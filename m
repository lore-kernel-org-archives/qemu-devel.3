Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0AAC79FBB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4JW4-0000Fo-N7; Wed, 09 Sep 2026 10:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x4JW3-0000FB-5W
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x4JVz-0005er-Mt
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788964986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wLpBNFZD3RVw+7D00ZIotFNb9etsyMpGKaQi8IeeH7Q=;
 b=a4IPIvR9Eoa2m0lMJh4vRTsgbiOcit8FmeTGTGNSHKh/gnKdjPmIT3Td/KcK2/uiaSi36W
 RCUP5g2szWYNKTdwzZTZisqpLXbNJggjdVfyF3/JWkrXuwWLyGWy9kwg20J6jXVVZznJxU
 QYzXdxWEnButhIwX5HV3DcgnF4797jo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-NaPsTDCxPX6YJ7ddKFKdGA-1; Wed, 09 Sep 2026 10:42:00 -0400
X-MC-Unique: NaPsTDCxPX6YJ7ddKFKdGA-1
X-Mimecast-MFC-AGG-ID: NaPsTDCxPX6YJ7ddKFKdGA_1788964919
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-484337a63bbso3838861f8f.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788964919; x=1789569719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wLpBNFZD3RVw+7D00ZIotFNb9etsyMpGKaQi8IeeH7Q=;
 b=BKvTJ4OAu/f/GksRKGJF0Eq2b0Yj264V6ukD9VOVwMeqAS8VLhY12OHYMsnNdwyx+7
 qu3JTLSaYEVE5kh/40G/zqS7zoMXRpDdPmQ+e8r5AMpDNLuITDEZgHu2XorT5HcnhHUk
 hXhaoFoknZkZ052mzAOydYr+8LsbuJjTmrzOv4oOcBDpS18qVIuRCqN0034H4XiIDevz
 E7rI7LvnbI0HK1V7J/qK4ZOQj6Ah/fbxueEnDmB4JJptBxJ2Qj33rNPeZe/8fhz6A8rQ
 URJk0CYY6h54vdEDcyNloYCzGWqLZ7jHYEv1q05JchppAJ1htowXLyS1owPtZldI5XTK
 GNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788964919; x=1789569719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wLpBNFZD3RVw+7D00ZIotFNb9etsyMpGKaQi8IeeH7Q=;
 b=ssqxWKUF6G6rtmD6k9GgpqzRK1tf2LnJVQR6HWw+EWiT0iQ3fTsMUKPKVaedWFN5cM
 O4dmpKFm989g44/2MfhhLGWtBFo/HwTFp+ot21G8wc4kVeGZvjOrsmL50trwIkADBl5U
 TyKRGQQysKTd3IK+W4YYc/O37ql4+LxXBcGPVFq0xV9PTZ3bzJGjLzi47bhh8RutFmhF
 dQEDZ0l3MIs+1+DhpFnZIFBcJnDpmcmDhaGrRjcu/olmf7uokhmdHI2NKvZSEkSAar7m
 BsvEOMjVBG0XRrh75lSNmFV9P8+dYF/zw/ZVqX/u4ecyxTcB04xyKA8MOaDyUEFbbuhR
 Imyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzU8oUnUS1OAkuerdHfwP4s9mah0U2O2HO1DxksaKTt6a78velt3hMENLSdke75qo/uYa3mVMybU7Hj@nongnu.org
X-Gm-Message-State: AFuF++mC1kwzTurMALYYC36O2eYi89w5ybHsrG0RkZjoBF2RScKpyCY0
 5KMMZIEdle24yuLv6h6BqfBNFlSio1riLcFXYEAw1yC3ppmA5kQ4wN9H7+9skYj13Zvrz8wszJF
 dkfhBaC49MbrgS5GZOsfdvlT5wpJDwOd2Wv5r7VUFMHhtMfzpK4VNG0s+
