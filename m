Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE453D29C24
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 13:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhot6-0002H6-Es; Mon, 19 Jan 2026 08:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhosU-0001s2-7s
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:01:07 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhosQ-0001ii-6O
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:01:04 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-78fc4425b6bso38648577b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 05:01:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768827660; cv=none;
 d=google.com; s=arc-20240605;
 b=DFpAycyfd6N4/6eopBZYWvXjj7v1LV0Mag37hnYW1SsZ8OXl9ZhuibX1ONkIoKSc1U
 KJyn0QVxurFFaPE0oPlOWwyGciP5ZGMR9itcwtvpLUJpURCb5y0eV4ARo04pbEGdxE87
 xg8eEW7z/ODZFe1bo0kNixY05kPOshiOcQy+mugn5Hi1OjQt6J+P8ePMV9AzEAAuh1cI
 x17qdMIitsExqbdXkqB0uFBk6rWNHJSLzn4HASF7glVNcM+fMyvgLKcdeot6Q8QQvoSz
 5A7Mi4KOlL9oHgwxcIQtuescuDLwksX1a0kzE8kFArN+hFCLtGMe3RPKYJjMjjVf7suP
 O9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TPQi86pLnYRCGvJvueNn+Jvwj1U84ceP69XmscXfzew=;
 fh=1RhkLhOVz+X/l215EGDErNq1r0hxWqCWD2wP4O/UH6Q=;
 b=efRYF5HvKXmiFB4IEmy1oxqri3t4hFyUtYHd5NwOtSG93X20QMjCD+rYJol43MKRhn
 qwilCh66siVNKGGQYWYxvqyxJehdVUNTDzrMdL12oxPsLiNbJHQu8xtzAk51ckn+3N0K
 xzxdxhA52hJL93+xHvuwx8u6+JkI6CiEVieY26EYfkQM+8pICXDkziwCEPiFwvUs29U3
 DMajntGcOntkXY1t8Ni00f77jR9JNxRfUSj6eyvci5JWXrprUNzWwW6Eawd3o5G7txhB
 nlKv8gE0fzCtVGNXxkGINw5NbImfFPUZc6hB1MHp2AXCiK3JD3C2YIelwMSGlj2MhDE8
 /5vA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768827660; x=1769432460; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPQi86pLnYRCGvJvueNn+Jvwj1U84ceP69XmscXfzew=;
 b=FZsVofjHz1YMa4GTgYidR6L4l7HpywpTxG1PzH3DjGwsDTycastp2R5WmiQQbqQUfp
 YTtlXFdjh8y68AhdGNaWv1V0Xrqq2Po5T41v/BKVdNrJrrDT0Qkyzk1MNQi+cIh++B3I
 6wD4FiuxFsrup80kadrGiGYI5MwQpzyfiz0JEZiKiedBx9grqh31lYjtkIqNRDTFI80g
 GtX69vzDDoCFH3QqukjB6mC9UkBQ+1VVO/hsmV6ZXatrznGPuSJIONJ1kBWOfreLY0m0
 cyL5mGiYnYY+ROybhv6UP4cS9C/0qPuHHL/QGHqMvr1lc3X5qKPUg68NDLAgq9V4lmys
 NTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768827660; x=1769432460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TPQi86pLnYRCGvJvueNn+Jvwj1U84ceP69XmscXfzew=;
 b=BJftfRbPIHw64CcGT8kvWdp5uoyBF80OEwhAt7cQQYUNqdEranY5J9GCRbCnRBmfw0
 YmsvH6S5ehqY990rUcHjO+ecRBxi6ZManwS8lAodjyYfM+axGlWPKljmDzFZ9egCtFDX
 N9G2D/6bwvFZKtU6wPBrpN54wcqtnrANWgURzaNgKZcMP9tj3WFzouDTY/F3mwZn92zF
 c9TuDq6E6lxLNaQ8wsO2oC/uKGkmr8j4W2fxsWoBd0r8bGKCsQedqVSJAYsVpUbWKfRg
 q9JRwsoxtrh4nIHbHo04wsxm/O3WDKj3mPYB062hGChUCw4u50lJQU4WOGenB08E9QKz
 RVVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUldEcETJk8VCxnfAL7croxAOcny561bsBoPg8/8geNtV5Edvei9pmIkhxXyEfyxm4gFagESbIP11kj@nongnu.org
X-Gm-Message-State: AOJu0YwXgeSrwYV8kttxntAODajbEjr8B9cukTU4k6DEoyi4+ZrG6bG6
 DJlWtqwKHBdvErzXthQQkLS4IaNvL5EydKGgtX6f1TbhVLeVHcdjAMDa3GI2VBVkP/6NJsCSO9L
 PMj3jYMA6oqApDGnY5+K8fs7g/SCIIR+Zx2gYn34x3w==
