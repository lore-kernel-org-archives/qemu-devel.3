Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28394CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGitK-0003yZ-VX; Tue, 13 Oct 2026 16:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGitJ-0003xi-39
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:14:29 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGitH-0004A5-66
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:14:28 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so3417914a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 13:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791922465; cv=none;
 d=google.com; s=arc-20260327;
 b=bIsWTmOzWHnoa5/lkn+N2Ys/Tw7hk2Z4VcfTNwXTY85se/8ViHiKuwv7IhZDiZ5ILk
 QkBOGvQeDtQnq+yvfqAhf8tVQb3XXr1QO0dKi5T9TqFvSuRSjJtS7nkSZbhk4yDDhQ98
 J0G/X0zfQiRXd3UW0KzRP/5E7evJhnbCPdUnNP0EU5RQrS5HEI+Nm/iKgzbADbuv4aQN
 g3Nj/PoFlgygGWWE1G95dpKiwYGufdKyNqv8GSshHieSc4ELIcWu9wuMINWLUUf22HU5
 k+DpMwZMi4QFM25cb3Xv838yLT7AQvDfOfV7NeJcUnB7H9TR5B/+N+ZygWFdtYQyfkD8
 uFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=ICFSQRUbmXhywluiCe3roR/AmwlPU+vySnBREngejIc=;
 fh=QKdANP/nO7rvHn5kIgspvwzO+mszMlwslD4O4YvMNsA=;
 b=WVcqP8wG4UfVuPFzCO3aSB2HTOS2Z5rRHvDbhy+p7GylG9LKhe6iXU2hYCmKjykf08
 rBFrNOYCNQ23hfTvWVyhcSRs6fzEMnfL7Bd00yWVFkEUPrBNUwTqVM04Ixr1W1JfgXFl
 bQ81kJPOURuyuXoUgLa+kGBGctCV4Ip/JlKtFG/ZZyEXScuEww2qKspOkSeGvttDxM1r
 quCMvDvT4N7F9oiMylkDtp2YZqqMcU86uv0PX1aWs8sJ9qCi/Q9K5h7fatdfKrAwjT6D
 w2hkRgGWmN0VFCaVtT0/1xq2YBOJ5JSoa2ciCrjMKxnKdh782bUi/EratGjDwR15/x/I
 68NQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791922465; x=1792527265; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ICFSQRUbmXhywluiCe3roR/AmwlPU+vySnBREngejIc=;
 b=pFmJNdhIcJbeaJZr85UWO5pLKYp2xD/ALCpAeoGV1PD/ZTAqIXvPVhPl5DAZFNjiKN
 5OXuGRHXF75Y0TtvNocSf6J75I9jsMprAfhwlDVj8iZd5rb2KoB9xwwl7gqmM4gASeGB
 AmkdEJBJo856so7pxroXtAHB55eO7Q68ySE6ylCgEwKU8YnCrZgwwcJZLjrBex1/GZ7u
 dgjGE9avzMn6BmRQcdElM/xeQZm/i0QsmsK/m0eMb1rM60g/dkHXTJm3kL5TwUOvP10q
 V4765kTJ1y0+7iPd658VWWF76926AtJq5LMjCM8t2Sqo7nBi4YLuE+ZuTxHryEPm2oL/
 p4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922465; x=1792527265;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ICFSQRUbmXhywluiCe3roR/AmwlPU+vySnBREngejIc=;
 b=BED724WiBT+yfhxiXxtNyeJulRQ3Ov5jiI+ID+09t4u0GnvKRF9HKWHqa60JZo9IDS
 wxkvy/WmoBK9F0sQ2drtm6u2znRfxoMgO5CxB1zsPqqv1yr24NnYbaFugVjpaLp+/1ob
 5hPjIy+7/gsXLtYAx7qLh878BkUZMlBDxC1+5KSQxQbW1qDEiYEBeg1QZv58cb0+HVEU
 IquKM+e6m52o9cKsSLirGDtTLIYFj9o+84GX5qYhPgUkzuB+UHtUMw5Esi+oNP/Z+yj5
 G/qITIMn0Y2OiSK60iSm4cKSRUPyWCjly3oVZhsTsmyxddPTyaCdDEWfEymhc0vpKEw3
 OJ/A==
X-Gm-Message-State: AFq9FYKl5FLPfsZlHWHak0sgUxiFRxvNSFHaNZCGsacxOYIANluzQr2U
 dHsI3r8dTeBH1x0heaVSeRHCmGcAUAI5HivYB+7llwkN9GRek/RY1ACU8C3q63Dxokj7P5o0VLd
 CsX6LgxTJUn7EbvqXpITi1jhRYw6zUtA=
