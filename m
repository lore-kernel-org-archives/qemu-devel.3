Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E061EE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagxI-0004dt-8N; Tue, 30 Dec 2025 16:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxG-0004dG-NQ
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:34 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxF-0002F7-Ai
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:34 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1826404f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128911; x=1767733711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ybCEBCayktp2Kdzo91lHKG/5ah0/ISp9PAz7gvS8NAw=;
 b=g1InOQYasGuXmew7Yr8JuLiy/dcxLdFJtVSIAFgT+2E84Xbajo1bsfQ9Z0+w9sEBwI
 HNmSVz/poSQQWUFn0tQf76SAMmTntVmiYzAXHeXYRBlgn7eOA5JSB0AFUJArcSuxQWyf
 7DzSIkavBHuGTt+GdAYdUdomkrwfNxCcCh90EHZZFoN3g4i7CvPO+rTCPIeYB8JKXiPX
 C3O7pxs32dji9TbccW0bERQANJ3Wz/oDGhBH0iiclhjRFxCsPfD797p8QiMb/L5gCseY
 SDDtqDON83/WDYnbdhH/D+W5wI8JjtLd/ogcVGjoR1Ktq2hISgrIp60Zs8NXtCrkAJF/
 0JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128911; x=1767733711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ybCEBCayktp2Kdzo91lHKG/5ah0/ISp9PAz7gvS8NAw=;
 b=ijo7VPDyRKqL0f3w9WbnMoIGFmkkGBTNAGqq6sjkIJfm2A3uzMudN7BtYWICrM04in
 HllDs8MqzSJB4dQe4rEAb5/wflfEXplADnu9/3748ZJxISceftnTI7wJKOrUrXY52cA9
 BP5wrEYqbgsfmXJCeVVU5hYOMWv6e6CTdbnddxcltQjnD6b9mCSwJMxU95hrqjEcjAGK
 2xSdNUEPTMfAv2OanpS9FONP140Z17XhKihINtBLs/VfqD+0FcZMjufEDBeYy5KC7n+5
 Ltw2XMig2JheQvTpXf6n5fGQGRVXoUgh6q/JeR3ZlEDs0ZWPM+kvta/U3xF61efm4rXN
 RVbw==
X-Gm-Message-State: AOJu0Yy63Ow5pVplzCcofFGEXWxRW1su+71qkbFUdnd8qDeYKf10yMZt
 NcGGdBonBkm2+wWUODLGDfTduMTL2FsJicUWfTHxpriPQzPVcYgBuS4ZOaFpKTDJEYxcHOg0FOd
 KnFSeyro=
X-Gm-Gg: AY/fxX6LQqYll9w+LIoErwNnJ77W9vCOx1DEkP2DONT4Llic804N8iJR/qSYaHUKhoh
 O4bNCVSLDWcg6RpoUceX9hcmMEoXWRSaQyjR2vBwg+KKHNNJyMs0LYPeFXVmM9q2qXAZkE4JgOS
 CtLc2MbTgezrsVhxdVAbaGRj7kA+W9anIJn+H0HLEvhlRgKvknR9ftAujC3LoxX6NpQO/WedPj6
 1D8hyd2hIIIbSZGuPuG3HGkNtsjN79LnIoc6TbcR/hteX59D2W8DyZe/ecJXUyUocMtaHJOEI21
 3WwQc32AeZTpj2z6Fg+tl8cr65ISjrb6cCyvhO+r5eq/H7BTHtzGcZj/eYtajm0cunVO5DkXBlP
 EiSqWzXIOFuobH5txM7qR0lvE8cZhK3uaXuAB7AuGl+5aH7J7b5TiVLHIzFmSmbtiZ+NxWldXew
 v9lvXMtI1vX6dCbeOZ0p8iNuDiv6ND+WeZqzdnClZinCjLAtJ6cgF7eTgVScOg
X-Google-Smtp-Source: AGHT+IHRCWgTHZyobfwDLUXHLGfTF71MFoCuahJjPI9RjtaDx43wlLhwWReTJFnCI5JZUp/Xcyln0g==
X-Received: by 2002:a05:6000:420c:b0:430:fbe1:3822 with SMTP id
 ffacd0b85a97d-4324e511811mr51135784f8f.54.1767128911605; 
 Tue, 30 Dec 2025 13:08:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm71316978f8f.20.2025.12.30.13.08.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:08:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/34] monitor/hmp: Replace target_ulong -> vaddr in
 hmp_gva2gpa()
Date: Tue, 30 Dec 2025 22:07:27 +0100
Message-ID: <20251230210757.13803-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

cpu_get_phys_page_debug() takes a vaddr type since commit
00b941e581b ("cpu: Turn cpu_get_phys_page_debug() into a CPUClass
hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-Id: <20251229231546.50604-2-philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index e9820611466..2976f986d35 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -301,7 +301,7 @@ void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
 
 void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
 {
-    target_ulong addr = qdict_get_int(qdict, "addr");
+    vaddr addr = qdict_get_int(qdict, "addr");
     CPUState *cs = mon_get_cpu(mon);
     hwaddr gpa;
 
-- 
2.52.0


