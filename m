Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F71ACA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xETW5-0005dA-88; Wed, 07 Oct 2026 11:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xETW4-0005d1-7B
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 11:25:12 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xETW2-0007bS-9a
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 11:25:11 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6aa97d1cbffso3284149a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 08:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791386709; cv=none;
 d=google.com; s=arc-20260327;
 b=qb1bUKsaeZ+Q66/W9r9BJyHA9LIz3muVAn90k6yfpRq8mHSki707lilzDwAQJz/scn
 l162i783HrCFIdNfoOUbh5uwvWnJFvbXsADLanWB8HBF70viKqxaOTuQ1M/aKb8882i2
 lstruPMrTBJccvhDU6kFpuH8K+LrvaY20sGAzMZbWI3f7eWMCicQY0JKp4gbFSwsoPZC
 M7b4xnvv5qT34jpwwyk4HTCXSpKFm+LQ9iMSRpsEmAXiZmO0sdNwDrnwH4Myp9n5+qqP
 8LPVkMOofvuPZbhniKD03ZINOT9xc3mZabAYYEnFN36mKNlamjsZXDmyQr0seqHyRwIK
 IZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=gtLb2x7is1RMWUJv1vZv/x474WG659kGkdwUyCu5mFk=;
 fh=o1u8eNUZbRJ8/CQ8SMp8KQuC/3MnxRzOf0QXECOyVFk=;
 b=jcsvoeQ9l2AxGzD8PysUuzQFR5zt1x3Ujp4IVl9VjaJksITLAQ+eoYkHdBwbTIBFce
 lZu2NFiPBTfOBcWhM4I4Qj2BF2hGIRQaNZ+W8g2zgoxrbL8a/UUpRRrIbWRIZ5ru4qC5
 hS4ujXlleFv3ThZAAujjL4jH3xeTxSqGKbYEC/FfcazQODSlDeh9eUGUiF7v2anYJ+Aw
 q9q6B0GPBEEl/CWU8FkwEuniF7O2Vbz/fr2EA5E1VQViyUlyavGZUmickMA7yZwUvGau
 hYuzZ/Lptx/yDt8txjN2PtA1VGod28Hi1iroa+p3a+P3pg0nX53sqBKhP4+plna8vqxk
 pJWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791386709; x=1791991509; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gtLb2x7is1RMWUJv1vZv/x474WG659kGkdwUyCu5mFk=;
 b=CCf6TryLV+Q6cW6/NfQ2d6CnTjI/Rbtrl2fGKkFXwvTOqHXuDB9WfoPS867O1gd5XJ
 Mof5N0U+7c2YoYTG3o2LD+gxSFPmia3BBg51a2OLZxmVVkNa/ziPoXevTe7UUYbzJd8i
 u7tPIZP6XKqnmu0CRQ5Ly+KiYLdLv9sd68ztZsWg8Q1O+5R/r9QpVjn4KvZgHplDVfPp
 pMNnJrkW5s/FJxgqzflnjDRLetuU590Em4YtwP+7+cbKpC8/2WanXgqRu2YhwsNOLSzu
 K/kOmYYdMU9ICX/O6c0a13c1wvoo0JEMszigMywedJaThRGsfZbz1eFlJFYMDB83fmOB
 CCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791386709; x=1791991509;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gtLb2x7is1RMWUJv1vZv/x474WG659kGkdwUyCu5mFk=;
 b=GvO/y0NSaDyIPzuwMvKxbV25BgPycG0XrVjpBflQf5XmpNiOBNpOvWDBlgnobTEYIB
 SIeIiFmc3zAcjPnGRJiLs2bzLcCDo9FFq2qRCn3fK5+wCSiQKheEYrRsigUJZv+Rxc3r
 U3UWYVkHcBnHkzh9S2fOTdEnfCZfWgk080ZrIA0AlKgCGeBNrJjAxzhAr02mk8fcQijK
 0JWbU+42Yboo8CF5m/srmUNWyBxgL81Umqlk5JcLfRwyEdC4LXoqJXV43C0tyPlRo5qq
 bZIHLORVQ/QQum4oo08kS+92zpcVx8eFWD3swmlM/cBn3gNrS+TPIOXQbFOkcegFlBsW
 am9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6636c/c7+2KsEC4vW5Rqou5FKGwfReFgZa/rn0hJHfuWeC4znNLPPtaqKbELLuhvhT7ZSPs6xdV7z@nongnu.org
