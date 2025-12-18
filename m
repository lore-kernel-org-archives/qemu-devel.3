Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BF1D6E2D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIas-0006TV-6N; Thu, 18 Dec 2025 13:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIaB-0006O7-AF
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:18:40 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIa3-0002yq-Fa
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:18:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso7612135e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766081902; x=1766686702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Fw9wiW8eGiYc4imf57ZBrS/UxIVjWCdGG1Tt5+MH7Y=;
 b=DK4sxOgFDcz0j3Ug6SMlaqCbOj6OJjQS4BHT7yvspOJnxB4DSQ7mEAyEX61MoBQcxN
 /ml++01sZJ+Qvd9SIAE48XpRtRZq2uz++3trcx1lxcbUc/XrfKprAn9L64uyg/vgODHb
 NtJD4isRJ46IcfSnXDJDU7bFDtzTwIS/dmZIUHHggQNa4BU7bhoEgYKqoMmOnib0PlaE
 O+qnSnGXUBEBbLa258kaos5GyHTlIcQrFrYbnUmbRA4HKJGfxRbioaF4vI6BhkVhNCqM
 ZBvTlpZ1goD7HSFv5zGFnfngUppA8r66fQeWhKFdHC2mceeKKpRCyc9W1lePyBVUO96Y
 5cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766081902; x=1766686702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Fw9wiW8eGiYc4imf57ZBrS/UxIVjWCdGG1Tt5+MH7Y=;
 b=UjVhp8vWffU36lEXhdiQNWlG5KiYg0/L9aCZimkxdAYTNoLO773hu+eHMTInUYgicf
 V4bAPVpfT8s/S+ylMMWmeX/BCODu0y6j4/fpeDjR6K4S/F1BNnwTB5B9TtZV88GExenB
 Da87bFyTWzl3gHGzbc+vIg/nRdMepo3VetUTu4LX7clzeNutRdJZkwuYQm1+Xr0ZnMpH
 gi13GKB9YxNd8UNOQBU7OEdgTX03nRA9njyzkUB36UTekGV217at6/wEl1o1EoCrabGp
 EM6ttf+oLp2PdutR79OWsgTJhTvMVDtwQywvMi/Y133dua/g2pBM5M0hTtSVftMd4NhM
 ZJ1Q==
X-Gm-Message-State: AOJu0YyPYaq++/vVpvgEony2XCb7+xNwRVxDYaiWypuWQ4UJtDqJw1z3
 bfuC757tjsJU66G4OuZNJM/7hvz8s/F3nnrsG4yEpEo/+UA7nfEbLbPNN9FMvoSCXZJakflq53c
 w5ZyuxnU=
X-Gm-Gg: AY/fxX5m4WGVN2HBDwK31wW0vjBp3WVSyTFKaB9+fvjeqQjJufA/4BwdOnfG/6BozlM
 uBYNvnA1+ToVG3gseRJXtqtkmY8kvsFfOToaD5BQwyxTShjzLgLufvjOvUbIjGHY8M3lTzTbkd6
 5OD3tz+CDu5AygPcUAr00VoCX5GDY1oS77ILv/eqY4WuDkfvdtOeyqNm99MxLkYnLwQ4NU5RbYT
 YrBn6isO4JsvxO9RaaHyN7OiUtXv6MTm+zNIN1HouxABogUP1uZwt/gPkLeoaljNicXox1qKQRa
 mKmEK95AU7VccAj8vla7ExofYNbDxo9Aj/pLRNbMCFGdC7BH8iovjUgxC44CS54f//gxHB/uNw4
 bEPDJjoeNMV9ozNpYCknbDtt/qB2kuE+RvCvmy2PI+RVPofIF3lj5/vehN5YYvlvjHLCjv+aVlV
 rhV+Aw8Ll2uT+NBNQUZ5MN1lSgCod6xcs6zc3m7UWW8MmuxNTdXNcA+a7KusdPO6Zz4iW9dIs=
X-Google-Smtp-Source: AGHT+IHqA+vzL5VfowrzPMh4sMwFeuxieIhnO+m2qRQLOkWuGZXOGkqq7f16yyX5dRTnLIeRTkV5vg==
X-Received: by 2002:a05:600c:4e8f:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-47d1957da79mr976125e9.18.1766081901671; 
 Thu, 18 Dec 2025 10:18:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346e48sm3223475e9.2.2025.12.18.10.18.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 10:18:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] hw/char/serial: Let compiler pick serial_mm_ops[] array
 length
Date: Thu, 18 Dec 2025 19:18:06 +0100
Message-ID: <20251218181812.58363-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218181812.58363-1-philmd@linaro.org>
References: <20251218181812.58363-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

No need to enforce the MemoryRegionOps array length.
We index by device_endian enum, the compiler will easily
pick the correct length. Besides, this allow further
adjustments in the device_endian enum itself.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial-mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
index 13aba780ec5..ce5b589c3fd 100644
--- a/hw/char/serial-mm.c
+++ b/hw/char/serial-mm.c
@@ -44,7 +44,7 @@ static void serial_mm_write(void *opaque, hwaddr addr,
     serial_io_ops.write(&s->serial, addr >> s->regshift, value, 1);
 }
 
-static const MemoryRegionOps serial_mm_ops[3] = {
+static const MemoryRegionOps serial_mm_ops[] = {
     [DEVICE_NATIVE_ENDIAN] = {
         .read = serial_mm_read,
         .write = serial_mm_write,
-- 
2.52.0


