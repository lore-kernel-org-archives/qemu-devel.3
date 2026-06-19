Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15691CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXgO-00023q-V2; Fri, 19 Jun 2026 07:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waXgN-00023F-L9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:46:47 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waXgM-0002A2-6c
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:46:47 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-46066e640easo1256201f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 04:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781869604; x=1782474404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jCXqjMIfTL9SpkiXIR8q9zvAP0noQkzfpusx/rSbEA=;
 b=sEM5rMj65T1vDKnXesFRO/a42StERRuK8t3CrygLeWTUyZR2Q7vhvMx6N0D3DYSDyV
 qepW2nwyLeplD8KhEtAtTEViyz/AwqhavdNBs+L26xz2ws4oy1C2+uXR2X0x9QIEhzHK
 /H+GLFECJwzlDYf5Q1U+hY+nyZ5Jvm0t4FCaWavnNZCADqG51n5ZCBvYAOliUxRwaOOI
 LwsNtYOViV5nk1v2v0AceKKUjbJNiwSxPxRODArI3bZy+k+jMEZ3E1McRBn5dovjxEY4
 vVP/YB+azZEMFKsILQGX/Ptte84bOJ0hyhJB2KF9cYV2PzcBUC03pz0OZR6QhXGkCVA7
 apNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781869604; x=1782474404;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1jCXqjMIfTL9SpkiXIR8q9zvAP0noQkzfpusx/rSbEA=;
 b=HbpPPUoukyAP+tv3QAdMpFfuIN2Bgm5I24dQAWNm9ig15F4Yp43ymNMbvfR/0MCPM4
 exENgWAo0vPvowgNLzmf/8Mcb9Vi+Y3E4GHd3BDKEwVaJ6TwUIVcC9MSq62CokAfU4Lu
 +THBPkXPS+ointtVXLN+KWU/itZ4zwzfSuLRSQJ0g7tqwKAjc6S8dDqQfL61pgW8Jqu2
 ZifarcVqB8iYPYqp7XhQXtbZzA5Hycyc4MmNq5dFptPDTnY1T+ESSiXMtvzmlXFlES2r
 KZdKBtaoWvksmRBpN12ORmu8/1PsA65DqlgVOZk7SoXdoornRJ83h4nR4EfovPvf35xS
 sxrA==
X-Gm-Message-State: AOJu0YxUFtyBPzm4DSVpBBiWldyEFzOzQFu0QjLGJH3xgYZNe7XGqq3L
 VhPepajdhKsRt1T3FISIRKMlN/fzGPZAuo2T0c42fE5uOUaCU4+2DEUcboGcTkMnyH0=
X-Gm-Gg: AfdE7ck6gv3jB8w5DPO05EHfnCj/vTglhYab1fmCEI1zFndngN4KVk1wgegAs2VQEE8
 d3uhnrOgADZ8JHCHGxdGxriK0rIBC+U24gdpPb7oQEvIUPhi6ZElatNGDoRYZ+vg4HzEaCyWmYJ
 LJ+Jg1zqdkaKY/KTyjoWssa8c839K41aJfNsLC3Q9r2dmAmcJ8YXar69ChLMhmpcls/x/jGqjLV
 thM3Xgd3o28ySz8WEeF9voCGNzrMc+52eMaAsEOXbwbZQyAEGRuDeXjcGcgn9n/+Np9DdRlLfRe
 U2iWrU8UF1LZIl/NIsT3Je++v2kyGpJviPdwpJ2yPIPE9j0UBhiCo4IjRU49n6KhTQWHkIL+dzp
 BjyWN9H0nA6hFo+nLKbXQIoCEc8JRGsQ9feFhpevISbhv+37jJu8RvLDqGftvYURneR+eElGbQt
 ZxcbXYHqlQybTUL1Nn1uQWcdw=
X-Received: by 2002:a5d:5f82:0:b0:45e:b99d:dad with SMTP id
 ffacd0b85a97d-4650a32ad1amr5771364f8f.38.1781869603614; 
 Fri, 19 Jun 2026 04:46:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650b67a3f3sm8248787f8f.20.2026.06.19.04.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:46:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBD135F7FA;
 Fri, 19 Jun 2026 12:46:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org
Subject: Re: [PATCH 2/3] tests/tcg/arm: Tests for new FPRCVT instructions
In-Reply-To: <ajUg9sIsy9if_JM0@linaro.org> (Jim MacArthur's message of "Fri,
 19 Jun 2026 11:59:02 +0100")
References: <20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org>
 <20260618-jmac-fprcvt-v1-2-1b4475bacf51@linaro.org>
 <878q8cgeux.fsf@draig.linaro.org>
 <16d97ff2-7e12-49ee-be1f-315f1387ba71@linaro.org>
 <ajUg9sIsy9if_JM0@linaro.org>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Fri, 19 Jun 2026 12:46:41 +0100
Message-ID: <87ldcag3by.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> On Thu, Jun 18, 2026 at 08:04:27AM -0700, Richard Henderson wrote:
>> On 6/18/26 06:25, Alex Benn=C3=A9e wrote:
>> > I'm not sure about this as now we have one test with two modes. Can we
>> > not just create a new binary (fcvt-fprcvt) and keep running the origin=
al
>> > test either way.
>> >=20
>> > See how we do that for the sha512 and it's various vector variants.
>>=20
>> You certainly don't want to be duplicating the reference file.
>>=20
>> Perhaps test the v8.0 convert insn output vs the FEAT_FPRCVT insn output=
 directly?
>>=20
>> Also, this patch is ordered incorrectly.  With the instruction feature t=
est
>> properly in place, it will fail without the final patch to enable the
>> feature.
>
> I would rather not duplicate the reference file, but the other options in=
clude significant changes to the existing fcvt.c test.
>
> We could:
>
> 1) Make a separate fcvt-fprcvt.c test which compiles with the fcvt.c test=
, needing a header file for functions - requiring a much smaller separate f=
cvt-fprcvt.ref file, but information would still be duplicated in it
> 2) As you suggest, do a direct comparison between the general register
> and SIMD/FP regs, but since the current tests just output strings, it
> would require a significant change to how the current fcvt.c works.

We'd still keep the reference file to validate the main case though
right? We would just be inlining the SIMD into convert_single_to_integer
and validating it got the same result as the main conversion function.
It would be quiet unless it got something wrong.

>
> I will probably do the second option, but if anyone has any other ideas I=
'll listen.
>
> Jim

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

