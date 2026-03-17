Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB50FF6E9B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dlM-0003xH-LF; Tue, 17 Mar 2026 19:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlL-0003wq-El
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlK-0006SO-4m
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773789825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p13D+9yMmIAV5Felq6/xUYZn5oEef6jEs3SIEfUrsbI=;
 b=VSvL01az+d0dCCv4t/1ND1BbIPR0tO0K5SsHT7KUmdv4++1XjgcwOfAjSiR5MrZADf3+B9
 ELc/D97M3mh2kKsqW/jlNOggm/KE7SpBm6SwfFn8NNj4fAh05XutEJWKCm1I88jLUz4zGz
 cq98IG9Pa2e3hy/BLGd0i/as00FSMTI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-_Rg5CuiIOXW8c_7fdwGRSQ-1; Tue, 17 Mar 2026 19:23:44 -0400
X-MC-Unique: _Rg5CuiIOXW8c_7fdwGRSQ-1
X-Mimecast-MFC-AGG-ID: _Rg5CuiIOXW8c_7fdwGRSQ_1773789823
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5091327215dso116081761cf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773789823; x=1774394623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p13D+9yMmIAV5Felq6/xUYZn5oEef6jEs3SIEfUrsbI=;
 b=eLyYHiFe3xu19ZJgknaN0MAjwrC6DJXRmbbc8vj4XDk5txZBoq2U4iDzFGblvsuAOu
 ZwGcdnmkuzAqEUqXlKoOMnxth6VpZ0hD/R+4lt2bkkXj6Tszcp7umtKh5QJ/4iQQIcQB
 F/n9XCBgHuyGw9CUQ6qG5prqplOu4acOB+ex9Dx6jdPU6d0q0lUmmPpOLKkFK+bXxIOf
 EL2SO6hBfuCO+2eWRbN2gOtJBDuuyfdgtfw2NpsRJjSYJ/biemQjzKkzbraT1allojb/
 +ne+11NmVtT7O8DHhP83kbXXUlihgniVOPOVlL+fESAGiBRFoOlH//430KPKz7GXD4N4
 /drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789823; x=1774394623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p13D+9yMmIAV5Felq6/xUYZn5oEef6jEs3SIEfUrsbI=;
 b=jCD236+gev7F0uIWyXb02X6HWUFG0xRTjQw4ZgC9ufQttmxYMDvDYvyjZQO51NRANj
 StHfejNx14MYHhDuHQ4smzpoWkqd/fe5dSI3ijoVu0xVRcfSWw8Gvh7uFIHNW8E4+959
 FmN38uU9KoTB6wwnEo3+oL7b1CxBBctOa4orGzxLVkqsj6JFB/zWIvtIZG8Mo+2TT8Cc
 qBb4NYp8zunYDM9qYv6LtKUDH+5zr6WT+quQ7IRzCQCIOEAWXV1F3oxVJkpiyn4PqNRv
 dd+xoRWNRZaEi+ahawBloAQkaHz6i3Bgh9BwRoMZKUEnHmkrcK8AvhM7plZchjUBAH0q
 CHJw==
X-Gm-Message-State: AOJu0YzoRtWYyYn7UlJkp0y3BZdbZOaGNEeMeHS9KnfJwSZTTHQZfPmY
 kJZ8O5Bn7zBiSFX3mRlu8ZUhS4GhY9h0QcVyOi5Z6CIVFpJXabmqfgUXc74guIGOhhYN1r+oFQk
 WLjfWnqNZ2gabbZli1RiGlAFPLbbxXujvqeVyQmHbuc+pWvOsFhO0ps9F1soRhxR26SW/hjaDSG
 1+5+wX9d25kQNpRcPC3KCzAIdd11cg3KT+wIKe5Q==
X-Gm-Gg: ATEYQzxXmMatdY1dQL6sr3uWHH85KzwNuQDt0JnJF0PZXSNhuIA4sIbm5SqWNJn5dsp
 YeZ3LZDbvZmtkKuQrFbG0nJHO0OiOzwWzC7YKpb3zghdPy20d5Tf1WPaaJG42edSwtpsjFpD2/M
 2ny0n//vP4cjug5ePaRsq2P3v+tKMYGH9zlh7fZg987JpvqsaZvZIDHR99Zf+A5pRbYNUjl3j63
 jiMhC0R4SgzIHK2dunBzPVs1AZHdQkLig0vXWaCIcuj/JtuhWFPfoQ/I6RD40FGcYzuyo5FQF4A
 u5ocOj14Plv22AI2zNty6ilasRKyICRKMGyAqmppw3WXPW4im64Sd6ezV1Hq0uC+n9V8PcRjv3G
 pUdThh9CT87jAIQ==
X-Received: by 2002:ac8:58c1:0:b0:4ee:1e82:e3f4 with SMTP id
 d75a77b69052e-50b148b9963mr16083421cf.64.1773789823253; 
 Tue, 17 Mar 2026 16:23:43 -0700 (PDT)
X-Received: by 2002:ac8:58c1:0:b0:4ee:1e82:e3f4 with SMTP id
 d75a77b69052e-50b148b9963mr16083121cf.64.1773789822717; 
 Tue, 17 Mar 2026 16:23:42 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ea39asm8203806d6.37.2026.03.17.16.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:23:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH RFC 05/10] vmstate: Rename VMS_NULLPTR_MARKER to
 VMS_MARKER_PTR_NULL
Date: Tue, 17 Mar 2026 19:23:27 -0400
Message-ID: <20260317232332.15209-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317232332.15209-1-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Prepare for a new MARKER for non-NULL pointer.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h | 2 +-
 migration/vmstate-types.c   | 4 ++--
 tests/unit/test-vmstate.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index b4bc69486d..092e8f7e9a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -283,7 +283,7 @@ extern const VMStateInfo vmstate_info_uint64;
 extern const VMStateInfo vmstate_info_fd;
 
 /** Put this in the stream when migrating a null pointer.*/
-#define VMS_NULLPTR_MARKER (0x30U) /* '0' */
+#define VMS_MARKER_PTR_NULL          (0x30U)   /* '0' */
 extern const VMStateInfo vmstate_info_nullptr;
 
 extern const VMStateInfo vmstate_info_cpudouble;
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 23f3433696..7622cf8f01 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -363,7 +363,7 @@ static bool load_nullptr(QEMUFile *f, void *pv, size_t size,
                          const VMStateField *field, Error **errp)
 
 {
-    if (qemu_get_byte(f) == VMS_NULLPTR_MARKER) {
+    if (qemu_get_byte(f) == VMS_MARKER_PTR_NULL) {
         return true;
     }
 
@@ -377,7 +377,7 @@ static bool save_nullptr(QEMUFile *f, void *pv, size_t size,
 
 {
     if (pv == NULL) {
-        qemu_put_byte(f, VMS_NULLPTR_MARKER);
+        qemu_put_byte(f, VMS_MARKER_PTR_NULL);
         return true;
     }
 
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 6a42cc1a4e..dae15786aa 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -620,7 +620,7 @@ static void test_arr_ptr_str_no0_load(void)
 
 static uint8_t wire_arr_ptr_0[] = {
     0x00, 0x00, 0x00, 0x00,
-    VMS_NULLPTR_MARKER,
+    VMS_MARKER_PTR_NULL,
     0x00, 0x00, 0x00, 0x02,
     0x00, 0x00, 0x00, 0x03,
     QEMU_VM_EOF
-- 
2.50.1


