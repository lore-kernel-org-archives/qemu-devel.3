Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F803E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Yg-000451-9g; Fri, 13 Dec 2024 12:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y1-0008HU-SZ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:57 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xx-0001jx-TK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:53 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361a50e337so14511005e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111228; x=1734716028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0Sy7P0n6dA4Q78sOSEQL1CmMwGaZp6w4fKZORHOrLdc=;
 b=hFvQV3OoOFvXdEm6204VY/NKuKREf7MzB8uSFhOwVtGBloeIARhCLnl4qpN77+aOTs
 u2xqDL+KqCt9mlnTDp7rZ/BY13vIhQpk93wk5P/ik3wFpxnAFv5KT1U+aTjqOZPl11hV
 y/KZNGe05DjQGjz/zJvNvs996lcqWj0xyJXoxogqhErZ9vNABZSJroRlm/q2anLUIQG2
 ZlQt+qlvoX4j4BauAFR+KwE7yydb58RMp9WYVJCAOpEb3VU7Bcb2OUBnuWVysIHts3K2
 W6gg3SO1TecCC9N6JfQLxK55ovJL1nwb60s5IF5cV425nUrsNw2bmLarXpkF4BMzYjba
 402A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111228; x=1734716028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Sy7P0n6dA4Q78sOSEQL1CmMwGaZp6w4fKZORHOrLdc=;
 b=wW06+8nT91GjaufuF0LQRKhoA3iD9FOy2GbDOr1pfGDvNV+YMY6YEPqYH8h2vTJmTN
 Rqb4wvpmNGPBfalxH+vS5jdkQeMxcf2hdzuJnpyPor+4ytgdut6+pUQL7iWGDnyqNEeT
 RN+GYBY6sQHt996/VIY9zaZW5cMxKxJxf1prfbfZ3FLnGbU9d1xrG+Cp/M5eV0bn/jgC
 YP+NcV/g6wt9JKXUSvjjHcofyF7ilFByZ7fo6VDRfPdFeWCixUsYkHFIV+OpVrYn9P7a
 Q5CjtFzfwsZw3/mSnoywYW/efDn+7NWs4rTlI0S7BNkCyVt2SwooXrfS0XOnNprNpBjv
 CiEg==
X-Gm-Message-State: AOJu0Yyl++PSqWq4EsWEeB8MNS1mvmW4GXOq9V4NN6nWPzLtSndhTfC9
 mhc0DgB+lHRmHLL19NA0hKJ0w1LQ0cxOy3Rtf7erK74pCidUZqkrGOnecJtJQp8F8IIhgfOw7Wb
 f
X-Gm-Gg: ASbGncv7w69oSlm//zgzR9cHAWYHzVQFoTNj0Tr/WY+pHpueXWH3TpYioVxXh43TVhF
 eDgez95or8OlweAfgvqQBtAYTVMDUS45pVdJ1U3sy6lxTpBhlUV/tPEA1rDNcRKUvsB++UeBBd3
 V4KAw/YDt8l8u/lYIpCUd+4XxNutN78FDGa2JGCNhv1LnJongDf2njbBGaLTrFSA+12gjvSpa2K
 ppNxHn0B9swSLWg9lrL9VgfPfsQZbrgQI74rLo11zrVBvZpNW/k25PBisO33g==
X-Google-Smtp-Source: AGHT+IHpLZJjEBwF7gRDanGj7TJ3aFrcpLVwFS6fVxV9CRs2+FtBc3EC6/Sal+4CZFS4xHLznkhWxw==
X-Received: by 2002:a05:600c:468b:b0:434:9f81:76d5 with SMTP id
 5b1f17b1804b1-4362aaa9a4emr24566445e9.22.1734111228128; 
 Fri, 13 Dec 2024 09:33:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 72/85] docs/system/arm/fby35: document execute-in-place property
Date: Fri, 13 Dec 2024 17:32:16 +0000
Message-Id: <20241213173229.3308926-73-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20241206192254.3889131-3-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/fby35.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
index bf6da6baa2a..e19274e75c8 100644
--- a/docs/system/arm/fby35.rst
+++ b/docs/system/arm/fby35.rst
@@ -45,3 +45,8 @@ process starts.
     $ screen /dev/tty0 # In a separate TMUX pane, terminal window, etc.
     $ screen /dev/tty1
     $ (qemu) c		   # Start the boot process once screen is setup.
+
+This machine model supports emulation of the boot from the CE0 flash device by
+setting option ``execute-in-place``. When using this option, the CPU fetches
+instructions to execute by reading CE0 and not from a preloaded ROM
+initialized at machine init time. As a result, execution will be slower.
-- 
2.34.1


