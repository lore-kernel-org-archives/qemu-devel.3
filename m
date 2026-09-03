Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC284C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2B3h-0006nt-2Z; Thu, 03 Sep 2026 13:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x2B3W-0006mn-KT; Thu, 03 Sep 2026 13:16:55 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x2B2g-0005MC-KN; Thu, 03 Sep 2026 13:16:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C87E1FEDD;
 Thu,  3 Sep 2026 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788455756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqkHE4lkv5qVdZQNoBjMq+szLNP+N06LvOruHqEmJe0=;
 b=xoHPvgq5XsIsDtZv2TxXoa1hXtoinRZPY5TdeBqrjRrySJk124eYfwm7doiJ8KXLzJmWyA
 k+T5xPEyJs16NYhqKyE9KlbFHft0d1V19HEyJbAx8d9yvbrSQxq89fBqTbLDNMvzwpJAKg
 uOccUykiqzWqhPPtraR6oCp15dYg+Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788455756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqkHE4lkv5qVdZQNoBjMq+szLNP+N06LvOruHqEmJe0=;
 b=WX98vK1w0H1rqC4vh/7iTCdr/mlheD9+MWIjR9GSaYqyzzJnfn/xHvqcI5gzrLkRVuNw1T
 GvgEDlRmwAGSxmAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nf5NftEJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K3pv4lw9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788455752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqkHE4lkv5qVdZQNoBjMq+szLNP+N06LvOruHqEmJe0=;
 b=nf5NftEJMeP2d28HQ85rDhlMb+JJjqqnzh4y81nqwwKWV8gandEuJPda5tt4iWM0twUHQC
 HdNOJpRYxrnVNm+yQ/2m0RKxJj2wlx7tLF4HWKQFbXjKv+MXxSxgb+TG1851NS5rGxd0Ux
 I00BsXGvngvjR5Q956KwJALl2Z8QROU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788455752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqkHE4lkv5qVdZQNoBjMq+szLNP+N06LvOruHqEmJe0=;
 b=K3pv4lw9scWAlF7NIh3Bl0onwYm6bXw3XX+l0z6G3dXbSGQSC0yETo69snPVkB5PHPTIS/
 z56XDw0eRlCByGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAB34136E6;
 Thu,  3 Sep 2026 17:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m0ClKkermWqLOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Sep 2026 17:15:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, Peter Maydell
 <peter.maydell@linaro.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH 27/30] arm/machine: move to new migration APIs
In-Reply-To: <20260825213811.3725682-28-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
 <20260825213811.3725682-28-vsementsov@yandex-team.ru>
