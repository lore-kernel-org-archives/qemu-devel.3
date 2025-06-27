Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E21C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7JD-0007gm-4u; Fri, 27 Jun 2025 07:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uV7J8-0007g9-92
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uV7J6-0000Vd-A5
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751023906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9pBYBdBNg06ftIGb3ioYeXiuHpqvO6JFuJvq88+4+M=;
 b=as0LlD7G7q+g6HwJtC9eW3kw7vRQRr7N1jYi5V6+2cPEN5rP91/cK2P4BsmvLmhTC6x6KU
 aVIRbmUaw/7PsiR46NYIQbVJ2ikMrB4DONCZ34ZmbrESTy95JP+UDzhReEZXzQ6iRa4vXl
 st0AEq/OGPpfAD9GEkndWjbADFYU1bo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-AOk8gCIgMfWJXcZe9Hpl7Q-1; Fri, 27 Jun 2025 07:31:44 -0400
X-MC-Unique: AOk8gCIgMfWJXcZe9Hpl7Q-1
X-Mimecast-MFC-AGG-ID: AOk8gCIgMfWJXcZe9Hpl7Q_1751023903
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso1039258f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023903; x=1751628703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9pBYBdBNg06ftIGb3ioYeXiuHpqvO6JFuJvq88+4+M=;
 b=Ek9GjuPUzlNPETErMcAudElKRz7d+FzGV0D83droy31hDaJjLwIMS/+fiX7o6xPl+x
 h4tbQ3yE0wSoJqCYEPx5VO4Bxtjku9wpZQxPq3aARt2dSyZhazJ4yJpye0AoL9ck2Yxh
 pExmftZA+cFeAH4RZnuzNivCosM4jkqEUiFG0Mi/t/ISfLWUsShV1zJBH4THFBrfnLgm
 FS015QubwBpcNBDY0TNT4PzWVhh7LGEpnHJZYAehaAKRT+G8V2W+AZfpQ5eAngeRM/u/
 /siscKNpsiqlNFNt4xDWiiSFCzs9tptFs2C/XYHOvedLFqITzFIVIDj/i811uZz5Suu+
 LYHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7o4RmeL7rioenNaOVg8TIF2RFGPdFufAXLVHCaSHYmNkTDe8WhC+0LKoxo9oE2IhEUV4+MZ+eE5wW@nongnu.org
X-Gm-Message-State: AOJu0YymFyNzAssacd689IDh/OLXLNqTJtCtYFfH+bnrWJUPpCi4jsK/
 k+9oi2Dr3mXY1SDVjihD1fSBnLnlWQzNjL+yPA9SiOT+/OslynbAW9vc5Dg4yTaTuS8swPoboF1
 8NHOLyNd+eu2x0fFANZOOAXvWFSwERjGUZoERe0ppQLZ+o5y5B3wWJzr+
X-Gm-Gg: ASbGnct/hdslizbzfuyp+7W1oylqDqtgK9eyI2RFgoItw1+ELwKVDJK4/PyfrjrcFeJ
 o9bQdfDXuwVzX38//JNbJ10jC1ZjFrRoSRARSsEaHy+z6eNyam2AGz1TJpoZGu2Z+6mCG0z2EFr
 CmmHvNL5sMQtW6fiPLoQwryUf9Mnc4k5gb4T8Ue8SNaqQOjwxcXQ3CnasNLdoH7IMmLE485MKpD
 WDUvqIIZqlZyVpISWnxlyYOElFM2DRpGmT9Eu80yWJVWaWbxjsi1SU7uRmbWWohd5fISfIxw9Ma
 ih7eWUK7OqFm
X-Received: by 2002:adf:9c89:0:b0:3a5:300d:ead0 with SMTP id
 ffacd0b85a97d-3a8fe5b1b0cmr2459342f8f.43.1751023902757; 
 Fri, 27 Jun 2025 04:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEO1tCvr8o6PlFZH7eKI7ueod3akAgKhCNj+aafP1Mq09DvC0dQnroZnCDNMlzNF/rIZa4tQ==
X-Received: by 2002:adf:9c89:0:b0:3a5:300d:ead0 with SMTP id
 ffacd0b85a97d-3a8fe5b1b0cmr2459302f8f.43.1751023902255; 
 Fri, 27 Jun 2025 04:31:42 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c1easm77368155e9.3.2025.06.27.04.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:31:41 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:31:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf
 <kwolf@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>, Jason Wang
 <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>, John Snow
 <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
Message-ID: <20250627133139.25e78d64@fedora>
In-Reply-To: <aEFiUp9xD-UIhuGq@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-5-philmd@linaro.org>
 <ccf78c07-fc08-493f-85d8-5058cccbe82e@intel.com>
 <aDad5elq0bgZ/tvp@intel.com>
 <20250603170238.75a0f1de@imammedo.users.ipa.redhat.com>
 <aEFiUp9xD-UIhuGq@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 5 Jun 2025 10:24:34 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, Jun 03, 2025 at 05:02:38PM +0200, Igor Mammedov wrote:
> > On Wed, 28 May 2025 13:23:49 +0800
> > Zhao Liu <zhao1.liu@intel.com> wrote:
> >  =20
> > > On Wed, May 28, 2025 at 10:09:56AM +0800, Xiaoyao Li wrote: =20
> > > > Date: Wed, 28 May 2025 10:09:56 +0800
> > > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check=
_cpuid
> > > >  field
> > > >=20
> > > > On 5/12/2025 4:39 PM, Philippe Mathieu-Daud=C3=A9 wrote:   =20
> > > > > The X86CPU::check_cpuid boolean was only set in the
> > > > > pc_compat_2_4[] array, via the 'check=3Doff' property.
> > > > > We removed all machines using that array, lets remove
> > > > > that CPU property and simplify x86_cpu_realizefn().   =20
> > > >=20
> > > > No.
> > > >=20
> > > > We cannot do this. Because it changes the behavior of QEMU.
> > > >=20
> > > > 'check_cpuid' is true by default while 'enforce_cpuid' is false. So=
 that
> > > > QEMU emits warnings in x86_cpu_filter_features() by default when us=
er
> > > > requests unsupported CPU features. If remove "check" property and t=
he
> > > > internal 'check_cpuid', QEMU will not do it unless user sets enforc=
e_cpuid
> > > > explicitly.   =20
> > >=20
> > > One option would be to have x86_cpu_filter_features() unconditionally
> > > turn on verbose and print warnings, but some people might want to turn
> > > off these warning prints, I don't know if anyone would, but it would =
be
> > > possible.
> > >=20
> > > The other option is still to keep the =E2=80=9Ccheck=E2=80=9D propert=
y.
> > >=20
> > > IMO, the latter option is the better way to reduce Philippe's burden.=
 =20
> >=20
> > we essentially loose warnings by default when some features aren't avai=
lable,
> > qemu still continues to run though.
> >=20
> > Given that Daniel acked it from libvirt side, libvirt doesn't care abou=
t warnings
> > (it does its has its own cpu model calculation). Likely other mgmt do n=
ot care
> > about it either, and if they do they probably doing something wrong and
> > should use QMP to get that data. =20
>=20
> Acking it was a mistake on my part - I mis-interpreted the patch and so
> didn't notice we were loosing the verbose printing of missing features
> by default.
>=20
> I'm actually curious why we made the 'check' feature tied to machine
> types at all. If it doesn't affect guest ABI, just causes verbose
> info on stderr, it feels like something we could have just had on
> all machine types new & old. Git history brings us back to
>=20
>   commit 3e68482224129c3ddc061af7c9d438b882ecfdd1
>   Author: Eduardo Habkost <ehabkost@redhat.com>
>   Date:   Tue Nov 3 17:18:50 2015 -0200
>=20
>     target-i386: Set "check=3Doff" by default on pc-*-2.4 and older
>    =20
>     The default CPU model (qemu64) have some issues today: it enables some
>     features (ABM and SSE4a) that are not present in many host CPUs. That
>     means many hosts (but not all of them) had those features silently
>     disabled in the default configuration in QEMU 2.4 and older.
>    =20
>     With the new "check=3Don" default, this causes warnings to be printed=
 in
>     the default configuration, because of the lack of SSE4A on all Intel
>     hosts, and the lack of ABM on Sandy Bridge and older hosts:
>    =20
>       $ qemu-system-x86_64 -machine pc,accel=3Dkvm
>       warning: host doesn't support requested feature: CPUID.80000001H:EC=
X.abm [bit 5]
>       warning: host doesn't support requested feature: CPUID.80000001H:EC=
X.sse4a [bit 6]
>    =20
>     Those issues will be fixed in pc-*-2.5 and newer. But as we can't cha=
nge
>     the guest ABI in pc-*-2.4, disable "check" mode by default in pc-*-2.4
>     and older so we don't print spurious warnings.
>=20
> IOW, we wanted to have 'check' unconditionally on by default, but
> had to do a temp hack to avoid spamming all configurations with
> the broken 'qemu64' CPU model design.
>=20
> > That leaves us with human users, for that case I'd say one should use
> > enforce_cpuid if feature availability matters. =20
>=20
> IMHO even with mgmt apps, it is worth having 'check=3Don' by default
> as the log message has value in debugging scenarios. It could have
> the potential to highlight situations where an mgmt app has
> unwittingly done something wrong with CPU config. At the very least
> though its a warning to humans debugging that they should not trust
> the QEMU command line as a expressing the full CPU featureset.

in that line of thought, maybe hardcode 'check=3Don' and drop conditional/p=
roperty?

>=20
> With regards,
> Daniel


