Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BF4CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 13:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNsLZ-00037C-EE; Fri, 15 May 2026 09:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNsLS-000367-AM
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:12:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNsLQ-000772-Pn
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:12:50 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-459bf19e87bso3500938f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778850767; x=1779455567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WheMXiVqmit8mEymN0nlA0kDJYvTtD1k939PyknoS0E=;
 b=bGcZuNpWBOSIqDhUPNHDX6erHAWryJPs4Ab+XvCbpn8TJ5Ltx3BR43hzQiA17WkGLU
 YjSfM4MgBsEAWJVVwVLQ33VF+tYNMRKys+o3CzNhup2JNxvQ3gHX4E+YGaiuZ+T3spGq
 6CiutanRv78K0rE+mqwx0NL0THoG5D8AhcZcdtAG7ciyxyIk4+gYFS3h7Tk1J5qint87
 Kgdq0bSOOY5LPtFXmNn0YZA3ILi8brafJHjPPHRICvFpMfmpDnSrFSqsgzTIegJllfGZ
 02XbLdiYjc1fe53DB4oRgUSjCUfM37JL679nRKNAz0wTYaAs8d1T1EvYP3aM9qfiktgE
 1WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850767; x=1779455567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WheMXiVqmit8mEymN0nlA0kDJYvTtD1k939PyknoS0E=;
 b=W4UbdupDm0W7AbsldzKkhlgbdN2/ybM1VLlPebEaBskNKv4+ONCszi0PzVUXDEJ0wY
 ECdTog5SUVYoRsx2q98NqtiR55UvA+zhEaNYdPQbhRfM1niFcVxhkC7etACQCpzMDox8
 0+Kg2nw6IqFgm5UyNCDTCBM4uFQcQ37TNv/Kcpt1SlJaTISk6+CNF3E/yljOwstsrSla
 BR2v4JtcYmyiKRWknDxDSJTSQFeW2DGEmw/Gz0814xb+oG7d5xGoK1I5t7F1yDACvfGc
 swQXWf9CHcAaDewtGqDahtshL5St7SdD7x96PDyfzIGXz9PfusD3cGS2yd15qvjz8lyf
 h8HA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RJz+CxAAFLEki7hrZTZpkHTzJr65/kU07RMPB0jLLU5uCJQxfI/S8EiPffM4KRD8fu5PNWiAZjw2g@nongnu.org
X-Gm-Message-State: AOJu0YyKhr25U9q63OJ3/AWC+R7fI7KF9fFQJJ4JEojVfZlSdS2cVSLp
 Ssi+W9sCrRdrn9SlzsuhE1eoiMdbnK/IB7Y8q55yINf8TPknWSNna4C2tqKFKid5Ejfmw7EcIlr
 ErwUJ
X-Gm-Gg: Acq92OFq2nDtdKIjzYLJY9Aovn7oLfhVOoXF39pQq7MuabGk7I70Oqoqtj0L2TtoYu9
 ei6VPiPptzzQq/ucDrBJM7BdRr/l230NQrYIiQ2qzDQRqB+hRC+Y9bna5GfjR/mK+rCSXKviJE4
 X7BTLmNs6LYWXMX993YBIsQKk9EIS+DsOiT9DPs2yDf7QDjn/xEMqnxao5r10gVXmAVOA3AB2zQ
 mK7csHfFxbk6kmqn1avN90haDdA5RWg7kEqYcA499pzA3tw3/uRikvuJfL4gcZ5rEB50Nb/l7sc
 6ml1k/E0MIkuORSIjsHSH2QArb0w01b6Ue1ooEFZCKIjoj1G9+Ir1PW5D96OKiXDUSJqSJ660lP
 veIxWjucB320OLo6J0Yi8h15L9aOe1+CJDNXlF76irw58v2I+k7Qb1BjlnFlH1iflk4WiVNvZOM
 TEpSUJGELswTndH8J+51UR5Liyg7oiTHSrSxQzJhHA7ygYlBVjJSr1UYzJOonVSbBYQhsFDmocg
 2o/NqYYGljgVQRjXwpQoT7MkO7u23U=
X-Received: by 2002:a5d:588c:0:b0:441:3144:efc5 with SMTP id
 ffacd0b85a97d-45e5c5db173mr5319138f8f.42.1778850766968; 
 Fri, 15 May 2026 06:12:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a5653sm15339338f8f.35.2026.05.15.06.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:12:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Set debug in attrs in translate_for_debug()
Date: Fri, 15 May 2026 14:12:45 +0100
Message-ID: <20260515131245.366240-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

The translate_for_debug method is supposed to return attributes
that include the debug flag being set. We forgot this when
implementing the method for Arm.

Fixes: abefca8e7f957 ("target/arm: Implement translate_for_debug")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8706dd59dd..0693d2867e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3961,6 +3961,7 @@ static bool arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
         /* translation succeeded */
         result->physaddr = res.f.phys_addr;
         result->attrs = res.f.attrs;
+        result->attrs.debug = 1;
         result->lg_page_size = res.f.lg_page_size;
     }
     return fault;
-- 
2.43.0


