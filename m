Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8E8C55ABC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 11:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtP89-0004Gx-JR; Fri, 20 Feb 2026 06:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vtP87-0004GG-N0
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 06:57:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vtP85-0001ja-2u
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 06:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771588623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f9Iq3P1+3CvjmPUgtUDKxrjal3kc2Xn/2NZQuVratlc=;
 b=dhYNhJaluRnpgzMyCZezjlqthdF0MBZkFLUHDqVG9QW5SSRfUD3Al7cCOUvQXc+0MslHwJ
 X8D0wE4A3njO+Oo1rPfRDNWUsXRnAeHSeswmfd8BLNeBuf2Ibh2czn2z3pv0PCe6kltZdx
 mlISc1dJpu5E2rIB2U8LbNPgA3KXIrE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-2M5eFbsJOtSh6Cj92C6Ehw-1; Fri, 20 Feb 2026 06:57:01 -0500
X-MC-Unique: 2M5eFbsJOtSh6Cj92C6Ehw-1
X-Mimecast-MFC-AGG-ID: 2M5eFbsJOtSh6Cj92C6Ehw_1771588621
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837246211bso21252755e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 03:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771588620; x=1772193420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f9Iq3P1+3CvjmPUgtUDKxrjal3kc2Xn/2NZQuVratlc=;
 b=Wzi3dMnNWa/0bv8Nf3SL2b01lHfBlcOg0v7kwmx9a4DvKjRSjWGNPolls5vT/ELTJB
 tpT+U4Z7tApdtdilIcelGmaPZzH8xsbI5MrlnOjWXB8ItVPd456guC4Zg6TMoH4G+qym
 ZDzx5j5LqgStQ5+Dvs0uZ+ud0j/Z2tDY81I9IK41y3lBXCFrSjCW+T3AgiKGgMg6T2DZ
 4ydAnF28/jo10EA6MIHpwqunG9T5duTUq813b7rdmFIhANo/2mdBh2hnZvjx3llzl4fa
 Ys0Ht/Gy0TQJouUHU27tplirsSnH+435TFVidEuRYNVGmOi1+h7w/j4X8xAEzY0kXOtB
 z/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771588620; x=1772193420;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9Iq3P1+3CvjmPUgtUDKxrjal3kc2Xn/2NZQuVratlc=;
 b=GUM1pQfibiFzqdGqghaUoM6OdkBMOWMTCwCpL0+VMLVClF1R8A75kGGK8uUX7WIEab
 REpjvN3KZtw+2qVdU6J0MIoYWLf+xuqQKHfP3bnR56h/zDC074g0o7bs4T3Nb93keu/G
 oCMq4nFUL/lEwBX4B0Go5Gvy7XAzFYGfmpedRbEK+E/Pz9I1t8QaHssl+bl9DJVsZ+r+
 C4Ztr4ITzIm73mpaPpLO3Nwn2y2GSR2GZ0d+WuVUlK6Gzxmr3jV5ioC5fh8II/X6VNOW
 8gzVTNXQh4nf6LzfxAGZAOtSp0RyzjiMC/+F/3FD8jA3yIPyFJr+vrGH/IJJ9naJsifB
 np5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWcr/gtj5z6rGquuMR6Dhtcl55x1sSfjcl/twl5by84rpcppLLDHmZD8V8x4oLUGkK+S3JXHxqaONk@nongnu.org
X-Gm-Message-State: AOJu0YwsaiNIa6CfjacS/gL7IRK5ZyHs8RkIKAsdk5OSg3NHOOdooF96
 16h/59yzQplg5dg9WLtupuC4Ea7wKjyy/wZQZygf3QvmqlctLjJSzz6ErTDyIeg6OGEAdytHt98
 bu8yxjxzaBHbKFHdmob557gMAIsJ5Hhd1Vx9x02LVTW5TeWKrAUh6hTp8RT+QU4qY
