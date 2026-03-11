Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F3DFD064D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0E77-0003Vm-Op; Wed, 11 Mar 2026 03:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w0E73-0003Sh-Jj
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 03:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w0E70-0001R2-1N
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 03:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773214567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AX49WeAmf7sq/9xxCXBG9J/FNXmONVenazDU4bxmpcQ=;
 b=EkamIbdg50qHmy0fM5otivsVy+SEXMoGKFf4xA+ALUmYGcSkh5AOjAGlzE7BBHX2IFmTWE
 1GNugzuSgyFjyhOTVnDzdigln3VnUlaMb8YpPDvtJHZWReMVZbsvD7ikLpkukywepzHrjf
 s8hCoBJ9GKCxdIbOVgyZyNHw9rrfzRo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-2lJNRtadNSu3SGmOyphDwQ-1; Wed, 11 Mar 2026 03:36:06 -0400
X-MC-Unique: 2lJNRtadNSu3SGmOyphDwQ-1
X-Mimecast-MFC-AGG-ID: 2lJNRtadNSu3SGmOyphDwQ_1773214565
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aad5fec175so511339455ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773214565; x=1773819365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AX49WeAmf7sq/9xxCXBG9J/FNXmONVenazDU4bxmpcQ=;
 b=e7katUP2dKx1NpKdafVJdUVpQR8iXoi1BRJz2U9i9hHRP+7H3zdGL0ZJUzRyMid3OT
 qwkSXVSXO5rabK7mhjvTicEYLtGa8EC+MB4ed7lcv5gh/jVyHdn6b7Dc0m6BQ0pp5FFn
 BjbW03Ime8G35UYRNEx8LUxKZkFlAFIkZzyLXV9szyt0bIq61HTeSFCJrVnGuwgHFpOj
 b5RjoDRDWib5QlPQ//Z849FXVO9VitmqBfZ6DVMiZrfaOyN9SG1rOHQElHOfb4L5IS73
 3TmVLiZycA0vqCLlCIThZjLB+15RKpwlg1p0v096UzdUXXzfqTOA9RbhGd2CS8GlJCUh
 Tngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773214565; x=1773819365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AX49WeAmf7sq/9xxCXBG9J/FNXmONVenazDU4bxmpcQ=;
 b=wsKCSao7OLRFbwpFQAZg5wMjTVlBKHlViQsbt1QXWwajDBezmXJI+2IUAEke6yj2BK
 zL/yNK810dfIxcrqEFOq3rJnw27Ktp3zJNxwOMFFOBLSgLUvCGfaE6L+kt6xTCzRTdp4
 VI9KRzz0LWP+zLSnHjm2n9PAi2R+KKxVK+G8S3nt3zamemSQZ0RWcCV5SGiXntzhwEcL
 BxCScciWnEN9Pu8W7Kqmccserb5DAc5OAyUvLDq4V90pCEtjacjMF7EVswJRv5WmCU73
 wg/BvIHWxMzokDszSk2psfvb4vsDPRQFkMFD6FtyI0S639vV0QRGfwE2zqKl8M6IoolO
 zr8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX5mPhhAQrX/0AbV5HpOx4wNLsPdeQ2sKZUErVKyJEE7oYt5IxDYf4kiT7JeI598NlPVjxnwgJwHVr@nongnu.org
X-Gm-Message-State: AOJu0YwCTcKkrvpCftfr0+PV4x5j8Pb/51h5sHgm31HbBA80jlSJYa8o
 uTdeJ9XKemmqy3Wui4ZtVDN4ykg/bomIIt8naYMMhH+I8QqrFVrIPQQiN6umG8ImX9xgTH2OnG5
 fOi4fNVoVNxX/V5gMOK2cK2CyPZKQhtcFXJ6pDBWtKp1z0nUydUk06C8x
X-Gm-Gg: ATEYQzzL1pZZEARa4QXtB9PfSdQfkF7lY8Uy8TUu73LNQPgjjJDpFlVSQQ/Bb/b/H3W
 s1RIVHWUM375XWw61PQ0N6XL6fmCXKKZxDbau57QJuVr2LEaAY5RCQxPEDvmI9C/R6arI7NtSPl
 FUatG+4rWHEcFJULMO9OxIkgxTf29IRYIX34M8vVyszgKr0RZ+s0a7VFt8XzqNxgCbgv+x8x4M+
 uL8sU0Zb4MKpvDmJjK5f1aKVOC9yuDf1zFB0NSeqS/eNNo98YPPthCyuK//wARSDSw++UduUlzc
 8ZOwffNK8NKqI1WLMn6qdibNOijERXE45ePePjU5vMd2sZl/G/wnLrNreIoRf8xqjqohUb0wyn8
 BYyzeORPFw+hxH/UF4kUeBspWs9oBraCOwpf28lFWbRBj5XES+YLklCY=
X-Received: by 2002:a17:903:230f:b0:2ae:517a:6c28 with SMTP id
 d9443c01a7336-2aeae849bb1mr16967565ad.29.1773214565162; 
 Wed, 11 Mar 2026 00:36:05 -0700 (PDT)
X-Received: by 2002:a17:903:230f:b0:2ae:517a:6c28 with SMTP id
 d9443c01a7336-2aeae849bb1mr16967405ad.29.1773214564805; 
 Wed, 11 Mar 2026 00:36:04 -0700 (PDT)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2aeae34d7d2sm14097815ad.51.2026.03.11.00.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 00:36:04 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v2] coverity: fix coverity issues related to confidential
 guest reset
Date: Wed, 11 Mar 2026 13:05:50 +0530
Message-ID: <20260311073551.61147-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fix issues reported by Peter.

Fixes: ec9bafd2ea9d12c ("i386/sev: add support for confidential guest reset")
Fixes: e76c30bb13ecb9d ("hw/machine: introduce machine specific option 'x-change-vmfd-on-reset'")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/runstate.c | 5 ++++-
 target/i386/sev.c | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index eca722b43c..ca6730d111 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -512,9 +512,12 @@ void qemu_system_reset(ShutdownCause reason)
     ResetType type;
     AccelClass *ac = ACCEL_GET_CLASS(current_accel());
     bool guest_state_rebuilt = false;
+    bool force_vmfd_change = false;
     int ret;
 
     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
+    force_vmfd_change = current_machine ?
+        current_machine->new_accel_vmfd_on_reset : false;
 
     cpu_synchronize_all_states();
 
@@ -528,7 +531,7 @@ void qemu_system_reset(ShutdownCause reason)
 
     if ((reason == SHUTDOWN_CAUSE_GUEST_RESET ||
          reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
-        (current_machine->new_accel_vmfd_on_reset || !cpus_are_resettable())) {
+        (force_vmfd_change || !cpus_are_resettable())) {
         if (ac->rebuild_guest) {
             ret = ac->rebuild_guest(current_machine);
             if (ret < 0) {
diff --git a/target/i386/sev.c b/target/i386/sev.c
index cddffe0da8..9dde972c11 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2011,10 +2011,6 @@ static void sev_handle_reset(Object *obj, ResetType type)
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
 
-    if (!sev_common) {
-        return;
-    }
-
     if (!runstate_is_running()) {
         return;
     }
-- 
2.42.0


