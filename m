Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614ECC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 09:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvYT9-0003uA-8i; Fri, 21 Mar 2025 05:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tvYT0-0003os-V0
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 05:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tvYSy-00008U-HS
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 05:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742548497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KNRmtc2RHYss3gdg1frxjZjU/sq4Jy5jsy65LL1h7bs=;
 b=F4vnhxkzHl5waGCd9QXVe1VFdW143IpBCHoLsZsO4Wui2jm0PtoUHqbLd+potU+t443/qn
 wZTDNjJRevBlF2nvWQ4SQSdsJ3PZ/Vg19Jxrz1dbgf0VjqyUyQncKcUSomhnOTZakYbukv
 DEGdTv1SQbdGHVh3rL4ZjzVgFUf4rR4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-PzVZAIcsMAirXYzySu7rFA-1; Fri,
 21 Mar 2025 05:14:54 -0400
X-MC-Unique: PzVZAIcsMAirXYzySu7rFA-1
X-Mimecast-MFC-AGG-ID: PzVZAIcsMAirXYzySu7rFA_1742548492
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 861591801A00; Fri, 21 Mar 2025 09:14:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E5621800944; Fri, 21 Mar 2025 09:14:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E937B1800390; Fri, 21 Mar 2025 10:14:42 +0100 (CET)
Date: Fri, 21 Mar 2025 10:14:42 +0100
From: Gerd Hoffman <kraxel@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <m4vcjc4aj6xarjy3ywcatedfegwdyqagsbesgacraiohx4aiqu@jppnme7rjpyo>
References: <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <6684f169-29d6-4f46-b274-1efd4c191b21@amazon.com>
 <ok6u7exmwmh7qsahp5o3udnbbzbsr2km22kpqod37t6mdsywcs@yhk2whhakl63>
 <fucfv6gf22t3sclhad4iwbmxi5tdg6a5dlhvl4kl4bzhnjkktu@dtn2eqh27k32>
 <c7f840d5-19ed-493e-8de8-7d64aef38948@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7f840d5-19ed-493e-8de8-7d64aef38948@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

  Hi,
 
> I think if we want to embrace IGVM, we should embrace it fully and make it
> replace the region list. At the end of the day, IGVM is effectively a region
> list plus data.
> 
> How difficult would it be to put up a prototype that uses only IGVM as
> vmfwupdate payload? We can definitely assemble that IGVM in ukify.py or as
> part of the boot stub. Or for the prototype even pre-assemble by hand.

Played around with igvm yesterday (no vmfwupdate yet), with traditional
firmware wrapped into an igvm.

igvm support in qemu needs a fix for that to work properly.
https://github.com/coconut-svsm/qemu/pull/18

Launching a VM using igvm works.  seabios+ovmf images created using this:
https://gitlab.com/kraxel/virt-firmware-rs/-/blob/main/efi-tools/src/bin/igvm-wrap.rs

There are some noteworthy differences between igvm and non-igvm mode
though:

 * When launching without igvm qemu goes create the pc bios rom memory
   region, and the alias to map the top 128k of that below 1G ('pc.bios'
   and 'isa-bios' in 'info mtree').

 * When launching with igvm qemu doesn't do that (at least with the
   current, not-yet upstream patches).  One can compensate for that by
   creating two regions in the igvm (below 4G and below 1M).  There are
   still some small differences, the memory regions are ram not rom,
   also the chipset emulation for rom shadowing has no effect.

take care,
  Gerd


