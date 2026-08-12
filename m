Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19E3C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4V7-0004EZ-0T; Wed, 12 Aug 2026 04:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu4V5-0004E4-5H
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:39:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu4V3-0006Fm-Ec
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:39:50 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so338937f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786523987; x=1787128787; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YiFLVeSqZ2/sOKndSWYhrQ33wTas3iQVbOrkHHiVi8I=;
 b=LstlH9r0g09pQOV3TR+nYNIadLJ8PIQCWBANfOKLcLcPYzpkjk6blhR3tBWpnYwGfV
 Od/ePmjXICbMxu12WLq2uXzb3Yu92FnNyqf4O+lue2XyRJlKkcQ/1SZ33RxXHv+xPhSU
 VLO3tSZYs7OtosAvqhXtnRPgAXGJRrUXrPoIldWxf7eqACeshSoV1IPNTovgc+jFYhSr
 bvf1hkDoE4dcJysYGYjr7EWRVdGTMtbU798tPdc3YTgb9bhOyByDqq4tUWizohpSL4zq
 BcgyjTVRGB3DvQVzvTsSn+OdGYLhSErVl64MXiKT9C5cIHDJNJYa5LJVd/BZyhpNRa+G
 V12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786523987; x=1787128787;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YiFLVeSqZ2/sOKndSWYhrQ33wTas3iQVbOrkHHiVi8I=;
 b=ocORj5hZ5GVy+TorZwtqqw5M8ov2os9cfGydy8qIWI4B2VQOAqArmGniUzorUZl5Wt
 UOT8Vs0Z/2Ixo5y2VoJd+NNYe95hi51VhDRHpYA5cyuXjpWh1pzMhjtEPdHol0T842WZ
 OZmsJvKYyxJ+JgL9jzO0InmwpzzvvXwIw2BERx8S10uAZOt6w4m9japSutTlf/mVHowF
 Zhgu/pl2o/i4k9W1hrQW+zjVQ3xGs1qdwJaCoUvob9RzFGg4/PW3fwqQDwrMXs6d/mo3
 xadWiBLoEHm7Tg6BlxE6jRfxTYB/wb9u/7Z7FEjbESOZEs7xUONljBQutOLtFAmt8MCO
 GhVg==
X-Gm-Message-State: AOJu0Yw/RQtnl8liB3P/hASn4JBk1TCwW1EWn+IVaD05oJbay1fHXJzu
 kb0Ue2jzLjfhAC89f74NMkv6OgPqekM02jBZtYe25o0C2232MEeGBCBfeetsC4gQXL0=
X-Gm-Gg: AR+sD113Al3oSLLiDtoihYlnaufkSk7g8vqbHuA8b805K+jvXY1uXA9295RX0EelHZl
 NfDdy4nfnr0TzU2ikuYcnBRU9HJ/qFr66qDIVoWGPv9Iz6vZ497sZvnsvwHZRAGGJ3G0zrRbvYv
 R98bPcfKLf4hDeBuK67khZTKFjNERvQ1deLwSipNuvxYTFxCaH0lsaP7jK3jPa2Tk09HtNrG2Tg
 QYwW94JCtvFVg4AAr35Lv08jIICKOWfIQ1Ar5VlboNS+Gdw1DRiUDGRiqw9yq+7JCJ4rqdMb2M0
 kBXHUcCh/ksqF9rOKWTPRrO7KTG30TXNAdk7lfUYME5y4Vnt3bfPsG1NpqkpDfES8vV1AsSXbri
 c3XDqzLb5RG/P846PFR7uERjp9kmMjU+RGFmsmeJ8e90zRkmK1zfuWFdwH8aI+UCGQygk62fev4
 61t0ZQYwnOkKvwEmJOO44VhkzbdcdsC3G3oF04kHtDVq8MArBHJkBgZkqzjC6X30DLSQDqUtg=
X-Received: by 2002:a05:6000:2dc7:b0:481:45ed:14de with SMTP id
 ffacd0b85a97d-481528ee84amr4070112f8f.25.1786523987494; 
 Wed, 12 Aug 2026 01:39:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5cba0sm5276110f8f.25.2026.08.12.01.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 01:39:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9EAD65F886;
 Wed, 12 Aug 2026 09:39:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, thuth@redhat.com
Subject: [qemu-web PATCH] sponsors: update who hosts the Arm hardware
Date: Wed, 12 Aug 2026 09:39:42 +0100
Message-ID: <20260812083942.3833221-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The WorksOnArm project retired some time ago and we are now hosting
the Aarch64 CI at Linaro.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 sponsors.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sponsors.md b/sponsors.md
index 8ac7d45..84b54ac 100644
--- a/sponsors.md
+++ b/sponsors.md
@@ -13,7 +13,7 @@ QEMU's continuous integration is supported by:
 * [Digital Ocean](https://digitalocean.com/) through the [DigitalOcean Open
   Source Credits](https://www.digitalocean.com/open-source/credits-for-projects)
   program
-* [Equinix](https://www.arm.com/markets/computing-infrastructure/works-on-arm?#Equinix),
+* [Linaro](https://www.linaro.org/)
 * [IBM LinuxONE Community Cloud](https://developer.ibm.com/articles/get-started-with-ibm-linuxone/)
 
 The [Oregon State University Open Source Labs](https://www.osuosl.org)
-- 
2.47.3


