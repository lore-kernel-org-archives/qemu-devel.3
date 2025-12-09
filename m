Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8A1D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 12:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSx3x-0006ae-Sw; Tue, 09 Dec 2025 07:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSx3w-0006aV-0K
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:43:28 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSx3u-0002KW-C5
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:43:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so71024155e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 04:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765284204; x=1765889004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ws/JJWO3A2J6B5+S2cwJdZEUpmY0vTJIQQuqx2SDQD4=;
 b=N9RpaIzYR3EA4UGaFmjrpIUtOAW7++BHaQ35k1uoG0OwsGdSvd3do3YhFJZJhpW/Ad
 mJuCBCwqIY+Us1SJDszWYw+NzUl2gObhthnzDEExhtzF5+YO4hQIJyVSDn2Bec3kyqTH
 eJFddTHLWKDuQRv8Zp6fxlh2dZMpfhS4J3NiYqoGPxXcFkliVcVhffHFE7+rC60Muj8f
 1Fl128Vlb9vs+B4FavPq/Lzap1RzJPKqEuLphbfLpTlOsV38ELBMXhYdMNhqQtqrvi8g
 JMG18LMaCVS5gQau9EIuLJmRoApMe44Xyade/7eh1C2/+Wdmn8x7tGvFvBVRfYA+sNsZ
 KqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765284204; x=1765889004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ws/JJWO3A2J6B5+S2cwJdZEUpmY0vTJIQQuqx2SDQD4=;
 b=EZ6tM6MZEv2A6WHmIEgYBelv3xuh9B6KBqKnCOQCYr38TGh899Depx8L9kCnVP1Gt0
 FCPVsUnNJ7xoAek7px10JumlxNXD5S/bYsgbtgaho2LfcAeMXIjz9s8Kc4sdA/Y52Byi
 uvSlFJ+DCg7J+NXOIq6GRXbgSKTg4YUqtVrhU21nZNJ8ItBvQV7oBGSSsBB6k/Sz/tH/
 VTvc4P5eXJzz2McnrLxNJxUkiSBhMxOv9KTHARfbtHwqGM//g90XCuful8UMibofvETD
 bVGUrbsuR7CYxRkh2Zt6p+M7MalIpfAb5hm73hcjrGvoU3bnmANSGKVAVOfR18K9R1u4
 hGKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRPq4VlgIN/t5Ucab6FfLhBXf+xdYSzMmxmvWx578qIFk7+Qq4yFhUmdSLSZmMyKPxl32lF++oTDkA@nongnu.org
X-Gm-Message-State: AOJu0YzUCE36RCgWSgQAFL4JT2YFWZGIJzSLrglff2lwcyAugAgX1P6h
 RyFFmVByePvaqWAlSEGkN9HPMycJQJ3nVz+EbChDOv9VChTUTq15tb4+ZepZK3DD2bg=
X-Gm-Gg: ASbGncsfmppTIFD1OeFcjZKNY9e0+I5jKGedxMJYufmcYWsje9XWvM8Vz9bX3iqWM5R
 DF6R60+4WSpgLQ5uyH/21KpBGbyc9QlRxOioDnOEurKDAyd2GmNZbVvDP9MLkUlUqbXX4V1FOQa
 W47hpvETFM8Zum0OlN2HxqNkjYX4AAasl3QPtEQWhrY7Y1au9H08dD6bK5fmlZ662t8lNNyFWXa
 hH7zzOWhXo9y3aP5aTpkcYGDd4AhqkDKICsxTUWNMsCWGZr9XJJI0BFC36bB8g+yWG53qeR/8t7
 WICi+OfyrCpdc1x/jfTK+atwmCjAwxizn7ASnLacupY+FeOczjE1ijfGZDmkyzG3LYwa7QQYS5y
 s240lgTuhfJg5YIYQNgXFvXHk0IiMMnLp4zuPskg1IsTWMJAqCbZ2BEL3a7OvfVsiP2yC7C9+pp
 8m5hbL1HKdLFqWO4gAlLTeaxQWg+SLu1yVD/HFG1DAgVu/Z5Dr3WwWtQ==
X-Google-Smtp-Source: AGHT+IFL7uTXCiK/1OC26ymbVobyzbAQSJX6OJ9gieCdmde8zp15ki/yVCjWL4HpOXw5V3XW6rTp8g==
X-Received: by 2002:a05:600c:4e14:b0:475:e067:f23d with SMTP id
 5b1f17b1804b1-47939e2b900mr105322015e9.25.1765284204327; 
 Tue, 09 Dec 2025 04:43:24 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d612e3esm36938205e9.2.2025.12.09.04.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 04:43:23 -0800 (PST)
Message-ID: <f5d5f13c-184d-47a6-afa8-a0e0ed9da96e@linaro.org>
Date: Tue, 9 Dec 2025 13:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call (9/12/2025) agenda items?
Content-Language: en-US
To: Mark Burton <mburton@qti.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sid Manning <sidneym@quicinc.com>,
 Matheus Bernardino <mathbern@qti.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, "cjia@nvidia.com"
 <cjia@nvidia.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "cw@f00f.org" <cw@f00f.org>, "demiobenour@gmail.com"
 <demiobenour@gmail.com>, "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>,
 Eric Blake <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, "felipe@nutanix.com"
 <felipe@nutanix.com>, Alyssa Ross <hi@alyssa.is>,
 "iggy@theiggy.com" <iggy@theiggy.com>, Warner Losh <imp@bsdimp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Max Chou <max.chou@sifive.com>, "mdean@redhat.com" <mdean@redhat.com>,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, "wei.w.wang@intel.com"
 <wei.w.wang@intel.com>, "z.huo@139.com" <z.huo@139.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>
References: <87bjk9hv4f.fsf@draig.linaro.org>
 <F4C64ED8-91E9-47C6-B51C-7B6929EE478F@qti.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <F4C64ED8-91E9-47C6-B51C-7B6929EE478F@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

+Eric/Peter

On 8/12/25 20:32, Mark Burton wrote:
> I’d like to talk a little bit about how address spaces, IOMMU’s, MMU’s and stuff are handled - we’re having some fun with that, and I have a feeling others are looking at similar things, so it would be worth making sure we’re not on top of each other?
> 
> Cheers
> Mark.
> 
> 
>> On 8 Dec 2025, at 16:05, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
>>
>> Hi,
>>
>> The KVM/QEMU community call is at:
>>
>> https://meet.jit.si/kvmcallmeeting
>> @
>> 09/12/2025 13:00 UTC
>>
>> Are there any agenda items for the sync-up?
>>
>> --
>> Alex Bennée
>> Virtualisation Tech Lead @ Linaro
> 


