Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F84CFA478
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMLhl-0006BU-Hm; Fri, 21 Nov 2025 02:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vMLhk-0006B7-Hb
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:37:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vMLhi-0003Ua-8b
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763710632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82qnaFPBZTwgTGUTYtaBG0ApMNQ3Bp2OWvgPpLO11nw=;
 b=dTQf8eFAdr7nbZ2GirtoPZ+ESn+i33fgOehZt5sVWPLGjXbUIwWDdSkRqtDtyyk3Pe7PP9
 +mc1W0nT968dxTAD1yvKH3dJ62ferKFLHnRWsjiJm24Kx6wRGA+Jgf/RIZGjTARM0b5DgN
 6pWBEHLt1aYEN52/GWj2+420gU4rPlw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-lvuod4KZMvi1eRXrS0Nl7g-1; Fri, 21 Nov 2025 01:54:49 -0500
X-MC-Unique: lvuod4KZMvi1eRXrS0Nl7g-1
X-Mimecast-MFC-AGG-ID: lvuod4KZMvi1eRXrS0Nl7g_1763708088
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-342701608e2so1985947a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 22:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763708088; x=1764312888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=82qnaFPBZTwgTGUTYtaBG0ApMNQ3Bp2OWvgPpLO11nw=;
 b=tPdRE84zSGw0aaSvZ3AFbW1z36eJXRO7LFjqhGabW5WAFqDWRoWjOoKQFFq4wtFF+a
 yhFISX/3OD3nmKUuMQLiMSRfsU8v3RHuBufSVWwJB9Y+gA2z8OWWOfQpsRY60br7pTxm
 UrDYy5G75jdwFnBU0SxJAksqJcmxL6E93mVTX3PmFEtPwqH9dPJJ3wDGsGWwr+UZCGaC
 TeHGxjIkBSuDi6fvG6XhcsQi9rygN4iAsjiZdiLFcJD3PuVziu1KvZcbg8Z1dBfKMbcl
 r0zha9/qd6HhVd7OwSvRkuY4IgnwnBcBK6qSrVPtu0aEVv1ovlRUdxm9eJ80FOxHagUd
 cusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763708088; x=1764312888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=82qnaFPBZTwgTGUTYtaBG0ApMNQ3Bp2OWvgPpLO11nw=;
 b=gcd3juz5iZhJcwSVIAJ4GWxULdhdyjQRgxzRON3YC+rDORFIH9vmpWs89fxWyjWi6I
 2I3qMPCspyIhK5rJQXvQcTuLJhrPwgZo68dqRglrc1NG/JzhFMywLtBvjjKYaNOvuk5h
 43bsbwdPWj+tqReNgb78qzctBCfcOpcn8KzOjNd4XVBqWA9o2euRmHOtdMn6EfwdU57G
 WODVoVY2cLFQykzM8zsGTSfBg5nhL7kqnOuk5Icy50Q8tLA/OkhV/sPpBZcYgL3zh0w/
 5Y19YKffF5mfwmHEcmh3F6gqpWnz09CEHmIHSa1y1sAiz4t8CSyNbDoKWpDbcKo3I/Co
 TZ7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFSQ5svAVQFOQpqakZ8edYGnetA281tHohApnZe6/hhvjRcod2argOmB3YjxkmkwYELjiUerYI1O/y@nongnu.org
X-Gm-Message-State: AOJu0Yz79EccgaMyFyX0/CFAjun1TgIJNi0OMGDiM5/rw5qUypA/OjVL
 6zw1NYSXytNRM9R/2E8qOi0Rt9iHVGvPHlEyIPtReHrOBeQTy/7yl21tFVfExpK40z0uAbCFqCs
 59z0swHCeGiT3Cdz+jpuUGL/OinSpsZAK6Eb+3JAPBlz7QX8/0+WqyLwR
