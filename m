Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF55CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRp4w-0002yA-5F; Tue, 26 May 2026 06:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRp4r-0002wY-9h
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:32:03 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRp4p-0002vk-Nl
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:32:00 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-651bf695701so10019002d50.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:31:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779791518; cv=none;
 d=google.com; s=arc-20240605;
 b=iocwVwAuphTH3rolLRbVDixLD0Pnr2MSKfxExU1j6FU938AzUEk1yu97kmTGeDKqJ+
 p1detitnl8yQWGbMpHaiw0791xO97SzNskILXufeCOe0VKG1vgDLowL0exWQXwyBIjIu
 GqwLxPPVMekaE7Up3RurZMIDPTQ2Fu1ypoL8v0J9oSuLOV2IHS/o37dgVQcrNXoklZem
 KabXcUK8ysg6denmZSsshU1t7u/BwFAK5DraLLYv0YPEcl2sO9Av65YYnkq/c5qM4haR
 GgWqfBWV+Xg9CER8E1+kGHJrWZwGlmw+CuQwf3dGhy9ddscsObylq+w3oTbi807X5rFi
 HCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CdB3Xeo/RDXmP5Hwr6H+wNirmuNzl+E2KmzTP4eU6wI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=esfms3QYPP+ismez1HesNWfMNHpI9+tqJ8jQyRFKr7prjY41XX7jY55BC7dXIhASm9
 /+I8R0Vi9/QCNRMvgsktPYrEpCfEEno2EjRGZIlj53Rzp4K1XivEMmWxsTaYSXQfrdtO
 erj/x3XzhTih2xFoOXLh83JM6p020Gh9wn0oVpLqahmXF6Tptpq3fkr9y8p6xs7UwnVR
 +ufVI6HfMxCjAnzx8NcuhAuWCFVpK7pO6TdPYymBx0QuFJWDSjlyAX0hQwJyneqDTGOk
 V4ib3lhrRNVoi4zM5wVRJLuTcnQAxlkKrj6elj8nRtfNOxGggjbu2FMGLfE8rIvX75dl
 0F1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779791518; x=1780396318; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CdB3Xeo/RDXmP5Hwr6H+wNirmuNzl+E2KmzTP4eU6wI=;
 b=xbtWwZFJKE9wdQKz8LFXv25hSPZq2ESDDf5qWyYIPtO1dNBFAEd33KM4BBv9oOZK4M
 XWg9PP4SquzKRtbRmGzcuxHV9XdYHbcZmtQLAcntIRlNg0z+4B/Ikjy3sadVyd1Jd+x+
 GkVCS3AkFHQ/XbQMv6gTBGCZJJg17CiwllDOUtq3ZKmdFPex56Y797bXcmkwos0xWf0h
 H63CwbZ26G1ufNSKp7LMI3o2rAK2WZf2hO57LqZyENERIFMHvehO3HJlPwvYd3B1RVhb
 PiZx34qrvVtoP5mEfV0Y9BC3lI6VYk85TZr0TSIpo6WuSXY4eu4jXS3gEi1urylwPW68
 M93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779791518; x=1780396318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdB3Xeo/RDXmP5Hwr6H+wNirmuNzl+E2KmzTP4eU6wI=;
 b=fd1LXEsHufQeR5LDCzYRgvtOtQNhxq2XKOzwcQnQl/qTfvHNtJcgAlxUGejdHej4sm
 TQuDS6b3pgGlieTJGQnQgphe5Hsuzqy59GnDaZPqq19CPvDG4zpAvFxbj8w+PnsxDkJ5
 X29aw+971v3eSezmwcxkuAoGvztcSRn+5RcARzeRx9PmtvPdY39pUqz2gJEERBcL1bPq
 TAkZwlIRouOZirPKYnNEWmRUjDf6Is8rEyClG0yyNQ6mU53NSk74nRHSGYhm4FwBUNZx
 NXsIQdYtqA97jl11FZOvs2UuJNfn9qLCPboEHfQf2Whk0F0ZNWJjdZaWsbEkrOnKs9Pz
 9NCg==
X-Gm-Message-State: AOJu0Yz4z3V/WAXWMnilReGACJXd9sDYMCpHVB4u6SZFe00f4ZphRBX1
 c2JMntkDDVwduoVRu6cnbuHdcJRMzxe957AWrOMjl538tdPQbGBsvX6ygWFlc22aWiOzrqwlTKu
 Sv04Ija0QHL4D7bSvH1r2tUk1RRQXe2EnYkVVT0vILA==
X-Gm-Gg: Acq92OE4zzhF9eH1D7gexL14ikZq93aTBpTsuSPYg+ZLssn4a/XMG79yBqnFPq3KCvO
 a5MJqD0hITMpka+JMz1LHCoabQ3WdAoxVud0mXawPoSOC26Upqce4R+ZvYvOYTkjcGtPVBDRg1l
 FVPbnaHSxmYLWxZewNs4Vk9uvIT7YQzM/wlPCk+kuDvPna7QuxSLt0Hfr6a/ADr/koyt5tyFbP+
 uLd6mgVHuu9ThN3zxQ9VcSKLtGCtcxP37NZjIhB2udS99wydWENDnOE8bizMV+/Dl2NLjJcDFZv
 08R4XeRiuhlOU7ytLOPJYvBqSlrIK4xZFBT8ZPYJzFWUj6tJOYQLPOcm0Vm2Li91kuA=
X-Received: by 2002:a05:690e:4844:b0:65e:41a4:54d2 with SMTP id
 956f58d0204a3-65ec98d662cmr12268126d50.32.1779791518107; Tue, 26 May 2026
 03:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260522220306.235200-1-richard.henderson@linaro.org>
 <20260522220306.235200-17-richard.henderson@linaro.org>
In-Reply-To: <20260522220306.235200-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 11:31:46 +0100
X-Gm-Features: AVHnY4IFc21ZkDYeOmP5SOvU9FXHwRAU5aY35cUDb5mhypfKxGx8rRpIrRa3KjU
Message-ID: <CAFEAcA_DGdtL534Sp49zq9dnt7b4fQEFc8f-FvoT0KU7bvd_Bg@mail.gmail.com>
Subject: Re: [PATCH v7 16/64] linux-user/aarch64: Implement FPMR signal frames
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 22 May 2026 at 23:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/signal.c | 44 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Side question -- have we ever looked at whether we can run
the signal-frame test cases in the kernel's
tools/testing/selftests/arm64/signal ?

thanks
-- PMM

