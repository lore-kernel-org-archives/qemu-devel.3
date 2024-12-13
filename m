Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D051DE77186
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB2I-0003An-IL; Fri, 13 Dec 2024 14:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1r-0002WK-2d
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:57 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1o-0006Yq-CI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:46 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71e1d6c7738so1117978a34.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116921; x=1734721721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKm04qysg/gEgbm4vurn75ARW08p/MAYicuTqcRbj08=;
 b=StpMa9rJDZms0fqTJSqcDhdfeCIJoHKZ6dKkvjJEw80fEF4v4zcS5yGJIh4oNv+BLS
 Dy5q7iiSVIhkdLeZ/Nd49V0sMzmstXFQgAMvIbJYujiJrTkA8iPCQM1/WFXtcWazrLFt
 8EIN8Ajo6BKPsf/PA8u8Oe5wwrKKpY0L6lZ9p9kXETcbMinefXb4yDTWHLI1YtwZBXp1
 0DyN4Osdk9RKo//SeJxHyCpUkVFhNbBPEbTun8KE7W687NqdFsKBpbdNegFkVaN8rWSA
 89+f9mD/3LsTWD83+3pIFOJ5nYi7zvvuNU3qTnY4Q55k0eAPEbwnykeW9ARcapI4eJzm
 tp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116921; x=1734721721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JKm04qysg/gEgbm4vurn75ARW08p/MAYicuTqcRbj08=;
 b=YKQCKH3b2fB3qDKy64NVeLyucE45X6NVxQMXurz26o5ym9sCyJMiigf0NMLTvFxhHD
 b1MMaTA4IEIsppza2YouHLr4llCCfzwJHQJYILGwnov2hpWWtToPIbKtxXJoqF8+IOLP
 bDu1UlGdC/CIew+XvLm7B0HpYeNaM2zq/IwiWw+ZtTLwBQuBlocxhc8zMRqIDZyaNSiZ
 /bHzuUQADj3/IAqMqqxDvZfyXbMblgSeYJy8UITOZUXT2D7LjOEvGr8XkinT9ZBqO1Jy
 BXsXzIbAZ8LfVevGfD3L8PiO+aId5QIyRI3ktb5u11yWTK0UzzomywpKusnxqmYbq2vB
 vrRQ==
X-Gm-Message-State: AOJu0YwXEMpT7PmBSgnRb3eqf9hddP1PdOIsYjhbVRR2boDg5x7EHvmf
 SRd17hijqofgkuyTT+wdG39dthtW1zICVC7E+h3YivpuWEcx8k8VbtGA0C3F9V22fwvAE8xooGF
 t9K6IW/P4
X-Gm-Gg: ASbGnctrkB8HyRjQthqNLgAqBb41R8F4wa67CZ/jiw2/2bsmawmefjo2kA/5rAX6Pnn
 PcP8l5Cbxza/KgJI26d7oK/sL/MKmxn50hOJlxkQ8bXm2MgbxdUbok90eCeySGviL9heIC20MDv
 rPhdWzxLmM9dqWKxAvIuXHwpmyj0VXN0qZqEAPocaVRtVNDkhMbfIjA8vXa7ynsFi9OV51+G5bX
 tJJywHaZqkEBK1cfzN9BcjYJjy0jqox38xU+gEnUqyawZpkby6v54N5CjQIcK3G
X-Google-Smtp-Source: AGHT+IEXm24ToGc6IqeKoxLAgKPqwB0T7wRd1P5z7PkcgO1t3mvypyaI6PTRDRjo/onweT80OBoifQ==
X-Received: by 2002:a05:6830:6e09:b0:71d:eb02:baed with SMTP id
 46e09a7af769-71e3b8576b6mr2256363a34.8.1734116921476; 
 Fri, 13 Dec 2024 11:08:41 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 10/71] target/sparc: Constify all Property and PropertyInfo
Date: Fri, 13 Dec 2024 13:06:44 -0600
Message-ID: <20241213190750.2513964-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 284df950e0..8f494c286a 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -874,14 +874,14 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
     cpu->env.def.nwindows = value;
 }
 
-static PropertyInfo qdev_prop_nwindows = {
+static const PropertyInfo qdev_prop_nwindows = {
     .name  = "int",
     .get   = sparc_get_nwindows,
     .set   = sparc_set_nwindows,
 };
 
 /* This must match feature_name[]. */
-static Property sparc_cpu_properties[] = {
+static const Property sparc_cpu_properties[] = {
     DEFINE_PROP_BIT("float128", SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_FLOAT128, false),
 #ifdef TARGET_SPARC64
-- 
2.43.0


