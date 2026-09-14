Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1EBC88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x685e-0004cx-Ph; Mon, 14 Sep 2026 10:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x685I-0004Jw-O1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:55:10 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x685H-00063t-41
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:55:04 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-671061b015eso3404518d50.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 07:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789397701; cv=none;
 d=google.com; s=arc-20260327;
 b=VqDBkXdxgGQK38As69tVABYuPYmrcoqBbYJyG+9EM1pJ8Kknhw57/dIDZWyIs0IHJp
 e6I8iLalS1azo4mrXSqiQMDXG0V6v+1+nuZxL2Bi29nZsCDtb+pCBD4FzrgbEU7PQZDC
 ePGjkVw+XGjMrsXTQ0v3cod2CrH86if9MgEOkQLKTKIQYol761icQiuxb/0Ff36YQp/w
 uaxkUpysnvI58vP2RRkPCoCvjDwsn3ZwJwDV06FfrY/1rhHX1BSAWoo/PKBUIOj68dGR
 dXjvi9KiVPgCuoqsubdosjtkDvCQDro3hT23xw7Luo7msE3LPmXa9EBWpYsxw8jQQWiJ
 h8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sM0/2gF1aJyA5yUI+R7y6wBgnZVV4qIB2xbuBa5hlKk=;
 fh=HJ+902Doo6RPjeq1X4cM7AUbNrGSy//M4omy3Lwk7NQ=;
 b=GjPu+2AX5ebTdCJxi+atkMRvJuflPtjggbYp3tEEbi9DYEB3a0sXcicAb6da+JYGG5
 paf09WjR1K1Fpex145+S9X85mcVky7TV/cgGfxJ1GP9fBkJs70DUrLGlphMqCJGnJioB
 RXSsK31Qf4hx77Oy/mStI3E2317FhjC8xT/pkyfbYkSsGSgPWHPJNNSeRjUxn/wN35aB
 BlVv/H2ADTXkg3qHmV0erOTnutqkJ2OSQ4l8Na8slezN3p5Xls2/LpmZPGZY0NGW9KxQ
 /CGPFc6gHSwqFQ4gS474uWQ1S8edmSOKOct7OvkZyFM1io1dMiI/bf+EfbM6Tf9zdQJ5
 yECw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789397701; x=1790002501; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sM0/2gF1aJyA5yUI+R7y6wBgnZVV4qIB2xbuBa5hlKk=;
 b=xs4q4XKiGYem+tGNvhCTHcabgu90bJpnA4XI5GUJLnXfZ00t0aIvC1nBZvMG0s9IAt
 gYX0kmuACkMBmJlBRpFROZgfKnpaWXkwrwET0advR3+krcz1v0cq4hssGzWwcJBsXBsZ
 Jc5QCheqe0frXeVPvgXBFLggrP7NbISfR0V7wwvvx+K0ttgwKW+BXoj3w3sUbGR8zIOm
 ND9uGKPJ48w/Hqfr2yQEaVn42xdLOcDkpxMIaNii15oEOha6SnSKTriucUlD8VLlNqA7
 IOkx48U6VmwzRzikGHnsZl9PVyzm2JV0aZLPT14ibjPdVxp4OvXwHENkCyq4lifiVJ20
 Q/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789397701; x=1790002501;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sM0/2gF1aJyA5yUI+R7y6wBgnZVV4qIB2xbuBa5hlKk=;
 b=a46qIzS145jlpglLrAhcPBEuhGZ1cL2KARn5tL2Q0AHKXkxHRNscXNGX0dSyLx/mf6
 ldqClfvgv7jpIL1bNRjN1fPtDbuvFC44Oiixtch5xRSbcotP65JVdSST+91QV04ruTIf
 57cmheeummpretQ/1AKA0PdsC81/Hmbrh09NeQwD3EXi9yysU7FNcPYs3v5b/dBlQj9U
 Par9Kx3Jo1mOsLLUU/tWPd2ZDHGWycVpb2LoGMCzV24T6DkOPAcjIQd94Q0Q2xxYKkoV
 nI3Ewq+C9g+eaEFXbmJWn2NSI47ns4nzf7m/z5kAI0vDdXWgJxuIk+4tFmydQXPDkcLu
 B+Eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwe+7emQjpHz0ypdkIjCRQeHs/tXQCDJ4O2ho4KW8n+DksVwswoAajayX190sITRjZiu3AhkJtUvGGQ@nongnu.org
