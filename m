Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04352CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 14:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwicM-0001DO-1o; Thu, 11 Sep 2025 10:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uwicJ-0001C5-9B
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uwicH-0004IC-8F
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757602173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oF2cIsPBN8qXmdEgTfizvTF3d/SEeert5/n3uAYGGo4=;
 b=IeylJWNOlnfu4vqnwNQE0QE+jsQDzdZTSTe0vVnaI2cpUaSIIQz53oYAVLSj7aRlEqvNlr
 jjV7Y/2TU4s4DgpjFrSNOCO3NSc2S6p2Rk8gbR90L/jj0Vkg9S4ZTm5afqdU18PhuqCp4L
 gw8qzlFSf1BP9+bVb+Bnw4VHafPq7g8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-3M87ueDSMoeTS8ug9Y01PA-1; Thu, 11 Sep 2025 10:49:31 -0400
X-MC-Unique: 3M87ueDSMoeTS8ug9Y01PA-1
X-Mimecast-MFC-AGG-ID: 3M87ueDSMoeTS8ug9Y01PA_1757602170
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45ddbdb92dfso6085725e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 07:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757602170; x=1758206970;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oF2cIsPBN8qXmdEgTfizvTF3d/SEeert5/n3uAYGGo4=;
 b=Wi/Q6owyzgEzsoSPrNNUp9/fA0ROKnd5vIwXCHor6A1ICQvUqdepLxscEYbG+3xg/7
 hNuitaUjzZ4TFpPHzCWAhZqpxv9vzOjMdZeYeeZ+kW4Qfp6JUKDr0K9D53uBzlwuCyJ0
 ea9jJKElggORGPxkrOwY7o617x2LLcwlNm5kgQKoH+A00ozeRZ1fCjjFB9vlasHMyPHW
 iirhFXiZ42wiLAlS+TQEd38v5BJz4iS/2rZsjpaNdHwzk8cE7hgSGrLJSwUcNffXBohu
 uW7YYJ72aaGjQWV9eih47+YA/gYOYwY6ll0SqGPQWvU7myLlll5GM6GyVvMDG3Qkc1kZ
 +fug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm9j3xYcLrBE9HizJDMBX1GJedF9ZOXPgBb+oaNzdsaYXMvTHq8d7aYi2D1HZWVGvfYJzmUM1cBoUc@nongnu.org
X-Gm-Message-State: AOJu0Yy3E2pPNJhdP9mY7/sJUmsQ0xsERl/rPUvyd3KiKgXbxWxCZu+S
 4tc0bhtLd3BA661YhWv6b2WEvLs4f7xLxmRaDJLeaP/pH/MAgXbx0H8RHoj8NsYxf2m8RH18zTX
 o2PV6YbC+N6J4rmn6YpIu4dHaYWn30I4UatHsi0SyXl4/D3PRAgVkNLrB
X-Gm-Gg: ASbGncs2I7g0pQHtAOJGmwQg1gmYuUiTmfv0nsem27Hugu5dad8EkSf7RhYnqM9/yFn
 L4oSQciZ4crWJ9Wji+72Dcd10jL+CyuADlOcbFGr/rlBShNw6jb2SjH+89doL5aGxSYCYZ9FiuH
 9Otq7LuwXV9ABDZIuqJuTbsAkQ1c+w2vEax7MkUXXWARLP9mkbpkL1CUjCy7VoNdIn5WnNXdhRF
 B6AiQffj9hpmfwRhyoHkII2fQV3vLSG0vq3fhRQRO9i4fTiPWKXJDFH/IoJJwbtnhYxm5K68CJp
 GjXCxoTLRAFVfUfMKWzg+OUDwJDwV40OMrrC8yyfVrtH8RsGE0me2PobIeJODSuYu/ozzq9OfKW
 yzsC3piy7YfwFNe0jfJm3WtFiTyHq
X-Received: by 2002:a05:600c:4688:b0:45d:d2d2:f095 with SMTP id
 5b1f17b1804b1-45deb702e1dmr110544205e9.19.1757602170321; 
 Thu, 11 Sep 2025 07:49:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8qtF1qAnlROs8xNUfS1Rs+dPLZYcpuM3doPWb7N6ekPV01fUhC82BPE/uzS0/3A1DBuiZ9g==
X-Received: by 2002:a05:600c:4688:b0:45d:d2d2:f095 with SMTP id
 5b1f17b1804b1-45deb702e1dmr110544065e9.19.1757602169950; 
 Thu, 11 Sep 2025 07:49:29 -0700 (PDT)
Received: from rh.redhat.com
 (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0159c27csm14941575e9.8.2025.09.11.07.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 07:49:29 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH 0/2] arm: add kvm-psci-version vcpu property
Date: Thu, 11 Sep 2025 16:49:21 +0200
Message-ID: <20250911144923.24259-1-sebott@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Note: in order to support PSCI v0.1 we need to drop vcpu
initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
Alternatively we could limit support to versions >=0.2 .

Sebastian Ott (2):
  target/arm/kvm: add constants for new PSCI versions
  target/arm/kvm: add kvm-psci-version vcpu property

 docs/system/arm/cpu-features.rst |  5 +++
 target/arm/cpu.h                 |  6 +++
 target/arm/kvm-consts.h          |  2 +
 target/arm/kvm.c                 | 70 +++++++++++++++++++++++++++++++-
 4 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.42.0