X-Gm-Gg: ASbGncutuPvy9NlWH7l+h+hurU+1iKQfA3eonKU7R3dqj7qYKRN4cv+M/Zq/ifOM76v
 zkAHyCvCC7ZWXAfIKJ1GZQwnQ3qqhXKhsIEYJRZ6DxlJ3oD/EWh1WEATqzM6RJSiuVTOKDGv7Nk
 xyr6d6QRZ77t7BGsrPgIN8Uh0oKwybjEXu+Mqg/Z/Y6xQOmxNjeNgXwPyjp/EIUcL0DYUG09gD/
 O604R4z+y6Q/EGG5wqD2Ymv4RnyMiwZE5r6ablXPR/1D2Bn0ChICskI7KpZYhUDFd2+3y8XGQxy
 Z2vkXZicJ4COh0/fUWBoucLNOePNXzkQuw3JbTtLfmGZeUNMAJ6UkO7whli4vvVdpWqPwyrlGy6
 /KxyOeTPOX24WJe68pJDYVvzFMrzQxjciKw4pHBH7DZM/TYbdLA==
X-Received: by 2002:a17:90b:1e51:b0:340:c060:4d44 with SMTP id
 98e67ed59e1d1-34733e5c442mr1575229a91.14.1763708088081; 
 Thu, 20 Nov 2025 22:54:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4IUYEXig1EOQlEkXHp2/sAMo4ljyvIGox1RbMWdChM1PHXKNPRpVPGGz82A7GskWAySTcoQ==
X-Received: by 2002:a17:90b:1e51:b0:340:c060:4d44 with SMTP id
 98e67ed59e1d1-34733e5c442mr1575196a91.14.1763708087694; 
 Thu, 20 Nov 2025 22:54:47 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34727be2320sm4317637a91.5.2025.11.20.22.54.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 22:54:47 -0800 (PST)
Message-ID: <a43d044e-51e3-4000-b5cc-3bcc14317d20@redhat.com>
Date: Fri, 21 Nov 2025 16:54:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] target/arm/kvm: Improve memory error handling
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, gengdongjiu1@gmail.com,
 mst@redhat.com, imammedo@redhat.com, armbru@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com, zhangliang5@huawei.com
References: <20251112172535.403042-1-gshan@redhat.com>
 <20251118104755.000024c8@huawei.com>
 <lghhh6xohwekbst2bbuqksiono5dgtrkyjxoypb4ahij2t2qgs@7dmgytmbiehd>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <lghhh6xohwekbst2bbuqksiono5dgtrkyjxoypb4ahij2t2qgs@7dmgytmbiehd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Mauro,

On 11/18/25 8:54 PM, Mauro Carvalho Chehab wrote:
> On Tue, Nov 18, 2025 at 10:47:55AM +0000, Jonathan Cameron wrote:
>> On Thu, 13 Nov 2025 03:25:27 +1000
>> Gavin Shan <gshan@redhat.com> wrote:
>>
>>> In the combination of 64KiB host and 4KiB guest, a problematic host
>>> page affects 16x guest pages. Those 16x guest pages are most likely
>>> owned by separate threads and accessed by the threads in parallel.
>>> It means 16x memory errors can be raised at once. However, we're
>>> unable to handle this situation because the only error source has
>>> one read acknowledgement register in current design. QEMU has to
>>> crash in the following path due to the previously delivered error
>>> isn't acknowledged by the guest on attempt to deliver another error.
>>>
>>>    kvm_vcpu_thread_fn
>>>      kvm_cpu_exec
>>>        kvm_arch_on_sigbus_vcpu
>>>          kvm_cpu_synchronize_state
>>>          acpi_ghes_memory_errors
>>>          abort
>>>
>>> This series fixes the issue by sending 16x consective CPER errors
>>> which are contained in a single GHES error block.
>>>
>>> PATCH[1-4] Increases GHES raw data maximal length from 1KiB to 4KiB
>>> PATCH[5]   Supports multiple error records in a single error block
>>> PATCH[6-7] Improves the error handling in the error delivery path
>>> PATCH[8]   Sends 16x consective CPERs in a single block if needed
>>>
>>
>> Hi Gavin,
>>
>> Just a quick head's up to say we've had some internal discussions around the
>> kernel handling of broader address masks in CPER and think it is probably
>> broken. Rectifying that may at least simplify what is needed on the QEMU side
>> of things and maybe even handle much larger blocks (2M and larger).
> 
> Btw, I just added a logic at rasdaemon to catch SIGBUS errors:
> https://github.com/mchehab/rasdaemon/pull/199
> 
> But so far, I didn't find a proper way to check such code.
> 
> Jonathan/Gavin,
> 
> Do you know a good way for us to check how the mm SEA notification
> is handled with QEMU?
> 

Sorry that I'm not familiar with rasdaemon. Could you please provide more
contexts about your question?

Thanks,
Gavin


