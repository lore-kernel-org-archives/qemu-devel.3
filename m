Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AD5CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcJa-0003ev-Mv; Fri, 02 Oct 2026 08:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCcJZ-0003eh-7e
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 08:24:37 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCcJX-0002tq-IE
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 08:24:36 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ab402b4716so33779277b3.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 05:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790943874; cv=none;
 d=google.com; s=arc-20260327;
 b=UgPVTvAAqJDmegJwPxYAM7kU3qBznUAu8Cl9tK6Iq772V1synR7DUeuvG6QTjNIu18
 tAOnCD0M5HMEarhzLyUD5XNsLehMOI/YJP/qdLmh/+uozm1t5+4qmd+uzhZ193a/BffC
 i8zln8aGkjnXIWzCpVunT0fgTIh9YfchnYqOPO+Qva1pDa6UgSHdcf7vBu1Rfjldvb6A
 AJZpdc0kOnuTs+uZCgOjIgVeiH8DMPWBPKKJIAjLikDHRYBGuGXycizLh1pdM/qAtnri
 PLy++WMguh+lH0mn3Kfpiy9R8EdXYmFmpeOgv74kGp8kQpS/nrg1Lj7wpc3qYV8XcHQ8
 sGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2NDUa73QpbsUE5V1wllXFwlFydoxfElGloz4pPOptRw=;
 fh=PbRjv5tYea0s8pzu68CJJSWeonCRJ/BmoFu++GPo9Uw=;
 b=Zq71gbXWaB7QB4eKoJwMxNO4RV1hQpPVaP8U9wws4LM/TTeRmVtunPtEs6Y/i+RSKU
 TE9BKGmc0NcaqY/jZs1afLpBhOYoV1vuJtDn+rl7F62/VNsiv3CcqZmkIwYACe41TCO9
 P8u+ke/vokvta3SVlJ0LMWnFv1ODYWDlnMorpv5Y21XR1Rgc6h6MR94oiAUKS+D1Ur7g
 IBs2T4iV9/nQlkKkyJHHRVswDboszKas5oq6qw/2BYQub6bsPQwPry/cvM8asyMe6cZB
 XeZ/hxllocY8Ht26wyLoPjBoiaFjFgVyHPdZVu5QgOI7uio6erohnTK4WS2j1VP2hssC
 YN0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790943874; x=1791548674; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2NDUa73QpbsUE5V1wllXFwlFydoxfElGloz4pPOptRw=;
 b=o18EV2p9GOhy/zdwcYUwyD5MkH55PuGzY/W4a8zsM3pgZpHHRHhOi1lRWcG7heIzl+
 Mfn2ZwB53sgba6LrIPpzlxsk/ur+PacrzHeiiarUvq3nuQ+DORkg4AjsFrT0aDfQ2pCu
 G0euGPsTO8kI/xbK2dQM4yDabSYSeTmk7utVCapqo9ydY0y40AYyFhbduaqG4uso5JD6
 d2sohEl5s4/cQUZo1OQYOIGY+fWhJNHwyI3LlAMU/jHgQ1Puc/nOshSJh5KF82lLIoeq
 ZeD7seVYVtcqS5wR1jEiQzkBglp0KCYPFqcUMZ7eMQ/8EmYprSEGoNdlZLD4EK8aIawg
 cWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790943874; x=1791548674;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2NDUa73QpbsUE5V1wllXFwlFydoxfElGloz4pPOptRw=;
 b=hAgV+SKdoXHgFV3xhD/SxFSipjXg00Jlg5G5BLU9gwAyBd783soMdDr5Q1pNeU4P2A
 vtzDSULcocJWsVZKNAbxiIeaeaOD3KcE+s2xu1iOcv5VNQoIa/RCURRnzKgkDDuhyiE3
 HXHDP6TGpzjyi3IBPkVmw+kQ6JaRh4e6xItJwjOsEuFj74GpKjWUMX1AGQfsgUyc89aw
 6VICIag24VGD4nqqHhEQq6lP78yIuW/AlY4FgukMsEE7QlMvkW/+S2HwJdv01HoLQqXY
 rgzAUV9KQAkaPLkE2uVZz3wd4xv/X8kZcLzVdZll+0Dj0i1K0XqWEX0vIQyDKr8PWENp
 0ChA==
X-Gm-Message-State: AFq9FYKQ/Ojlhf013Dx/4cx5vrEYv0kGNMo40DFO0vO/bu47kV5p6n8j
 Ca6L8vMXmH3nqAhOyYITojDwqxDkq6+348ziqSsGpNczZu2b75to/t7It3jV5QW+rOYMERMxy7n
 Kfq49YMfB6fXGHwewXD9LqkdRb5F7STXCDBsHTepTew==
X-Gm-Gg: AYBFou1iDOAJa9jYiRvqUoEEqUXOBqNMepJ6McoWLCP5vcGdi3Fk/6clcdmQg87e+6D
 15TQb1SDNnBMr6yVGaZpF0OT5BtwsyPt3c+QyVe+6myiIcwSfzATw0Zf3SSBJSjEi6lCUDVLmye
 v11v6dA2vjueQgDgBYWlmNbb9ouNEar9HOhYaYnsySX+seS1JCAS2VuFENlMeGmGrV432+NPBwf
 T9x2uIJvazlqHdmEulNCVLdzMWUNboTjSqIB4EmJ0/+RUyae8HwY4hsyft6IkEUQ6tSoyXYCWOE
 gfFxsTQW330fH4QTd8cPGwzYD7T3FtTXrkmrSDGHJ1XxqvXa9FS3uEgdGY943nOYsmmlIahbl5k
 7Y8aIw4FG9BOVdz4/W0qfLUNG/mLTe1ku4PDpx1OKd1JbkpwwiA==
X-Received: by 2002:a05:690c:6604:b0:8ab:400f:75ca with SMTP id
 00721157ae682-8ae3afdc1a2mr8856337b3.89.1790943873826; Fri, 02 Oct 2026
 05:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20261002114100.3714102-1-berrange@redhat.com>
In-Reply-To: <20261002114100.3714102-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2026 13:24:21 +0100
X-Gm-Features: AclHuK_o3toH1Eky3PV9qNwYzr7rULOoRiNLOX788EKwuYZ4-O4WTa03hcBujcY
Message-ID: <CAFEAcA80+Vu6wFcH6KSbmdO3U=F0PvvTU2gV9a1n-M-19f+cfg@mail.gmail.com>
Subject: Re: [PATCH v2] .claude: delete obsolete/redundant link to AGENTS.md
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 2 Oct 2026 at 12:41, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> From the release notes for Claude Code 2.1.77:

2.1.277

>   https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
>
>   "Added AGENTS.md support: in a project with no CLAUDE.md,
>    Claude Code reads AGENTS.md instead"
>
> If we assume people will keep their Claude Code updated, then the
> .claude rules we added to link to AGENTS.md are now redundant, or
> very soon will be.

It also took them until 2.1.281 to make AGENTS.md work in
sessions with telemetry disabled:

    "Changed AGENTS.md support to also work on Amazon Bedrock,
     Google Vertex AI, Microsoft Foundry, LLM gateways, and sessions
     with telemetry disabled"

Still, I guess we're OK to clean up this wrinkle now.

-- PMM

