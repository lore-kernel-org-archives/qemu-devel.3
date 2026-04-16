Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B30F433E9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 05:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDFaR-0003Rh-Vc; Thu, 16 Apr 2026 01:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDFaQ-0003RB-MY
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:48:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDFaP-00016K-95
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:48:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso76308845e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 22:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776318500; x=1776923300; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7y7TM7zrf/HNpopW1RlexWweeCSKf1nKomanOa5KSZk=;
 b=XzGsGuXxhahzEEpn/6HYseuQ82Y9vYm6OET03hap5oUiK2HJ1ox40Hd/jw5xN/vgWg
 pujw9rFF0+BWLdCHF9AYbs6h2HR6+yVDaMCw7aHpAicBQ8gTg6XeSeXT3XWcttGugxwx
 wMmLxyJ2ftVO2yqd6ETWhqvOSbMvBIA/zFqc1DeScTlh/nNjkbTZLlc8Fn7XHdVAO2Ja
 GUSPdmg5iroG3Q446Rg67qsx1GVgtZx9VLw48VzdUA/1Ef4mAn1MbjYxpXIAcOsvvjgy
 Q9faP1ZYIm+1TdnrcT2aU/Pvby8etBB8Zqdh72f3XPX7qquOkKGaZfZRV+aZynKohYej
 7Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318500; x=1776923300;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7y7TM7zrf/HNpopW1RlexWweeCSKf1nKomanOa5KSZk=;
 b=ax1FXKtR1BLU82y+BQOdkPMtSXJVAO3PkIemFUqjAD0xXN+742Gz/iXyb2ZOzI/95X
 aGpBXdnokBsOKe95Rx3k0IjjOmIlQ3vBgxdiqFSFbmSZ1Af5tB54GUH8ewlwAkkb47XO
 myCUJY1/htwMaZLt4X/Ua92JvwX0pNTuINeLezvckms0hjg2Fzwp9pBHFIE1diJvk5gM
 oQtC92q0xpagGI6dCtf9lEVJKNLdCa0D55PSer2kDCw0OcOAECJfmXEHK17rz3Lq7m0E
 mLfHWaSUG8I7Yf8WBdN6bB7lywJyKRTL3uXBXuRusJRpxGn+KCFw/+6e11FefVgcOoyM
 a83w==
X-Gm-Message-State: AOJu0YwlcMeEReuUVXOUUgmaxAUWMBr9LsyXOOYw25dc+GmulKDSThaj
 +DHCHXzjSTmiSEa4UZK6jwzNg0XJNI/fSNiL9S0F82+54EW7AQ4o/GE8ucEOtwhQhQk=
X-Gm-Gg: AeBDies7PvI0NnTKCZdHOxyYTjFxJmZGEeXAt+FTfClkeaNaVnJKX4uMFRqY1BuU1oW
 ZSz9DUAaImAZFq9iHcMjTIKXAJniUobdLG4M9qBqUMM7LWvpC62dsng8/6eE1QeYhF86qkvimB3
 I3ZQWMlxF1mqxp0bLLzdhXhZyeppe7IG28718g5tPOgXZ+2m7+2l803O5hg1KijRzZskfTDD0II
 1SvnAo2pwkCl5gGs/gy+plnOWBdMhWt7lPOyYFCw0WgDbqR9Ihg120rpXPYxtT/qePukv2T6Nvi
 cBSl8t2E2c4P9B8uReVs6tjzHB9Zo/1MlmhxlgTUfFbmGe/HilNcRCAeXP/zk3ycDZVBk/qBXHg
 a6uo4iP3SBU4WB0ApztYwSH6lTk4tmsq+jcwmM1jiTm+tsuyvVUPJEGuX1Mi3Y2Io7F6PepTIYj
 +hXx+wRrNZRIEmrjL4EMdSXNUrwhIJPElX0OuhLcZFO3vdsIGOyC4YjY64mU174yO708OyWqgFr
 vq+wpelWs0Jqf0OR3sz5BFXqHnnmdab4jtvIhY+
