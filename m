Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A43BC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 13:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiD3r-0006UV-PI; Wed, 12 Feb 2025 08:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=131cd17d8=graf@amazon.de>)
 id 1tiD3q-0006U3-Hq; Wed, 12 Feb 2025 08:45:54 -0500
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=131cd17d8=graf@amazon.de>)
 id 1tiD3o-0002qk-CB; Wed, 12 Feb 2025 08:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739367952; x=1770903952;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8nNDiYVOIzb50G8u/FMD6qLfVR5OxkQy/ZxxsYWuLR4=;
 b=OvnF2QibsSWW2RmFaSbTQF8TXnQgDNX5xY5pFTxBHWepbEFn6j3LtXME
 7NALqnPaa5r014hi3VkZTknJbcmRDSsUPJ9naY/MjFuuiplOL1qHorrjh
 ZWs8t9dUYANma6ohRcJM57XcFQjrgDfytb6JtaKIkptDFhcBBQ/QYrarJ o=;
X-IronPort-AV: E=Sophos;i="6.13,280,1732579200"; d="scan'208";a="376710266"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80007.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 13:45:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:50646]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.65:2525]
 with esmtp (Farcaster)
 id 229e485f-f479-4442-ae6b-8afd477a348f; Wed, 12 Feb 2025 13:45:47 +0000 (UTC)
X-Farcaster-Flow-ID: 229e485f-f479-4442-ae6b-8afd477a348f
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 13:45:47 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Wed, 12 Feb 2025
 13:45:43 +0000
Message-ID: <73fe41f7-dff0-4506-8769-1997323c0a76@amazon.com>
Date: Wed, 12 Feb 2025 14:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/23] hw/uefi: add var-service-core.c
To: Gerd Hoffmann <kraxel@redhat.com>
CC: <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, <qemu-arm@nongnu.org>, Michael Roth
 <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Ard Biesheuvel
 <ardb@kernel.org>
References: <20250211092324.965440-1-kraxel@redhat.com>
 <20250211092324.965440-10-kraxel@redhat.com>
 <da0ac9ed-fdca-433e-b793-5423f430a852@amazon.com>
 <iuwaykfdm7bwtvblyz7lkew3em2ksi5xeztdphqjdv7tsp2ejw@s6j64y3lfmrw>
 <ea1d355b-7e56-47ef-b1e7-158003b6d85f@amazon.com>
 <kk4f5e3olb26qfjveqefkuzrjc45djikkk7uspz4yj7iesdmbj@zointitbvhdp>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <kk4f5e3olb26qfjveqefkuzrjc45djikkk7uspz4yj7iesdmbj@zointitbvhdp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=99.78.197.218;
 envelope-from=prvs=131cd17d8=graf@amazon.de; helo=smtp-fw-80007.amazon.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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


On 12.02.25 13:28, Gerd Hoffmann wrote:
> On Wed, Feb 12, 2025 at 12:30:20PM +0100, Alexander Graf wrote:
>> On 12.02.25 11:24, Gerd Hoffmann wrote:
>>> Why do you use confidential computing in the first place if you trust
>>> the host with your EFI variables?  I'd rather see something simliar
>>> running under guest control, in svsm context.
>> That depends heavily on your threat model. You can use a host provided
>> variable store to gain variable persistence for things like boot variables
>> and then have an ephemeral SVSM based TPM that you use to measure the loaded
>> payloads. A malicious host can already replace your root volume, so
>> extending the threat to variables is not the end of the world.
> If you go depend on measured boot instead of secure boot then yes, this
> might be a workable model.  Should be doable with a small svsm driver
> which forwards requests to the host via svsm-controlled bounce buffer
> (where the svsm has control over page properties).


In a BYOF world it's even useful without SVSM at all, because the launch 
digest performs measurement for you, but you still want to find your 
boot variables.


>>> The firmware knows all this very well though.  The OS passes a mapping
>>> table to the firmware, efi runtime drivers can subscribe to mapping
>>> updates and can use RT->ConvertPointer to translate addresses from
>>> physical to virtual.
>>>
>>> The edk2 code (https://github.com/tianocore/edk2/pull/10695) does
>>> exactly that.
>>>
>>> I see your driver does that too, so in theory it should work just fine.
>>> I'm wondering what exactly the problem with macOS is?
>> You get to know the new virtual address, but ConvertPointer never tells you
>> what the new *physical* address is. That means you have no idea where to DMA
>> from once you're in virtual land.
> Yes.  Knowing both physical and virtual address works only for memory
> you allocated yourself before ExitBootServices.  So you can't pass on
> pointers from the OS, you have to copy the data to a buffer where you
> know the physical address instead.  Yes, some overhead.  Should still
> be much faster than going to pio transfer mode ...


MacOS takes over the full physical address map past ExitBootServices: 
Your code no longer has VA access to random code and it literally 
memcpy()'s all preserved (virtual available) code and data to different 
physical addresses. You simply have nothing that is all of 1) RAM 
(mapped as cacheable on ARM), 2) known VA 3) known PA.

So we really really need a fallback mechanism that works without DMA :).


Alex


