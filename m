Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A55FEFB4F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyDn-0003Hk-T5; Fri, 27 Feb 2026 08:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyDm-0003HS-Bt
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:49:34 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyDj-00051B-Og
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:49:33 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ad8435f46so2221896d50.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:49:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772200170; cv=none;
 d=google.com; s=arc-20240605;
 b=cX6bJ/1klTkE7mmcD5srCVkfj+j1P9H8LP3sYELNes2tGm8kD0e5t9XWyvGdCqoVwB
 DfrGfL2vdE8I8ubCUV5buE+Ym1OCEYacdSD0dXH4LHSC1W50Q3dBTeS82uE8tKVOme+W
 32mUgPNr4H2DtpQduMa3LD8zhMyx5Ca70AnYdqfITSN8n070gkOkNSVrvBPXf7yI/FxI
 uCSO17M6eFcsDlDUkQUHJigtMGu66Dt/2VBVDL0NK9bcks3guAvHXvnUSMXRfHBAVQOh
 zcnYqocGEmZ88VOFAmEq5v613WB2++ikYbzcEhq8AiOow8TCrn3VHpN0ZQtrJOqRMTAO
 989w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h4faykPy3QfaB9GmHo91gYE997qEK4iDj3Hi35x6rlg=;
 fh=CEXWF7kyeimEJadJsJt7kuMT1sSCqciADpgEX+sCqSY=;
 b=L3WXiPPdKg6fvFJp3xi55nS7az9URnf6aVVIcVznOD1R02kbUN5W230vV1T/fRDd2W
 hem8Xzl9qziDZh9paOg0xxtQ9ifbJ8ULasl8gpLSYksbpuTMvs6AG0bBDvMOsvIVuCoM
 11oOOlWDQwa87mJzbgjzJKnbO62XgH8ddv6hg56dgPb5HrpnJufL7ck1iyVjuI+Z2GE5
 PI7M5lxGbxcC0JRmA0Xx0ahcSHgs8+iiMJF57NVkCrPOpkhNgkGMe7N3P8pxpWB2vzoo
 Fjr4nG4NAh4tV7yQLNCA8rBe1xsAmA5MJuB5C9Os5zgLQHl7MZmvGm8du8DXoe/LHGd5
 fTMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772200170; x=1772804970; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h4faykPy3QfaB9GmHo91gYE997qEK4iDj3Hi35x6rlg=;
 b=Hp/2LN3JDSgu3cOxUTjX48EyFLTPdFEJ/uTauuLKej6t6qDkJjeIMDcowocU55tFk3
 gfJAlYK7UiVof2sjdo4MKC80kxYB1AfoCQ2Y3tKOdRbTHeFn0/nvMprb+DhJEyZ/FxO4
 Ncr79xsxNL36APifaxjR4zw2wu6UUuohd8UCdfZD0shUdmFyyhGGzYaMvkHfCacSB1on
 r15VUwgH+XFnUJHHfGg9EB2Xfg0xLT1tgET2EDq5uentP6umKdlF9aa2doc2efCXU/DN
 ihNLic+wTBxJWwbidk+mugcRSKGFny6oN6VT96izxWOh4oVWsqUKVvT1NthaAvNyIpg/
 E/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772200170; x=1772804970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4faykPy3QfaB9GmHo91gYE997qEK4iDj3Hi35x6rlg=;
 b=hGg7FylkOyVqp3mWCtAIxaiTmItZ065EAZ/12FxN5evo0si9P9kYzbV6dmlHUr3POU
 LqkMCTceEh8lrASYusi0cPkaM8K3yfUk/gnW1wTavosCs3IgtBav9OrtBHVlC8Q5GStv
 RYGiRF3sH4mG+vIxdXFPZ7+gO8dnldC2JvsLiFOjmnUTyttLWxAF2Xx7jeByvVLW0d35
 uC+xFeNBH4wI8Wmh9rb2LWbluNcB5gzIhHjBOQ0hgdhBaMymdWoxqlboU6tsLNWw+5af
 5mbK8BlbLQy8VT6ZZWszX/wJ4nU8MU0ptPQZ8MTa9FTuUkRfn1h8ZnAucpGCYuw6J/1A
 Q95g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLPOMmvDWPDy0YwWZwlLNdxMDyF4dgHNKUX5WThcLYdKIfHCmdX6UQhVahot8LTEIQFNYZOoIgJK3y@nongnu.org
