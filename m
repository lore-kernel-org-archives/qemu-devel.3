Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44527CD3430
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJuqR-0000PO-3K; Mon, 04 May 2026 11:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJuqN-0000OC-TO
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJuqM-0006WC-Aj
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777907061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pJs5cr2yIQaphtBiLYjzdHcvxooKxlss8miDOVEMrPs=;
 b=AW7CNpG/D6MxExu5DbAztWxqQaqB80I+ZINb2w5qWqL89CK87L2G5SC7wgFMKQUsGotBHM
 qFOvQza4B7/OJjybFFlYgBEe1k8OR54wWXFLPfYcuWe6aeghqh+Ka5rjMlVKsHJO5vm4YG
 h9virqEWNit1jgwAbg9P9XSWbkL+hvk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-WFSEiyAVPYSytY0H2zGKBA-1; Mon, 04 May 2026 11:04:20 -0400
X-MC-Unique: WFSEiyAVPYSytY0H2zGKBA-1
X-Mimecast-MFC-AGG-ID: WFSEiyAVPYSytY0H2zGKBA_1777907058
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488d56f87e8so34114095e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777907058; x=1778511858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pJs5cr2yIQaphtBiLYjzdHcvxooKxlss8miDOVEMrPs=;
 b=E4NwDxNPfjWW6UoRSgRy7up+Ow4hJgL4k49Nyqon3I/I3NnPszU/m5bOw0xdA479OF
 wOdtLrrRgW4c+inMwF4zsJobk4wjhBOJfaYYL+9X9q6LnQyMt++Gxwxpm+9PRYlNP5Jx
 KMef+kfYrJV12P6YvPNNQEmzLOF16a8HBdrq9nsFVLb8PNUB5VsnA4mldlkECQO6PJd9
 F31emyuv5V8jyTNRYaPAtHkDTmX9vnq0IqvfDsUmKcxsJX0dJokZBEQ0z9qdgnd3B2aA
 TKiVGyjvrc4hFZqM/CSk/ujEYzsBaCVfy1GhDn2pvkY7cHzmxpUbBkt8YLkVtfzohipT
 2y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777907058; x=1778511858;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJs5cr2yIQaphtBiLYjzdHcvxooKxlss8miDOVEMrPs=;
 b=eSZQOxAdQBuP+MGjiY6uksJgap5CuPKgItPEFxaalf6qs10cZ5mmxdH/ezrSrXvXhw
 2RanFFqbKOUe0aqy+GQkUai08L+LzVzGuQ6dKUWUr5fGgynkcT3/m8H4QtKCFOvIPSjR
 iUTOPQUpMB77klade67+73Gph8s5WS1Bjh4He0mCHA+FercoR2ISnZp8aU7keU+5Pt3B
 fMDVkfxaj65ZzMnWXaC4hfEm9b08cOEAiwzX3kXponxDJIMnsdSu9EQ4eARsWTR8VjJN
 KUZVGSuh2ehU14eUkTs1e4VSdgvzaV6O3ZK7Kqvni03OD6KrqMVSUcDsRMox80fwNKn5
 hOgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HQ/m10f0iNc7wHueD/Rxlwx724APPNm9pZ7YDH0Q8yUxPptwcFH6RH4pSXhKSKYrD8m3isG9a2ghL@nongnu.org
X-Gm-Message-State: AOJu0YyrY0HLwCH1NyV84jZaxXGlcm9lOnZ7nieVkqDce6PR2b77pa10
 lV/fTnvug2jlemooLnKRbH/WMpu/33aLx0iNVllgooKvT5kJbs1cOgNzicHJu63qaNyO12446bL
 15VEgG+Au5ETpqdGAsSFL6B4shJELCb5SGK6xw34WR0DlI58pb7SD7YkN
X-Gm-Gg: AeBDiet0n5GfIH+UYUtQpcuPmCALuR3eHMIWBYG4EWo8yqsBZfguujC6DQHzSJH2Oby
 znlEyQbZzD6ZdDVfwZMKyZ5xxkXXZGUmFj3ZCA82+hUeUtVClL1HnZ96mjKVb1b5a93ug68dVI5
 1Ud+tBQfLLtVV+PuN032e5kJp0A+wKK9D0wDQaD7XsBrxB1bAaDFDnhzwZJ9hxNXKmkLhsPh57p
 zEmz5iD0a5EBBAtcHB9zIYC89n3YreVHjXrFfpF4R1/1HUJvGb9dGe8Hy4/1Xw3QFVzlVPjYS/X
 hVX3MyQkkD50pih0WDkHyjJYUXkz731C5V801j8Ev/8wJJABYsdfo9N+DTBrIw9BU02NUefJVt0
 DgDHCkMA1dGhSfZW5KcH7IYpwLOjuySex1kg4PZ58Ul2THFBKDOVrL6zVaMAPQ7ry9hJkvdg=
X-Received: by 2002:a05:600c:a30a:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-48a9865f34dmr122318415e9.17.1777907058094; 
 Mon, 04 May 2026 08:04:18 -0700 (PDT)
X-Received: by 2002:a05:600c:a30a:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-48a9865f34dmr122317895e9.17.1777907057560; 
 Mon, 04 May 2026 08:04:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8ebc4201sm445631915e9.15.2026.05.04.08.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 08:04:16 -0700 (PDT)
Message-ID: <e1b01043-048f-4345-94d8-6e87a75805e4@redhat.com>
Date: Mon, 4 May 2026 17:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/remote: update libvfio-user subproject
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20260422140244.2147400-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260422140244.2147400-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On 4/22/26 16:02, John Levon wrote:
> The currently wrapped version of libvfio-user has compilation issues on
> newer compilers; bump the library version.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/remote/vfio-user-obj.c     | 3 ++-
>   subprojects/libvfio-user.wrap | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 12ecdab6de..3c89e7a741 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -798,7 +798,8 @@ static void vfu_object_init_ctx(VfuObject *o, Error **errp)
>           goto fail;
>       }
>   
> -    ret = vfu_setup_device_dma(o->vfu_ctx, &dma_register, &dma_unregister);
> +    ret = vfu_setup_device_dma(o->vfu_ctx, LIBVFIO_USER_MAX_DMA_REGIONS,
> +                               &dma_register, &dma_unregister);
>       if (ret < 0) {
>           error_setg(errp, "vfu: Failed to setup DMA handlers for %s",
>                      o->device);
> diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
> index 416955ca45..11db795f8a 100644
> --- a/subprojects/libvfio-user.wrap
> +++ b/subprojects/libvfio-user.wrap
> @@ -1,4 +1,4 @@
>   [wrap-git]
>   url = https://gitlab.com/qemu-project/libvfio-user.git
> -revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
> +revision = 4d9f663450fa80ff375612dbbafe073700e3d3d8
>   depth = 1


Applied to

     https://github.com/legoater/qemu vfio-next

Please base future contributions on this branch.

Thanks,

C.



