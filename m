Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04260105A584
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drM-0003yo-Py; Thu, 12 Mar 2026 07:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dr0-0003lK-Rq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqu-0000Qq-WB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4XICs2ZC8HPTCpMLKqC712lAFqd8shEbTlhChEXD/Ok=;
 b=Bq/soXv9dipMqqYspbXyOpdyw5HBWM61pzrVMOt6FWxdwIkE59rHVgnf8qn0Rfmi8Zuzcu
 uB8T6eBbFZ0GpiltLeOZjzheE7DQAvMZl3o1KjaUAuwlPs9DOZ7wrzCgXDIj2LjBCdqaT6
 Udp3Mf5nrd02klbNKvvOi2uIiFeiGRo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-a3YP9u0TNtaZTU7JEsdK9Q-1; Thu, 12 Mar 2026 07:05:14 -0400
X-MC-Unique: a3YP9u0TNtaZTU7JEsdK9Q-1
X-Mimecast-MFC-AGG-ID: a3YP9u0TNtaZTU7JEsdK9Q_1773313513
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-485397788b3so7957165e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313513; x=1773918313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XICs2ZC8HPTCpMLKqC712lAFqd8shEbTlhChEXD/Ok=;
 b=Gtuywx8sbJVJIqvN/V8UKoW9cYwkUuWUN2a63j768NJTHphY2QtK4cMWWuOORzMKFM
 k311rGZ+YF6Cj3G3t8t+N8iDWMOYqxM8ghkpE6IdJS0/zmIyq5UxriDNLsYBDcSW++00
 iIkQwOWka0AtDpuUKLbPmnZ4Vcl1deCW0B3RqUDulpoMLiVT7v6DP5H0eFGB/vWZUH1g
 C2NZl8ioX9sOE0v2u+B4um9ad77nsHOW4NtmTfIM7lEgY5M0pyR6FeuDFM2lpQNC0s+0
 FQGVhgFYfG4LPSWn16EnG+ZBZ/hcqmdCWvo6VRGa9kBctF09bQGwAvKOdbZ6Oz+AJpQK
 886Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313513; x=1773918313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4XICs2ZC8HPTCpMLKqC712lAFqd8shEbTlhChEXD/Ok=;
 b=YYRREPxp6TqrF27wSqfbpgm1I1Zgtmgpvg6V0CJ4Vsyv18Y8gma6Bgj2+MtgntqsEm
 NihQFQdMszl5WL9vt+U+B982W3Gvwx7T0ClgbjlZVVNXMFrZnad0+YaBKt17XnTCCxP7
 6zRUBLHC71eFgT0t7JObvWNISUAG0DKlClKm+5wcEN9xVlsWRryqZyhyJY71pURxnuVu
 KBV34MeWWe6INQgTjfEbgKPU7OzXaEZWZUW6ikjFWnkGYhbTsEEuEz9nqJjA9Xdz42lu
 7Va88WowmykQe/aoyhk9PDmJFbe3WstE9yZDR9BTjZiBg+1FimbKHzRQtxcKGsh2CXPh
 g+7A==
X-Gm-Message-State: AOJu0YxIDvdy9V14yayx3uMr9Sv2F296OvEEqR46gGaP/QN6D7CEK5bR
 nZmRZVwTNebQKx/QPwR9IAndCM4Yj/+EmaFqP2vpWVOcyzO3qmFdxIS6fvxZjR6OXC9377nydV9
 oE9JG54wPROKzabLgAFcFcR+Ird1vJVUDXUp4iyvooT5bSFgxetemNQ+kU3r7u3mH/8MtGQ1URV
 NAuA57kb4zTluYb3WaaYJA5/O3DyCbjSjTHWfi7tUM
X-Gm-Gg: ATEYQzxcp6intEeApl8jNwHLXuGUCaHZWJIwJ7UAdoVM70B9WCCkUoJr3rceCwPdkiv
 AMlwv3qckQY6qJzxGP7w9DNg+3e8TPNx+46EWkt+ltasPrwYb/8WuwzzGQ2cJcisirXoqccPlLa
 WwzGVGs0q52kjPy+37rnUBWLXIDEe8wFZ7CQY9prB3L8doy//sav0iYxoSJBKTALIMQGJGW4ZWC
 9/d5LT8BTQmfoT2b4eDuDVgzspZEaB2RXpi0EPVpoULTPFfvLxIQPzKJpdvXqAh8YuT/1RSIxyz
 CdLMB7HX1WyBtvyEhYMbVpLt0se+eAWHqe0ys3Jz3uQ0CnEkGGL4HMRzek0l5zfhUiCQC7QdX0u
 AL/bfbvw3BcCGzWR2DABLsLrtgmuqrbtAPrUcdlTa2EHk7Ga2A3JOmBQqp6XV9iv7hoy21Nc3kc
 1IhmCO4GXM6XLsn5StfNA8Ay7spm0=
X-Received: by 2002:a05:600c:8b0a:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-4854b129f91mr95670315e9.29.1773313512539; 
 Thu, 12 Mar 2026 04:05:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0a:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-4854b129f91mr95669665e9.29.1773313511966; 
 Thu, 12 Mar 2026 04:05:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fe27sm130151345e9.9.2026.03.12.04.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/14] coverity: fix coverity issues related to confidential
 guest reset
Date: Thu, 12 Mar 2026 12:04:39 +0100
Message-ID: <20260312110451.685161-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ani Sinha <anisinha@redhat.com>

Fix issues reported by Peter.

Fixes: ec9bafd2ea9d12c ("i386/sev: add support for confidential guest reset")
Fixes: e76c30bb13ecb9d ("hw/machine: introduce machine specific option 'x-change-vmfd-on-reset'")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260311074048.61367-1-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/runstate.c | 10 +++++-----
 target/i386/sev.c |  4 ----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index eca722b43c6..77cb14ae028 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -508,13 +508,13 @@ static int qemu_debug_requested(void)
  */
 void qemu_system_reset(ShutdownCause reason)
 {
-    MachineClass *mc;
-    ResetType type;
+    MachineClass *mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
     AccelClass *ac = ACCEL_GET_CLASS(current_accel());
+    bool force_vmfd_change =
+        current_machine ? current_machine->new_accel_vmfd_on_reset : false;
     bool guest_state_rebuilt = false;
     int ret;
-
-    mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
+    ResetType type;
 
     cpu_synchronize_all_states();
 
@@ -528,7 +528,7 @@ void qemu_system_reset(ShutdownCause reason)
 
     if ((reason == SHUTDOWN_CAUSE_GUEST_RESET ||
          reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
-        (current_machine->new_accel_vmfd_on_reset || !cpus_are_resettable())) {
+        (force_vmfd_change || !cpus_are_resettable())) {
         if (ac->rebuild_guest) {
             ret = ac->rebuild_guest(current_machine);
             if (ret < 0) {
diff --git a/target/i386/sev.c b/target/i386/sev.c
index cddffe0da8d..9dde972c118 100644
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
2.53.0


