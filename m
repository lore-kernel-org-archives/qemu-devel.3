Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBFBC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSu-0001q9-HI; Fri, 02 Feb 2024 00:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSr-0001gH-Gv
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:49 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSp-000230-Bx
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:49 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6dddf4fc85dso1354927b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853106; x=1707457906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMDUR8YTjAtFg0favVwCF9fiRHHGxe41Pc5h5Qu3z9s=;
 b=gXixLQXqSO7rcz5ExIWeC6rEiB5vJJqG/j2KOTBX0eth7PjvpIV5zt41TxK0WM+BCt
 TjXTi+oWAdUlN4tYeog65Ls7UUNkjzHJsY/leVOV4OPv6LYwswMViobEJjiy4dXXVroF
 e3WGBiQXyoJ7s9UeVd4kCN0DoJhuMrlRhHg8sO0c8FcQRHUGWBC4XUbJ6NBtONiGiqD/
 3+u5MK7uwGlY0mGDno+ibNboZYBQ9WZyGfvOZlJLC7mNP8KumyDCL7QmF1hpqI+pHp6n
 HC7eo5kWgprNdKsvjiT2bqvim0bKzztMYGxhw+cMncUBVQ6f36KM+IuCaoqVXkGDstHa
 wbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853106; x=1707457906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMDUR8YTjAtFg0favVwCF9fiRHHGxe41Pc5h5Qu3z9s=;
 b=hephT0qJ8rCqe5xcISXjvcRJtR0uTXS2SCFQ0EDcFBNyr5sAK/wJUPFJwRZYXPxzBY
 VWAoV/RWjSs86RYujaNTuPy2vcVB63jRFE+lJelwWe73jcHs2L4YvbbSzK6gqB8eMgsp
 PkFFUGXIOGyxzJaqZYRpC1hRNnUvPrBluRmydlRK7P9zEOz2hK3fHL6R5ReKkFWeIe4Q
 E5hNxug77jgEeIyKFrrlhgwopfAV3p7znT18FcVGL9JLZQN6N1FILuXUlOfVfIdErnhG
 qSCmMGQWClhncDKWibDA94fNKIdSfFXKgotdHWRvcAmn3H4Oe7i4r31xc5Bxb0WEFXC/
 V0vA==
X-Gm-Message-State: AOJu0Yw6Rf2clndkuULByHRYJ1VEBUBHwnMRpTi+LFlrNpyrvi0AqmPx
 2SHKQh/HLoc9w3R/ozLHsEdI0oI1FFPlEGZs/GUXR02atjDT30BT6jWLoVDvtNEk4HPIY6t0hGE
 mLeQ=
X-Google-Smtp-Source: AGHT+IH9UsEV6xL9Rdp0pgC0XnurkbuxHRTyOC1RMTPIPi8Bdzex8eFd6ObN+ngwpD/ogSYYuPPw5g==
X-Received: by 2002:a05:6a00:b55:b0:6dd:8522:5005 with SMTP id
 p21-20020a056a000b5500b006dd85225005mr1968086pfo.2.1706853106006; 
 Thu, 01 Feb 2024 21:51:46 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/57] target/tricore: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:50:09 +1000
Message-Id: <20240202055036.684176-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index e6d91c74b5..74e8a22b86 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -89,6 +89,11 @@ static bool tricore_cpu_has_work(CPUState *cs)
     return true;
 }
 
+static int tricore_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return 0;
+}
+
 static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -194,6 +199,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
     cc->class_by_name = tricore_cpu_class_by_name;
     cc->has_work = tricore_cpu_has_work;
+    cc->mmu_index = tricore_cpu_mmu_index;
 
     cc->gdb_read_register = tricore_cpu_gdb_read_register;
     cc->gdb_write_register = tricore_cpu_gdb_write_register;
-- 
2.34.1


