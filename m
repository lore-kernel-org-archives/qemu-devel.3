Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1B4CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKsm4-0004Wx-90; Thu, 07 May 2026 03:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKslg-0004Mg-D7
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKsla-0008Tj-4w
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778137404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/kilG54wUv//vbTh1s1EH3zZGwN6MvjGo4PW8UDMj+4=;
 b=fwqVOpswYmw9We1cWF1/3unOpa0GfVpkCX6VRQG0PkododPpmkqVvuOMfLa0PTaoIMgOvl
 8hJ1OASWnRvwPS3+Lcab6eHwi5tl+3RtBTX3vKuVJMU0e+jPampTPxZSuUHYIHd6ftg75s
 u8DMnf3jC6+tfM3I1X/we9ZpknhGDqs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-t36chLosPlyQMSt2QPltTg-1; Thu, 07 May 2026 02:58:19 -0400
X-MC-Unique: t36chLosPlyQMSt2QPltTg-1
X-Mimecast-MFC-AGG-ID: t36chLosPlyQMSt2QPltTg_1778137098
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44696b11265so561326f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 23:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778137098; x=1778741898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/kilG54wUv//vbTh1s1EH3zZGwN6MvjGo4PW8UDMj+4=;
 b=fsH9X1NOn/xfQBpqwk1F+67YhDy4oCgtFLZGLTFpVhe6gyaMuaq5qJ2MTkXRzKGKDd
 2I2+82bMxL5QTZhuNHH9p+K0Di3Ga3Ekdxw2IfipKOdxxlT3WLJu8jAtAJuezIRu2b8t
 HxO8s+a0ttkqrpU/IR5PNVpWPAhbA3/BMsmXhZQQbLZ1lp+jOYoppUjTivDkMLqBnVkJ
 2zU0174AgYvcJi4NFmPYXtV9ItYdYki3/nsfB5nADjZKMOK/5W4c/+NTw4W/aI975W8R
 DUryvHF5lziY5LycBUPjnzvybMZDibdR6FloLm0kCLiAYViQ5mdV5Xjn/heE7yF0qY8s
 gbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778137098; x=1778741898;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kilG54wUv//vbTh1s1EH3zZGwN6MvjGo4PW8UDMj+4=;
 b=SAdlboPWc9F8koNdklFL23l/UniWtZAWzjELPvq7xA6/jk2AO58WsBnAFqmtQ2SS4k
 OOqWxtlgKTzHsadG0UnilRSGqZmZBPZB0wz7YL9rBjOytiOD2KwNSm56+fqvFBFlsBA5
 BHSNsX8ky5j9Y7tTH3oR1JyAlnfaaWWtHovqtXYWUs5/414cI4F8hFDHhH2pM3xeJOfy
 izt2rP/VrF2m+rbINdeh+yVcsK8ss4Xmos0JyBE8qpfAQsO8hFvAWesO46ZDGOrwudna
 +Ghnrx0zjNBIx9wTFix4krLOPrmbXL1zci77/82idGLu1tic8tWmUKHbCyLAKXPjjfS9
 lkVQ==
X-Gm-Message-State: AOJu0Yx4cdBAto2KYjJQQ98itWRUE77WZLhAA/ukr1kZxrbPPBJqxLO0
 FTYs7szgGfqe+DgFXxhIVFKUSwsXkzf95qXeL+2PW9zm/mwnUDYGMfm90C+TxRDxIHi+x5dLZdv
 IAv1QTRHmqNgDc7GZvJ/BWhIeuUhDufBCOGev1bDgLACGnzHWvBaWvcnD
