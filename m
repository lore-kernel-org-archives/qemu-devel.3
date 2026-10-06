Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B15CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENBJ-0000Oe-VB; Wed, 07 Oct 2026 04:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEIgQ-0006HC-Sa
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:51:31 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEIgN-0002up-3l
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:51:09 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6af8620a7d2so2088737a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791345065; cv=none;
 d=google.com; s=arc-20260327;
 b=PnDx2b7/gB8jvmQEiiug0jhP/3/UmnFzvACvAa4o2cBgTb3rgt4oB98pcqfEHxG29a
 dWcjI4wi0mUV/ujjTM98Z7efEfcl1SXUplsdD4E5oRlqTFpACtBJ2H7ONf4QxHNovNMr
 bl5pYNjhxwU7SeoCzsUiauNyMCNMcuwu6PWYLc1Z8JXJOA8YhFdiA8M3lX/0AzfSPh/v
 at/X7p9nSSLiBWJ411j5913IzMgat3n3/oQd2lOQrhJlcedxJkmyFgXAw00E9a3W8vfP
 C6R0/p3e+3PLGjA/CNv8L/aCFhWZoCw3tE7h7B3tTTOY+9rXQ62dTpNiE698cMPKomSC
 5bDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=wvjd8rpKftWz+IQsEhLo/5THb60flXR5RBB+A48+eCM=;
 fh=IXxx+34ywcA9jGgCutUL6lsIwrMKaxl6D+9BBuyCi1U=;
 b=pQbkyqvjAbuZta/2PY6MZ/EX+2GoJKf8hZKqecLkzAgl2n+hJXB2dTkkiN8V+CcKDK
 rVndRH677TNQgdaZ2UncgCxzXZY6UDlPUXPI4/Zg22bhLuRpi8fmq93ROrr/1v29lKiE
 3AfXoyBj84kOtivPIR0yuCb7jwqhg8EL1+E4PweL9UZ4w6a9bUa43D6PiRy+UrhGNZdf
 dnk0KlBuwNe7v6NDILXNwhcPFguOo+f7jNplAU/3qVxF2xgznY6gFVav0xzBGTFgnCfL
 DzFcjOvrGj9lhAWe/hwVTu8XXHbAYpG42iRUC9IGfoplmHHwGUpnIc0MCZjaB7y5GMzq
 3XDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791345065; x=1791949865; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wvjd8rpKftWz+IQsEhLo/5THb60flXR5RBB+A48+eCM=;
 b=ZPMYoiDhgzDa/uyDfjOp35TPZ8j37ndg9mW8AwWpYQ1cfUxxNxbhtbI26PXc/FH3la
 MoVxkSp1FbsrwMWPO6Iq3PNKHOj5fNH3ldynKKh1pNyUp8yq/PR7oSJ+pu30WWnMwNvu
 HbrQcShRCyLZ6HVJrL8ljAa6Ab88Pnavo6YTp0xOJ24VVTFXi+fVlbgnHG05kzDy9TK6
 LdHx84DYbPP7hdxNMb69EOKWUJDM2yOij/vSv/u1AN6eSSeXZqXumeIctfZe8iYqQ6R/
 WYxQITFqvXBKl/kAfTl7+zT9JOZLJq7Q0ySreJV6fftYY5AdMsaakr6iEgkGFXBjKLa1
 RFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791345065; x=1791949865;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wvjd8rpKftWz+IQsEhLo/5THb60flXR5RBB+A48+eCM=;
 b=Civ+JYUA68R9y0GCbFQ4hf6/S2dtMcwm952L+1jEXDvGzW7tdIqPsBFgYFFywwgxtz
 nWNTXvv1mr2U1/Y4tiWrsKIuL6cSo/u3kkAFtzccuFbKcHF7mxo286pmLwbjGQZvJtwS
 tYmRA3QSjjRQsrPzoNSIGdBFExhFtpeuENNdtNhR2i/QI+OovzvgNOU19FuhTkWcrXCl
 BDQmsV1H755gIaEC7ejZxmlIQQ4TyaJP61f4uIHRngHEb9aFQc6Eryi0zrlzNHcafWcI
 hRfHQyZ9L39c8IOMv2oy/vhIvTW0jaHUB1miSQUXL+nZATvcuCZbUZO7mh6lxVFVubwH
 oP5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLsP3nh+MQIz0ye8X+n3hDB4+AXIhdSp8EqIj8CcDCkH8BfgeCw65Y5PgtLzsnsBy7PrEcRKEjaCDA@nongnu.org
X-Gm-Message-State: AFq9FYKb4lCAH0Crb9SF+rfaZlJ6MzbH8rbLmSCXydVo4G/lAAAUGer6
 4lSqIdlyAmbYD6U4HU//TGTpbhPsWB4UiWGEKl2R9mixdAsToN1zu7uF9Ca/kdRlr4RliHvMWAz
 IjBrA9fRX9wYutuCIC75aVZ+B8ZpbUTDlCnvT