X-Gm-Gg: AYBFou1PCjBkczl+D9ndZFJtQ71X4A1/7glJkrC06ZzQ7m6xvW1Xc9zC+1y/yU3aCcb
 5JW2vgQAuBJMr8ZVfk2DTsFPJbNa5BYwr+rh6Hn42V+TRMfOVADBs3NAscgFHp0KnsJ8u1bCVyu
 Z+TK4Q1K1aNRtAzQj2qYa6s+YkrD8VYpmGW7fQlbjXbseZoW3sPvarXTDOG4mqyRFYou3MIsQtR
 4pe9pR8gg39MDVEKduQbCTUkyWifGySxTDDAy41kn1CtDmjFtLaj1hY/VmFG9lqjRfxwDigJmUS
 oaWachMlAzqGXgBsP9B7O9ieiRAAytOCsOYEEkFw+MwFazptq5prh5kAQAMmeKxT7X96O4SKgo/
 p9nrrroqxuWviGjSswEgjacLnWVRQgt1dRXatic+zu4EXeH9yjyG5zfdMfHsrU9q+9A==
X-Received: by 2002:a5d:5d02:0:b0:485:8a46:b3c6 with SMTP id
 ffacd0b85a97d-4858a46b562mr37607288f8f.46.1788964919537; 
 Wed, 09 Sep 2026 07:41:59 -0700 (PDT)
X-Received: by 2002:a5d:5d02:0:b0:485:8a46:b3c6 with SMTP id
 ffacd0b85a97d-4858a46b562mr37607258f8f.46.1788964919199; 
 Wed, 09 Sep 2026 07:41:59 -0700 (PDT)
Received: from rh.redhat.corp
 (p200300f6af0e1b00fa6b14698c8a91c3.dip0.t-ipconnect.de.
 [2003:f6:af0e:1b00:fa6b:1469:8c8a:91c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485958f1493sm32933395f8f.37.2026.09.09.07.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 07:41:58 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, khushit.shah@nutanix.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v5 0/3] arm: demuxed ID registers (CCSIDR_EL1)
Date: Wed,  9 Sep 2026 16:41:48 +0200
Message-ID: <20260909144151.26803-1-sebott@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To support efforts to generalize handling of writable System ID Registers
[1] this series addresses the demuxed registers that are kept outside of
ARMISARegisters namely CSSELR_EL1.

CSSELR_EL1 is moved within ARMISARegisters and accessors to retrieve
and set the demuxed values are provided. Initial values are gathered via
the usual KVM_GET_ONE_REG ioctl.

V4 of this series was posted here:
https://lore.kernel.org/qemu-devel/20260702133606.34529-1-sebott@redhat.com/

[1] https://lore.kernel.org/qemu-arm/20260616132625.1732031-1-eric.auger@redhat.com/

Changes V4->V5:
* changed diffstat format
* changed cover letter

Changes V3->V4:
* added R-B from Eric
* incorporated suggestions from Eric

Cornelia Huck (3):
  arm: handle demuxed ID registers
  arm: handle CCSIDR_EL1 as a demuxed register
  arm/kvm: get demuxed ID registers from kvm

 target/arm/cpu-sysregs.h     |  9 +++++
 target/arm/cpu.h             | 18 ++++++----
 target/arm/cpu-sysregs.h.inc |  1 +
 hw/arm/virt.c                | 19 ++++------
 hw/intc/armv7m_nvic.c        |  2 +-
 target/arm/cpu-max.c         |  6 ++--
 target/arm/cpu64.c           | 14 ++++++--
 target/arm/helper.c          |  2 +-
 target/arm/kvm.c             | 31 ++++++++++++++++
 target/arm/tcg/cpu32.c       | 26 +++++++-------
 target/arm/tcg/cpu64.c       | 68 ++++++++++++++++++------------------
 11 files changed, 123 insertions(+), 73 deletions(-)

-- 
2.55.0


