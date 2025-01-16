Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2967E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 05:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYIZl-00058B-Nx; Thu, 16 Jan 2025 00:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYIZi-00057g-Ho
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 00:37:50 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYIZg-0002I9-BA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 00:37:50 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2161eb94cceso5402085ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 21:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737005866; x=1737610666;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OBaa8mdtMqGNt7FNMhG5Xlqa96gK76Piqa+Zc/XRTkQ=;
 b=ykaUGxyO6SxQHs69ofGHuEjgdaNgd4go44fp47vQoLA/PI5OpAWzBneoyk1uy3p9hT
 Kh0+vXfvVESGfCAoBTo115bxIOQxfQcjy35ja5DUVizNjgn7YyF86RI/jKX+U7M8OlBz
 uUNJh581aeWD4BvCWqaI3gCphwdssCjo8sRVQxgczBUBZUgOBAQWrXP9CrRBWngPWJK0
 8Succ9bA9Wx1UoTpHsugy4e41TvhwzeLk3vI7dJrlhhQMiZogRvG1yyyV+Sa9aC1fRjo
 fNEx0Fm1Xteb2AhOZ2tCVgfkqzKKFhbteSvPgglTpuzYAQr+5hMfZmcMcCDGRjXjPKEm
 RR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737005866; x=1737610666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OBaa8mdtMqGNt7FNMhG5Xlqa96gK76Piqa+Zc/XRTkQ=;
 b=drQyiUisEJKeY9cdHkL1/SftCWfedi+ix3KYTIeT1kEJrpMJsAKbgjZvTYZzU96hZg
 sKjkuGxTVoWtqFbtFfYjoo5hfM+P/wpZgRDuqzKAtGiasyrabbf2n6pm7hv0zVKMKBuj
 RnLJN5sadKJmFulzubbPmjozPaIuiHhg0gr6nXpW8GqCDSPQYJX1peSy1drSTDGaO8B5
 eKKqQqq+kAS6UdUvO/8BvD4m+tQADGGI8p24OweVh0BlszbxoUGrRlBsQogg70zFmKsc
 SoOFdxTEmmW1KadFyqfNVPncm7g3RuNVg5MN+4Wz1DTjE2D4KXRlm2fgDgXw/k00YOlo
 ml2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrr6GvjC+ttd1XygNl8WIopdjZ9X5lW80MusAlcaUQbmoW1TxW9iLwnyFFl05nxk0AxMFu0YzWsiHM@nongnu.org
X-Gm-Message-State: AOJu0YzbMp3kx8BGfJj6XTRMQPDKhcmmA6qqib9hdck3m+oQJmqzA5PD
 ghja9TjkpMIsRrQocYRu74usayRX7L6nBs5qHQmiLrMwL7s49/QcelzqwrKxZdA=
X-Gm-Gg: ASbGncv7MyDzqad4WSIR4JGOTNnIUjPYD0tOmLZBNDW/+AEWvMGr+OSlJyZW+hJE7Jt
 9/qlIJUif2TzoMlPeeMFjKkXLiuSLK0x3sO95ilD4kGvYg6Z4eAdXvqipGS+Ih77mcDrixMCrOT
 76uBvTyx0XLwrCf2WeYl7n+oMcalFQOctzfb+xFQZbcNU51Jd8NCjTycsFpG/SCpgmBFSAMggOw
 w+t9MybcscUUSrvKyJ6MG9I3YvpXnUF5vh6+QcRLBe2wrWtS/Hiw4owUsbCNVAjtYs=
X-Google-Smtp-Source: AGHT+IH8cJBTxw7KetplP5xGM3OuWlgAe4yxJkjj0iNdNnt3cmrHQOHJWc+W9QCdnpiHnYHofmLMbw==
X-Received: by 2002:a05:6a00:3287:b0:725:456e:76e with SMTP id
 d2e1a72fcca58-72d21fb1d3fmr44282888b3a.6.1737005866616; 
 Wed, 15 Jan 2025 21:37:46 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d406a552fsm9970780b3a.163.2025.01.15.21.37.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 21:37:46 -0800 (PST)
Message-ID: <99016684-b5f9-446c-b85f-0dc21d1edae6@daynix.com>
Date: Thu, 16 Jan 2025 14:37:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
To: Peter Xu <peterx@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, devel@daynix.com
References: <Z4E6TnKaUt8FMWIv@x1n>
 <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com> <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com> <Z4aYpo0VEgaQedKp@x1n>
 <00a220df-b256-4b70-9974-f4c1fe018201@daynix.com> <Z4e7gFSqdhcmJPYb@x1n>
 <dbf863f8-6174-4c37-9553-a2d94f06de00@daynix.com> <Z4fW_rI7Mfrtc1Fg@x1n>
 <af018f8a-ce00-4ce2-9fe9-b6ba3f97bfa1@daynix.com> <Z4fezdR1ApN8ZLTS@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4fezdR1ApN8ZLTS@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/16 1:14, Peter Xu wrote:
> On Thu, Jan 16, 2025 at 12:52:56AM +0900, Akihiko Odaki wrote:
>> Functionally, the ordering of container/subregion finalization matters if
>> some device tries to a container during finalization. In such a case,
>                        |
>                        ^ something is missing here, feel free to complete this.

Oops, I meant: functionally, the ordering of container/subregion 
finalization matters if some device tries to use a container during 
finalization.

> 
>> removing subregions from the container at random timing can result in an
>> unexpected behavior. There is little chance to have such a scenario but we
>> should stay the safe side if possible.
> 
> It sounds like a future feature, and I'm not sure we'll get there, so I
> don't worry that much.  Keeping refcount core idea simple is still very
> attractive to me.  I still prefer we have complete MR refcounting iff when
> necessary.  It's also possible it'll never happen to QEMU.
> 

It's not just about the future but also about compatibility with the 
current device implementations. I will not be surprised even if the 
random ordering of subregion finalization breaks one of dozens of 
devices we already have. We should pay attention the details as we are 
touching the core infrastructure.

