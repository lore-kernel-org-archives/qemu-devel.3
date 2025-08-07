Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A69C87FDA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 13:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk0GV-0002Ju-SC; Thu, 07 Aug 2025 09:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uk0GD-00028M-9L
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:02:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uk0GA-0006to-4T
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:02:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459e3926cbbso4937515e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754571735; x=1755176535; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cu9VJ2G8pODrK0GcoOi2CvsmQSsPUqkZ+nRhmsTmMU8=;
 b=tD5MawJt5G2FoZppGIg8UdM/K4wzf263N1aMDC5rhOzn8RvF9fxaeXIGh+RsXqzbe/
 3L7cGhiXDL5Rv2i6y2J66VaUuusOIh2GxO5uH13zMaSQp0gxY18204+pgFnKXRb0ajUk
 cRWk2cFEC817C1dslaGeo5SKZT/8wUP/9UB0Kz2Br2q3jxEod4LEpIfSaHna47k/hM/y
 vCb6XpjWKWmf4JtkK1akz1M25G/GUiE2/rH9IziCk8yHeLyVk/x4D0WlUJKgbS2WgjEJ
 zQtmV6JtFSLlZw/9Zmwe3l5MO9uhGJeiS+qHJiTtzlz0K3Zz2RGEqzaitqox2wPmJ60j
 4h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754571735; x=1755176535;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cu9VJ2G8pODrK0GcoOi2CvsmQSsPUqkZ+nRhmsTmMU8=;
 b=KrarDtChsHEuqpB0bXTcWdfHKbdTxyvq/RreMVYxcbKoXIH/+rAmumGyiVoTcoPxpl
 HZsAS7EFOB2FDghaa49N7lNyx9SWqaZp+t6GFTfPzVUPW0/OcWuigAGq3XlErdeaG5p3
 f6jx6rYMLKZTAA5atDKRtfL0QYBbnO+dL5l6CT5vk5hRwKBb1hr+CaCNe2ODxUbJt904
 ocVAAHVz6ZLpSDzx5yNpP8uN8XhAhcElkw73x8QBA1H2/C4N8jNrSjF4f64N2cUj53sJ
 G/JVwwR+wbwMoJQBH3rh5Yek0DBEu1SqnwMfLYjvGEsz/NxYYBAs5k0lIWDe17WzTn4n
 I5BQ==
X-Gm-Message-State: AOJu0YzibZaHpKv+hsJZbm7ONHUHiePFYddkkrDxF4Mz50/tFmpl8prW
 A0dQ+TXxww6iIZboBzQr2+JHdKXEADNi7GwiIVAJIbb6Ma1k0NvKZrszWOYEsgPuwmg=
X-Gm-Gg: ASbGncsmfa7UaAOdXyfvJB9yCRjA3rafo/TJXLDlpT+6fLYqWBN+d8rMz/y96Y2iPpy
 xAOjyv4lWz0lT8p+NwO8cu6HvDWsxjOEkvjYN/7O0rAPjzyYL7tW63s1vHscvS/7KgpWdilbpp7
 9nP4nNSGZLlMtmDlJW5LwzP8888Tpb2SzoInJmyEoeRROT852pXCcrqBGv4QElr44b/75eJqs76
 Q1jr+U5aa/6UNh/avUiE8Y+iz33AO4DiPsQKqFpxUex9O/dpl3OcKhcwS32intzHdvz8PAAsHi0
 ZuYyvjNJJSv8lDAKqQG75zHBkIj5o1tQHVFcYFGTehx2NCrVocR/DqGl2Bb/vRzDnFZmiB4pNNB
 L/WOEETbFKlV/86aXqi311HCU2NFiEf3NYHH2mr11sSJvjaBrZSSJXvMS1HTtvlioUAau
