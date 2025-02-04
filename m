Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA922C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMwV-0001od-Rl; Tue, 04 Feb 2025 12:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tfMwT-0001mq-BG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:42:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tfMwR-0008Ty-Q8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738690950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6xvLMBbIJRGPQ6vbqTTrPD/v72AS7GvH4rIHfkZKoNw=;
 b=OKqUu500ApJ9lC+1b3zLtdWp4enKK48UUL0u01S7BntIEi8rg/Y5k3+9kpAULILv1VOFI0
 OllPTX3L8B5XJUL+wD0KiZtobOy6UV3yTh271D+YNeip/N+pfxYMAxRnxBGtYcTjhmeiuw
 ZgENUaCP2JVkIlaVRtRlrnEI5GRzlDY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-UiwvF6VkMq6a3RUYrQM3Lw-1; Tue, 04 Feb 2025 12:42:28 -0500
X-MC-Unique: UiwvF6VkMq6a3RUYrQM3Lw-1
X-Mimecast-MFC-AGG-ID: UiwvF6VkMq6a3RUYrQM3Lw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38c24ac3706so4062801f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738690947; x=1739295747;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6xvLMBbIJRGPQ6vbqTTrPD/v72AS7GvH4rIHfkZKoNw=;
 b=Vg4yOZu/bkXtWQvYyeNq6qiZ3awDW/SKf+D9ryslrfVajjMB7+HzxLYYq8q/qui9lM
 ShrtBPOn1kiNfVB1/1wuftrembSwh9Onll04loRFDWVEqzXhZTdnhZtb4dCaCDTP0yxR
 +dHnKCRlUQwRAFb+/ObvSWK1gm6JR7UntC21tmWli0ZsztE3nChJEjm1de9mPDvSdxuZ
 Q8MkQIPqF1StGPjT0DGxgJwH10MnlrFn1zqjlsJLOxuOaIIQ2Rtq66OeVn1suDbax/oL
 /L/eIWSb65y/bCclZKOoqKXy7jw5XwOpgyujg+xzeCcTWJkR+TL6Mo6VicHzWsIIyqrD
 7v1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVje0xH+5eE1MiU8CmDLaG6bWl5GWBlEK8rkt3M6YwRhFDu0AEavR9cupwptzbi2iPbj6Zip7qbVn7o@nongnu.org
X-Gm-Message-State: AOJu0Yyw7Zn2dOpcnoyHQ2eodj83/8ZJjBP3EKi1wH85khe4fcp7ZJP4
 Yf+EhqGrgtZ8sbhK8OkHod1LzdGYKBc28ky36574q6mgJ6qfhnXGUxu8QA2171jJ+9Lj02Uk87Q
 x95HA+F1dzIwXVzTYlTf9B2PqQg6pgx3PmyEhYZQTs0iQ55X+gNC9
X-Gm-Gg: ASbGnctvutBMN8ciU6veOwVIl7aFPyvOM8lk9JY0xNGZL0Q5EkxC9c4iLgnpSuUyE8U
 PUKS0DHd6rAZXeFoE3Iyyyq2cFYWJGMJbdxgPkYZlwgzhU0tryq6DceOvuMKfKiyVMABXSuaVFL
 irkQYVswNrbNjAi3ngQ4vgOyM9h3UC9NLbW4c4/xSbWUwBx9czErgXe7JtW2jYP6cs3DOoC3uS9
 UyhA9jntMaeSzCYF1FNtBJr2dyg5wd8g1KBVPRd5ScFQGgCZKpsEvUr2F16yOElcBtfX/tORJtu
 rO9URTM1kumNROw4zotIZ38xhdtY3JFtIInuwxL7T7NlOGZpBxg6sIIWD6IF5TnhIPFSpBZE7RB
 Jqj2qEbuuAVqwUq2BNsNd0E6SQ0c=
X-Received: by 2002:a05:6000:1843:b0:38c:5d42:152b with SMTP id
 ffacd0b85a97d-38c5d421959mr17554953f8f.54.1738690947622; 
 Tue, 04 Feb 2025 09:42:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELvjoW4MAsrHMrqVA+MWQOCPc8cn37hi3pvEa8AmqT2Q9JgqOf2fdpvq5Mt4lYJjWB3ZC72A==
X-Received: by 2002:a05:6000:1843:b0:38c:5d42:152b with SMTP id
 ffacd0b85a97d-38c5d421959mr17554942f8f.54.1738690947283; 
 Tue, 04 Feb 2025 09:42:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c70a:300:3ae1:c3c0:cef:8413?
 (p200300cbc70a03003ae1c3c00cef8413.dip0.t-ipconnect.de.
 [2003:cb:c70a:300:3ae1:c3c0:cef:8413])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38db15f7712sm899214f8f.49.2025.02.04.09.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 09:42:26 -0800 (PST)
Message-ID: <6356ce2f-0e41-4d6d-a019-5164af502de6@redhat.com>
Date: Tue, 4 Feb 2025 18:42:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] numa: Introduce and use ram_block_notify_remap()
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?=E2=80=9CWilliam_Roche?=
 <william.roche@oracle.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-5-william.roche@oracle.com>
 <Z6JLmG8srpk9_3Jn@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z6JLmG8srpk9_3Jn@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 04.02.25 18:17, Peter Xu wrote:
> On Sat, Feb 01, 2025 at 09:57:24AM +0000, “William Roche wrote:
>> From: David Hildenbrand <david@redhat.com>
>>
>> Notify registered listeners about the remap at the end of
>> qemu_ram_remap() so e.g., a memory backend can re-apply its
>> settings correctly.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: William Roche <william.roche@oracle.com>
> 
> IIUC logically speaking we don't need a global remap notifier - here a
> per-ramblock notifier looks more reasonable, like RAMBlock.resized().

Right. Note that qemu_ram_resize() also triggers global notifiers.

> It'll change the notify path from O(N**2) to O(N).  After all, backend1's
> notifier won't care other ramblock's remap() events but only itself's.
> 
> It's not a huge deal as I expect we don't have a huge amount of ramblocks,
> but looks like this series will miss the recent pull anyway..  so let me
> comment as so on this one for consideration when respin.

... and ram remap during reboot is not particularly the fast path we 
care about (or should be caring about).

> 
> We could also merge partial of the series to fix hugetlb poisoning first,
> as this one looks like can be separately done too.

hugetlb frequently uses preallocation, and the remaining patches in this 
series make sure preallocation after remapping happens.

-- 
Cheers,

David / dhildenb


