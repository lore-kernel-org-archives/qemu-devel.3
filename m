Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF523C5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNUdB-0005Sq-Sg; Fri, 06 Jun 2025 06:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNUd9-0005ST-Mw
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:48:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNUd7-00063I-U0
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:48:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so964726f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749206936; x=1749811736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=po23SzpoypXfwQE17VJFAQBRB3fwLG4/svDxgjPhrJ0=;
 b=PQoUZvr1uxaVNaIy/rFa0T7uYPA66x26+V8svVNDUR+Tum6yBR8X4xvYxluIFDOen3
 9PAomQU4llAHBrAbQ9sxzVevpRFdKPTswykSF/TzyFMTIYbwl3c8hAmbUGAcvWq8YfAk
 x8mmWWPC96tvMlRYJhRXzg29JxVCAt/NteVEki4whNaUwrZcSPqHT2ZyjHglG/7+DaHD
 7NBC/mbeDQHAK7ND85cq4OFgTibWF3n45R+dmxdlZpKL2yFLCw3gszyZ1VtzDfwhvooi
 eSZTwzNd0KoEC2pwP3HQXJXbQUygrh1yXvKtzJpDVkLqsRs5GTNRiWtmQiIE1ruHBbOp
 YccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749206936; x=1749811736;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=po23SzpoypXfwQE17VJFAQBRB3fwLG4/svDxgjPhrJ0=;
 b=fYzsCS2+xRlUfqnDlGri8e2nvm6ppVPebsUi8JLbGl1WDe+THfp0IDUDcWMZoXDflY
 ZJ/T+XKcNWAxIjfPp0FXr8mst0fBw/i/XFCaNZbrv8+OfSCfPbSEPT5q1O41Ija8Oorc
 /lwGLEMDp1tuxtwbs0PyH27axFGE8GwzuoPcynVvwYcc38lzRlN1+hwcPtAEIdeJVaPg
 IeMGY0VUipKOltdHoSk2E0c9/f5yG8P1BylLPiSiQDbnLl7UruzzaWgJ7B0UpkuIY2Dg
 ubEh9sKqOz4aD9Rp1zjzREFMS+edUwnibUK1u8y2gExvkmFoLX9WKX3KY0yu+pVoo50k
 JeaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBL/LGFM9dsvrmh+pW+MSv0GhZd5mSepqAlv6ytMivHi1/vzBZHi2VsBmU8Q7y+VTqu+ViF33Czrq6@nongnu.org
X-Gm-Message-State: AOJu0YxPjtQ37Help9c+flqkHOTms68hfdgbhQmafSTgXdlPZEHVHHvS
 IkBG4hxi4E9PTUUHJDuWoYwc8NqPotijRXi1Q5+lxPqvDnleOX06jmaqaZlT7GSpCkM=
X-Gm-Gg: ASbGnctkh7KnZ+YIY8BMj1dsRNPYexOEZ7xjuHngW+lXufIKSgzbPrOPr/sURdb/xyl
 XAvqNL2M/ovvBUrPkNvbhoGNhO7FXj0f/dR/f88w9EjpaPjR2jDim4sSpZjM8nffIXbxbnRqMwL
 fmX2wwMpv4eNTcUkcXt92S0FQ8wp2aWnbrFYYYclgqSZKPjkC3KIiDNJ5ocXJkQeEzCqvajUt+b
 trrcjK/qThx9zZV6FTMjRqGTM8yIO2q4hSENfUbqlIgwyY8XXJR5lPDhNu/wX0ugAucJHSW2SUr
 gIb8ig8Fl3AdeqnagowpH0rOKrxYdIu/BMNikAQOUnvhDUT3ozZll+hBiyHXxAQr2/xJhWCZqGF
 zg9yof6Xe3Iasy1LEjuE=
X-Google-Smtp-Source: AGHT+IHuetT+INxo3ey99gzgyhvg6yfKyxKkabVUC3hFRbZTtwryLZPXBiuOdIToo/igHChGQuT3Cw==
X-Received: by 2002:a05:6000:4210:b0:3a5:2182:bd17 with SMTP id
 ffacd0b85a97d-3a53189b57amr2254350f8f.19.1749206935635; 
 Fri, 06 Jun 2025 03:48:55 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244f04dsm1493083f8f.73.2025.06.06.03.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 03:48:55 -0700 (PDT)
Message-ID: <10e43884-d147-4031-bcec-0a7c528e3103@linaro.org>
Date: Fri, 6 Jun 2025 12:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] hw/char/sh_serial: Remove dummy definition of
 SH_SERIAL class
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com, armbru@redhat.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20250606092406.229833-1-zhenzhong.duan@intel.com>
 <20250606092406.229833-5-zhenzhong.duan@intel.com>
 <22f73acc-bc5e-4cf5-bbd9-c2c94bec9d33@linaro.org>
Content-Language: en-US
In-Reply-To: <22f73acc-bc5e-4cf5-bbd9-c2c94bec9d33@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 6/6/25 12:40, Philippe Mathieu-Daudé wrote:
> On 6/6/25 11:24, Zhenzhong Duan wrote:
>> SH_SERIAL is declared with OBJECT_DECLARE_SIMPLE_TYPE but defined with
>> OBJECT_DEFINE_TYPE, SHSerialStateClass is also a dummy class which
>> missed its parent.
>>
>> Change to use OBJECT_DEFINE_SIMPLE_TYPE and remove SHSerialStateClass.
>>
>> Closes: https://lists.gnu.org/archive/html/qemu-devel/2025-06/ 
>> msg00586.html
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/char/sh_serial.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
>> index 6abd80386f..8ccc2234ba 100644
>> --- a/hw/char/sh_serial.c
>> +++ b/hw/char/sh_serial.c
>> @@ -78,9 +78,7 @@ struct SHSerialState {
>>       qemu_irq bri;
>>   };
>> -typedef struct {} SHSerialStateClass;
>> -
>> -OBJECT_DEFINE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
>> +OBJECT_DEFINE_SIMPLE_TYPE(SHSerialState, sh_serial, SH_SERIAL, 
>> SYS_BUS_DEVICE)
> 
> I'm surprised this is the first time we use OBJECT_DEFINE_SIMPLE_TYPE.

Actually I already posted a patch cleaning that...:

https://lore.kernel.org/qemu-devel/20250124175053.74461-1-philmd@linaro.org/

Also I now notice I never replied to Peter's questions. I'll and
queue the series, along with yours.

Regards,

Phil.

