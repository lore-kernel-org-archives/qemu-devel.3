Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5830ED11705
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSxz-0007C3-WF; Tue, 02 Dec 2025 11:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vQSw7-0004xD-T5
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:09:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vQSw5-00006W-5P
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764691741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VN5D96R/t76acLMeIjKxcWybmi4kuwmjRsxRAB7XktE=;
 b=UCfzE55bIOhuT395iNYjQbkKzLXK/VpND2cG2aMfq7CZHJ25UWEJ/7461fWaMVk8h4FTUE
 zFZ6CVQL9lB5I3/MoYgA2PHKQvKoCwe5+6upmHVP3QxxB4Snb9U3gOkOwbTh4e9JmSqIsC
 HxfuJZK1yHTPT733SGNSDKQrE7wpODo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-urD26W68PReOBIVPg4E3eA-1; Tue, 02 Dec 2025 11:09:00 -0500
X-MC-Unique: urD26W68PReOBIVPg4E3eA-1
X-Mimecast-MFC-AGG-ID: urD26W68PReOBIVPg4E3eA_1764691739
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b366a76ffso3715724f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 08:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764691739; x=1765296539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VN5D96R/t76acLMeIjKxcWybmi4kuwmjRsxRAB7XktE=;
 b=O9n63kxFu3GSR9YvC0nRShBvZyEnulJqXK0mBwDxhKOpyc0q2+J1tM2+Fq4LYNGvRb
 W9juRz3eZg6ZnrkSuexU2TrwSkdyYBFhElqoQ8U43WhDnijrClP84n3jQDKR5jG0Xq8l
 ijTTyQ3u/GW9PlS2J+/R3uSRKK4U34CvoGPGU8PboE4amPkOuc0wZ7mvuqQf9ZX2N7JL
 w+TVUyKU8Peaih/mO9+b9yYEytwcdBw7i7vTk75h0wwhCFNbFIdaPqNeqJyGSX1V80Fv
 mzYMxKIO+RVh8r2UD0/HIaDjOI+qnBm0ApNpyupVO66R2XSaG/g12a57KrfaeQ7JswPb
 eOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764691739; x=1765296539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VN5D96R/t76acLMeIjKxcWybmi4kuwmjRsxRAB7XktE=;
 b=lmz4qWpzFr1wOIq2nKCN24FSoTerxWwWyiYJqFwRypMZOYeUoSjJqYHJWvhqGap/Pl
 qeSUIPdt4xBa/PkV2mArMmic2jAjDnOATMe06NxecB6OQQ/wnMw9iJCBCTynTXYNStkH
 s0KAO+BuBfXNjfdQthdtbmzrq6H+QdC4qbZtADcm5Y1yiMEUzgOTfytit6FeE4Cj6tWH
 GfBYv96zrBg9GG61IIkhCPFrLqMs+GbpCQSd4m6pGijXgEbmTh8JbKU1LflmFtGAEAVW
 NZHR45t7TdQXQf+cq9ScGfWdJU9Dw5tsP8YLzm1fo1mRdoBOkOOgSCmxUrVaXWMyN7O6
 5gsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtTCu3ewvUCslbYlU7PaNURZgniRSbapmYPihgypLZRSQHMk3b36zo7lMGRSiCThJZ7LzlLM9O+Wdk@nongnu.org
X-Gm-Message-State: AOJu0YyaS7fRCFGZSCB+CycS5UT2/zRCMhB5xV5bh1h42ljpuiCDwHQR
 DPI+Vvp3eNOCg7O+0FZHhxyRrZgNpboePAMES/sHt/URS0hJ4iI0mqx+H4s7IxLJ3zdtJlvWkiQ
 HGVcImJuyu/gHbFamGue3D1Ul7Jgb8el6l1xbcr35PJirsj0uukVY4Z0t
X-Gm-Gg: ASbGncthDPfR92XwQofGvqq7cUxITAIL8B8G6oyIVhGAnvfkxgv29WTbbDqamFkoZZC
 w1QYM+0tfJylJs+TG4NsYrUqf4AoOLtea7B58LAOlgHFzjME8RmZ2mMVN0R/2u5ZMQvBZbcqdlv
 u3h9pGevuAuEo7zwuzlhv/MQUpmMBfKosgUz1AbWBHPlaGiadkWpPdTCJLt4qgJMlZgnSG93jUm
 dgb8zoJCFBAqxPYlpWXfO182rV0Wd4K1E7NdFydWLho4xXqhQjcifYFiHD5T3/qrz0D8wJXPx4V
 Fg7HBtOP/3+mFJMihD3xAZHns62z2U7ka8wd6Gpu/MIgBFVWPRWfQ6FXVaa0bGpkeXP2ZDQGgVR
 j9Wil+Kux7x11jjupuBaKLiOfHPqk+tTxsxtiIxOhiFB345v7hGsa1CVwPu8lsodHOA/txoR3
X-Received: by 2002:a05:6000:2307:b0:42b:3bc4:16dc with SMTP id
 ffacd0b85a97d-42e0f213b9emr32166633f8f.21.1764691738809; 
 Tue, 02 Dec 2025 08:08:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlWgvgyCrCdB68a/vDVtdUnY3Hzqt9cNDCyK0z8du3Hyb0hPWF5OXcMS0TvNkdQ42xNIogkQ==
X-Received: by 2002:a05:6000:2307:b0:42b:3bc4:16dc with SMTP id
 ffacd0b85a97d-42e0f213b9emr32166604f8f.21.1764691738387; 
 Tue, 02 Dec 2025 08:08:58 -0800 (PST)
Received: from rh.redhat.com
 (p200300f6af35a800883b071bf1f3e4b6.dip0.t-ipconnect.de.
 [2003:f6:af35:a800:883b:71b:f1f3:e4b6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1caa767dsm34300899f8f.38.2025.12.02.08.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 08:08:58 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v4 0/2] arm: add kvm-psci-version vcpu property
Date: Tue,  2 Dec 2025 17:08:51 +0100
Message-ID: <20251202160853.22560-1-sebott@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series adds a vcpu knob to request a specific PSCI version
from KVM via the KVM_REG_ARM_PSCI_VERSION FW register.

The use case for this is to support migration between host kernels
that differ in their default (a.k.a. most recent) PSCI version.

Note: in order to support PSCI v0.1 we need to drop vcpu
initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
Alternatively we could limit support to versions >=0.2 .

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

Sebastian Ott (2):
  target/arm/kvm: add constants for new PSCI versions
  target/arm/kvm: add kvm-psci-version vcpu property

 docs/system/arm/cpu-features.rst |  5 +++
 target/arm/cpu.h                 |  6 +++
 target/arm/kvm-consts.h          |  2 +
 target/arm/kvm.c                 | 64 +++++++++++++++++++++++++++++++-
 4 files changed, 76 insertions(+), 1 deletion(-)

-- 
2.42.0


