Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B6EC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo64m-0002Kw-Ep; Sun, 26 Jul 2026 17:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wo64a-0002Jz-Uq
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:07:50 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wo64Y-0000zx-QF
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:07:48 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-ca957432c7fso1470239a12.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785100064; cv=none;
 d=google.com; s=arc-20260327;
 b=qCDZYUjZkA/09jKCfh9CjtG54g0ols6VLRqe9koIt49TpyXkn4tV8KtTG73bVwqnKR
 k/WRQJFftbgpe1WutIYVA60mMV34EDy68iyTSJJpBI+uKRUIlOFsg8We4xiyvTmBbwyf
 EbSuA1ojzxiLCgoDqIOTSPMp+lSYT8i0rj1kP2jCgA76YZIS0Siw6VJNi0ba/qWM05h5
 K9cuyS4Jcid+WVO8XO2RcKx85NeH6Ga0FIoeFk7kHTAOqbb07exnBsC+sMvAL/eJFvwO
 jXpFau4wU4/Bpffb+2qEjxN9OeCSloXkEp1+mSEvtUlCJun4owRCyB9o/axM+Xn4Q0Dp
 2FKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u2r7pEfz1ix8vkd0ThXfCOiLoWXimpXZCkwczzll1VY=;
 fh=uKI3ggVMJgYhH8K+/qh700OBsmBzXMzFdzBcQOaZbl0=;
 b=VA3k7wn7xS6ilgrE3SNeXVY9GX1Ucp4uyzZ9lRXAjMCKoNhlOgQ0r7kQYDuvJ0PfQ8
 Xv3+1Hu3v8tB8IZZ6zbjbThg+LGiqoGr4y60FGAfHsAL9HpQkUhnhIx0riARSTu2KCCE
 A/D5hDHJ962AsF5gyEeqA6Ods7RDOd4Yt/xxLmfxXp6QkkTTI49gmbHRjyGVgvjeVpvF
 pIsjozsEqpZ/MWydRf6pmqmjSujexZgz+JAENjm1QUEKZbPlQGUNjX5dt+r/ZLVR3pcc
 OstRqO+yV2A66RDgfm7W5r3BBA/x7TN0pJcOASILVNq5IioUE/r6zl+3vEXv34naq5L4
 KlqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785100064; x=1785704864; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u2r7pEfz1ix8vkd0ThXfCOiLoWXimpXZCkwczzll1VY=;
 b=C1Zf9Dd7OLGiCA9/LPL4G3RnL1gHDZwFBmKmGPWIn0azZq9midPZwJH0yCPNKPTGy3
 VgBusJGehMgd5Bqt7ws8DVYSvmexSCnWafOi2gpUl1BHJucfd9lSvxOMZvpEuo0B1ve8
 gxs1w02pSTzzd0ypKU8DEQTZpptWzE4uMeQ1vnPPCtfkXEvP6BaiCYwXmNyUkB9y/GYg
 xKF2ihaIMl6m2GYoUT/+20QJ4AFofLjEAF3tp8UGWmG/wUHT/6u68pMfOUVgAYoFtMt9
 irF47F15U+mzzCjFr0On6xQAMVA2hN4MT9/JzCd3SKpQTkE25ZyTw62tz2cAWZXSpZyN
 7puQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785100064; x=1785704864;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u2r7pEfz1ix8vkd0ThXfCOiLoWXimpXZCkwczzll1VY=;
 b=YzHX1cu+HI6swV/LQj1aEksPiQK6nplgEw4/CI23C+XbE//q+JzEGM72JFWWGe5jsb
 0g20U5Wu4J5tKgm1B7GpA1kELb0hEQvZLt6n4loRufyJ/xU0wnag1qqUpkGwH0DJzSlD
 U2NR3fyBHwvgybl4ZJtK/P/t9QeobBiLvou7iyM4SU8ru737EG9W5TPwrK2IKVFZAYZ4
 ROtN1No71SEq8xxN+E2g1U2ZZWmp6bZzmHk4J8fzibie8BzuSsnpboVCCaPt8UkXqJd5
 tyioOI1Zbnscebx+S0K+9lYQphf1tFoiw6cGD2vU9bTtuA3Dcwnoa4v8I3BhoaQ9jlqL
 iEig==
