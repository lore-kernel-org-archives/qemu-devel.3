Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AABCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR36-000450-5H; Tue, 16 Sep 2025 04:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1uyR34-00044U-5H
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:28:26 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1uyR30-0005Y3-9A
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:28:25 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5DD0B3F529
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1758011297;
 bh=mOxgbBelQVtMfLAAGSDSv7Up+z367EFXer98eyldTQM=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=P51ecp9CLrlSRvTLeqbQYW7sFd91DXyetjz9iU+wrtMeDPLE7MIjL7i7O4/gnp+sj
 FjNTlIZuz1iIwp19rmNIgxQecfNQ1OzPH+DQtbq7U2wcRIi00yX4uFxGVFm9Xm4Y16
 1Ox5ZeUmNZ2tCMe0URG/P5JyEsPSjbnNZuAa3QgaBm7nDuDbsHjMbO8zZVSsSyLhxT
 Q+UjMXOUvMejjv8L0vA4/mN94+7Apadj8dqdKbVoybjrVEdodh7tJEl9y1rjHX3934
 J07YYrLfFT48M+78LVjLQkG4BuMjPdfZfSX3xZANxJ8k556oS9x3XjVRJDpEZSSSUo
 eKosllff12ybQ==
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6215a926e31so4106342a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 01:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758011296; x=1758616096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mOxgbBelQVtMfLAAGSDSv7Up+z367EFXer98eyldTQM=;
 b=WoBdCA+hatj0ZGBoD4O73Z6xrqgPh4T64e/tJ+ptp61kUnFyBo6mnmuwzzBufqtc8P
 cC2Mhb1lAJ7+rfJGxgbwMmrjRjDd9gH3/yZkOEnDllKWUzFm+FdE5bl/ioyhr6nFUTj4
 uhI7kAO0uXmsyDmKEB1FpKPNbMMqIGFPNCUixdJsDH2u8JJR7N/nBmI8PKZXIIN7BWxK
 i5gqCQdTqhmRb+zKRZRBW7jSstFOkf9fP+toN10zexeJd/pw1ev25VE6v30bdu1/zTo3
 kSug821mfS+6AW2qbCwPNWXEK546N+q8CNpCMwSQWkw/N2rXjYq85m7XBI9xt6YDOurb
 BC+A==
X-Gm-Message-State: AOJu0YwFiNTvQY6BSIvakhlCRV/yThy9+S5hP3v8JKPiUxBn0XCjro3q
 Fd9/qC9HhnyWV5EacCx0ZtOW+oFiMxEIEV5/4GYoALbcOwHij9uuX7GKp1SLamEDQwMz3uKSm53
 GvmOt+A32q/sFxc5JVnvQ/vZNmfbxeJsfRbvS5210zpffUCpLv+aqw2Miwu/nbx7pkw3ddFgJbU
 9nRAPZxuDuHJLrv9bKM9rdSbxZzUQNhVb/afgHj8ibAmBOy5DszkqfnkqDdoD1mO0=
X-Gm-Gg: ASbGncvQK5BZbTIx2o7wYvVgGO1UcYdu9DtReKAKbZWOywIFZJgsSkYIRB1OuTEombO
 IZFIMRvnBW1HoLe7MUiUKHSVXwYjaON44+419J606hbeJtoqcM6v+Bd2yfixp96KmzJpVIHqsDm
 3h2H7W21KJvcHIserV56inR7evsr9Ef6u0mYYX4aYfoL5Lq+4OflEmR5uBHQ6ks1TWY2xmD6uDx
 K+jwSy4xPYx
X-Received: by 2002:a05:6402:524a:b0:62f:4dbc:6792 with SMTP id
 4fb4d7f45d1cf-62f4dbc6a5cmr4615105a12.23.1758011296502; 
 Tue, 16 Sep 2025 01:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFafPkxEgb87SXqwZ9MAYp6bh51z3VFkcmYWGYLWLIT1pjekejlRZOMqMKrHjOGkgqe2kGeUDlxSwPBWFxcstU=
X-Received: by 2002:a05:6402:524a:b0:62f:4dbc:6792 with SMTP id
 4fb4d7f45d1cf-62f4dbc6a5cmr4615087a12.23.1758011296010; Tue, 16 Sep 2025
 01:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <CABjvBV7wgfSv-OjGf_L2t9ranXfzTQTSBdRAFODpHH-nFcLFig@mail.gmail.com>
 <20250910115733.21149-1-hector.cao@canonical.com>
 <20250910115733.21149-2-hector.cao@canonical.com>
 <aMkb60m0cbFJvv-b@redhat.com>
