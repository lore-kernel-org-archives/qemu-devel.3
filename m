Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E94EF99F0
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr59j-0003h4-Ko; Fri, 13 Feb 2026 21:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59h-0003fj-Ty
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:09 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59g-0004Y9-IW
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:09 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43638a3330dso1219995f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771035186; x=1771639986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4u43mewq1FTrot1iOEEMQ28OqdFfPZBhtZzWEB1g0Y=;
 b=R96lmDqWvB7vJfKSqiPAR7KI9mKQ9eXKtsXTvMa6Nz8aRi8DDuU+F6tkwtpk+d81Gj
 rIXYR+8gt+e81qcNmlc0STIOx7KSinDXTZOTb3TiK+rFi66Ky7MbTi+wQuiiCDU2Oo22
 UEuUSpz3WlaB9wqgqYyF439xiHfdhAk1K3+vQfozSNNRMtC7ti9AriqOy/nMyZMDSf/a
 mZ4i2elUOFfh+vQtAiJ8K+U3CoBi2E7SajKtHMHPK2rQujyem4UYpYwGmjcUGP2wad1M
 yD3b5ROiGyc0R8mH8Kb6gmOQWXsYwp68R5IxxgYtlyAzcllP87TzlZwNlAYguErwnS2h
 K4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771035186; x=1771639986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h4u43mewq1FTrot1iOEEMQ28OqdFfPZBhtZzWEB1g0Y=;
 b=PymF9HdygWegYr9u+MKDhRklTjptrQ1AnfNytWCR90OTXbwlwR96WHAj++AXEA5MM9
 rnvzzhxFOuAbadPuW6KRSvCyRHWiddwq4h2WVAuK1MC5R8X4Xcp3fGtnr99r5AC5+ouq
 63FdU7tH31mLFv7wd4cKDEW2mc42I8XfMb+Ks9RjdMEJOfFwxpWzGYPKOyK5CGvs8G5N
 n+ZdbkxBOhVCR/tY3BfkCkcFou5gMjjEXjWfTEE78ZLcJ5gd19BqyUGw4AxzbnViShyi
 koc0+2gxpQNgiB6iDpXriUliH7thybXWO8bBT6FbmCT34rrve26+J26KSWkjozk9yN6X
 QEoA==
X-Gm-Message-State: AOJu0YxExnpVFJpOC6Skuc11yvUW4r2E24fTaeR7ai3WNBWnBFF6LtzE
 wm63NtrlqyYL7cwefH+nhX++gZ4wqyKKkIdFK8+GoHP+qfNCLLpK2jv8ejIOsM/+4LW/y4Ko6Z5
 3dSeOIG4=
X-Gm-Gg: AZuq6aLFyo69nFcrabPxCIEHTFT1nycnTxQcnatbSElJCKyZ3NS5FN5RgjKo4XFhBTJ
 BDN8H0smAe8ReziXZwMHvl6HICb7LBeiEABIYJ9cyRGcab7+IqXBhc4DQsmdT7ZYFLGnah1Jd0p
 65rDljfGAJG5mMMHAROoIMDnng6JPNDVy25Sm12u77L5lXM2GQNL9Xk96zPIyC9s7K3dxXVpLpH
 omI+/J/WkD0emqdlyXGBIYnysXZGFrsFk0ESPkwhqgA2uxo4XtQyPlPsA7QmTty95WjMfTNAFGf
 x3tQKnkh1nYeUWHeYBAc1r4lePpGj0/qD+Z3I6DEoOfF27XwGJLgNpbsHyUdhz5Y3rKPPxkrfwT
 vC3iTYO5e84Fuo9re5fKUurJeuJhX04wvR++nQrTVqqE7fxBE0Te7Bm8VuxWq4zL0K2dCfmy/2v
 +Fs6EIxQEdxFnKcp6/wXvpBf7Fdo4OO+6bBcyczIJXwwX9itgDSk+vuu9/ZLiwdfQOhLtmbpr4
X-Received: by 2002:a05:600c:6309:b0:479:2a3c:f31a with SMTP id
 5b1f17b1804b1-48379b93364mr16621565e9.1.1771035186547; 
 Fri, 13 Feb 2026 18:13:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a3eb7asm46759225e9.1.2026.02.13.18.13.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 18:13:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] hw/m68k/q800: Use MacFbMode fields in q800_machine_init()
Date: Sat, 14 Feb 2026 03:12:34 +0100
Message-ID: <20260214021240.58657-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214021240.58657-1-philmd@linaro.org>
References: <20260214021240.58657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Once the Mac Frame Buffer device is realized on the NuBus,
its MacFbMode might be different of the global graphic_depth
and graphic_width globals. Prefer the device MacFbMode fields
to initialize the BootInfo structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/q800.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 4767eb4298f..b55c03a90bf 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -605,9 +605,9 @@ static void q800_machine_init(MachineState *machine)
         BOOTINFO2(param_ptr, BI_MEMCHUNK, 0, ram_size);
         BOOTINFO1(param_ptr, BI_MAC_VADDR,
                   VIDEO_BASE + macfb_mode->offset);
-        BOOTINFO1(param_ptr, BI_MAC_VDEPTH, graphic_depth);
+        BOOTINFO1(param_ptr, BI_MAC_VDEPTH, macfb_mode->depth);
         BOOTINFO1(param_ptr, BI_MAC_VDIM,
-                  (graphic_height << 16) | graphic_width);
+                  (graphic_height << 16) | macfb_mode->width);
         BOOTINFO1(param_ptr, BI_MAC_VROW, macfb_mode->stride);
         BOOTINFO1(param_ptr, BI_MAC_SCCBASE, SCC_BASE);
 
-- 
2.52.0


