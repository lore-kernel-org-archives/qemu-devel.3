Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2A0C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbq1-0001jY-HD; Tue, 16 Jul 2024 02:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTbpv-0001hC-Cd
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:38:56 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTbpp-0005Uz-SY
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:38:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-367818349a0so2988286f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721111928; x=1721716728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lu06PX3rZ2SdYhrTE2X/kjnlfR4Gujd2mIJUB/3xjDM=;
 b=rqyNo52LnrXIP+brxrW2HwBUUKGdFc39WbZg5InQk33BiVEd0RBIkPWNnv37y+4RWD
 w85I0ck728nnvTU/T3cfXpihacHd6uax1NrZsQmS2C3/yuVZ765psvahce07pCWOIdto
 S0nmVk4n7bF4ImtGz9MLlYqnmGYc16Fd4TeY15iL2Ihbws8xgiLOqx0mgff0SrTKB/sJ
 r7+veJ+lcnXjB/ewoccFdxUH2FVEW3SJip6GMCTLa+decgVWAe84p22FcpoTSxU/9R/V
 jbRRQAoInOKEvpRObLaXbNH4oCeeT15W6bpO6toC1O/wZuJ+6PV3oc8mQGs8tKF48WDI
 9jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721111928; x=1721716728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lu06PX3rZ2SdYhrTE2X/kjnlfR4Gujd2mIJUB/3xjDM=;
 b=rEEJ+AgWVGf2TckwZFpoh7WbhA+4jOj9kT6df9hKGJVtPnNJ4sDNes0v5FPj7Ucd8e
 pZUFMvhmdYKzltjI1ykJKSokDXmSMRwudh/UTBQJvPpi9E5JvQEP8J1fLH5fDSLhtFt6
 1dCsKaTQDtiu+gdIT7DpP6pew1Rg+5Bt117KDQtbsoP8U/JCGEqQkbalqDnWR9Iths09
 KaLUG3W/wByh0RMGYBFBNrtb4mL0cDZ340of2vhuyIy7sIn7Hc8+atl2IqB3RsIixe/2
 HrGl/HkkhdOIMBZI560VC3hqbPQvI9LW/Eo+mpn2KvPLwP3iPo+glhWpjnj48SSVMht1
 G+/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvIy6/Ez8zawwEHmVBHrPO1rM8cjS0i6V2La0P59zWpCIyIWQOU3eeCrbBvlf+H+rwHGnrg7DHfa91dt7AkoNVQWme58c=
X-Gm-Message-State: AOJu0YxBq0GR91nldqoXWam9rDrfYIpFcDfHmDcRrzRv5IbW2iYIsl0S
 nexAQ+lyKYhas72RfFZ0KoZMVeZi6PVxrlbbj0oFYWvyjRixIx2Gu2VfUbtBmYk=
X-Google-Smtp-Source: AGHT+IG2E/XPoVt7aEfb0QW1ucPuywd3O0iuM4/XOUKIoyTj/7MNf9KsG2G2W5Zty+q3uV4AKHYceQ==
X-Received: by 2002:a5d:64a9:0:b0:367:8c65:3c9 with SMTP id
 ffacd0b85a97d-368260955eamr926384f8f.2.1721111927644; 
 Mon, 15 Jul 2024 23:38:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db047f0sm8076021f8f.99.2024.07.15.23.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 23:38:47 -0700 (PDT)
Message-ID: <a7087230-9fc6-4ab4-b35c-d3df032d16df@linaro.org>
Date: Tue, 16 Jul 2024 08:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hw/display/apple-gfx
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, agraf@csgraf.de, graf@amazon.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org, lists@philjordan.eu
References: <20240715210705.32365-1-phil@philjordan.eu>
 <eca02ec3-e2f2-4994-baf5-b86908fa0418@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <eca02ec3-e2f2-4994-baf5-b86908fa0418@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 16/7/24 08:07, Akihiko Odaki wrote:
> On 2024/07/16 6:06, Phil Dennis-Jordan wrote:
>> Date: Mon, 15 Jul 2024 21:07:12 +0200
>> Subject: [PATCH 00/26] hw/display/apple-gfx: New macOS PV Graphics device
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> This sequence of patches integrates the paravirtualised graphics device
>> implemented by macOS's ParavirtualizedGraphics.Framework into Qemu.
>> Combined with the guest drivers which ship with macOS versions 11 and up,
>> this allows the guest OS to use the host's GPU for hardware accelerated
>> 3D graphics, GPGPU compute (both using the 'Metal' graphics API), and
>> window compositing.


> Hi,
> 
> Thanks for continuing his effort.

Yes!

> Please submit a patch series that includes his patches. Please also 
> merge fixes for his patches into them. This saves the effort to review 
> the obsolete code and keeps git bisect working.

Should be as easy as squashing patches 1-6, right?


