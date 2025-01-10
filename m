Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CDCE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 04:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW6rR-0005YD-6v; Thu, 09 Jan 2025 23:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tW6rP-0005Xw-As
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 23:43:03 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tW6rL-0007c4-BA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 23:43:02 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2165cb60719so28923485ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 20:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736484176; x=1737088976;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oHzOBSna1JN8fAYfqSSf7voX3jAxT+Nhk1iapYTsC2o=;
 b=qrViRcmRR+ZpCf/b7DiWStlbPhBZbd3A6qFNAFqFW5IR8R9sOxbOmztAXKZbTbKINx
 V+F/J0HOvhYoVYqL8Nyd7QCZFJ8k6hSywE7C7qCOpr+P/ceYKpQTNJGKZxK0RrzvOVqQ
 JnV3xOXhg1SXhBnGjjzJpcZyBK3jKzvZLk04blTVrE2ABOYphSIGyBOcXEUE7QcHTeKh
 m+i5SBZQjUUfGN1GbXlk6YANkWnhzObn3NCPq9d2AWsvucreJkubyVRCn0Rxr81WjQiw
 JHdokDAiz+eWJxomCubDj+P2tDTCYdkSSWYF9mwTjfUUEaIwxTQ66dK5/9bWBYI6shL+
 vQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736484176; x=1737088976;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHzOBSna1JN8fAYfqSSf7voX3jAxT+Nhk1iapYTsC2o=;
 b=Evx3yvzb6FyFTdMwBVKRqgSl97srOZC3VXMZ2tCyOaSWfLCL14uUQgRWThYVfjWnqM
 diRSqpHEXOhgOpltmknXoikolSVewdo8hzV7fJEL2UW6P15kGsKOHtfEvgnvBVC/t6lP
 tSQ5vP9HDLXvUv4d9MBRI1O6+OfMprQvS/8OtA8lH+e7H+jmqyM6gcjaAYse5p1317ct
 Okbpu9A8U46u67wXfCC2u9bw2QSVc9wCd+K92dPKvadcU+S0yYF8yGtNRT4iTpKKaDv7
 IqgUxKVsWWDoNRbCO3W+A2PJJWUtgxY3RDTPR9EfJYAIAM3tqEm+vYOH+949T1Uz3qOJ
 FC2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9dzP3ix5wZNac5NywuOImiyHi1+LT8A37+rHInMv4l4TbMB/tZGAfFZ7PT7pA/sBG+fMunGT5TO7y@nongnu.org
X-Gm-Message-State: AOJu0YxOvc4TKSiRw2L8+Dl4iJ7XZHdcxiei/T+5i5DlPPEA5KWpMl7X
 rCQUMnaIjlCBQPdUO6oGcUnetthiUiPGzYSzXCQENkFQ5YJTBSLgxx7NKbZHu60=
X-Gm-Gg: ASbGncuukX8oHJRPjem3x7L+vcQUKp3s6EKA+FWX1pSa9qJIArOYtzJutikMtAepAHp
 Ym67YbyZn+jrNNj9OMtAXrd4RLPhaMWDWO0wyvI7bNECT5RHvUt9jKqAIo9Y/vbHNQcEumMQDYH
 NHsgUBZ44h/09cR06yxKQFpgLz4zmS0UCjGZyJaKyRpBpC7CLBIip+kJxySe6HGVHxnvsR40gyJ
 C9PA9gNpLAxCtXFdlAZIrdhrrOLcAqjgeuEFOAVIuF0hSPjOs/tIKw9YhikRpm/uxY=
X-Google-Smtp-Source: AGHT+IGolfFHoM/P1GHekTz80Dmgbvaw1/OfTE68nGFS2RQWjnYUreuvK8TIGi22YXv6YL44RyeTJQ==
X-Received: by 2002:a17:902:d481:b0:212:6187:6a76 with SMTP id
 d9443c01a7336-21a83f4d7c8mr143287025ad.14.1736484175982; 
 Thu, 09 Jan 2025 20:42:55 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f261bf1sm5752085ad.251.2025.01.09.20.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 20:42:55 -0800 (PST)
Message-ID: <f9d724e1-25c8-4fe8-bb95-591830e5ad56@daynix.com>
Date: Fri, 10 Jan 2025 13:42:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] virtio: Convert feature properties to OnOffAuto
To: Markus Armbruster <armbru@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, qemu-devel@nongnu.org
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <87msg09mhm.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87msg09mhm.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

On 2025/01/09 21:53, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> This series was spun off from:
>> "[PATCH 0/3] virtio-net: Convert feature properties to OnOffAuto"
>> (https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/)
>>
>> Some features are not always available with vhost. Legacy features are
>> not available with vp_vdpa in particular. virtio devices used to disable
>> them when not available even if the corresponding properties were
>> explicitly set to "on".
>>
>> QEMU already has OnOffAuto type, which includes the "auto" value to let
>> it automatically decide the effective value. Convert feature properties
>> to OnOffAuto and set them "auto" by default to utilize it. This allows
>> QEMU to report an error if they are set "on" and the corresponding
>> features are not available.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> How is this related to "[PATCH v2 0/4] hw/pci: Convert rom_bar into
> OnOffAuto"?
> https://lore.kernel.org/all/20240714-rombar-v2-0-af1504ef55de@daynix.com/
 >

They are orthogonal. "[PATCH v2 0/4] hw/pci: Convert rom_bar into
OnOffAuto" was also abandoned in favor of "[PATCH v19 13/14] hw/pci: Use 
-1 as the default value for rombar".
https://lore.kernel.org/r/20250109-reuse-v19-13-f541e82ca5f7@daynix.com

