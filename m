Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6D6D6EC0B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 13:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH1UX-0001Nu-T8; Fri, 29 Nov 2024 08:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tH1UV-0001E4-9Q
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:57:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tH1UT-0005QD-Ix
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732888619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r5FztujggOnqdKi7zf5nAXLSvIwPUHmGAjChqLkKhtI=;
 b=iIX2e7nytqr3bYw6LdmCcYd1C6eaf5AaTAdthBFESIAqtQGboDVQ4+fzbOgHycSNMzeaH0
 UzSENV5jhZxLwzzGNRiXYyuAJmqPRgjJP7AGGlIb0r9PcNoOAuP+WuDW4WsC+JrMUqc0Dv
 EiWkgwR++fI2qA0+O5l/hLyhlI+sOTw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-yTO-6I75OTmNHiNcC8BQPA-1; Fri, 29 Nov 2024 08:56:58 -0500
X-MC-Unique: yTO-6I75OTmNHiNcC8BQPA-1
X-Mimecast-MFC-AGG-ID: yTO-6I75OTmNHiNcC8BQPA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-382428c257eso955509f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 05:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732888617; x=1733493417;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=r5FztujggOnqdKi7zf5nAXLSvIwPUHmGAjChqLkKhtI=;
 b=kYTXvKRXggR/5DFMs4x96mPEy7iYsiP4yOdnvHB2YybRbx0lmOelQPH4iP+qeM1pBg
 facSynjFYRE65RqiuEN5vPQWixyGkpq7LtS5SGcVbPjjlr2IFKDy9+r4Ueym1KaoW1gp
 C0a3ts5eE8Ml81Oe8UukEb6yCxhfUOssNy6SmNZjVRj9+wthTjnubpGxzpG1vrZhHvvk
 DC3lMq5vpDasPEPSQwdx6Dw/18kxsJUpPjcRHG44FIPr3RR44xlZmv4d/OGk0Bi5ScCj
 /ggA8X0ckL0Pw0CXqYQ8WgvdWY8eJUriuxFXOd7WuVjft0qAPl0rY0A5UxBTRtN/NHNe
 +abg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTEwxS+UzCsaiYGhAcLcvh+Rv4nZFpWdjxucOCMyn6RGXlpQjvSN9EmievRyAhR1QS66SCCAg680/M@nongnu.org
X-Gm-Message-State: AOJu0YzLh2QKOOBDUPoNqWC9yz4X0mYTa/6weu/YoOr4dKkn38QTRaMv
 FCdH7W1coqFTUBKjIRQU84n2EDQzFvQFMibGAuWk7bvnrxTD43Tw8iaPgSuIaGfSKOWpGloNMrh
 U875xP997yW7AZW4s9Xwyhf2L/0n0xLP8yZKLThL+0hPVEk0dBie1
X-Gm-Gg: ASbGncvGt5wjBk3bHwetNVp7lLF0s6hH6gFy82zCacLoWTLseSa9sHiaj9LZcwbDqhC
 FYeR02wXFlo4EDyaRzsp7lWXyHuJNZaTHzJrZjDge5edtfiaKIOsc5Qi3v3twYeUr3zgnKdS4HU
 VPU1z7V6AYtqGMhpkWhGnSOC7SYQY6OcPWMRrDdbyVvtOVXVhj1vs0ruPIYacU4P7qu6wQAvmr3
 O2nlo49lLBgO3bNlvPkLWk34qEjwaX3bmBhZj7czYjHNPuQL5ff61X4xkH4BUxcyDIfhq5vR3ab
 bojsVPqknezp/T2Riiw6gt85eEfnXckKFg4ub/3BmPLt9WMF9R1faGK1yHX3iQid1+QPoIBYKxM
 RGQ==
X-Received: by 2002:a05:6000:1fae:b0:382:3c22:e894 with SMTP id
 ffacd0b85a97d-385c6ed7631mr9868345f8f.37.1732888617280; 
 Fri, 29 Nov 2024 05:56:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkVNWwQtOQdDPxqV4ZSbJHia5aQzTxC7APkhUr0eIRMb3Pg76pmoWKStmmAU812mNwSjTJtA==
