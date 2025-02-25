Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D48C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 05:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmnNz-0003uY-C4; Tue, 25 Feb 2025 00:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tmnNt-0003tK-6N
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 00:21:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tmnNr-0002dR-1K
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 00:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740460887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v07r7g6NHMZBPDlpdpIP1BMmCqBN0AooG99ChaY9HsM=;
 b=Z+4t/cpSyAcwk2bZCBlqu5cJrACr6NtnCz0W5W6Fo+CiXq7ZXEPNy476SvgfGSpEoIfYAB
 QCFIisQnEq6DSeNFqXnpwR07n6yjNV5Qnp0hWCbEj+hLrmjZLXTDtnLA4s9D/JKmS8MJpV
 sBPwmG+IjafPjWCu73JcITaLrOwqlI0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-9hP1zTmRNqyYc3dnGkNKhg-1; Tue, 25 Feb 2025 00:21:22 -0500
X-MC-Unique: 9hP1zTmRNqyYc3dnGkNKhg-1
X-Mimecast-MFC-AGG-ID: 9hP1zTmRNqyYc3dnGkNKhg_1740460881
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab397fff5a3so542950566b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 21:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740460881; x=1741065681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v07r7g6NHMZBPDlpdpIP1BMmCqBN0AooG99ChaY9HsM=;
 b=MKeDZEuLsSNv3/dVgEdt7Laj91BqtZEIai47ILE6xIsHFP7SmVW2MnN1J7dmIQWN91
 W4qg5ld6Im83PPT34dmANJ/xWJ3qfxnsoubADQRKVqSwrRr/seXmbtIja/o7H75H7QUo
 Lf/RtgeQY/EdHLr9Jxt7TSF6gK8eO0R9dj4EeS9Eo1PEyxmfILJ01vShg3PPd8YH+iAe
 OKg85+3kn5vnbxOTcebbCnYKYkrOVZnwHsDYFQc4v3X1w/r5CgAALErTAtJlbmjCOP1L
 iivAPpxQ5yb6JHSeOjulgY4TvoWLEf1QNuZfTx1qkR6cRUNaKrOHAV1dldq3GOtVSHbz
 hqqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8msYsbL8hgJS3ZuIibOuOsFiTb7dpEJDFmFkEmMZzRF+q729+9/6AhH2Wmm3TlQacyIcMUSyzfd3j@nongnu.org
X-Gm-Message-State: AOJu0Ywbs979a6inP4eGgD4/8quPaRe7sDhFsBP0Og9QHK8aoKEvn3q8
 EnWQk7D6SkZibA/LzE5pp3pub10kMTxDrOM0aBQ9MgIYFSLYFR6Dt05kjDgb8EPNgjork+7YZwU
 hJkVibtFnelYQW1d01TLzvDqiTLH4P5AAe0FiX4OD3d9QkYRwfV/44+pFBj0C5m6b8yDXOmaHyn
 reRHxt7I6A8qL/tGPo12Xoa5Q4Nlg=
X-Gm-Gg: ASbGncs5bddjAiiT+TRaIZ78HDWgDrlA9fFUrfrifkiSGdgzL1YZu+6+F2XsdLud81z
 v0iOlGqX2Vg+q8Ck/kcJD5xmcguXz6FLnJuf38Iy0h4nyAMkkXKkgEbLkBNFfP7sUfPSzo5pYhg
 ==
X-Received: by 2002:a17:906:308c:b0:ab3:9aba:ce7d with SMTP id
 a640c23a62f3a-abc0ae1ab4cmr1252840666b.1.1740460881141; 
 Mon, 24 Feb 2025 21:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqouq1gCtETHpSiwqsPSpyiCGon8khly30Uf7WK+w3KADr0A3NMylSomhlqxu86QvPktPOXggrxW7QE20lJlE=
X-Received: by 2002:a17:906:308c:b0:ab3:9aba:ce7d with SMTP id
 a640c23a62f3a-abc0ae1ab4cmr1252838166b.1.1740460880762; Mon, 24 Feb 2025
 21:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20250214153443.159889-1-anisinha@redhat.com>
 <xhprkjs2yj5yli65opi7md7gfylqxgdkiwap76stcxcx7jdpub@fauqiqm5giyi>
