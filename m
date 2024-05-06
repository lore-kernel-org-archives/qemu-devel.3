Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3FEC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3vTi-0001Ik-Lk; Mon, 06 May 2024 06:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3vTc-0001HX-Lg
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:21:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3vTZ-0008FK-Ou
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:21:43 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34da04e44a2so980944f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714990899; x=1715595699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3R19P3OyRCxMOQp4ONqe+KyB+udrpxcbfQ17ucAD1/A=;
 b=q124PaCYVv1laSbLRu5Wb1lekH53iR0MSQTFly903csFT4EDcwrCqkZtJuRFcZL6ro
 9nc99JFVzeXhs6gtntm/e1+jL6VTlasrSqSLs3PuMP6BG1Xz/f0a0sx7ngz2YO1+WgeN
 Ix9MkjQYUCRf0tFVyC/8BvHh7R635PVf/6oCgzo6CwJJ9TvDNe8wh8UfqMHPK7F9VruA
 0F7QsWxEgSdsIKi02dL+89fTsAqZB1jzNg/C0QTWAOV10fx3DWnKfWBGLMiH4Qe0zsJL
 a2u2BZQl658Pn1pY0tqc5awgj/vWfh5DE4CDFOuux6q6qj6ruiQB6FdJMpH590KVV3kV
 uIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714990899; x=1715595699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3R19P3OyRCxMOQp4ONqe+KyB+udrpxcbfQ17ucAD1/A=;
 b=tIcxOCdikDPerWX7rzEAs2PobOCDfnEKSbjNAW5GZIWNnEbafOJojmf4CGkDufAyef
 8VzW3eCOKDcryrGqfdCw1kBBSTya8QE0CbY6VMsHlPeR7MhchM+MPtAzgi972wO48UhR
 zZNb+ZJvENyc3A9/ybccK9/om11G5tlRyd0x72ihwq5Th4VMZlnt3Sw2UKVaS+ZW3x3K
 JSluOvapXOKl3fWndxKYtC59pmuT/GGkIcAiFMRRff2wy2A61/eK/WIQpAwc+622Uh7V
 RN26Yg4ePDcAlWczQIbl53hoXOIP+1veXN97EVdwmX6Optt7FwYWQlQ2uM0obSkWhs28
 +AFg==
X-Gm-Message-State: AOJu0YyeK5pfgreLgQOaYy6xCLMjcbIPcbs4UarTO+rsYqIxdUY/UHO3
 r6RD5v2TWqJt+vfefiQB+wMHmDhreVwxkXSHVaklQBQ69rAvpbSObf4SWL3Rguo=
X-Google-Smtp-Source: AGHT+IF1SoDbHOXgpG8N/21hSx48uhBBIxbLFUYZmZQ6dqIA0cRCB6rMozrTycEpVZUACIKnO+CDuw==
X-Received: by 2002:a5d:4444:0:b0:34d:b284:9540 with SMTP id
 x4-20020a5d4444000000b0034db2849540mr6615328wrr.4.1714990899512; 
 Mon, 06 May 2024 03:21:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d5985000000b0034e0ff3e6dasm10304139wri.93.2024.05.06.03.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 03:21:39 -0700 (PDT)
Message-ID: <b386a0b6-9cf0-4503-85be-f7b48d90d381@linaro.org>
Date: Mon, 6 May 2024 12:21:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/17] xen: mapcache: Refactor
 xen_replace_cache_entry_unlocked
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-8-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2405011345140.497719@ubuntu-linux-20-04-desktop>
 <CAJy5ezq2PBXMXGMFORfuDVeC_t4S=9AF6b_pur9kD26fhBPhwA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJy5ezq2PBXMXGMFORfuDVeC_t4S=9AF6b_pur9kD26fhBPhwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 2/5/24 08:32, Edgar E. Iglesias wrote:
> On Wed, May 1, 2024 at 10:46 PM Stefano Stabellini
> <sstabellini@kernel.org> wrote:
>>
>> On Tue, 30 Apr 2024, Edgar E. Iglesias wrote:
>>> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>>>
>>> Add MapCache argument to xen_replace_cache_entry_unlocked in
>>> preparation for supporting multiple map caches.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>>> ---
>>>   hw/xen/xen-mapcache.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)


>>> -static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
>>> +static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
>>> +                                                 hwaddr old_phys_addr,
>>>                                                    hwaddr new_phys_addr,
>>>                                                    hwaddr size)
>>>   {
>>> @@ -578,7 +579,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
>>>           cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
>>>       }
>>>
>>> -    entry = &mapcache->entry[address_index % mapcache->nr_buckets];
>>> +    entry = &mc->entry[address_index % mc->nr_buckets];
>>>       while (entry && !(entry->paddr_index == address_index &&
>>>                         entry->size == cache_size)) {
>>>           entry = entry->next;
>>
>> There is still a global mapcache pointer in use in this function:
>>
>>    xen_remap_bucket(mapcache, entry, entry->vaddr_base,
>>
> 
> 
> Thanks! I had accidentally put the change to use mc in future patches.
> Will fix in v5.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