X-Gm-Gg: AeBDietHbUgDeEn4tR1TGVG3uFFgVE0wddB79tEl4mF7hPbPP+4PHIm/wjeCEyAg4o8
 m/hzoXAtPaNoCk7iVy9rlMhBZGqXV+IJjLZRVE8WnOyejtFhKipen1klS2+C5YLdKRun6wLXu6j
 kWPOxLSUxi6/PecWKPw56SefX0QMumDQQmTr3FmtwKfQ+LG2Y9uH5dZkr8F0NoqzGo82B+Q4wML
 oyNFvnS0PFf6TgDxToZFqcRMBRzTJaI/s7RjHRh8iCilcdmyZ94tItum05rAB9UYR5+razav8EM
 iDO6dhKgaxXKKsW7kI5jn47J9PinMgYW1ba3n9kHoycnGhhFaE/9WFEC9mE2bcj3ooMVKDcVixh
 YdHVW6aGO9q1bOUag2U5MBccuNXKcoQr5W+BkBcenrD5FKY/m/TH1JIR+/kHEIOqBX5kiduOhw3
 AobXu9rw==
X-Received: by 2002:a05:6000:61e:b0:441:2335:ac3f with SMTP id
 ffacd0b85a97d-4515d4d114fmr11180309f8f.31.1778137098375; 
 Wed, 06 May 2026 23:58:18 -0700 (PDT)
X-Received: by 2002:a05:6000:61e:b0:441:2335:ac3f with SMTP id
 ffacd0b85a97d-4515d4d114fmr11180249f8f.31.1778137097863; 
 Wed, 06 May 2026 23:58:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055d381c8sm16934998f8f.33.2026.05.06.23.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 23:58:17 -0700 (PDT)
Message-ID: <c36929a0-f6a0-4db8-85fb-733853171893@redhat.com>
Date: Thu, 7 May 2026 08:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] update-linux-headers.sh: add typelimits.h to portable
 header list
To: gaosong <gaosong@loongson.cn>, maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn,
 pbonzini@redhat.com, cohuck@redhat.com, thuth@redhat.com, mst@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@linaro.org
References: <20260427070029.1059386-1-gaosong@loongson.cn>
 <20260427070029.1059386-2-gaosong@loongson.cn>
 <0a95025f-7234-ae8f-641d-cf605c5742ce@loongson.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <0a95025f-7234-ae8f-641d-cf605c5742ce@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/7/26 08:23, gaosong wrote:
> Ping~
> 
> 在 2026/4/27 下午3:00, Song Gao 写道:
>> Linux kernel introduced a new UAPI header file typelimits.h in the 7.1
>> development cycle (commit merged in Jan 2026). This file is required by
>> ethtool.h and other headers that include it.
>>
>> Since QEMU's update script only copies headers explicitly listed in the
>> for loop, typelimits.h was missing after updating to newer kernel
>> versions, causing compilation errors like:
>>
>>    fatal error: standard-headers/linux/typelimits.h: No such file or directory
>>
>> Add typelimits.h to the list of headers processed by cp_portable() to
>> ensure it is properly copied and sanitized into the QEMU source tree
>>
>> Cc: clg@redhat.com
>> Cc: pbonzini@redhat.com
>> Cc: cohuck@redhat.com
>> Cc: thuth@redhat.com
>> Cc: mst@redhat.com
>> Cc: peter.maydell@linaro.org
>> Cc: richard.henderson@linaro.org
>> Cc: philmd@linaro.org
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   scripts/update-linux-headers.sh | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
>> index 386d7a38e7..471f9cc71e 100755
>> --- a/scripts/update-linux-headers.sh
>> +++ b/scripts/update-linux-headers.sh
>> @@ -255,6 +255,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
>>            "$hdrdir/include/linux/vhost_types.h" \
>>            "$hdrdir/include/linux/vmclock-abi.h" \
>>            "$hdrdir/include/linux/nitro_enclaves.h" \
>> +         "$hdrdir/include/linux/typelimits.h" \
>>            "$hdrdir/include/linux/sysinfo.h"; do
>>       cp_portable "$i" "$output/include/standard-headers/linux"
>>   done
> 

There is one issue with this patch. The headers should be sanitized.

See :

https://lore.kernel.org/qemu-devel/20260505081423.28326-2-avihaih@nvidia.com


Thanks,

C.