Date: Thu, 03 Sep 2026 14:15:41 -0300
Message-ID: <87jyp28ddu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5C87E1FEDD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yandex-team.ru:email,suse.de:dkim,suse.de:mid]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  target/arm/machine.c | 107 ++++++++++++++++++++++---------------------
>  1 file changed, 56 insertions(+), 51 deletions(-)
>
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 89127e5d83c..159a1f0e930 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -51,8 +51,8 @@ static bool vfp_fpcr_fpsr_needed(void *opaque)
>          (vfp_get_fpsr(env) & ~FPSCR_FPSR_MASK);
>  }
>=20=20
> -static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
> -                     const VMStateField *field)
> +static bool load_fpscr(QEMUFile *f, void *opaque, size_t size,
> +                     const VMStateField *field, Error **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
> @@ -62,78 +62,81 @@ static int get_fpscr(QEMUFile *f, void *opaque, size_=
t size,
>          /* 0 means we might have the data in the fpcr_fpsr subsection */
>          vfp_set_fpscr(env, val);
>      }
> -    return 0;
> +    return true;
>  }
>=20=20
> -static int put_fpscr(QEMUFile *f, void *opaque, size_t size,
> -                     const VMStateField *field, JSONWriter *vmdesc)
> +static bool save_fpscr(QEMUFile *f, void *opaque, size_t size,
> +                      const VMStateField *field,
> +                      JSONWriter *vmdesc, Error **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
>      uint32_t fpscr =3D vfp_fpcr_fpsr_needed(opaque) ? 0 : vfp_get_fpscr(=
env);
>=20=20
>      qemu_put_be32(f, fpscr);
> -    return 0;
> +    return true;
>  }
>=20=20
>  static const VMStateInfo vmstate_fpscr =3D {
>      .name =3D "fpscr",
> -    .get =3D get_fpscr,
> -    .put =3D put_fpscr,
> +    .load =3D load_fpscr,
> +    .save =3D save_fpscr,
>  };
>=20=20
> -static int get_fpcr(QEMUFile *f, void *opaque, size_t size,
> -                     const VMStateField *field)
> +static bool load_fpcr(QEMUFile *f, void *opaque, size_t size,
> +                     const VMStateField *field, Error **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
>      uint64_t val =3D qemu_get_be64(f);
>=20=20
>      vfp_set_fpcr(env, val);
> -    return 0;
> +    return true;
>  }
>=20=20
> -static int put_fpcr(QEMUFile *f, void *opaque, size_t size,
> -                     const VMStateField *field, JSONWriter *vmdesc)
> +static bool save_fpcr(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field,
> +                    JSONWriter *vmdesc, Error **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
>=20=20
>      qemu_put_be64(f, vfp_get_fpcr(env));
> -    return 0;
> +    return true;
>  }
>=20=20
>  static const VMStateInfo vmstate_fpcr =3D {
>      .name =3D "fpcr",
> -    .get =3D get_fpcr,
> -    .put =3D put_fpcr,
> +    .load =3D load_fpcr,
> +    .save =3D save_fpcr,
>  };
>=20=20
> -static int get_fpsr(QEMUFile *f, void *opaque, size_t size,
> -                     const VMStateField *field)
> +static bool load_fpsr(QEMUFile *f, void *opaque, size_t size,
> +                     const VMStateField *field, Error **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
>      uint64_t val =3D qemu_get_be64(f);
>=20=20
>      vfp_set_fpsr(env, val);
> -    return 0;
> +    return true;
>  }
>=20=20
> -static int put_fpsr(QEMUFile *f, void *opaque, size_t size,
> -                     const VMStateField *field, JSONWriter *vmdesc)
> +static bool save_fpsr(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field,
> +                    JSONWriter *vmdesc, Error **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
>=20=20
>      qemu_put_be64(f, vfp_get_fpsr(env));
> -    return 0;
> +    return true;
>  }
>=20=20
>  static const VMStateInfo vmstate_fpsr =3D {
>      .name =3D "fpsr",
> -    .get =3D get_fpsr,
> -    .put =3D put_fpsr,
> +    .load =3D load_fpsr,
> +    .save =3D save_fpsr,
>  };
>=20=20
>  static const VMStateDescription vmstate_vfp_fpcr_fpsr =3D {
> @@ -755,8 +758,8 @@ static const VMStateDescription vmstate_m_security =
=3D {
>      }
>  };
>=20=20
> -static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
> -                    const VMStateField *field)
> +static bool load_cpsr(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field, Error **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
> @@ -797,22 +800,22 @@ static int get_cpsr(QEMUFile *f, void *opaque, size=
_t size,
>          }
>          /* Ignore the low bits, they are handled by vmstate_m. */
>          xpsr_write(env, val, ~XPSR_EXCP);
> -        return 0;
> +        return true;
>      }
>=20=20
>      env->aarch64 =3D ((val & PSTATE_nRW) =3D=3D 0);
>=20=20
>      if (is_a64(env)) {
>          pstate_write(env, val);
> -        return 0;
> +        return true;
>      }
>=20=20
>      cpsr_write(env, val, 0xffffffff, CPSRWriteRaw);
> -    return 0;
> +    return true;
>  }
>=20=20
> -static int put_cpsr(QEMUFile *f, void *opaque, size_t size,
> -                    const VMStateField *field, JSONWriter *vmdesc)
> +static bool save_cpsr(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field, JSONWriter *vmdesc, Error=
 **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
> @@ -828,17 +831,17 @@ static int put_cpsr(QEMUFile *f, void *opaque, size=
_t size,
>      }
>=20=20
>      qemu_put_be32(f, val);
> -    return 0;
> +    return true;
>  }
>=20=20
>  static const VMStateInfo vmstate_cpsr =3D {
>      .name =3D "cpsr",
> -    .get =3D get_cpsr,
> -    .put =3D put_cpsr,
> +    .load =3D load_cpsr,
> +    .save =3D save_cpsr,
>  };
>=20=20
> -static int get_pstate64(QEMUFile *f, void *opaque, size_t size,
> -                        const VMStateField *field)
> +static bool load_pstate64(QEMUFile *f, void *opaque, size_t size,
> +                        const VMStateField *field, Error **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
> @@ -850,11 +853,12 @@ static int get_pstate64(QEMUFile *f, void *opaque, =
size_t size,
>      } else {
>          cpsr_write_from_spsr_elx(env, val);
>      }
> -    return 0;
> +    return true;
>  }
>=20=20
> -static int put_pstate64(QEMUFile *f, void *opaque, size_t size,
> -                        const VMStateField *field, JSONWriter *vmdesc)
> +static bool save_pstate64(QEMUFile *f, void *opaque, size_t size,
> +                         const VMStateField *field,
> +                         JSONWriter *vmdesc, Error **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>      CPUARMState *env =3D &cpu->env;
> @@ -866,7 +870,7 @@ static int put_pstate64(QEMUFile *f, void *opaque, si=
ze_t size,
>          val =3D cpsr_read_for_spsr_elx(env);
>      }
>      qemu_put_be64(f, val);
> -    return 0;
> +    return true;
>  }
>=20=20
>  static bool pstate64_needed(void *opaque)
> @@ -901,8 +905,8 @@ static const VMStateDescription vmstate_pstate64 =3D {
>              .size =3D sizeof(uint64_t),
>              .info =3D &(const VMStateInfo) {
>                  .name =3D "pstate64",
> -                .get =3D get_pstate64,
> -                .put =3D put_pstate64,
> +                .load =3D load_pstate64,
> +                .save =3D save_pstate64,
>              },
>              .flags =3D VMS_SINGLE,
>              .offset =3D 0,
> @@ -911,17 +915,17 @@ static const VMStateDescription vmstate_pstate64 =
=3D {
>      },
>  };
>=20=20
> -static int get_power(QEMUFile *f, void *opaque, size_t size,
> -                    const VMStateField *field)
> +static bool load_power(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field, Error **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>      bool powered_off =3D qemu_get_byte(f);
>      arm_set_cpu_power_state(cpu, powered_off ? PSCI_OFF : PSCI_ON);
> -    return 0;
> +    return true;
>  }
>=20=20
> -static int put_power(QEMUFile *f, void *opaque, size_t size,
> -                    const VMStateField *field, JSONWriter *vmdesc)
> +static bool save_power(QEMUFile *f, void *opaque, size_t size,
> +                    const VMStateField *field, JSONWriter *vmdesc, Error=
 **errp)
