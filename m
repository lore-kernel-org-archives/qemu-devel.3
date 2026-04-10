Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADA7F36B9A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 02:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB1Ja-00017d-IX; Thu, 09 Apr 2026 22:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wB1JY-00017P-Oj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 22:09:44 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wB1JX-0006Nt-3f
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 22:09:44 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-9549a6448e6so339150241.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 19:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775786982; cv=none;
 d=google.com; s=arc-20240605;
 b=C0k97bBHFLBumM5nRVei3+C/EqO4yzH+b199xHqraF5CcOsasIfUmiqXo+z0KwPC1y
 WOVYXUJoMSPh8Dbi+Z8jmNZpS3MNTV6eghqRExtsne+7VXMT9edxBaWfii0NC82gXehf
 SPA21GBt0qheSGaY0KoOfNXOV/ejd3HZ+8/jhM2GfeQYopp4p8j0RkxCJwUPNs5Nwnpn
 mZE1vNYVCl93fJT9RcSKma/JX84txEtL6bE4xN2KwvayvMxY3hos4TrHlNRknbf468S8
 3aIqIlRcg7dEqU1ThgKvB83WOEAer33Vxvpva8zHRlw9I8mequf+KvsUj8IIBgr+4XVi
 w7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fu9VAJi4oofOw449zoo1nqP2TsOt/Fusn6qpq5HBG4Q=;
 fh=mCZyUOZNBC0wi5TF8haytF29amPSn9tvfwStsFR2vvw=;
 b=FYVNzyr0rtN3x67aui1z5BKpg6UP1SVycW1nlGdXRzzaAadzlwJslZZs5/XBsU+us0
 ceoo6sm7qFyioxMTfKLqzFXwPOmSOcfJmBjVKVcDeMHVVKW3C9vuooa2pxF5CsheKzqT
 sDM5HZBzPWljY5g8UO4KGDGBtLUtKtRJZvia8PTUFj7Czw8Lx/SOHMWB9WZToski9a0l
 XtnYlYRmYdXjEJU3HmEXbK7/Pz/9aZX1tYx5W9ANxNu8Rrat3OVJJb727l9UGPJ4ZpIq
 zHZY8oNvgsbCfVqQKcEBxkBVXm43WieaNK1gCOTZFK/dLZDvTOCRxZMnvQYnoCCNuDFz
 7FxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775786982; x=1776391782; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fu9VAJi4oofOw449zoo1nqP2TsOt/Fusn6qpq5HBG4Q=;
 b=JqSCl5CZsS7NxV02Yem2VT6J+um8YJPJviPjbYvKROM7/BNeRLRsuN1N4+rVcaQMIg
 lSh7MlSy36O2DKEAr9N+8vtxUKs62wylbptcvjhArtLkFb0VcoeK1K5awV2jdEKDDviB
 YGwOG7a6LOI/G4/hkVhqD976tsnl7/RsUNE1VeklEedIg6er13HXQf4C+gwyU46YQpwr
 3lI6tNFe7oYmSD56DV35ATB36zseGD3CoBKEHxs4DH+PTtxDTw6eOxaIXyOKpCqfO2Iq
 QdSE45IktHWcBubPyQxOXfijBzOyYlpYgBky3Bd4pwN/QqTNwuxgqR/eqidWmUtFmH69
 ed8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775786982; x=1776391782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fu9VAJi4oofOw449zoo1nqP2TsOt/Fusn6qpq5HBG4Q=;
 b=d0mbHebbc+64Z9TEMmAydcrbDU8Cz83yg25nxiomP/CaKWsUHD+87ce/ORpTGldizM
 NBXwjPDiCDu9GSd0EcJjc/Fz2bR19rG6ZwRmI4qtZESZ6KzPPSjlZpLXmfedP/DY58gZ
 OBz2kP57UeGkREVzHoEuBtOwEohUK6+1mP77/OJ8VyQ1T88lQMOyu2wyOlHtcqwEpIUf
 5Dli4SSp8VhT+txHJk1gJ29xnhyoxxw0FqlaCH+bD/0K/pgmSTPYdbJGnm7c8y3nomVB
 8cERPKpGnnpzu2Rf+wkAChogJOzecDYusSJSw2v2MLpc66G+3mc84xueGbasaKPO5wKg
 sv6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSjBX+ibI+sXsFpk9l1BJD5Vj3Kl/X8+zsVzxfZyM7zvKlSk2KRKUKsITuQ7dVIiUD/VXCxaO2MJye@nongnu.org
X-Gm-Message-State: AOJu0YzRXYit5NRA1dvYcRvuVfoa5d1cPph+cU3ptDVfrYQ2AqRVbvPM
 tvPX2+0gaBAvFM/xaU2rISSeQNcM5gE5tuKZKdrBAATTnbn100zWdWnwB1lz1OVLnW8fjTLHCna
 4noDDqpTq8CbcylYkBWv4CtEXLw3+jGc=
X-Gm-Gg: AeBDiev5x+Rg6864cYxf7YCJIa5AxQbDwPOS1Z1+HpUMFvbfgT3gCQ2XBIQhDzIfE37
 38qrLNHnslLvAMNHwoVaLLan8jn7HsK/LulLhqNsVbbX9ap3gJRnV/ZAszO42uCRxND2+seZTl/
 jDm/Xl0oISKHpq6YfMb9x2eLQrX/hyvnT0EAnNsxM8NhStlmWIxSm/LK0KAQMZsmwkM/x4jpxoI
 e1KqY99o+hVpuQLLxCppKAY3THF1fus2Mdz6R/tExNesyEwTzrDty46R2C2PjQRnsueOZLkLGir
 Hr338lap/ss7m9MvOXzWkBOhoitv2iiWfEzfQ7fruT69k92n8l3HcC5ABr0cC3HU7fCGlHvJ0cW
 HtiwO
