Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2A1D148B7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdke5-0006w5-MP; Thu, 08 Jan 2026 02:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdke4-0006sZ-2z
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:41:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdke2-0004MT-P3
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767858082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W0KTzkiiDgXQG/gI9Es9R6bIt0ngSZRtrWFRtG9y2hY=;
 b=VDYPv6nin7JRUqXsBQu+hElcpS1SqZ/+LSRLJ3SzRrfFwaeKYb0Rvrj33ydvSBK0cA8x0Z
 KT/WF4iOWp3SL5vDXAmhvruslToh9Pc1QvYGXA6WKDNRzOklAAnDRueOyL3NZvjJuVHRx+
 Oe9dl8tE19ZGP8C7Mir+WgPP4ia/ot0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-xBwB8wh6P2u0hnwF-tam6w-1; Thu, 08 Jan 2026 02:41:18 -0500
X-MC-Unique: xBwB8wh6P2u0hnwF-tam6w-1
X-Mimecast-MFC-AGG-ID: xBwB8wh6P2u0hnwF-tam6w_1767858077
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d1622509eso18062975e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 23:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767858076; x=1768462876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=W0KTzkiiDgXQG/gI9Es9R6bIt0ngSZRtrWFRtG9y2hY=;
 b=BHSod0eh9EvhbJmIx6o/ZO8bbDs5+3p8p3eHcuqSTErNiuTD9SuFUhBQoNg8uu0CJ3
 vCrnLb0QtkmGrOTc+i7dultzJgAxi+Tw91yE6/n8KS0vwjJQgUTi2dyDkKMoNcvO549u
 tutnKZjFk8HmMem5EQOyPev7U6bUhTbVhNJuc5vFEv5VuUW8N/sVMlt/RS9eZHdtMU0W
 0+HSAu18PVYIswa8YTcCp4Ec2cuCyT85ZRFo/uknqCjaoCTWnN/b+cjSasuP27LvYkMs
 KzYA1cEuWWMKSPCN4WlGCidSZWpdwBlWnf5vwPjEzurzLG0BtXaSkHKdEAdmXu6CCyrn
 snmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767858076; x=1768462876;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0KTzkiiDgXQG/gI9Es9R6bIt0ngSZRtrWFRtG9y2hY=;
 b=vnrNQh1wAEfq+QKg/IxPHeuDr5iTp7Wv3P0YcqhtDz/IJevAF9WygVQE6HSJISTXM0
 kTdasA5mHtAp2Ps1nouQFjCZWKCBoUVpfO67fQdXCqvwx9OyyspEyBgllZhG/4XhjPe9
 5wWxdwaz8uH842mpIKLENUCrd44X6gQm5zSBsBwtqJjALzQmHull0cofn0QFpLdJYiss
 6lupYmef4q0iaWROlHCYHGntF+e4ADhqog4BIQJldGIISp/x/hYnehFcStPJMpTa1Ezr
 iIXUUUxRTBdismzggFBOV4tU02c7Agyr5IS2v1hBaTr8ybDcH6Oj7pwJ6k0nPPs6dIQI
 CfWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHPFtAOC4BkvmAVkN34NoKZkLrPsuLm18mwJWIDGoca3dkA75jJCbyPyLcbf1rKk+YC3TXav4Ld1XH@nongnu.org
X-Gm-Message-State: AOJu0YxIp9pL80n/34uH3niYE5ZSUUOXsXXzf0sZSUxeyeQtJ92PD1xy
 GtQEE8m6jPhnoaLAFecQH/+E0P7iv5y02aAPOQSLb6Ffl+Sgi3oZMK/gnM3oScJlszFF95LWhDS
 PxyVQuqwpyX626YRNXnTxVoX0Gx9c5rrZ3woXnKeVNtc2l73UNOSccKt/5H1K3icq
X-Gm-Gg: AY/fxX4Sy0bniBGkt9wtUvjR3b60gz7DutaYIfu06LcSQMfYW/P1l/h/BBbMyOfEHfm
 kbatndGBpJ5ZtHfHynrO5Lr9csvTzlZamhv1JoUbEME5raOsS86q46Tut9yEgTPE6IQokm2Da15
 jP90XWoSwPLbGMDdrDRf66JBRXqSDK6EWwMyLzVkPGOtu8JPdJBA02DH2DJ6sxkpMhb1JVJo+H3
 ZC+XtqqxIbNuGnCKhtPMVMi8sIirfkZi2ImyvsJkkvs+HKGQbTRPkfk7yi9iApTxqy2Ffrm9EmN
 1gwXkwqzpgEvUwj8wp7AqVZi+i2XbmDpSU74Eg0ETSIMbaGI5Zntc04grafGVew7Z0tEBZOD2Zg
 vEJfIp64=
X-Received: by 2002:a05:600c:4fc6:b0:477:7b9a:bb0a with SMTP id
 5b1f17b1804b1-47d84b54c52mr60359555e9.21.1767858076211; 
 Wed, 07 Jan 2026 23:41:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIL178Rq1+aDb/3sweIJBWsDOHArYkNO7tqNabdZL3laU+p8KyZJ8LSHXib4u0aVZ4rtyBHg==
X-Received: by 2002:a05:600c:4fc6:b0:477:7b9a:bb0a with SMTP id
 5b1f17b1804b1-47d84b54c52mr60359365e9.21.1767858075864; 
 Wed, 07 Jan 2026 23:41:15 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm148587825e9.1.2026.01.07.23.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 23:41:15 -0800 (PST)
Message-ID: <ff7ec647-64fa-4392-b4e6-a912e777e292@redhat.com>
Date: Thu, 8 Jan 2026 08:41:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] target/s390x: Pass vaddr/hwaddr types to
 mmu_translate_asce()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-8-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130807.69870-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 07/01/2026 14.07, Philippe Mathieu-Daudé wrote:
> mmu_translate_asce() translates virtual address to physical one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/mmu_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 9ee1d778876..ccb53e99ebd 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -122,8 +122,8 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
>       return ret == MEMTX_OK;
>   }
>   
> -static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
> -                              uint64_t asc, uint64_t asce, target_ulong *raddr,
> +static int mmu_translate_asce(CPUS390XState *env, vaddr vaddr,
> +                              uint64_t asc, uint64_t asce, hwaddr *raddr,
>                                 int *flags)

I'm ok with the change to vaddr, but with regards to raddr, I think you 
should rather change all of these in mmu_helper.c in one go. Otherwise this 
is a mix of hwaddr pointers and target_ulong pointers while the change is 
going on, and that is rather bad.

  Thomas