In-Reply-To: <xhprkjs2yj5yli65opi7md7gfylqxgdkiwap76stcxcx7jdpub@fauqiqm5giyi>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 25 Feb 2025 10:51:08 +0530
X-Gm-Features: AWEUYZn6iKT9_O1X6U4AYrJc5O29yTCLtPZvXhQyI3Y8xxGKnc48Y3QEoeeMers
Message-ID: <CAK3XEhMs=Do_3FA+Tyb9u4u+9XELvJUk3-SKAeuxciM-bsvDhQ@mail.gmail.com>
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

On Mon, Feb 24, 2025 at 9:17=E2=80=AFPM Gerd Hoffman <kraxel@redhat.com> wr=
ote:
>
> On Fri, Feb 14, 2025 at 09:04:07PM +0530, Ani Sinha wrote:
> > VM firmware update is a mechanism where the virtual machines can use th=
eir
> > preferred and trusted firmware image in their execution environment wit=
hout
> > having to depend on a untrusted party to provide the firmware bundle. T=
his is
> > particularly useful for confidential virtual machines that are deployed=
 in the
> > cloud where the tenant and the cloud provider are two different entitie=
s. In
> > this scenario, virtual machines can bring their own trusted firmware im=
age
> > bundled as a part of their filesystem (using UKIs for example[1]) and t=
hen use
> > this hypervisor interface to update to their trusted firmware image. Th=
is also
> > allows the guests to have a consistent measurements on the firmware ima=
ge.
>
> Works nicely for me.  Test case:
>   https://kraxel.gitlab.io/uefi-tools-rs/seabios.efi

yeah if I can't get my unit test working we can make this an
integration test. or best case scenario, we can have both.

>
> > +Fw-cfg Files
> > +************
> > +
> > +Guests drive vmfwupdate through special ``fw-cfg`` files that control =
its flow
> > +followed by a standard system reset operation. When vmfwupdate is avai=
lable,
> > +it provides the following ``fw-cfg`` files:
> > +
> > +* ``vmfwupdate/cap`` (``u64``) - Read-only Little Endian encoded bitma=
p of additional
> > +* ``vmfwupdate/bios-size`` (``u64``) - Little Endian encoded size of t=
he BIOS region.
> > +* ``vmfwupdate/opaque`` (``4096 bytes``) - A 4 KiB buffer that survive=
s the BIOS replacement
> > +* ``vmfwupdate/disable`` (``u8``) - Indicates whether the interface is=
 disabled.
> > +* ``vmfwupdate/bios-addr`` (``u64``) - A 64bit Little Endian encoded g=
uest physical address
>
> This is out of sync with the actual code (vmfwupdate/bios-addr does not
> exist there).

The actual implementation detail can vary slightly with the spec no? I
will try to bring them as close as I can.

>
> Also this adds five fw_cfg files.  Given that the number of fw_cfg files
> we can have is limited I'm not convinced this is the best idea to move
> forward.

Right, For implementation, I suggest we combine FILE_VMFWUPDATE_OBLOB
and FILE_VMFWUPDATE_FWBLOB together and also make
FILE_VMFWUPDATE_CONTROL part of the same structure. These are all
writable by the guest so makes sense to have one fwcfg for it. We can
have another read-only fwcfg for FILE_VMFWUPDATE_BIOS_SIZE and
FILE_VMFWUPDATE_CAP.

Alex, what do you think?

>
> Alternatives I see:
>
>  (1) Place everything in a single fw_cfg file.  ramfb does this for
>      example, the guest writes a struct with a bunch of values.
>
>  (2) Go for a mmio register interface.  The EFI variable store I'm
>      working on does this.  fw_cfg is used for hardware discovery,
>      via etc/hardware-info file (which can carry entries for multiple
>      devices).
>
> See https://lore.kernel.org/qemu-devel/20250219071431.50626-2-kraxel@redh=
at.com/
> and https://lore.kernel.org/qemu-devel/20250219071431.50626-21-kraxel@red=
hat.com/
> (v4 has a double-free bug in patch #1 which will be fixed in v5 of the
> series).
>
> take care,
>   Gerd
>


