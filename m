Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6563C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsf0w-0006jB-A0; Thu, 13 Mar 2025 05:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tsf0t-0006ie-SF
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tsf0r-0004ji-RZ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741858678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJZ7jwQeCTBVB9Mm2A4YyFue5MUOMew/8DAczACINl8=;
 b=T2NDDgZ4MwidM3gwMiJ35/7PKUGADVIOZPNZEnXf+Dl0rBqgKcPbQMOgcKgMpyehU1xGPC
 KNuL6EwjjFuawXcow+/21PsrybNsb5Fq95qGuJjLLCoURvOlLbWmgGYanEqIZU+2srfqnM
 TDRLHBLhsJrNnA2Bib5S7epK0zllaz4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-fl01JTlWNDGiO0K9R5gfPA-1; Thu, 13 Mar 2025 05:37:57 -0400
X-MC-Unique: fl01JTlWNDGiO0K9R5gfPA-1
X-Mimecast-MFC-AGG-ID: fl01JTlWNDGiO0K9R5gfPA_1741858676
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac27d8ac365so65454566b.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 02:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741858676; x=1742463476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJZ7jwQeCTBVB9Mm2A4YyFue5MUOMew/8DAczACINl8=;
 b=P9xE0kL5YHopIBulWrT3lbTygooRPFnUTOTlLnFy/v+R8Jw5FUWAa2ikZKao7woy7y
 lpZ0gCrSDQkTB0uoac1nxRmxSvo+AGt3YV7uusL2RSO2Lai4XZ8SI0IPcFGYDCUVJ3a9
 uoxyJV3/wiPzexRkVyfvRsXGS7YBee2o1sfp9pty7y2rYGV2cpN3B+pMAJ1S1sSbovdf
 C0BpOtTQx1GcEDlG1X4feFC9XxoyWpE6TQKUd67Xu82srDbO5MS+Nz0iOlV0wfWJ7qH+
 iPpgzkYUSuFUVfZLYodmBLO8pIDyz960Hh9MTFlrm4VAWaqKn+Nj4RctWaJPC7FZ/40g
 PuoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE13sXmXEavXfHDR674NVoZ1FhbxgTanbd1CRAw3r/XQBz7iL8qzkckBZZggCORAYmj3HHQORZ2dCc@nongnu.org
X-Gm-Message-State: AOJu0Yw9Osiovbsvj9E2V7Soh6DcAODAiSpqknxXVG/9nmGzus5aU0z/
 HS/yoXut0nY8KA0OzFTeHF7/jcTizFssmeiKS6SH5/tWA5n0YKQyN51JoSnaIm5ZqQ4XYAQXq9Z
 EZ/rTJMOP1WlQHT1+CaItFh9ZWycKsC7XmnFIZOHfCmSmtSHKkCqIvat+y8xi5nHgD5H3UpIRft
 x1lgPGMsCtHlOUzdrwNgfliXKfU3U=
X-Gm-Gg: ASbGncsPRHIoES0sg0eROKSeOEIOHPa+gwtI0jCF98sVAgp+dlW2LMR0xl7ZqqsIMNG
 d+jX80B4v/FIC52Ze+RHXggwaQ3RYKq5Bs9Mkfcvl1duchWcFwajrOuU7fj6KXr66m1POCBvHtJ
 k=
X-Received: by 2002:a17:906:b6d0:b0:ac2:cea7:6c6c with SMTP id
 a640c23a62f3a-ac2cea7743fmr934407966b.57.1741858676030; 
 Thu, 13 Mar 2025 02:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHba6fULUUMCxGvgPfcFdBHA6ZMZn1PQ+oX3QWkEkQsN16zttduruyEZohlD6gsR0V0pasaIkCXLce20J0HTs=
X-Received: by 2002:a17:906:b6d0:b0:ac2:cea7:6c6c with SMTP id
 a640c23a62f3a-ac2cea7743fmr934401766b.57.1741858675111; Thu, 13 Mar 2025
 02:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250214153443.159889-1-anisinha@redhat.com>
 <Z9KfMPKr9Tsz-psi@8bytes.org>
In-Reply-To: <Z9KfMPKr9Tsz-psi@8bytes.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 13 Mar 2025 15:07:42 +0530
X-Gm-Features: AQ5f1JrDxwIiqtWLAG47HA8qvRkwjFojoB-MCL4JblGg5UsEODNAdozTkXjwFwU
Message-ID: <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 13, 2025 at 2:40=E2=80=AFPM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> Hi Ani,
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
> We discussed the implications of the vmfwupdate mechanism as currently
> proposed in yesterdays SVSM Development Call[1]. The reason this came to =
my
> attention was a request to support a non-IGVM boot protocol in
> COCONUT-SVSM, so I started to look into the vmfwupdate.
>
> I do not claim to have a full picture yet, but what I'd like to better
> understand is how the proposed update mechanism plans to guarantee
> predictable launch measurements for confidential VMs, especially since
> the measurements depend on the exact order of setup calls for the TEE
> and data the vmfwupdate mechanism can currently not pass on to the
> state-after-reset. Can you please share some details on that?

The state before reset is the state that uses stock firmware from the
hyperscaler. The state after reset is a fresh new state that uses the
"trusted and known firmware" from the end user. So the launch
measurements would not match between the state before reset and the
state after reset and there is no guarantee that there would be
"predictable launch measurements" across the reset.
What we do guarantee is that after reset, the launch measurements that
include the "trusted and known firmware" (whatever that is, not
necessarily edk2), is understood and expected. If you were to
calculate offline the measurements that include this "trusted and
known firmware" using the same order of setup calls as the target
system and then derive the launch digest, it should match that of what
the hardware would produce in the target.
I hope I understood your question correctly. Otherwise Alex can
perhaps explain better.


>
> Regards,
>
>         Joerg
>
> [1] https://github.com/joergroedel/svsm-governance/blob/main/Meetings/dev=
el-call-2025-03-12.md
>