In-Reply-To: <aMkb60m0cbFJvv-b@redhat.com>
From: Hector Cao <hector.cao@canonical.com>
Date: Tue, 16 Sep 2025 10:28:03 +0200
X-Gm-Features: AS18NWCGYtO29MgmWxPdnEGo_ql-uHB55WQvNszZGnOLAunoHCNbUBE8AnbqUuo
Message-ID: <CABjvBV6gB6bSLhSjGfrJy2zBRtE30D3Jw=+L-2PsZnHJt0LZ-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/i386: add compatibility property for
 arch_capabilities
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cf6887063ee6e6da"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_REMOTE_IMAGE=0.01 autolearn=ham autolearn_force=no
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

--000000000000cf6887063ee6e6da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:13=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> CC Paolo as maintainer
>
> On Wed, Sep 10, 2025 at 01:57:32PM +0200, Hector Cao wrote:
> > Prior to v10.1, if requested by user, arch-capabilities is always on
> > despite the fact that CPUID advertises it to be off/unvailable.
> > this causes a migration issue for VMs that are run on a machine
> > without arch-capabilities and expect this feature to be present
> > on the destination host with QEMU 10.1.
> >
> > This commit add a compatibility property to restore the legacy
> > behavior for all machines with version prior to 10.1
> >
>
> Can you add a 'Fixes: <hash>' line to refer to the orignial
> commit in 10.1 that introduced the regression.
>

Thanks Daniel for the feedback,

Since this patch is a PoC at the moment,  I will submit the final one later
once I have enough feedback

Here is the line I will add to this patch header:

Fixes: d3a2413


