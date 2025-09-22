Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96646CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lj9-0002F5-Qi; Mon, 22 Sep 2025 14:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lgX-0006Ch-Er
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:51 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfW-00053J-7a
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:49 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2680cf68265so35249365ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567223; x=1759172023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IYbDL7ZzrPeJgVCiHhUdegByQ1ip3ofl4M+Y1UUBtM=;
 b=AAVi4i+w4rIcEfe/1j1A3byj26ZxRaafpJPbkwOdMIcezyIfIzpxy5+iNH7i/9cP4b
 lAH7J4JPEl8BM8yluuYluTdJMGckaJXwBusn4nfsvvGmv3Th4ReD1r2tBSuozyKLxTUw
 MVc38Vi1Twn2GAnH7OuS0Tt5KQ7rszFS7K39D64RGf67PlrtJT2CMd87WjWuRVxyXEuQ
 BwV6QxJ9NHz2x6JOQmVKUKqv7xlC5kDwZnx7BTzBxAp3mwadjesdCLiFDxNGwFzsHPzb
 6nkvCt/gmnYEmvz/1uYvs/Y9/SL0G6rEDN2cdFwuKy8RnPNmaSxRE005Q3Oy25t6L0Bf
 OaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567223; x=1759172023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IYbDL7ZzrPeJgVCiHhUdegByQ1ip3ofl4M+Y1UUBtM=;
 b=JxaF9HrumEbC5K0m51805QgEJO5Qe1rxoii4D5Z2rSIUY01yX6YtjYxg6U1dpMaGE4
 WAniQX02scwPdam3D9E9zip0B97Z/euH9B9wAlX1JgovTxGnYk3NJT6ckoExb54mAIsE
 WlpLjDetINvymk2pWTHOgPxI/Hoff9K9PI1bLhn9XwV6fVIdxPMsNHr/vqz9fq45L38V
 gc90vJw/WKB/2W7E0DfzCgBCS2+amy3SPFKHIQYcUphQgJVE8re33IYJQlJohxOIaP60
 ZwQAKyeclsR5SgDQZ4lG1TYofbKg/73HO5ohDwQltvJReWNSQfTfkuD1JN2WQFW6XTPw
 LWLQ==
X-Gm-Message-State: AOJu0YxNdcv7EFYttu8LtpTs0Drom+PzXvW4LLZNOp6aJxrXLXam14+m
 oplPeK04z02CbIq/+VeBE6WC52/PBXB7RwhlfqJJO+aBfroZgbNEZRkakI+a4Pdevei/ObJ7rQl
 4orQ5
X-Gm-Gg: ASbGncvpLAZggyOnA+Bc8b2S0TLy8UZNXt8db2JeopDBOcz+vZlr0uBqU5j2KxEJgt/
 V8Aqsv9KGG32v6vzIYq7iEw3khIjozgDfiO+rnUXhkDEnkKDdv5UWsl5TXey9T+l6wsiQqX/grp
 HdSenngjzED4tSsnhjF2RNjp1H6yxlEqOmzLQH2BPAyFOJiHkggdwl9vDbPLNkExAFHC3jcqg6w
 2W5yR/YXC/z1G03NatnLUg2r79CdBLqFtD4N5OsvC62UdJIDFSVS3lSF9SmJp/0Biv/5ToY02OY
 Z2X9p0yGIGstUOJtIXdLYXLj92yUZahNXjFeEaMGqCT4TMHxCfsfNpGRpmfmf4U39wtyFc+I8WO
 mPl56rOz4+k7zzP56mvXbO3DzpaFP
X-Google-Smtp-Source: AGHT+IEzf8Wiy2NKCx8H9SnpkzFth9aV71brdSnnU9dz0tHrG9Iw50zCTN79jt3ognF3uHYY31PaNQ==
X-Received: by 2002:a17:903:32ca:b0:26c:3e5d:43ba with SMTP id
 d9443c01a7336-26c3e5d47bcmr179749685ad.17.1758567223171; 
 Mon, 22 Sep 2025 11:53:43 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 73/76] linux-user/aarch64: Enable GCS in HWCAP
Date: Mon, 22 Sep 2025 11:49:21 -0700
Message-ID: <20250922184924.2754205-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 77d03b50e1..3af5a37776 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -169,6 +169,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
     GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
+    GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
 
     return hwcaps;
 }
-- 
2.43.0


