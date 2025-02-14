Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41308C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 12:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiuiW-00010h-3z; Fri, 14 Feb 2025 07:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=133e246af=graf@amazon.de>)
 id 1tiuiU-00010N-Kd; Fri, 14 Feb 2025 07:22:46 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=133e246af=graf@amazon.de>)
 id 1tiuiS-0003HH-P2; Fri, 14 Feb 2025 07:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739535765; x=1771071765;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=nLKsqGE/1IcijdeTlYJxozj2UMrtOjxKXaQ53M4yRvY=;
 b=NeA4xyBEa9uK8uLwCz+X7/No4gq04ae4fBtkZpW0QlAJ9G8CpeH+FhhU
 SMOIjeWjUHoHnUhjcVWdUKBrSq4r/aOPX6kfwvRJKj99YPiv+ZJ2tpA5O
 gCYwrO+mzHswyb8+C6GwZ7tDBMSL1QY6nVhp6kisA1AVkTMIJhcwIj1+w o=;
X-IronPort-AV: E=Sophos;i="6.13,285,1732579200"; d="scan'208";a="462547518"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-6001.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 12:22:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:43970]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.176:2525]
 with esmtp (Farcaster)
 id 189c9969-2a3d-49db-a012-bff917a0d461; Fri, 14 Feb 2025 12:22:38 +0000 (UTC)
X-Farcaster-Flow-ID: 189c9969-2a3d-49db-a012-bff917a0d461
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 14 Feb 2025 12:22:38 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Fri, 14 Feb 2025
 12:22:35 +0000
Message-ID: <eed0e242-db81-444a-88e9-ec73a33dc5c9@amazon.com>
Date: Fri, 14 Feb 2025 13:22:33 +0100
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
References: <kk4f5e3olb26qfjveqefkuzrjc45djikkk7uspz4yj7iesdmbj@zointitbvhdp>
 <73fe41f7-dff0-4506-8769-1997323c0a76@amazon.com>
 <4bwjwcs2k4hbrj6mokc57a5dy57jjssfxnvd4qm5257dgnid3x@yqdx7e47o2mf>
 <2c06a98c-f286-4632-a352-8b47dc4cc43c@amazon.com>
 <2vgc4scgezmb3med6dypykcym7te7gzlx7wp3vm5ehtfmxj3xr@kswpu35wt5ns>
 <f59bb48f-051d-4681-a702-6aed3420c2f7@amazon.com>
 <jnxvyw6q4vkng7jztu7q5rabgeohhpoxojdn4wt6xckc6pzmqz@ateji77pl5j7>
 <342a1bd9-52e9-4a6d-8a2a-63d2b478d896@amazon.com>
 <5whdvrcqkpted5wl53yo5qbq2g4bf4j57vrzvbsebho56xfz4w@mjpktoiarmto>
 <a39a1cfb-7d98-485e-98aa-9c03300f4be2@amazon.com>
 <imob6duupjhtdqrmxdvnopqeqgdtw7vjgjzixej7vy6yragzck@o7kcfbdbqedv>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <imob6duupjhtdqrmxdvnopqeqgdtw7vjgjzixej7vy6yragzck@o7kcfbdbqedv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.95.48.154;
 envelope-from=prvs=133e246af=graf@amazon.de; helo=smtp-fw-6001.amazon.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 14.02.25 12:16, Gerd Hoffmann wrote:
> On Fri, Feb 14, 2025 at 10:51:17AM +0100, Alexander Graf wrote:
>
>> I also like to have dedicated register spaces per component. So even if you
>> choose to make it a hard split, I think we're better off with 4k at
>> 0xfef10000 for control and 64k at 0xfef20000 for the buffer for example.
> Well, if we go for PIO transfer mode instead of device memory we don't
> need map the buffer any more.
>
> The control registers for the x86 variant are in io address space right
> now (0x520, next to fw_cfg).  We could place them in a mmio page @
> 0xfef10000 instead.  Any preference, and if so, why?


I did the same mistake in my version and use PIO for x86 but MMIO for 
ARM. In hindsight, I think the same mechanism for both would have 
simplified things a lot: You get better testing coverage of the exact 
same code path. If you split between PIO and MMIO, you always have 
issues that only pop up in one of the implementations. It complexifies 
your test matrix for little gain.

Since you need an MMIO avenue anyway, you may as well always use that. 
This is not a high performance interface where the exit latency 
difference between PIO and MMIO really matters.


Alex