X-Gm-Gg: AYBFou2UVkLltE5T1fdn1qo3TncK92jtYCB+W5MrkplOHb87gBoaSdIQiMchlMOmAj0
 D4glAhluRHA3o0CRWR98TOt19CnxMi63Wb0SvHUL9PgF9wFF9ahtvjbMig0YAXngf34hEmRXEcb
 4yPAad/UeizdTXDNdmAnOlzAZFYnCDXcBLWataZfwI5fBuPSLK5Px3jvzRQ/oaYu3gnjg0HhOjR
 EE2a3NhTI+7dWr60ie2T3X1aB9BBDi2U802flAPL7yOlxASr0Yi5TzzE+KfUvabIxNaqyJdJBgV
 w/iyiugLgjm6GRf4yb2FJb2J+/q7jox5SiyUSciHGnI+/hgprzlg8y8=
X-Received: by 2002:a05:6402:1e92:b0:6aa:a015:716e with SMTP id
 4fb4d7f45d1cf-6afe29cd311mr1666433a12.41.1791296400351; Tue, 06 Oct 2026
 07:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
 <asT-GoQ6xH4-dLET@redhat.com>
In-Reply-To: <asT-GoQ6xH4-dLET@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2026 22:19:47 +0800
X-Gm-Features: AclHuK8ZQyFp8bUbwk2uZAhPtizIeNEgKYlqHzDprudn-As8byAVTqK0FwvHZI4
Message-ID: <CAE2XoE8NSUik9VDRCithDmuGcqP6YYvdJQ7ggpcELGyFswFrwg@mail.gmail.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 6, 2026 at 9:56=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
>
> For example on 10.1.0:
>
> $ for i in /usr/bin/qemu-system-* ; do echo -n "$i: " ; echo -e '{"execut=
e":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"}\=
r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null=
 ; done
> /usr/bin/qemu-system-aarch64: "aarch64"
> /usr/bin/qemu-system-alpha: "alpha"
> /usr/bin/qemu-system-arm: "arm"
> /usr/bin/qemu-system-avr: "avr"
> /usr/bin/qemu-system-hppa: "hppa"
> /usr/bin/qemu-system-i386: "i386"
> /usr/bin/qemu-system-loongarch64: "loongarch64"
> /usr/bin/qemu-system-m68k: "m68k"
> /usr/bin/qemu-system-microblaze: "microblaze"
> /usr/bin/qemu-system-microblazeel: "microblazeel"
> /usr/bin/qemu-system-mips: "mips"
> /usr/bin/qemu-system-mips64: "mips64"
> /usr/bin/qemu-system-mips64el: "mips64el"
> /usr/bin/qemu-system-mipsel: "mipsel"
> /usr/bin/qemu-system-or1k: "or1k"
> /usr/bin/qemu-system-ppc: "ppc"
> /usr/bin/qemu-system-ppc64: "ppc64"
> /usr/bin/qemu-system-riscv32: "riscv32"
> /usr/bin/qemu-system-riscv64: "riscv64"
> /usr/bin/qemu-system-rx: "rx"
> /usr/bin/qemu-system-s390x: "s390x"
> /usr/bin/qemu-system-sh4: "sh4"
> /usr/bin/qemu-system-sh4eb: "sh4eb"
> /usr/bin/qemu-system-sparc: "sparc"
> /usr/bin/qemu-system-sparc64: "sparc64"
> /usr/bin/qemu-system-tricore: "tricore"
> /usr/bin/qemu-system-x86_64: "x86_64"
> /usr/bin/qemu-system-xtensa: "xtensa"
> /usr/bin/qemu-system-xtensaeb: "xtensaeb"
>
>
> but on git master:
>
> $ for i in $(find ./build -type f -name 'qemu-system-*') ; do echo -n "$i=
: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}=
\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .ret=
urn.arch | grep -v null ; done
> ./build/qemu-system-hexagon: "hexagon"
> ./build/qemu-system-x86_64: "x86_64"
> ./build/qemu-system-s390x: "s390x"
> ./build/qemu-system-m68k: "m68k"
> ./build/qemu-system-xtensa: "xtensa"
> ./build/qemu-system-xtensaeb: "xtensa"
> ./build/qemu-system-rx: "rx"
> ./build/qemu-system-loongarch64: "loongarch64"
> ./build/qemu-system-riscv32: "riscv32"
> ./build/qemu-system-hppa: "hppa"
> ./build/qemu-system-ppc64: "ppc64"
> ./build/qemu-system-microblaze: "microblaze"
> ./build/qemu-system-sparc: "sparc"
> ./build/qemu-system-riscv64: "riscv64"
> ./build/qemu-system-i386: "i386"
> ./build/qemu-system-mipsel: "mips"
> ./build/qemu-system-sh4: "sh4"
> ./build/qemu-system-mips64el: "mips64"
> ./build/qemu-system-mips64: "mips64"
> ./build/qemu-system-sparc64: "sparc64"
> ./build/qemu-system-arm: "arm"
> ./build/qemu-system-tricore: "tricore"
> ./build/qemu-system-mips: "mips"
> ./build/qemu-system-or1k: "or1k"
> ./build/qemu-system-sh4eb: "sh4"
> ./build/qemu-system-aarch64: "aarch64"
> ./build/qemu-system-ppc: "ppc"
> ./build/qemu-system-avr: "avr"
> ./build/qemu-system-alpha: "alpha"
>
>
> so we need to fix that behaviour change for query-target.
>
> If we want to be able to expose only the "base" target,
> then query-target's  QemuTargetInfo struct could be
> extended with a 2nd field that presents the base.
>

Thanks a lot, this is a better way to describe the issue.

>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

