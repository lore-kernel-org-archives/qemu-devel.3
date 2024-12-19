Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0893E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFS-0001n7-Qt; Thu, 19 Dec 2024 11:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHiu-0003BJ-4C
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHin-0002PT-Lu
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734619308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=df6CjF6Td41AMvjiwZAUJBUmD4molRWafGhHQVx7OQA=;
 b=RlNcwyq47BQ+9Ihi9N/uQp+doB1kHlMh4fhGx3SQzeyBO+3NJihbcqKzJ8e+stHGaXBsaw
 1lshir+xHgATB7sJVqwUaalquuW+SBlGB0E+4SkwCQcscIYtnA/lpPswzo2kQ922LBNqeJ
 lwwldLvvWx+an0F0JMKnsQkIUcPZHUw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-4GR8vVUPOmecpHdCBGcwCg-1; Thu, 19 Dec 2024 09:41:46 -0500
X-MC-Unique: 4GR8vVUPOmecpHdCBGcwCg-1
X-Mimecast-MFC-AGG-ID: 4GR8vVUPOmecpHdCBGcwCg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d51ba2f5so437652f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734619305; x=1735224105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=df6CjF6Td41AMvjiwZAUJBUmD4molRWafGhHQVx7OQA=;
 b=an8Cl+JrH+MP1VX7oj40oNaQFFTnfZVz26WNqTB2KIfnXtOSawfbsrKUrzByvbhKA1
 qIpCuQUzqq1FifRwbbzRHQMVm/YRGdCCpyiq45qXbG+eDnkwbEGxIZJJseyZsHC5N3A/
 d3wg0McWW1bAczsVwUts3Kz/LKzBK5DX3vPPpij2cXUJFxgKpVbuM1R9nJDFhAK0qlYK
 Lfq3HfE4fbSM0sL3rZGCFKmmf/6mj8+Wj2iYnAuTRndSJ/q6jk4/cDu4u1oym0IzwVsO
 +t0hM02iCbNlNRwb9ta1SN3+QqeTieGmgKlr5MJykVw9CFwuV8zc3NFgwd//8Z6nNaVK
 Ewlg==
X-Gm-Message-State: AOJu0YxDphl1PHvlNr0PW0lxhM90EmHM3jf4xTHae4jywJ9QjMZz99zc
 QSmDjh+1Yme+jrWoyVfKRCnKFHR3joVp78AsF/bLhdttud+rSK28xRJSHHVaz4/FBNzWC18Cjqu
 0ZPblIeWo1gu7nKupiwfNfcc9J52MeawkUYvWI0G3Jstsimv8LTx3zFsKXLF3U6+73r43wVYLVu
 YoVANpaAp+RkDj5h8ll+t/yyiTE35/Jcfo/Rc=
X-Gm-Gg: ASbGncteULAwg6FnSLvYgjASzVNjvbA46YoLLfi8YQ/f+sTZQ9yoEj/jGHULX+YFDB/
 A7uFRbPy3u1tPX2Ne63xHneZGkzz2dG0qKbcjjtVEdm285PzWnH1+GINezzGJSWeZDEkl2NMruV
 9X7qcGkiUKXl3B5lPjFo1aOQ+HF5b2xS5zYBhiCFeYrQm+WNk1poO6sg8Zib9OaTTbwAWlHDgz4
 GOIOqQrgBH4aFXoWcZigB2YrCBxxVeM0pYx4ZduoJ4kQYFMFjx2XBz6OkRGp0LTA5lSXIb2e25w
 wOvTe9Te0iTOWmKJ1zwKKByw/iz1qoTsKs7AmIYW
X-Received: by 2002:a05:6000:156b:b0:385:f892:c8fe with SMTP id
 ffacd0b85a97d-388e4d43a62mr7283606f8f.21.1734619305567; 
 Thu, 19 Dec 2024 06:41:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnbgS8QXfgDi/2wFabwK+V4asQjZyvjUrkQalZxbn1dBHR2sy2bkd9kITBj9Xd7DU3nCABYw==
X-Received: by 2002:a05:6000:156b:b0:385:f892:c8fe with SMTP id
 ffacd0b85a97d-388e4d43a62mr7283563f8f.21.1734619305129; 
 Thu, 19 Dec 2024 06:41:45 -0800 (PST)
Received: from localhost
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38a1c8acc02sm1681600f8f.104.2024.12.19.06.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:41:44 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/14] s390x: remember the maximum page size
Date: Thu, 19 Dec 2024 15:41:13 +0100
Message-ID: <20241219144115.2820241-13-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219144115.2820241-1-david@redhat.com>
References: <20241219144115.2820241-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Let's remember the value (successfully) set via s390_set_max_pagesize().
This will be helpful to reject hotplugged memory devices that would exceed
this initially set page size.

Handle it just like how we handle s390_get_memory_limit(), storing it in
the machine, and moving the handling to machine code.

Message-ID: <20241008105455.2302628-13-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         | 12 +++++++++++-
 include/hw/s390x/s390-virtio-ccw.h |  1 +
 target/s390x/cpu-sysemu.c          |  7 -------
 target/s390x/cpu.h                 |  1 -
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2ba66be018..9f8d830798 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -143,6 +143,16 @@ static void s390_set_memory_limit(S390CcwMachineState *s390ms,
     s390ms->memory_limit = new_limit;
 }
 
+static void s390_set_max_pagesize(S390CcwMachineState *s390ms,
+                                  uint64_t pagesize)
+{
+    assert(!s390ms->max_pagesize && pagesize);
+    if (kvm_enabled()) {
+        kvm_s390_set_max_pagesize(pagesize, &error_fatal);
+    }
+    s390ms->max_pagesize = pagesize;
+}
+
 static void s390_memory_init(MachineState *machine)
 {
     S390CcwMachineState *s390ms = S390_CCW_MACHINE(machine);
@@ -191,7 +201,7 @@ static void s390_memory_init(MachineState *machine)
      * Configure the maximum page size. As no memory devices were created
      * yet, this is the page size of initial memory only.
      */
-    s390_set_max_pagesize(qemu_maxrampagesize(), &error_fatal);
+    s390_set_max_pagesize(s390ms, qemu_maxrampagesize());
     /* Initialize storage key device */
     s390_skeys_init();
     /* Initialize storage attributes device */
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index de04336c5a..599740a998 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -30,6 +30,7 @@ struct S390CcwMachineState {
     bool pv;
     uint8_t loadparm[8];
     uint64_t memory_limit;
+    uint64_t max_pagesize;
 
     SCLPDevice *sclp;
 };
diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 3118a25fee..706a5c53e2 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-sysemu.c
@@ -255,13 +255,6 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return s390_count_running_cpus();
 }
 
-void s390_set_max_pagesize(uint64_t pagesize, Error **errp)
-{
-    if (kvm_enabled()) {
-        kvm_s390_set_max_pagesize(pagesize, errp);
-    }
-}
-
 void s390_cmma_reset(void)
 {
     if (kvm_enabled()) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b4506539f0..5b7992deda 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -881,7 +881,6 @@ static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
 
 /* cpu.c */
 void s390_crypto_reset(void);
-void s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void s390_cmma_reset(void);
 void s390_enable_css_support(S390CPU *cpu);
 void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg);
-- 
2.47.1


