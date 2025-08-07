Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC552C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 13:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk0GK-0002Cr-82; Thu, 07 Aug 2025 09:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uk0GD-00028N-9s
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:02:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uk0G9-0006tZ-Cv
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:02:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-454f428038eso8157425e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754571734; x=1755176534; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f//2yf583SEThhe/QDKnaLlWxecBSLAzEmutcOkTSD8=;
 b=mCQsTQZ7GSh92fGCxxfJuQJG+WiQ+erTqLf/5qoP5PNUH94XXFc/FkVW6eBnAwzz/0
 sEOcAYf4EgtUA0/gSx0e1dUqBwATlj2ewcl0I9WMgTsea/sCAKLYa5D2Hfcx/KBz98S6
 6PzumA3SlqKgE4M57CWYPPjuX3YCJIooo7SIHWMCN2XLiLt71oCBYv5N+uzisxyH/ZZx
 exERA8+IwXMFoN0jtJcS+HIjQh6VmzkvXuBuANmvhi8qDxQ3hFxSJikytcPTR6+6IsbJ
 f5Z2HWqQ6G5pD8gxzBzaK/LqZrJbV+k0nkOH5ozhG/fn/+owIUCRmqZXP8ZnK3F/vhTE
 0vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754571734; x=1755176534;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f//2yf583SEThhe/QDKnaLlWxecBSLAzEmutcOkTSD8=;
 b=X0rx8AaLBO94AS6o4XfN1zBWfapmGN+H6UWJg3ly1RshJgLEgqvli4NqXIU22TTvAI
 8VZ7QWglG2NrcVrr83uJSOGbBD3tk/5tcn6bAMZgymOQ/IykllG3a7pfXFuoPC5iB1S0
 ooqGZ9chDYYGA8RWM7kNxhtLCtip9g7qB8H9V8c9EQIIIKyHXn17Psc23hhjqtUBZty8
 3GchV+ZG+d9jIRz0dCdD/4o6sny/d1y1aZExMJY6oX5Bu5ZJkxnj0220AT+SMpQP+nt4
 tg3XIweMgatyB84Am7RFJnBzXM2DfeYf2BwRSWk92UXi7kdRyLSclqEyB0zTk4Ed3VCQ
 IMKA==
X-Gm-Message-State: AOJu0YzytHuNhSoTafdHfDBdWFwcLeQfhBvkHSMmspmpDEUbaHKRyr87
 0UgIUGl3jcT2UgsMJZLCC7zJyCbJgsl2j8YtzoHhINQdxJSRJtg62NOKEE9+XpMsp/E=
X-Gm-Gg: ASbGncundDyB5VI9uxJ9IXi0VbbDhgqwdTEJx+Qdj74dNbw1VGAQys1OAPWbULeqgFm
 iEQSlvB807KNBu0xPEpjWeoZ6fOjdYUCaoWswTOj6T+4Ycctq+RCXvpHk/fhTJFO63bFLjMNAUU
 hxH0hp6IgNwQPBsOqkckA2CI+ALsuyDoPmZEM+iJ3vS6R2MAC5a5btNoHuJt/b9bxjkFmOmuXb5
 Eloz5IiohilK9ucFGmPSE6h23NW4iAG7KxkqV56EXifNs4PjaomfXdR8zvMNCJ7nl67k/GkyTrj
 rmjMopWCLIT8QcU6sQlRvDCENiHjHAPez0sdyqJXhoVvA9RSb/Ou5Wakxp9noaXpKQaa9FF25Pj
 z4FwkIhJOvqDrhoc++FgUaHJ7P4Ayw3DNUCcv5Z/OnYtpRbTa0FS189t8hQwJUqTe22PZ
