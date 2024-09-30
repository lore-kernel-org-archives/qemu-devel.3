Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683C2CF64A6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFuL-0007zb-GC; Mon, 30 Sep 2024 08:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svFuJ-0007ro-Ll
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:53:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svFuH-0006XJ-Fo
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:53:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3770320574aso2876327f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700819; x=1728305619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gtv6IX/KV3JKuyckPwlUPbMBU1EPVCs+bl/6v1epcQg=;
 b=i3VM0qHDQ8Wzpow6zGMOrnoaOKnOGjXReO7NPUhYO1fqCAQPTLwcR8TvPIscWk2YAL
 U2+xtfTUaKSR83F+s/gt/rFE07001rb4CWsfk/AIYI7CN/BJjRjEe5eT2Uhw003A8Maq
 1Pb6f9JXScG5LTsB3pF8/UJ0F5TWHlIUqtS+AuiptIEmIgPwRJMluJCDNIhBIiOCYOew
 aSOLODDs6gShLWcfJU3B22rWhMOJncJ4KHjCiMIXVm9AYJngw+G/ikrcT3FUSPS4pmKE
 uiTtvt+erbmY5MoItpSr0qq6lYzv4fBwafISh2tMLV5yJfGSuJvNcV9aFw6DvACtlTvG
 EBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700819; x=1728305619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gtv6IX/KV3JKuyckPwlUPbMBU1EPVCs+bl/6v1epcQg=;
 b=S0r2TDw6xqze54siXMYL4e6dlTBEL7eYAuqdcsMR5kfEZNyfxJfOEYKT3VQNXTauQw
 ZOqB7XMIVuaoJDb2vCyZlqgdWJOnlLb4FCD4TqfLpGFy8ZrTomZnjd1ccccKNPYK0eiR
 lhAOPCXcfryK2Ts+nARIUCJK9sHHr3gYND8+Tv1Ig/CbQ0utkQJquoblDSY8Q5k7L/gb
 knVv34n9Wz15xfkhXpWCsVePv1Txw11j4J/zJeFHwS5jQMBQPBtf+p9l4YRAlgfS9bTN
 qk4cvU/8yx9KDfmtaL7c9ctqE5cnUW6HDYs3b2ejM5TsK7YBQJ2URMsEhjQgAgxqkzyT
 0mww==
X-Gm-Message-State: AOJu0YzdxvKjjN1qW9wLxB17tkapruGle6T0cg/is0L8dKLbVmfcuZah
 hgbE8C39jRRMaWeHgSNUck0JE3PxI3oRS9vDgD8GYhOMJPtCZX1bI+za/g4ViiE7GHCX/9jkRx1
 zNwQ=
X-Google-Smtp-Source: AGHT+IGvlyMVD8GqdUuXqC7ZuTDpdqn6SoaisFx8JGE/Rxou76lyPx6d2syn+uUCOCW350lIfgVirA==
X-Received: by 2002:a5d:4d0e:0:b0:374:cbe8:6f43 with SMTP id
 ffacd0b85a97d-37cd5a9c921mr6466471f8f.33.1727700819587; 
 Mon, 30 Sep 2024 05:53:39 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm9077147f8f.58.2024.09.30.05.53.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 05:53:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] hw/ppc/virtex_ml507: Replace tswap32() by stl_endian_p()
Date: Mon, 30 Sep 2024 14:53:23 +0200
Message-ID: <20240930125323.54671-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930125323.54671-1-philmd@linaro.org>
References: <20240930125323.54671-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace the target-specific tswap32() call by stl_endian_p()
which does the same but takes the endianness as argument, thus
is target-agnostic.
Get the vCPU endianness calling ppc_cpu_is_big_endian().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/virtex_ml507.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index c49da1f46f..135dcbde06 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -141,7 +141,7 @@ static void main_cpu_reset(void *opaque)
 
     /* Create a mapping for the kernel.  */
     mmubooke_create_initial_mapping(env, 0, 0);
-    env->gpr[6] = tswap32(EPAPR_MAGIC);
+    stl_endian_p(ppc_cpu_is_big_endian(CPU(cpu)), &env->gpr[6], EPAPR_MAGIC);
     env->gpr[7] = bi->ima_size;
 }
 
-- 
2.45.2


