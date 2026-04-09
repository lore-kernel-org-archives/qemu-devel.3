Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42436F364B7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 20:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAvq0-0000wv-Ts; Thu, 09 Apr 2026 16:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAvpz-0000wl-KW
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 16:18:51 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAvpx-0007n3-Ut
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 16:18:51 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6505ef94043so1400139d50.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 13:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775765929; cv=none;
 d=google.com; s=arc-20240605;
 b=GsqvqamZkPRUV/3gadQYy+mxIpPQ1f9FlooDNwKiA21EoP6PJ8vcOrw8ZMaG9B4ane
 6n3bjvc83ukH+WSHZK9OLJjYtkpxyWBVTHrhExNLRQlYCOPv8I5f/lzG9HMCKpWsU78l
 c8rKRJU36dcvypcHRK3f4fhYL8J6HnTpdLNIlqG407q71Kz8Bx3exlkG3rnROLtT7X4F
 jxHElafq503p2Yf+zEowbX0yhtwqC3z4zQPHHhLfc+xNp2ghe34bMAsWf97DN70nF/9m
 ePRdaGsqduzljwJ5E57hfLl5XQKLMTB1dwj4CfcS/ZcAi77joYfspBlbtiv44diU/lsw
 WV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4plR2ELqZYXgy0a8tUDJL86AodK9YMya5DajTn+4JH4=;
 fh=JqUq8MrIlWC9x6+SgSpz3yeZ6a4MgfoXe4ZGO/gz6y4=;
 b=eaN2OhcyCYAfLg3sMCO0cAdJmo1BqxMFdI+9y71i/5zoW3/rYdOgiIaCa6vpCIaZy6
 EJ11slASIkw+QDuBtJymiQ10x+0DVSoMBafzqM/1ezU3NVM0e2knpkQygy1BA16HSbf0
 nFg0AGOlX+iWRsmf+O0f0czlXfk/EaQ+x9mr/PFVMO6Q54yKMCZ5QHwBvpPNfr0rKORZ
 agD0y7L/nnCIRrIbi4r1PP62xmeVP5/op0fFEMenwoRqCZD4GYaUxkLrzqY//oajlOU/
 PNsXskfU2RAhoKzlJnTNH8llufjWKSeeANCAXEA1DVSH9E24cN55utLI44HVpQ8QlFTN
 atQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775765929; x=1776370729; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4plR2ELqZYXgy0a8tUDJL86AodK9YMya5DajTn+4JH4=;
 b=nRk/sVZtf1X1k8yQNjEc7FBsr1On6UviENUDmGUk/BwK8WkL907hMRivD255t+Sw5o
 BzK56uDHIqKZj1dQxGQEg46WdaUDZbZW2tZse5Kqt8UPUaQ6apttZHDeq1bOaJBbvKrp
 iQ9HRDrH5Z/Tfhb1zZHtxOPl1ajWdZ8LOFlkndievA3krCULVcXzKAOLUDsDrWitlVQB
 qK033YQuC09NWNTGNyoQi40jscIZD/988GXSHg8rOpFugEmFSBOesPFMWtfl1Y68xt8f
 +HZd7MckPjwV3D+bmTIcxIALDCafelZlvm2hMrRkQ2PO+EZYxxxnoZuPeBO2g53tT4yd
 ibag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775765929; x=1776370729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4plR2ELqZYXgy0a8tUDJL86AodK9YMya5DajTn+4JH4=;
 b=HiI9XveaxyRrLQxvTfQ41ynzocjdrWXaQrbeUXhjzLtZ4EfWE7j9eIpIPiJyr245as
 34OBhnxdQLEtVHjMtqE9kLnX7Xoxy6Y+wt88daTSZZXXWBTLw0HcwaMMrnm0TMwq9Bsg
 22dXUUXadb0jBWd8lCbKD9kzETrxc2LKFwC+XYiPxbSyuwEvmdmDjbpuHCL3uPYZXKXF
 GdWReJEjd5da2YgTwqSgzFEU6AIipjfRBRrklm1n1/XHxCpWqnf+X4uWVxZkwtmMngea
 CgPD2hkGiF4OGlT52i1XhtqkNZ6JIk20TjmYdDdtGcBCL0xR2KER+m4pL2kQMjj5kdyb
 CtNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx9abdwUyjhrUD4vFnLaFQPjh1btfoyWnyCUzREuPDMQSXB9ldJblyXkn5EIu1S4dhj3ci84Ruf6hp@nongnu.org
X-Gm-Message-State: AOJu0YwyICWfkwt1boq1+yNVBlgVdPhFHupUIps/i4N+RelXNZR7hjzN
 ElKevlalGswP4JfoAxyQy3Bhr+5qGuIDW1cReovyoBbZvgRgwMjiG/2Rz+tzTm/NYh+8UDws6DP
 ijtc3XLziBl+sF6XHAn1bcIMCf7rEGey4xJIAh9wt1A==
X-Gm-Gg: AeBDietLIcbp3WPgiHJMvLplGwDwtsyLK7Hb3EPO3NScA87RkHYAaWH76DSVLbw+59E
 tb7z3tnNlDqlVnQS4M26BlzJ58l2QYy1yCL+omufAd9zsz6/jAIlJw67H2VFUTidykvTnOXpEp0
 U8Imh8pBRuPGh0snVS+oYfE5eYKk5z8QcID7z2nlovcyILrQXtPIAImrnHBVHneAiGqhlefvNI+
 ECo0nRJh7wyGWtf3QAI+I9Km53Fu9y+iCqLEqeIwUmqucYxBz0ZJy48irZmIwTwaPoaMR6dNblh
 JtsaO/RyCmsxLc4jiDSILvThLHH/EXRqxI/Vr0sAN+L8qpIByYDHoczeyg+P9Ssp5LA=
X-Received: by 2002:a53:b174:0:b0:650:8923:5618 with SMTP id
 956f58d0204a3-65198bd4155mr288604d50.57.1775765928729; Thu, 09 Apr 2026
 13:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260409110256.684-1-anthony.roberts@linaro.org>
 <87qzoo9vzu.fsf@draig.linaro.org>
In-Reply-To: <87qzoo9vzu.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 21:18:37 +0100
X-Gm-Features: AQROBzC3wDWKbiJK8Q3XOXR-HuMw_NfQAZHN8d_A6mx5NrUtx0zgYqHt4KnMGkA
Message-ID: <CAFEAcA_yjPkAtM0FJLvXGUykxX6Y-HyXTxBrrvWEaLUEpHfgTw@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: Fix assumption of EGL presence at runtime
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Anthony Roberts <anthony.roberts@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 9 Apr 2026 at 13:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Anthony Roberts <anthony.roberts@linaro.org> writes:
>
> > The original commit had a section of code which worked on the assumptio=
n
> > that if OpenGL was enabled at build, it was present on the end user mac=
hine,
> > and calls could be made to it. This is not always the case (such as Win=
dows
> > on Arm devices).
> >
> > This line should have also included a runtime check.
> >
> > This commit moves the relevant line to inside a runtime check for OpenG=
L.
> >
> > Fixes: 52053b7e0a0e ("ui/sdl2: Implement dpy dmabuf functions")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3347
> > Signed-off-by: Anthony Roberts <anthony.roberts@linaro.org>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Applied to git directly, as requested.

thanks
-- PMM

