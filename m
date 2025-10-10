Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5598CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 03:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v73ld-0004OL-92; Thu, 09 Oct 2025 23:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v73lb-0004O6-AK
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:26:03 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v73lU-00022q-FX
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:26:03 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-64a760e5281so527518eaf.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 20:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1760066746; x=1760671546; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SPCzBSe17DsVrG2R5Ia2ittybxehIqWLJkZuXUDr1QU=;
 b=YwxobI5EZD1Rx7bO9woka3RRi7BXzzJQbBpgXVJ7vsXGfISAphxbp6oh5TB5oO7es2
 q2n2lGYo3A9jzKtDk2vOXvq774y/g+v/ANNCveWx55FAwMgk4BkOi8/cppL34K+dkq3L
 Q64FNbC/wctwqz3Dq+YbYm6Fs+PGJGReKvEZ/Lg/LcddeSTcroaHcnh+a5JwET/wPm6Y
 iJ0l0zMDGgjjlUUxqakVNl4sdto7wriTguT0KlyfXwQ+VhsZ6ceYIOSp0XaPX6J06m81
 uBZVG5RVF+eGt//htx3jx2FRiUA8mjr9UThMWQfbCembPOOs1ue/mZl5V9wQ/fOwqe5z
 gK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760066746; x=1760671546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SPCzBSe17DsVrG2R5Ia2ittybxehIqWLJkZuXUDr1QU=;
 b=UKIPcq2gFD0f5vm5qrFJCnMd/jJ3x6S4XoFmzKgL/iochgz+a2FV4NfTm4fTLj9l99
 SGiLxg5TkPEz3N5BOOViu0XsBETYx+DZ+Dwhfre6xuCNeBGIT6uWM7+jZWaUou9jegI1
 Q9S6JJ3uMbk8o+jIcy46b/UIcyUpsrFutISUcqOhKiBVNrRkoAM1GLvG2mex8TWqE7jG
 BXmqKEaa9yAT6UnT5pWdZV4Tl7/eOJHC1MYHA65XmAV403ToBSjAksm6FwKVf5p94Sw2
 ndULKTgDph9Dz1XGHx5iQWu4SLouxIjv1Wukn71VawFiWjj+N6WGarCxGEAbg1acdbLK
 pHtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/fSuPeh5UIGAHuWj3IDzqTWHRLJPaZkZLOJ2uoJ1BtGqkszZBpaQEq+tg8cUVgB0/+JRXk8tMsqdq@nongnu.org
X-Gm-Message-State: AOJu0YyPffD8cjjhFxYLbtOiD7Stcy5sLGjBK1Irz/uQtaBagtiHPDiw
 +VdZtYHQfrASNSBlE8Q/AgtK23iBsR71F1fbvKggWnUmUZUQsZSJuBNWghP81uY+hh/gXSbOqS4
 bwyIbPiSvZBPD0m+cTcOPkvPIBdX8BIzjP+zH9dfDCg==
X-Gm-Gg: ASbGncvuCOQPJmZoRpqsQB0+3Sfs9Sju/FBvjmbhIvozJf+TEoKpIF1xLR+AAFJKTyO
 FRXLUV1qioOUjzs4ho4KwM+MrSeA+mNglI7UydyDWUfXNZZwDxUWBU4T4AqQLJtO2W+s2ZkRZGm
 BUCZ38bMbAYOuSw9TXfvk8ZFSdWD7Any8n31gUls7ux7QEBqo3+0j1nkeHgakXa6KPX4Y9hlElo
 pWjmB1nye6qBCNfQuxterRHntflxqlZoRvMiAecMSSWzP+LSTiy2nA/AIBJ8iktfl2m4eMC0LSE
 aeRod6w=
X-Google-Smtp-Source: AGHT+IG575vTzMyASoOISYjPyi7VfaFwime2AUtrub30U3ncG6O0D5PvBnMwHnz86GMQpUihKD+t+GnEcnJM7Zn7Itk=
X-Received: by 2002:a05:6870:17a0:b0:332:8989:4ef8 with SMTP id
 586e51a60fabf-3c0f6d386c8mr4127622fac.31.1760066746452; Thu, 09 Oct 2025
 20:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250930224037.224833-1-salil.mehta@huawei.com>
 <871pndlgi7.fsf@pond.sub.org>
 <6A8391B8-5E75-49B0-834B-00183BA4CF3E@oracle.com>
 <87bjmgiqbx.fsf@pond.sub.org>
 <FC06F103-13EB-4928-8170-310E0675416B@oracle.com>
