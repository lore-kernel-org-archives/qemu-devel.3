Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE24EE7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdxv-00089R-9S; Wed, 08 Jan 2025 16:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tVdxt-00088z-6E
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tVdxr-0003sw-1w
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736373105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8N0guUDSbIYVWqXggvmiyG0+OeGoVojdJbWZtZjg92s=;
 b=gGthotSgAztkb5z4Xpeggkg9fkjwYQ4aclUioG3fYKK5w1b3PiJblPxWgR6yog6Cvdgnl/
 nk5F3OOvVIwrI6v9yoyVF844CCfGhGbYCqRKDzEfNitb4GK4vt3HLBn175x4GJZcWOBwe7
 gEfU1pxdUMrvlMxT/76xII4RR+06uVQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-CyrGSstMPNOs1czKYUqoIA-1; Wed, 08 Jan 2025 16:51:43 -0500
X-MC-Unique: CyrGSstMPNOs1czKYUqoIA-1
X-Mimecast-MFC-AGG-ID: CyrGSstMPNOs1czKYUqoIA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385ed79291eso643992f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373102; x=1736977902;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8N0guUDSbIYVWqXggvmiyG0+OeGoVojdJbWZtZjg92s=;
 b=NVxPmnfKGUGiSVG+0U+VudUTS+daWhqB3U6v0+yaLl7BpsFHwXpTkaqQOqxGxJph8X
 JNo9DzuN0/saSgghw0ShpL20pM2xlZvyItCnvQCEoCYd4VMLWMz27LGcmV2luqBpQBDp
 8OP1iweu7eJK5++WIhWORGTF8+Ge0+4P8ysmutEUn7M9zcuOYvqsljWWT6Bg0JmIC7pW
 yw+ujgHr8wTbM5yoL8nkcZ1WZxUaDQLn15AlU6tP7tQOVGzX9+gbHarjhNIP6mtEThJe
 Jc5006yBuEG7CQRWh+28Xr4HtTo5h1Tc3oOVkOCIBbQQAYF23iLLlPBPf+4JR5Am8RhN
 DQTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX5J4kd5PsNWyefzaN5D10fwfmPq4aZ2o0Z4tIlmGfjDpr9n/KC6R/fmFtbg0QdMwfgiGawQ7h+W1C@nongnu.org
X-Gm-Message-State: AOJu0YyWY15vWVwL7iDfKQQlQFmQ5uXltkBm9GnjzwXpP3sn7au9PHfb
 pmpEptZnizIVChoLwKviO9SA9jXhdIEx8ceKsDIVlIqKmhJVFy5YwwC3YeBElZBAZ/cWjDC0dHo
 YQzehXDXc7lOUWYwUEHqI8XVVtSO0YtDPLVcEPvItVSvAz013LUtG
X-Gm-Gg: ASbGncsOe7FJ/MuCZUUcsDZA+K1Iihe2cN3mzMED5TCmJ6t6IVb2zkIG6HfHYnRHCPm
 0UvBuUpt8pWsHh6jUm9V4RvAZkJKttLZ9Pr6LgM7cPNLIvByGtmqMb4KNs0gNVoj13+yqk9nDJ+
 n2vQ7yWdwsjK5rXYTmKDwOmrbktxph9BTKeV2kGErzcBS9J7RMudgrhiNiW3lvL/Gasn859Vmm1
 +5Z7CbNHKP06VnxQiKWMF80+GU/l+5PYg+IVlT1JZux9/IhX5MhhbKBQYdMS+drxDS11WZgXg2J
 rGlKiqIhUJ34Y3p9UEpeNfZG5Yn4xwgmltBVcHDoJTsDDE8MyFHs55vxmt6Gb3keaGWZIwPh+x7
 fxpE2rA==
X-Received: by 2002:a05:6000:2a9:b0:38a:88bc:aea6 with SMTP id
 ffacd0b85a97d-38a8b0b816dmr700635f8f.6.1736373102264; 
 Wed, 08 Jan 2025 13:51:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdQZn9sbC0j/500N2aXfLDc3+B4bnc9d7BRW68te+PhIY3H7ViQETdbfPrzgYOrEfKA1kpsQ==
X-Received: by 2002:a05:6000:2a9:b0:38a:88bc:aea6 with SMTP id
 ffacd0b85a97d-38a8b0b816dmr700608f8f.6.1736373101931; 
 Wed, 08 Jan 2025 13:51:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7?
 (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de.
 [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c6a2sm3178f8f.54.2025.01.08.13.51.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:51:40 -0800 (PST)
Message-ID: <56c1cf86-9244-4388-abec-d5c48b9217b9@redhat.com>
Date: Wed, 8 Jan 2025 22:51:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] c
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20241214134555.440097-1-william.roche@oracle.com>
 <20241214134555.440097-7-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241214134555.440097-7-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 14.12.24 14:45, “William Roche wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Let's register a RAM block notifier and react on remap notifications.
> Simply re-apply the settings. Exit if something goes wrong.
> 
> Note: qemu_ram_remap() will not remap when RAM_PREALLOC is set. Could be
> that hostmem is still missing to update that flag ...

I think we can drop this comment, I was probably confused when writing 
that :)

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
>   backends/hostmem.c       | 34 ++++++++++++++++++++++++++++++++++
>   include/sysemu/hostmem.h |  1 +
>   2 files changed, 35 insertions(+)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index bf85d716e5..863f6da11d 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -361,11 +361,37 @@ static void host_memory_backend_set_prealloc_threads(Object *obj, Visitor *v,
>       backend->prealloc_threads = value;
>   }
>   
> +static void host_memory_backend_ram_remapped(RAMBlockNotifier *n, void *host,
> +                                             size_t offset, size_t size)
> +{
> +    HostMemoryBackend *backend = container_of(n, HostMemoryBackend,
> +                                              ram_notifier);
> +    Error *err = NULL;
> +
> +    if (!host_memory_backend_mr_inited(backend) ||
> +        memory_region_get_ram_ptr(&backend->mr) != host) {
> +        return;
> +    }

I think this should work, yes.

-- 
Cheers,

David / dhildenb


