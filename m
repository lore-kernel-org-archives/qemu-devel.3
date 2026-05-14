Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839AFCD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 12:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNUnb-0007K5-Ow; Thu, 14 May 2026 08:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNUnZ-0007HC-S2
 for qemu-devel@nongnu.org; Thu, 14 May 2026 08:04:17 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNUnY-00021A-4H
 for qemu-devel@nongnu.org; Thu, 14 May 2026 08:04:17 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-65c305f381eso9907372d50.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 05:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778760255; cv=none;
 d=google.com; s=arc-20240605;
 b=BWPM3yGd2bFLMGWOl9X7D82LaLc6QXTEpP7GZTOivylWJycarma1TaFnKnvoCDq+5C
 bp7lEOrKqsj1xofOMXk0JXfLrSE7Mxh+VGfsoTU9JBrfvBStOrvbIXry/KRN0c+8DZtj
 6F7OaQuarYbeT4wTcvD8A9w6TC2S4MFEl61q5pIhwjvFGiBTXfSNEd+HbJcOyT7YtaIY
 Ro83JYDjixqiPR0s5XkmGedEcER+RtGNuNPFaK+vuxVCtoqE3Nv/KnE3Zp09vP0CiIz2
 1jmDbqHyM4OIA0pKAA9B0OErejUbvN72eTDb6YG6qbGjFIMVjqt5kA4uNmlHAlbVwAHt
 TcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kjhUwzMrVgD5GhEbpOQmXeKw6TXzwDB+Jv40ww+PuNM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=hBuSdjRCp1Jkbvw6tyDqytA8l4L3JYa1aESYDg+tDQj+4PC2kEf4WXCONvOKVgwvB7
 KFAxa8J8d+tNKjVg93hMw+2wZcCmshVLFx5fcaLwDF6yd4L+I3GBdJkaDDIftFB+vs2b
 y5EJiAReotwnFPsVUDI5c51EWz4TJ+sscs/w1Irvb9UYMEjNpWqsfmUCUHFOO4tVMGpP
 0L/+WQuKRl//vkhyITCzi+SzAoyQwz7C7BbzMMrEuQPthaBvaDmqb0szFkcP7kcjW/H4
 wUFj+Z94mIEc2O9Zrfugz2g9dd/hsLLg/7n9fbo6QcTKmeIHG9VvEVmL6v1UHf43Vkhl
 BdEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778760255; x=1779365055; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kjhUwzMrVgD5GhEbpOQmXeKw6TXzwDB+Jv40ww+PuNM=;
 b=R0P1/ViKhyojkBu6EdAiV7l3QuZgSJu9FZGuK/gfzXIQGTnJWRk0kfZ3aybdtE/YsM
 6//NkJ3vz9D5k61+Ej/Tfe2WTXHTj6a8tNl4f9wkv6nXxbt0YsJiY0My8+/lln+8i2Ym
 N/ig3fN7bgNm0o3/PSDvljh80ijfwxRmjvlnVS0Y6kApkhsimq1MIM/tYlej57SFcVHX
 iqpu26igUvVKhvn+SZ5cvNY2fk37X3YO6grFco6OCXsnQ4Njc8374Q27VjSa35DaP6yB
 9q2VW34/qsaNdkYL5d7cJwC4AEKXn0iwblS7OOvH/XV+cBbcQTh4eNij0aMFD35UDT3m
 vq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778760255; x=1779365055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kjhUwzMrVgD5GhEbpOQmXeKw6TXzwDB+Jv40ww+PuNM=;
 b=pwc9fqP+zxfSURwr2GMvr9BkowGDtb8qkr0AjMOSaFIxiyjDvlYucVyyLUH3ZCXNaS
 +B3c4Pln31lv42I7jxWlFErrcQPiUXkk13vhuDTfZYjlVQ+loaHq2MMIFY/0eUGRfgOi
 lHafMRByXH6pvLWOYUFVNNChRd0CJeTJVyOfMRJCkyCT/eo1jPj4uD0f9f5RPliZfBHS
 lT/c7kTF8/S+RnVVpJ/WS9bhk6ku7HEHXas+OBbySqI8FgKSp0g5ngsLyAImuun+ewgu
 fO8dmuupRalvq7v7ryAXs6GnecRfRz7UnmFn/hTNGnWBwHyFU2dOPU5OmFfPU5xeC4OL
 j4FA==
