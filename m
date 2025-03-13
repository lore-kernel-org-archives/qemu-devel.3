Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF0AC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfry-0005e6-3x; Thu, 13 Mar 2025 06:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tsfrZ-0005bu-I3
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tsfrX-000405-Qd
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741861946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fC5UAU8G/UAfG67wKQndUlIVU4N8jjIIbIFQf/7N7rA=;
 b=DgV5ZpKs+zkxNzltZXPcOfTyFL5tvmedggB1hGc2Uu3LRlmRCjIz3dNpckZ1PFgMqP1zh1
 VD65pyfy075Lo0Q8HvkqV9wdHrUbbPvw2RIGLKl87/quAGPJtJ1bBQw5yEJn6RIRKNEuKz
 gIXStEo4mWX3LY1Z4H7e6zKIe98+k/w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-YFcIxz2kOACELxYNiyTH_A-1; Thu, 13 Mar 2025 06:32:24 -0400
X-MC-Unique: YFcIxz2kOACELxYNiyTH_A-1
X-Mimecast-MFC-AGG-ID: YFcIxz2kOACELxYNiyTH_A_1741861943
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac2840b1ee8so85029466b.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741861943; x=1742466743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fC5UAU8G/UAfG67wKQndUlIVU4N8jjIIbIFQf/7N7rA=;
 b=i2o6txsr1jAprUVObpibIZWmL0Kef0W2UHRs5gDLlLr1rOq9UQVyLyU0hSgIiAiEub
 4pS1AxZUGXJTq3zWPsjFHIJrs1ktnrLAei2E1RNSl2513TEhJtUmE63Gei1o6Oxk9AsD
 LAcj8nGPVZix0b8X1sKdSY3RN9hjrHrc2q6CE0m9D1mzqpc71Y1EUy4ZQafTHoJFBZXA
 LUoDBHC0HxdRl/uNQJzJpW4HAUgw2U5NOkpcQR22r1bTC22NsectHcFOT4OtGOoFUDC1
 aTHwL9b7Ylp+aQyyMcLCewvK1hGqZwL4oL9jwVILgJbijx+mMiEdQWNH9Mqn0/kyAddl
 2BuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWELaGD/ST1RnnS6aEwc8Tpmdugir7gUeG0AXDCw7V+/Dsudk3sBbEMNr6AJEVS/wHnFRtM2/okP8mb@nongnu.org
X-Gm-Message-State: AOJu0YwzRsOAqfQdZAA06d/2oKfZPt0Jd6RYSUHp+8I56knCuT1nEv9m
 wA2runn8ZbTF3flt/P/gI/k6nBOFQRXR2B5NJXSmE8A52cnx9duTKOZUo0Yx4LaxJAAAQxiB6Iy
 ptWcHt1Oxl7vbPnRhgc6PoNt1c0qp3b5zDYiRHCIy4SoDJxdXNiQ0yARFBPbUU+gGjETVNCjo8u
 x/by0+GV4ws6e5XCb95GQAvjgyRc4=
X-Gm-Gg: ASbGncvGQXLgVYf5PbLvfMzSJ3KiWzdg0h4pDRzfJ9DAPjmkJ/viMa44vhCvlXqXhQY
 t9q855WUzhzaIT32SUG4yQei8T5poslEUs2ZPBCw2RXTKR57oJ43ZXqU+gWqGe5dsbZKZOUmRNB
 g=
X-Received: by 2002:a17:906:f5a1:b0:ac0:f164:31cc with SMTP id
 a640c23a62f3a-ac25273810dmr3131058466b.8.1741861943211; 
 Thu, 13 Mar 2025 03:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfNgyGI7bvXFOOjZ2nop6MUhQMDF/sdu1G5T4MIXbjoqgRiKHcOERKVJN5FQOfJoF/vgMSXlHUqeheEcZvntk=
X-Received: by 2002:a17:906:f5a1:b0:ac0:f164:31cc with SMTP id
 a640c23a62f3a-ac25273810dmr3131055566b.8.1741861942839; Thu, 13 Mar 2025
 03:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250214153443.159889-1-anisinha@redhat.com>
 <Z9KfMPKr9Tsz-psi@8bytes.org>
 <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
 <Z9Ku-o8zJUWgXoYE@8bytes.org>
In-Reply-To: <Z9Ku-o8zJUWgXoYE@8bytes.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 13 Mar 2025 16:02:11 +0530
X-Gm-Features: AQ5f1Jr7zjqb_lxBO5Qw4pPIt8pTTePqswUpgz8R-yEO5PDrdkwwZzZNH8QRVxw
Message-ID: <CAK3XEhOnhpzSg3F2C+PEvjgPKH7Yc9MqyoL8qJJGcbGXign34A@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Mar 13, 2025 at 3:40=E2=80=AFPM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> Hi Ani,
>
> On Thu, Mar 13, 2025 at 03:07:42PM +0530, Ani Sinha wrote:
> > The state before reset is the state that uses stock firmware from the
> > hyperscaler. The state after reset is a fresh new state that uses the
> > "trusted and known firmware" from the end user. So the launch
> > measurements would not match between the state before reset and the
> > state after reset and there is no guarantee that there would be
> > "predictable launch measurements" across the reset.
>
> Right, I understand that the state before and after reset will have
> different launch measurements, that is expected when booting with a
> different firmware :)
>
> > What we do guarantee is that after reset, the launch measurements that
> > include the "trusted and known firmware" (whatever that is, not
> > necessarily edk2), is understood and expected. If you were to
> > calculate offline the measurements that include this "trusted and
> > known firmware" using the same order of setup calls as the target
> > system and then derive the launch digest, it should match that of what
> > the hardware would produce in the target.
>
> The devil lies in "same order of setup calls". Without a way to define
> this order through the vmfwupdate interface there is a lot of implicit
> knowledge required about how KVM/QEMU setup the TEE context to calculate
> the expected after-reset launch measurement. Even worse, the exact way
> this setup is done then becomes ABI, because any change in this process
> will lead to a different launch measurement.

Forgive my ignorance, today none of the hyperscalers use IGVM to
define this. How then the expected launch measurement is derived?
Our vmfwupdate interface does not make any attempt to define this in
any way or make this an ABI. Its intentionally open ended. It's really
up to the guest to set this up any way they wish. This is the same
when the guest provides the igvm file that defines the above.

>
> Some examples of initial memory layout calls which influence the launch
> measurment:
>
>         1) Launch VMSA(s) (SEV-SNP only, though I believe on TDX the
>            initial register state can also be changed to some
>            degree).
>         2) Pre-Validated/Accepted memory regions (TDX and SEV-SNP). This
>            is especially important, as different FWs have different
>            requirements on what memory is pre-validated, zeroed, etc.
>         3) Zero-pages, measured and unmeasured (TDX and SEV-SNP).
>         4) Position of the CPUID page, secrets page, and id-blob
>            (SEV-SNP).
>         5) Pre-populated data (TDX and SEV-SNP).
>
> If I understand the vmfwupdate interface correctly, and please let me
> know if I am wrong here, it only allows to specify a call for part 5) of
> the above list. Some of the other parts can be specified in architecture
> dependent ways in the FW image itself, but not all of them.
>
> So the question is, is the plan to hardcode everything else (including
> the order of calls) and make the behavior ABI?
>
> Regards,
>
>         Joerg
>