X-Gm-Gg: AZuq6aITfCEbcKoNxji+oypKtzyJ5vqOX5HBiRPA+qoJMdGeXupEh9gORzL40EF1o/l
 Rs1KdgNw0Z1PmvFE+MH3bwOnWJbpZoK/nTlXE5Cgh8SiuPRJ3a6geA+VOJf1uBZVQODcLRTCpd6
 bcIFEHe8Y0DduU0rBhqJNcRm+XimaWGe7XGXz8qVXcxJJZk+y3D49tOXqCgs3VwkrnmRrVpki7F
 70VnE3zXsjrt1rkgCKSAsHJP0+96cf+c2jCgsCR7+p3+ibNylm4F4BlSYzVpQNsR+qK++jmEbWs
 L2GmMnDIubh+cNL5WiaqQDfNC4tsv++0qahYRWcx0yUlzYl5zHN3BDJP6SjNDIj6C/PwjOhoXFt
 adWJTsvGZvnB7oscY3QPtLuChKCeHlVxLjAqNCF5Ya8ZEcwGaeWE6neOueMH/EjTHrkIsiMaly+
 jKf/KBu0KL
X-Received: by 2002:a05:600c:4fd5:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-483989ca4e4mr142430025e9.0.1771588620340; 
 Fri, 20 Feb 2026 03:57:00 -0800 (PST)
X-Received: by 2002:a05:600c:4fd5:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-483989ca4e4mr142429585e9.0.1771588619823; 
 Fri, 20 Feb 2026 03:56:59 -0800 (PST)
Received: from rh.fritz.box
 (p200300f6af2d8700b4c2d356c3fafe63.dip0.t-ipconnect.de.
 [2003:f6:af2d:8700:b4c2:d356:c3fa:fe63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a316c2aasm66102295e9.0.2026.02.20.03.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 03:56:59 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 pbonzini@redhat.com, qemu-arm@nongnu.org, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v6 0/1] arm: add kvm-psci-version vcpu property
Date: Fri, 20 Feb 2026 12:56:55 +0100
Message-ID: <20260220115656.4831-1-sebott@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series adds a vcpu knob to request a specific PSCI version
from KVM via the KVM_REG_ARM_PSCI_VERSION FW register.

The use case for this is to support migration between host kernels
that differ in their default (a.k.a. most recent) PSCI version.

Note: in order to support PSCI v0.1 we need to drop vcpu
initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
Alternatively we could limit support to versions >=0.2 .

Changes since V5 [5]:
* incorporated feedback from Peter
* dropped patch that is already upstream
Changes since V4 [4]:
* incorporated feedback from Peter
* added R-B, T-B
Changes since V3 [3]:
* changed variable name as requested by Eric
* added R-B
Changes since V2 [2]:
* fix kvm_get_psci_version() when the prop is not specified - thanks Eric!
* removed the assertion in kvm_get_psci_version() so that this also works
  with a future kernel/psci version
* added R-B
Changes since V1 [1]:
* incorporated feedback from Peter and Eric

[1] https://lore.kernel.org/kvmarm/20250911144923.24259-1-sebott@redhat.com/
[2] https://lore.kernel.org/kvmarm/20251030165905.73295-1-sebott@redhat.com/
[3] https://lore.kernel.org/kvmarm/20251112181357.38999-1-sebott@redhat.com/
[4] https://lore.kernel.org/kvmarm/20251202160853.22560-1-sebott@redhat.com/
[5] https://lore.kernel.org/kvmarm/20260211153032.19327-1-sebott@redhat.com/

Sebastian Ott (1):
  target/arm/kvm: add kvm-psci-version vcpu property

 docs/system/arm/cpu-features.rst | 11 ++++++++
 target/arm/cpu.c                 |  8 +++++-
 target/arm/kvm.c                 | 48 ++++++++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 3 deletions(-)

-- 
2.52.0


