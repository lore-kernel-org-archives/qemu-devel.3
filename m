Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF8ACD3438
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 18:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJFMW-0004ZU-IW; Wed, 12 Nov 2025 13:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vJFMF-0003DH-1l
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 13:14:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vJFMD-0006nv-GO
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 13:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762971252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6wkDGLNl95u4gTMNts1lwy5hnz5zbSzJt2V8JBhOwjc=;
 b=ggBSa7h7RtN8yTMxfK7Jhu2i5louopNYV4dkAwrffNzdAESpgrbWfykEaVHTsyjglbsl9s
 dshN7uoDiA+dy0M8iwa2Ws1U/Fret6sjoYPCeUJXxybhd3aly2QGVVMREzImWaGujHpdk3
 nQMeE8Ty8mEd9uAdPbuslq1aJIbtEU4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-WUS5niERMV2OjthzU1H-UA-1; Wed, 12 Nov 2025 13:14:07 -0500
X-MC-Unique: WUS5niERMV2OjthzU1H-UA-1
X-Mimecast-MFC-AGG-ID: WUS5niERMV2OjthzU1H-UA_1762971246
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47754e6bddbso7928165e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 10:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762971246; x=1763576046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6wkDGLNl95u4gTMNts1lwy5hnz5zbSzJt2V8JBhOwjc=;
 b=Y7ttPZjG0WWNqaE+6nWjKqlj0FGx+76HFDGVk7xMLRCloP3WgEvXUVBWYh3FIzS3r3
 9j/9IuJkxudz8PBgjM8o/ST9bO2ewIOTOtY1jnmoPGecf4qayfLcijf4yCVFuwihh6Nc
 5mqufHZWEzvdMaNMAmAE2I/g5K+8bB0TEb/mPeck/Fq9Bx0Fykqb0bw6Qlyju3IY/49C
 mcxCsiyOSAgTCl/FbxitaWIvK87PL1+V9rmIwcsaqWdHau7hJxhIp8G4TMnXnv/epE7u
 odxKmxFeIcy+lclKlpWELkeAQlo74UI8J6ZXOpOXcHYKeKYZFqVH+/KU2UVdY0is6oNK
 6Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762971246; x=1763576046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wkDGLNl95u4gTMNts1lwy5hnz5zbSzJt2V8JBhOwjc=;
 b=UhUyYi4/atKYgRlicOIyAI7zoX1s7v59+fZXm/dQVSfrNiZ9IroMMu2JmU7xVzX5Ue
 mm63J+de8HossmPGApMJYLJ6MuBSd/oWfcdx0wF1UEA/95K3lqYafCtfCWHkIAHpS+0U
 9xB3SrhnBgQNifHduJu3W/3Spj5ZZnGRMMXOZAIEtxS65YHdD7dfoaad8dmaJCnH2Uxh
 ybBIixCqD2jdFJDQnerXxU23khioP27IATasZv95l0JwftAYI/jHGR/SVrh261T3jYz4
 kunj3G2gMrN5tJBmS/+nE7w2tPQLp91NFLkZpBNaycFgcpKz3+ZHR/BmomKwOBo0923W
 hlYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUepv+EoOJGVZ2Ew0SSHeYmxwGMooft7P2a4WPOAdFo+yWZHZazfZ/v19U3kro6oNM/we+KG3FrOBd5@nongnu.org
X-Gm-Message-State: AOJu0YzFRxA+DmGeK4w1WP9o4hXWXY1FQYKostl2J50YxK/jnEmCxHWQ
 2iSNoGCY3uqR21PytrlJhN4j2ElPWbDC6Zp2sTw0kLJN6qJf/gCHR1vfMqk0QcxVQ1eBmZ6tf2u
 3I8EWOJFVygW5QmRhxOEG7UMclVLuhP4n7XhVIeB0bTClgTO5o3cvXCBH
X-Gm-Gg: ASbGncutl08fauVYfS34/h3s9sYxGaW93DWdQi5Y9KwxMAJCpl3hm7ZROjY9qY1v7Cf
 v2eiazs34MVkVvh071+cire3wWMahUdMtGnOjGmw7/Wh9IqyxtWB93IIpBbPXDID7C3VIQKEYic
 lh02n1kYiGacLuFonOrpId2H4318w/GhVY7zdYr0lDiiV/Q/9EppAZqyDFj+x+s2WuEJtggcx6s
 hWrsl7wgnUd0772YAiJULEiqH1SjgX/DBqdDLey/u4MBb+w+0U1iMNQlkfQy1hRbFpU8sKzJOWP
 oUBDSY2a/38jklIlPoOIlcWSA6u+qortASXc3BEdvX9tCZLEErwd4C7kuCTz/qpVEP5ru3X7UMT
 /lbIWbcluoKSwF/5kU5YvsEDzwnoPVwsTMZdkyp4uW3rBdsEyOiv3N+h3xZFCCA==
X-Received: by 2002:a05:600c:4f54:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-47787071103mr41219885e9.1.1762971246459; 
 Wed, 12 Nov 2025 10:14:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9+tZW+TZfDNytcYdvgsMKLxtasoyhEGtTeovHC2gFRRAmyVWZ9b21XTXgVv0PcfEXirpotw==
X-Received: by 2002:a05:600c:4f54:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-47787071103mr41219625e9.1.1762971246059; 
 Wed, 12 Nov 2025 10:14:06 -0800 (PST)
Received: from rh.fritz.box
 (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e51e49sm46851355e9.7.2025.11.12.10.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 10:14:05 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v3 0/2]  arm: add kvm-psci-version vcpu property
Date: Wed, 12 Nov 2025 19:13:55 +0100
Message-ID: <20251112181357.38999-1-sebott@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
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

Changes since V2 [2]:
* fix kvm_get_psci_version() when the prop is not specified - thanks Eric!
* removed the assertion in kvm_get_psci_version() so that this also works
  with a future kernel/psci version
* added R-B
Changes since V1 [1]:
* incorporated feedback from Peter and Eric

[1] https://lore.kernel.org/kvmarm/20250911144923.24259-1-sebott@redhat.com/
[2] https://lore.kernel.org/kvmarm/20251030165905.73295-1-sebott@redhat.com/


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


