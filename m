Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC56D78309
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 10:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI48g-0002xA-DI; Mon, 02 Dec 2024 05:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tI48e-0002rt-1H
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:58:48 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tI48b-0002mc-PE
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:58:47 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53df1e0641fso4532192e87.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 02:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733137124; x=1733741924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=c8jm30HIJIHDRqV6Q97GgxCiYLshI3pxdnrd4Buw6EE=;
 b=DoResXL3KkY3d+6VrCYfDaq/oSaD7L62tHxvwp8AN0suPcIXnghGUnTR9mFwV1nU8E
 SzqNAQLxm37EZHaJtiQG5dyxRT2lqJYt/MBOxf1FV9wmSLAtqeKMyGGOXoFHTy+yE801
 osbzOGLGq0d8Ew2/Ssn1Jg0kjk/DW5b8q6k2EJ84NtCDTYubu/bkPvMwxi35DGf2ANc+
 nFB8+BgQvjns/IWLCw67shbVp0IHM7uB+iPyfyH2j5BADy7ThdTS8USGzcFvdYToX71E
 /39B8X/vt7P+7TZqrlZRiNGGS0CMBTHAakLY1Nhsrm9bnXXEcgt/rkKAEL9TIdyTlDdO
 A8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733137124; x=1733741924;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c8jm30HIJIHDRqV6Q97GgxCiYLshI3pxdnrd4Buw6EE=;
 b=RW/+V3NnqKjBdzyIf0O8yR0qCtOXuvAM3xD2QNr8bulxw+ktOQ2IxvZnq7ZPfw4bCN
 L6J/obLCXcT4heDzvzRNR2Cd35TWz2WSzAOTScePzx/eJ665wJ0ct4SRNlOj0FHcaKQC
 b96nqihDA6TT0JPSsyGV+aBAaoES1yzeVBEL3WMWBi3wyxT3Y3SkAnqJW+/5rLOC/WYx
 SUYj2ml8v2ZMfWpNEjteEXCDJe9tWhcvQlh+/Uj/DbfqI4Dk0P285iArLLdUlM/LhyHa
 PriA4iKBhxic/XwAz3MD+yp2YgXE4fSxMBfciQ4PHAxvTkxp8CALmh/bkqOgbiszfSM5
 ppgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7l9dCJAgWAEfxUM16uP96BQ3o0YnZVvjZlSAOl/qjmYc992Pj4lNMkMMfVluzdsKdYT+vHLbi2zPf@nongnu.org
X-Gm-Message-State: AOJu0YxNaiJ904vVlUZxXwjZHfvQ4A4+/cYhr3EoutbEZMtM1MqClRyS
 +jZW3MD9YnCWiKk21XncOYqKrK5/IdXJbZ9jv2z2LpY60YqcRIzPHjEZHMjoAzPxsGUSF5xXTbg
 m1f4=
X-Gm-Gg: ASbGncthXmh4lHsQ0ApQlZoxqiH6KvoJSzPBZCrU6d7jimepyzgBCGJQqIs2f9zgNVl
 L940tC03WcTWioUQmUS6vz0tG+AJKdtR/5IXgA/TMXUuZ56RLbDMnNjsaPBN0Q2V6JttW9BrLWC
 oltIuBNOrB0qNz76G2R8b0S3Ng4mHuPxPk1jzC7C6IBbSBwDMBX3MZiut7WYmZ04vTZD6qOb5HV
 WjuAT/T+9HSGuJq8pYUyptGA6DZIXFz2PAgijK/yY36G03VPo05W+IWRjIPJuZzUq4UDRTPIPqQ
 kOiCnPNxEanFZv3e0pyZ6N1n65h2
X-Google-Smtp-Source: AGHT+IH7dsn19ofz+BupGbFw7tGSjLy2B6mpxA9PGkJhftfXmFKk7nrnousYCt6ixB1lc5fD+vo29w==
X-Received: by 2002:a05:6512:3e08:b0:53d:dbec:9fca with SMTP id
 2adb3069b0e04-53df001abb1mr11580153e87.0.1733137123731; 
 Mon, 02 Dec 2024 02:58:43 -0800 (PST)
Received: from [192.168.210.26] (83.11.10.28.ipv4.supernova.orange.pl.
 [83.11.10.28]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53df646effdsm1434026e87.130.2024.12.02.02.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 02:58:43 -0800 (PST)
Message-ID: <21d8399a-91bf-4599-a73d-351f9f0c147c@linaro.org>
Date: Mon, 2 Dec 2024 11:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

W dniu 1.12.2024 o 19:09, Pierrick Bouvier pisze:
> Hi Marcin,
> 
> On 12/1/24 05:34, Marcin Juszkiewicz wrote:

>> So RME tests probably need longer timeouts or would not run at all.
>>
> 
> By any chance, are you running those tests in debug mode?

zOMG, thanks! Turned out that I left "--enable-debug" in my local build 
and forgot to remove it.

90s vs 2974s is a difference ;D

>>> +++ b/tests/functional/test_aarch64_rme_sbsaref.py
>>
>>> +        self.vm.add_args('-accel', 'tcg')
>>
>> That's default value so can be skipped.
>>> +        self.vm.add_args('-m', '2G')
>>
>> I sent patch to bump default memsize to 2G recently.
>>
> 
> Is that merged already, or will be later?

Still in review queue.

>>> +        self.vm.add_args('-M', 'sbsa-ref')
>>> +        self.vm.add_args('-drive', 
>>> f'file={pflash0},format=raw,if=pflash')
>>> +        self.vm.add_args('-drive', 
>>> f'file={pflash1},format=raw,if=pflash')
>>> +        self.vm.add_args('-drive', f'file=fat:rw:{virtual},format=raw')
>>
>>> +        self.vm.add_args('-drive', 
>>> f'format=raw,if=none,file={drive},id=hd0')
>>> +        self.vm.add_args('-device', 'virtio-blk-pci,drive=hd0')
>>
>> sbsa-ref is fully emulated target. There is AHCI controller built-in so
>> only "-drive" argument should be needed (no "-device" one).
>>
> 
> I followed official instructions from Jean Philippe to build RME stack, 
> and I think it's better to keep them in sync.

OK.

>>> +        self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
>>> +        self.vm.add_args('-netdev', 'user,id=net0')
>>
>> e1000e is built-in already
>>
> 
> This is needed, because without this, there is an explicit wait for a 
> network interface when booting. Adding this device allows to skip it.

Thanks.

>> As both virt and sbsa-ref tests do "more or less" the same stuff then it
>> would be good to make common file/class and reuse it both tests by
>> adding hardware differences.
> 
> I was thinking that at the beginning, but most of the config is 
> different. The only common part is the nested guest test.
> 
> However, I didn't see any other tests that were importing functions from 
> other files, and since we want to keep those two tests in separate files 
> (to allow parallelism), the most pragmatic solution was to duplicate.

Fetching firmware on sbsa-ref is done in separate to not duplicate it. 
Which gave me idea.

> Overall, tests files should be as simple as possible, even if the price 
> is to repeat a few lines.
> If you have a cleaner solution, I'm open to implement it.

