Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A042E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 07:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNoiF-0007ma-6g; Wed, 18 Dec 2024 02:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNohw-0007ky-Ob
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:43:01 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNohv-0006j7-2R
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:43:00 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-725ed193c9eso5288111b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 23:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734507776; x=1735112576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhQYxkte1TR03Kv00xe+YPvtM5yD9Xcv9xhHtnyiN9Q=;
 b=TmQrIXrSGo3zz2AUsS91MTUK+NNiK0Y881szTp2mhytDbGkB2ciJ/JEYr/fFQOcm6y
 B8ggUkUsDeIzPhFxmUdQsLWxHNvGChRxpBvvFmIaaeMuinVhZDjAq8nH+dLy5SkTNI5i
 uomkHDvt1BydEoDHFKwEfasjdSGFMH5pFCxgVpAGbxBleMs+x12BBZ5CLMg5HDn9sEQ/
 1BamklvAFRLvtV8JIVbGhTVrBDPKY2t0f9biKKOcGd1EULlynaOh2WNn4N01Zj92YIbj
 SuvdUaihuiy129PIlh0yhyocUiVux67Lrax/Iigjsv0fSkyxg3x1YmIw3WJZ+ib3mSsi
 Ey4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734507776; x=1735112576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DhQYxkte1TR03Kv00xe+YPvtM5yD9Xcv9xhHtnyiN9Q=;
 b=SKW6Xl2+GfMDSeHSVB0fGaZoE3ylfgxPh4QZkdTr8BNf/KIDdnUgBJr4opkJQ3bvuH
 Hl5c5HxINTi6fGGUsSJAT4whdkFTaO0veArtQO6nN89E+brjtHN6kEn8ae96a3LxEQt0
 cp8pOT4Mvq8bc/nuSfz01Q+x1UUaFZEtMFwNCIVgHtXJzL+LOzXXx9bfH/ShqWvv/9/f
 lMXaALWjUyk5ObOHtBrWAjZRuozw+wgu2fOouOwu6fhUCM0dPbqRLQh0z/au0BF7H/GE
 jaA01qB7XxrQSM9NLzAs3T3isyMpkOYfMWUvPCggbs4UttNxNWvXUs+j2h3qcW1Shpe4
 iJmA==
X-Gm-Message-State: AOJu0YyQwc/mqkO3AEWn4v3m5mpkebijGq7vFhIrlL//4SaU+CB6Z5sp
 ndIbegV4O8EmfgLj2IiBFbMMYEbpOX90HV1IdCUtVfo1jk8uk2MUD5Q6cw==
X-Gm-Gg: ASbGncu2EBBr1znHUX0nt049FU6fQgtvQ6nWEjb8L/x4oWEUto6mBCQAMApQoSVRnGH
 aEwZBTJjFUw4zVvXqzvYvGL0uzlVER2iwskj/X+ZnSuiKU71iKQ/KXKBZeZVpNZvfSzjA+C0UyT
 Fqfjxza+DQZfCWk4tiw0lxTvq3vlIgHD5a6PeV4TcHpbUV9xpWVo0uE3tqv5nsWRZZCEotRiULR
 uYU8VbL7hkHubIdgQjowP6uQ2g0AZOIVQ2LZOAhMJzrT6JIb8XrjgVnm1+dnOJcriQyPSSw0PTs
 V9yaOw7AiA==
X-Google-Smtp-Source: AGHT+IGjJW5O0zzFIkf1ALUeSbO0hZNu1IMO+2h4EsFG/Ng7jISvSniljPv106yzaHIuDra3hj7THg==
X-Received: by 2002:a05:6a00:1909:b0:729:c7b:9385 with SMTP id
 d2e1a72fcca58-72a8d22374bmr2831416b3a.6.1734507776024; 
 Tue, 17 Dec 2024 23:42:56 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918af0caesm7900933b3a.86.2024.12.17.23.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:42:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/5] qtest/libqos/pci: Do not write to PBA memory
Date: Wed, 18 Dec 2024 17:42:29 +1000
Message-ID: <20241218074232.1784427-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218074232.1784427-1-npiggin@gmail.com>
References: <20241218074232.1784427-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The PCI Local Bus Specification says the result of writes to MSI-X
PBA memory is undefined. QEMU implements them as no-ops, so remove
the pointless write from qpci_msix_pending().

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 023c1617680..a187349d30a 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -361,8 +361,6 @@ bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
 
     g_assert(dev->msix_enabled);
     pba_entry = qpci_io_readl(dev, dev->msix_pba_bar, dev->msix_pba_off + off);
-    qpci_io_writel(dev, dev->msix_pba_bar, dev->msix_pba_off + off,
-                   pba_entry & ~(1 << bit_n));
     return (pba_entry & (1 << bit_n)) != 0;
 }
 
-- 
2.45.2


