Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2E8F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGsv-00011y-9U; Thu, 05 Mar 2026 17:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsp-0000zl-I6
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:27 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsm-0002DX-12
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:25 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439c9eb5d36so2163630f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748562; x=1773353362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VeLOTnhmpK3hGfuKtvu330mCQPPVQNuv7C0J7IEVho=;
 b=V0vBBOLbnAaqAJOWAPI9ZEddCBvzmWIVyN6qhvgVxZybqk0brWBKxVT7oEjgOEbmks
 TLwsIn+/xmGbsiriaszq2j2uhai6CzNEoSZCNnhyW+P4Fwj3fzKn+Rsddh86ZrsvVsbJ
 DJFE3fB54V6TEv4jLifFc9XEeHCkI2MpYwZ7v5plOVfxRW7e1vRcs587oszk1s+83ZSG
 DliGpzpv1y1vPCsvcAt5svm+ruyUAjJgBkhtw8+3vc8DlD8i6XBWV43MZDzK1Ti1gs0g
 IIqOEPYnXAjg3Yni8hoTKYAOuThCqvsG7ditdZPov0p5NGUNaPv8msVr7dBfBWomZlkJ
 La5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748562; x=1773353362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6VeLOTnhmpK3hGfuKtvu330mCQPPVQNuv7C0J7IEVho=;
 b=dXQPC3PoPs8bzJWGXZm/9HHWeaz0YydPWTdOchtcdcg37MnqVqfGRR5B2q32blCosw
 eV/DUZJ3Jj6lbbf+s8cwWldzBOYxNVFtalwLy/NLVIAiEd/LQ4dMwL/f/tqCXhONysis
 mmVSYZH+KYZASAEzXwzxIW/sEfj3ti9S3zu/IiwitooImZM3mSMBNT4mNAvUfNDer8VS
 oHV1IPSFlWb9gEnosaS31ALW2Ls10hcHSMH3XopKwUr/aiIDmexBjaNAq8ViF7ued6Rr
 E+v/UrPVETevDlRQpxgs6DMTCahazCJ3yXBxwmdfBJqz0nruQPE3FyVfZDR0qJdulI5z
 bt9w==
X-Gm-Message-State: AOJu0YwTwhXuVWiE0Nh0077IYmmI81GxrYYGfK7nEM1sAomFvIYemh7Y
 9wcd14VOh6eFt78mcrjrrSGNDaf34NrLL4VFl2xxxoCP8DptPaUiCgIv0irPJw==
X-Gm-Gg: ATEYQzxJA8OufUA2JflBxBLRIIo3kx2kENCYbpcKmxLSf0dZdysAbLLzQyP/RVAlN8V
 q2Oa9cf3Ywaya0pqWnuZauVqkNGX/uqTNPBIHb/3wkr1MNsNGFkmCZdg9jWZqAlwO+fRd000PJE
 MxYYC0Ar3Y1V7pUKsKN4oDw/1BJeWJI0+M0TF5JCh1YI2hgJtecwE0yCa1dyu5hZVPE1AccKd7M
 HpzyMkEywR6mRJTABMPMuWlSxgddULgaQ+L8S70dYXC2eALrh/xNT/jyxSJo9QIoSrcqw7MKjh3
 KiBQLcpPhmC0cgx8Y6f//MdPK2x0q2k6HQkXBnBqdGz1qdg1F6Uep/GyITcvUztH/TmopIDnygg
 gceMRlczUEfQ3SBhIjWb9PG4SAPdheXDIOrYkpQZRbZnQx3NSaPicpAWTSYQUpGOf7x5ACPEzuB
 k0jR5oPIK7XYtdlOGIMDOBoqlvjTFb6rVeypXFFgwn8oslnskItOrViJsce7pCi+/+awbSbCWEb
 IZvx7+d5meGiY2JA7se2BPY6JIxf2TsGoGyP02L4zpDFZc=
X-Received: by 2002:a05:600c:4688:b0:47e:e7e5:ff32 with SMTP id
 5b1f17b1804b1-485198a3bc4mr116276825e9.34.1772748561651; 
 Thu, 05 Mar 2026 14:09:21 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:21 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 02/14] hw/char/{diva-gsp,
 serial-pci-multi}: Fix deinitialization order
Date: Thu,  5 Mar 2026 23:08:59 +0100
Message-ID: <20260305220911.131508-3-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The memory region is owned by the device being unrealized, so must be
removed from the mapping before unrealizing.

Fixes: d66bbea4e0d3 ("serial: add 2x + 4x pci variant")
Fixes: 274074708455 ("hw/char: Add emulation of Diva GSP PCI management boards")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/diva-gsp.c         | 2 +-
 hw/char/serial-pci-multi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 280d0413c6..f9aa6e326d 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -62,8 +62,8 @@ static void diva_pci_exit(PCIDevice *dev)
 
     for (i = 0; i < pci->ports; i++) {
         s = pci->state + i;
-        qdev_unrealize(DEVICE(s));
         memory_region_del_subregion(&pci->membar, &s->io);
+        qdev_unrealize(DEVICE(s));
         g_free(pci->name[i]);
     }
     qemu_free_irqs(pci->irqs, pci->ports);
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 17796b93dd..7782452018 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -56,8 +56,8 @@ static void multi_serial_pci_exit(PCIDevice *dev)
 
     for (i = 0; i < pci->ports; i++) {
         s = pci->state + i;
-        qdev_unrealize(DEVICE(s));
         memory_region_del_subregion(&pci->iobar, &s->io);
+        qdev_unrealize(DEVICE(s));
         g_free(pci->name[i]);
     }
 }
-- 
2.53.0