X-Google-Smtp-Source: AGHT+IE5EzqzLgF/rXJ3VMGqW0FYoK9+DGS/z5EGwo2L/UyGBSZ0xjm+oQchDgbSpgBcIgFzqSuCrA==
X-Received: by 2002:a05:600c:1907:b0:456:2a9:f815 with SMTP id
 5b1f17b1804b1-459e7075ec1mr66695155e9.4.1754571733002; 
 Thu, 07 Aug 2025 06:02:13 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440194.home.otenet.gr. [79.129.176.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5879d76sm101024775e9.24.2025.08.07.06.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 06:02:12 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 07 Aug 2025 16:02:04 +0300
Subject: [PATCH 1/2] docs/devel/rust: Add mention of 128bit integers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-rust-docs-add-128bit-mention-v1-1-1d8a1ece3a51@linaro.org>
References: <20250807-rust-docs-add-128bit-mention-v1-0-1d8a1ece3a51@linaro.org>
In-Reply-To: <20250807-rust-docs-add-128bit-mention-v1-0-1d8a1ece3a51@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=857;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=s1N5r1fVGvE1POMGbkaaQ7oaC5GeKbgjxoWrG8Ko5q4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9sS1BTMmNlcC9PbEtuSkJzdlI0ejlPV3l5K3RBCkV4SHVwbmlLU3dIYWxWYnZP
 QUdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUpTajBnQUt
 DUkIzS2Nkd2YzNEowRmlpRUFDWTM2d3VPZ3hmd3NLaGZYTmFocWR1NjZJU2VycS9tbGRYbFFTbQ
 pPTXFteUthcTYrSk5xTXR5SjFHU3lDQXdYUENUaTRRT1hpQ2ZxYXdKbURUZ2gxNnhiQnVLWW1Kb
 0xvTlVNRGJFCkdZa2dTV0tBR3RjTCtkR21XVnAvMm5XZGFHL0VWcUs1eVZsLzVNRlhnT3poNTVL
 OERpVEZMVm5QWmZmRnc2TjMKODRkYURaUHNubmtKQzZQRjVJczlpcXpHWjdLcXArQVUwN0JNalR
 yNlZaaW1UVC9qNFlNZHQyV1p4dVh5NjhWRgpCS0ovTVdLM3pTaXRLMUFFUHJpRUhNWllmMVEzaD
 FMdmRKMFFUWUhRU2dhS3czTkFXendVWlk4Q0VlOFV1NUNwClZxTzRXQzJTVkZRNklRR2FQN3J2R
 DZWYmx4UGZneTJ0NVZGV0VGUUp6d0VIdHJJUGVaWjBISXgrTFdBTnYwdmEKWEl2NEJsMmorRlI5
 b2FmM2tzTW44TDBRcWFqREZZYlY1V3pvZDVJbjhtVXZ3cVZpd0JVQm83ZWxXVG9jREJzYQpmYUt
 QRGtyUHFGcjcvVGxIT3RGY2lEZXY5bGVyRWc4MTR1QWl6NWRLY2M1SEtLNW1ndnJmSDJJTVNVMU
 xFOFcvCkZueStabEtZbWU0MGhlT0pvUDB2SENTOHdLRkZiaG5DbTlIdzRCVDRkQnNCdkJockxMc
 mRXYk5GYmJ0OU9PNEYKdEN4cW9oWHJCUys0blNSWHBZZ1ZtdkN4ZEdCK1lXOGtudmtaUmRhMGgv
 RFhNc3IxUVJNMDdpZnFTQWthMlN0OQpER2FVWDBoSk1MeCtwQis1WU10NGt4NW1wZkRhN3VPYm1
 pblY1R1J6K1RJekhXVHNyVjR0ZmIzc3k2NzU0NFdTCnhNb0RNdz09Cj1weElLCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

FFI and 128bit integers are now stable in 1.89.0, add a mention in the
"missing" list.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 docs/devel/rust.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index b6737536c694fd54fd0d3204c0dd1145a9b0e973..91b1eab78df0e0e25baef746d378717bc8dedcd4 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -105,6 +105,8 @@ are missing:
   ``callbacks::FnCall``, but is still experimental.  ``ASSERT_IS_SOME``
   replaces it.
 
+* FFI support for 128-bit integers (`stable in 1.89.0 <https://blog.rust-lang.org/2025/08/07/Rust-1.89.0/#i128-and-u128-in-extern-c-functions>`_)
+
 __ https://github.com/rust-lang/rust/pull/125258
 
 QEMU also supports version 0.60.x of bindgen, which is missing option

-- 
2.47.2