X-Gm-Message-State: AOJu0YyCc3Ug7EjbLM5QVuBp3kmNn8FNz57car7OHXDo/D3kNWEJ4GBM
 3g3D+QzNH3oA6F8ETB9JTrSXbbBs0W9itL7IlmZ3a6xYqKZnjbhI/NKZafUKf+HzywMFrDt8Cef
 a8YQ/kxEU05ZV2cMKOe4Z6GLjhDkpLn8=
X-Gm-Gg: AR+sD13vDcOp2LKDqCprUSj+iXX3kR2bJtKnYs6CV54+uogZ2DTHNSemTqHAtj6DL2r
 OUNY7tPDKSzBcgM8aGCixcPhBHJy4xN3Oev5VCsxNCtrw4OD0rWPTnubOAhwctnBDhgv/T+BFhG
 uN5z8cKZuEJUGxv6bNyzLAQevkGxSZXP3llz0Y8ziIemh5YjzVzueOdSgkRsdRj2rKaVoCdGXA3
 yTSGQ+NBZsJLQvJ4xilzWI/alq/xOigPidA7DpUrDI3R02zw6L4eMzNlLD61sDTOJgJ9R02VUlr
 2oE3dzWxmeFDPS49Iw==
X-Received: by 2002:a05:6a21:695:b0:3c3:64cc:311a with SMTP id
 adf61e73a8af0-3c67dd65ec9mr5862823637.22.1785100064432; Sun, 26 Jul 2026
 14:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
 <20260726165049-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260726165049-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 01:07:32 +0400
X-Gm-Features: AUfX_mzEvwCCsNgyO1efvLmuth4XGgxSCbse45Oox1CmDal_x5wIx9hKzgHU0tQ
Message-ID: <CAJ+F1C+jzxfbWbmLoU6vMobKUr0VFkpnr--FyPcy8o1=Q0vY-g@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] Fix some -Werror=maybe-uninitialized
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Mon, Jul 27, 2026 at 12:53=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jul 27, 2026 at 12:44:06AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > When compiled with -Og, gcc produces many false-positives
> > gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).
>
> it hurts if you do it? so don't do it then?

We are not far from getting it working, we can accommodate a bit of
code while making it a bit clearer for the reader too.

>
> > We already use auto-var-init=3Dzero, but better be explicit.
>
> explicit about false positives?

Explicit initialization

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  target/i386/cpu.c             | 3 ++-
> >  target/i386/emulate/x86_mmu.c | 4 ++--
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 5805d33ab92d..28e4435df23f 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -7734,7 +7734,7 @@ static void x86_cpuid_get_avx10_version(Object *o=
bj, Visitor *v,
> >  static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
> >                                           Error **errp)
> >  {
> > -    const AVX10VersionDefinition *def;
> > +    const AVX10VersionDefinition *def =3D NULL;
> >      CPUX86State *env =3D &cpu->env;
> >
> >      if (!version) {
> > @@ -7757,6 +7757,7 @@ static bool x86_cpu_apply_avx10_features(X86CPU *=
cpu, uint8_t version,
> >              break;
> >          }
> >      }
> > +    assert(def !=3D NULL);
> >
> >      if (def->version < version) {
> >          error_setg(errp, "avx10-version can be at most %d", def->versi=
on);
>
>
> what does assert have to do with gcc warnings?

That's what is expected at this point, unfortunately the compiler
doesn't care we help it here. I can drop it

> > diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mm=
u.c
> > index 8d4371467fd7..65bcccd4751e 100644
> > --- a/target/i386/emulate/x86_mmu.c
> > +++ b/target/i386/emulate/x86_mmu.c
> > @@ -185,8 +185,8 @@ static MMUTranslateResult walk_gpt(CPUState *cpu, t=
arget_ulong addr, MMUTranslat
> >      int largeness =3D 0;
> >      target_ulong cr3 =3D x86_read_cr(cpu, 3);
> >      uint64_t page_mask =3D pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_M=
ASK;
> > -    MMUTranslateResult res;
> > -
> > +    MMUTranslateResult res =3D MMU_TRANSLATE_PAGE_NOT_MAPPED;
> > +
>
>
> This is not 0 as the commit log implies.

Initializing with 0 implies defaulting to MMU_TRANSLATE_SUCCESS - not
the best choice here.

