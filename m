Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006C110FCAC9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82BS-0004M9-WF; Wed, 01 Apr 2026 16:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BP-0004Je-Hn
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BO-00038s-3y
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cqb2TTAmwxd+RL4JJIo+I7R0mtstkhAmAVuvztaMFd0=;
 b=CUXxlMo3FldXypWKTn+6dF8lfTzlzKHAbAq0grzJu0ALELNg9FBeh+hst94BlXxLq8SUCB
 K0QRVuYppJxtCjoU2Euv7Ic3nRKCnJZC1dnZnYjVflnhfuMKU8DgAqV3UbPxBEWaQ5zqU2
 YR8+8Ldeyc1aEbpOi7jgJUFwgndfUr8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-ix3nJF6WMPmRrwySbQqqCA-1; Wed, 01 Apr 2026 16:28:55 -0400
X-MC-Unique: ix3nJF6WMPmRrwySbQqqCA-1
X-Mimecast-MFC-AGG-ID: ix3nJF6WMPmRrwySbQqqCA_1775075335
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cfbfac0e05so34139685a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075334; x=1775680134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqb2TTAmwxd+RL4JJIo+I7R0mtstkhAmAVuvztaMFd0=;
 b=Mcvy7cnQ3zyd1MJfEnoRCY34XCZVZLY9j/8K8xTqxMQiO5QfLVXPEd0qMCZuD7TMwk
 3DPFsOBp6cfhZhhY/XmWVI2zMhU277EYU0sB9/IDwcg3J3jwD9J1Akw9mXUMFcKL1Dvz
 eV21shIOwrnDcGjaA48Rx0szNVy8dxG6fLEKgPd6aqnlftCBJ2rI/xgYUGGh6NF2Qtyi
 AlCnLhMLuxn1os/pEPClbyI9AX5IX3gY7V1puIsALcHhRCDimB2nprYjVZre6eM9E0Ck
 8xSlo+3uDCpGhh/oUMM6md+67c95oef+OXcGSgvNRitqxLdAeYQ6gSpIQzBVnH2GKGv4
 j5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075334; x=1775680134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cqb2TTAmwxd+RL4JJIo+I7R0mtstkhAmAVuvztaMFd0=;
 b=EUYKvos3D+CrHsdicTiJB3zt2+O9Lws30vwsQnbTFt0TSF1biqOFkmitrSSc651P71
 VowJgYF9qsoqKevCiEUyboym6i9lc6uI/4X29LwROINR/fqvk84Y2RVlW9/aXPXzzNTk
 Kyr+wKpTMoT82ptZ2vsORhPNBFwaAiGBx3dv9HD2c6terbfV4c79ygT66KXgaPUuGRtv
 IqVOtr0rFpJQPlVOIEvgeQfPBsAGyZFbjxIhOh5p+NgVsrGbWk+qXtz4IGIY5WrK0OKF
 HqpEvxzlAWlAav7JF9woO+QHf/eI7E6qeqRT+DRjZMkCLoNANw3UoxKVXdWcQO662ed0
 ZyTg==
X-Gm-Message-State: AOJu0YxzRsF6ABtlfxufgxLtx+w54Oxwv4Wi2bD3s4ujcgAseprO+Qyk
 4AHNJAW0VzYGB2weOouFxbjiCWSfGVUZViiOTmOQfXR0vNsvxRc2Q+xDwrgSXvtF6jRQnMcKBma
 bVMf/wD16AMM3wa/9h+OLH6oozSvBuFuAGec/nYUcCWeOvy15R2Rng7+pQ6Ua6uqHaOaUHtJaaU
 LRl2rc9AE/1RqYAz8NVI8El+Am9okbhyAU0A1SNA==
X-Gm-Gg: ATEYQzxfcvSQix+11BAFf9FqaW2OUxCUp0HxoPtwF7CQuRXQOlqlROMd8svckeKHFqP
 uwqsymXC5JrsWcXYHcudcHXyXceFu0w1N3TzKx7deZk077pYKIwWLQfNq/V0V00QT+6iTBLPuEl
 9SJcgb3M2Bhlo7DM3mTI/PBMHiEkrazvUt57/0vgACnxrLeeBae5QX+Sl4SIQy8153L6fo8ljQK
 MIGI5m4SawqhIpSJpLK5+N+MjHHqHU6wjWUeHZpjVrOFiAr398dssS0GWkfi4TnXOOs4ADJCuK9
 VdQAg0NYJFVFUmssD+syo6fwf3g3St6KYuR6bCIxzAfSIXdCp4P+2YApJS4l2sYafvRkKJjS/Oy
 Kv2GH5go5EM7lzeQoiWOU1PQpqyZc97soUou7RS5cIWA=
X-Received: by 2002:a05:620a:d83:b0:8cf:d0bd:bc8c with SMTP id
 af79cd13be357-8d1aa3bf9admr1212628785a.12.1775075334356; 
 Wed, 01 Apr 2026 13:28:54 -0700 (PDT)
X-Received: by 2002:a05:620a:d83:b0:8cf:d0bd:bc8c with SMTP id
 af79cd13be357-8d1aa3bf9admr1212625185a.12.1775075333687; 
 Wed, 01 Apr 2026 13:28:53 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a548a4efsm68194085a.8.2026.04.01.13.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:28:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/11] vmstate: Rename VMS_NULLPTR_MARKER to
 VMS_MARKER_PTR_NULL
Date: Wed,  1 Apr 2026 16:28:38 -0400
Message-ID: <20260401202844.673494-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401202844.673494-1-peterx@redhat.com>
References: <20260401202844.673494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h | 2 +-
 migration/vmstate-types.c   | 4 ++--
 tests/unit/test-vmstate.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 350e62a55a..7396e38531 100644
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