X-Google-Smtp-Source: AGHT+IG1CF37ecOGVOctub1bFZDP/Lrqo1RpnPe9NCineMk4o2qxPlR8MCIkUyi/zaDMt6MRTlZZdA==
X-Received: by 2002:a05:600c:3ba3:b0:459:e200:67e0 with SMTP id
 5b1f17b1804b1-459f33bb3b2mr10838925e9.10.1754571734296; 
 Thu, 07 Aug 2025 06:02:14 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440194.home.otenet.gr. [79.129.176.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5879d76sm101024775e9.24.2025.08.07.06.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 06:02:13 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 07 Aug 2025 16:02:05 +0300
Subject: [PATCH 2/2] MAINTAINERS: add Rust docs to qemu-rust entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-rust-docs-add-128bit-mention-v1-2-1d8a1ece3a51@linaro.org>
References: <20250807-rust-docs-add-128bit-mention-v1-0-1d8a1ece3a51@linaro.org>
In-Reply-To: <20250807-rust-docs-add-128bit-mention-v1-0-1d8a1ece3a51@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=579;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=X5ZX/frCh80u0CQ6fP9JF3ZzC+6AFM2kDDf7/GfQP+8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9sS1BTVWJBQnh2WlZyVTkySEU4blk4TlRnc2V0CmxENldDZUVsZWhqcnNGQm45
 aUtKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUpTajBnQUt
 DUkIzS2Nkd2YzNEowRDR4RC85eXh5UVhzZ2RtcVZORGhhWm9wSUw0S2ZrYXNDUVlQaDVsYXhpWg
 ovYTJGVVBDUjBQRHFxK3ZuSkRtT0lBdHZaNUdaeWpFd2NBUkR2bmdHU21sOURhVDJBSTlNWUVsV
 3hISjNDaUE2Cmc1czBoanJLQkUwVnErVGJ0M0RsY3I4MVNIai85a1oxQnpWdzZBbFM0UW85UkFu
 V1B5QWdQZVNaVnBEeXduU3QKbElvNll2VVVtUTg2djVrMzF1MlBhZXUreS80QmZlNWR6aWxDdTV
 JMnMzNTBXaUtnbXRDbWtGWnNrYVJtOFlTNAo2eTg2N3E1a2lkK2wzQnUwRmppaFg4dTJnM3ZwbD
 JJS2kyMXladVpWcWhpYW96eFVpRHFRVGQ4WFRLN3ZsTzl2CkFhK2NPOUtLUFRMSTBVK1NUbjFVa
 CtkcFVmbk1nYXYybktzQVkyalpVRlF1N09TTDlqcEtqeklKcDlFZVVwRjAKMmVUK0hLVDZNbW8x
 SG0zQUUvUHI3cllGdXlLcUZWeDMvQkU2SEUxNk9Pa3VBMzM5L3dkREMvNCsxREQ3N3VTMwpJVTA
 1NmY0bHg3MTJPYUZuSUZlS0wrckZCWjFHZEZDb3BTV1VodE1iQXJtUUZUZGhLbW56dFdLdUNGa0
 ZMRmM4CjdSblA2Tkd1MURGcXZDYlNpb3gyWG9RRml1S1JEc05lZ3RhNzhBd2pMYWh0RWFsNjEwY
 lNvemxsUVA3UnFFQ3YKMXNVcU9ZMHd4UnYyRndXV29nY1c5T2tPR0k2ZGI2UVZTa0FscTBUWG15
 blBVSEVmUjFLZVNvT1AxSnVxK1gxQwpmRGNCVEMrOWg5QjluRWNqcFFRQUxGYXYzMmNXUm5NcFh
 jYmRiOURHSkZMdHc5b0pWeWMxSmRVZ1dFMVBoS2JYCnV1UlFaQT09Cj1PTzkyCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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

Cc qemu-rust list when touching developer Rust docs

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed76213e3a204bbbf3a83137f1487e4b65..82011bb097fccac3dcc9df46cdb15afa41c44cbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3519,6 +3519,7 @@ Rust-related patches CC here
 L: qemu-rust@nongnu.org
 F: tests/docker/test-rust
 F: rust/
+F: docs/devel/rust.rst
 
 SLIRP
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>

-- 
2.47.2


