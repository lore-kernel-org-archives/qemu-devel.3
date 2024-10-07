Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054E9CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmGU-0006vR-PI; Mon, 07 Oct 2024 07:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxmGO-0006my-U6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxmGN-000596-86
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728301853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTJbKpOPjVPX3a+d9rQHvAnWplw8tf04UC4z6wdI0GM=;
 b=R+5BJHCFKD3VbVV3MOflvaH+QqG9jNsYBkAC2TLFwpkTEJv9nUk9LwvsjiSSSfl6M4/2sf
 w75C59W3P1VuyiU/NTTmT0gWveMRlAKi6DLegLhgoeeEagcNTJmJAQDU4FL6fmEnVMUb93
 P5ljjxltppwMtvE6pdA+y0eylTmAsDg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-Sp3Od9CMOfOevX0zgAkM9w-1; Mon,
 07 Oct 2024 07:50:50 -0400
X-MC-Unique: Sp3Od9CMOfOevX0zgAkM9w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A81621944A8A; Mon,  7 Oct 2024 11:50:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC90D19560AE; Mon,  7 Oct 2024 11:50:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/12] hw/m68k: Use explicit big-endian LD/ST API
Date: Mon,  7 Oct 2024 13:50:21 +0200
Message-ID: <20241007115027.243425-7-thuth@redhat.com>
In-Reply-To: <20241007115027.243425-1-thuth@redhat.com>
References: <20241007115027.243425-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The M68K architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' hw/m68k/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241004163042.85922-18-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/bootinfo.h  | 28 ++++++++++++++--------------
 hw/m68k/mcf5208.c   |  2 +-
 hw/m68k/next-cube.c |  2 +-
 hw/m68k/q800.c      |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
index 70c1dc0e8c..0b3e7c4ea0 100644
--- a/hw/m68k/bootinfo.h
+++ b/hw/m68k/bootinfo.h
@@ -14,39 +14,39 @@
 
 #define BOOTINFO0(base, id) \
     do { \
-        stw_p(base, id); \
+        stw_be_p(base, id); \
         base += 2; \
-        stw_p(base, sizeof(struct bi_record)); \
+        stw_be_p(base, sizeof(struct bi_record)); \
         base += 2; \
     } while (0)
 
 #define BOOTINFO1(base, id, value) \
     do { \
-        stw_p(base, id); \
+        stw_be_p(base, id); \
         base += 2; \
-        stw_p(base, sizeof(struct bi_record) + 4); \
+        stw_be_p(base, sizeof(struct bi_record) + 4); \
         base += 2; \
-        stl_p(base, value); \
+        stl_be_p(base, value); \
         base += 4; \
     } while (0)
 
 #define BOOTINFO2(base, id, value1, value2) \
     do { \
-        stw_p(base, id); \
+        stw_be_p(base, id); \
         base += 2; \
-        stw_p(base, sizeof(struct bi_record) + 8); \
+        stw_be_p(base, sizeof(struct bi_record) + 8); \
         base += 2; \
-        stl_p(base, value1); \
+        stl_be_p(base, value1); \
         base += 4; \
-        stl_p(base, value2); \
+        stl_be_p(base, value2); \
         base += 4; \
     } while (0)
 
 #define BOOTINFOSTR(base, id, string) \
     do { \
-        stw_p(base, id); \
+        stw_be_p(base, id); \
         base += 2; \
-        stw_p(base, \
+        stw_be_p(base, \
                  (sizeof(struct bi_record) + strlen(string) + \
                   1 /* null termination */ + 3 /* padding */) & ~3); \
         base += 2; \
@@ -59,13 +59,13 @@
 
 #define BOOTINFODATA(base, id, data, len) \
     do { \
-        stw_p(base, id); \
+        stw_be_p(base, id); \
         base += 2; \
-        stw_p(base, \
+        stw_be_p(base, \
                  (sizeof(struct bi_record) + len + \
                   2 /* length field */ + 3 /* padding */) & ~3); \
         base += 2; \
-        stw_p(base, len); \
+        stw_be_p(base, len); \
         base += 2; \
         for (unsigned i_ = 0; i_ < len; ++i_) { \
             stb_p(base++, data[i_]); \
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index b6677ad6bc..e37cd50d18 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -359,7 +359,7 @@ static void mcf5208evb_init(MachineState *machine)
         /* Initial PC is always at offset 4 in firmware binaries */
         ptr = rom_ptr(0x4, 4);
         assert(ptr != NULL);
-        env->pc = ldl_p(ptr);
+        env->pc = ldl_be_p(ptr);
     }
 
     /* Load kernel.  */
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9b78767ea8..9832213e7e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1036,7 +1036,7 @@ static void next_cube_init(MachineState *machine)
         /* Initial PC is always at offset 4 in firmware binaries */
         ptr = rom_ptr(0x01000004, 4);
         g_assert(ptr != NULL);
-        env->pc = ldl_p(ptr);
+        env->pc = ldl_be_p(ptr);
         if (env->pc >= 0x01020000) {
             error_report("'%s' does not seem to be a valid firmware image.",
                          bios_name);
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index fa7683bf76..556604e1dc 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -684,9 +684,9 @@ static void q800_machine_init(MachineState *machine)
 
             ptr = rom_ptr(MACROM_ADDR, bios_size);
             assert(ptr != NULL);
-            stl_phys(cs->as, 0, ldl_p(ptr));    /* reset initial SP */
+            stl_phys(cs->as, 0, ldl_be_p(ptr));    /* reset initial SP */
             stl_phys(cs->as, 4,
-                     MACROM_ADDR + ldl_p(ptr + 4)); /* reset initial PC */
+                     MACROM_ADDR + ldl_be_p(ptr + 4)); /* reset initial PC */
         }
     }
 }
-- 
2.46.1


