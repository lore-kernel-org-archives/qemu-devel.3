Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20D4C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 14:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt6Mw-0005vb-9A; Fri, 14 Mar 2025 10:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=161315f38=graf@amazon.de>)
 id 1tt6Mr-0005jA-EN
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:50:34 -0400
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=161315f38=graf@amazon.de>)
 id 1tt6Mo-0002JH-EZ
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1741963831; x=1773499831;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KtyDTxtD03WmcoNRXQLxiemEFy4Zd8vRF1HUse6144c=;
 b=X8Mdw5jkrY5VrYnqk7IO/yLf2hJQc2VkgsWRQeI+ZEut1VzoYFYEDj/k
 r1DMwJvA3JJaDmmkfpGPdJ1+mFxcvizzvDmy1JD3C/ebXqJaaz00FeeXD
 1j3hXDswcOD5xpr9g1XtPWZp472j6CookgxvU4QuT4LWJOdurirb4bSfL g=;
X-IronPort-AV: E=Sophos;i="6.14,246,1736812800"; d="scan'208";a="386729649"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80007.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 14:50:26 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:29080]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.245:2525]
 with esmtp (Farcaster)
 id 933782a8-fa1e-4cba-bb62-96b0d85cc1d9; Fri, 14 Mar 2025 14:50:25 +0000 (UTC)
X-Farcaster-Flow-ID: 933782a8-fa1e-4cba-bb62-96b0d85cc1d9
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 14:50:25 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Fri, 14 Mar 2025
 14:50:21 +0000
Message-ID: <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
Date: Fri, 14 Mar 2025 15:50:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Gerd Hoffman <kraxel@redhat.com>
CC: Ani Sinha <anisinha@redhat.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 <qemu-devel@nongnu.org>
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=99.78.197.218;
 envelope-from=prvs=161315f38=graf@amazon.de; helo=smtp-fw-80007.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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


On 14.03.25 15:08, Gerd Hoffman wrote:
>    Hi,
>
>>> Ok, assuming we allow the guest submit a IGVM image (which makes sense
>>> indeed, otherwise we'll probably end up re-inventing IGVM).  How will
>>> the kernel hashes be handled then?  I assume they will not be part of
>>> the igvm image, but they must be part of the launch measurement ...
>> The kernel hashes must be embedded in the IGVM image by the time you invoke
>> vmfwupdate. That means when you generate the FUKI, you take 4 inputs:
>> Generic firmware image, kernel, initramfs, cmdline. Out of those, you
>> generate and embed an IGVM image that consists of the firmware image as well
>> as the kernel hash page.
> If your input firmware image already is an IGVM (say coconut), what is
> supposed to happen?


I'll leave the details to Jörg on how he envisions it, but IIUC the flow 
for a "readily assembled IGVM" is different. In case of a COCONUT-SVSM 
IGVM, you expect chaining of trust. So the SVSM implements a TPM which 
then the OS would use with measured boot etc etc.

It's a fundamentally different concept from FUKI. But it could share the 
same vmfwupdate mechanism to load.


Alex