X-Gm-Message-State: AFuF++liXHOQzZx/vk47YY47YEJkB7ZVjOaSn/7RLw+kLtbri4REYVTK
 Ajl0WYWQ8GgL2p8eXnktfDi41NEIcbIEY0p8IKJakMVC8/T9JvZOvnWV6hJebsQGuVLyN2qx54x
 Kz/27otZgyMhO9HrXH2ImqRoteQQmEz3r4WgiV1WRYps8JwrlkdFj5xaZ8w==
X-Gm-Gg: AYBFou39RDdK7hrAuh5qPHSAsQYdbkYAm+qbMzl078Ri5D/ZwEbRFc0JQ+BevOxJYon
 mw4i6JlXw4LkHxkbn5CQe5kCOYrolXL+AU5tRUgVaRNtmr/bvUVEw+QexkjHaQgFNTNHY4wvjQE
 g1NV4yM+ovpJkFuoyIkoOqdchjVSKRMwC4nCN7M0N/KtN2r330p6kZW69fvIjl2uiO6YTALwTt+
 D9d98yJLjExCp+kz2xzjLsVSKSMF5nq0G/MDXWWz1RsNYG4CtB0tmFGWTT4Lek22xJ6YTSC4YMI
 S2r3EGTs3Vjucumof2eoQ+8YbM7ZOfgal7MEtDWIdF6CRvRqpEMIKv3aJgaILQYC8g7M+tn9L4a
 xLOFNLk974Am7KRRGuPNgT6Uizxyrlio4eUvRBDw=
X-Received: by 2002:a05:690e:4553:10b0:66f:d560:32f1 with SMTP id
 956f58d0204a3-6714dff5f14mr529114d50.39.1789397701084; Mon, 14 Sep 2026
 07:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260824102805.639072-1-peter.maydell@linaro.org>
 <20260824102805.639072-6-peter.maydell@linaro.org>
 <03dfa51a-64c2-4b79-b524-2bac3e53335c@oss.qualcomm.com>
 <CAFEAcA8HOx3nQN00LTtqRVLqBGuQTT8bu7gaSntJyeot=hzcHQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8HOx3nQN00LTtqRVLqBGuQTT8bu7gaSntJyeot=hzcHQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 15:54:49 +0100
X-Gm-Features: AcwNN1W0n510HT8bNwFQDvmPqv-2zlbi0tBRu7d5nOtnPa2MdhRUFHS_iaHojgk
Message-ID: <CAFEAcA_=Xh543D3kf8P4Ghde9p2jZ=r-J-skO1M8xZXUmgiYzw@mail.gmail.com>
Subject: Re: [PATCH 5/6] hw/intc/arm_gicv5: Free memory in finalize
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 24 Aug 2026 at 15:15, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 24 Aug 2026 at 14:55, Philippe Mathieu-Daud=C3=A9
> <philmd@oss.qualcomm.com> wrote:
> >
> > Hi Peter,
> >
> > On 24/8/26 12:28, Peter Maydell wrote:
> > > The GICv5 allocates memory and creates hashtables during realize and
> > > as part of its operation.  Free those resources in finalize.
> >
> > Why not in unrealize() path?
>
> No particular strong reason. Do we have some life-cycle/style
> guidance on when we should put things in unrealize vs finalize ?

Looking at this again, I noticed that to put these in an unrealize
we would need to register an unrealize method we don't have now,
using device_class_set_parent_unrealize() for the child classes,
and have the child classes chain up to the parent unrealize.
On the other hand, we have (empty) finalize methods in these
classes already and you get the chaining up to parent classes for free.

So unless we have a reason or concrete style guidance saying why we
ought to prefer to do cleanup in unrealize rather than finalize,
I'm going to leave this as is for v2 of this series.

thanks
-- PMM

