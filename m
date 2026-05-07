Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4252CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKtUL-0008AB-J0; Thu, 07 May 2026 03:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKtUK-0008A1-5D
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKtUH-00012C-I0
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778140175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UW/FrIS9NTHqKGFRmT1HiOC3IfyJTpQnTw9hbMit0CE=;
 b=PozvQsWZJuBD5ZHRJkx4rpLoy1WGuELWG4/QUaX92tt3aH1sVxg7Na6NMQ3OVhDa0go0Mu
 hdqvjPTfQGC79nKpaRFPgxPNiTZugf/f5JN1WoMy0aCzBEUbnRpDqv/UsCxMAeaRuf0YVa
 yf2ybYuEwzo11DmZ9an5gIdm2y3LP5g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376--Vo0v0HRM9WfS4x02m3LbQ-1; Thu, 07 May 2026 03:49:33 -0400
X-MC-Unique: -Vo0v0HRM9WfS4x02m3LbQ-1
X-Mimecast-MFC-AGG-ID: -Vo0v0HRM9WfS4x02m3LbQ_1778140172
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44dad1b938fso340226f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778140172; x=1778744972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UW/FrIS9NTHqKGFRmT1HiOC3IfyJTpQnTw9hbMit0CE=;
 b=az2vXonHnUkjisTGFSvVVHwixObShuTdKUJgptiZcP8Hu3ToPCkduurRakTWByigx6
 rqtAA5HnqN0U64aA/Un5qUt3B8PIB+7heMzhLa8RtEZZ2rMcE8GLgKsCf7F/L8o+xUNF
 Y8XYvpB1XAebgiwjMm1ARiWzjaswnSDPGNljqwJ5CCcTkF0dT2oYgC1vvVIq/d/5IWf8
 Z+ZsuustEWMRVtDiFHVuiZ/zTK/TZs2RtozfCabwbtiBKjppSVorwloMTPdmFzLWsXlr
 irvJjvDipTu+zxkfibCLCjpR28kLdrJ6CYLuAfMcG8x5hsp2PtUN6F+WkbUgRf3d0VmC
 1WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778140172; x=1778744972;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UW/FrIS9NTHqKGFRmT1HiOC3IfyJTpQnTw9hbMit0CE=;
 b=CT5eYAbL8FSHvnJzx95ENzQl8xpZhWrbjOwCqXJiT4DBVSmv1xPSsCGqrXDpAMw4LB
 p7cGbLtRoFqzZ9rJrYB7hB6R/VPGYB8jrs8GzN8eL4n3k3+MNeCWfRxeKA4jNtchvx9v
 gRb0zoGsMatwl5NRf0mmKyjqPnErVcQc6bFdqowQW+e9W/Ag4aMOHmNU9McWyj+Oo+5e
 fEKcpYWHBacrtf1NNHT0mNLfidtzE4WvpCYW19K7Ek7/6rkSySuk/x0Pu0vg8GHcavY1
 6BbUDae8jJ16bU4ilQiZAMnp45JZz85gF1WoWtjHV1hfvcfeW9rW+fBk3XQpxFMEfvK5
 XThA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5Zq/E9i5mZDjWaGUlHSZK72rWrw2/lxZMJ8xNxyzrxNu/xyGBfme6cgNJB+jDwuTXvJzRUePG0Oob@nongnu.org
X-Gm-Message-State: AOJu0YxxBpPO52PYHBb3piD02pRCddq7GZ/XbYg53tgo78Dr5Jhb+J/T
 Yo2R1f5FJTdqVU6YkKbufmhRN2zDRoVDb1TS+V9e34mLgmoNgKSOIwmsVFrpb363wqFPupQqtYy
 mmHezKCBMCMmCrIBajnDjLeEp4zVb0jFcWfgBs0VQIeMuD7tG4HiSjukT
X-Gm-Gg: AeBDietqLpjfGwrwXL/ukSTqxVSxljmMNqHCGb6N5tAxGN2HdkR4/zCCCoLG0khblC5
 u3CSZR2BYmyN5V9opCY9zd20w6ztZNbR4V1s6DSy1CLcE4KnENQptJl/MvzQTgtO9Fc9lEdDN5y
 o2Z0hId1kDHhCOo6d5wKytOqOY5NppzrYx/abelGUVD83tCVNURfG37w2Q2sf+WFXgIvsPR2ByN
 6ebHg9TziKNll+5I31bJUv/twsUlE0GekbtqK1NV98OLigcpiTu9YqucJXQHOOG9TU/z9onSeYM
 KWEU+aoIdLPE9/SziOyLjMcrdhKJJYRY14GqpWijSuNKZltA4DxbI2uAcPeURIyYI9SmePDqglM
 Crxl47RDtSfW+bpi64TJf+OebTujhXDRElOp+A8xguKAjz5aWwvPEpKUmXRncvLgfTpqobOg=
