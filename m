Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1C1C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 11:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s91Xi-0004yZ-6e; Mon, 20 May 2024 07:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s91Xc-0004xF-0G
 for qemu-devel@nongnu.org; Mon, 20 May 2024 07:50:57 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s91XY-0007yd-AR
 for qemu-devel@nongnu.org; Mon, 20 May 2024 07:50:55 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a59a387fbc9so732627666b.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716205849; x=1716810649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+J3nEy2JCn2/CgkzZfL/geex+jz5+hP2/DLAqyrU2R8=;
 b=IPuNY47vnnRo8n3HzEPN8uYnr1IPsoyd4/Jj8YF2Vc7Svjwn1qelBwHZZJZ80AMuPs
 BhD1FyoQutXNmAljqhzZ/ameWawlEMdH0D8YcMfBGIBCawqXO73BNPhmQNmjsHlrfSw+
 DuaRbNbDmZzGAwaBdZ4KeiCH0xEuhwwEbYtS3bhv/i/nri/bMCvDGcKkiHXDWXz17Juz
 YQy9VgHHyFEng+SlnD+3X+13F3OZez1Wrx4cq3l7TJUHMQjp8k3ZgydVySMV8dxqDyql
 WM3K7eSsuRR7iO7s7NwsgtzJD8uTVBvLB4x42SuiqFTr+wDkPNQR3Qn5iOWr1Hycz77X
 Zh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716205849; x=1716810649;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+J3nEy2JCn2/CgkzZfL/geex+jz5+hP2/DLAqyrU2R8=;
 b=jZDEE5lz3q8TWglLBFCicjJHqdXWX9/E/uqixA+x2L7DRanDoHZHW26c08XyFZ26ls
 Eb7x9ooqU7w9xHlDAIh//kzMhWl19GM6rcelQyDavdhQHg1hHOi4oGJDN5P4U5e3O5Jg
 kTjSFiVsoWoRWsvX9EeLCxDvFCbbAySL4MgUtK5KcEYsurap2xFxmQXmUoKQMBFFqVUJ
 iJWEKMU/pJ8yzx3yIaZ9hAHryc8c+jBa9aJ9DI6PHS+goG3tPKiZplL8JKU7JztAxRTU
 eqTiCduzNSQIWAmSsSh47jy2LILe1wapfPt5I6sMEMOt4DZdv8OtWHfhPjVUa8+2Y3aI
 xBaw==
X-Gm-Message-State: AOJu0YyMJO/7jSwE0Q8iA6PS5moBze2CRqYvxE1jO/ddhQIuVRfzjFcX
 TvZ5kyHMLnmSerVoJnBqnPPVL/4zpK4RztBKslj3Mz13sUQoNQ8Nd/SYlg==
X-Google-Smtp-Source: AGHT+IEeywF1qhGQ51IuAslibRS5pdXbMwWHD5HwLUfnwZe9IvpoPW3tXlfOj5x3Vw+bVnRslDgipA==
X-Received: by 2002:a17:906:7815:b0:a59:c3bb:b83b with SMTP id
 a640c23a62f3a-a5a2d54c915mr1600421666b.1.1716205848606; 
 Mon, 20 May 2024 04:50:48 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-098-013.77.191.pool.telefonica.de.
 [77.191.98.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d4b2sm1437154966b.27.2024.05.20.04.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 04:50:48 -0700 (PDT)
Date: Mon, 20 May 2024 11:50:47 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Subject: Re: [PULL 19/34] disas: Use translator_st to get disassembly data
In-Reply-To: <20240515075247.68024-20-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
 <20240515075247.68024-20-richard.henderson@linaro.org>
Message-ID: <FD65D32D-E0D7-4991-843F-47B16A86274B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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



Am 15=2E Mai 2024 07:52:32 UTC schrieb Richard Henderson <richard=2Ehender=
son@linaro=2Eorg>:
>Read from already translated pages, or saved mmio data=2E
>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>Signed-off-by: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>---
> include/disas/disas=2Eh     |  5 +++--
> include/exec/translator=2Eh |  4 ++--
> include/qemu/typedefs=2Eh   |  1 +
> accel/tcg/translator=2Ec    |  2 +-
> disas/disas-common=2Ec      | 14 --------------
> disas/disas-mon=2Ec         | 15 +++++++++++++++
> disas/disas-target=2Ec      | 19 +++++++++++++++++--
> plugins/api=2Ec             |  4 ++--
> 8 files changed, 41 insertions(+), 23 deletions(-)

Hi,

this patch unfortunately breaks the "execlog" plugin which doesn't decode =
the mnemonics correctly any longer=2E When launching `qemu-system-x86_64 -p=
lugin /path/to/qemu-build/contrib/plugins/libexeclog=2Eso -d plugin`, it ou=
tputs either "addb %al, (%bx, %si)" or "=2Ebyte 0x00", regardless of which =
instruction was actually executed=2E It seems to invoke the disassembler on=
 zero-initialized data=2E Reverting the patch fixes the problem=2E

Moreover, patch 11 in this pull request "[PULL 11/34] plugins: Use transla=
tor_st for qemu_plugin_insn_data" causes the plugin to not print the correc=
t machine code any longer, instead just printing "0x0"=2E I haven't investi=
gated whether reverting that patch fixes the problem since it doesn't rever=
t cleanly=2E

It would be nice if somebody could look into this since I'm also trying to=
 hunt down an alignment problem in the ARM emulator introduced in 9=2E0 whi=
ch now prevents my guest from booting, and the execlog plugin is one of the=
 tools I use for investigation=2E

Best regards,
Bernhard

