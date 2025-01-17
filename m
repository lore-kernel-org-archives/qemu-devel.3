Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B615C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfM3-0006SL-UO; Fri, 17 Jan 2025 00:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfM0-0006Dx-Cm
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:12 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLy-00060X-RQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:12 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21680814d42so27314365ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093429; x=1737698229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RKj9pkAQKgNTMuJh8LWZpMpqh2pwnc+FSCkX3QCrbU=;
 b=FzoXBwzG4yKmZ6owFn0qLa7WxhMhp9EAQrGK/HtsxwwR0NzrlgCJ8KgrdteZzg2JvF
 GxeZMszLTEVRRWfZ5/oMh/JqJ0CvCuttQiNosrMqLXmVJ77VYexLm/Ryyk6B4GSS02t9
 y9S+7G1iBgk+h3jnza0PzqiS9VOmIXDFmvQhO3rRs301gcpdDTKS5Y3Al6qOlHGF1bqY
 pT2lgd+UsZxIPITe/uFGlnEReKHz8ioyXg7yE6maYCKb+Fbfmek5IB/xMi0S0rna6yxi
 2z3YClXxpMV1DW0lnySUPEs1Umkq6yfelSZZz9W3ybgRFPTjXWmtl7W7hVoZeT6HACB+
 ckSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093429; x=1737698229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9RKj9pkAQKgNTMuJh8LWZpMpqh2pwnc+FSCkX3QCrbU=;
 b=EtuXAfnc8Eac+n+OHbuAarAcCn8VnjYwD/jabMyXamaKv9qrM5fmw4D9UjyBtUUBH6
 VS8kpUhaxHOwewsjOJkxE/l+frTfVAmWk/WA79iFcH0w82ESECL6zR5JUEV7JJxnuA/J
 YSQtRlkt1e7zYczi/iNydj808HXk2Z+J02cd3qXpkjAn+9kB/P9sixbzmobqOYdAU9e/
 c6pl/cjs0y3cx1q0QqrsAYy9yB31d6UEbLhmSyJUn8ueCDM6eqoX0SyEQGsEPKREYCns
 VYEfYrtG8AnfFiB4EmbEJkhU9M6c1PQZlSuOPFSn6imYUHG/B3H5DBgFQ5i5TcheCeHi
 l6hQ==
X-Gm-Message-State: AOJu0YxeMjdwN0X7fqulflotWrUTZ+tdvHRA58kaeuIZt6dmkBbEA5DB
 FA7exYPV8belsGHaXSV6AkSFbQo4vVav9LP7C5QDTqcXp+/LsB5zqt+Kcg==
X-Gm-Gg: ASbGncvtGM55OAkQGJOt2xgL033TgWuKX0IQceutMc63e7RWIkLEwlyjcFj7rX0AFSO
 n14OuBZ2IJMISKLPyLIfCUe0nh+F8EJDwnyRnKeSLXIyYuZ2l+/glaGRdHriEHHlLPp1uIaTloG
 HF1W7nBTBqas3uHVXu+jHNaxjktuys0qbD552u2+UID8ZRl+p2G8sF3/M8MZjMupeJIOZtST/VQ
 ZdUnBJegQ0qhmplUgHF4qymCydDWuvDZ5AmNPSgbew4oWyAbwR34dLtS9l/eQOIQB+kxj/FEGV5
 TRe5fwHoelqiJdBCIoFJqUP4ZdnGLUZPIt/KgHwZg0A+OM3mzoJ+GuoBe0NL
X-Google-Smtp-Source: AGHT+IEBf+DI/Fc3m9g+dSleaIaxiJwKDHwGzJ5lSXAIyuk9MIz4Pp5M9lsYJfRzmCiEL060EwY0+A==
X-Received: by 2002:a17:902:ce09:b0:216:2bd7:1c2e with SMTP id
 d9443c01a7336-21c3540acc8mr22561185ad.18.1737093429179; 
 Thu, 16 Jan 2025 21:57:09 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:08 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/50] target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
Date: Fri, 17 Jan 2025 15:55:22 +1000
Message-ID: <20250117055552.108376-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Tommy Wu <tommy.wu@sifive.com>

The boolean variable 'ext_smrnmi' is used to determine whether the
Smrnmi extension exists.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106054336.1878291-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index a36d3fada3..ee7c908710 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -129,6 +129,7 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_smrnmi;
     bool ext_ssnpm;
     bool ext_smnpm;
     bool ext_smmpm;
-- 
2.47.1


