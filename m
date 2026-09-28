Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C73CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDr1-0005lT-8T; Mon, 28 Sep 2026 12:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBDqz-0005jd-0Q
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:05:21 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBDqw-0007EY-UT
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:05:20 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6056ac81fso4571724a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790611517; cv=none;
 d=google.com; s=arc-20260327;
 b=m8eSHxUJX9O67RsPqeaFJr3o3nw7h9k5i2rR+HUj+wj8j51wAlUjbAEciJ4EINWsnf
 uDJZl2vzUAjE+sR8DWXae5Jy4wK8T3jDVwrsRSOEo7bZs0YxWEOhueY4zOT5kHbY+5tK
 cvu/DuQ0H3I2Wi/0jIkAS62vTSSDoPBhKfWFh86ZB3nvotPH+yNO1hERlRXoZcD++nGk
 PJizjRHqNTOKlbHgkQBFamn/OLCpQZmZKn9cXbYYsPS1fzkwk65OvmlQ5eUbVI9aEtad
 C5K8JQ3+Z+Fy15oHmRJMpchYp1w5t/94OsNEHhZDB0LCuOVlXqFWYz0Bi2ENffcg6N2a
 9/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=w9EzIeFbERenqhymBK9XblJ6PBKI//1Ot9k5xJ9LNso=;
 fh=4eeYYN7SaSVMgnkle1XNo8n3Za5vqgebzO1th9Am2XA=;
 b=gE/TcQCBdSQNfHiYcsaV5pr70632WrkAB94xuWWlYgIKOOSeIhdNkbuWmdyMeGb08o
 Ey5WYyM0oyhkTIqNg1Hz4E0sICH4J70ObgDx6GqM/W6DwHwxIXllhwfUFb7nR906pDIx
 AgxAv2mwpguFOI6uZger76W0R2uzwpwzYC+fufhgU11h9jfHQghUpotOTIn+Rtlk1EEI
 gTdPrgKrl41HA/hd6pq4QHWx+lJ1sX0Ea3vjPVxVXWzKyrhDHswZ38kqkLDkRx+T+Pwy
 YCJOqIi3AyRL/XNbaLz8uvE8Iywp/6+78EKNT0aIlXUAltB0DboW9bMYx6EuAxuSr2bA
 ifdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790611517; x=1791216317; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w9EzIeFbERenqhymBK9XblJ6PBKI//1Ot9k5xJ9LNso=;
 b=gDv5TVeTTeUH+4gi4thS2Y5FO9S5VVWqIEEH82BkfiINyYu3x1CcxAtlOKeS6B5Cmc
 jHAyF4xHO9aIoU69W69aB2BJQ4SGRsFacLpDrwwdQEZzcn6K6s/NS1hl9ilwlGBmFa1D
 R+nHpmbVTYh3j7QtrVF7NjV+qQf8w1VcahGqmkVFcs12cy99CKnQTVkM+jPoODzRCtOJ
 6MRfIq2GEleC2ogNKqJGDMeIzWw2kBnL+u0kwv7xy7AWdQCikravjoaRxGjcaq2kX17p
 Wi1jV+jFBhXyVt5sNvMT/hQqzBHXzPLSBEUyNYfDlvSmxx6c3kMT6wv6PCkNL2VDtSPZ
 NJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790611517; x=1791216317;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w9EzIeFbERenqhymBK9XblJ6PBKI//1Ot9k5xJ9LNso=;
 b=e/Sqw+s3l7ZAfdrlXREiVmSzWZLw5aGVGP0jrmCvDx/MjZYN7EJDlZ68ScWYI6MJI5
 I8d03rwG6p5AwTkCBPnDxl0pm7l4WWNk1dduvv/tUS4eRAx+R4FJ7D/5e6pkfPZs2FDO
 oobKw5yV1/RjVEBd4IM3AqpetSGouo3NAZ7Wx3D84bLdcxjyof/4XDl3qHPvu6za7f4p
 Gl9er5OFNo3wiQRjOXdqweZ0rNJFVvRgLtMFcofwfLvFyOLcfM/G34hbpHE4gjm74WPs
 iefD7xbTi9iBEtAgVaomZj8IfNEjEGoWXaYxjPastUtBZvydrdE9cC+d7NAdDmiBYrfX
 nllg==
X-Gm-Message-State: AFq9FYLpeB1TC47kqUqT6e4ARyyXhX+4qeES7elDSFcBv2Mp/TN+nBnd
 KHcYPxqh78Xq4eRcFsDe4bM5jvFdMXfyuLWVvl0GmrH3SD6oTafIPb197/WCPz5RWewee+d8PIx
 tC3P1XFbEj9GxgXG+ZSiJOf5VoHLo/W4=
X-Gm-Gg: AYBFou1UBBkWAkN5vhy3xyU8Fmgq/L3eUCVCm4lrtZwuFlSsS69vnzZwiI/+NDghUAI
 tEgUZ6uplojIyEPPU6mbrjSDPCLMZ5Nle+r9BryEZhli9u/yx5uhnjTRAnmuIVIdEoYjgnii1gG
 4FjWWFu4nU8w23HVld7RnfSPN5BjwEi/8+n12PUJ7+3L6sv7D+Abo03dMZqacOHw+dTTdgahLsK
 CYF7YNJySA/JlE2/52ea8MejRP1sL5OktvX6M27SfS58jFH1pv4NW9J6HaBhGBIXfZlkiDzU5z7
 kz+C+aB/RnKHUJen7LsQy0hMW70SxnmtRwX6rzQsNEz2WO6zvEJSfc4=
