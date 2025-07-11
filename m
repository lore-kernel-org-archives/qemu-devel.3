Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CBAC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9xL-0008K7-T7; Fri, 11 Jul 2025 05:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ua9wp-00088c-S1
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ua9wl-0003lH-6I
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752225692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7KfMCYGHgJvSYYg9G6zQyoD/nixrh0SNXvj+yUHolu4=;
 b=SCGJPAqe1Wu7yZhu/7HiF7hHOWbE7QzAlFkrKY5wies0ykuxy/nNB+rMmiunkYUc//Nij8
 vYhn7h6l9yIcMQXtVrAATO+qXifHYFW9TjO6prkWA/6DvMZXOrQ1SxRULmAXmY8v2vIBn2
 x1Nm/KhtZR/zuBsHIbsNzIF3wW+pUjw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-0khUHrJ3PPqpiWxUBf2uvw-1; Fri, 11 Jul 2025 05:21:30 -0400
X-MC-Unique: 0khUHrJ3PPqpiWxUBf2uvw-1
X-Mimecast-MFC-AGG-ID: 0khUHrJ3PPqpiWxUBf2uvw_1752225689
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso1108878f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 02:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752225689; x=1752830489;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7KfMCYGHgJvSYYg9G6zQyoD/nixrh0SNXvj+yUHolu4=;
 b=gP42k7MYOf1Ebxrv9c6btOI5SjKTdIPJCgglLmdeC3DZ5nsaxGDwhJegpF2IvRvXdq
 baKT4S7xSE5pByR6MCwGQ02YLfpeJ6393CYRCEkvws4FbIpzMZgKhllIJ77Da++KMPZl
 JiWTqKpZhU37ki++WfC0sHr/k+Q0P58qBZceQW+fKbFuNYs2Wme2MFjOvOyIB7+OXOiy
 d7gRVUguCt9FzMm4C23PQ3nX9KPTlBYMzHgubLbFCqbFpt+gUzdCjxODANYG8qpTaIg9
 4l244s5G/KBw/mtKsAD7X8oUgxo7ApEjlK+KKUltkw35NtlwIx2idjmiXIjf5q677FG2
 xuZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAc2L9KwBNkFSoU/tlVtSVdU0c73MfCpetsMgcHoQEGwViyOsN7JBivnP6Fhb8cZqGbHopwJiHWcHG@nongnu.org
X-Gm-Message-State: AOJu0YyP9fXM+nt3hTELb/OW72yKsKLgdteM3qbfoBkwtjL/ibeyae1q
 tlnVghizgbeVnTuxl+u2dW81Ree4CLmR3ABWxQe76lgluJkFg+xAVc2NVjy98dr7nBNor117H0e
 PJ4VlAW5FJMSbUfz1sZ+AWo8NZ8onTQlWjJChw7aNKLZmdkLyu/B4BzpG
X-Gm-Gg: ASbGncs4EgXaq+Qjv7Taxu3l0OSkDPqkGtAok4S41GACfs8F3O7muhNv1Ur5xn0AJh2
 HmBn0GVC1ndkb8jG+Ymsl3I/WYa0ZkKNQ35hAE+G4UfPd+unGlYmEczbXA2lCVim9J9tKSA/r/5
 kZre9dq9MS6pyM7mGDDsvLpVzZrJTNWKKHJ30MNEDPcN4N6w7GB71TBKaQHDV1znmwjJ60W+YEd
 A46X2vGaU/c9AZ68mo9at0hRc++hV+BreDN5+FY0aeKuKeR4ct7w7Z2dOr/xFXULecg5cSecfiA
 PkPhTC6eO4I+k97cyF63ieE9tUlO8SACgxYE/l6RjsuLYdudF6X1Pkrc82BdfvJOO4HH+433KAA
 60oBtxZpbHKcUbgWoO+XMeryBbjQYI3+/rfx9rdQYEtO3lYi/AQXq4+UboXTGShkiHeQ=
X-Received: by 2002:a05:6000:43d7:b0:3a5:2ef8:34f0 with SMTP id
 ffacd0b85a97d-3b5f188e1f9mr1752260f8f.22.1752225689071; 
 Fri, 11 Jul 2025 02:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHFZ+hFNeQX2LJspwmWxY8fWpGUNybo451uhswQsagtpEvlg94Xpj/cvAdkIUtphacDbvfsA==
X-Received: by 2002:a05:6000:43d7:b0:3a5:2ef8:34f0 with SMTP id
 ffacd0b85a97d-3b5f188e1f9mr1752242f8f.22.1752225688654; 
 Fri, 11 Jul 2025 02:21:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e?
 (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de.
 [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1647sm3926711f8f.1.2025.07.11.02.21.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 02:21:28 -0700 (PDT)
Message-ID: <98db4301-294a-43f1-b2fe-3721821e0a64@redhat.com>
Date: Fri, 11 Jul 2025 11:21:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/s390x: Cleanups around s390_cpu_[un]halt()
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
References: <20250708095746.12697-1-philmd@linaro.org>
 <7834f3e5-6eb2-46ce-8061-f17d9fdf51f2@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7834f3e5-6eb2-46ce-8061-f17d9fdf51f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11.07.25 10:50, Thomas Huth wrote:
> On 08/07/2025 11.57, Philippe Mathieu-Daudé wrote:
>> Trivial cleanups around s390_cpu_[un]halt(), split of
>> a bigger series which consolidates CPUClass::[un]halt()
>> for re-use between accelerators.
>>
>> Philippe Mathieu-Daudé (4):
>>     target/s390x: Remove unused s390_cpu_[un]halt() user stubs
>>     target/s390x: Expose s390_count_running_cpus() method
>>     target/s390x: Have s390_cpu_halt() not return anything
>>     target/s390x: Extract system internal declarations to s390x-internal.h
>>
>>    target/s390x/s390x-internal.h | 231 +---------------------------------
>>    target/s390x/s390x-system.h   | 215 +++++++++++++++++++++++++++++++
>>    target/s390x/cpu-system.c     |   6 +-
>>    target/s390x/helper.c         |   4 +-
>>    4 files changed, 222 insertions(+), 234 deletions(-)
>>    create mode 100644 target/s390x/s390x-system.h
> 
> Thanks, I'll queue 1-3 for my next pull request.

For these 3:

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


