Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C909C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1S-0005Zi-Lt; Sun, 04 May 2025 21:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0z-000440-3D
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:05 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0u-0002eJ-Nk
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:02 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso3060359b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409979; x=1747014779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E27VnLHwdjjgu7+qzkSpdD6sP1u8J5fzfB0GITxze0s=;
 b=OykUdVg2ae64oYOPVPbKQmMMyrFBnKe2irDCX+WZOd342lOHAQVyARUtXfJgVZXf3R
 xhcguqml9QrMPtlUKqm4qkACeDShDuD7tCnwhN8CKz1QqZTyEfy/IWCIL5N5rDaa+x16
 F5Dv00T5ujMnsPe/n9nDz2N+GL0+0emKPLTDagTXb/0SzzqqChZEcePVY6Y8Hzhl0bqr
 bZ1y7qJmXxug1VKnTw9aytX3EuJkZsMyVNt3nAvWw0kBSEt21PfZkHJFThFAxAF5tnu5
 fddRqGRZzfumagXLrUTvL7oe+gwGFEyoBstJVQgCZrMCwVUl7D1/9zpXTjLyLgh5PtXZ
 4ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409979; x=1747014779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E27VnLHwdjjgu7+qzkSpdD6sP1u8J5fzfB0GITxze0s=;
 b=n3fkKLadqfnMZ1g6+jhraEGspZdnSQLDaHdJq/3GkOCfldkaP9pwDJcBxFQvtr8e24
 PhLnne8nIHn9TJ8kCvcrCnYJSnscLerog75YFpySmUJ7iXpMFfnWDrokbaoPqcokH//7
 iBWfD6k3k1acY9xj5QtJLOckbscJDA0MrUkq8ussyI9TqbGwS84EOLz54jU/y8nlgFS7
 D3yeozqEoaBHXyKlePk2/cDpQM9VJWZBFtup/27xKMnlINrXvLsQRLThGRH5wVg9e4yD
 nLxiY2FyskjgG1hjikvF7ZoJLk+h9VECmG+QVE8zUH+QKy2ERRIJwzypOoBtMavajVgp
 t85g==
X-Gm-Message-State: AOJu0Yx1kFsP/E30JsSQeu8ZzMB/nyjU3CebG+7TMhmLlNzTGOoMaihx
 2kquskKMmMROrADclGmt0taZet8lpX3l3BlmWbeIC21QhvU9z1GbFKHT1Uo0xABGU09C4PNvmB+
 DqOc=
X-Gm-Gg: ASbGncuI6jhiFs4iKR038F8VjpH9icNcCocv1V9ozIs0l8U8l2jzchhmmgjvT0sft+K
 WbYwonarFyJVUJyIa7s4SgJ6xKpuGN1ncocHq+dGQFHg6GiqL8T3LQ1xagSgsMl4Jlfr80fthiL
 TuYaCXwSh7qwVlyv88MEFk/6b5QV6Bc3AdQgX3gB7DfuuGSgqLcpOVBUOQ0VwUIhUGP7tetmbzL
 htQYkxWLcQN+JaSFG77Qti3nCylEpNnT8Y3qKAG5So5POoZAAbC/0iEEFKQfKuhNIAJvpaOcRqV
 he3HNySpcuaQclJ0JjzfHYdja8nx4GjLG7ljGVD/
X-Google-Smtp-Source: AGHT+IEBqSWAZSrJB6FCEJYBOGMoQn9NjDs/eddpBPADMLAHWe8pda3zWyhyviTYa40vpwkWQJSf5g==
X-Received: by 2002:a05:6a00:440e:b0:73d:fdd9:a55 with SMTP id
 d2e1a72fcca58-74057beac3fmr17689934b3a.8.1746409979095; 
 Sun, 04 May 2025 18:52:59 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 33/48] target/arm/ptw: compile file once (system)
Date: Sun,  4 May 2025 18:52:08 -0700
Message-ID: <20250505015223.3895275-34-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0327b6f5b..151184da71c 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -17,7 +17,6 @@ arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
-  'ptw.c',
 ))
 
 arm_user_ss = ss.source_set()
@@ -40,6 +39,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'ptw.c',
   'vfp_fpscr.c',
 ))
 
-- 
2.47.2