>
> > Signed-off-by: Hector Cao <hector.cao@canonical.com>
> > ---
> >  hw/core/machine.c     |  1 +
> >  migration/migration.h | 12 ++++++++++++
> >  migration/options.c   |  3 +++
> >  target/i386/kvm/kvm.c |  5 ++++-
> >  4 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 38c949c4f2..8ad5d79cb3 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -45,6 +45,7 @@ GlobalProperty hw_compat_10_0[] =3D {
> >      { "vfio-pci", "x-migration-load-config-after-iter", "off" },
> >      { "ramfb", "use-legacy-x86-rom", "true"},
> >      { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
> > +    { "migration", "arch-cap-always-on", "true" },
> >  };
> >  const size_t hw_compat_10_0_len =3D G_N_ELEMENTS(hw_compat_10_0);
> >
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 01329bf824..5124ff3636 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -510,6 +510,18 @@ struct MigrationState {
> >      bool rdma_migration;
> >
> >      GSource *hup_source;
> > +
> > +    /*
> > +     * This variable allows to keep the backward compatibility with
> QEMU (<10.1)
> > +     * on the arch-capabilities detection.
> > +     * With the commit d3a2413 (since 10.1), the arch-capabilities
> feature is gated
> > +     * with the CPUID bit (CPUID_7_0_EDX_ARCH_CAPABILITIES) instead of
> being always
> > +     * enabled when user requests for it. this new behavior breaks
> migration of VMs
> > +     * created and run with older QEMU on machines without
> IA32_ARCH_CAPABILITIES MSR,
> > +     * those VMs might have arch-capabilities enabled and break when
> migrating
> > +     * to a host with QEMU 10.1 with error : missing feature
> arch-capabilities
> > +     */
> > +    bool arch_cap_always_on;
> >  };
> >
> >  void migrate_set_state(MigrationStatus *state, MigrationStatus
> old_state,
> > diff --git a/migration/options.c b/migration/options.c
> > index 4e923a2e07..3a80dba9c5 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -203,6 +203,9 @@ const Property migration_properties[] =3D {
> >                          MIGRATION_CAPABILITY_SWITCHOVER_ACK),
> >      DEFINE_PROP_MIG_CAP("x-dirty-limit",
> MIGRATION_CAPABILITY_DIRTY_LIMIT),
> >      DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM)=
,
> > +
> > +    DEFINE_PROP_BOOL("arch-cap-always-on", MigrationState,
> > +                     arch_cap_always_on, false),
> >  };
> >  const size_t migration_properties_count =3D
> ARRAY_SIZE(migration_properties);
> >
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index 306430a052..e2ec4e6de5 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -42,6 +42,7 @@
> >  #include "xen-emu.h"
> >  #include "hyperv.h"
> >  #include "hyperv-proto.h"
> > +#include "migration/migration.h"
> >
> >  #include "gdbstub/enums.h"
> >  #include "qemu/host-utils.h"
> > @@ -438,6 +439,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s,
> uint32_t function,
> >      uint32_t ret =3D 0;
> >      uint32_t cpuid_1_edx, unused;
> >      uint64_t bitmask;
> > +    MigrationState *ms =3D migrate_get_current();
> >
> >      cpuid =3D get_supported_cpuid(s);
> >
> > @@ -508,7 +510,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s,
> uint32_t function,
> >           * mcahines at all, do not show the fake ARCH_CAPABILITIES MSR
> that
> >           * KVM sets up.
> >           */
> > -        if (!has_msr_arch_capabs || !(edx &
> CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
> > +        if (!has_msr_arch_capabs
> > +            || (!(edx & CPUID_7_0_EDX_ARCH_CAPABILITIES) &&
> (!ms->arch_cap_always_on))) {
> >              ret &=3D ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
> >          }
> >      } else if (function =3D=3D 7 && index =3D=3D 1 && reg =3D=3D R_EAX=
) {
> > --
> > 2.45.2
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
Hector CAO
Software Engineer =E2=80=93 Server Team / Virtualization
hector.cao@canonical.com
https://launc <https://launchpad.net/~hectorcao>hpad.net/~hectorcao
<https://launchpad.net/~hectorcao>

<https://launchpad.net/~hectorcao>

--000000000000cf6887063ee6e6da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br></div></div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On T=
ue, Sep 16, 2025 at 10:13=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D=
"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">CC Paolo as maintainer<br>
<br>
On Wed, Sep 10, 2025 at 01:57:32PM +0200, Hector Cao wrote:<br>
&gt; Prior to v10.1, if requested by user, arch-capabilities is always on<b=
r>
&gt; despite the fact that CPUID advertises it to be off/unvailable.<br>
&gt; this causes a migration issue for VMs that are run on a machine<br>
&gt; without arch-capabilities and expect this feature to be present<br>
&gt; on the destination host with QEMU 10.1.<br>
&gt; <br>
&gt; This commit add a compatibility property to restore the legacy<br>
&gt; behavior for all machines with version prior to 10.1<br>
&gt;<br>
<br>
Can you add a &#39;Fixes: &lt;hash&gt;&#39; line to refer to the orignial<b=
r>
commit in 10.1 that introduced the regression.<br></blockquote><div><br></d=
iv>Thanks Daniel for the feedback,<div><br></div><div>Since this patch is a=
 PoC at the=C2=A0moment,=C2=A0 I will submit the final one later once I hav=
e enough feedback</div><div><br></div><div>Here is the line I will add to t=
his patch header:</div><div><br></div><div><span style=3D"color:rgb(31,35,4=
0);font-family:&quot;Monaspace Neon&quot;,ui-monospace,SFMono-Regular,&quot=
;SF Mono&quot;,Menlo,Consolas,&quot;Liberation Mono&quot;,monospace;font-si=
ze:12px;white-space:pre">Fixes: d3a2413</span></div><div>=C2=A0=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Signed-off-by: Hector Cao &lt;<a href=3D"mailto:hector.cao@canonical.c=
om" target=3D"_blank">hector.cao@canonical.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/core/machine.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 migration/migration.h | 12 ++++++++++++<br>
&gt;=C2=A0 migration/options.c=C2=A0 =C2=A0|=C2=A0 3 +++<br>
&gt;=C2=A0 target/i386/kvm/kvm.c |=C2=A0 5 ++++-<br>
&gt;=C2=A0 4 files changed, 20 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/core/machine.c b/hw/core/machine.c<br>
&gt; index 38c949c4f2..8ad5d79cb3 100644<br>
&gt; --- a/hw/core/machine.c<br>
&gt; +++ b/hw/core/machine.c<br>
&gt; @@ -45,6 +45,7 @@ GlobalProperty hw_compat_10_0[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;vfio-pci&quot;, &quot;x-migration-load-con=
fig-after-iter&quot;, &quot;off&quot; },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;ramfb&quot;, &quot;use-legacy-x86-rom&quot=
;, &quot;true&quot;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 { &quot;vfio-pci-nohotplug&quot;, &quot;use-legacy=
-x86-rom&quot;, &quot;true&quot; },<br>
&gt; +=C2=A0 =C2=A0 { &quot;migration&quot;, &quot;arch-cap-always-on&quot;=
, &quot;true&quot; },<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 const size_t hw_compat_10_0_len =3D G_N_ELEMENTS(hw_compat_10_0)=
;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/migration/migration.h b/migration/migration.h<br>
&gt; index 01329bf824..5124ff3636 100644<br>
&gt; --- a/migration/migration.h<br>
&gt; +++ b/migration/migration.h<br>
&gt; @@ -510,6 +510,18 @@ struct MigrationState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool rdma_migration;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 GSource *hup_source;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* This variable allows to keep the backward compa=
tibility with QEMU (&lt;10.1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* on the arch-capabilities detection.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* With the commit d3a2413 (since 10.1), the arch-=
capabilities feature is gated<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* with the CPUID bit (CPUID_7_0_EDX_ARCH_CAPABILI=
TIES) instead of being always<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* enabled when user requests for it. this new beh=
avior breaks migration of VMs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* created and run with older QEMU on machines wit=
hout IA32_ARCH_CAPABILITIES MSR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* those VMs might have arch-capabilities enabled =
and break when migrating<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* to a host with QEMU 10.1 with error : missing f=
eature arch-capabilities<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 bool arch_cap_always_on;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void migrate_set_state(MigrationStatus *state, MigrationStatus o=
ld_state,<br>
&gt; diff --git a/migration/options.c b/migration/options.c<br>
&gt; index 4e923a2e07..3a80dba9c5 100644<br>
&gt; --- a/migration/options.c<br>
&gt; +++ b/migration/options.c<br>
&gt; @@ -203,6 +203,9 @@ const Property migration_properties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 MIGRATION_CAPABILITY_SWITCHOVER_ACK),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_MIG_CAP(&quot;x-dirty-limit&quot;, MIG=
RATION_CAPABILITY_DIRTY_LIMIT),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_MIG_CAP(&quot;mapped-ram&quot;, MIGRAT=
ION_CAPABILITY_MAPPED_RAM),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;arch-cap-always-on&quot;, Migrat=
ionState,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0arch_cap_always_on, false),<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 const size_t migration_properties_count =3D ARRAY_SIZE(migration=
_properties);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c<br>
&gt; index 306430a052..e2ec4e6de5 100644<br>
&gt; --- a/target/i386/kvm/kvm.c<br>
&gt; +++ b/target/i386/kvm/kvm.c<br>
&gt; @@ -42,6 +42,7 @@<br>
&gt;=C2=A0 #include &quot;xen-emu.h&quot;<br>
&gt;=C2=A0 #include &quot;hyperv.h&quot;<br>
&gt;=C2=A0 #include &quot;hyperv-proto.h&quot;<br>
&gt; +#include &quot;migration/migration.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;gdbstub/enums.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/host-utils.h&quot;<br>
&gt; @@ -438,6 +439,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s,=
 uint32_t function,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t ret =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t cpuid_1_edx, unused;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t bitmask;<br>
&gt; +=C2=A0 =C2=A0 MigrationState *ms =3D migrate_get_current();<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpuid =3D get_supported_cpuid(s);<br>
&gt;=C2=A0 <br>
&gt; @@ -508,7 +510,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s,=
 uint32_t function,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* mcahines at all, do not show=
 the fake ARCH_CAPABILITIES MSR that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* KVM sets up.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!has_msr_arch_capabs || !(edx &amp; C=
PUID_7_0_EDX_ARCH_CAPABILITIES)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!has_msr_arch_capabs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || (!(edx &amp; CPUID_7_0_E=
DX_ARCH_CAPABILITIES) &amp;&amp; (!ms-&gt;arch_cap_always_on))) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret &amp;=3D ~CPUID_7_=
0_EDX_ARCH_CAPABILITIES;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else if (function =3D=3D 7 &amp;&amp; index =3D=
=3D 1 &amp;&amp; reg =3D=3D R_EAX) {<br>
&gt; -- <br>
&gt; 2.45.2<br>
&gt; <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div style=3D"text-align:left"></div><div style=
=3D"text-align:left">Hector CAO<br></div><div style=3D"text-align:left">Sof=
tware Engineer =E2=80=93 Server Team / Virtualization</div><div style=3D"te=
xt-align:left"><a href=3D"mailto:hector.cao@canonical.com" target=3D"_blank=
">hector.cao@canonical.com</a></div><div style=3D"text-align:left"><a href=
=3D"https://launchpad.net/~hectorcao" target=3D"_blank">https://launc</a><a=
 href=3D"https://launchpad.net/~hectorcao" target=3D"_blank">hpad.net/~hect=
orcao</a></div><div style=3D"text-align:left">
<p style=3D"line-height:100%;margin-bottom:0in"> =20
<a href=3D"https://launchpad.net/~hectorcao" target=3D"_blank"><img width=
=3D"96" height=3D"81" src=3D"https://ci3.googleusercontent.com/mail-sig/AIo=
rK4z5yECcB4DOFqFQjPXjogBAVC5Vv1klgihEnAZXkqybF5lNxe9SeDqtm-9dmSwj3Sbw2kDL58=
U"></a></p>

</div></div></div></div>

--000000000000cf6887063ee6e6da--

