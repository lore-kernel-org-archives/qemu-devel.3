Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF95C021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 02:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjUgi-00051I-6Q; Sat, 15 Feb 2025 21:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjUgc-00050C-Qq
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 21:47:15 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjUgb-0002CU-2c
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 21:47:14 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fc11834404so4429121a91.0
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 18:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739674031; x=1740278831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mjBDQgKSnPpdtaSu85xia3xVzxjiSK0IUYjLZJGHYqM=;
 b=t+/pCjnD4LtaJ34JjgWCEi9YuG94mQOLlCUwhHQQ6ld412731PdJVW2eJX11FnyoE8
 /AVz0MFCy2TUPhkyfXD5KmPhgHEjgD39EpCM2eEDZPv65iqgL+8z8nh4fVkWfk+jCM/5
 xOywBkqsj1imj5yE3Wzr4TXdGYdisedsBR+vYMBfj4Z9GFTx6sgVNzbSutDht4BxS5+g
 il3nvlqXDpar1WkYFo3Oz3vnsyFQZs0iiVMpV6mI2X1P9FdIOMmSzLoU4YJDYuilpBzf
 zi0zXA6VNoFj7Lb/dTpWj/cCFw+Pn+UiBDmJuTfoa6x3+EiEaiAHXpOZhQG4QFYwNGY0
 fuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739674031; x=1740278831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mjBDQgKSnPpdtaSu85xia3xVzxjiSK0IUYjLZJGHYqM=;
 b=YtOA4E1K7R/t8E7IVbTMN6MewMpHS8sUBS2n7SzqlxxD1RkiW1x0gvZ51h978n6fN2
 NGWJ0aJLRXv8BzoMfBQqLwQ8TsoYfMy9mXAhFFsKZ/ilBN3VamzgllFjRfUB/FhIhV4I
 qgt5Dggevg0ZAKKi9CghKaIt2BjgsVV7y5zP7UKby1f3ttzwy2x1XaBg/7v6rWl6EXeJ
 8SJ/+i5gvLN2/a91sFpwi/UnknOKWBL39XldTMWB8wdhT2equYcapYxZBDagfv78yIsY
 sXc0sSlpNAouNkodlLKq8PJeRii1RI++wVoK8ESJasUOiA7mYP3cuQ81YLvdCIC/Q09a
 gNCg==
X-Gm-Message-State: AOJu0YzTdlWcgdsu32KS1xNw63O1xYd3llp42+jxn5++tZFu1KJf0kGv
 qwDUB28PnaB+iobAAAiRNNBxGZj2tueoLM4KA6HdMzt5iYWMvfLiG7ONNkYSau7qwQwbawcM7g/
 A
X-Gm-Gg: ASbGncuApyUCcdLhCr87zrtetxCn0fvWLYszWNGdKworukpowADJGNpFy3KRNfdb4rr
 4gbAZ21tJYLCQQSh+5nIxUWxQCy8AaIP3yoqR1wbnvf+MvhREf+awLtZ4CRgOqR8LezRDMzMtoe
 rmnjY5RDD9d84GKe36pX/qZf7DH1JOV/xkq/ln6elQ/XrCimGIOEuMCqTYOYmyFFVcqFG5E7Hg8
 vZYC9BSYhXjUIh8XOEZTtFe7iCty1ePU0ziwi796abxPdsXmopAPMQ2K7vUuzsLKtx0CRzmut7j
 Ew011y90HO6r78QfyMSHHNqsBCpAdi5PmAagT9PVt0kDYdg=
X-Google-Smtp-Source: AGHT+IHr6t0biU24iwQ4g+Ct2I3mJ+vv//asa8xbubujrIKZd7yh5bRxsCt3OmQjP0USawd25Lw9aw==
X-Received: by 2002:a17:90b:1b46:b0:2ee:edae:780 with SMTP id
 98e67ed59e1d1-2fc40f22bd3mr7294803a91.15.1739674031012; 
 Sat, 15 Feb 2025 18:47:11 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf9ab0233sm7701710a91.44.2025.02.15.18.47.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 18:47:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] tcg: minor cleanups
Date: Sat, 15 Feb 2025 18:47:07 -0800
Message-ID: <20250216024709.2624325-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Two minor patches extracted from a larger set.

r~

Richard Henderson (2):
  tcg/i386: Use tcg_{high,unsigned}_cond in tcg_out_brcond2
  tcg: Remove TCG_TARGET_HAS_{br,set}cond2 from riscv and loongarch64

 tcg/loongarch64/tcg-target-has.h |  2 -
 tcg/riscv/tcg-target-has.h       |  2 -
 tcg/i386/tcg-target.c.inc        | 65 ++++----------------------------
 3 files changed, 8 insertions(+), 61 deletions(-)

-- 
2.43.0