>  {
>      ARMCPU *cpu =3D opaque;
>=20=20
> @@ -931,16 +935,17 @@ static int put_power(QEMUFile *f, void *opaque, siz=
e_t size,
>          cpu->power_state =3D=3D PSCI_OFF) {
>          bool powered_off =3D (cpu->power_state =3D=3D PSCI_OFF) ? true :=
 false;
>          qemu_put_byte(f, powered_off);
> -        return 0;
> +        return true;
>      } else {
> -        return 1;
> +        error_setg(errp, "Migration should not happen during power trans=
ition");
> +        return false;
>      }
>  }
>=20=20
>  static const VMStateInfo vmstate_powered_off =3D {
>      .name =3D "powered_off",
> -    .get =3D get_power,
> -    .put =3D put_power,
> +    .load =3D load_power,
> +    .save =3D save_power,
>  };
>=20=20
>  static bool syndrome64_needed(void *opaque)

../target/arm/machine.c: In function =E2=80=98save_power=E2=80=99:
../target/arm/machine.c:940:9: error: implicit declaration of function =E2=
=80=98error_setg=E2=80=99 [-Wimplicit-function-declaration]
  940 |         error_setg(errp, "Migration should not happen during power =
transition");
      |         ^~~~~~~~~~
../target/arm/machine.c:940:9: error: nested extern declaration of =E2=80=
=98error_setg=E2=80=99 [-Werror=3Dnested-externs]

