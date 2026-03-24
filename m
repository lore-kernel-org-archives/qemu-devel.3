Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9863F54AB1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w51kt-0003As-4m; Tue, 24 Mar 2026 09:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w51kr-0003AY-WF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:25:10 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w51kp-0001Wi-Gr
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:25:08 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64e8c7f5082so4789772d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 06:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358706; cv=none;
 d=google.com; s=arc-20240605;
 b=lH/dTsQsIlk+ld32IWtpABuS6gKOHVAkgHceryhscXf8m2Ek+aU2b0b+Mxam1UI7qi
 D9ynErTNd3V+1R5oVCepSSIHFM/2jNJ/F5FFwR6C2RAPy9n1wcssI0fI+LKz7TpNoLhh
 IkP0eq/py9UHnpIAwSmhcQqe/YN2uz+vzY7Tw6SXKFf2DZbMk2gmObo/ycIWHMOZVlIH
 1i1VHLl0LouZ14aVhKDiLdg7EB8TRw+lwllgJKF2ofrfZ1Q1pDd/re3/CwKCot47/3wD
 YgO43sEDaQtrNT3D73NBAKofLNmcSWDxvAGt5G9+FRwpiXbGMtAPvTWvpCB1dz5bxyq+
 quvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O6dP6Khj+mROzt0FB2SFuxNZ1ZPHBngVahmPasPatkQ=;
 fh=GwkkCr8gB9TFv+wNzkL2anedh8B04+PoIpZsqvChqVQ=;
 b=UOPuuRk+3gltc/4uLWjNJRK++GVvQv8GY/vcyvp4Zh6kx9SCrc5nV+eBoT65p5CVhi
 KPTKan414ns7oC+LYDn/fzCDq87w3hNrflLcLGgCCSQRkK6piJ8z5hLk60zzY8DqUFg7
 9iEXV9BYr1Y3n+AwFY88WgA6C/mKNESdt1GmlEg/8aYqEc4NCzwdSUmf8HM4dFe+498G
 CIiG5lDVZqWxyZk6t98XZ10Q/eIsuPcIw/uuRl/gPTDbxztiNOS4qkibyWfW6EZHcVTI
 hg+YDwxCLtx1pPlmoNdD/qRIo8AUdbKllWfNVp25lJI+SA2qE78fRVU7GWyVpJ0EsUUz
 t5jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774358706; x=1774963506; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6dP6Khj+mROzt0FB2SFuxNZ1ZPHBngVahmPasPatkQ=;
 b=JdJtIPFOmaCpL+TX7KzOA9ABzoE55gxwIAvZWXR7zUVO1tkJ2poAa0BPMCEFcVfjfg
 agMvpM4my2oLE2QMiRtavfpX0hp3vVqFxatSZPEFBWuMERTit3si2u57sBTZe3BzumOf
 jMhj+WHzEptGuFgWLdaQ3K+i7xcHd/mHqbtrNwI6tunSCvUJdyQVVstjZh99w5m2XUKo
 3Qu5+tRi8G1Xzaso1J48EkY96AIx6VsjBP68zbUDdjOyDbkPaSNpJLwH0Z1Bz7gU5vk+
 FknNqAgdv7eKkIKZPTuWbnR4RM5HSMuru+c4MNtV2cR7hhX0g7hLUEemF+qadKdGzj4v
 VFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774358706; x=1774963506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O6dP6Khj+mROzt0FB2SFuxNZ1ZPHBngVahmPasPatkQ=;
 b=IarkFNOvz3NdFD6LoHBW2p5gNWLmzZkB2hUPQUQLF9yx8IHGO5s9ustC/0n8S6bJr9
 iBmII16QUWhSWM2/ec718eL32xG3V4lbELXUTeyg3SAc3h6FC2ZBJrYFJ8GeIZIxedVn
 QpzkIyv+cqkrJuf6sra6KcfTrfXTy9Y8szCPhcbCTkEvG+UE1Vg5PImk/zh8wkkK295e
 ekFYf/c0dSKuCeO0cZtyF+wLI3NHQfIQQ4ZINenGKsi91gESeO5XYxWW2oz5rvn+I0em
 cOYjhmrUIoqSx782eHHv16KacgsCg1JC3jPFonleNpNqfS0vMVcT/Ak+DHK3UfH1k3gN
 BFXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6UC9ATlkuo4N6uinpEzsItUn14zPv8apO3xOVP8/3nLLNRcpznJ9kYHSbUwrdyynsY7Y4pHEitS+E@nongnu.org
