Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F85C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM08w-0006Sw-VW; Mon, 02 Jun 2025 04:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM08u-0006Rz-0m
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:03:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM08r-0007cv-Gw
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:03:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a374f727dbso3507888f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 01:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748851410; x=1749456210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7uJMBclFbySKF+D9SxGxlxS2224L2MCE8b24Z1Krug=;
 b=mCaLH96g7HDquajxHbR/WPdrAaCDrEyDqzPRprjmO7ffR0p37fWQ74ENyJwZH2RFk4
 pcJ+q9bYAwfCKNKXBwwpvKHz/lri1KSyPbkWiu4IWeQHDtZYdiByKtdr/tuWWGCk6RP9
 8rxe1PvhSmz+sVD5xPis8iF9eS/ihiuPlAfi1a04gngDX1vXFjK4HZHpJk1fc8KBzWFs
 8vooy/FQFotU5jevU55TVp1/XdX3H8niig3KAynSz0wXYu/tap8mr0kVBK0eyYY9pnwn
 mOA+p6UdlJRSghDR4yD7s9JBE8J+ufA30gLHI6rVnmhGbqfJWaupTLszmatkW/27ZML+
 kzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748851410; x=1749456210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T7uJMBclFbySKF+D9SxGxlxS2224L2MCE8b24Z1Krug=;
 b=meVUAjyB10D7kkBm059kZ2vtlMFwZKeusXVlpdXmHC94BclrbHTHvtJKxdyOByxSsb
 MEa5Ii1rwhvTxKT5BJ7MV2C4oTmGeL+R/OBiSSPyBoevteqxSzrOblt1GN4URYFhRSZO
 M9YakimBC9kIKz6POi1mteRyb+FrYEhCZnm2t4wB5EXwU/xf9I28lixrmf7laUoeDuda
 WSEAsl2FNIegXuqHFlDcRtCArYSWh+5wjAGz0BgjavMH2QTJ16RuGky7a3LLLRWw/exP
 wS+KDUK5kis2fdFGpt11MtH3kwffnFMQPAkPRSA2pQVaYs9l0fDEBlpuhzzgybIat2Q6
 isgQ==
X-Gm-Message-State: AOJu0YzKUEVBRg7RzRqo2i/mPs29rcr7Nnu0mzHnh/MOlEDjGDRWWc/6
 /LA5GEMQLfPLTOFdjWXnlX2riE4lYTm1wnW3tE/wh9Vx3RS0p7ERsesyNbEZyQ0IjZ4=
X-Gm-Gg: ASbGncu9nBRXv7wHK2+UOxk05XveElOFj3fBln7KAc5TkVIqO1v+6vOO8dfsbJN7IdC
 FC0TwuUp08suxZmubDV+bIZYhClxfOeSX7Sh0Y3ji1BZLxgQt9+GDUAzPGWiG4IDfX/AAIR7Frh
 uuPIp2RuL/gos9DzUN13Fofi1GDYgUK0foN3odh2/u9tUYqsXt3NIJIF9OjHHysB9yBjb+4Kv/B
 cHtFEck4wZSzhCIKLxGt2eKpuBmwCAUhnIxkAIKIQKMVZ0jxUkNPyLs4LSW+nlo09tH55oRiC/Y
 GkWze2/7yg2XO2YVuhs5HPrnic/5rpNhVNWvNVucGNfcJWt/oF5PIzIIOfASCQd+sSeeZBUT7OG
 OEL/XOuxSdc2jGeVn4aP84FQEd8/l7PowGsjR8Mlg
X-Google-Smtp-Source: AGHT+IFrFDRGQa99uaBKxP76NCATpA9YQEIxhM9ckS8dD66Q0cvChm511zWi/eRxQ1dp1vli1nlswg==
X-Received: by 2002:a05:6000:40cb:b0:3a0:b940:d479 with SMTP id
 ffacd0b85a97d-3a4f89defc9mr10357174f8f.53.1748851410242; 
 Mon, 02 Jun 2025 01:03:30 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa21e4sm114137875e9.11.2025.06.02.01.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 01:03:29 -0700 (PDT)
Message-ID: <140277c2-40a3-438f-90ef-d549ba487b75@linaro.org>
Date: Mon, 2 Jun 2025 10:03:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/19] hw/block/fdc-isa: Remove 'fallback' property
To: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-14-philmd@linaro.org>
 <6484086d-22a7-4cb6-9140-bb5251c5cf93@redhat.com>
 <bfc0d4e7-d062-4526-8969-9fc0a7a3d179@redhat.com>
 <20250530074459-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250530074459-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 30/5/25 13:45, Michael S. Tsirkin wrote:
> On Wed, May 28, 2025 at 10:30:17AM +0200, Thomas Huth wrote:
>> On 27/05/2025 19.20, Thomas Huth wrote:
>>> On 12/05/2025 10.39, Philippe Mathieu-Daudé wrote:
>>>> The "fallback" property was only used by the hw_compat_2_5[] array,
>>>> as 'fallback=144'. We removed all machines using that array, lets
>>>> remove ISA floppy drive 'fallback' property, manually setting the
>>>> default value in isabus_fdc_realize().
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>>> ---
>>>>    hw/block/fdc-isa.c | 4 +---
>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> FWIW, this needs a fixup for iotest 172:
>>>
>>>    https://gitlab.com/thuth/qemu/-/jobs/10166450223#L466


>> and I will queue this series (without the "Remove X86CPU::check_cpuid field"
>> patch as mentioned by Xiaoyao Li), unless Paolo or another x86 maintainer
>> wants to do this instead (please let me know!).
>>
>>   Thomas
> 
> No, pls go ahead.

Thanks both!