X-Gm-Message-State: AFq9FYLbRnj1hn0dNtq7EeaGVxvwkLt34iuipYS8MdzSmM3nPcefBJfG
 fWyHr1I8jds04DVuU4IJ79AEk2auZZIsHtsTBeCly11hn9NvoiAXzBwW8rojBIjOivjmhF66umo
 Fl+oRng6vOYQxtAOF7LlPfKRPgTXz4iE=
X-Gm-Gg: AYBFou1ddC/NjeXIugfERbV4mdsCCz0DesMBXFxJbTCCFDUHNBOCVi4mIFqejfJqcUk
 bn0cvyC0+mkVqLmpmk5gpL1b7/OuaMHt8W5bVuPjpTmZjmzpy1DIn8xd1KV2ZvQx7Ep6Qg3qNkk
 JyVe1puIHZ/Px67rgT6AwQU1SRxlOjxcbEwv63soEwTPCZzRWBBR5oEkhyw7bCS9ub+tsofPJ6S
 SWodPLeDffI1MnZYak4woIsx9wa3LciwP7EzuMjDCXmLFDuxQLMoTkZDKVucO+EX1+OMCXMQ5xQ
 XbRyJnKlaBInnWPE0DAHS22Sfn501PeshjyhXLitsjUjRLfR4TKIb4Y=
X-Received: by 2002:a05:6402:27d3:b0:6aa:e589:87d6 with SMTP id
 4fb4d7f45d1cf-6aff3986114mr2414978a12.9.1791386708463; Wed, 07 Oct 2026
 08:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-2-philmd@oss.qualcomm.com>
 <7437c9ee-d1f5-452a-a456-d1dd7e1d268d@oss.qualcomm.com>
 <asYmU2H_J225oU2s@redhat.com>
In-Reply-To: <asYmU2H_J225oU2s@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2026 23:24:56 +0800
X-Gm-Features: AclHuK85Brli7Bk4WCqpREhNIi4AAuFeOnb88G0qp-XVfsHloKudbOuAZLUMsAM
Message-ID: <CAE2XoE-NXxVr7mwhVt2azsAkFZpsmjOmNh8oYR0t=wU7-zWriQ@mail.gmail.com>
Subject: Re: [PATCH 01/27] cpus: Add helper to log raised exceptions with '-d
 int'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52a.google.com
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

