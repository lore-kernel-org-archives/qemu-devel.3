Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E6DCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfOE-0000e0-2Y; Wed, 20 May 2026 07:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPfNQ-0000ZR-O8
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:46:19 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPfNN-0008H9-Ep
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:46:16 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-837b39eb078so3226053b3a.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779277570; cv=none;
 d=google.com; s=arc-20240605;
 b=kvaxLGqmvTWgBLLHC382YJntUezyKNSl5mKhZxf6g4LMj655shKteukfSpKc0fud9V
 Y53E2Tz+ru4PaiPkq9XuzrgGIy3M2CUO7JeoqoZ7Ljpb9PwuDq/MntWAT1q1vzW7lcNc
 JDQeyvM1wZF5o9TE6Brh+epoxbDggWfhRXgz69HvGzZwhg5Py/FSvEBGYm36E11ag9vz
 NbhuNx38Jv1wzoywpiaP7vbbnUDG9K1E0g6NGBfEkAyaUDy87eBIkz3RgGwGFoVLGhxg
 bli5HpHl34fueiixcJMgi9UJu/H3zNfXf084+LzTfc6aBlBqC0/Hi7F2KeMClwSY4y5F
 yHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cgQLGJS2bx0nRDlaTWldFNCGHt1mi7S2SfWqqbh07cI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=e8LdEtORUcMXzvG/XacopTRDnrIova8aUIth4aQTDJOUVpmXTCXwmGf8YYr8KVPHtI
 pLNRtJgkXB8XxfKAqpN4sKNjxEdXmtWjEqIA+ssXw8XIvXE/QCrWZO0kvhSUUEU5M5Ev
 hGx+3Cop4psy5NXUcrcRNNxQqcPLptIqerPbARynG1U/edER2w4uW6Z7Iq5HJRONkgIj
 NPBR9lohWFQIwGXsuQl6EotlUCb01vnxapeNud0qgBb32YRcjgKJmot5crqiALtPtcC+
 oB1uB5j5NVpIaJ7RDV7mWQaiKP71N7aj9E3CaNYqsc5u2sKXssQlOTD8g1hXAQ7SWcnc
 FvGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779277570; x=1779882370; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cgQLGJS2bx0nRDlaTWldFNCGHt1mi7S2SfWqqbh07cI=;
 b=g7i87OzFsv2UIG59zmZD7pcja6CNuJ/PoPa5dzP8JdnWaPveWYCZrR4XM9/Ubb4P/6
 dc0Z4AMGrtEhWijOCio+ZVRn6rwVaySw3oPgbJIMPGFJzzHZ17RYbonvM43JpPdZtD2v
 24K2hi4hO0apyP/0f+uXIxPDZ9BExYqSWvbx3UbCFaee10BZYsFbPWRzW6zgu0qX02VY
 de9G9LwMnWkUSiCs1YH0L7+kRuQSEQblIMEXxB2UOzgRKaJxvUeiCf+pNc2a9JhEYdw8
 QEVM7ZW35l5p/nhV8Nq6tHgRFGNUvosnkITMpwgmW2Gkf+0gt1cR577lYOUHIKyFA8uJ
 rB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779277570; x=1779882370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgQLGJS2bx0nRDlaTWldFNCGHt1mi7S2SfWqqbh07cI=;
 b=hOLknERFORLRQVPgZRtQbxUQ9ND5BiINEIXBTY/QZLGD0Wv3YjG0lo6yxDzA+HhlZC
 vO7NqEKRqp0AVwULkryo20iUy3jOeNybiqQUdsC6N8CLSmk6LQN/3WcstaWQ8KatildA
 mQEicazA7ni1kggXNpLBKHngRb7eekQ27Bg0Ib3nGwW65MidgWh5WtQ5pmd16rbl1ajt
 L3c5T5va9uV43Hntf8t0hsrbdafTgidj6Pbovi13jRyvO7ScnYBaLCh6C2ncm6Q6Biyj
 s9DcbVk07aQ3I0hjSAzF8aScemb+m7QhWPuQDs2YdcOGnnUC8QvtE8+imUvE0q/DFimJ
 HQWw==
X-Gm-Message-State: AOJu0Ywz88YXa3KSnnpnCHMMfj6n3lzgRLcPGh68QnAtZqonkblD+gb+
 2JnwBdX9SG3Fu+aA0UHDNeP6Xui2l9diojDk4mz2v9wxWyZDnloo3Y8wsAlWiyFD0hUWuw0Xsw2
 yNF4EJ73J8O3VfTT54B+xdwPWw48tDvn99oeNKNgaUcyjxtz4R99X