X-Received: by 2002:a05:6000:1fae:b0:382:3c22:e894 with SMTP id
 ffacd0b85a97d-385c6ed7631mr9868316f8f.37.1732888616910; 
 Fri, 29 Nov 2024 05:56:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404?
 (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de.
 [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd2e007sm4626129f8f.4.2024.11.29.05.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 05:56:56 -0800 (PST)
Message-ID: <00cf6179-e525-4309-98cf-028785f8cd23@redhat.com>
Date: Fri, 29 Nov 2024 14:56:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3 for 9.2] hw/virtio: fix crash in processing balloon
 stats
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Martin Pitt <mpitt@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20241129135507.699030-1-berrange@redhat.com>
 <20241129135507.699030-2-berrange@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241129135507.699030-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On 29.11.24 14:55, Daniel P. Berrangé wrote:
> balloon_stats_get_all will iterate over guest stats upto the max
> VIRTIO_BALLOON_S_NR value, calling visit_type_uint64 to populate
> the QObject dict. The dict keys are obtained from the static
> array balloon_stat_names which is VIRTIO_BALLOON_S_NR in size.
> 
> Unfortunately the way that array is declared results in any
> unassigned stats getting a NULL name, which will then cause
> visit_type_uint64 to trigger an assert in qobject_output_add_obj.
> 
> The balloon_stat_names array was fortunately fully populated with
> names until recently:
> 
>    commit 0d2eeef77a33315187df8519491a900bde4a3d83
>    Author: Bibo Mao <maobibo@loongson.cn>
>    Date:   Mon Oct 28 10:38:09 2024 +0800
> 
>      linux-headers: Update to Linux v6.12-rc5
> 
> pulled a change to include/standard-headers/linux/virtio_balloon.h
> which increased VIRTIO_BALLOON_S_NR by 6, and failed to add the new
> names to balloon_stat_names.
> 
> This commit fills in the missing names, and uses a static assert to
> guarantee that any future changes to VIRTIO_BALLOON_S_NR will cause
> a build failure until balloon_stat_names is updated.
> 
> This problem was detected by the Cockpit Project's automated
> integration tests on QEMU 9.2.0-rc1.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2329448
> Fixes: 0d2eeef77a33315187df8519491a900bde4a3d83
> Reported-by: Martin Pitt <mpitt@redhat.com>
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/virtio/virtio-balloon.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 609e39a821..afd2ad6dd6 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -167,19 +167,33 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
>       }
>   }
>   
> +/*
> + * All stats upto VIRTIO_BALLOON_S_NR /must/ have a
> + * non-NULL name declared here, since these are used
> + * as keys for populating the QDict with stats
> + */
>   static const char *balloon_stat_names[] = {
>      [VIRTIO_BALLOON_S_SWAP_IN] = "stat-swap-in",
>      [VIRTIO_BALLOON_S_SWAP_OUT] = "stat-swap-out",
>      [VIRTIO_BALLOON_S_MAJFLT] = "stat-major-faults",
>      [VIRTIO_BALLOON_S_MINFLT] = "stat-minor-faults",
>      [VIRTIO_BALLOON_S_MEMFREE] = "stat-free-memory",
> +
>      [VIRTIO_BALLOON_S_MEMTOT] = "stat-total-memory",
>      [VIRTIO_BALLOON_S_AVAIL] = "stat-available-memory",
>      [VIRTIO_BALLOON_S_CACHES] = "stat-disk-caches",
>      [VIRTIO_BALLOON_S_HTLB_PGALLOC] = "stat-htlb-pgalloc",
>      [VIRTIO_BALLOON_S_HTLB_PGFAIL] = "stat-htlb-pgfail",
> -   [VIRTIO_BALLOON_S_NR] = NULL
> +
> +   [VIRTIO_BALLOON_S_OOM_KILL] = "stat-oom-kills",
> +   [VIRTIO_BALLOON_S_ALLOC_STALL] = "stat-alloc-stalls",
> +   [VIRTIO_BALLOON_S_ASYNC_SCAN] = "stat-async-scans",
> +   [VIRTIO_BALLOON_S_DIRECT_SCAN] = "stat-direct-scans",
> +   [VIRTIO_BALLOON_S_ASYNC_RECLAIM] = "stat-async-reclaims",
> +
> +   [VIRTIO_BALLOON_S_DIRECT_RECLAIM] = "stat-direct-reclaims",
>   };
> +G_STATIC_ASSERT(G_N_ELEMENTS(balloon_stat_names) == VIRTIO_BALLOON_S_NR);
>   
>   /*
>    * reset_stats - Mark all items in the stats array as unset


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