In-Reply-To: <FC06F103-13EB-4928-8170-310E0675416B@oracle.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Fri, 10 Oct 2025 03:25:35 +0000
X-Gm-Features: AS18NWBx9gY4c3ULkiZEJ7fBE8Q0kD_hZnmjYTP1k_GgnLCYamswBve8Bo_dGys
Message-ID: <CAJ7pxeYoVbV-3isfcmmzeBQN46Gn=YzarnAhBbTra7wU2VrNyw@mail.gmail.com>
Subject: Re: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like Feature
 for ARMv8+ Arch
To: Miguel Luis <miguel.luis@oracle.com>
Cc: Markus Armbruster <armbru@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org" <maz@kernel.org>, 
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, 
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, 
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>, 
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>, 
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>, 
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>, 
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>, 
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>, 
 "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>, 
 "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>, 
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>, 
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, 
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, 
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, 
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="0000000000003428b10640c579de"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000003428b10640c579de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Miguel,



On Thu, Oct 9, 2025 at 9:18=E2=80=AFAM Miguel Luis <miguel.luis@oracle.com>=
 wrote:

>
>
> > On 9 Oct 2025, at 05:42, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Miguel Luis <miguel.luis@oracle.com> writes:
> >
> >> Hi Markus,
> >>
> >>> On 8 Oct 2025, at 12:33, Markus Armbruster <armbru@redhat.com> wrote:
> >>>
> >>> Salil Mehta <salil.mehta@huawei.com> writes:
> >>>
> >>> [...]
> >>>
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> (VIII) Repositories
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> (*) Latest Qemu RFC V6 (Architecture Specific) patch set:
> >>>>   https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v6
> >>>
> >>> Does not compile for me (x86_64 box running Fedora 41):
> >>>
> >>>   [...]
> >>>
> >>>   FAILED: qemu-system-loongarch64
> >>>   cc -m64 @qemu-system-loongarch64.rsp
> >>>   /usr/bin/ld:
> libsystem.a.p/hw_acpi_generic_event_device.c.o:(.data.rel+0x50): undefine=
d
> reference to `vmstate_cpu_ospm_state'
> >>>   collect2: error: ld returned 1 exit status
> >>>   [6757/7232] Linking target qemu-system-mips64
> >>>   [6758/7232] Generating docs/QEMU manual with a custom command
> >>>   FAILED: docs/docs.stamp
> >>>   /usr/bin/env CONFDIR=3Detc/qemu
> /work/armbru/qemu/bld/pyvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=3D=
1 -j
> auto -Dversion=3D10.1.50 -Drelease=3D -Ddepfile=3Ddocs/docs.d
> -Ddepfile_stamp=3Ddocs/docs.stamp -b html -d
> /work/armbru/qemu/bld/docs/manual.p /work/armbru/qemu/docs
> /work/armbru/qemu/bld/docs/manual
> >>>   /work/armbru/qemu/docs/../include/hw/qdev-core.h:190: warning:
> Function parameter or member 'admin_power_state_supported' not described =
in
> 'DeviceClass'
> >>>   /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum
> value 'DEVICE_ADMIN_POWER_STATE_ENABLED' not described in enum
> 'DeviceAdminPowerState'
> >>>   /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum
> value 'DEVICE_ADMIN_POWER_STATE_DISABLED' not described in enum
> 'DeviceAdminPowerState'
> >>>   /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum
> value 'DEVICE_ADMIN_POWER_STATE_REMOVED' not described in enum
> 'DeviceAdminPowerState'
> >>>   /work/armbru/qemu/docs/../include/hw/qdev-core.h:269: warning: Enum
> value 'DEVICE_ADMIN_POWER_STATE_MAX' not described in enum
> 'DeviceAdminPowerState'
> >>>   1 warnings as Errors
> >>>
> >>>   Warning, treated as error:
> >>>   kernel-doc 'perl /work/armbru/qemu/docs/../scripts/kernel-doc -rst
> -enable-lineno -sphinx-version 7.3.7 -Werror
> /work/armbru/qemu/docs/../include/hw/qdev-core.h' failed with return code=
 1
> >>>   [6759/7232] Linking target qemu-system-i386
> >>>   FAILED: qemu-system-i386
> >>>   cc -m64 @qemu-system-i386.rsp
> >>>   /usr/bin/ld:
> libsystem.a.p/hw_acpi_generic_event_device.c.o:(.data.rel+0x50): undefine=
d
> reference to `vmstate_cpu_ospm_state'
> >>>   collect2: error: ld returned 1 exit status
> >>>
> >>>   [...]
> >>>
> >>>   [6874/7232] Linking target qemu-system-x86_64
> >>>   FAILED: qemu-system-x86_64
> >>>   cc -m64 @qemu-system-x86_64.rsp
> >>>   /usr/bin/ld:
> libsystem.a.p/hw_acpi_generic_event_device.c.o:(.data.rel+0x50): undefine=
d
> reference to `vmstate_cpu_ospm_state'
> >>>   collect2: error: ld returned 1 exit status
> >>>
> >>
> >> I=E2=80=99ve had that same issue although it got compiled for me addin=
g
> ACPI_CPU_OSPM_INTERFACE for MICROVM:
> >>
> >> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> >> index 3a0e2b8ebb..29d9b09486 100644
> >> --- a/hw/i386/Kconfig
> >> +++ b/hw/i386/Kconfig
> >> @@ -133,6 +133,7 @@ config MICROVM
> >>     select VIRTIO_MMIO
> >>     select ACPI_PCI
> >>     select ACPI_HW_REDUCED
> >> +    select ACPI_CPU_OSPM_INTERFACE
> >>     select PCI_EXPRESS_GENERIC_BRIDGE
> >>     select USB_XHCI_SYSBUS
> >>     select I8254
> >>
> >> Miguel
> >
> > Thanks for the hint.  I additionally need a similar change to
> > hw/loongarch/Kconfig, and comment hackery in hw/qdev-core.h.
>
> It seems that every arch selecting ACPI_HW_REDUCED must also select
> ACPI_CPU_OSPM_INTERFACE or it fails building otherwise.
>

Thanks for debugging this.  Something is not right about this dependency.


>
> >
> >>
> >>>   [...]
> >>>
> >>>   ninja: build stopped: cannot make progress due to previous errors.
> >>>   make: *** [Makefile:168: run-ninja] Error 1
> >>>   make: Target 'all' not remade because of errors.
> >>>   make: Leaving directory '/work/armbru/qemu/bld'
> >>>
> >>> [...]
> >>>
> >
>
>

--0000000000003428b10640c579de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">HI Miguel,<div><br></div><div><br></div><=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Oct 9, 2025 at 9:18=E2=80=AFAM Miguel Luis &lt=
;<a href=3D"mailto:miguel.luis@oracle.com">miguel.luis@oracle.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
&gt; On 9 Oct 2025, at 05:42, Markus Armbruster &lt;<a href=3D"mailto:armbr=
u@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; Miguel Luis &lt;<a href=3D"mailto:miguel.luis@oracle.com" target=3D"_b=
lank">miguel.luis@oracle.com</a>&gt; writes:<br>
&gt; <br>
&gt;&gt; Hi Markus,<br>
&gt;&gt; <br>
&gt;&gt;&gt; On 8 Oct 2025, at 12:33, Markus Armbruster &lt;<a href=3D"mail=
to:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br=
>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.com" targ=
et=3D"_blank">salil.mehta@huawei.com</a>&gt; writes:<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; [...]<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<=
br>
&gt;&gt;&gt;&gt; (VIII) Repositories<br>
&gt;&gt;&gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<=
br>
&gt;&gt;&gt;&gt; <br>
&gt;&gt;&gt;&gt; (*) Latest Qemu RFC V6 (Architecture Specific) patch set:<=
br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0<a href=3D"https://github.com/salil-mehta/qemu=
.git" rel=3D"noreferrer" target=3D"_blank">https://github.com/salil-mehta/q=
emu.git</a> virt-cpuhp-armv8/rfc-v6<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Does not compile for me (x86_64 box running Fedora 41):<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;=C2=A0 =C2=A0[...]<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;=C2=A0 =C2=A0FAILED: qemu-system-loongarch64 <br>
&gt;&gt;&gt;=C2=A0 =C2=A0cc -m64 @qemu-system-loongarch64.rsp<br>
&gt;&gt;&gt;=C2=A0 =C2=A0/usr/bin/ld: libsystem.a.p/hw_acpi_generic_event_d=
evice.c.o:(.data.rel+0x50): undefined reference to `vmstate_cpu_ospm_state&=
#39;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0collect2: error: ld returned 1 exit status<br>
&gt;&gt;&gt;=C2=A0 =C2=A0[6757/7232] Linking target qemu-system-mips64<br>
&gt;&gt;&gt;=C2=A0 =C2=A0[6758/7232] Generating docs/QEMU manual with a cus=
tom command<br>
&gt;&gt;&gt;=C2=A0 =C2=A0FAILED: docs/docs.stamp <br>
&gt;&gt;&gt;=C2=A0 =C2=A0/usr/bin/env CONFDIR=3Detc/qemu /work/armbru/qemu/=
bld/pyvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=3D1 -j auto -Dversion=
=3D10.1.50 -Drelease=3D -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs=
.stamp -b html -d /work/armbru/qemu/bld/docs/manual.p /work/armbru/qemu/doc=
s /work/armbru/qemu/bld/docs/manual<br>
&gt;&gt;&gt;=C2=A0 =C2=A0/work/armbru/qemu/docs/../include/hw/qdev-core.h:1=
90: warning: Function parameter or member &#39;admin_power_state_supported&=
#39; not described in &#39;DeviceClass&#39;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0/work/armbru/qemu/docs/../include/hw/qdev-core.h:2=
69: warning: Enum value &#39;DEVICE_ADMIN_POWER_STATE_ENABLED&#39; not desc=
ribed in enum &#39;DeviceAdminPowerState&#39;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0/work/armbru/qemu/docs/../include/hw/qdev-core.h:2=
69: warning: Enum value &#39;DEVICE_ADMIN_POWER_STATE_DISABLED&#39; not des=
cribed in enum &#39;DeviceAdminPowerState&#39;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0/work/armbru/qemu/docs/../include/hw/qdev-core.h:2=
69: warning: Enum value &#39;DEVICE_ADMIN_POWER_STATE_REMOVED&#39; not desc=
ribed in enum &#39;DeviceAdminPowerState&#39;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0/work/armbru/qemu/docs/../include/hw/qdev-core.h:2=
69: warning: Enum value &#39;DEVICE_ADMIN_POWER_STATE_MAX&#39; not describe=
d in enum &#39;DeviceAdminPowerState&#39;<br>
&gt;&gt;&gt;=C2=A0 =C2=A01 warnings as Errors<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;=C2=A0 =C2=A0Warning, treated as error:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0kernel-doc &#39;perl /work/armbru/qemu/docs/../scr=
ipts/kernel-doc -rst -enable-lineno -sphinx-version 7.3.7 -Werror /work/arm=
bru/qemu/docs/../include/hw/qdev-core.h&#39; failed with return code 1<br>
&gt;&gt;&gt;=C2=A0 =C2=A0[6759/7232] Linking target qemu-system-i386<br>
&gt;&gt;&gt;=C2=A0 =C2=A0FAILED: qemu-system-i386 <br>
&gt;&gt;&gt;=C2=A0 =C2=A0cc -m64 @qemu-system-i386.rsp<br>
&gt;&gt;&gt;=C2=A0 =C2=A0/usr/bin/ld: libsystem.a.p/hw_acpi_generic_event_d=
evice.c.o:(.data.rel+0x50): undefined reference to `vmstate_cpu_ospm_state&=
#39;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0collect2: error: ld returned 1 exit status<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;=C2=A0 =C2=A0[...]<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;=C2=A0 =C2=A0[6874/7232] Linking target qemu-system-x86_64<br>
&gt;&gt;&gt;=C2=A0 =C2=A0FAILED: qemu-system-x86_64 <br>
&gt;&gt;&gt;=C2=A0 =C2=A0cc -m64 @qemu-system-x86_64.rsp<br>
&gt;&gt;&gt;=C2=A0 =C2=A0/usr/bin/ld: libsystem.a.p/hw_acpi_generic_event_d=
evice.c.o:(.data.rel+0x50): undefined reference to `vmstate_cpu_ospm_state&=
#39;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0collect2: error: ld returned 1 exit status<br>
&gt;&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; I=E2=80=99ve had that same issue although it got compiled for me a=
dding ACPI_CPU_OSPM_INTERFACE for MICROVM:<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig<br>
&gt;&gt; index 3a0e2b8ebb..29d9b09486 100644<br>
&gt;&gt; --- a/hw/i386/Kconfig<br>
&gt;&gt; +++ b/hw/i386/Kconfig<br>
&gt;&gt; @@ -133,6 +133,7 @@ config MICROVM<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0select VIRTIO_MMIO<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0select ACPI_PCI<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0select ACPI_HW_REDUCED<br>
&gt;&gt; +=C2=A0 =C2=A0 select ACPI_CPU_OSPM_INTERFACE<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0select PCI_EXPRESS_GENERIC_BRIDGE<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0select USB_XHCI_SYSBUS<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0select I8254<br>
&gt;&gt; <br>
&gt;&gt; Miguel<br>
&gt; <br>
&gt; Thanks for the hint.=C2=A0 I additionally need a similar change to<br>
&gt; hw/loongarch/Kconfig, and comment hackery in hw/qdev-core.h.<br>
<br>
It seems that every arch selecting ACPI_HW_REDUCED must also select ACPI_CP=
U_OSPM_INTERFACE or it fails building otherwise.<br></blockquote><div><br><=
/div><div>Thanks for debugging this.=C2=A0 Something is not right about thi=
s dependency.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; <br>
&gt;&gt; <br>
&gt;&gt;&gt;=C2=A0 =C2=A0[...]<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;=C2=A0 =C2=A0ninja: build stopped: cannot make progress due to =
previous errors.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0make: *** [Makefile:168: run-ninja] Error 1<br>
&gt;&gt;&gt;=C2=A0 =C2=A0make: Target &#39;all&#39; not remade because of e=
rrors.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0make: Leaving directory &#39;/work/armbru/qemu/bld=
&#39;<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; [...]<br>
&gt;&gt;&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000003428b10640c579de--

