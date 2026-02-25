Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E34FD3776
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIkY-00048Q-Vr; Wed, 25 Feb 2026 12:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvIkS-00047g-3y
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:32:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvIkQ-0001hu-4f
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772040748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DYlmXQRxHfwwiEGA+D5oGQIP3S8DkUnP19Idv9bO1fI=;
 b=KbfmFw9pajiPiLosJCKvwWP7QhZ0gVafTFdsw+c0l/gL/+gUeJuLsBOHLGqJUMtvw6BXes
 +X75OHgBf2WPMoVLloKqax66mWnA5d/feifeffgVacH80YMHhLPmRUmsYF9Cdj10hLBm1U
 9kykAVMKRvrnqxcCU9gXYWggAb/wQ3I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-F3B5trF9PmaAc2yNfL1xeQ-1; Wed, 25 Feb 2026 12:32:27 -0500
X-MC-Unique: F3B5trF9PmaAc2yNfL1xeQ-1
X-Mimecast-MFC-AGG-ID: F3B5trF9PmaAc2yNfL1xeQ_1772040746
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-437159d3ff2so4578516f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 09:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772040745; x=1772645545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DYlmXQRxHfwwiEGA+D5oGQIP3S8DkUnP19Idv9bO1fI=;
 b=VCt9EDtS6wpFERCzbFpgQKr145d1n2TLcp9O02kH5yZuCC2tY8b9nWAsmwYN1nRni4
 S2uyEO0FMNriCE+LwImwJH7eBk5fZFXPGTEpavX/FyjBgR9lpUlq2gBWOsaQF3xbX1Zg
 qDit8MMOwV5ZBrClngDCAMi5V//Dn1+djQp99A78r32eJmH4Dcwog6ULRDv1NEnoF6EM
 l0ozL7JZPw2F+SxJxTaJCdJC43Gx0dmtkMJwZ24dTrPyxAPi0bNRRUHJx/i8NPSX1MfH
 KTsy4BOewwGCPqbknZmhZxvxO5vgMSwKpeh+FESHkOEfV/xpCUaUNCswhYDHPcYzLQE1
 k4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772040745; x=1772645545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYlmXQRxHfwwiEGA+D5oGQIP3S8DkUnP19Idv9bO1fI=;
 b=qHOUTKtUfbVv2FozzUL0n1YPoGR7Okc5XGHDEfWscIvNkTk2PVGGIismSyK82JnBwK
 Cl8AZLgV4CWd5UJvA1wXe2ZZ+bxqoD6bkqHtTSardV3nec96eQ2E94C+/ovDl3eznSP4
 58mBAd31f4hJSqxKAGGhPT0xPRa11Q+/9lc+TjWL0ZCw9gf3PAqAvIrwLxM7BBiP+RNQ
 l4TMK72Wq2RIk1YjQnXLkZoSp0aU6qzbxwrExp82XGlvjtsZjJ6XeqmTKi9AzETiB4OP
 2bwINdigCrGpWBJ//UjUpvFPXGPAoSDB+0vmgBysAc0fj1rdO+erFzXWyA4f7uJrrDsV
 tkRw==
X-Gm-Message-State: AOJu0YzILrRA+gntG0KFYyDdhUGAZ8QnrsSOYpT68ciVoNS36/S7qDVB
 gzBupNHWOvzT6Dxfswe+3ABHEB2eAt9jzZgr+m+3kWJ1uytfZqdxVnb2uRvxlIRJvAr8ryk3s+k
 ZFUEbk1yqaMqyS5zVIcXaEUpALQqkslM0YAKtlA56L5zffNpUf8hvngkmGWmXnz2QRF0Sh8Djo3
 nCZFCkBVRcDqXp82nHzj6jMOasZm3xwFM2PYde5K3z
X-Gm-Gg: ATEYQzwv0sYS5cMP6tBjniBbgavJAU9n/SoDlvlIvXm1oo63yHlEOQdeNeF/xdBz0+g
 xDPTuYPQ+/LQyXCQCZTEL2zMdODaIbWtXLSSM0CyxcmxlaFscO9u+Fg8uhdSqZfVrDXPsPhT5Cv
 CWHd6Y3mx3wUrD17q5QEkp+Dew784+GONn2c07WN4Y0jbr5KrZQkqqK5AQyNl9exsEOXPBUMoDM
 L0eLTzCIlHrWXsNopYtxOnpwvPXEnAuSrH5kgjQdyE1uqPAsUafzDg8KTbzPEfsbfF3MPZFSEhg
 zLwmM0T1qNtijiZ2RC4LwZL1o/V0y8K+ZieeFNgbfuN+PVB4jQtsgaPnZ/kum9Dp4zN8n9r5I/C
 2GTtaqY9PzCq/5foc14ODi4EbJaZ3D/6frFHAKST+wi3AdUrQ0GiEgpC+jAGJoGYvcc7ecbnMeK
 9j7XDQsdM/P7F8XpFi3Nc4DpmLEI0=
X-Received: by 2002:a05:6000:186d:b0:439:909f:c590 with SMTP id
 ffacd0b85a97d-439909fc747mr4526833f8f.6.1772040745216; 
 Wed, 25 Feb 2026 09:32:25 -0800 (PST)
X-Received: by 2002:a05:6000:186d:b0:439:909f:c590 with SMTP id
 ffacd0b85a97d-439909fc747mr4526769f8f.6.1772040744624; 
 Wed, 25 Feb 2026 09:32:24 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d5463dsm32256216f8f.34.2026.02.25.09.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:32:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com
Subject: [PATCH] nitro: mark CPUs as non-resettable
Date: Wed, 25 Feb 2026 18:32:23 +0100
Message-ID: <20260225173223.418262-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

Based-on: <20260225144532.84673-1-graf@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/nitro/nitro-accel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/nitro/nitro-accel.c b/accel/nitro/nitro-accel.c
index c92bda32273..a1e97a9162e 100644
--- a/accel/nitro/nitro-accel.c
+++ b/accel/nitro/nitro-accel.c
@@ -254,11 +254,17 @@ static const TypeInfo nitro_accel_type = {
 };
 module_obj(TYPE_NITRO_ACCEL);
 
+static bool nitro_cpus_are_resettable(void)
+{
+    return false;
+}
+
 static void nitro_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
     ops->create_vcpu_thread = dummy_start_vcpu_thread;
     ops->handle_interrupt = generic_handle_interrupt;
+    ops->cpus_are_resettable = nitro_cpus_are_resettable;
 }
 
 static const TypeInfo nitro_accel_ops_type = {
-- 
2.53.0


