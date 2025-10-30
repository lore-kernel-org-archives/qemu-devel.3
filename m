Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A2CCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVzy-0002Mo-00; Thu, 30 Oct 2025 12:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vEVzr-0002Lg-4L
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vEVze-0005HO-Rd
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761843553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c4skaTSZXHQuIRmGbiy2gxynizyJICG1cT+Q8yDgioM=;
 b=b0AtLualPZOceKQXEfxTS5gQZGI2g4ZsP6N7tIcDjM2ZT7dweL2egLeFZJUWfa42nl8Oto
 eEWZpVelX9/k13Fi94Ytz4UA79royGDklTFeNONIP/sM568/z4svdhwEuGFp2WetG5zl9t
 ko/AIyUKam+RONs6xgcIFN6r7X3KDj4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-5lOeUMikPLuyR_k0ddQAvg-1; Thu, 30 Oct 2025 12:59:10 -0400
X-MC-Unique: 5lOeUMikPLuyR_k0ddQAvg-1
X-Mimecast-MFC-AGG-ID: 5lOeUMikPLuyR_k0ddQAvg_1761843550
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47717c2737bso6204855e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761843549; x=1762448349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c4skaTSZXHQuIRmGbiy2gxynizyJICG1cT+Q8yDgioM=;
 b=V7aWKXLgugRpOXbTJl3iYIPUtjM8LlACDKsLfafwyxMPErMgAJ34EeUBhhWThso0uk
 roFAI6++cCoP8Ww/v8HJEZuLYSA2xPKQ3SfvzNLkBaObDXcUDmi6aQq/YcYSyfgQo1hb
 plo+hqol3IJF+MkMba6UU3mebYlmlxk8JB5hcjoqqEJ8w68+uzt3k+mG1RR0wLd4z/Qe
 th5cIhMCAYAh0+0hnYGDgJ4w4dJLcNJ2yU55auuN8Hn+geEuic2XpRXTGkpWdT6vKRvd
 r5ChlZ+njlqhIZklL7VmgX0NSojzbJa+DT9XKvBSp4XHOD5EWz/IbgpX7WMQ3KVWnbE2
 mTgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm6oK3Q5TRRr/TjuX+d8z5moe+lumdVOzRGlpWcohyJm0v62+tkOPYRQ+yrvrlo3i10NwGj8SsiXNQ@nongnu.org
X-Gm-Message-State: AOJu0YyRopY9ReUGWe6wUtV/T+Xb0SHdFCFmPpqXB0MXNjeYlJ4eumJB
 3TCYudI+YmnSVv5N4BfRMKWwNkblgXY6OfBTmnv7zoy8JtlvSII1+RwYq2HyK8C0soVhCchQHiu
 edNf95gyxsGCPiGUzwDxYnv+a9ObiWyygcR9aF0Ui4605a5XEem/3s38P
X-Gm-Gg: ASbGncsfHXI6cjK8R9IQebJNMnbTtuM3na5PSx1cjBcO++BO3EMdl4v2puIIpNcZvXe
 WqBwboqVZ9QnvYw9bQADvd30DGO89mdOr5TNWbHe+ZxAqZambZf50rfxe9d5jNEFZtUcjEr0uVe
 Vsr6k5VxCeM/jJUpsTEK1ejnrChEv6X1fn4lYK8qPRmuJZWEVyMfXjzEr8DdKBWNxdTlUr5Qa/1
 rkpMhO7V/Xf3U6mkuCDcHjsCcMrnIrv4GbwHeyfdYoz4ETolSjAQWSIEt/NEDWCMeQGE9nvz+xg
 X2Fj9nzo5VwQSHIjgA0whmrOMAFIhvUymNC2X0/DscXD2QL5zJwnNpu3XFTHOwzAyupXiI6LrmE
 bpBmddY7U8DL/rgrf3S4/7TJvRnItZkF0VZ7bECimovpwRW+0QO/wMEF9zFLHB7Y=
X-Received: by 2002:a05:600c:841a:b0:471:672:3486 with SMTP id
 5b1f17b1804b1-477307d7648mr5007465e9.15.1761843549527; 
 Thu, 30 Oct 2025 09:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt7B6ojHr/3JYckmLT4sLA4gFFjBs0ue4eJPWN4fnRoRr5RGdu8WPcg8CocqfFNx1nXc9tQQ==
X-Received: by 2002:a05:600c:841a:b0:471:672:3486 with SMTP id
 5b1f17b1804b1-477307d7648mr5007155e9.15.1761843549096; 
 Thu, 30 Oct 2025 09:59:09 -0700 (PDT)
Received: from rh.redhat.com
 (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289e7cf5sm51104085e9.14.2025.10.30.09.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 09:59:08 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v2 0/2] arm: add kvm-psci-version vcpu property
Date: Thu, 30 Oct 2025 17:59:03 +0100
Message-ID: <20251030165905.73295-1-sebott@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Changes since V1 [1]:
* incorporated feedback from Peter and Eric

[1] https://lore.kernel.org/kvmarm/20250911144923.24259-1-sebott@redhat.com/

Sebastian Ott (2):
  target/arm/kvm: add constants for new PSCI versions
  target/arm/kvm: add kvm-psci-version vcpu property

 docs/system/arm/cpu-features.rst |  5 +++
 target/arm/cpu.h                 |  6 ++++
 target/arm/kvm-consts.h          |  2 ++
 target/arm/kvm.c                 | 60 +++++++++++++++++++++++++++++++-
 4 files changed, 72 insertions(+), 1 deletion(-)

-- 
2.42.0


