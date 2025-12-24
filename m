Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D87E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRZk-00075h-8P; Wed, 24 Dec 2025 11:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRZH-0006yY-PM
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:18:33 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRZG-0002Ez-7R
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:18:31 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42fb3801f7eso3277603f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593108; x=1767197908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wU31SR/JT4eTFC/HWfl2NIM8RsVwLMoHP1xZxIQHUvk=;
 b=mS35EOEcpPUQIiUwZVhVXR56SO47D4yGphMpFZyCDv5Gm+OyN3xlO4uOpJwpJcyCXr
 h+aX2ywh5+pRDmnHrev3Mz+4gHJrELPKtpytKRrRZg9OxzGQrd2/t07qHiUcPhnXuA27
 36anifoZZxfFPcoBUJEHunF0hdnI98zTpCfIc8XNgyIkyjcAXwO1nThLMdvi4NQQ85t7
 TBfiwgNhLGDbcgq28f8yUq4fyGWCdoB7AilliJkFpBUtkZKccTohRK5M++yF3WgJV7zf
 37AIjKxcRLJuBKRXUhpQt+kQ7+HCWtcahPc0hPF0S3SYIxFasaa3ke3V9u2SKyof6Jeu
 2gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593108; x=1767197908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wU31SR/JT4eTFC/HWfl2NIM8RsVwLMoHP1xZxIQHUvk=;
 b=Okg8BmCVZGRzRSpddNE+PgseYxx0veY3UQdhenpuca/Df7AVDyVAL1O7bgu2Bd70mT
 f5XmN3MgCr7nohvFyV03b4Xz5QiJu7aoqAWuEeDyW8UIPQmCg/xKO8T45jAWwfMare1h
 YGYTSaa4jpgfHuXDLflbFeiUvgJ85VlcpBwgF2LCD/iMx7BLMhQ39osz1R1zbhgVmVGi
 /JCF8hxzQjC5jN07rwhbY4CbAKHREbGab+kUH4A9wlNT53YnMW8bvKnlfA8f3AdYanrd
 9/Cv/0xgIfMzPcVzmb6CubLAzAv3NhWu7H+mEVWsYk7qN3WgzUDsvbpleEgbkm8sWUbk
 57NQ==
X-Gm-Message-State: AOJu0YyJ6VU2oBB7Lgdbc40kyrvOPg88376KaJlQhE26GheX9iT1yIiG
 CJpcIK9GX5cbr3dFuiJ6DyM4m7T6F7iv03A6SMG/PLZL7vORWD6pL6aeiHnc06iyYiUwxNdYohi
 iAN65RRs=
X-Gm-Gg: AY/fxX5k4baEy2NfI5UlD3IVrd5ffqAX4CAPb8T2R0VF3zeSjenqsciKUEWPa91x7kN
 1sOC3LPJiji/7pcSO+rtocQwX8gmCeh+02HQ6D+OaHxl9NCAREyEPnxh88xjyAe1Tmzf83OXysB
 62ItjQtjmVMlGDSOmLJ3a6Lbxdgn1ZfK/KYYeCexo4sDIKZoguPhzSrmTLFG5apNPuySms5iZ8c
 GPXuKGDK3x9zqB1NEp2okU7wQc2kV4TxtKSb318lch0oq9b0JCd4OczT10lovnU+ujwxUTynv+f
 KD+I7MAmZD9ZH8/J+rLbMw52jaoa4lZkfrKUJvDQPxdzI6dCtFB+eqE7lPQQWPs+Zz6b9F4d9mw
 VaHzQbyxGz90VakPmkaPUJQ2ZXSdQyh7imd1xxwnpH+GZj5v89Pi2xw+OJWRUsJyXuoFFqPTroD
 TjzhmtaTp2ZmHeL2Vp/G+ypNjtDhFe6Swf/dZEeI2tjnZVx1LmLMLmCEA=
X-Google-Smtp-Source: AGHT+IEr6l0XvfP2UHWQupi22/0TCd31tLHgkK6WkEpEkTk93kh9tQCMsCw4r1zp6ZdUQ9UOfugmFw==
X-Received: by 2002:a05:6000:178d:b0:431:384:15d2 with SMTP id
 ffacd0b85a97d-4324e506bcemr22794782f8f.53.1766593108153; 
 Wed, 24 Dec 2025 08:18:28 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1b1sm34678933f8f.3.2025.12.24.08.18.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:18:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jia Liu <proljc@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] target/openrisc: Use explicit big-endian LD/ST API
Date: Wed, 24 Dec 2025 17:18:02 +0100
Message-ID: <20251224161804.90064-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161804.90064-1-philmd@linaro.org>
References: <20251224161804.90064-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

The OpenRISC architecture uses big endianness. Directly
use the big-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/openrisc/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index 45bba80d878..ca1592c6200 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -50,7 +50,7 @@ int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUOpenRISCState *env = cpu_env(cs);
     uint32_t tmp;
 
-    tmp = ldl_p(mem_buf);
+    tmp = ldl_be_p(mem_buf);
 
     if (n < 32) {
         cpu_set_gpr(env, n, tmp);
-- 
2.52.0


