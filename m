Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E764BD10F21
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 10:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOCoX-0006l6-PI; Wed, 26 Nov 2025 05:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vOCoU-0006ka-H5
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 05:31:54 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vOCoS-0000RJ-J9
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 05:31:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so40493625e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 02:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764153109; x=1764757909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqlLfxnuBYDIKlTs0/wyG8/7aCGyzNh9ZV5sxe05R2M=;
 b=ICOVW2npd/eN9Slcz/L0hY21TE0IsYGHBRnhReK1rH4BNBeG1/d6l6jHYpqmg3lQr0
 24SF0M65jAM2ZRiw+PO+iIyoiEsx41E1sIlCLjskmrKwG2v86N7sUUYXfqUqUb4KVvjM
 eY/Kj5u9CTxegDiLbt5kuKMOWaZcl0hHc7yhAc9uKmBCgCQ7wYTZS08UpdBPpfYeWzlo
 AsXWPVWnwmQLAubz4pyRnD+syWHO4trH6gWEz4RwOUzU5tQXETyiyCY5F3scykRtaJMZ
 HrNpSVr+YA95FLrTlvKFg4OLMcwMVw3/xMZ0RBZvaEBXdHC2bgaLNpKZ9soiqq/zFD+T
 kx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764153109; x=1764757909;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XqlLfxnuBYDIKlTs0/wyG8/7aCGyzNh9ZV5sxe05R2M=;
 b=dnLtlMiIVL1mFso5CPtyd9zE/2a6jlDGtuPWfS7F8y7iyeDt0op1ezKusHD8mRTaGV
 nbveqghodIDfoPj+mOLpQNFxsd433vZztJ/YMV8BqnVGRyyL/zLuKCCrN8BFAP5h1MLx
 J/brqbjv2FMTmPfPOtQdiXCL/jR0NszwI251cOup87K0XUWEPrcyu5Gzy/ApSsqLHlbV
 +akSauUJlAr8un5XnBvtuhGZyaUdvvBP9pxgHdUUYmRgPcd7Q9nhcBQ7OYGIt8A4oybZ
 b+IASolspJAh/Avf+mxss5u6mtdsyrjtds/8wKpz+q2bOlg7lVJR2DuRqEQuXuDI2+JG
 kqpQ==
X-Gm-Message-State: AOJu0Yyo1btYyT5Gg2i93DYnRVkUluypG+7w8vcq19YdPte/2/Sj+5FB
 JyIeSeIy4hOxxsAkKnYlKdBUSmmkx4Q7Nx/ytLPvSyKfStbTN5RJwVQw1mzrHe0A1z0=
X-Gm-Gg: ASbGncvVVlWGWap4jaiZyhyBmyXBwdKLsEExo052O4AJQFkG8vj0WTrD+Up0PokWDjw
 yLETephzlr6hKvockmiVWUVJX+wogTWD7dMyiahSTnPkNaHrZM3XEm5oJu8U36F60O7SPkJPecd
 QDoaioBoepBRP+vEn6vWw3j0OFBBPluLDa8MteGevlmQc3d8ofeyGo6/jcgG38pF9PNVYbPGVNv
 GJqeKOYeprZW56/rgbQlxxexaOdoqrY+LgmgIdf4Kq5R/PBm0MmPdM6veTB5bHYjrHLg44EqITL
 pEHVQBJsMofkBCkil4iv/6yR/4T7NVlWem+2qIyGaClikJjOnYUdGMhqQdmmJsTYnF7w7JFTaMA
 3OrZBmwSA0NbCX5dGN0SliEXGY98cooiBpmHgu12HmMpCNmVBFcP8Kidh+JMDnA4owx0A9VhtgF
 ttpw2u209f6Ek=
X-Google-Smtp-Source: AGHT+IEIX/AHbi/jKBY+9cMJmD4rioYelRxfuuI52zZadWjPDu3yi+PvQnwn3OjZtg3eB4AN8Dqsmw==
X-Received: by 2002:a05:600c:1f0f:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-477c017ba5amr178816635e9.13.1764153109591; 
 Wed, 26 Nov 2025 02:31:49 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47906cb9715sm37672155e9.2.2025.11.26.02.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 02:31:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 42E305F7DD;
 Wed, 26 Nov 2025 10:31:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] tests: Add test for ASID2 and write/read of feature
 bits
In-Reply-To: <CAJfKr9W7DuFGkARhSYfT=aumHcZvFbp3pzV0VLxnqaDUn2JQAg@mail.gmail.com>
 (Jim MacArthur's message of "Tue, 25 Nov 2025 21:29:58 +0000")
References: <20251120125833.123813-1-jim.macarthur@linaro.org>
 <20251120125833.123813-4-jim.macarthur@linaro.org>
 <87fra38ogg.fsf@draig.linaro.org>
 <CAJfKr9W7DuFGkARhSYfT=aumHcZvFbp3pzV0VLxnqaDUn2JQAg@mail.gmail.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Wed, 26 Nov 2025 10:31:48 +0000
Message-ID: <87y0nt5bl7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: <qemu-devel.nongnu.org>
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

> On Mon, 24 Nov 2025 at 15:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> If we instead use this to test for the presence of the feature and then.=
..
>>
>> > +
>> > +    asm("msr " TCR2_EL1 ", %[x0]\n\t"
>> > +        "mrs %[x1], " TCR2_EL1 "\n\t"
>> > +        : [x1] "=3Dr" (out)
>> > +        : [x0] "r" (in));
>> > +
>> > +    if ((out & feature_mask) =3D=3D in) {
>> > +        ml_printf("OK\n");
>> > +        return 0;
>> > +    } else {
>> > +        ml_printf("FAIL: read value %lx !=3D written value %lx\n",
>> > +                  out & feature_mask, in);
>> > +        return 1;
>> > +    }
>>
>> extend this part to check the bits are behaving as the feature dictates
>> then we can add a second test like this (Makefile.softmmu-target):
>>
>>   run-asid2-oldcpu: asid2
>>           $(call run-test, $<, \
>>             $(QEMU) -monitor none -display none \
>>                     -chardev file$(COMMA)path=3D$<.out$(COMMA)id=3Doutpu=
t \
>>                     $(QEMU_OPTS) $<)
>>
>>   run-asid2-oldcpu: QEMU_OPTS=3D-M virt -cpu cortex-a72 -display none $(=
QEMU_BASE_ARGS) -kernel
>>
>>   EXTRA_RUNS +=3D run-asid2-oldcpu
>>
>> Although its a bit clunky - one day I'll get around to converting this
>> lot to meson.
>
> Good idea, but as far as I can see cortex-a72 doesn't implement
> FEAT_TCR2, and nor does anything other than cpu-max, so the write and
> read to TCR2_EL1 will be undefined behaviour (and causes an error in
> the test). I could (and probably should) add a test for FEAT_TCR2 as
> well, but it won't test anything more than my original test covers.

Ahh I see - until we have a new CPU type that has FEAT_TCR2 without
ASID2 there isn't much point jumping the hoops to test the edge case. I
think the most modern non-max CPU we have at the moment is the
neoverse-n2. We have TRMs for the -n3 and -v3's now so we could check
those to see if we have enough of the features to add them to the list
and if they meet the criteria of FEAT_TCR2 without FEAT_ASID2.

In the meantime no need to hold this up:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
> Jim

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