X-Received: by 2002:a05:6402:a290:10b0:6aa:e589:87df with SMTP id
 4fb4d7f45d1cf-6aae5898994mr5001332a12.30.1790611516982; Mon, 28 Sep 2026
 09:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
 <CAE2XoE9AAz8KfJrpErBaZvW5p5COxfE1yveA_AMPwa0j=ghyEA@mail.gmail.com>
 <arp7xUzPHmkgfxLC@redhat.com>
In-Reply-To: <arp7xUzPHmkgfxLC@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2026 00:05:04 +0800
X-Gm-Features: AclHuK_ySAh2wUP_ZLkRO-cTQXhVC-RYZXjpf9omF8LYWvQDhoUtMF2fg4CBqtU
Message-ID: <CAE2XoE_Zgs0_Co4ZLZiTRQZrx4DMRo_i-FEN79b+ZbHCedFd6w@mail.gmail.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x10.google.com
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

On Mon, Sep 28, 2026 at 10:38=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Mon, Sep 28, 2026 at 10:24:39PM +0800, Yonggang Luo wrote:
> > On Mon, Sep 28, 2026 at 6:14=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > I don't think that we need to report machines though.
> > > We already have 'query-machines' which gives much broader
> > > information on the machines. "MachineInfo" needs to
> > > gain
> > >
> > >    "targets": ["SysEmuTarget"]
> > >
> > > to list which target(s) a machine can be used with.
> > >
> >
> > This is my final design for the query-target / query-targets / query-ma=
chines,
> > for consistency and testability.
> >
> > Per review: reuse `QemuTargetInfo` for both target commands, drop the
> > per-target machine list, and let
> > `MachineInfo` say which target(s) each machine runs on.
> > `QemuTargetInfo` stays small; `query-target` and `query-targets` return=
 a
> > derived struct that adds the target's device and accel Kconfig state.
> >
> > ## QemuTargetInfo
> >
> > ```
> > { 'struct': 'QemuTargetInfo',
> >   'data': { 'arch': 'SysEmuTarget' } }  # since 1.2
> > ```
>
> > ## QemuTargetDetails: QemuTargetInfo plus kconfig
> >
> > ```
> > { 'struct': 'QemuTargetDetails',
> >   'base': 'QemuTargetInfo',
> >   'data': { 'kconfig': 'any' } }
> > ```
> >
> > `kconfig` maps every device and accel `CONFIG_*` symbol to whether it
> > is enabled for that target.
>
> KConfig is an internal implementation detail that should not be exposed
> to management apps as we don't want KConfig to become an ABI we must
> preserve.  QAPI introspection provides feature based information to
> the user. eg instead of querying for "CONFIG_SEV", qom-list-types can
> be queried to look for the 'sev-guest' class.

For example, `TYPE_NITRO_ENCLAVE_MACHINE` is available only when
`CONFIG_NITRO_ENCLAVE` is enabled for the target. When I construct the
machine list literal,
I need this information to help me to check if the machine is listed
in qemu-system that matches
qemu-sysetem-$arch. That needs a QAPI for it. What's the method you
would suggest
for? Otherwise, the test for the listing machine names can not be
reliably running for it.

for example:


/*
 * Machines omitted from the normal lists. Merged in when @kconfig is
 * true in the target's query-targets "kconfig" object, which already
 * folds in host libraries and accelerators. xenfv is an alias of
 * xenfv-4.2.
 */
static const char * const xen_pc_machines[] =3D {
    "xenpv",
    "xenpvh",
    "xenfv-4.2",
};

static const char * const xen_aarch64_machines[] =3D {
    "xenpvh",
};

static const char * const vmapple_machines[] =3D {
    "vmapple",
};

static const char * const microvm_machines[] =3D {
    "microvm",
};

static const char * const nitro_machines[] =3D {
    "nitro",
};

static const char * const nitro_enclave_machines[] =3D {
    "nitro-enclave",
};

static const char * const x_remote_machines[] =3D {
    "x-remote",
};

#define SPECIAL(t, k, m) { t, k, m, G_N_ELEMENTS(m) }

static const struct SpecialMachineMap {
    const char *target;
    const char *kconfig;
    const char * const *machines;
    size_t n_machines;
} special_machine_map[] =3D {
    SPECIAL("i386", "CONFIG_XEN", xen_pc_machines),
    SPECIAL("x86_64", "CONFIG_XEN", xen_pc_machines),
    SPECIAL("aarch64", "CONFIG_XEN", xen_aarch64_machines),
    SPECIAL("aarch64", "CONFIG_VMAPPLE", vmapple_machines),
    SPECIAL("i386", "CONFIG_MICROVM", microvm_machines),
    SPECIAL("x86_64", "CONFIG_MICROVM", microvm_machines),
    SPECIAL("x86_64", "CONFIG_NITRO_MACHINE", nitro_machines),
    SPECIAL("aarch64", "CONFIG_NITRO_MACHINE", nitro_machines),
    SPECIAL("i386", "CONFIG_NITRO_ENCLAVE", nitro_enclave_machines),
    SPECIAL("x86_64", "CONFIG_NITRO_ENCLAVE", nitro_enclave_machines),
    SPECIAL("i386", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("x86_64", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("aarch64", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("ppc", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("ppc64", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("s390x", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("riscv64", "CONFIG_MULTIPROCESS", x_remote_machines),
    SPECIAL("loongarch64", "CONFIG_MULTIPROCESS", x_remote_machines),
};

#undef SPECIAL

These machines all depend on the kconfig. When I try to write qtest
for it, I need the CONFIG_* information to be returned for them.

>
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

