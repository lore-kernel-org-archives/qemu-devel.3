Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A6EC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKhs-0007ql-L8; Sat, 15 Mar 2025 02:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1ttKhr-0007qb-Dr
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 02:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1ttKhp-00027B-9i
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 02:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742018946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58WnGVzNfvl7rhxPJmCWerojBGye0IKaLgzTOxHLN0g=;
 b=fWLV7XGKjcld3a1DEAZDilpjb+umT3LVf3aJ1G6Fgt38ktLw2vSTYh2xz2UC/A94bV5HER
 vfRTCxqOsHtA6SreUb45L6OQ3yGiuQXKUEK9qOCpP2raZ4jMJgBoOCqONp9813XlBE/zdj
 iSjO8IgIhvjcoDBGHWB5bmWhGTCMWMk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-ud11UAlqPyeHVhhPNTXwXA-1; Sat, 15 Mar 2025 02:09:04 -0400
X-MC-Unique: ud11UAlqPyeHVhhPNTXwXA-1
X-Mimecast-MFC-AGG-ID: ud11UAlqPyeHVhhPNTXwXA_1742018943
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac316d639d2so231463466b.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 23:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742018943; x=1742623743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=58WnGVzNfvl7rhxPJmCWerojBGye0IKaLgzTOxHLN0g=;
 b=pyke7iWKfzfIvQ378lr/r8bq5qbI0uF81o15ZytT9U/CT3JY0G9zbgzhO7lXBOdwu6
 j2cr7CXN14EemYmLXwANGZt4l3Y/qEwgMNkj1/diq9uur+tbJ7kbFmEygg1BEPD+yXLt
 37YUkifN/Fj1XJ6fyIGTyyYORWpfvia555Xkzdf6L0lXywVMGSJdg1ZQYcXGCyNNbkQg
 IiunOfFWR71QL58kSevHvZnHFZaqKGdpPQYIOmqKomvASSwD+OZtaGFW6HpoMkqv7yqC
 it6T66WfnboUgdkzVmKPpfS0JpTY4VVeQudF3xk9krYyFZF+7ci5LFY8Grf42MIRZ1OQ
 rOsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWxWWcwsMqk54Gvltq7c28Ixu+WKWtl1OTBWmmf4UqQL3Glnnv2fwYT050b9ztGZ0FJCgC2UTUuJbj@nongnu.org
X-Gm-Message-State: AOJu0Yw5eE5UVAisEq4+iqfavktVAdIK22F/uCE3u0yN5tmqVzlFVuV/
 y8aSgtDhdWUldvVXFnXlVOlVA7DlofhwPpbqEsUoHSMv31J9wwME4XS9wSJeIfsczYRKTG6gE0j
 w4O2VkkN5ZvEJb4mleCefNdd4b5B7EjOUzpIrefn9ktyJv9EhhKk6CUMt8/jUUo1cTAWrj7stV9
 9D/5JQRhkVJ+/qjS3YNj8+dX3YTiw=
X-Gm-Gg: ASbGncsmmWuBzP/Hz8Q6aS9fVE2oNpoV9xz+5G9YrhJmmb7z+w9XnONkz1f4sdDZJ2b
 FC5ddgUYpVRq1u88vNIIQp6H1tsQafXBF2VJBEO7GjQnFr0KlTwjkZPN3wh+/nIWZQ7FSAlQW
X-Received: by 2002:a17:907:9687:b0:ac2:b086:88d5 with SMTP id
 a640c23a62f3a-ac3301d26a2mr549496866b.18.1742018943303; 
 Fri, 14 Mar 2025 23:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKSClLNw35zzaS68iuUtVIlfSBKwtHltn4zMG+5CdrLvxd3eB2spXDrCnTr5MEMM+M1GHfPBYZz5A7kETVagQ=
X-Received: by 2002:a17:907:9687:b0:ac2:b086:88d5 with SMTP id
 a640c23a62f3a-ac3301d26a2mr549495866b.18.1742018943010; Fri, 14 Mar 2025
 23:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <Z9RIaPTxn7tTX9c9@8bytes.org>
In-Reply-To: <Z9RIaPTxn7tTX9c9@8bytes.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 15 Mar 2025 11:38:51 +0530
X-Gm-Features: AQ5f1JpLSa0kh11zrqcUgFWt0i18Zwcjt36KN7w-KA6ebjwQltXy_U6TSeE1moQ
Message-ID: <CAK3XEhPt22mcXEvXdy8C0Wa5kdg2g8RUSmMN6Av7haw3FkqZ7Q@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Gerd Hoffman <kraxel@redhat.com>, Alexander Graf <graf@amazon.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
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

On Fri, Mar 14, 2025 at 8:47=E2=80=AFPM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> On Fri, Mar 14, 2025 at 03:08:43PM +0100, Gerd Hoffman wrote:
> > If your input firmware image already is an IGVM (say coconut), what is
> > supposed to happen?
>
> The COCONUT igvmbuilder has the ability to take another IGVM file as
> input and add its directive and contents to the output file. This is
> needed for the Hyper-V firmware, which is also provided as an IGVM file.
> I think it can also make changes when processing an input IGVM, like
> changing the VMPL of a VMSA.
>
> This can be extended to cover more use-cases, e.g. like direct-boot of a
> linux kernel with initrd and command-line.

Have we considered how IGVM will be deployed in the FUKI case? I have
always assumed that UKI would be the right means for this. For edk2
for example, we are implementing support in UKI. Hopefully the same
can apply for IGVM.