On Wed, Oct 7, 2026 at 7:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, Oct 07, 2026 at 12:47:24PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 7/10/26 11:44, Philippe Mathieu-Daud=C3=83=C2=A9 wrote:
> > > Add log_raise_exception(), a common helper cpu_loop_*() can
> > > call to log a raised exception when '-d int' is used, and
> > > qemu_excp_name() to resolve QEMU-internal exceptions to names.
> > >
> > > Use it in cpu_loop_exit_atomic() to log the EXCP_ATOMIC reason.
> > >
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> > > ---
> > >   accel/tcg/cpu-exec-common.c | 32 ++++++++++++++++++++++++++++++++
> > >   1 file changed, 32 insertions(+)
> > >
> > > diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.=
c
> > > index 68077c8fd9d..2ac8380d0bb 100644
> > > --- a/accel/tcg/cpu-exec-common.c
> > > +++ b/accel/tcg/cpu-exec-common.c
> > > @@ -89,6 +89,37 @@ void tcg_update_all_cflags(void)
> > >       }
> > >   }
> > > +#define EXCP_QEMU_INTERNAL 0x10000
> > > +
> > > +static const char *qemu_excp_name(int excp)
> > > +{
> > > +    static const char *excp_name[] =3D {
> > > +        [EXCP_INTERRUPT - EXCP_QEMU_INTERNAL] =3D "async interruptio=
n",
> > > +        [EXCP_HLT       - EXCP_QEMU_INTERNAL] =3D "hlt instruction",
> > > +        [EXCP_DEBUG     - EXCP_QEMU_INTERNAL] =3D "debug",
> > > +        [EXCP_HALTED    - EXCP_QEMU_INTERNAL] =3D "halted",
> > > +        [EXCP_YIELD     - EXCP_QEMU_INTERNAL] =3D "yield",
> > > +        [EXCP_ATOMIC    - EXCP_QEMU_INTERNAL] =3D "emulate atomic",
> > > +    };
> > > +    assert(excp >=3D EXCP_QEMU_INTERNAL);
> > > +    excp -=3D EXCP_QEMU_INTERNAL;
> > > +    if ((excp < ARRAY_SIZE(excp_name)) && excp_name[excp]) {
> > > +        return excp_name[excp];
> > > +    }
> > > +    return "undocumented";
> > > +}
> > > +
> > > +static void log_raise_exception(const CPUState *cpu, int excp)
> > > +{
> > > +    if (!qemu_loglevel_mask(CPU_LOG_INT)) {
> > > +        return;
> > > +    }
> > > +    if (excp >=3D EXCP_QEMU_INTERNAL) {
> > > +        qemu_log_mask(CPU_LOG_INT, "raise exception: 0x%x (internal:=
 %s)\n",
> > > +                                   excp, qemu_excp_name(excp));
> >
> > Daniel suggested on IRC we can use target_name() here to distinguish
> > between different kinds of vCPUs. Alternatively we can add a
> > CPUClass::log_friendly_format_name() defaulting to current "%p index:%d=
"
> > but overwritable i.e. as "accel:%s target:%s cluster:%d index:%u", so
> > each time we log something on a vCPU context we have an unified prefix
> > format to parse.
>
> That would be problematic. Those two different format strings have
> different args. Also since it is not a static string, it can't be
> concatenated with the format strnig being passed to qemu_log_mask().
> So that would imply sprintf'ing the CPU format string prefix first
> with whatever args it needs, before passing the result into the
> qemu_log_mask() call.
>
>      g_autofree char *prefix =3D g_strdup_printf(
>          "accel:%s target:%s cluster:%d index:%u",
>          accel, targe,t cluster, index);
>      cpu_log_mask(CPU_LOG_INT,
>                   "%s raise exception: 0x%x (internal: %s)\n",
>                   prefix, excp, qemu_excp_name(excp));
>
> the double layers of printf makes logging quite unpleasant,
> and while it could be hidden in a macro, the runtime overhead
> still exists.
>
> On IRC, I suggested an approach that would work at the preprocessor
> level to concatenate the arch target name at compile time on to the
> front of all log messages, so there is no runtime impact at all,
> nor any code impact beyond s/qemu_log_mask/qemu_log_mask_target/.
>
> #define  qemu_log_mask_target(MASK, FMT, ...)           \
>     do {                                                \
>         if (unlikely(qemu_loglevel_mask(MASK))) {       \
>           qemu_log(TARGET_NAME # FMT, ## __VA_ARGS__);\
>          }                                               \
>     } while (0)
>
> Note, TARGE_NAME is poisoned, so we can't add this to to main
> include/qemu/log.h file. It would need to live in a header file
> that is built per-target, and thus only used from target specific
> code like the TCG impls.
>
> As a slight variation, *if* we can assume each target arch's VCPUs
> are in a separate thread, we could avoid using TARGET_NAME directly
> and instead use a thread local
>
>   __thread const char *target_name;

I'm a bit confused, we already have target_name(), we can directly use
that, is that costing for logging?
the __thread things can be hidden in target_name() function wrapper.

>
> ...which would be initialized to TARGET_NAME when the vcpu's thread
> starts.
>
> Then  we would change the macro to be
>
> #define  qemu_log_mask_target(MASK, FMT, ...)           \
>     do {                                                \
>         if (unlikely(qemu_loglevel_mask(MASK))) {       \
>           qemu_log("%s" # FMT, target_name, ## __VA_ARGS__);\
>          }                                               \
>     } while (0)
>
> That would make it possible to include more dynamic information
> by adding more thread-locals and hiding more fmt args in the
> macro.
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

