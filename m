Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BFCC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH30C-0007yv-V2; Mon, 19 May 2025 12:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH304-0007x6-7y
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:06:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH302-0002ZV-A1
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:05:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a36f26584bso745030f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747670755; x=1748275555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNuP6SjdxYcYAA2oXPQrhal+s9DvaYvcXkHUmfDFzoU=;
 b=xE+IL/7Up/h/qWYNOglhzl3SbFNLXl1wYZczcsOIyhm7lp7+05kVcAvTy3ofs+7bfs
 E4r4YwRJ97euslCKDgk8IlNVZ2oGOepgvjyKI/F8xIAUInAeEwd3vKeFgywi/vf/TZR9
 sOS0R5uCKn+3eRqz3bRenUk/qVzaXAonAH52uK7cFH2en1XtD+cBxseyYZw6rQiLUJxt
 UXrAhxu8mforI5KwJiHX8zJg7q3XJNKiZl4ZfPKfSTvuY6/sCz0ii3P5BhWaVNZVzXSR
 /QuSFatTEo5RZq360P+VWVazf7QMuGjp/U+uEEkIlYNfPoWCtbwdg5PC0MtQqdRktuHq
 EZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747670755; x=1748275555;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VNuP6SjdxYcYAA2oXPQrhal+s9DvaYvcXkHUmfDFzoU=;
 b=UE5KyJK6L50D5FmIMyzvWQxkmUOIf2z1c2Jv/d1FF70uGSvmhAPaz+qE9P4Pj/HZdz
 Kd8IjOVfJkm1SbefMHZ5Zlumkac26HHlqTHr2KnMoOns9fEidtMxpEi9w8hPgNdA07OW
 JfCrleWj5I3FMZCSZWJa9hVbpFXlcZUC6R1oNuy7cLUKyCAZGYF36jaUc7w0tIfJbqIk
 4MZk6T53bVDTa9iOaxreSVPY4igQ+8LKpTuDS8PRhuKSO+Cg/GIiSxgp5Z4Wa309ChzT
 Y0PDLOoptVW0fEquOnx2ksFJXRfniAj4nJSnyNxf5wzyTTeaCgReqExAk1NkvQbuaBZb
 Ht1Q==
X-Gm-Message-State: AOJu0YzWf9sWk9XeeZaIvKl8G2v1NmvEmrAigAs6GFtSxwixffR+bbCV
 UDuUSC+1QUiHhkABGW2phXjdu3e8i4+LN6nUNjT8N+CxOj4yoVAKInpZzkyAlrKyxGY=
X-Gm-Gg: ASbGncuL4S4fYAtgyZ9dydua7qF1eW2vvFU/gPa5m2bH1hqiuuWB4V0fzqYG20C+J0n
 lyq2/QBDQldH1rr522UX1wkXFwlYi4gKhRZvwQ8IM75/JqIC0eyjkEQSrDCNGYADJMbPi/KSlCa
 EVZMosCHwRInKuuil8S0gxtNRcfbGdum9T7ik36QetNa406kULf4rN3c2hHqMWJgZrECSWRYRYQ
 L1tVL5Tn6qrSUqPKs19L+8LnYoFto9FGVvpBS5JtDgr47RtDHjAxoBV+Y52D6z46xyH9x8KTXTD
 1lvfYuRLQ/akY0ApTMmXET6tHaZw9LPo7cwvgaQl3ApOhloMgnXw
X-Google-Smtp-Source: AGHT+IEHw6iPEI1as1YEaZ3Dnh0FramvJCkja4DBEH3KSGmHUTgI/HTCyWoTUL9KP5vk9sl7JEe3Ug==
X-Received: by 2002:a05:6000:2a4:b0:3a0:8070:8af8 with SMTP id
 ffacd0b85a97d-3a35fe79f69mr10364585f8f.18.1747670755313; 
 Mon, 19 May 2025 09:05:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca88735sm13600780f8f.69.2025.05.19.09.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 09:05:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D077D5F7EE;
 Mon, 19 May 2025 17:05:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] gdbstub: update aarch64-core.xml
In-Reply-To: <swih62.nwehumxno4zp@linaro.org> (Manos Pitsidianakis's message
 of "Mon, 19 May 2025 16:45:21 +0300")
References: <20250519-gdbstub-aarch64-pstate-xml-v1-1-b4dbe87fe7c6@linaro.org>
 <87msb8sqts.fsf@draig.linaro.org> <swih62.nwehumxno4zp@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 19 May 2025 17:05:53 +0100
Message-ID: <87r00kr3fi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Mon, 19 May 2025 15:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>>Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>>
>>> Update aarch64-core.xml to include field definitions for PSTATE, which
>>> in gdb is modelled in the cpsr (current program status register)
>>> pseudo-register, named after the actual cpsr register in armv7.
>>>
>>> Defining the fields layout of the register allows easy inspection of for
>>> example, the current exception level (EL):
>>>
>>> For example. Before booting a Linux guest, EL=3D2, but after booting and
>>> Ctrl-C'ing in gdb, we get EL=3D0:
>>>
>>>   (gdb) info registers $cpsr
>>>   cpsr           0x20402009          [ SP EL=3D2 BTYPE=3D0 PAN C ]
>>>   (gdb) cont
>>>   Continuing.
>>>   ^C
>>>   Thread 2 received signal SIGINT, Interrupt.
>>>   0x0000ffffaaff286c in ?? ()
>>>   (gdb) info registers $cpsr
>>>   cpsr           0x20001000          [ EL=3D0 BTYPE=3D0 SSBS C ]
>>>
>>> The aarch64-core.xml has been updated to match exactly the version
>>> retrieved from upstream gdb, retrieved in 2025-05-19 from HEAD commit
>>> 9f4dc0b137c86f6ff2098cb1ab69442c69d6023d.
>>>
>>> https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dtree;h=3D9f4dc0b13=
7c86f6ff2098cb1ab69442c69d6023d
>>>
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>
>>Queued to gdbstub/next, thanks.
>>
>
> Would patches for the field system registers (NZCV, CurrentEL, DAIF,=20
> SPSel) be acceptable?
>
> If yes, I think defining them in the static core xml is cleaner than=20
> generating them dynamically in "system-registers.xml" like we do with=20
> arm_gen_dynamic_sysreg_feature() but both can work. The drawback would=20
> be that we wouldn't match upstream gdb's core xml schema anymore. (Maybe=
=20
> we  can add a new xml include "pstate.xml" instead)

You could submit to the gdb core schema first (surely they would also
benefit from the patch?).


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