X-Gm-Message-State: AOJu0YzPIs9XEf99unoZjSocPn9k7fy7gIPelz+EItc3OA+gIRwTRebU
 P9UFXPTTFizjaX7e1JgU148v/Y3fND0uRWGjUMFIcR3ljld7gd53YnxNpaz05knUcKWwJBSiUPj
 y9CikCRHXFM28lITJ20qJRA4dJ4RPhsyBMUN1Mug81Q==
X-Gm-Gg: ATEYQzxj1WLfHC2s1Jda501UcSVVyYDcCqIP4+kLEryh72gtEawa+CQ9UCkD68Gg6bi
 ivLCnTuandEJinx0cEF1KdBMCqXtrXNgt/FnDguu+NkpyZgN84+tbFYP3bPf4qf8lf1zJcgUJUl
 oUk9cEzScFlwpAXpNFy5rtbQ8G7tdd4cUEuW7bIfp1UwETZjnPHLij21+G6qlRkALpxBI+y5jjR
 MwyA8yPNK6yRWjSCO63qtItVV1PTcU8P9HjjNPi6VDrPaVzx7uiS9BlKIdKR3TI1UC0ft44b9b7
 uGGQ3Boinx0zMinqQiO28EzM7QLEQk+SrQB3YNjyILiqLyDkOuVVA185jVqbYY4ZaJA=
X-Received: by 2002:a53:ef05:0:b0:64c:a2f7:b49f with SMTP id
 956f58d0204a3-64cc215d620mr2041949d50.35.1772200169710; Fri, 27 Feb 2026
 05:49:29 -0800 (PST)
MIME-Version: 1.0
References: <20260224181440.832943-1-jsnow@redhat.com>
 <CAFEAcA-zsPN0Pbg9USt2dWCD9+iONr=bCGDaxomysn3ubqx=gA@mail.gmail.com>
 <87bjha9yea.fsf@pond.sub.org> <432BE3EA-839F-489E-A535-6A08427F8B86@dlhnet.de>
In-Reply-To: <432BE3EA-839F-489E-A535-6A08427F8B86@dlhnet.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Feb 2026 13:49:18 +0000
X-Gm-Features: AaiRm5153WTwpSuIK7XfipN0azx9Y-VW_XkzH0EN84zHv7ds2ERzj3Ouv11zPBE
Message-ID: <CAFEAcA_HuwNdkGW5OmE-8aZDEpTWeAfDh5HftG70s2X3LqzODA@mail.gmail.com>
Subject: Re: block/nfs.c and libnfs vs Fedora 43
To: Peter Lieven <pl@dlhnet.de>
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Fri, 27 Feb 2026 at 13:37, Peter Lieven <pl@dlhnet.de> wrote:
>
>
>
> > Am 27.02.2026 um 13:14 schrieb Markus Armbruster <armbru@redhat.com>:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > [...]
> >
> >> I guess for the moment we should fix the Coverity build
> >> by dropping the --enable-libnfs (and accepting that we
> >> don't scan block/nfs.c any more). For the longer term:
> >>
> >> * does anybody want to update block/nfs.c ?
> >
> > Plan A: somebody does that.
>
> I can look into it next week. Does that still fit in the cycle?

Yes, just about. Softfreeze starts on the 10th March and
changes are supposed to be in pull requests before that.
If the required changes turn out to be fairly minor then
we can probably let it get in even if it's a little bit
behind on that schedule.

-- PMM

