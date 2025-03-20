Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF366C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 13:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvGLu-00010o-Vf; Thu, 20 Mar 2025 09:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1678d28e3=graf@amazon.de>)
 id 1tvGLg-000106-O5
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:54:21 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1678d28e3=graf@amazon.de>)
 id 1tvGLc-00074v-7d
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 09:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1742478852; x=1774014852;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qSZMBivb2Y9jLImO1fl0gDWje0K57nODnLUNlg4HJz0=;
 b=UA4el6b+U/PYud562UsHV55Kr9+CICNaCGizfDVpakj/uf2TWX/76Uqz
 wV8Aklv6Dx+7On4+a89I3IEFe1nS8g7mgcbopWMmRiF8J3RMF/pQGKXF9
 XPs/pXwB9OzWmCeDc1dbEssPc9t+8u8DdQNfMsJCOsAvlKEPVT2L0JIqi I=;
X-IronPort-AV: E=Sophos;i="6.14,261,1736812800"; d="scan'208";a="33584194"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 13:54:06 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:22091]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.69:2525] with
 esmtp (Farcaster)
 id c6c62568-ff34-454d-8fef-87e158876aa9; Thu, 20 Mar 2025 13:54:06 +0000 (UTC)
X-Farcaster-Flow-ID: c6c62568-ff34-454d-8fef-87e158876aa9
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 20 Mar 2025 13:54:00 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Thu, 20 Mar 2025
 13:53:56 +0000
Message-ID: <c7f840d5-19ed-493e-8de8-7d64aef38948@amazon.com>
Date: Thu, 20 Mar 2025 14:53:54 +0100
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
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <6684f169-29d6-4f46-b274-1efd4c191b21@amazon.com>
 <ok6u7exmwmh7qsahp5o3udnbbzbsr2km22kpqod37t6mdsywcs@yhk2whhakl63>
 <fucfv6gf22t3sclhad4iwbmxi5tdg6a5dlhvl4kl4bzhnjkktu@dtn2eqh27k32>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <fucfv6gf22t3sclhad4iwbmxi5tdg6a5dlhvl4kl4bzhnjkktu@dtn2eqh27k32>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=99.78.197.217;
 envelope-from=prvs=1678d28e3=graf@amazon.de; helo=smtp-fw-80006.amazon.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

Hey Gerd,

On 18.03.25 12:11, Gerd Hoffman wrote:
>    Hi,
>
>> Maybe not from the user's point of view, but surely for the vmfwupdate
>> interface design and for the launch measurement calculations.
>>
>> When using igvm parameters for the kernel hashes we need to pass on (at
>> least) two items via vmfwupdate API:  The igvm image itself and the
>> kernel hashes, so the VMM can fill the parameters for launch.
>>
>> I tend to think it makes sense to keep the region list, so we can
>> actually pass on multiple items if needed, and simply add region flags
>> to declare that a region is an IGVM image.
> Went over the interface spec today, here it is.  Changes:
>
>   - Moved descriptions into source code comments.
>   - Added leftovers noticed in recent discussions, such as cpuid page.
>   - Added capability flags and region flags for IGVM.
>
> Open questions:
>
>   - Does the idea to use igvm parameters for the kernel hashes makes
>     sense?  Are parameters part of the launch measurement?
>   - Do we want actually keep the complete interface (and the functional
>     overlap with igvm)?


I think if we want to embrace IGVM, we should embrace it fully and make 
it replace the region list. At the end of the day, IGVM is effectively a 
region list plus data.

How difficult would it be to put up a prototype that uses only IGVM as 
vmfwupdate payload? We can definitely assemble that IGVM in ukify.py or 
as part of the boot stub. Or for the prototype even pre-assemble by hand.


Alex


