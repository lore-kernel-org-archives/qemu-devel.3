Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0FFEA3F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCBA-0007JJ-9V; Wed, 11 Feb 2026 10:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vqCB9-0007IO-0n
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vqCB7-0008AM-Dr
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770823856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x2E0s+P8sKjuC6cwmuu4hJ5r1IkHeeGVxzBUO13i7RU=;
 b=g3WL7fcao0z4RsmYdfupTUUPKwR2/G7kV/3nBiXmMd3QBNzx/lSRqu45v9e9SbHGokflQC
 mc0rhk8LbokIY3zEEoFKSsncPBYfNJl+dzMY6YTUzSNbTPb16L5vg2uLiOwcKTx2yOuwIu
 65CpHNEshbXqT7wKd1SV2dgJTu+0zg0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-vtO7QOHkPq6JkKuk_gR0xA-1; Wed, 11 Feb 2026 10:30:55 -0500
X-MC-Unique: vtO7QOHkPq6JkKuk_gR0xA-1
X-Mimecast-MFC-AGG-ID: vtO7QOHkPq6JkKuk_gR0xA_1770823854
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4362456500eso1531860f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770823854; x=1771428654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x2E0s+P8sKjuC6cwmuu4hJ5r1IkHeeGVxzBUO13i7RU=;
 b=fKDADG94JJ8RD+ew2XYMhLB1+7GsS6EhPLHbNcyVNhO0p07yJTMz9M4fvd6qBaOGzW
 sS6nxCg9T8emNOgodrToTpUs4k2gR3yLjum+AVQzXHWEaggy1itZ13Ttv2jWvxfEIeUZ
 yotht0yg2zE8rV+3zpSHFiSOzcNvhKSwvib1j6/3tH4+P/VXlEMt1MNzxX6WujnTAZ0n
 oJj4/hSezOAo92yEMLyOaQyZTmr+GlNnAuDI7pWChzsem5uPojcyBsTwFQsV2urdIPJU
 WPkKb2R9mofRXfVrosmCMkEIhsVIfuDaGxLt2aCP6SDR/nYx65aGl+yLTcG5fb37p7vS
 Y5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770823854; x=1771428654;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2E0s+P8sKjuC6cwmuu4hJ5r1IkHeeGVxzBUO13i7RU=;
 b=k1ci9kjitMZY7LEF9qHXEtYDuQy/rywWEwP13J7uJRmKbNpCqfhm8q0lnQs98TXBv5
 FbO1v1oO0znHi47DsNUcNuYN9WvCw+gIgW3UZDOxiS193XiWVprJ/uBnsrHg/MUN06rP
 yHOMZ/y6QPFMnSNg4w4qjepxhvXAM4UY4MBiVU/uYF4bwBvzjNyPVmelTFriLy6Ymcah
 ZsuBDo8vHR191TcYMpceBO2Zq3pTKttcEGQit4T8sa5rxYHsIpRl3uuPyFHIQjDqVN9F
 kjajHGZRT3PKLd+urNfNE9b3/n/kdvUrOVCdY7uO+pHlHX6jOxh04ve1Pc198PXm4MBG
 bNyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCVwQH1lCyIQk0uq01C26I+s2gektJLxO3pg9XRhnDUToStaD6AO0kxnhEb6FKBgFl4iryW+Vyp5le@nongnu.org
X-Gm-Message-State: AOJu0Ywb0lU5HTyGmCP6EwNCkqDYs7z/tu9UI9BP9shueMsYxhe0wfK2
 q9bwRMF/IwST/GVdc8GU+h5n0IkJjZcncTPxQV9APDfff5sR4stIKxEEt3YHzjs5yqVI+pBnKPf
 egRnayLeXD37r8vrORkTvTtuV3m82snYIT+3FsguspyXqsHI+joOhXM7u
X-Gm-Gg: AZuq6aJeU9fkXERHWJmnFANJmOyQ9vdW9+76sH2JH9nMc4Pt6DlpgASNJefduE/pC4/
 pw0JA7dWHsF0T7TrDpTi9vufsuMZatal31APp0gSbpZS3qPXzfa5B9qiuNVTKamjWlrmZGjk63I
 kkdG5S76ewmnHvYO/lc9TxugH7Mv6CAKwE3NdBz6LjL+jmOA1LZ/n7vbtFalD1rUCxGAxH+uUzc
 3tTpuCh1y6t/lttyGA4F0bKjKONTHObD3ycm+TWMYVqvOJyhXHOJ3HlVxgR8T24QF3kS8+Q4ENs
 2oxsFrqPZluL0oX6Zg9rU1sC7f8XfpItSdnbFw/8aMYX14NsWUPnZtgNRdqcWTP2ru7xx8VpSl6
 nJ9shVJhxfxaxuIIRFkcCZb0IJjeB4UsILTsVTj13Px6yfQ5KkVTAjLpFyQlCEkFBdUhF+plF5R
 b50ShsEwfN
X-Received: by 2002:a05:6000:420c:b0:437:a49:137d with SMTP id
 ffacd0b85a97d-4370a49155bmr20114268f8f.21.1770823853634; 
 Wed, 11 Feb 2026 07:30:53 -0800 (PST)
X-Received: by 2002:a05:6000:420c:b0:437:a49:137d with SMTP id
 ffacd0b85a97d-4370a49155bmr20114220f8f.21.1770823853091; 
 Wed, 11 Feb 2026 07:30:53 -0800 (PST)
Received: from rh.fritz.box
 (p200300f6af2d8700b4c2d356c3fafe63.dip0.t-ipconnect.de.
 [2003:f6:af2d:8700:b4c2:d356:c3fa:fe63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d34657sm6448511f8f.6.2026.02.11.07.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 07:30:52 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v5 0/2] arm: add kvm-psci-version vcpu property
Date: Wed, 11 Feb 2026 16:30:30 +0100
Message-ID: <20260211153032.19327-1-sebott@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Sebastian Ott (2):
  target/arm/kvm: add constants for new PSCI versions
  target/arm/kvm: add kvm-psci-version vcpu property

 docs/system/arm/cpu-features.rst | 11 ++++++
 target/arm/cpu.h                 |  6 +++
 target/arm/kvm-consts.h          |  2 +
 target/arm/kvm.c                 | 65 +++++++++++++++++++++++++++++++-
 4 files changed, 83 insertions(+), 1 deletion(-)

-- 
2.52.0