X-Gm-Gg: Acq92OEhdW1L1lddSIjukKqz5M+TLYuwCkcYnxcaaJSDep2+IoAWGerd+zsfj0b2sRp
 LTYWtwC7Ag/j6Qx4GUbR6jOy+qhaX/L5QXlev4Fwmp0wCqyIgX1vxJU5wOlf1DaZfJfyL3BTX4z
 QVHLyln7g6Jq3DIPDueuk37ZBh2jUhIFWwMLevjl8Too/022JU0iXyrhEExKH7QPtV83QsbaBMP
 ctsb8XmqXcJRbBOeEa+Rut+963qf/WA9jHrkxziDRbAbspOO4GyI6/X36lPAAsQjiVyd95kpxkW
 fbVmyWWr1RRVRNIlsNxu3AAtkzViz7h4XIXKHAduJmqHa/ga9S2HlH2rwTy/dqQXAcwHAKn/S/F
 +ug==
X-Received: by 2002:a05:690e:2501:10b0:654:28b9:e50 with SMTP id
 956f58d0204a3-65e227f64f0mr18793325d50.40.1779270580592; Wed, 20 May 2026
 02:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-46-richard.henderson@linaro.org>
 <CAFEAcA_4wU+wndbAqjnObpvnLit11OVDZvTZ1RWy_q0cNfH7uA@mail.gmail.com>
 <90811f89-79a0-4e34-b6a8-d349353620f0@linaro.org>
In-Reply-To: <90811f89-79a0-4e34-b6a8-d349353620f0@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 May 2026 10:49:27 +0100
X-Gm-Features: AVHnY4K4eDIayRiNmqGf9vHMCbHzDTi64krvFk6dz5Y5kxjDxEJ4Xzt59IRbbfo
Message-ID: <CAFEAcA8777gA7i_Mywr25QfNVJVFLTDdLMk2en=QPsD8v9NyVg@mail.gmail.com>
Subject: Re: [PATCH v5 45/63] target/arm: Implement FMLALB, FMLALT for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-pf1-x434.google.com
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

On Tue, 19 May 2026 at 22:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/19/26 06:41, Peter Maydell wrote:
> > Also, I realized that this squashing mechanic means we can't do
> > the handling of invalid input formats the way we do at the moment.
> > The float_raise() operations done by fp8_invalid_input() will
> > get squashed for multiplies. I think the fp8_invalid_output() part
> > is still OK because we only use it in the FP8 convert operations.
> >
> > We could perhaps have fp8_mul_start() explicitly check for fmt1
> > or fmt2 being fp8_invalid_input -- it has access to the real
> > fp_status so can raise Invalid and InvalidSNaN there.
>
> Here's the thing:
>
> FP8Unpack doesn't raise an exception itself, just sets fptype = FPType_SNaN.
>
> For FP8ConvertFP, we then explicitly raise invalid and return default nan.
>
> For FP8DotAddFP, we notice nans within a loop, setting any_nan; after the loop, if any_nan
> is set, we return default nan but do not raise invalid.
>
> So I guess we don't need to do anything special during fp8_mul_start.

Yes, you're right. I read the FPMR.F8D text about raising
Invalid and assumed it applied also to F8S1 and F8S2, but it
doesn't -- invalid format for source merely means "it's an SNaN",
and doesn't explicitly raise Invalid at all.

Also, it looks like "treat as SNaN" and "return 0xff, raise Invalid" are
both merely "implementation is permitted to" choices (that the
pseudocode takes) added to the usual set of CONSTRAINED
UNPREDICTABLE appending options for setting fields to reserved
values. So we don't need to be super picky about what we do.

> One thing I could do that might be slightly clearer is
>
> static FloatParts64 fp8_invalid_input(uint8_t x, float_status *s)
> {
>      /*
>       * Invalid input format is treated as snan, then one of the uses
>       * will convert to default nan and raise invalid.
>       */
>      return (FloatParts64){ .cls = float_class_snan };
> }
>
> What do you think?

That's probably clearer. I guess.

Maybe have the comment:

/*
 * Invalid input format: we could take one of the usual set of
 * CONSTRAINED UNPREDICTABLE options for use of a reserved value,
 * but choose to take the additional option provided by the
 * FPMR register specification, of treating the input as if
 * it were an SNaN.
 */

and similarly for output but
 "...of setting the result to 0xff and signaling Invalid Operation".

?

thanks
-- PMM

