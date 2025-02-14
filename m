Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8CBC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 09:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tisM8-0007UF-Sg; Fri, 14 Feb 2025 04:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=133e246af=graf@amazon.de>)
 id 1tisM7-0007U4-Mg; Fri, 14 Feb 2025 04:51:31 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=133e246af=graf@amazon.de>)
 id 1tisM5-0003BQ-TB; Fri, 14 Feb 2025 04:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739526690; x=1771062690;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=06TkTKG2p7gvpvMbupdGztjQ5q+MhnngMmoPj2hqdSo=;
 b=rgJrAY5Sd5Gzb3n+EAqj3KMVBad1+pTTqKwMPMK3tz9+VrGRskL7y5lB
 6cp9eIOtYUrFt8d/Tn1nKkyck6jFe0pPdVxEtNAl/RSDL2QO2Cx280m11
 cT11NVDmVUyyHMPrW7pv8NYSt4RYMsTwTa+x35u9mNYvrcGUdUviaJUEe 8=;
X-IronPort-AV: E=Sophos;i="6.13,285,1732579200"; d="scan'208";a="472131555"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:51:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:49333]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.141:2525]
 with esmtp (Farcaster)
 id 1592676c-aff7-4f27-b5f6-fa61695a852b; Fri, 14 Feb 2025 09:51:22 +0000 (UTC)
X-Farcaster-Flow-ID: 1592676c-aff7-4f27-b5f6-fa61695a852b
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 14 Feb 2025 09:51:22 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Fri, 14 Feb 2025
 09:51:19 +0000
Message-ID: <a39a1cfb-7d98-485e-98aa-9c03300f4be2@amazon.com>
Date: Fri, 14 Feb 2025 10:51:17 +0100
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
References: <iuwaykfdm7bwtvblyz7lkew3em2ksi5xeztdphqjdv7tsp2ejw@s6j64y3lfmrw>
 <ea1d355b-7e56-47ef-b1e7-158003b6d85f@amazon.com>
 <kk4f5e3olb26qfjveqefkuzrjc45djikkk7uspz4yj7iesdmbj@zointitbvhdp>
 <73fe41f7-dff0-4506-8769-1997323c0a76@amazon.com>
 <4bwjwcs2k4hbrj6mokc57a5dy57jjssfxnvd4qm5257dgnid3x@yqdx7e47o2mf>
 <2c06a98c-f286-4632-a352-8b47dc4cc43c@amazon.com>
 <2vgc4scgezmb3med6dypykcym7te7gzlx7wp3vm5ehtfmxj3xr@kswpu35wt5ns>
 <f59bb48f-051d-4681-a702-6aed3420c2f7@amazon.com>
 <jnxvyw6q4vkng7jztu7q5rabgeohhpoxojdn4wt6xckc6pzmqz@ateji77pl5j7>
 <342a1bd9-52e9-4a6d-8a2a-63d2b478d896@amazon.com>
 <5whdvrcqkpted5wl53yo5qbq2g4bf4j57vrzvbsebho56xfz4w@mjpktoiarmto>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <5whdvrcqkpted5wl53yo5qbq2g4bf4j57vrzvbsebho56xfz4w@mjpktoiarmto>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.95.49.90;
 envelope-from=prvs=133e246af=graf@amazon.de; helo=smtp-fw-6002.amazon.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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


On 14.02.25 08:55, Gerd Hoffmann wrote:
>    Hi,
>
>>> How do your patches pick the transfer mode?  Is that dictated by the
>>> host?  Or is the guest free to choose?  In case of the latter:  How does
>>> the guest decide what to do?
>> In our version, the guest gets to pick. It defaults to the DMA interface
>> unless it detects that it's running either the macOS logic (a case you can
>> ignore for now) or is running with SEV-SNP.
>>
>> I think for the upstream interface, it would be best to have the host
>> indicate which one it recommends the guest to use. That way you can force
>> the fallback path without requiring tedious edk2 changes.
> I'm more thinking about a hard switch, i.e. the host would support only
> the one or the other.  That way we'll go need less register space,
> because we'll need either the buffer location register (dma mode) or the
> pio transfer register (pio mode) but not both at the same time so they
> can share the location.


The nice thing about supporting both in the hypervisor and advertising 
preference is that a minimal guest firmware could choose to only support 
the safe one. Given the simplicity of the DMA protocol, it's not a hill 
I will die on though :).

I also like to have dedicated register spaces per component. So even if 
you choose to make it a hard split, I think we're better off with 4k at 
0xfef10000 for control and 64k at 0xfef20000 for the buffer for example. 
Even in the buffer case, you need some control registers. And you want 
to leave the door open to making the buffer space be a direct RAM map, 
which means you want to make it a page granule of the largest typical 
page size (64k).


>
>>> 0xfef1000 seems to be free, which is kida fun b/c of the 'ef1' in the
>>> address.
>> True, I love it! :)
>>
>> It's not enough address space to fit the full 64k buffer though, right?
>> Would all of 0xfef00000 be free by chance? Then you could just direct map
>> the transfer buffer there.
> All of 0xfef00000 is 1M, i.e. 16 x 64k.


Oh, there was a missing 0! So the target space is really 64k right now 
(0xfef10000).


Alex


