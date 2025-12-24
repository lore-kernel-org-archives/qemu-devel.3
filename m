Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B6AE7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYP5s-0002Js-NE; Wed, 24 Dec 2025 08:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP5o-0002Jd-VA
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:39:56 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYP5n-0002KJ-5a
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:39:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so39679255e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 05:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766583593; x=1767188393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dxY3HPB7rRZjFZATDxR6GWgzcoKAUIYF6yFOCpX50IQ=;
 b=TTI54bfudZMG8Pju9WK2G1V8Uloysr8UxeMSwz71DiOSpNfF2o240OH3HL/mGltLr/
 U8gzmYbVBCzbnUzmHgWZMZHcgNPgrrRAGmcn3c3CmsJ2DkfxMbESj4RpOwCVLLdKHyiJ
 hEmx00km6qWolb8UF7wLCuSo1f5QKtFML4KmllV6bsEojyJlK4bxdrKuBDdhMzOSoI/A
 Hs8wmjeSvk1cVizySWPzYa8EYxfJtQn2tASmfaX4lHanOym2izhWFnvtm5GgyRob9y7s
 UBilJLCHVouAhLo9DL1mu1BR2WS6HdbsedjdIpwUbcAgoq/Kj6K2jDNVHyvc/vvNy5Q4
 GLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766583593; x=1767188393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxY3HPB7rRZjFZATDxR6GWgzcoKAUIYF6yFOCpX50IQ=;
 b=KrLAtgFjcz5+jn2vEZkIR/nDgl3BH/bHn+j5nmPoXKgsk50aAnsFj9nf793f7TLYOY
 ni7YdyoBBCSImPH0xx3U6C6n6w9Vqi0n3SRhkPpseOYKRSOS5E3zQxQKm2nop/O0HIHu
 SbzvcJVQ8ljzXCdi8ozgn8HJ3fgt7cjyP9JhsuHqVY1KkuSJUQcPUb3Y7ZrFBAwmBZpk
 6L6Ml3747TVS7h5ZP4takhqMGjnDaKjn2PNWHHTEjsFd13bCHViurG10IpQRzPRMA9Lj
 uSwYCLrkU6rmsdTooS8kBtZAvzZHVxFvmwTfMH5pIXb7xmnroU8Z4xi12phQQ/AxM+vT
 59eQ==
X-Gm-Message-State: AOJu0YzBGMz2cHw4r+GrJNv6Rn5HBx/BjW3wmLmh+rKZFx9duZJbOKeh
 6mkIjhS1+WRUmerP6MZB//5X88EecUOX6+PTm8JGFWmUiqiAyKlimG7Ep1fZinpxdenEMwvVR+6
 yO9n/S8A=
X-Gm-Gg: AY/fxX7N56a7nXeUUV0ikTCW9tMuVsAwTuu93AAUF89B62Gu4eGCbSRu2DyfCPYXRDG
 YohTRrlLC2l1hgBh+1cFaHho7aDJPYDrEf7cwMIufcHEBrdmLyBy5SahrKauZtM4cd9oCrBIMr2
 1Wc9/+Mhlmbq2IVrVG8amTSiq1AsGZC9lYWIG1oohNgeqnooGh0axutYwGslzubx3RN12Ce6rqr
 a5MKxEmt3MQKlFw2jdiMYxVuUZuo8AgSi/XpGAu4Cxp8yHJ384+Wn8XdODi9MJKLgfSlA7I0nKc
 sc7I1ee+eo+rJUbQpeeWJnlE10bbeuUrhtmf3KKS395J9hlgI9iktltk4E84IvPs272gJ6/mCV6
 IRwYYO80spB5j0GgvcNSQ1HKWRkGXvWqZJtuBT1HgSJgwK1jfoEssbn9Ox0K7uIO0xRlHFNYw6Q
 iPp4oqdOexT1PH7MCXxFIpu5s+kAoLFSkIukpGEI9rVb/0sI3W1nY5b5g1R9BR
X-Google-Smtp-Source: AGHT+IHrmo8Ih956Mv/7/Yii6h90TKwlPN5baqC8gVFgQPN8SlMveZIOQpVu2nqxq0Bfk5TkMaOY0g==
X-Received: by 2002:a05:600c:6096:b0:479:3a88:de5f with SMTP id
 5b1f17b1804b1-47d1959d6eemr181181905e9.36.1766583592960; 
 Wed, 24 Dec 2025 05:39:52 -0800 (PST)
Received: from localhost.localdomain (218.170.88.92.rev.sfr.net.
 [92.88.170.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm34432951f8f.35.2025.12.24.05.39.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 05:39:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] monitor: Merge hmp-cmds-target.c within hmp-cmds.c
Date: Wed, 24 Dec 2025 14:39:43 +0100
Message-ID: <20251224133949.85136-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Requiered for single-binary work, remove target-specific
parts of hmp-cmds-target.c, eventually allowing to merge
within hmp-cmds.c.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_hmp-v1
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (6):
  monitor/hmp: Replace target_ulong -> vaddr in hmp_gva2gpa()
  monitor/hmp: Use plain uint64_t @addr argument in memory_dump()
  monitor/hmp: Remove target_long uses in memory_dump()
  monitor/hmp: Inline ld[uw,l,q]_p() calls in memory_dump()
  monitor/hmp: Fix coding style in hmp-cmds-target.c
  monitor/hmp: Merge hmp-cmds-target.c within hmp-cmds.c

 monitor/hmp-cmds-target.c | 381 --------------------------------------
 monitor/hmp-cmds.c        | 354 +++++++++++++++++++++++++++++++++++
 monitor/meson.build       |   2 +-
 3 files changed, 355 insertions(+), 382 deletions(-)
 delete mode 100644 monitor/hmp-cmds-target.c

-- 
2.52.0


