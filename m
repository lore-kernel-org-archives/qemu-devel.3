Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAE3C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNhn-0003wR-2f; Thu, 18 Jul 2024 05:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhh-0003Wk-82
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:37 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhb-0007dA-Ko
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:37 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a77c1658c68so62453066b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295930; x=1721900730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cfYyhSqeU6lh61PrlYddSdndv7Xezjj0qPHaR6Sb3o=;
 b=dMAHTH8xBY2EHU2pf2H0Y3UDAFhH+mmoc4LWBCoD5uaIX2u82EerR+l2OLNW7a7PzD
 XNz7XPSvfTuF5GEzbkFamRjon/rBu0tsnhbFszqN1O+BKsT+E5iz6pdqiPd16J+RjgS6
 u8XUHhQo8fEzFpj6Be2M7PBu3BabKF2Y2fJrdz/Y0vHgxpbGytRdBii0PL2p2FGpXPrk
 RTO9zEBn7G7ozP6rHb5A5l+M48/vw/Yoyv4v4HqjYs7zTYsyQ5+LU23aPHoFJhCDycFn
 rTOE/uLSFzjXlJUUGIZZF2+4VUCGXfyIZaHG/pU0VjTXJ1L/P5jZZzFyzbMWQp9uJpLO
 eMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295930; x=1721900730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cfYyhSqeU6lh61PrlYddSdndv7Xezjj0qPHaR6Sb3o=;
 b=ZLcQWS7h8esotnh3WVM6Q5IPymf7C879Rj3bCnk+lOvcPS/MOu+0x1C+vPSTD1+6FO
 5zfQlfDbRXcN6vsFkvhsBd0SFSjRGBNVsi0Ng2+oLDAeh6zUvJVxyEUEZn6siwVYbrcF
 N1BzDWpYTPsxXyy9o0POZeZG4YRj1ycb2fFyuoyhQqYskKrAvh0bUwR5CUuuvXSBlKLP
 axiEJUOJARVVUKX7lgmfQqGidXgdp6PGMgBKezlXiyr71N4vMHiE0hD3m+pgbY6jtFVl
 j0LUdTjUru0j/QqG77gY0lJZ3zpM5f/qyskv++kZKPmFYuB6QCjecy9zzsARbzcs9VZE
 B8Zg==
X-Gm-Message-State: AOJu0Yz4THDfUqJrgTaol2cbsLpPDMWpXrNgK44yBf74LatG0pvkDmrI
 1sDtbfBni8gbBJQWJGugBVItYUG3dB8ZPyLZxxA+tT+qYiRih3CxFc1mQqrtgK8=
X-Google-Smtp-Source: AGHT+IEz+wd0NIA66sJzZOQgn+jHutMe3W/oA0yxyNS/fVUDbi7YoClWPrtzZCWXVj50rxlTpbhQhw==
X-Received: by 2002:a17:906:fd8b:b0:a77:a630:cf89 with SMTP id
 a640c23a62f3a-a7a00ef47a6mr364181766b.0.1721295929671; 
 Thu, 18 Jul 2024 02:45:29 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7e50sm537503566b.69.2024.07.18.02.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB4EC5FA3B;
 Thu, 18 Jul 2024 10:45:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH 07/15] plugins/execlog.c: correct dump of registers values
Date: Thu, 18 Jul 2024 10:45:15 +0100
Message-Id: <20240718094523.1198645-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718094523.1198645-1-alex.bennee@linaro.org>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

Register values are dumped as 'sz' chunks of two nibbles in the execlog
plugin, sz was 1 too big.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240620083805.73603-1-frederic.petrot@univ-grenoble-alpes.fr>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/execlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 371db97eb1..1c1601cc0b 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -101,7 +101,7 @@ static void insn_check_regs(CPU *cpu)
             GByteArray *temp = reg->last;
             g_string_append_printf(cpu->last_exec, ", %s -> 0x", reg->name);
             /* TODO: handle BE properly */
-            for (int i = sz; i >= 0; i--) {
+            for (int i = sz - 1; i >= 0; i--) {
                 g_string_append_printf(cpu->last_exec, "%02x",
                                        reg->new->data[i]);
             }
-- 
2.39.2


