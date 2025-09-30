Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E07CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3UiM-00014b-1D; Tue, 30 Sep 2025 03:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3UiJ-00014D-9X
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:23:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3UiA-0006WT-WA
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:23:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so9166135e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 00:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759217022; x=1759821822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=itVX7tgCqZhn3DDR7jTxWGvfg+OOdlBPano0M6bAsBg=;
 b=SgX0PKnv8kJheO6sIWw7AYv6GEynIKCY2koHsOBFRS8CR9zuembj34GwOE1aT7Ml0D
 QGVvS48fpqP3eZZ8AVCSpWUEX5ynJoiQbCMThXUkGiSyThj0PuI8SXK+V2KuKUISWgSK
 p/SxqVmvmVzzQSXmS5KhUoftIxt5sZNEAoPGbrkBPnQKBBSTE0MBvvhnlEs6GM1VLAy2
 7XV7DPYioKMoxUwXXti7+nVS+xqD5mNrwKqrfEiLDWsItR74HCpLBTUVr8OdsAHgm0cS
 qztCXH/XstA39dgqgw5lhe62+nhpWH0OVBIKYCyzC7oA5pWj3nsue3U0NJyblhw/2ixD
 qTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759217022; x=1759821822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=itVX7tgCqZhn3DDR7jTxWGvfg+OOdlBPano0M6bAsBg=;
 b=epv3wbynWCKyWgGVY6Q4LDpzYpOdiy1XDOS5T8p5wflEwQB2xEDndnt+5vdafVowNX
 XhzFsQiGNaBsGe6sR8cKbwtN9junmyFOHYodbJjnGF9zA+kBFp70bPw97C7uPX3HXR2t
 /yIexGl6Iu26j9NddJzedrA2UBUg2aagDRjEy0YfHajD0iPVhvnfSNX7GFs9ovwjhIun
 wxScIQiHwynv7ORoF9NZv+eUv3XTSalRmri5xPydjUPivEzs70ChBI2IAhgyBnjSTd1t
 1YfghHHJ/XnObwPx3HtI3Hq6iupb5yhwEbZUDottiPWXkADzj/lCE8+ykGgq1tH+vGDM
 sDyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViNbhc5/SwZ3k3gP3JEK7zTwEJr1qZ4V6DM68cyyaOu7z6aV0HjXnl8beeP1Zte7lJ53PLAdgrDTGT@nongnu.org
X-Gm-Message-State: AOJu0YwUtdCsPl0K+yQ6hE1FM7/M2R8+K00PLUahxdDTkBFMYmYeubyX
 cbN60+4nYa+owFlQtUlgfocHMhYdcVbcnd7F/mGuwUJkwLmdmYXtdti2sdhAOl4YjSY=
X-Gm-Gg: ASbGncuXYjqHJgWzVe2UHC6RX3IDKiFna37wsGsLqXmbMnPzmUqa6idkUN+kEx30E2R
 WZh06DZlv4Jxc2CATjGgyDaIdId8CMvF0E43Hiucsz3VOP4W+OrRp6QSe/SV04pAM3veGqVnkYi
 Ot0UXikcP39T49fNIUiyf48ZmDZdaoTT1fDXbXZX5oH9x3GK8w1MHExEpVvmYP1dBiLWc4MWP37
 d4kK5E0LRxVqRsUqa5YtufRVrlBhNEFZSgMMFPAVvFiFn59Wm2TT9M33bsWbfnjgVGl75+lHeto
 lm4g1Ti+b5jeu2fHU5Hjou9lnediVplK2IR+B6/WmjlNe2Ouxkpip1CPg5LQuCNxj0TbolAxUwK
 e2/iyxKttvtRZjTF5Lgoe2OmUDDeF8WOtVjFEZN8OFx4Mwd7ZMqGyv3Wwf8Hzao9p4eerjRwbJy
 12tXNkTNFWeYZcyQ==
X-Google-Smtp-Source: AGHT+IHvY4Ey9R8Ex4kFK/h9CrX/gZMo0TkG92UrmsqICbzAXLN4hHP/QkaUH3LOu+37Fvfb480y1w==
X-Received: by 2002:a05:600c:4e4a:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-46e4b7906ecmr109670425e9.31.1759217021708; 
 Tue, 30 Sep 2025 00:23:41 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3dbcfsm44146575e9.3.2025.09.30.00.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 00:23:41 -0700 (PDT)
Message-ID: <61c31076-5330-426a-9c28-b2400bec44f6@linaro.org>
Date: Tue, 30 Sep 2025 09:23:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/17] system/physmem: Un-inline
 cpu_physical_memory_read/write()
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-s390x@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <20250930041326.6448-1-philmd@linaro.org>
 <20250930041326.6448-15-philmd@linaro.org>
 <193cd8a8-2c4c-4c2c-af22-622b74c332ee@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <193cd8a8-2c4c-4c2c-af22-622b74c332ee@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 30/9/25 07:02, Thomas Huth wrote:
> On 30/09/2025 06.13, Philippe Mathieu-Daudé wrote:
>> Un-inline cpu_physical_memory_read() and cpu_physical_memory_write().
> 
> What's the reasoning for this patch?

Remove cpu_physical_memory_rw() in the next patch without having
to inline the address_space_read/address_space_write() calls in
"exec/cpu-common.h".

Maybe better squashing both together?

> 
>   Thomas
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/cpu-common.h | 12 ++----------
>>   system/physmem.c          | 10 ++++++++++
>>   2 files changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 6c7d84aacb4..6e8cb530f6e 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -133,16 +133,8 @@ void cpu_address_space_destroy(CPUState *cpu, int 
>> asidx);
>>   void cpu_physical_memory_rw(hwaddr addr, void *buf,
>>                               hwaddr len, bool is_write);
>> -static inline void cpu_physical_memory_read(hwaddr addr,
>> -                                            void *buf, hwaddr len)
>> -{
>> -    cpu_physical_memory_rw(addr, buf, len, false);
>> -}
>> -static inline void cpu_physical_memory_write(hwaddr addr,
>> -                                             const void *buf, hwaddr 
>> len)
>> -{
>> -    cpu_physical_memory_rw(addr, (void *)buf, len, true);
>> -}
>> +void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
>> +void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr 
>> len);
>>   void *cpu_physical_memory_map(hwaddr addr,
>>                                 hwaddr *plen,
>>                                 bool is_write);
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 70b02675b93..6d6bc449376 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -3188,6 +3188,16 @@ void cpu_physical_memory_rw(hwaddr addr, void 
>> *buf,
>>                        buf, len, is_write);
>>   }
>> +void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
>> +{
>> +    cpu_physical_memory_rw(addr, buf, len, false);
>> +}
>> +
>> +void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
>> +{
>> +    cpu_physical_memory_rw(addr, (void *)buf, len, true);
>> +}
>> +
>>   /* used for ROM loading : can write in RAM and ROM */
>>   MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
>>                                       MemTxAttrs attrs,
> 