X-Received: by 2002:a05:600c:528c:b0:488:a2ac:a337 with SMTP id
 5b1f17b1804b1-488d68c2bffmr312352795e9.21.1776318499777; 
 Wed, 15 Apr 2026 22:48:19 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440559.home.otenet.gr. [79.129.177.223])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818e51sm39201895e9.5.2026.04.15.22.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:48:19 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/2] More virtio-snd fortifications/coverity fixes
Date: Thu, 16 Apr 2026 08:48:08 +0300
Message-Id: <20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABh44GkC/x2MSwqAIBQArxJvneCnD3SVaGH6qrdR0ZJAvHvSc
 hhmCiSMhAmWrkDETIm8ayD6Dsyl3YmMbGOQXE58ECPLFG/y7KD3CYmp3SgttDBWztCaELGZ/7d
 utX5wHHwkXwAAAA==
X-Change-ID: 20260415-virtio-fixups-3bc3a1a1cd27
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 qemu-stable@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=510;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=jQZ0+8hcE0wbiElgkbitPaqYS4LFfx0kI1hdIY+zdUM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnA0SGdpQkFNTlZVbzA2RUhDV25WUnhtNFpxK2ZNCjNrQjE1d3I4RzBUYkxsVjJY
 TzZKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWVCNElnQUt
 DUkIzS2Nkd2YzNEowSjkrRUFDUFdNR3VLQWswRFVPbVh2cTVCdzFHTXJ6TlJFZ2dPbVNvc3dBQg
 pJN3RDY2dlOVkxbGlXdWw2ZFUxVVlIVVlWcEpjay8zbUVEWUM5Sk42WXlRZEY0dWVBT3hRT2c1S
 ytnQ0R4WVlYCmZGR2o0bTM2Y2JFcHlPOVU4c0JmNThzb1YzcmhVekp2TUJyQ1VYVTFuTklwbVJr
 M25OSWd0Zlh0S3VISE9GelIKL1RlV0h0bGlVZ3BNcFc0dnZWRWtTSDAzeHpES3NpVHdubGNPbVN
 JcDZtWEw4cUJRdVBneTBlODNZNjVjWU1adwo2SDhFeFVYSFBVOHZoT0FnMWEzblcxREdlNXpuY3
 BjRDg2MWJTTDk1aFpqSWJtVFpPWWthVnhEU0J6MjdQM2RFCkRaV3JUWnY3UDRCalZwL1NPeWNSb
 TZaYnJVY3BRL3p5WmRFS2xYK3R3dlBsVWlEdkg0bTJWTEZXenBnYmtpWFcKR3B2QmN3YUxkaDdv
 bEdTalNxRXRZZ1VFRjB2RzNYemszenB2S3BiVlJNYUNVN254K0wyN0J5QWZDa0h3ZjlBeApmb29
 ROVJUeHZGaFZ1RlpRdUNURlFuZEFibUNrWnRmYlRkMmdCa2g4NG1qQnNCeHRlMkF1bmNnS1h0UE
 ZUbzNaCmp2UCthczdJZ3dlWVBGSWdXakk1ak5uL1luS2RDb0FCVElyTU9DQkkvUzVvcEdsakJRT
 GhQeXJJQ3k5eEZUZW0KcjFMRERJRE56d0trRnFGRzllb2J6SnpPQ2hyc3dtd1RtK2dzZngyY2FO
 MkZ3VjFmLzdjVnVybjFCZmhmQkZmMQpsZ3I0b1lGMEJnRnQySThoQTlUZUhNaXVOSzRuSHpXNnQ
 xeXJNQU9LY1Y5d1FLOEx4YjVuOUpRWko2Z2ZuVTRHCnV6NWlPdz09Cj1JOHVQCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

Added checks for stuff coverity pointed out.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Manos Pitsidianakis (2):
      virtio-snd: check rx buffer descriptor size
      virtio-snd: check for overflow before g_malloc0

 hw/audio/virtio-snd.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)
---
base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
change-id: 20260415-virtio-fixups-3bc3a1a1cd27

--
γαῖα πυρί μιχθήτω


