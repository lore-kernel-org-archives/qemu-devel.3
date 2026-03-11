Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9FDFD88EB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AYL-00015I-Lq; Tue, 10 Mar 2026 23:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w0AYJ-000159-Qs
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w0AYG-0004kv-VV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773200883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aF2u6GllzhNzrdWPAaFPtE+a3uz91CYpR9l7tdV1HgE=;
 b=UzrkjdBEl7dtx85G4lNnKxGpRG81HhCgYNw07sVcgQFklQ1N9C84448DtLqMdyalQyHCm/
 wt8eV02neM2kKz0ZcXIBU5iNoHLIICmf9aNzClZRx6vyApPi8iM6PdFQV/gcI2T86a99jd
 fsaPjhqREjymkvgwqke1vgtg8jy+9PI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-ydUx-o2SO5GiR_gFfnrN-w-1; Tue, 10 Mar 2026 23:47:59 -0400
X-MC-Unique: ydUx-o2SO5GiR_gFfnrN-w-1
X-Mimecast-MFC-AGG-ID: ydUx-o2SO5GiR_gFfnrN-w_1773200878
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35979a03106so10931376a91.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773200878; x=1773805678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aF2u6GllzhNzrdWPAaFPtE+a3uz91CYpR9l7tdV1HgE=;
 b=oFxUZgYI3Gptmz1jcTwd5iXFsnA+vxBuZb0GoKFxO0CNK1ewAvoMuuM7ysBM2YBide
 fWeFNd0u4NooAlHLKFFPB81Kg/VBIbSY/xiUwTwDAcR7DqmT/3gW5iC2GK3chgX6m+ck
 CEGNTyBOmpiFlahXK+ul1hJGuEh33QmV2EcCBnbX0blVJi2sDjuz0f77zr/y7PELzcCL
 rUQO7i5WMSXIxhEg4VJ/WxzkQ4DNQPZxWjY53eY9LUMY0c9gGpMxyvO+JK6lWLcJxT8U
 yuxOq7dq8PgDesiABuPLcdO4I+0lc008V0J5BzdeeFRPjZSpeSgcGeM9JwrzPzVYlebO
 zTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200878; x=1773805678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aF2u6GllzhNzrdWPAaFPtE+a3uz91CYpR9l7tdV1HgE=;
 b=bJ6I7lvLMkHtvEO9PRRdSytwyzqbx22YGt9I13voeLrLezqCpdRecc80F7WCTQz2R2
 xwVGR8S8tn80jN9/dYp2N+dCSi2rO0vi23xj4nXHE3litfdEbn/p1hfczMX2d9tnoMRa
 HClKNxSmEwsPgYt0Agu97ouOlJ3mdQ5z8XMDAbNYUGTL3ROFFeJKs1i+c+wBhN6A2Hhq
 MAizFMwgW9t+d8uuDprpsz8/2v3ejZhgdOQTBjZ80SKhTcvJNb2DCa7Kyvix1sIcK16b
 /i1Q48I2tklkUZKjreAsC1aH+LQT+ZdDnoXgp7YHg34ocMth2Sx7zY5psPJ7ziYFVTTq
 TLHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRtUlLbu9SxWiHZ5M2mTlI++kLeeYQxULHuTKpmkw35AMf77y0YhOvDHLiszP4Tmyww7deIKhgkWFH@nongnu.org
X-Gm-Message-State: AOJu0Ywh3lqOrvUJaerf7kSGMPEE0MsCMdzo/BpeRcHFwUS4hsdCRtYt
 L906dxrRA+j4v6o0kywtYRlUBxfOAKoyjjyPjWHqTo9yZjdV5Zv9NuO7wKTVCDC5/iZosjtFqww
 rhSH417xRFMJiag1+rvpV59TcSW+sQB0NWWU2AC+goifZWtfJPdE1hbG3
X-Gm-Gg: ATEYQzxrRaW0ZwdZ2uLtY7UBCGkKh1NINomnHAJJZ6xJAagjMtavB6O3n9UufJOuMWA
 LRGAgUhS/xUE5tizC4o8+XTBqZsqYeP6yjeAa0U0tFZMDuNoneC5lsBXPTRqX8lu3nXdsxVbHPD
 MNJxb6mz2e6ZT6nZ9rH0NmuthGZmq9946b6n5h8lAOs50HRylU/UahBepD0tKJQrtX5z5DyB8Jq
 K8pvUCTV7rXWoU7LrbHAzGB0DkN3UDvBEXrPliV591PTYbRG8B3acZ9xs7v23BHKLg7IL9pF1tA
 nn6Z6nC1XQAT/M1jQxBw6Pce+AYthjExNZ0ROkZyHfGeu9QSf1SiX00W2F/Hb/sfROUI1FZCta+
 9kaTMPrJ6g+i8rP7RcNxnQ7F2PFSewPG1WZvQsTQ/XROlGJlOBUM2gew=
X-Received: by 2002:a17:90b:5486:b0:34c:fe57:278c with SMTP id
 98e67ed59e1d1-35a01381399mr1169953a91.34.1773200878516; 
 Tue, 10 Mar 2026 20:47:58 -0700 (PDT)
X-Received: by 2002:a17:90b:5486:b0:34c:fe57:278c with SMTP id
 98e67ed59e1d1-35a01381399mr1169921a91.34.1773200878056; 
 Tue, 10 Mar 2026 20:47:58 -0700 (PDT)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c73cdfa9acbsm603530a12.32.2026.03.10.20.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:47:57 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH] coverity: fix coverity issues related to confidential guest
 reset
Date: Wed, 11 Mar 2026 09:16:53 +0530
Message-ID: <20260311034653.59826-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

Fix issues reported by Peter.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
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


