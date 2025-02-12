Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CD0C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiB9C-0006lm-KK; Wed, 12 Feb 2025 06:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB97-0006ju-4x
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:43:15 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB92-0001gR-PP
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:43:12 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dd93a4e8eso3174796f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739360586; x=1739965386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HNvaHR+OX5hzwcK2kevMbzberbz0WirV91y8Qp2ZirA=;
 b=xUdD/7NmPM5k8vId2CZh7+Byw+WjFifVktR3tr2Fe+hDhgKwFD1Y0ep+JfenbFwedq
 UWLYyas0Yg7GexqzNTnT5q9pkELkFWl9wFPlffECkIzek9TDJD0nUmnvZAJ2NFZmDfSi
 YpLsw0iDOjvGgX6APwGjwsqZIF+ig57vEmYsXyTdYeE9j9wFgq4iD7cU6EisonoiIaYh
 8SSv7X2flLSO1KvSQE1d3tUoIfzyDWMAbvBM80f6rzD3DrUettjYrazjlKFj+fCn7iuP
 FwKcXglIoNWZ+uCUDW96Zsl9WNIachhU+66Dr5kwnz+rUa+WF2aED9QXGrTborne4A4u
 5byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360586; x=1739965386;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HNvaHR+OX5hzwcK2kevMbzberbz0WirV91y8Qp2ZirA=;
 b=aMq6J2QBgWFCsgTIZQmqM8ATur7gKTq6lrpJW1TL4Q250zhw4JC3FaKtfF+t+QBVmi
 6K87hum2b0o5AvGahWAe8ZqvZMkKWUQFfJvHNus3SkNVImoJNrb6C9KuVtyU4/CI05P0
 L89ExjZdCi7pxGoOEnX+prN5tmrIIPZDazK+qDI3Jy5PV2AaqGroeoyAMdZujyB0r43j
 Ww3JXKBxWLorTYbo5UH1osLErLLYTiMfVmQXkW49PA4gE0TXFnyNSzHTFI3mrCQmVp1N
 Rc1a8yY4kbKy7cH2sb5CbDbN/9NyzLuAZbYY/K0EHO2Ff6JW/kDyDbN4jtZhgEb0tPdY
 KgKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQUKFm8IKKs950RvlCguORt2iVGVXHcACm+GieSSqrtb/cZ7RAckcZySCvE6B5MRqzIHgB5gZD/5u7@nongnu.org
X-Gm-Message-State: AOJu0YyJHtRVMQwA2E8XgC2ZRtR46cVbPdaZCgp/v22uU21oW0i8Jx+n
 gTgW92pxWLXo0LZDru+N+92zqGq4lPUkcgDODqnaIjhGKqHgq6K1o5VVSXrD+hQ=
X-Gm-Gg: ASbGncuWv3AAJvOKuXpUDgvzD5jZCVOl3nXS6xWT2Hh5wuBZ0lWgDSpp4BuAE1KXW+P
 TBMaiknv3I0n1Zf0Qff9XKR0B/RgzOpfcxPlfjp6j6Fn/mCGVdPA1faaSTp+BBZrAlS9gAsbM5F
 53pXKvUsZIp7hn2vQynfoY3q2i1P06QoQHuoexg0Mz3VkYz8VAv3rVO6+lfSYlBRmW4WrermmDP
 2/kVOCorCyFM2fQSfy8ValELzKhI5lE/mNScX8m+5rvhsCvRhMLEyPkiYAtEpdSOflMn1IBAzHJ
 JrK/pOugcyMHD1lzNoYQPhwOhihkW4wBz985z0wCOlkkHZASSjGCH2TWElQ=
X-Google-Smtp-Source: AGHT+IEMBcSCcsZhWx2InouLyu9q6uRY5nJZtl70/pd9jsw9H4JeLLfRhSGZIkY7z/35vSjDursIxw==
X-Received: by 2002:a5d:47c5:0:b0:38e:65db:517d with SMTP id
 ffacd0b85a97d-38e65db549amr1971930f8f.40.1739360586583; 
 Wed, 12 Feb 2025 03:43:06 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd07fa80csm13080296f8f.13.2025.02.12.03.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 03:43:06 -0800 (PST)
Message-ID: <50ba4e4b-4124-46bb-bb84-4758ce9c5e66@linaro.org>
Date: Wed, 12 Feb 2025 12:43:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] hw/qdev-properties-system: Introduce EndianMode
 QAPI enum
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-2-philmd@linaro.org>
 <cb828dd8-25f6-47c6-9ac7-cae5b0d0932e@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cb828dd8-25f6-47c6-9ac7-cae5b0d0932e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 12/2/25 12:37, Thomas Huth wrote:
> On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
>> Introduce the EndianMode type and the DEFINE_PROP_ENDIAN() macros.
>> Endianness can be BIG, LITTLE or unspecified (default).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   qapi/common.json                    | 16 ++++++++++++++++
>>   include/hw/qdev-properties-system.h |  7 +++++++
>>   hw/core/qdev-properties-system.c    | 11 +++++++++++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/qapi/common.json b/qapi/common.json
>> index 6ffc7a37890..217feaaf683 100644
>> --- a/qapi/common.json
>> +++ b/qapi/common.json
>> @@ -212,3 +212,19 @@
>>   ##
>>   { 'struct': 'HumanReadableText',
>>     'data': { 'human-readable-text': 'str' } }
>> +
>> +##
>> +# @EndianMode:
>> +#
>> +# An enumeration of three options: little, big, and unspecified
>> +#
>> +# @little: Little endianness
>> +#
>> +# @big: Big endianness
>> +#
>> +# @unspecified: Endianness not specified
>> +#
>> +# Since: 10.0
>> +##
>> +{ 'enum': 'EndianMode',
>> +  'data': [ 'little', 'big', 'unspecified' ] }
> 
> Should 'unspecified' come first? ... so that it gets the value 0, i.e. 
> when someone forgets to properly initialize a related variable, the 
> chances are higher that it ends up as "unspecified" than as "little" ?

Hmm but then in this series the dual-endianness regions are defined as:

+static const MemoryRegionOps pic_ops[2] = {
+    [0 ... 1] = {
+        .read = pic_read,
+        .write = pic_write,
+        .endianness = DEVICE_BIG_ENDIAN,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            /*
+             * All XPS INTC registers are accessed through the PLB 
interface.
+             * The base address for these registers is provided by the
+             * configuration parameter, C_BASEADDR. Each register is 32 
bits
+             * although some bits may be unused and is accessed on a 4-byte
+             * boundary offset from the base address.
+             */
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
      },
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
+    [ENDIAN_MODE_BIG].endianness = DEVICE_BIG_ENDIAN,
+    [ENDIAN_MODE_LITTLE].endianness = DEVICE_LITTLE_ENDIAN,
  };

We could declare the array using the confusing __MAX definition
(at the price of wasting the ENDIAN_MODE_UNSPECIFIED entry) as:

static const MemoryRegionOps pic_ops[ENDIAN_MODE__MAX - 1] { }

WDYT?

> Apart from that:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks!

