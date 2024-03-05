Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B680C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTlJ-0000hX-EV; Tue, 05 Mar 2024 07:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTl3-0008PV-7C
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:58 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTkv-0003Ey-8r
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:56 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d382a78c38so34208051fa.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709641127; x=1710245927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UcgWSPHavk3jnzeArpwVhpqUMOHkHAZLH3BaPdead8s=;
 b=QKwwoS0ayhUEegS00UJTOCSR29nMBAaWYEnKDZgXZLp9GRvjXbeqhuKq55QxUBIOCN
 y4DYcA6Pv2BLswRfqtb8TXNLbao1KV8yL+gtRxpQgWJ6hADfbK3kqL8IeOcskWww6pxb
 ulds9KF/8DTVKVQrPqrRnJgIKYWQaiKQodQw3mA+nW7pY/LXjFIyGBJdc8+Lu3CFzoT9
 PBHcs6zJX/ExkIaLj7QdgOckCqCfeRQCOlyYukyuOXncwOXQ/F4lUwK1NVpaD1ati8Wv
 uSOniV9BVqTVgpwWBC0MOEnsFLWFC5GBfALzyaZnDmLKPn5uz5ZAD8ITp2xzTM5hjnAJ
 ZaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641127; x=1710245927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UcgWSPHavk3jnzeArpwVhpqUMOHkHAZLH3BaPdead8s=;
 b=t+hO2/cyWbdZVzTAwwi1FzyScxJ6sBRhoVyNdk5u2Knbw1M9owEfKQwRKy9zBqRvq4
 SJ6r0hevHL50Fw5WC5azuVUrY2HBCy8TQxEnJJnUIguuG73DZYMmyEYNkqtBOOTrPUfp
 XQjUyXO+XWww6XfU8SVOWO9Uz8zqfeE8hppBP0sIBPFIniV8+zkeQ78Xg/saGpwd4WsQ
 MFnb2OokD7e8SfHjCCN8LR7/s6z64/PnLYmjNlfJBqUTzQBnHOsDeUM9A/hvPX8rEJr0
 bWSrWTxkFA7RcoHoFVXegqTJ4n6A145yfYJtelNzxkRKNArJotsb2n+34z0UzpTv7RZT
 ul/Q==
X-Gm-Message-State: AOJu0YwhoRFFf8OzHiPBfF/9914v+rGxa5zdTYBwclfcNGibeQEjXOio
 xyq0T83ALejl6Ts7fbOjT/QoTELbFKdS7wXQ1TviA3/T/jRr75B775TeX4FDjPU=
X-Google-Smtp-Source: AGHT+IH9KwVJTQeQEslJG89+vmGjqmmhWGi0+6NQxtwTOFdi4QGrRO1QXgsNsRlyY8haRvYRTzihfw==
X-Received: by 2002:a05:6512:36c7:b0:513:3738:f831 with SMTP id
 e7-20020a05651236c700b005133738f831mr960024lfs.32.1709641127409; 
 Tue, 05 Mar 2024 04:18:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k4-20020a05600c1c8400b00412e556d4besm5271799wms.48.2024.03.05.04.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:18:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE1675F9FB;
 Tue,  5 Mar 2024 12:10:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 26/29] disas: introduce show_opcodes
Date: Tue,  5 Mar 2024 12:10:02 +0000
Message-Id: <20240305121005.3528075-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x230.google.com
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

For plugins we don't expect the raw opcodes in the disassembly. We
already deal with this by hand crafting our capstone call but for
other diassemblers we need a flag. Introduce show_opcodes which
defaults to off.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/disas/dis-asm.h | 8 ++++++++
 disas/disas.c           | 1 +
 2 files changed, 9 insertions(+)

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 2324f6b1a46..b26867b6417 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -396,6 +396,14 @@ typedef struct disassemble_info {
   /* Command line options specific to the target disassembler.  */
   char * disassembler_options;
 
+  /*
+   * When true instruct the disassembler it may preface the
+   * disassembly with the opcodes values if it wants to. This is
+   * mainly for the benefit of the plugin interface which doesn't want
+   * that.
+   */
+  bool show_opcodes;
+
   /* Field intended to be used by targets in any way they deem suitable.  */
   void *target_info;
 
diff --git a/disas/disas.c b/disas/disas.c
index 0d2d06c2ecc..17170d291ec 100644
--- a/disas/disas.c
+++ b/disas/disas.c
@@ -299,6 +299,7 @@ void disas(FILE *out, const void *code, size_t size)
     s.info.buffer = code;
     s.info.buffer_vma = (uintptr_t)code;
     s.info.buffer_length = size;
+    s.info.show_opcodes = true;
 
     if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
         return;
-- 
2.39.2


