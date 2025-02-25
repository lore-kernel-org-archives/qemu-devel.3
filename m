Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F9CC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 09:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmrdz-0000MR-7q; Tue, 25 Feb 2025 04:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tmrdx-0000M9-NT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:54:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tmrds-0006uG-LS
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740477258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CnndPjAaiAZFF4YhSUuLBS1QitPd0p4DCMjO7h/WNw=;
 b=fOXo+QKgXI/5qtIVv1k432U5Wvk8ZG5+MUpl1+DqUc9irpkn8xFXTs2ZXElvQjubrXe2Vr
 W7+ZXEmGf4X3olwrDKK+zjrkeeKmGJY1melGlHxntaj8hU+PfBxUkb66rcOTrXYMfDPbP9
 2Okzxef+vJPUuyMISZXhcgzEUFhuQOM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-zdV0137rO2CxS7yafOiMew-1; Tue, 25 Feb 2025 04:54:15 -0500
X-MC-Unique: zdV0137rO2CxS7yafOiMew-1
X-Mimecast-MFC-AGG-ID: zdV0137rO2CxS7yafOiMew_1740477254
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abbaa560224so520391166b.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 01:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740477254; x=1741082054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CnndPjAaiAZFF4YhSUuLBS1QitPd0p4DCMjO7h/WNw=;
 b=mP3yVvHUkFk6GxiP6VHdq+NRh/mCALPtVXQrE516vS9M8hy+myuUBSxzkFYhrcIQdj
 C/Gh3LeubF9KTgBMFQ1n9u7SG9hOaK3lIUiiiCfuIq22QRWaWpVXTHmny3ujtHzd05b5
 uhvD96KSBYc7yoFSt+Ob2dV/mSyE+WFLQQI/DCkVl6tiHMkZfiNN6who9oq6Up7rzGOO
 YMaVUJe+TV6oP3jXDOl8D2tJ1X4N7PWIk6Q2xix4REDz/c5gDL+4x5EcWXVaji32+bOJ
 S+XpU3WlkYnJ03i6SeEYVPmGdDIKx6xW/EFz85yF314gBlLWNVyunn4/2gKSCItWK8P9
 gsfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNiA6Lui5nAV/rSMCtGzOz9jmJAk7AD3PFZ2rP/0hzvjcJA932d1G2gW2PgVIVHl+UhKrkc/foJi3m@nongnu.org
X-Gm-Message-State: AOJu0Yxvh8fBWgygTDqhxiooqJh8BUX2E3k1wV4OWcgn89U0/YfS8B1l
 IQns7PGwJUfe4I0bz0RiO/pzZr1Len4dbd1o/Il+KgY8nEVVFBgLkNGgLF7ksDgexnNpb7DPNrc
 +n4W6TRIjaBZ6kPYyGpq4KGQ21hnZLi80LL8BcngcO93/2r+LLS/5YoEqp4WcE0k+AY8OGFlX50
 yaDBh44C4qMcQ5hLyvUQPs+Sb04KI=
X-Gm-Gg: ASbGncvftw/hQhEsGaPoWeLIMC+Zhxmy3OsgeiAGdxgWAHcBeWGGP10gqdGhKA1OppK
 CABQe/8x2W76uqRgyS9joGsgF0DS0XAX+1IKEQlynMzt2K8c+3gjcXRd+7ngx6vLtFy2g66ihNw
 ==
X-Received: by 2002:a17:906:31cf:b0:ab6:ef33:402 with SMTP id
 a640c23a62f3a-abc0d9e4ef5mr1510870466b.18.1740477253827; 
 Tue, 25 Feb 2025 01:54:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK2s6X/Y4+S7Ee3G8Mt9fE3xPjyjQYRVpGJsxK5EUMdjOeTeyeCmqazyNyM5XTxW2Wtw6/o5Y/8zYEQ+diPyA=
X-Received: by 2002:a17:906:31cf:b0:ab6:ef33:402 with SMTP id
 a640c23a62f3a-abc0d9e4ef5mr1510868266b.18.1740477253409; Tue, 25 Feb 2025
 01:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20250214153443.159889-1-anisinha@redhat.com>
 <xhprkjs2yj5yli65opi7md7gfylqxgdkiwap76stcxcx7jdpub@fauqiqm5giyi>
 <CAK3XEhMs=Do_3FA+Tyb9u4u+9XELvJUk3-SKAeuxciM-bsvDhQ@mail.gmail.com>
 <6t76cizlvnhufhg7j6v5dpyjj3k6ba4urd3r7563d3g3e6wnsf@7aenaqnc5d5a>
In-Reply-To: <6t76cizlvnhufhg7j6v5dpyjj3k6ba4urd3r7563d3g3e6wnsf@7aenaqnc5d5a>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 25 Feb 2025 15:24:01 +0530
X-Gm-Features: AWEUYZnj8QXurhycJhvOZJWCZmvJFpRdDKHGRED4Gct2WeukVltb7nmEYMn9smI
Message-ID: <CAK3XEhM40mD1_ucpB1-oWEMLucFLVyt6OpoQ+F2PShiUEgsnOA@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Gerd Hoffman <kraxel@redhat.com>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 25, 2025 at 2:09=E2=80=AFPM Gerd Hoffman <kraxel@redhat.com> wr=
ote:
>
> On Tue, Feb 25, 2025 at 10:51:08AM +0530, Ani Sinha wrote:
> > On Mon, Feb 24, 2025 at 9:17=E2=80=AFPM Gerd Hoffman <kraxel@redhat.com=
> wrote:
> > >
> > > Works nicely for me.  Test case:
> > >   https://kraxel.gitlab.io/uefi-tools-rs/seabios.efi
> >
> > yeah if I can't get my unit test working we can make this an
> > integration test. or best case scenario, we can have both.
>
> Do you have a branch with your unit test somewhere?
>
> > > Also this adds five fw_cfg files.  Given that the number of fw_cfg fi=
les
> > > we can have is limited I'm not convinced this is the best idea to mov=
e
> > > forward.
> >
> > Right, For implementation, I suggest we combine FILE_VMFWUPDATE_OBLOB
> > and FILE_VMFWUPDATE_FWBLOB together and also make
> > FILE_VMFWUPDATE_CONTROL part of the same structure. These are all
> > writable by the guest so makes sense to have one fwcfg for it. We can
> > have another read-only fwcfg for FILE_VMFWUPDATE_BIOS_SIZE and
> > FILE_VMFWUPDATE_CAP.
>
> I'd prefer to put everything into one file.  Maybe except the opaque
> blob page.  A struct along the lines of:
>
> struct vmfwupdate {
>     u64 capabilities;   // 'cap' file
>     u64 firmware_size;  // 'bios-size' file
>     u64 control;        // disable bit etc.
>     u64 update_paddr;   // 'fw-blob' file, paddr field
>     u64 update_size;    // 'fw-blob' file, size field
> }
>
> On the host side you'll need two copies of the struct then: one where
> the guest can read from and write to, and one shadow struct where the
> actual values are stored.  The write callback goes sanity-check the
> guest-written data, takes everything which passes into the shadow
> struct, finally goes copy back the shadow struct to the guest struct
> so the guest can see what the host has accepted.
>
> Part of the verification process can be that you already copy the
> firmware to a host buffer.

I think we decided early on that we would not want to do that - that
is consume extra memory on the host side for boot components.
right alex?

Best using dma_* functions, these return
> errors in case something went wrong (say the paddr passed is not backed
> by guest ram).  Which gives you the chance to propagate those errors
> back to the guest before it'll actually try to launch the updated
> firmware via reset.
>
> take care,
>   Gerd
>