X-Gm-Gg: AZuq6aJKAizuNYa/wwTfiHao0h3PCAgFZR0RO6GkEVkpRczaMgaKwHdCdny+J4gnhBh
 QlUNoNLG+o3DcQNj0SyUoe6XYarKeFgTWzV0pdqLWKEuFITbV0lZ/tKXlPDTata06e7SXsd5hEO
 Yt4fWySykTKlSuNK325LdGKGQxbXLmU80EF8oPu2bZEaTK1JtIVkpiVJKea5xI69x483mw+v4pF
 8RcbdWnxjKTzcgOBlXhb3jfMirC0hh4qq5aIfEZzp29YXPvpxBdi9qP++b9a/TnSkVjGopFzjxw
 jcE2
X-Received: by 2002:a05:690c:12:b0:785:fe77:ccce with SMTP id
 00721157ae682-793c544d54cmr89607217b3.44.1768827659942; Mon, 19 Jan 2026
 05:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-52-philmd@linaro.org>
 <cd27bf13-a8ef-4b7a-bfea-0e4220091ec1@linaro.org>
 <8af2b03c-6fc3-48c6-a307-7d49d38532b4@linaro.org>
 <6b934c5a-bfbc-4877-8e53-b7e89db1531b@linaro.org>
In-Reply-To: <6b934c5a-bfbc-4877-8e53-b7e89db1531b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jan 2026 13:00:47 +0000
X-Gm-Features: AZwV_QguP00tnkyjRD6H94znLrQCE0jUQ2AOx2kWebFzmEBuRaJEAGHFMdeGyfU
Message-ID: <CAFEAcA9RnVqWfgm_jhevoFE0Z9E825=7JFZVNNnfnJeCKd0LJg@mail.gmail.com>
Subject: Re: [PATCH v3 51/59] hw/arm/virt: Warn when HVF doesn't report IPA
 bit length
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Joelle van Dyne <j@getutm.app>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 19 Jan 2026 at 12:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 18/1/26 23:03, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 28/10/25 13:07, Richard Henderson wrote:
> >> On 10/28/25 06:42, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> Emit a warning when HVF doesn't return the IPA bit length
> >>> and return -1 as "this accelerator is not usable", allowing
> >>> QEMU to try with the next one (when using '-accel hvf:tcg').
> >>>
> >>> Reported-by: Ivan Krasilnikov
> >>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2981
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> ---
> >>>   hw/arm/virt.c | 8 ++++++--
> >>>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >>> index 175023897a7..1d65fa471dc 100644
> >>> --- a/hw/arm/virt.c
> >>> +++ b/hw/arm/virt.c
> >>> @@ -3225,8 +3225,12 @@ static int
> >>> virt_hvf_get_physical_address_range(MachineState *ms)
> >>>   {
> >>>       VirtMachineState *vms =3D VIRT_MACHINE(ms);
> >>> -    int default_ipa_size =3D hvf_arm_get_default_ipa_bit_size();
> >>> -    int max_ipa_size =3D hvf_arm_get_max_ipa_bit_size();
> >>> +    uint32_t default_ipa_size =3D hvf_arm_get_default_ipa_bit_size()=
;
> >>> +    uint32_t max_ipa_size =3D hvf_arm_get_max_ipa_bit_size();
> >>> +    if (!default_ipa_size || !max_ipa_size) {
> >>> +        warn_report("HVF didn't report IPA bit length");
> >>> +        return -1;
> >>> +    }
> >>
> >> I suppose this goes back to the previous patch.
> >> It might have been slightly less confusing to merge them, but the
> >> underlying questions about when and how this can fail remain.
> >
> > Right. I'm dropping this patch.
>
> BTW I was looking at the extra-commits in GetUTM and noticed one
> related to this:

IIRC, the failure in the associated gitlab issue is because
in hvf_accel_init() the very first thing we try to do with HVF
is "find out the IPA range", so we can create the VM.
So any kind of "HVF doesn't exist/is not usable" problem manifests
as "this call to try to get the IPA bit size returned an error".
So we either need to have hvf_accel_init() determine "HVF
is basically working" as the first thing it does so that we
can know that failures in this function really are specific
to the IPA range check, or else have the error be propagated
back from getting the IPA range so we can do something sensible
in hvf_accel_init().

(I haven't looked at the rest of this series, so maybe it
already does something like that.)

thanks
-- PMM

