Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B9ACF31AF
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwpR-0004UP-Nt; Wed, 02 Oct 2024 06:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwpA-0004Tj-Qg
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwp7-0002gE-Uk
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727865793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uaoyH1JLEp/2pIr4KBEExzIi3qSVppTrtmAri/LRB+o=;
 b=HrW095NuB2OCDcbIi0drpRrtU+/kVQrGuKComjcGuXW8gIe/cgh034EvW0766qRraTKrIp
 Mb6hRkIntChHn6ssR492Wm7YlcwNoU+s5PDlQXgqjG6S0zzQkpKVBNuLEiklO+AsJwAcXi
 yp110O39w5rR3lNmehmkmGompPQjx+4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-qrkjAlRSOZioX5IVn_tCqg-1; Wed, 02 Oct 2024 06:43:11 -0400
X-MC-Unique: qrkjAlRSOZioX5IVn_tCqg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42caf073db8so54426585e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 03:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727865791; x=1728470591;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uaoyH1JLEp/2pIr4KBEExzIi3qSVppTrtmAri/LRB+o=;
 b=QjUhjvZomldBu94J5lyYM+wyoqNUAeYH3BhCHZLT8zzqTGLHrO5x6DpDnqieLdH5Ar
 iVMUjfBeHptcIZN+jvGHn5meUvkPoNtwENOYGy9se19/bk8wZYTvNOC3T/B4cZ94t5pC
 LANxICPj7b5DJSuhrZrfZPo1P5Cbm/yvqrKFlIBTfGYz+/tWVzK2L/DYS629sQuE3CkL
 MT0XnpNE42kd+o77uURBVFJcBVk3EBpPWYe2aInjWS+qr24AN3Nkwnl/EHWVuxcWSVxg
 mnN1/buqxiLbEes0gnNsDOM9QYAOWyHIn2rYALYvRsu/w9S7s6e2nNOkH0+srUqKLttI
 24+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp7EGDnyXouM5yKs7LF41dB8X9Z3hWfhSZC+I7Ag6SccUeuHQQTuUPRe9+9SdN+wD07oWabJnqHWRP@nongnu.org
X-Gm-Message-State: AOJu0Ywep1Gf7UFvXZL0gxbqubPWKOD8yDUEe7/2qkFJub6GKmsSiNvg
 UuNa0XsvjYSmWXzlzMeE4zcaqYp1jmfS+v2WRnFc4lftugNADDkO9c642r0GdDQScNkRozaITD9
 GfUnOSSraVB0be9vcFx0l+Nm6CKmABdQyJMSETj3klg0qDfN2PqdQp2INpUp+9/0=
X-Received: by 2002:a05:600c:1d20:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-42f777c1a6fmr20946265e9.16.1727865790672; 
 Wed, 02 Oct 2024 03:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY1YhCtW3gaCOkfoNUfFRQvZH/rOhpXoH8huasV9V4Ry2ZwGT/w2IuApsNcyWA5Ms2izjaxQ==
X-Received: by 2002:a05:600c:1d20:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-42f777c1a6fmr20946115e9.16.1727865790294; 
 Wed, 02 Oct 2024 03:43:10 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7728b382sm13826505e9.1.2024.10.02.03.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 03:43:09 -0700 (PDT)
Message-ID: <03a317f1-1868-4a45-96f6-5797478a22da@redhat.com>
Date: Wed, 2 Oct 2024 12:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/rocker: Remove unused rocker_fp_ports
To: dave@treblig.org, jiri@resnulli.us, jasowang@redhat.com,
 qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240918231447.458796-1-dave@treblig.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240918231447.458796-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/09/2024 01.14, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> rocker_fp_ports hasn't been used since it was added back in 2015.
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/net/rocker/rocker.c | 5 -----
>   hw/net/rocker/rocker.h | 1 -
>   2 files changed, 6 deletions(-)
> 
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 1ab5852113..5e74acc969 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -134,11 +134,6 @@ RockerPortList *qmp_query_rocker_ports(const char *name, Error **errp)
>       return list;
>   }
>   
> -uint32_t rocker_fp_ports(Rocker *r)
> -{
> -    return r->fp_ports;
> -}
> -
>   static uint32_t rocker_get_pport_by_tx_ring(Rocker *r,
>                                               DescRing *ring)
>   {
> diff --git a/hw/net/rocker/rocker.h b/hw/net/rocker/rocker.h
> index f85354d9d1..6e0962f47a 100644
> --- a/hw/net/rocker/rocker.h
> +++ b/hw/net/rocker/rocker.h
> @@ -72,7 +72,6 @@ DECLARE_INSTANCE_CHECKER(Rocker, ROCKER,
>                            TYPE_ROCKER)
>   
>   Rocker *rocker_find(const char *name);
> -uint32_t rocker_fp_ports(Rocker *r);
>   int rocker_event_link_changed(Rocker *r, uint32_t pport, bool link_up);
>   int rocker_event_mac_vlan_seen(Rocker *r, uint32_t pport, uint8_t *addr,
>                                  uint16_t vlan_id);

Reviewed-by: Thomas Huth <thuth@redhat.com>


