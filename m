Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9852ACCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy5L-0006fy-4Q; Mon, 20 Oct 2025 18:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy5J-0006f8-LR
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy5I-0006JD-0Z
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4710022571cso41435925e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998230; x=1761603030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i98Yuq0ltlKlv4yK9SnQK5pu59pN5J9uGirjRSj4vcU=;
 b=i232VvbNgYEESRyBHkcSUnQoNse5LMtARl9jwukQiogohm64Q+JKWVUpxDa4dnHQwe
 UFPrtqisY3Oks6+se3aegYeDVh2l/yPiwAnr08+7qBsJHd68JDM5F1Ax6Mfs+ReJcdyb
 TO2ESPYFG6+C5D/7+AezTO120O4kmhpkOYjUgqJ4LBnl+z0GqMH8M6PqjTV61358YREE
 RIvC0E25Ro7sn/s/pY7DTM3RSAD9z7E4xLqpvQKkw1cl+H2x+S6vF1A65jurGt2kFaRI
 4WeRXGXDKZbzygrBSU0by0voo9mJ67DWQJGaeEVrOWo6s905lJhkQoG00400JpukDWkQ
 XoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998230; x=1761603030;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i98Yuq0ltlKlv4yK9SnQK5pu59pN5J9uGirjRSj4vcU=;
 b=DF/kszAoisjB/2dQo2dI3/s7VBX2q84CSzXFKnmk7MuvdViXCFwDdb0KaX0COqGoJT
 nJ13RnIdoGn0FOXMC6gEb+1Fq7lPB2Ogr579x3kieh1RtOB9UHsQ0R6pT0kmQNDywiRu
 4dI/2/9GUk21v8f+MN8WnqWlXYe9qJJZmvGMH9Tq0t+KoPmo5Hwr63Tqj17wclgjuMWj
 QDXlT2Rvrump2ADKqeVw0p7uCG5Pgr07XdkQVyeMNYCshriFZg0KwvC1pRShHja1s6ER
 Jks8MVZfeenpq9F5Vn7soZi3gk5udJtlLviNJ2qdFvz9MN9Uglzb/nmnIY6QKd/NrBaB
 bEqQ==
X-Gm-Message-State: AOJu0Yw62PI+j9P3FQ6ZILLrv5wxs36tTKHCVNxcsDPAk7mbZtZItTsi
 oKnlfTkxxfNiSH90i1hk/IPoA3vi7hp6x8uOzLbcHfC8EfnF0NwraxoTcZnifDaaDV4=
X-Gm-Gg: ASbGncs/XcZeQ8WGra4W8TAr4h8X+IsVGBxEYIBYZh0hnSWDW3gtidEThv6Mz7/KPyM
 zjxMwde0YKtzs4WKgnbKkXHAnHAC5qF5ZqHMbUxd+p6Ur4rmVuzg7EQe4TjpuKnJQ9rwLo+x60J
 uZ/1o5rliOd6RO9eAnxIwldXHgtmQF8jPUVnR9CcrrtVd9JYc78uSxtP1QZ5mlfJvlcFo1lPaVK
 OIZ3LvEJUAHZ7F3xDcU8Obsar1Dvp0vpedCPU1DraBDhkYIPiCkztwfMAwsV//u8jWEnMDSd1bq
 WNpVr42UL/7jNg4/VCEKEkE0GznO/5yj45BFZ/p03heImBTNr8pQqmPa3paxufJvkOrg5+C3D0Y
 Ukl71XSRVuEK8Hg1AjnLbp5aShin+8j5j6n4ccARnzDMB7oyzFlwDiLmouxZuQiMXsLdHz5toiv
 eaeJCQ1awh+opzIcRotBQQThWWt/V4hGcbxTaLBpm28CY=
X-Google-Smtp-Source: AGHT+IFCdJ33iX9IfoprfwbMNSNRng0Iy4UBXs5y7kA2QBqldWqeZq5YgNhauCzSIulO/79S1LItfA==
X-Received: by 2002:a05:6000:4011:b0:425:855c:5879 with SMTP id
 ffacd0b85a97d-42704d6c536mr10010310f8f.15.1760998230305; 
 Mon, 20 Oct 2025 15:10:30 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47494ac30b4sm4312245e9.2.2025.10.20.15.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 15:10:29 -0700 (PDT)
Message-ID: <daa0fa36-6441-4936-9975-1bb38bb7935e@linaro.org>
Date: Tue, 21 Oct 2025 00:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/16] hw/pci-host/raven: Simplify PCI facing part
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760795082.git.balaton@eik.bme.hu>
 <9f0e1a8860f6a8f00c15e212ba5c46ae6a7fe39a.1760795082.git.balaton@eik.bme.hu>
 <56bb063e-696c-49fb-943a-7ef9f28c4826@linaro.org>
 <45817152-d402-cf83-cbd4-22d7d2c6d60d@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <45817152-d402-cf83-cbd4-22d7d2c6d60d@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/10/25 22:54, BALATON Zoltan wrote:
> On Mon, 20 Oct 2025, Philippe Mathieu-Daudé wrote:
>> On 18/10/25 16:04, BALATON Zoltan wrote:
>>> The raven PCI device does not need a state struct as it has no data to
>>> store there any more, so we can remove that to simplify code.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/pci-host/raven.c | 30 +-----------------------------
>>>   1 file changed, 1 insertion(+), 29 deletions(-)


>> I'd rather this patch split in 2: remove vmstate, mentioning this breaks
>> migration, then use pci_create_simple().
> 
> I can do the other way around: first convert to pci_create_simple which 
> leaves RavenPCIState pci_dev unused that then can be removed in another 
> patch.
LGTM, thanks!