X-Gm-Gg: AYBFou1OwQhjXyykiH/iyhMFzV208KsqwbtnmD8ln4ZiQhPZAuDH7hStmY6UisSEJwM
 TtlJA+scgwi717NRYBETCqFCUXH+ipnWRNACvx3XKdIo2yHAVfKD/izLmlCdhZszjILirqeFX07
 kwa1n9u9HT8xwFUfTxrOpJbgLjPItgQjENZw4serCaF/0k98SbtVdGbPgaYe8djDTPz6p7OG9GB
 qvl3/A/Sjod0+Bjcgje+46AOJYbLM+bQgX1ZpDDLDJolit5QSSAfDPCjferII1lPqUvFjHUzxEo
 eeAaTf//DJksElHXCt2n44U85JIctZTWagGtVzD7asOHC7p3BHYXaIBqSRj8JIauDw==
X-Received: by 2002:a05:6402:a0d6:b0:6ac:94cf:9f2e with SMTP id
 4fb4d7f45d1cf-6b17c237c33mr10326853a12.13.1791922465114; Tue, 13 Oct 2026
 13:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261013195606.152-1-luoyonggang@gmail.com>
 <f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com>
In-Reply-To: <f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 14 Oct 2026 04:14:11 +0800
X-Gm-Features: AclHuK9RFvIM-MjwZLss6HSSX2ZfqiMgTZvUmrtG96vi5GcgoYYcuwsU4f6cclo
Message-ID: <CAE2XoE9pUcZOxXNOFtpXnqa+N+s3AJz9xSkFofuKiCAmA4N_9A@mail.gmail.com>
Subject: Re: [PATCH] target/arm: defer max-v8 initializer selection until CPU
 creation
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 14, 2026 at 4:08=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/13/2026 12:56 PM, Yonggang Luo wrote:
> > This is for avoid "max-v8" qom name conflict in multi-target qemu
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
> > index 65f851f2006..d7323ab431c 100644
> > --- a/target/arm/tcg/cpu-max-v8.c
> > +++ b/target/arm/tcg/cpu-max-v8.c
> > @@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
> >  #endif
> >  }
> >
> > +static void max_v8_tcg_initfn(Object *obj)
> > +{
> > +    if (target_aarch64()) {
> > +        aarch64_max_v8_tcg_initfn(obj);
> > +    } else {
> > +        aarch32_max_v8_tcg_initfn(obj);
> > +    }
> > +}
> > +
> >  static void cpu_max_v8_register_type(void)
> >  {
> > -    static const ARMCPUInfo max_v8[2] =3D {
> > -        { .name =3D "max-v8", .initfn =3D aarch32_max_v8_tcg_initfn },
> > -        { .name =3D "max-v8", .initfn =3D aarch64_max_v8_tcg_initfn },
> > +    static const ARMCPUInfo max_v8 =3D {
> > +        .name =3D "max-v8",
> > +        .initfn =3D max_v8_tcg_initfn,
> >      };
> > -    arm_cpu_register(&max_v8[target_aarch64()]);
> > +    arm_cpu_register(&max_v8);
> >  }
> >  type_init(cpu_max_v8_register_type)
>
> It works for the current need, but will require further changes for
> heterogeneous emulation. A more versatile solution could be:
>
> arm_cpu_register(&aarch32_max_v8, target_arm);
> arm_cpu_register(&aarch64_max_v8, target_aarch64);
> /* and fix other call sites */
> And arm_cpu_register could take a new parameter, to set
> TypeInfo.is_available with the callback passed in.
>
> @Peter: do you have a preference on this? I'm fine with having current
> patch and delay further changes to arm_cpu_register until we have proper
> heterogeneous support if you prefer.

Only a small number of patches needed other than machines in this way
to get a usable
qemu-system. I've posted all patches(other than machine related) that
required to
select the target inside select_machine.

The branch is at
https://gitlab.com/lygstate-qemu/qemu/-/tree/machine-targets?ref_type=3Dhea=
ds

The whole series is small enough, and I tested to start alpine with
    "qemu-system",
    "-M", "aarch64-virt",
    "-cpu", "cortex-a72",
    "-smp", "2",
    "-m", "2048",
    "-bios", "edk2-aarch64-code.fd",
    "-drive", "`"file=3D/iso/$diskFileName,if=3Dvirtio,format=3Draw`"",
    "-netdev", "user,id=3Dnet0,hostfwd=3Dtcp::$($SshPort)-:22",
    "-device", "virtio-net-pci,netdev=3Dnet0",
    "-device", "virtio-gpu-pci",
    "-device", "usb-ehci",
    "-device", "usb-kbd",
    "-device", "usb-tablet",
    "-spice", "addr=3D0.0.0.0,port=3D$SpicePort,disable-ticketing=3Don",
    "-serial", "mon:stdio",
    "-display", "none"

Looks better now:)

>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