X-Received: by 2002:a05:6102:3e23:b0:609:af4a:371 with SMTP id
 ada2fe7eead31-60a00e44326mr562833137.23.1775786981269; Thu, 09 Apr 2026
 19:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260408184228.44242-1-james.hilliard1@gmail.com>
 <CAFEAcA_Jt3SmuTiLWxuVQuktAG=M5C-Ux7OYKcGwPUBSETegew@mail.gmail.com>
 <CADvTj4rMoQi-ic=q=TJ5Dz6_GhHhR=JNhMoRhfKCFAuZzhUpzw@mail.gmail.com>
 <CAFEAcA_JPnWh22zhb+ajr76oKtFRoCZSZpsVW51m08eWrMZS5w@mail.gmail.com>
 <CADvTj4qUY6=b56LeHb+fZBEdvFPPR9dMFkYEjNhtN=BipOaEog@mail.gmail.com>
 <46b5a434-10de-4ff2-aaca-636fc7a85180@linaro.org>
In-Reply-To: <46b5a434-10de-4ff2-aaca-636fc7a85180@linaro.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 9 Apr 2026 20:09:30 -0600
X-Gm-Features: AQROBzCGo3_-1AGKUe4rgZzfUZpYoxaFQfw5QjjwbrElF0cxNC7ChXStET0rDHM
Message-ID: <CADvTj4pQXVt=mTidKeaJRfP8mzSgnDyOWgNzA0J8Y-Qi8X2d6Q@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mips: keep k0 in sync with CP0_UserLocal
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Apr 9, 2026 at 3:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 9/4/26 23:00, James Hilliard wrote:
> > On Thu, Apr 9, 2026 at 2:17=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >>
> >> On Thu, 9 Apr 2026 at 20:47, James Hilliard <james.hilliard1@gmail.com=
> wrote:
> >>>
> >>> On Thu, Apr 9, 2026 at 10:17=E2=80=AFAM Peter Maydell <peter.maydell@=
linaro.org> wrote:
> >>>>
> >>>> On Wed, 8 Apr 2026 at 19:43, James Hilliard <james.hilliard1@gmail.c=
om> wrote:
> >>>>>
> >>>>> MIPS glibc startup expects the thread pointer to be live in both
> >>>>> CP0_UserLocal and k0. linux-user already updates CP0_UserLocal for
> >>>>> cpu_set_tls() and TARGET_NR_set_thread_area, but it leaves gpr[26]
> >>>>> unchanged.
> >>>>>
> >>>>> A guest can therefore successfully execute set_thread_area() and st=
ill
> >>>>> reach __pthread_initialize_minimal() with k0 =3D=3D 0, faulting on =
the
> >>>>> first TLS-relative store.
> >>>>>
> >>>>> Make cpu_set_tls() synchronize k0 with CP0_UserLocal, and route the
> >>>>> MIPS set_thread_area syscall through cpu_set_tls() so all guest TLS
> >>>>> updates follow the same path.
> >>>>
> >>>> Where does the kernel do this? Looking at the mips set_thread_area()
> >>>> https://elixir.bootlin.com/linux/v6.19.11/source/arch/mips/kernel/sy=
scall.c#L87
> >>>> it looks like it sets CP0_UserLocal plus the tp_value field in the
> >>>> thread_info struct; and I can't immediately see anywhere where it
> >>>> would read either CP0_UserLocal or tp_value and put it into k0.
> >>>
> >>> So this seems to be something used by the vendor SDK for Octeon1
> >>> but not Octeon2 and Octeon3 targets, kinda strange/annoying.
> >>>
> >>> I also found this:
> >>> https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02026.html
> >>
> >> Ah, nice find.
> >>
> >>> It's in the Octeon vendor kernel here looks like:
> >>> https://github.com/MarvellEmbeddedProcessors/Octeon-Linux-kernel-4.14=
/blob/5c48e5031fbd86361e8185f6c530ffcfa5c9a60d/arch/mips/kernel/syscall.c#L=
94-L96
> >>
> >> Mmm. We emulate the upstream kernel, not vendor forks, so
> >> we wouldn't want to set k0 here I think.
> >
> > Yeah, I was trying to see if there was some sort of way to trivially
> > identify binaries that require this k0 support and autoenable a quirk
> > but I didn't find anything, maybe it would make sense to have a
> > separate runtime target for enabling this k0 quirk since it seems a
> > lot of octeon binaries require it?
>
> What about (untested):
>
> -- >8 --
> diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
> index 0a000ac8f35..c4aa08df4a3 100644
> --- a/linux-user/mips/target_cpu.h
> +++ b/linux-user/mips/target_cpu.h
> @@ -36,7 +36,9 @@ static inline void cpu_clone_regs_parent(CPUMIPSState
> *env, unsigned flags)
>   static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
>   {
>       env->active_tc.CP0_UserLocal =3D newtls;
> -    env->active_tc.gpr[26] =3D newtls;
> +    if (env->insn_flags & INSN_OCTEON) { /* Octeon1 */

INST_OCTEON isn't OCTEON1 specific, but we could do something like this:
https://lore.kernel.org/qemu-devel/20260410020012.98778-1-james.hilliard1@g=
mail.com/

> +        env->active_tc.gpr[26] =3D newtls;
> +    }
>   }
> ---