X-Gm-Message-State: AOJu0YwWwjorsifeeoa6FPurCzdZNi6jA9teyJ7FdcXWYhwiBBiYxIsK
 Wl/T393uJX6/HLLlgkF9rbH5pH4JUikSHniteuC1rRkRmpDXikP0hingkNGhQG/Sttxx5HNgutG
 3/0Lhdb7qfgxaf1YzpwgU4g10zCPEhHWDojHNB0Cujg==
X-Gm-Gg: Acq92OGpB06CQUHU3E2NajMNHOnJBiwPsmXpH4yvM2f5HMmGRBe5UpvPGfB4XlKJzGX
 7J/WMtEAUfhLOvKI2V2AKjgd3ET6W4cIh6PCwKcAs/mwZGD5qt9hOre5gPm1wvvIqBldTaoStAZ
 Q7qqiOz6hrQrIH6m9HfHhZhHbyQO4Rqq2/rkyadHeNj7DzCjTRnff5qrG31KdDpf/SaMiV7MJBa
 WAX0qqFsDAVBJUm6YsuJagRF2bjd1D7O1weIWgTpo2gy3OUhnrfnYmTegYDwkxQq/UhMAW1YLm/
 SEEISFxMuGLtXSJOdZ0nXsE0KjdgHr73Jvp5knWSvsveMdvwpZouNOfro2c8TfrTOJzwKCs6rwe
 yfg==
X-Received: by 2002:a53:b750:0:b0:65d:b6dd:69f3 with SMTP id
 956f58d0204a3-65df635cf7bmr5311259d50.36.1778760254126; Thu, 14 May 2026
 05:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260507234413.643512-1-richard.henderson@linaro.org>
 <CAFEAcA8oCde3+2gvLL4vvgu_MiUjvic_nbLweO1WF+nkNuzgtQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8oCde3+2gvLL4vvgu_MiUjvic_nbLweO1WF+nkNuzgtQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2026 13:04:02 +0100
X-Gm-Features: AVHnY4LsKav_ramfjmNnBJDiMOK2ZAu1trJa7kuoWVyiMuob-pDdpSlAnhtv-K8
Message-ID: <CAFEAcA-6Bu8U1bDwpWq2fP_mb2q3-SPnAdhQ=v8gO35EA5PSfw@mail.gmail.com>
Subject: Re: [PATCH v4 00/60] target/arm: Implement FEAT_FP8
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 14 May 2026 at 09:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 8 May 2026 at 00:45, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Based-on: 20260507160959.449170-1-richard.henderson@linaro.org
> > ("[PATCH v3 00/11] fpu: Export some internals for targets")
> >
> > Changes for v4:
> >   - TF-A firmware update for FEAT_FPMR
> >   - Rewrite decode/encode of FP8 data types
> >   - Rewrite FEAT_FP8FMA helpers
> >   - Enable FEAT_FP8DOT{4,2}
> >   - Enable FEAT_FP8F{32,16}MM
> >
> > This completes the set of 8-bit floating point features.
>
> Do you have a git branch with a rebased version of these patches? I
> had a look at them, but as well as some mostly trivial rebase issues
> on current head-of-git I found that it doesn't compile, because
> this series wants fpu/ to export a parts64_scalbn() that returns
> a value, but the version of that function in fpu/ is static and
> returns void. Did some patch for fpu/ get lost ?

Ah, I found the scalbn patch that got dropped from the fpu pull,
which looks like it was the missing one.

-- PMM

