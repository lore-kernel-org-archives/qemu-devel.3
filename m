Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EC1D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfSS-0007YF-0a; Fri, 19 Dec 2025 13:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfSP-0007Y7-Si
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:44:05 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfSO-0001Qu-Do
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:44:05 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso18634315e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766169842; x=1766774642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7V8qg/y3aHUm0EegbN49/SRMFNCcT+Po5/GtkUaJokw=;
 b=PYE0SorZ3OtSaYaea04By5dHKgWZXO5ouBnJLFKwsO4Lq5lyWOO9U6rxFoLVOc83qI
 YvTGk3pWwm7KPzKVxYWEe1JNxhE57EcQKeygXlUO/ywkTcqwtaccIBzHllR5N9o8oSm3
 6aRB3rWoolX8odA6nmwtpfOv0c+LwT8WdC8jQ37RY9xN7SUFb7rqlVnGAT6NwqgzC8qI
 RREpsBqdQUh4LyXh/20D6lp4MYA6HOfx+HHKs2e5W1cmUYeXX9TJQ3uHWrpRrhc4ZjMV
 MC71itEOSNAoyBK/nBUrn8fvJeqgZE8++4IsQjKNCJIxVMKWOkI5e5/wBAmQOXedi9VR
 e6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766169842; x=1766774642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7V8qg/y3aHUm0EegbN49/SRMFNCcT+Po5/GtkUaJokw=;
 b=MeepQj9RpkhoQhANm9LBiIAk4XvvuS8+MzABegb7QMceMMHuUCYhYHj07Mwuqxi7UP
 bjXyYe6mJV0BPQBZpT09UWRpKiMJnlAUomjUL6nsEZrwkcJ02DGLCn5/52KsRymtzZNa
 cpjJgx6kL3oPgNTRys0kvObDQR+dXYsRWE+HOmyqkdLqeJO0y1juIsnjMWiF8uQPsWo3
 Py2eCgo8nGYnUgiJDwo8nwUR3Y9DxNacykCiDzCnj5CS26kFus+VXouCb2wRs198Dia0
 Ulg6o5Lscsu3KUuI7ytNeR8XRPQFzXbQnFuZGqxtjcoOMmVLMI2YALU7O0fXPnsqU7Qt
 iRLg==
X-Gm-Message-State: AOJu0Yy2uhCKHiwgIXc3w77phAYQKK9bGGr/HkE8IkNUvyt231nhAZ1c
 I1xvoMse/s9dFognQSZr9U2lw3oNxlFQ+9GORyGw9DGUSlzmUGGbtWPEkmAzy85muzShpMu6diZ
 EKhGiliU=
X-Gm-Gg: AY/fxX7VIz4KlTbrWMKnCxnKwB1l1xvFFQ19DBnZjQK2l8GuODs7kGLCXFOYlIr6mkV
 4cVRZiTiZnbOgFGq9PTGr8aGB+m6fk819OPNd/lYHRY9dHN13wKTtwkmnYA+EVOSk75iYwo9KB0
 Rve9SkW8yNew9lt9FPsgAfM5LUWEPhFwfuO8i2+dRXjS/EMBu5qrBhzECMvz8/QRzuxeYufk2sP
 ONuWhisH2AKpOimx/r5Vm5eU2I7t7yBIFpX7GYP9HY2ut3A9Jxlboon9xTlF2O+OjVHPqd9P+La
 zqh+SHKEjQwxnqPbLuYQf6W4rnQ6j/fNG6sXgCTe6OmHHk3d556T1vzmFkJRhCvnpGdsnkDv1np
 yfbfSIcfG3J0rNYwvTwUAOXvJbXBLvoWpU2VB8m5mcXhraTNTPK4nSaze76CmNpQJh4k9lHApVh
 Zcgprk+Oon/WMYNV9iVz2P9MOv44ZBs2rMrAvoVzbjr236YnRmXUCT8pv/9/5H
X-Google-Smtp-Source: AGHT+IH4RJTUgGy1B5Kg4bqoILeeLim+19LgPjD/m/2A3Tqnhqa4c+lz6uPXLwosOfDmuaBYHot+Mw==
X-Received: by 2002:a05:600c:3504:b0:479:1a09:1c4a with SMTP id
 5b1f17b1804b1-47d195a50ecmr35905085e9.31.1766169842396; 
 Fri, 19 Dec 2025 10:44:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279c5f8sm102868635e9.9.2025.12.19.10.44.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:44:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/hexagon: Use little-endian variant of
 cpu_ld/st_data*()
Date: Fri, 19 Dec 2025 19:43:44 +0100
Message-ID: <20251219184345.96786-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219184345.96786-1-philmd@linaro.org>
References: <20251219184345.96786-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

We only build the Hexagon target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=hexagon; \
    end=be; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/op_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index e2e80ca7efa..08db1e9c56b 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -77,13 +77,13 @@ static void commit_store(CPUHexagonState *env, int slot_num, uintptr_t ra)
         cpu_stb_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 2:
-        cpu_stw_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
+        cpu_stw_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 4:
-        cpu_stl_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
+        cpu_stl_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 8:
-        cpu_stq_data_ra(env, va, env->mem_log_stores[slot_num].data64, ra);
+        cpu_stq_le_data_ra(env, va, env->mem_log_stores[slot_num].data64, ra);
         break;
     default:
         g_assert_not_reached();
-- 
2.52.0