X-Received: by 2002:a05:600c:8908:b0:48a:5821:5ff2 with SMTP id
 5b1f17b1804b1-48e51f24340mr74014125e9.8.1778140172265; 
 Thu, 07 May 2026 00:49:32 -0700 (PDT)
X-Received: by 2002:a05:600c:8908:b0:48a:5821:5ff2 with SMTP id
 5b1f17b1804b1-48e51f24340mr74013855e9.8.1778140171856; 
 Thu, 07 May 2026 00:49:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53907e8asm103170095e9.13.2026.05.07.00.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 00:49:31 -0700 (PDT)
Message-ID: <7fe94a3b-92b3-41d4-87d0-0171cfca13be@redhat.com>
Date: Thu, 7 May 2026 09:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] update-linux-headers.sh: add typelimits.h to portable
 header list
To: gaosong <gaosong@loongson.cn>
Cc: maobibo@loongson.cn, qemu-devel@nongnu.org, lixianglai@loongson.cn,
 chenhuacai@loongson.cn, pbonzini@redhat.com, cohuck@redhat.com,
 thuth@redhat.com, mst@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org,
 Avihai Horon <avihaih@nvidia.com>
References: <20260427070029.1059386-1-gaosong@loongson.cn>
 <20260427070029.1059386-2-gaosong@loongson.cn>
 <0a95025f-7234-ae8f-641d-cf605c5742ce@loongson.cn>
 <c36929a0-f6a0-4db8-85fb-733853171893@redhat.com>
 <161dc86d-dcb5-731a-f5d4-2a4cc3321b88@loongson.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <161dc86d-dcb5-731a-f5d4-2a4cc3321b88@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/7/26 09:45, gaosong wrote:
> 在 2026/5/7 下午2:58, Cédric Le Goater 写道:
>> On 5/7/26 08:23, gaosong wrote:
>>> Ping~
>>>
>>> 在 2026/4/27 下午3:00, Song Gao 写道:
>>>> Linux kernel introduced a new UAPI header file typelimits.h in the 7.1
>>>> development cycle (commit merged in Jan 2026). This file is required by
>>>> ethtool.h and other headers that include it.
>>>>
>>>> Since QEMU's update script only copies headers explicitly listed in the
>>>> for loop, typelimits.h was missing after updating to newer kernel
>>>> versions, causing compilation errors like:
>>>>
>>>>    fatal error: standard-headers/linux/typelimits.h: No such file or directory
>>>>
>>>> Add typelimits.h to the list of headers processed by cp_portable() to
>>>> ensure it is properly copied and sanitized into the QEMU source tree
>>>>
>>>> Cc: clg@redhat.com
>>>> Cc: pbonzini@redhat.com
>>>> Cc: cohuck@redhat.com
>>>> Cc: thuth@redhat.com
>>>> Cc: mst@redhat.com
>>>> Cc: peter.maydell@linaro.org
>>>> Cc: richard.henderson@linaro.org
>>>> Cc: philmd@linaro.org
>>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>>> ---
>>>>   scripts/update-linux-headers.sh | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
>>>> index 386d7a38e7..471f9cc71e 100755
>>>> --- a/scripts/update-linux-headers.sh
>>>> +++ b/scripts/update-linux-headers.sh
>>>> @@ -255,6 +255,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
>>>>            "$hdrdir/include/linux/vhost_types.h" \
>>>>            "$hdrdir/include/linux/vmclock-abi.h" \
>>>>            "$hdrdir/include/linux/nitro_enclaves.h" \
>>>> +         "$hdrdir/include/linux/typelimits.h" \
>>>>            "$hdrdir/include/linux/sysinfo.h"; do
>>>>       cp_portable "$i" "$output/include/standard-headers/linux"
>>>>   done
>>>
>>
>> There is one issue with this patch. The headers should be sanitized.
>>
>> See :
>>
>> https://lore.kernel.org/qemu-devel/20260505081423.28326-2-avihaih@nvidia.com
>>
> OK, I will correct it .

No need. We can take the first 2 patches of Avihai's series.

Thanks,

C.


