Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211BFD70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjo8-0007SN-3g; Thu, 28 Nov 2024 14:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGjo2-0007Qk-4c
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:04:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGjny-00012P-Be
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732820635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eriCoUsPgPe+ZFlX9sbQ3IOaHyhMkLhKCQuZMuT1aeI=;
 b=bJ+cAvUKwUA7hbUwwYsUgAygJ16g291jCo+ijBPlioOyOkVE723ouT6iiFfo9Ub80tAQ1l
 3nb6hSOo6HlIvXEhLeMxSVKTk2MOeBKcnL4eHlYflzcq1BDRTKjOG9ef4Q43zpjWCqExb3
 yGqdIPwDX2309dOaKk58KBDUcIRCKP0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-RgFJkmtEOlu9IqE18DDuOA-1; Thu, 28 Nov 2024 14:03:53 -0500
X-MC-Unique: RgFJkmtEOlu9IqE18DDuOA-1
X-Mimecast-MFC-AGG-ID: RgFJkmtEOlu9IqE18DDuOA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434a29a93cdso8011355e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 11:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732820632; x=1733425432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eriCoUsPgPe+ZFlX9sbQ3IOaHyhMkLhKCQuZMuT1aeI=;
 b=jtmCO/3ncPRu7smGIFul1a5YcTRuRJc9Rk6R7+i9AjzDYtUI6Etshh9y1W6LT80BWm
 OyioOv6zAdJpCGnBjCMNVli44Wnq7MebjcN+uALtq5Woqi/RCMbTLKvGfLXaYvewscm6
 bk4uBFplvdYksBxAGMMTiB6iL205RQawzhhPjDV/ZPo3TEQcxM/WXBwYEgCtLMOFfhrn
 F9ooV+IoBQKSTi2CnW6LfOxkiYwPecIBbYCN67ArPVzF98rGIxck5ch0TMjGz2eN6v48
 N9q4HU1OJ3nEpXJf/4MyWpAhBsM1joEA2TlrPtLA5Ygs1Kxujvz5tJxUlbVvlmypij/w
 Ltyw==
X-Gm-Message-State: AOJu0YxvT5aYBEkvSY/IDJVQ+vJ2W8LKX/RPR+Ei699py78pQ9SrENRn
 tHmBP9gq/6LbJyQc/RQ1rVLL5zjKP4GhRaqFCXvqk/FlFbwWrcLtWYMsw+Z78fpeTic/RW6O2VF
 ay7erqvlE41qxbWwhCw009rqUWSuW4nckLxp6WCxUgv+5gDz0brz8w2SBpLVidUMEkOda4rBOxr
 ZpH5m/GfheIWkToav1jZJRLeOaxESPieiAGIhq
X-Gm-Gg: ASbGnctgf1uLxFZ0IXC3bbk+3fW8U9fou9N7VQKkTk2HFg5WO1fBLptfNtaJ4PgMhk4
 4VERkTdZouEu7aBO7oeRGSjM/DxG3jgWQbqM75LzBRgnxuZ4wjOYkKfNC3orBFOL/sEfDnh7rLH
 6jq4qfaKD1gfysgka+GuoMaVn09uPfH1RE1Zm+y6Z/B2iW2P8+a7jjOXPq1rgSONnpMhzFqCt43
 tdyHDjy/CApGxJj6CgAGJr004AbDWP2CtcNbq+8+6XXnJA0QRbsV1c=
X-Received: by 2002:a05:600c:1e06:b0:42c:b187:bde9 with SMTP id
 5b1f17b1804b1-434a9e0bc3fmr82747925e9.30.1732820632154; 
 Thu, 28 Nov 2024 11:03:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcMbhntS39q8xFwn3IeO7G+4wcuQfv2dFRQhkYPY81ygmni7G1fx+fCMaad26dnN3uVkR5IQ==
X-Received: by 2002:a05:600c:1e06:b0:42c:b187:bde9 with SMTP id
 5b1f17b1804b1-434a9e0bc3fmr82747575e9.30.1732820631559; 
 Thu, 28 Nov 2024 11:03:51 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa763aaesm61448755e9.14.2024.11.28.11.03.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:03:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Bugfixes for QEMU 9.2 rc3
Date: Thu, 28 Nov 2024 20:03:46 +0100
Message-ID: <20241128190349.541014-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 24602b77f5658ae8377958c15fdef2f44affc743:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2024-11-28 10:50:20 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 3abb67323aeecf06a27191076ab50424ec21f334:

  scsi: megasas: Internal cdbs have 16-byte length (2024-11-28 18:02:22 +0100)

----------------------------------------------------------------
* amd_iommu: fix clang failure on non-KVM targets
* target/i386/hvf: fix advertised 1G page support
* megasas: fix CDB length

----------------------------------------------------------------
Alexander Graf (1):
      hvf: complete 1G page support

Guenter Roeck (1):
      scsi: megasas: Internal cdbs have 16-byte length

Sairaj Kodilkar (1):
      amd_iommu: Fix kvm_enable_x2apic link error with clang in non-KVM builds

 hw/i386/amd_iommu.c       |  8 +++++---
 hw/scsi/megasas.c         | 14 ++------------
 target/i386/hvf/x86_mmu.c | 30 ++++++++++++++++++++----------
 3 files changed, 27 insertions(+), 25 deletions(-)
-- 
2.47.0


