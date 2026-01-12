Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72132CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQnh-0002o3-TS; Mon, 12 Jan 2026 17:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnO-0001Vj-8L
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnM-0003dp-PC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso49927145e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258435; x=1768863235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hjDGQkSz2d69Y3xUjIS3DqkHM9ixSaRb9oSaRByIicM=;
 b=e/sOTclIgIEpNP04iZr8Ghu3W9Z6i805TQarZSbavGUmft7aIoBX6Z/9M7NIXbK0gm
 MVJ7AoAnxJPmjAFCJia+LBKDNCqmklOWFntCx/zlRlkZeRnZlTOxlkLY18PMCKqLoTcD
 QXuTpzFwEAULkRgI0NpzJvfgiNODrdNia94fsT3osg7EcIEq43z2mrLjUd1VfNFiG95c
 4cuoeYJ9AuBzh+cTycPZe5RGSCz9yhWwM2jcc2+07CA2rldNDwmukjVE3RHR2ITC4G0w
 NQXLPaNsjbcbs0yiq4RRcpaumlJ9fjKCJ/9YMkchILsk1YFFignj8FofZOn/CwOhw/Lp
 8XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258435; x=1768863235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hjDGQkSz2d69Y3xUjIS3DqkHM9ixSaRb9oSaRByIicM=;
 b=WOHAEayn9vJRVLl8UZcwokTQTWUhDE5AqpKGecrg5Rpg48RBGNz0fhntIj7X+ER2oL
 fPVLknxVhYWhqhoYb9xYI1RmKc6yUuqAhRKE7PeT0z1zLdJ+Y0kb3ra8SrgJlzA7+ZDF
 ch7i1M56MQbgFEYLO5tzWGuU7/2nOWvkUJpo3Hgqn182tdfIY5Y6PveAE2w/44bIZJPz
 Ox2NBNNh4qfPvddnWEzfaJ57XDH9EJ0fAgMtPMyHJK1U9ODCMEj7B1MmXsNHCPXct7yW
 ruQ80XFUIzrFCvNkw7GHROg3zjccIvcZjCILHj6l66L5IJWWonz/5Cw54e6DOUFRB2x0
 80tA==
X-Gm-Message-State: AOJu0YyZkM5CMRCQZ1Yn8sJpG/n/BEQFcuPpK4R+XRiUZb+UYz5NzXFK
 rKMw5X53ma9dM32ayr9r7pBTUJINZ3tlysgWX6oEq22IG4hZT94aVA1B1+ggiC+8YHF2KG2n5ai
 LmwaksZg=
X-Gm-Gg: AY/fxX5OtxXRASYxo9fzdlyZyX77CLktiWvooK0VLPtqyDCzsArGTcitK700pPj9IY7
 uzc0yXxLA8K9TboGQ7hyEVVkEtTjFdij+DC5OzlYRxpTAZw2hJbSOnvJ5NfXPorZvc/yXJliU/P
 bvEvL2h1B2gPI5vD7jYJQB98skJNlwhbv7F6lANm1tb/SAccD+yg4b6WuJFPimZJzqH5x4vZA6n
 LWgx1WiZl/J9e/QUw8eIYjle337B/P8tCY6N0BwaKIJGrlz18P6mRZm83/wKrlzmelBsIAW3yGe
 JL6oDodjg+f6ngrmWavVvprf72frbUAoaXYjBQSESh0aYKBw/eQurel/9T4dkIcwFYcdvFq4/U7
 S3V78leHVHZhYB4bOAjBRrT+RPE7GzxjNL6f8hP6Z5sFAD+SKK52aqQk0qK6k/fS/papO9SlR9P
 qsbMEYf4ePANvZtX9an14l+3xxAaVL1ESXWt24Zn6YRe5AK7+rqh7X0nqFx8gF
X-Google-Smtp-Source: AGHT+IFGVSuxj79EGmfc3vQShBama2SD3T+55Acuv9QzDeMN489W8VFWQp5YXneWZb+bK65OMkPmRA==
X-Received: by 2002:a05:600c:8b44:b0:47d:6c36:a125 with SMTP id
 5b1f17b1804b1-47ed7c2afd2mr11892635e9.17.1768258434911; 
 Mon, 12 Jan 2026 14:53:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e175csm40337431f8f.14.2026.01.12.14.53.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:53:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/61] target/openrisc: Build system units in common source set
Date: Mon, 12 Jan 2026 23:48:38 +0100
Message-ID: <20260112224857.42068-44-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Since previous 2 commits and range 2795bc52af4..5b67dbf1dc3 we
remove all uses of the target_ulong type in target/rx/. Use the
meson target_common_system_arch[] source set to prevent further
uses of target-specific types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260107200702.54582-7-philmd@linaro.org>
---
 target/openrisc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/meson.build b/target/openrisc/meson.build
index 31608b6dc7f..d51ea1ab753 100644
--- a/target/openrisc/meson.build
+++ b/target/openrisc/meson.build
@@ -22,4 +22,4 @@ openrisc_system_ss.add(files(
 ))
 
 target_arch += {'openrisc': openrisc_ss}
-target_system_arch += {'openrisc': openrisc_system_ss}
+target_common_system_arch += {'openrisc': openrisc_system_ss}
-- 
2.52.0


