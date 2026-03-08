Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A9EF55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8QX-0008Fu-NI; Sun, 08 Mar 2026 03:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8QM-0007Ud-6I
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:39 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8QK-0001s0-BY
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:37 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2be26d11b95so8540727eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954375; x=1773559175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WGIqVmVnYrVul4QZnYM5zBGsZzKNPp+Wzo4Tq3D/fo=;
 b=OCFDX6pQjJCFrb2RR4WmzWs+S/S1+y6dle6n1wEa8hi8MoQc21S76NcaBN/ZQFHU/Z
 +IVLlH7bptJQkPZqjy999qERorEUQQNMKU1QYwrarKPcZMUDs1AgIWVIKbP6sqz/kmt/
 yPR2wD+KERaJbwb3X4JWcaeP73b8V3a0VAf84E3p7uNzBloYTuE/5wKcktFGJjslNeZu
 FVK7FNhc5ZsYl9DL40dwAdsTUARrXcZT3n6cZ7SDIR3EOMmpg9IhhaRIX5zaJS9NEh47
 XTXU3VJm6w7o8kdS0w3GQU03arDOxHR/QSGOebqDVYqDMVbaMw2gw5QJsR+0aHWQjL+h
 GW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954375; x=1773559175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/WGIqVmVnYrVul4QZnYM5zBGsZzKNPp+Wzo4Tq3D/fo=;
 b=COB6iHE+fUBD438QfslZJkDQfHVvMIq/7t6wuYNmDKZMuaPTU0QUMa122RsOE50XoA
 2x0/FfGBafghiDwaIqQz6vw5Im0o6h2zHq4mmmcT/kXiywvN9l/MRBSRDFjb0w6nzr+T
 VLS0XDO3TUS3SuD/ZN44NomikvWh6jWPAv1iBP1FYJ5uFS+fvrRz+7q+QdTDhtBHmbed
 Sc89LlQSzujuTsArpuSfwKTi9GPloABoK1r+KM13QaWn8mhuKF95V1FKFhKAAgq2/UEK
 mzquE4FdJ396GwR4lhmriS+fq4/AO7Lu8RQkjtCmiQHbbsv41KUgHyIduP+4SlfGUfWt
 30mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrM1mNN8Gxqc0OltPimIZzW+N1QHVsSxYNKuusXJIRV6s0RDP6EVuv+Rsth2hqRIFVKgisGbSc/509@nongnu.org
X-Gm-Message-State: AOJu0YwPjZbbiT6eCnLhNyJkGbvCMoKYD/DJ6Siz96zMamVCEVH8Ovre
 A0GhpQyQRsOcptyT75AWJDOesLyVO+gexSFfR3akf3x0+aM6Uw7Y6B4V
X-Gm-Gg: ATEYQzwaGPNf7nhsKklDjb+CHVlwdX8ABK9GOsPwmEKoUG6KTa+sSKyZlWmDP6bQdeA
 xF0uae+jVwdNrXeSwMsroB+J0VjuhGOlOHvezs+poDxy8UWAAxZbZf26+5SylX+nSYkJYmgU5ls
 1LJ9G2OYhtxXBZ3cUEJ2TUcT0rfOKAGTZQ0WdOgRcIj3bo1/Hod7PSxCtnGqDbJIop51faMIJp9
 FiGFdtyH5hSpgSfRN8Qu8I4GU3f6lJt5sH/AbM5UA2onfL12Y21aTLeGfMQljw5SX9xwVUIf9rq
 z7IpKOo9O/1kJNUKPyKTmHMGz5A1uWvXzo4e9Sv9L3ifTiqc9o2dY4r6/Iq9Kf7wt7vvMnVCdSG
 eGEZyUp76hBbDYHjbphGySLPFH/4bJJX/lmbBo1DMZgOqN3PQ3MRlsKuyfcHlJpynmT1tihK3wI
 b6x6Zk7NFrPQEnee5IEDZgxOYtqBJc6Z3ggsURLHI6IskKZuwGKJvt1Zzv5PMb3taMoVm9rxy/p
 +0FNPRKh6DLuobo/tMWYAziVN0=
X-Received: by 2002:a05:7300:fd0e:b0:2be:53a:5f4 with SMTP id
 5a478bee46e88-2be4deac6f0mr3128572eec.9.1772954374927; 
 Sat, 07 Mar 2026 23:19:34 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:19:34 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 11/28] target/riscv: suppress itrigger TB state in Debug
 Mode
Date: Sun,  8 Mar 2026 15:17:14 +0800
Message-ID: <acba51005a230bea4ff25614026c79253ecf7e5f.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Do not expose the native itrigger translation-block state while
a hart is already in Debug Mode, because trigger matching is
architecturally disabled there.

Hiding the TB flag avoids stale itrigger state leaking into ROM
execution and keeps translated code aligned with the active
debug context.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/tcg/tcg-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4674ff3e3c..43d764fd59 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -180,7 +180,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
+    if (cpu->cfg.ext_sdtrig && !env->debug_mode && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
-- 
2.53.0


