Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886C3D729F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 18:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH5LA-00041L-Ib; Fri, 29 Nov 2024 13:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tH5L5-00040x-HW
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 13:03:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tH5L3-0006N0-0P
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 13:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732903411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=txmoSWE8e5T93IXqpxgk2/+iJKR+cNOF9vWFQCCOL8E=;
 b=ADbvUpM5We9M8JRUxvU80vyS6XJs102saG8x2eHydCKPiJi4yyLsuMC1XO8QfBH1YWBuFJ
 TMP7odOVxzolyuV7qARzP9XoP0odgIvk5CY1heBDlbaYRoB90J1OOlVeM6AZ17ysejItF3
 DtMbeEE6+WhKRNZYOtmTDZgWzNavqFw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-GhuwSi9XPKC18kY5GyJC0g-1; Fri, 29 Nov 2024 13:03:30 -0500
X-MC-Unique: GhuwSi9XPKC18kY5GyJC0g-1
X-Mimecast-MFC-AGG-ID: GhuwSi9XPKC18kY5GyJC0g
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa5438c6b13so131157666b.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 10:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732903408; x=1733508208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=txmoSWE8e5T93IXqpxgk2/+iJKR+cNOF9vWFQCCOL8E=;
 b=nhL9zFmrgY1GYhD/2P+aChc+1WwLMztYJUBDJwP4/BnkbqdX7WCokjj0QFnovTHdLe
 mB2JHFJ2i6FDWITcdeeSIW2R/XiYZquDJ20eyrmfyu83sl3uJIaiwpENjTZaIJs2KHUZ
 VhlbKSdQY6L6ADODLPrcvv9yKHlwKop7Y1H8cQIIyCrZfuV9HnIkuCrb9wDURqTLF3de
 I+jT+2Mpyi/sHaMKR4dvP33/+xr+RsaELCMtqTCp8DSzbzXfxpVIDnJ6PCmLA3B7BVue
 SlLTJ8LMrpDAWg+2V6VSQ5hroBnBCBckphaEuSZ0MFNInCA6EaKCzLbVwQ4Lc8QgZFDE
 aKMw==
X-Gm-Message-State: AOJu0Yy3qmTZLVbA9Pq3/Gb5BK2GLDs++Hpb+jQNz5fmBF+keuCg0qab
 Mj740sZ8cd5OrmIleEbSnE6D6lYUdIUCChbmvIozeej7tS1dPg0WpbEhtP3vGo2VIg5yLP/DLjR
 m8yCjADt88b3/XDaGbdYjdKM0rqUFDrKEXyMbR7f0Z9UBB9aZTYyu6+M3fOlFz7XDYy6vGnn7F2
 UUo7z47K2LBGvki7yPSy048Vy+niQes8wPloKg
X-Gm-Gg: ASbGncullq2n2p2JbPf6I0ThHCH0c4tSwXhf50HIcCRNXCL6Y2a6hx6dkAH2HsFAtxS
 g+N6qXVQz5+Pm6IbcGe2Qh7jENe8AQWKPdJGwZRBPbmYpn1aAYS59xCrlNZaw2VCZUnWixFNPfB
 diYaNtrpQ2kIVtIB6NTxttgGVpNKUhNHP0rsbxxS1hkXeS9ojKqN16UmrnxO/esxG7OoFFA7XgD
 0DxEQrWD+g2gYGDazzkq+e+/CoR3aDIeUNW8Orfy63+eL2Zx5xS
X-Received: by 2002:a17:906:3d21:b0:aa5:3fa9:e90c with SMTP id
 a640c23a62f3a-aa580f56c51mr960384766b.32.1732903408558; 
 Fri, 29 Nov 2024 10:03:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGViFSVSGcicjNcYg41K6EGGYqp9bTcFti+jTjCPAQb7O0DqpEcbhjMCznZAKC5sykWD1rEJA==
X-Received: by 2002:a17:906:3d21:b0:aa5:3fa9:e90c with SMTP id
 a640c23a62f3a-aa580f56c51mr960377866b.32.1732903408017; 
 Fri, 29 Nov 2024 10:03:28 -0800 (PST)
Received: from [192.168.1.84] ([93.56.170.251])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa59990a757sm194702966b.161.2024.11.29.10.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 10:03:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 0/3] qdev-clock: miscellaneous cleanups
Date: Fri, 29 Nov 2024 19:03:23 +0100
Message-ID: <20241129180326.722436-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

These are some simple patches that I made while studying qdev clocks.
The main change is removing the callback on unparent rather than
finalization, because finalization is too late and the callbacks (if they
were called) would operate on a device that's been already partly
dismantled.

Patches 2 and 3 instead are just cleanups.

Paolo

Paolo Bonzini (3):
  clock: clear callback on unparent
  clock: treat outputs and inputs the same in NamedClockList
  clock: inline most of qdev_init_clocklist

 include/hw/clock.h   |  8 -----
 hw/core/clock.c      | 22 +++++++++---
 hw/core/qdev-clock.c | 86 +++++++++++++++-----------------------------
 3 files changed, 46 insertions(+), 70 deletions(-)

-- 
2.47.0