X-Gm-Message-State: AOJu0YzWjy64XJhFsUW4blK13/B7184lCUURM9MVp5tgOXZ4PIfoSbu3
 v1gVs/wSqe6kKMBAdyXUEw7+OPlTwcSoHWsUNyWaz0+cWE/tnMbl7PdRdBkFXIFtvAvi3vaoZL8
 2R6yJR5cxH30miECapktqOPF23we1lvzIpdTiggtgHw==
X-Gm-Gg: ATEYQzwGpuAl1ClO9DFv4vFytw1oSu5vkg1QNoSdp3HqUGVhanwmT065unse1cKPzzq
 WEVgBk982EbGTya4xa9T3YkgNh90kem5o3CRq1BJbrYYsX6z1zjzbGkH40mwq9i7qXqDfLbL5w5
 3RFSRq6ECNg42mtk3TLyIUOTIYIB1Jb7d8HIVJpZ3YSUftVrIL2wupWyCcK1+Wy9RTGPHUVGU12
 QB6GC8IZOpmEUkc1syuhNiQ0P0rzGH9eCL38YkKkBihG7Xpa9NBZf1SUUxpOq1Tv0JFwgT0VIuN
 zMX5MSdRIFV5ADtVDRAblXI6OE4dtxEMccfAg747bqz7CE/KByMajN9Z6mBpOi8+s3c=
X-Received: by 2002:a05:690c:c4fa:b0:79a:b9a5:9e68 with SMTP id
 00721157ae682-79ab9a5a6demr60775217b3.50.1774358705961; Tue, 24 Mar 2026
 06:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-4-philmd@linaro.org>
 <87pl4ts7vx.fsf@pond.sub.org>
In-Reply-To: <87pl4ts7vx.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 13:24:54 +0000
X-Gm-Features: AaiRm52RKS9m3pZnpXbtMCZlAY2cK5R-UTj3lrxxVUAupp6Lihf26isQSIFG0dg
Message-ID: <CAFEAcA_y5amOwF-HCM8L3xc1_bSbXxno+HjrLBiOaN25fCt4eA@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 v6 3/6] monitor: Have MonitorDef::get_value()
 always return int64_t type
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>
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

On Tue, 24 Mar 2026 at 12:57, Markus Armbruster <armbru@redhat.com> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
> > Simplify MonitorDef::get_value() handler by having it always
> > return a int64_t type. Truncate to 32-bit in the single caller.
> >
> > Note, this handler is only implemented once for the x86 targets.

> > @@ -78,7 +80,8 @@ int get_monitor_def(Monitor *mon, int64_t *pval, cons=
t char *name)
> >      for(; md->name !=3D NULL; md++) {
> >          if (hmp_compare_cmd(name, md->name)) {
> >              if (md->get_value) {
> > -                *pval =3D md->get_value(mon, md, md->offset);
> > +                int64_t val =3D md->get_value(mon, md, md->offset);
> > +                *pval =3D target_long_bits() =3D=3D 32 ? (int32_t)val =
: val;
>
> This assumes target_long_bits() returns either 32 or 64, doesn't it?
>
> Is this true today?

It's certainly true today, and we insist on that: exec/target_long.h
handles TARGET_LONG_SIZE being 4 or 8 and will #error on anything else.

What other values do you expect it could have ?

> Will it remain true?
>
> Could we use something like
>
>     val & ((1 << target_long_bits()) - 1)
>
> to truncate to target_long_bits() bits?

This is UB for the case where target_long_bits returns 64,
and isn't what the code currently does because it zero
extends rather than sign extending.

If we wanted to programmatically sign extend from
target_long_bits() to the int64_t, that would be

 *pval =3D sextract64(val, 0, target_long_bits());

(Whether sign extension is what we actually want for your
average register is questionable, but it's what the code
does now both for the get_value functions and also for the
generic cases handled by the switch on md->type.)

Incidentally, we currently behave differently here for
qemu-system-i386 and qemu-system-x86_64:

$ ./build/all/qemu-system-x86_64 -S -monitor stdio -display none
QEMU 10.2.50 monitor - type 'help' for more information
(qemu) print $pc
0xfffffff0
(qemu) q
$ ./build/all/qemu-system-i386 -S -monitor stdio -display none
QEMU 10.2.50 monitor - type 'help' for more information
(qemu) print $pc
0xfffffffffffffff0

For qemu-system-x86_64 we have a 64-bit target_long, so
the unsigned addition of env->eip and env->segs[R_CS].base
in monitor_get_pc() is done at 64 bits, and that width is
then carried through get_monitor_def() and to the caller.
For qemu-system-i386 we have a 32-bit target_long, so
we do an unsigned 32-bit addition in monitor_get_pc(),
return a signed 32-bit result, and then sign extend that
to 64 bits in get_monitor_def().

thanks
-- PMM

