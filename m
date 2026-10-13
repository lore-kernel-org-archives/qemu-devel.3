Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59473CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGasn-0005LN-B7; Tue, 13 Oct 2026 07:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGasl-0005Kz-RA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:41:23 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGask-0006bA-5a
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:41:23 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8871ada1a26so18105267b3.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 04:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791891680; cv=none;
 d=google.com; s=arc-20260327;
 b=IkS2DninxxCkBwba/+Rkp5BUtv2F4IPPCKhA98dnPH0QEKlUk/wJmgmE/EYHNbLmZj
 WutdBhqZb4sCCjKsG5NjSLIR1NkyK0ca6H20Grr2x9IdWfGJytM6m7+9QzTqnKK5R+Ea
 StGfORzORpD6ws3da7A9hoPqseTtDEBtfSpAgi3p5BVSRatdXv4mDOPI5ds+chDiY3ST
 +Z9q9rVrjjLg6Os+pivcn6rhVxxWOR/tpy4jS3ZpT4Z6jgouecJsen91m5dFp511H5NH
 ivtVP62KqGcgp668ubFQkggtqc/jdGjCvrPw+QkF1Wg/ZSWOUDAuGFUCRrJEdfu/xwSD
 vDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9McWWCAOIBxuGBkuBTOr3Tp86N9anlMxSYYZCGam1ns=;
 fh=0cG31DgQdDSBo+ScoxXvJWhhEtLI7nreI37zUzAcm+I=;
 b=mLc+h7RK7YlPoOVvqQP2XwgS/qgS1L6ASi3OXWXZfB8UpSp9+6+x7dsAfdQUluRc6p
 NvIq5X30USX/9Kb/rAtiZdqg4/QtmOPQP4RtgWRXUktHd+yRwYdATVlpK3NLjrRNsHgs
 mpC5tJM71fvPs6kzRghAVdc1Jc4bbIIAnMCa3qNkIQIFau04msQ8a7Ttq/6akTJTcDbr
 ZcPMYVsnEyD0HqLwPlgttvP1Y2M6a2vwFEV+ZJiFXLgZKh6wETEB6l7RrRXMkYuRfWKv
 fqP6/gsjD/tF3iPJN2w2WZ7Ohm/7I4yJHaviVzSZjC+EhMN6YuJyfzHhJ72MLuLuOi6b
 TUyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791891680; x=1792496480; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9McWWCAOIBxuGBkuBTOr3Tp86N9anlMxSYYZCGam1ns=;
 b=dZecJ01UL3gMSh3ZE9qNN5zjUQWs/xVTkLVo5fcyGFSjT5tFPMwqphZpoDUh39zSft
 CG6dgYZV6+QKMXP40o+GtIoeDT+209MTweyddgwu9XiiIn2ZLjKSWQhUT5Dl++MytD8V
 vIndoVzflFypd9TXadLCpd0tkABKHP3O/RrpICXTxC379pYqbYcVco3Xaqjd9c8c+m+3
 zDloEuiw2UTUWZyI23o//xOIZRpSZ+Lan9qYGOazmaeAeYF1a4/0UYdwFeMNM/6GNl0U
 3aLEyXlOZeo6GWnVy21jIkU33oSY5xIVyeMmsfLPiU5cfaHbj/zt7ADHOtKzpwZ2OHlU
 crAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791891680; x=1792496480;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9McWWCAOIBxuGBkuBTOr3Tp86N9anlMxSYYZCGam1ns=;
 b=Q2Qyjv8wpknY44MEqPMr4jtVoBGbgaXuIbWR4rr+w448d1mW3FeTWBBYlNIEybP8tb
 rZa195/PALEsjbqj2g6kn5iHQqCe+yNtTa9sh27QtbnyUgnObx9unJlZ7+05F8WuluG/
 yp9yN11geyYZAfjbBiRIGmXwoEfPWjZt+WlR+z4927pjw0eyyeRIlrs8hreQ3uwEKZF0
 22oNH9Jjcd6YDExk1DPkGmNOISoEQhhC1HvGUKM5EedREHbhA5r7WJg6RNhC9mWH+k8g
 Zl3hw4GRPBQ2uzNh1h63isV2aZfZiRDBwD5wJkCzMqA+7h6kZ3gmxBkYt+tx8ytbevvi
 bUYg==
X-Gm-Message-State: AFq9FYLwnKBFprTzXRQ1rR5BOShAn5aDT4Nv/RzDPv02L/ILY09REg60
 HfdMalJBkszIngEdFBpvuf1gWf7GNdYNr00C3JkfM3On2/TnLkx8w/0CKMc5jkwEezsdWgsqRxh
 Mg4khqPXDbHV/TC97UBj8BpSTK5OF0pIoUCnCwkESZg==
X-Gm-Gg: AYBFou2ysDMPp3rQUweAa8MdiGLVOEUj8CgEjUHlBEOcbwcvfRsdHw9Cko9QFJ988NU
 0Y8OAXdJm54OWn8+sP7h7X3Kzfa9TB57JOrdsWgTm0D/oHD7vjgNvMT0YFCr9XZeNaHijH3wBZP
 Y3u6879TL8v2ao9UErphAkAlVOvjlZmdDHhDtan8+u4Tiw/jbcBN3pBh2VIuo00rEdDmtRT6wam
 l9LrvBvmeJmqxmIVnGmDT1YgrBbXHv5USok6+g+BEyopC7B18Z61dTVlJWInjvYYl2l8ADaMs3F
 Dx33m0EpE3422AcQooli0xa4tdroqgPdxy1LcZ3wLGyWNnwz032j+iRSBeguyp0ykmgthl/XZBQ
 ClCrDFsZsINhkqLqWEUPJUxSmPY86Sh8GTsHJyXjHX6LkM0wjHw==
X-Received: by 2002:a05:690c:f08:b0:8a8:e0c7:dc3f with SMTP id
 00721157ae682-8b07edb5995mr42242067b3.18.1791891680293; Tue, 13 Oct 2026
 04:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261012134840.1051969-1-alex.bennee@linaro.org>
In-Reply-To: <20261012134840.1051969-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 12:41:07 +0100
X-Gm-Features: AclHuK-_TRFTWfTRNb6_FhuCtZhq8iwthH6pC-l_0gF9LKp9RuHZlndyg60fWdE
Message-ID: <CAFEAcA-9+y_DQ2Pc5WZGQR_8Q3Qo_xCxaXhKPq5tor1sRFG2ZQ@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: hold bql when SEV sets the event_register
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Mon, 12 Oct 2026 at 14:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> There is a race in qemu_process_cpu_events and sleeping on halt_cond
> where we can miss the setting of the event_register which would cause
> arm_cpu_has_work to report we shouldn't sleep. As by definition the
> bql has to be held when we go to sleep against halt_cond guard the
> kicking of the cpus by the SEV helper with the BQL to ensure things
> are properly serialised.
>
> The other places that set event_register are fine as they are either
> in the same vCPU context or are already serialised by the BQL.
>
> Also use qemu_cond_wait_bql like the other halt_cond users.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4660
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  system/cpus.c              | 2 +-
>  target/arm/tcg/op_helper.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)

This should be

Cc: qemu-stable@nongnu.org
Fixes: d238858bff6 ("target/arm: Implement WFE, SEV and SEVONPEND for Corte=
x-M")

right?

thanks
-- PMM

