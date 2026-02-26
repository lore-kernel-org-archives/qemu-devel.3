Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C4CFC5910
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYQF-0001H6-HX; Thu, 26 Feb 2026 05:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vvYQD-0001Gg-Dq
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:16:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vvYQB-00038a-5K
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772100997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9oWCswLb5L7ptghwnTCvOR8gC3pEp5Uc3EP+QJdSQO8=;
 b=EYJVcRiD8EwQJ6n2HaxLG+f0iUJr0Y7vv5oA3bKIk+kz4lMjr6g7do8hCaKASSk/dZFcr0
 aeGhYccPveJu4cxOKT8SSNiQSQPhG9JgT+68v55ufyN9sjAqGGf+1BJqwKd5Dp/xBSZ++F
 zUXOBkkamnEXMNwhxnQLvNsLJhZZGUw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-7oSN0mCFMnaUUc39MbIuUA-1; Thu, 26 Feb 2026 05:16:35 -0500
X-MC-Unique: 7oSN0mCFMnaUUc39MbIuUA-1
X-Mimecast-MFC-AGG-ID: 7oSN0mCFMnaUUc39MbIuUA_1772100995
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso7428155e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 02:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772100994; x=1772705794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9oWCswLb5L7ptghwnTCvOR8gC3pEp5Uc3EP+QJdSQO8=;
 b=tEE/7dJH9XmR6C2ZG24kV9TpybY9AxwnD3qqPCDnsDIob/vCZZwOL5JDTY3kZ81QoX
 ZecyMaYWGkDlh1oK0slBBWlGqu+PmtETab3boDT9spUNdXdWDCBQ1PozS/dajrDRM43C
 onEoQDt/E5o59VSl0/LW1Jyw7GPkf6ZUCl2JgWgDoFAv/4CJVVSjB9Q2ykJWY0Cuu/Yu
 /ayS/o5cIBQRuowq0xbHFi1iSCHqPfgt1rpz80MPx++1IUxOWgoC+g+/lxPCZYUiSyue
 BPNxlg+hJIqrLGu06KYanp3ZaWkB9waTHnGEKYRzQ3lkq9xQgs/L5Trb6LQMI89BoPSN
 eAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772100994; x=1772705794;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oWCswLb5L7ptghwnTCvOR8gC3pEp5Uc3EP+QJdSQO8=;
 b=iHI+exLzz6zXFjPbOUysKylyCVJOSznM6UXEQzIUZ28dthyNgde/H4VgLSo2hA6xXr
 b/R3XpeyFo2BcA+JUlus5laMtiEQEn/cdErVDEDsVyDPj4qXjrjM1NA4hvJxm6bhr7OW
 vQLEzUBrvkNkDS7Aif09Lc/KClC1kYB+LR/8nj+SFW/nuQZJO2ZzwvkcA1H0gdEIg9p/
 0Qic8nEXrWn+O1P/rKF6EFZJ0Lw1BGZDqxOfQ0enrUJxOi/yLEpOZ/teswgvIMobKFdG
 8T+OuXrREAuNf3VBua6iuLqynTMUIedKZa//5YElBFZvqBpzE2wPL6/2Psw/PixK27te
 lmkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyARnGtlyyIGUmJ5mTVJKCCROJPykQsOR796lx3xvzYLJb/ygFWwPE0Znszklya5V27zAhA3mTogYg@nongnu.org
X-Gm-Message-State: AOJu0Yyn0Ucfn3pQCUR5EwvKerLWx0povCMqu0tRtq5a1TtCgixabzUs
 T6Zd+dAcVlkHU9lzUr4ena2mAcvkErh1uIJ7o2jR3zl03AM/XFm+VeyB6aVSkie5BenhgrG2KgW
 XLBgs7xT8igbDDyrUFC1IVkHUg9ilsBH7CDyxs8+hrOh1LDCdH3QZywao
X-Gm-Gg: ATEYQzx1MULLu2p8WxVmXS9inv2OjcdW5TaO722KaOabPyg4pmkT8u/aOTu3doM/Su1
 GPCd+H6U4Ca77YCCUqmUtZjHI+UbhNY0aJRRBl3Wsn0xjEeieUb3KGG6aUOlDmmT6r67A8qsOsM
 2RQVR5LNvsITQLv1Pr+cNvDgellGg0iPZV9rIhqEOgwGpg1TcQ3jjIdFNEXJ79UTjtoIfDoaZNK
 TEJc6oZ37OJBsWBDhfFK65I+7Ak44TmMa9Api7Ynvcauf3V4E+qO56NOmeQNgeh3HYmOz0vgRen
 hKFWyHvTCr6jBDC9XYiwsIz2j4OOSLllqJcMx29bQyTuKyO7SIX/NSwDVSIwqX2K8HMjrsj/z0o
 20ZUBEAUubpZZik2nZVqHxksGpnId7U5OkWJ9qO0m1YawuGsRVLmKqoAZ2A==
X-Received: by 2002:a05:600c:8b35:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-483c3db518dmr24698315e9.7.1772100994472; 
 Thu, 26 Feb 2026 02:16:34 -0800 (PST)
X-Received: by 2002:a05:600c:8b35:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-483c3db518dmr24697785e9.7.1772100993974; 
 Thu, 26 Feb 2026 02:16:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:2c1a:3780:4e49:dfcf?
 ([2a01:e0a:165:d60:2c1a:3780:4e49:dfcf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfbb465bsm78546265e9.3.2026.02.26.02.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 02:16:33 -0800 (PST)
Message-ID: <23522438-72ce-4b54-94ba-125ec513876c@redhat.com>
Date: Thu, 26 Feb 2026 11:16:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] system/memory: split RamDiscardManager into
 source and manager
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260225120456.3170057-1-marcandre.lureau@redhat.com>
 <20260225120456.3170057-7-marcandre.lureau@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260225120456.3170057-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello

Two little issues below break documentation generation.

>   }
>   
>   /**
> - * memory_region_set_ram_discard_manager: set the #RamDiscardManager for a
> + * memory_region_add_ram_discard_source: add a #RamDiscardSource for a
>    * #MemoryRegion
>    *
> - * This function must not be called for a mapped #MemoryRegion, a #MemoryRegion
> - * that does not cover RAM, or a #MemoryRegion that already has a
> - * #RamDiscardManager assigned. Return 0 if the rdm is set successfully.
> + * @mr: the #MemoryRegion
> + * @rdm: #RamDiscardManager to set

Should be @source

> + */
> +int memory_region_add_ram_discard_source(MemoryRegion *mr, RamDiscardSource *source);
> +
> +/**
> + * memory_region_del_ram_discard_source: remove a #RamDiscardSource for a
> + * #MemoryRegion
>    *
>    * @mr: the #MemoryRegion
>    * @rdm: #RamDiscardManager to set

Should be @source

>    */
> -int memory_region_set_ram_discard_manager(MemoryRegion *mr,
> -                                          RamDiscardManager *rdm);
> +void memory_region_del_ram_discard_source(MemoryRegion *mr, RamDiscardSource *source);
>   
>   /**
>    * memory_region_find: translate an address/size relative to a


Thanks,

C.


