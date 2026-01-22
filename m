Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D23C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqUQ-0004Jp-Vd; Thu, 22 Jan 2026 03:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqUC-0003if-EM
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:56:21 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqU6-0006LL-Ks
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:56:13 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee4539adfso7387295e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072169; x=1769676969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hHRCg8AzpvchTIM/bMaRLTqrDQYbeQK/7j1Xud3g/Aw=;
 b=FaYJ5/IXdbe4/2mFPlykfUZYMyPxfpyR60GqFKhyTENFFApAYbdAzdU0bJwSbMcogF
 8FzBtVfBbs87deHYGWoF3kjTRzBEoGYzrh8P2jX2+k+lyivdMroHWWPs+TtxiVhqp56T
 GW3bH4NcD4ULoj+0PCGyUyA4Fmc0Z88i7fHDL3+UZWVa8znR0RTXh+yFlqBlclV44ROg
 2yhi4kb+yJ0RSKFl7XJVhjhgNJei+JxgyU84LIutH5BhwONtrRK0nUFVsGSNSYozEZ+V
 bGF6AwLKoUbVWLsaNWePeM/af/Y34UGYBXiRrSY/JzH+spXHnFdq7xGCsx9coZtDUhNo
 SqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072169; x=1769676969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hHRCg8AzpvchTIM/bMaRLTqrDQYbeQK/7j1Xud3g/Aw=;
 b=P1aQfokf7F6Lztw3jc31tcgbc7WAEmj9S/nXm4GFwJGHM7JTp3Dg3IqTdka9Q5eY6/
 kcPeStrz58OaYvJVld8gowEeg2zyHJ+JooiJjv7g6mrvptgkLkaHSwKY4yP936lXNqbD
 V51wyaHtqS53RxFnzqW7sO671C/I80hTaMEHLNHfkEhJ/zd06LcvrI8UIqA8ADw+gsvl
 jfDmiyOn+wpFsD73LW9MnMDWfpKNSWwEwZTev2c/y1sGk74Q/xnHw0TWrMADNggzBa3C
 Ku7gVUhsD0t/Rnu9NcLv9VKhVv9Lsy1u4xb3tHoxNVp3DQ2XNHcu8sFOzTWFd5wcfv70
 G5AA==
X-Gm-Message-State: AOJu0Yzw88VrIsVR1Ty7sH2JbcAykL/7mFtFgGcCc1OZlyqKR3UxHh9K
 JOKIfXJ5afluvaZYdj6P1/CktfeItswZZCZDP4FM3GyUa8SpRLsHcpnUgMV5fqmtKlAWLQOGnA0
 eazUbfEM=
X-Gm-Gg: AZuq6aJ5+aoXqAIKdh+gtkuQM7NU+ko76ImDnammCFnkkJll7EQIYP1fDriZqCP055m
 WsXiBrOibKaqkM3/cZPTPGKaBLRraUV5DTeRdBLK7kalYGr17AQohi/T/oAofHhjmd96h8YR2LF
 XVF9wsKASxbl059BEv7b/k9ZsBtgothlPMT+0SFRG/knxFWG1ZBzBLrXu73SmXujLTQPM6OPaSa
 t/2SfGHU5XgbEBXmRHeAxWRhGyc7y58B3na0DFADIBi2GkHhCzYCIYVGVknRF3Mq7rSRtBYApqb
 1ySCgqzGANd+jSWOwjTn42h4KiQED4HJv+bAEkv8AxVzIZk2A9Pv4RxIC1aszrpLGIKjF3wHLWu
 akceo8cNyYIrAXOy9yiDcmRSCCPC2aW/iS78I+UQ4yVZCPBTMP2sF05X1nAtObUT31hY4xfzBmW
 JJdnbix7mNFPWVWWzPlJsS+j5TGToZz3/H8Fcjv2bsqH6BpFPu4U14VNcJDaYh
X-Received: by 2002:a05:600c:5253:b0:47d:403e:9cd5 with SMTP id
 5b1f17b1804b1-4803e7a2bd6mr111455285e9.11.1769072168808; 
 Thu, 22 Jan 2026 00:56:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804702fadcsm55373915e9.2.2026.01.22.00.56.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:56:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/31] target/i386: Add a _MAX sentinel to X86ASIdx enum
Date: Thu, 22 Jan 2026 09:52:52 +0100
Message-ID: <20260122085255.95035-30-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add a sentinel to the X86ASIdx enum so it can be used to compute the
total number of address spaces supported by the arch.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260116185814.108560-3-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2bbc977d908..da5161fc1a5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2733,6 +2733,7 @@ void cpu_sync_avx_hflag(CPUX86State *env);
 typedef enum X86ASIdx {
     X86ASIdx_MEM = 0,
     X86ASIdx_SMM = 1,
+    X86ASIdx_MAX = X86ASIdx_SMM
 } X86ASIdx;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.52.0


