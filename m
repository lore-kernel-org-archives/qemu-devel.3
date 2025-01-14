Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C992DE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXhVG-0000Yz-Ek; Tue, 14 Jan 2025 09:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXhV9-0000M7-CV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:02:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXhV7-00034c-Dk
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736863356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RpUZ+GGieafLel0Gxe4KEIbQV4ju5WGCHcCJH31DYa0=;
 b=NEOm61hbiKJ3fAI2LGn86T8irER8FCL2IV4yxh1RCv1d/uqQJcI7EgGRheZwYkXTXTf8O0
 MhVt5k4MB88PfhupfyQAhvqbetUZ+BvWMNH9bfCzJwIRVMV+NuTIhFMA++JimUq58x4VZU
 I0bVoUFxspG9WI+69b7+cJ0GODOZ5UI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-mT8X90U7O0K5oiOTns22Qg-1; Tue, 14 Jan 2025 09:02:31 -0500
X-MC-Unique: mT8X90U7O0K5oiOTns22Qg-1
X-Mimecast-MFC-AGG-ID: mT8X90U7O0K5oiOTns22Qg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so42442235e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 06:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736863350; x=1737468150;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RpUZ+GGieafLel0Gxe4KEIbQV4ju5WGCHcCJH31DYa0=;
 b=qYNT/suCXCVybmMksUx0JKY9egzBZu1ajkXtQgNZQ9NCqd6tnfQncfqmhIc/QReCof
 o7hrVQ5YoQ1PBk6hKXe+hG5qO2F2me95Xl285YVedSLMNFdyBue7KMkqSaGL1yBXV1FJ
 OsaHkRySoQb1jHbaEW6k/y5+ZKxCcACF8Zn2shk302EEHBqvOiulYzlnAjamdxDRqESW
 Eilyn8f6yEmpdlQxampwwDmH6gPyUglc9c3GDGK51eOMNh1TnOg/6t8PrwGTTvE6sp4j
 KH8hzE3nAKfLL02ysVb7HiBErglYHBb/lcTEpU2zJvdtWR9lA5LHJl/fFBwbW6g0yXit
 wNUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIKnpKTZzp/MV38AkqyLBn3eJS9cbo3McseSpRuCTKu0EjGEHmHLq+h2R5q8TIYu9D1mZ+VdzoLYlk@nongnu.org
X-Gm-Message-State: AOJu0YyuNz1mwj91huzxMB7LXr3BZYtgzUE+v+dJ02Muo/SERFVxEnTT
 XWrIpn8v72b6o4sfe9VYHobR8lV1RwppQD5C97GLwMCBrXaNugOujXCxjz64+XXG9z6PyHoTzX6
 W1A1rSTCOzUYTsbUyZwN0jro3N6azCypCOvb+m2WJ35jyYK9xcOa8
X-Gm-Gg: ASbGnct4eavV6SUP57tuOKgoq7jqVvZDlkW4EbsAinDwd9jw+ywPsihbMIX+9QahWqr
 GwJykI8h0w7FUhTNXLRQ/Ou7WVgtQe/OUgQfVHb+tyC0Rir43baq3sZUMLgsOsRwUKNJVyqZsn5
 d/HpDHOCjiibhb0bYaXPuLjl1Mi1MKTT/x4IN24iJNR5JFnAmMdRBTbnBrhB9YduuPR08X/nhyQ
 3MtD4+gihXX8ums43EAwFCsZGFRSM76amtoJ8bIQyiPi1MdNJLkxo026s5FtURl47iv8+RoVbEQ
 INTZYF3UInL7KhRLjJ6ZeK0DN9LVTK1SgYIkFo3xfMOsB8jCwca2tpTJsxi27GzLxnxOoSHfUdI
 3+r2WMaTx
X-Received: by 2002:a05:6000:2aa:b0:385:fa26:f0d9 with SMTP id
 ffacd0b85a97d-38a87086c15mr23569694f8f.0.1736863350329; 
 Tue, 14 Jan 2025 06:02:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwJyCbLnWc+0oHQBOQk9bvC/zhSOLD2Js2QRVvPEKyvrbmCH2hAWnw1bqeczeP7Zg7ICvkiA==
X-Received: by 2002:a05:6000:2aa:b0:385:fa26:f0d9 with SMTP id
 ffacd0b85a97d-38a87086c15mr23569627f8f.0.1736863349827; 
 Tue, 14 Jan 2025 06:02:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa?
 (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de.
 [2003:cb:c738:3100:8133:26cf:7877:94aa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38378csm14828197f8f.25.2025.01.14.06.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 06:02:29 -0800 (PST)
Message-ID: <2a79643f-1d9e-4122-8932-954743a18c21@redhat.com>
Date: Tue, 14 Jan 2025 15:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] system/physmem: handle hugetlb correctly in
 qemu_ram_remap()
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20250110211405.2284121-1-william.roche@oracle.com>
 <20250110211405.2284121-2-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250110211405.2284121-2-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10.01.25 22:14, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> The list of hwpoison pages used to remap the memory on reset
> is based on the backend real page size. When dealing with
> hugepages, we create a single entry for the entire page.
> 
> To correctly handle hugetlb, we must mmap(MAP_FIXED) a complete
> hugetlb page; hugetlb pages cannot be partially mapped.
> 
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---

See my comments to v4 version and my patch proposal.

-- 
Cheers,

David / dhildenb


