Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB70510F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYWo-0000fF-Ab; Wed, 08 Apr 2026 15:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69d604dc.v1-cb72f1063b41437b93800602a20dd3a4@bounce.vates.tech>)
 id 1wAY7U-0007fk-O5
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:59:21 -0400
Received: from mail178-25.suw51.mandrillapp.com ([198.2.178.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69d604dc.v1-cb72f1063b41437b93800602a20dd3a4@bounce.vates.tech>)
 id 1wANik-0003ul-Um
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 03:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1775633628; x=1775903628;
 bh=lf/7x995PIuMmZC7YZDG2jKn3t9Oc495yOkrRXw8d4M=;
 h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=cAfLHoz+9gelA+wWjlBpE5/+7ZLnszfyOQEwdGb41ArKa/AhC+x4g6dfKobJRrjKJ
 YrUZ4ylR6PSokkdrxPlOR2xD1NrsqelHwBLyYsrv4GFmL460KJH8wxTMCQQo0Sqjs7
 0WaxpO7ogofHR1UVmSFucR2N5Cgaix7PQJOprr7wNNRrzS7aanYtzFnw2w1MV0wvyq
 YCuIn6vPln3WVZFO81jxk4gZuOMBQg3IEDJPT73jC7QXPWERgH/sd32yNNUzBBgL6Y
 UPvKfLxbN+iM1hv8G6K6A0hzHehDMqxuYwrCmv9EAi7U09UJ09sx5LuE3AiB79MsIX
 4BtPF+u2htLEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1775633628; x=1775894128; i=thierry.escande@vates.tech;
 bh=lf/7x995PIuMmZC7YZDG2jKn3t9Oc495yOkrRXw8d4M=;
 h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=kgD+GOfVL4hQRh+lUUqs1M6Grgfznzt40ooRn5aKRJRPf+yHks52SAVp6XPUsSR0r
 ODnWINq2XR8hRcrmC7s0ALaVBwGt3TRawjZIvQTaMzBWwIrxYJUqok+a3rFtXfWF0s
 qCUM+rU5X6KR0fWow9I6nGcknD1ZtRN2qXv8e3KgxQtPTfyPkpy9xxXTyPXLdrw6vx
 i1SKDWzFBEznwUJrCQbljhs8A/ziY5wtc5JaYjHyjPkqzrT2TuIOJrd+HQl3E6hn4H
 rJN9HSEG7G12QqBokWoaDLAekqI8AemO4neWsbfzV/q3rCBWaIiEBzQGopfcTZxcPt
 W3Drd1rjmk9lQ==
Received: from pmta13.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail178-25.suw51.mandrillapp.com (Mailchimp) with ESMTP id
 4frFDX4xN5z4f3mQb
 for <qemu-devel@nongnu.org>; Wed,  8 Apr 2026 07:33:48 +0000 (GMT)
From: "Thierry Escande" <thierry.escande@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=200/4]=20Xen:=20Add=20Q35=20initial=20support=20for=20HVM=20guests?=
Received: from [37.26.189.201] by mandrillapp.com id
 cb72f1063b41437b93800602a20dd3a4; Wed, 08 Apr 2026 07:33:48 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1775633627298
Message-Id: <7db25729-b4ab-41d4-8790-097b5338fe17@vates.tech>
To: "=?utf-8?Q?Daniel=20P.=20Berrang=C3=A9?=" <berrange@redhat.com>,
 "Anthony PERARD" <anthony.perard@vates.tech>
Cc: "=?utf-8?Q?Marek=20Marczykowski-G=C3=B3recki?="
 <marmarek@invisiblethingslab.com>, qemu-devel@nongnu.org,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 xen-devel@lists.xenproject.org
References: <20260313164649.794591-1-thierry.escande@vates.tech>
 <abVtsK31t9tWgsaY@mail-itl> <acJZHpw8tcTMPpCn@l14>
 <acJgclxJ4_0YbBqT@redhat.com>
In-Reply-To: <acJgclxJ4_0YbBqT@redhat.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.cb72f1063b41437b93800602a20dd3a4?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260408:md
Date: Wed, 08 Apr 2026 07:33:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=198.2.178.25;
 envelope-from=bounce-md_30504962.69d604dc.v1-cb72f1063b41437b93800602a20dd3a4@bounce.vates.tech;
 helo=mail178-25.suw51.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On 3/24/26 10:59, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 24, 2026 at 09:28:00AM +0000, Anthony PERARD wrote:
>> On Sat, Mar 14, 2026 at 03:16:15PM +0100, Marek Marczykowski-G=C3=B3reck=
i wrote:
>>> On Fri, Mar 13, 2026 at 04:46:56PM +0000, Thierry Escande wrote:
>>>> This patch series introduces Q35 chipset support for Xen HVM guests. T=
his is
>>>> based on the work from Alexey Gerasimenko (See patchset [1] for refere=
nce).
>>>>
>>>> This series does not implement device passthrough as this will need mo=
re work
>>>> on the Xen side to support multiple PCI buses. Since Q35 chipset does =
not
>>>> support device hotplugging and with current Xen mechanism for device
>>>> passthrough, they have to be plugged to a new PCIe root port, i.e. not=
 the PCI
>>>> bus 0.
>>>
>>> I always found it weird that Xen does hot-plugging of PCI passthrough
>>> devices... Wouldn't it be easier to change this (connect them from the
>>> very start, via QEMU cmdline) and declare hotplug as unsupported (at
>>> least at this time)? I realize it's more complex change at the toolstac=
k
>>> side, but overall may simplify things and maybe even improve
>>> reliability.
>>
>> Skipping hot-plug on Q35 sounds good to me.
>>
>> I though we could keep using QMP to do cold plug, with the experimental
>> "--preconfig", but "device_add" isn't allowed :-(. So yes, doing this
>> via command line sounds fine.
>>
>> In libxl, we might be able to transform the json for `device_add` into
>> the command line counterpart for `-device` fairly easily so the argument
>> are only generated in a single place. Then we could skip the QMP
>> "device_add" in libxl when it's already done via command line.
> 
> -device accepts JSON directly, so there's no transformation you
> need to do from the QMP JSON. For example:
> 
>   -device '{"driver":"pcie-root-port","port":8,"chassis":1,"id":"pci.1","=
bus":"pcie.0","multifunction":true,"addr":"0x1"}'
> 
> Likewise  -object, -audiodev and -netdev accept QMP JSON too

Thanks for your help and directions.

I have a few patches that I will send soon as RFC to gather your feedback.

They add a 'hotplug' option for pci devices, enabled by default, to
control if the device should be hot-plugged using QMP 'device_add'
command or through Qemu command line with `-device
xen-pci-passthrough,...'. The 'device_add' command is skipped but the
'pci-query' check remains.

Regards,


--
Thierry Escande | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech



