Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93241C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCygW-0003E9-0d; Thu, 08 May 2025 06:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCygT-0003Dj-Ey
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:40:57 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCygM-0006u2-Aa
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:40:57 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso9527585ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746700848; x=1747305648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qw1ywOd02LlgNfUEzx1GDQpU1ww188fr56xFmlT5WP8=;
 b=Ixwsu5B/elqE9VbZ18BS7OpWuAjpXvWjtWWbZl6nlo7ZM/loeCNGzoh223sjZ6uMYU
 YwrK+t7qn9rEX7STNQuZkJFKz9EtZu1O5d/mUGF+TFGF6UeW8omX5kZ5jVuBzDEFRV7T
 EJp9kIDYtbKSBz2g7JImri6Kf5PelYDddrG4VMlJiEyi3ui37ElPqe4tLAWxFb/vtE9C
 mO6sUFUG9LEZ+9uMaEM9TQ2ed55df2MkRI1zEO9GpluZLbIfVEUctvdmMoFQcFdpzL4H
 9/J78S6xhQ5s56/Xizm1rahEiEwmQc9qdLbVugKFanqWEQeUlEew7bzVhE6em6hlizfQ
 QYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746700848; x=1747305648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qw1ywOd02LlgNfUEzx1GDQpU1ww188fr56xFmlT5WP8=;
 b=w/9Dv/347dmEFyq+F40Yzvxnls5P5pE1rVS1bQgGeEsohQHJ4PwVGKHMtOTevyI2yP
 ws22nYAvq9JBwe8+hmmmhdUYqSeM3R5uPitlV4oAPc4YXkdMBs/0RNxvyRxL9cU0ZYMb
 d44upH6jze1rWq0X9By0nrxpJ2GwyKYYGlxzyu9QdGoxja0Fsw5ohDBbhxO2wArxPTWn
 40gJeaPXWs//R158VsTkQXoKGvUjEVJ0wmJRX7ixQtc73yaZGuNCwXEl9O39tpTKDZwf
 qtUIJPTh36/gWkG+ftGJ/Va84MgeHrXzvJsyNMqqH9/OMtvpW39ICnC+sXsVJQSb5Qhu
 AixA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHiDwIULSD7Do3R9C9a4dZHdxgGjx26GqTvk8X/55SU/WXSwvY5qqbCy1WGcjXb4VuesAsxxrienua@nongnu.org
X-Gm-Message-State: AOJu0YzxtCXU+dBx6aHI3tkv4CVXF79forTZO0h+V5oBVFA6wL9EUxL6
 W6uDDhlPeJoSW5C0zWP4AaQTd8G2CWoPBowyHa1pK09NjAdDJK4WmacomAYINVQ=
X-Gm-Gg: ASbGncuEfPgCcSgR5GnhhaMWK1+Utl+PeGfA0R0EtrgMFbSf1dlVAvIG9+n5d0dig8g
 WopmXi3EIfkIxdZz9DizrOMFOvR42U79wd+F+vcZH7wv9eUbVzuQzsiktIZtEc9u3zn1jcPo4+y
 uEJto+p/bXFiX+wZwEnZsIdW2XRwU1DDZ2cFQcsG7Vs49pWNOyJnXbHaZnQjdMp+tdO3WUCqTSS
 Zrt/diwZ9H2wMtCw3GfgP4U9vYn6onS/rg380MAnm9LOOBv7XS09F3M5U4tXCF1lpLhSyhPaCTs
 PxdaNPTbVe00Q6XbWR+5guGJai5E0nx+ga5ptVx12VXTiovwLaMSZd4Htt4UsgFfXp1v0nJPl7O
 cdKrukWrd
X-Google-Smtp-Source: AGHT+IGB4hpADJxoItFehGygvwNmLK8hx0NyKnNukqXpF6PqwMsF+LhL+F+GIcah1jYycI+SEX1XJw==
X-Received: by 2002:a17:903:3bcb:b0:220:ec62:7dc8 with SMTP id
 d9443c01a7336-22e85614060mr39008635ad.2.1746700847872; 
 Thu, 08 May 2025 03:40:47 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151eb171sm109017625ad.102.2025.05.08.03.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 03:40:47 -0700 (PDT)
Message-ID: <1bd065b9-32ff-46d9-8131-b06e75017243@linaro.org>
Date: Thu, 8 May 2025 12:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/19] hw/i386/pc: Remove pc_compat_2_7[] array
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-13-philmd@linaro.org>
 <2e2f4b39-d7f1-4817-947f-106558c1621c@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2e2f4b39-d7f1-4817-947f-106558c1621c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
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

Hi Thomas,

On 8/5/25 09:55, Thomas Huth wrote:
> On 02/05/2025 20.56, Philippe Mathieu-Daudé wrote:
>> The pc_compat_2_7[] array was only used by the pc-q35-2.7
>> and pc-i440fx-2.7 machines, which got removed. Remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   include/hw/i386/pc.h |  3 ---
>>   hw/i386/pc.c         | 10 ----------
>>   2 files changed, 13 deletions(-)
>>
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 4fb2033bc54..319ec82f709 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -289,9 +289,6 @@ extern const size_t pc_compat_2_9_len;
>>   extern GlobalProperty pc_compat_2_8[];
>>   extern const size_t pc_compat_2_8_len;
>> -extern GlobalProperty pc_compat_2_7[];
>> -extern const size_t pc_compat_2_7_len;
>> -
>>   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>>       static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>>                                                    const void *data) \
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 7573b880905..ee7095c89a8 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -241,16 +241,6 @@ GlobalProperty pc_compat_2_8[] = {
>>   };
>>   const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
>> -GlobalProperty pc_compat_2_7[] = {
>> -    { TYPE_X86_CPU, "l3-cache", "off" },
>> -    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
>> -    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
>> -    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
>> -    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
>> -    { "isa-pcspk", "migrate", "off" },
>> -};
>> -const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
> 
> I'd really appreciate if you could provide clean-up patches for 
> TYPE_X86_CPU, too. Otherwise I'm pretty sure we'll forget that there is 
> some clean up possibility here.

Well TBH it is too exhausting to keep rebasing these patches without
feedback from maintainers. I'll respin a v4 with Zhao and your comments
addressed but without touching the TYPE_X86_CPU properties. If
maintainers prefer to remove dead code in one go -- something I
certainly understand from a maintainer PoV -- I'll let someone else
do it, taking over my series.

> Anyway, for this patch here:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thank you for your support with these series.

Regards,

Phil.


