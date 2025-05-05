Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F8CC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsax-00017h-LF; Mon, 05 May 2025 05:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBsat-00016g-3G
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:58:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBsaq-0005rS-3E
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:58:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso25862765e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746439114; x=1747043914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SpZDlT5cEJosrUV6fxdzIDuupTkbtlUZTawaLOnJ0f4=;
 b=E4chFs6L0i2Z77ABBldeZh52DYTqqDQkG8mw0RYbeJ8hVoPYmtZGfMWOetTlt2s3Gx
 POj3RzB+v9OwderVOqbJJvvMQrx7UBkXK0MXSv5V+FqgnxcrOIr/UJdUmSeKZUGNfddl
 tPE4s5dI4O3+wJc4od74LbfKuHay9FtaT2Uig1TK/+rfNp8bqIzB15TteeXcf7qWN0/j
 ewlSUVEyOs5i0Sn0JKlDWbXez/aya4n8P1A0QLmevSD9qvyYl+AEwDhtW4RlMPGm4jGF
 CnPBJS+n/tJtXyZg3QMZ/hXP5rdRf150sFxerVzXQPrT28zuM22a8T9ZqWnA/MceBrtW
 Hoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746439114; x=1747043914;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SpZDlT5cEJosrUV6fxdzIDuupTkbtlUZTawaLOnJ0f4=;
 b=IBvHBo+k12CKbpLRUjn/c2wbAUqphf4W2a8D7xskRuvubM+ggCxBWnq0JXvbwQ6BDs
 XRQiWGHz6I5E35RfZ+pC20W+/EHDlsK2V+HSA9NRIAlH4DrRfXge0n149NlTEfWkQ5aM
 MLhKggFSbw0BvMmHmsRZ8hecu3j2RhRbryAWlwBW013mL8JDSyRdYs89XnoSp8zElr/A
 Flh+ZsPA7L5jK1r5Tc/JOqwem7BXSUrQC9vxTlPAoCYRLpoEmvmISrK9xQIpKAawpeaD
 paGBLlj+e+LWKYd8l+gHM5nyhstKyNSVl69pjIMhAzE3bVELOYiUB4xKxl8mKyypVUJu
 EORA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTA1DF5UF+UWkE3+iVL/5t+pG65ofIEj4wFDNyI9IY+SgiA90JGrHkc6cYl8DZkmE1cNiZE0XB0Msi@nongnu.org
X-Gm-Message-State: AOJu0Yx6OktQU6Ugi90Y1ENa+aWMmYq2ZQpuCMYmyxmAO/gnVFvVpB6u
 t7PGYKzUZUNOaZ5AEe+fUecxAfyobaT1+6NFqMPXzpuNPcvhsdqJFJ/fe9bnZL4=
X-Gm-Gg: ASbGncveKY3zj3qf2+xj0nfGQIMNofyyeW8LuVBEuU0HKzRzjf9crMYMtQWp03OoK3z
 1jhWZ06jbRP+xsgu3YFhzW6bJbsoTWufEPicJVk5uRjPmaco8lm83UFGllOd9JmwyNL6GIZ4NJH
 PTTCD4rn2wyh4KziUKC9IwusVJNQFkCYhTk+LOeYMxpmhasKitKeCpQeOH3qKev9xvZFAQVt2FR
 2grGLuqLGcsU1Ps9CDh/hJXgcdAwWajyT+eMXTZLLGhng52kTc/VJDBm9z7Uy4CPzp/NoBoYXSn
 F2X5MLP1wC6bjM58PqjV0nQH8iiXONhOsMVgKT1Dnv8Vsdp/vTYtoyTe4WsuE6YaXRI3zq6Mjap
 lc4Hxx6qgTJHQ3A5IqA==
X-Google-Smtp-Source: AGHT+IFLy6w762y1I40ejkraONKZv5a7YVh7PFtbsREBXUx1xfn35W/HcUP0ryZz7cqmsuvgtUsWvA==
X-Received: by 2002:a05:600c:698c:b0:439:8878:5029 with SMTP id
 5b1f17b1804b1-441bb8483d2mr101548555e9.2.1746439114386; 
 Mon, 05 May 2025 02:58:34 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2aed5e8sm172857945e9.16.2025.05.05.02.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:58:33 -0700 (PDT)
Message-ID: <cc6fbcae-fda6-4ad9-9f7c-b3afd471d151@linaro.org>
Date: Mon, 5 May 2025 11:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] hw/core/machine: Remove hw_compat_2_6[] array
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-7-philmd@linaro.org>
 <fd5da152-cd33-48e6-96f7-7048c631661b@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fd5da152-cd33-48e6-96f7-7048c631661b@redhat.com>
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

On 5/5/25 11:13, Thomas Huth wrote:
> On 01/05/2025 20.36, Philippe Mathieu-Daudé wrote:
>> The hw_compat_2_6[] array was only used by the pc-q35-2.6 and
>> pc-i440fx-2.6 machines, which got removed. Remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/boards.h | 3 ---
>>   hw/core/machine.c   | 8 --------
>>   2 files changed, 11 deletions(-)
> 
> It's still used in the arm virt machine which has not been removed yet?

Sorry, I forgot to mention in the cover this series consider
ARM virt-2.6 up to virt-2.12 machines removed because the
series doing that is already queued in target-arm.next:
https://lore.kernel.org/qemu-devel/20250116145944.38028-1-philmd@linaro.org/


