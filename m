Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9D0C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1hyU-0004tl-KM; Wed, 02 Sep 2026 06:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1hyT-0004tE-1S
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:13:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1hyR-0004WQ-Dg
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:13:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso8116475e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788344021; x=1788948821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YVTyk7o36cWXqKvE2J26PLdadcd3CNxEAtXF83c7IH4=;
 b=TaKtl0gErlI2G8XzQXmu0voKTSBF+DuaeZY4frbA2E3GB/tPCCGVwwI0U2AGPxzUcw
 5Vqe4ykhlLGjQvaP7wq1M72UAjMGbD5vNZIP7eEeAnWCrdoCg99bW/GLk0xygRtyC6f6
 sfKBRkMrZwj3Jd8CzMoOYck1Tkw/2eucep1KsTqgE0fU63EiWGmLqw/9ylodLgJThaa8
 MGQwAAOFmSgpAckPg+bMd2U4iBnsGpoFTjk5dLCBghn2fk1ff9GB6soQPELYbRC8ophE
 csfvuyBbEQQrLcZhRoqf3h8i7ycPwfAXh3syInVdNBADdKtg/dFIFltYLgiKw8hOxIDD
 uDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788344021; x=1788948821;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YVTyk7o36cWXqKvE2J26PLdadcd3CNxEAtXF83c7IH4=;
 b=f7p0IG/uFmo5JZdWVltfifryOvlwV42Zxjdju+KchWAngGnLWwDy6dEbcUGofe8a0Q
 VDYf9eC6LaQk5L0V4TNkdEjhGNYjYaSCi7yOOSNlCBmQCxcRmbZDOjPokxRVmXJf61w7
 SsflABGFiBcKmgrGbZahUE6a8Xm45QVVDDeUHDGXtUyQnKqkeVgYg3Y62fVxjg9JVuvv
 /4HhUTnAeB6EVHPUWXerttOQvUr+KuuD127kEOLG1DqvfYm3odo35650gpgt6Ap0UCJN
 8aFq7SCNSTiBP2cAtHn+OXMz9NNNTI2sqRcoaYOVbPe4UmpFRVnMnVst1ZS+UCAxYUFu
 xbJQ==
X-Gm-Message-State: AFuF++m5VrnlIfxBq4L6Ul6mz4fFhKPf1+DmbeXCjpuQ/S7gCuaDV2g2
 Y/17AIazPK7xV8MVeYVVBmLwWQP/VVKlSxby7Mr0M10ONIVb0I6To+YDCHzMPdP61lI=
X-Gm-Gg: AR+sD11VP1Qq7oVnuF88h42SHPsS7Ba1MmOYn7nByTMz5MM5vf4yuPYE22JVCDj0rBn
 nMig4/12DgNWv7bwbwWzYq9Nw/3eg6b1Yne6NSs1anGl7VHzC/PnbvuNiK83y4JIfBAwMikWRLL
 O7o4HhGSOGqT0q1xCiFtkGbofmVKUazcrfWqTXm17uIEOVaDUUVx6QDQ1HVBpmT9urAJbWiOFsf
 hJajBPHHOmz+ZFzZGQ05RQuN3B5F6mPgSyEdkqUtZeIzMztLNQK9BcLQXokGz5RBzVFcRUwqUbn
 Ok7gtjOFfBWVQl/To3TqvSrXNQVJXbUfJanrIjzt0qiasf3TKpCagQkQVJYB+jr+Aae5vspYg/z
 inok5dQ/AYYWJGLHhqRMTUnejR5iYAi8ZUurMFpRxRWHY9c8HQiP4bL02Pf67/ANYoWZqaJ3lgs
 fxg9pjmkYKngA1iI0I6CI7HGDEqY4YGWUOCEIDjaltyqwM3UQmqTe53G+rSWN2
X-Received: by 2002:a05:600c:8718:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49ce7c03f46mr31756095e9.3.1788344021350; 
 Wed, 02 Sep 2026 03:13:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce0b456sm158458845e9.2.2026.09.02.03.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 03:13:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 033145F85F;
 Wed, 02 Sep 2026 11:13:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: gilles grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Fabiano
 Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH RFC v2 06/30] hw/misc: add RP2040 SYSINFO and SYSCFG
In-Reply-To: <AC79D616-7FD9-46BA-9761-CC64E2E3E056@univ-lille.fr> (gilles
 grimaud's message of "Wed, 2 Sep 2026 01:29:43 +0200")
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260829234308.33725-7-gilles.grimaud@univ-lille.fr>
 <87a4q0u7ys.fsf@draig.linaro.org>
 <AC79D616-7FD9-46BA-9761-CC64E2E3E056@univ-lille.fr>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 02 Sep 2026 11:13:38 +0100
Message-ID: <87h5k8rmel.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

gilles grimaud <gilles.grimaud@univ-lille.fr> writes:

> Hi Alex,
>
> Thanks for the review. I have looked at the impact of these comments, and
> for v3 I propose to:
>
> * split the current patch into two focused patches: one for SYSINFO and o=
ne
>   for SYSCFG;

Yes

> * remove the powered-off memory overlays. They were intended to make CPU
>   and DMA accesses fail after setting MEMPOWERDOWN, but this goes beyond =
the
>   documented register behavior;
> * retain the documented MEMPOWERDOWN register state, reset value, and wri=
te
>   mask, without claiming to model physical ROM or SRAM power gating;

So is this modelling individual cores power states? I'm still a bit
confused as to what in the model will be accessing them when the cores
are down.

> * route PROC0_NMI_MASK and PROC1_NMI_MASK independently to the correspond=
ing
>   core;
> * remove the MemoryRegionOps.with_attrs callbacks, since they are only
>   needed by the powered-off memory overlays;

My preference would be the other way. The with_attr callbacks allow for
richer memory modelling. Indeed if you really wanted to model powerdown
state you could keep the same accessor and return MEMTX_ACCESS in the
main implementation without needing an overlay.

> * remove the per-subsystem RP2040 Kconfig symbols and build the internal
>   devices under the single CONFIG_RP2040 symbol.
>
> I will add focused qtests to the separate SYSINFO and SYSCFG patches.
>
> Does this sound in the right direction?
>
> Thanks,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

