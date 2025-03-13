Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F966C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslSm-0007X7-K4; Thu, 13 Mar 2025 12:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=160d0ab05=graf@amazon.de>)
 id 1tslSJ-0007V0-T0
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:30:55 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=160d0ab05=graf@amazon.de>)
 id 1tslSH-0004KT-Hm
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1741883445; x=1773419445;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dsWTnJKEZ1UVc7KuZ4D4sxtpgvYPEwFJaPGL4XmB+II=;
 b=A2wIcrSA5e5rU/YV3cZNa050FOsZQFbybD94ZGK/h5NHWHho81mdNPfd
 o4Jun3phsnfS3RIu52zunn8xhpPUe7rtOyq2Os+rQw3C7794VNvuMt91y
 ahyzPz0kq9QY9wPsGNyTHEItiXJR3vNHpRAHRx8gUqp9EY44rUM8BIvhe g=;
X-IronPort-AV: E=Sophos;i="6.14,245,1736812800"; d="scan'208";a="480168451"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 16:30:39 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:42654]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.151:2525]
 with esmtp (Farcaster)
 id f8a8e13c-5e53-417c-ac0c-733b86c96269; Thu, 13 Mar 2025 16:30:38 +0000 (UTC)
X-Farcaster-Flow-ID: f8a8e13c-5e53-417c-ac0c-733b86c96269
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 16:30:37 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Thu, 13 Mar 2025
 16:30:33 +0000
Message-ID: <b91881ee-69cb-46dc-82ff-b9781f480096@amazon.com>
Date: Thu, 13 Mar 2025 17:30:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Ani Sinha
 <anisinha@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, "Gerd
 Hoffman" <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Vitaly
 Kuznetsov" <vkuznets@redhat.com>, <qemu-devel@nongnu.org>
References: <20250214153443.159889-1-anisinha@redhat.com>
 <Z9KfMPKr9Tsz-psi@8bytes.org>
 <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
 <Z9Ku-o8zJUWgXoYE@8bytes.org>
 <CAK3XEhOnhpzSg3F2C+PEvjgPKH7Yc9MqyoL8qJJGcbGXign34A@mail.gmail.com>
 <Z9K6nrGwnyob9tED@8bytes.org>
 <CAK3XEhNDnX1+W9jZ_MZaSYKHBwS-dCUbjhPVav7Q1OxaAzJ73Q@mail.gmail.com>
 <Z9LBD_FnO2Gi2vMK@8bytes.org>
 <CAK3XEhMa3Bvy42ErqAhf9vE+oUH1ZkHhv8JZRv1BpyfdejYMYQ@mail.gmail.com>
 <Z9L8SYW8ObyoDMLy@8bytes.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <Z9L8SYW8ObyoDMLy@8bytes.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.95.49.90;
 envelope-from=prvs=160d0ab05=graf@amazon.de; helo=smtp-fw-6002.amazon.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi Jörg,

On 13.03.25 16:39, Jörg Rödel wrote:
> On Thu, Mar 13, 2025 at 08:23:44PM +0530, Ani Sinha wrote:
>> Note that even with this approach where the hypervisor *thinks* it's
>> dealing with a real firmware, you can imagine a small rust based
>> firmware image that is loaded by the guest in the firmware region.
>> This tiny firmware then jumps to a well known address (chosen by the
>> guest) where IGVM is loaded and then starts executing the IGVM
>> instructions.
> Yes, but this way the predictable launch measurement property of IGVM
> is lost, as the measurement only contains hashes for the actions
> which happened before the VM was finalized and launched by the VMM. The
> SEV policy can also not be changed anymore when the guest is running.
>
> Anyway, I think it doesn't matter much whether the IGVM is parsed in
> guest context or by QEMU, as long as the resulting measurement is the
> same as if the file was loaded at initial VM launch.
>
> Given that QEMU will hopefully get IGVM backend support soon, there is
> some value and saved effort in just passing the IGVM data to the VMM via
> the vmfwupdate interface and let QEMU do the rest.


I have a few concerns with IGVM:

1) Parsing is non-trivial. Parsing them in QEMU may open security issues.
2) Their data structures are tied to the target CPU structures like VMSA 
which FWIW are not fully owned by QEMU, are they?
3) I don't want to allocate a bounce buffer for an IGVM in the 
hypervisor. So we would need to ensure that the memory allocated by the 
loader for the IGVM does not overlap any memory the IGVM wants to 
consume. If the loader considers the IGVM as opaque, that is difficult 
to achieve.


Alex


