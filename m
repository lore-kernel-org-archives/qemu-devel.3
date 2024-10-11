Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9C6D2447B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 05:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz8ci-0002eC-Pq; Fri, 11 Oct 2024 01:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sz8cg-0002dh-JP
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 01:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sz8ce-0003UA-3O
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 01:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728626128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iU5Te3QXwHhu7LIEwk4DcZwooZE7fXg++FwNyVVswNw=;
 b=IonHnU8xCyFxd5iOWgsI15WQFFvpQFBJQa9AgLDtvGZvKZtFZTd7mqaMqrG46jPB82rqPC
 zoeHU6gPqsjjY9wJGhjcFZcblfZ//y2BY8lOY3Jz7rECsHMQnQIRuBzcHPni64vjUbt6Ag
 pTGC50K0cnq2/tcm+PMixY1mqPgjp38=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-im3RtAVHObSS__6Yt8VA_w-1; Fri, 11 Oct 2024 01:55:25 -0400
X-MC-Unique: im3RtAVHObSS__6Yt8VA_w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a99501c3a13so172323266b.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 22:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728626124; x=1729230924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iU5Te3QXwHhu7LIEwk4DcZwooZE7fXg++FwNyVVswNw=;
 b=E06pFcDD9D02mJBhzYRqL7FfHhBP3oqgwKI0GIEGChRSCM/1appwup/Zp0sUGEa/g4
 KRJkcbOqj8+Cp5eurOl/RSjlc4QCCNZVzUv6If9ke4dOOfdaw5Qa93cqr6KtgTZHutA7
 sNhrW3rF2hWSS09I9v7/1vAEAnuQ25/7CVvD4TUgu/MtjU6FWtPKIEbzDtCluVVqsTdB
 f+HhMkcYXs7o2YAmW4FFgjdAlQ4FSzXrMHpYyziYNG4J6LL0fyMeKgCIqq+ZAQMWoCHI
 8MXTCyX+KtWq4oizZ5pAb/Rnd4lXM6Dx0ODvwdFOlEMhcgVGlya4D2L1UCTuLp6WbzZV
 ftVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfzGmUnlM6Snq/nzON84BkAynQ0lUZ4aK80t/kzwv9hdIVix8vIJigHnez0dLiiewFimyAnXa1LdD/@nongnu.org
X-Gm-Message-State: AOJu0YxdkYO/26Sy4jG93jSOwCI8eHhWs/yYqSmscZGLXhhemomh1d7G
 czHnNlZmQeKQHZMMVrprPCvg9Udpj3+b7KoO/+N3EGbCT+RSaSQnQ8hH91ArIV8vKxQe7p/jb8v
 MbBR7OczIigsELwf6tHw/50sbLMDvHNAKdyIiBtf6R0Gc/xiXGwJx
X-Received: by 2002:a17:907:1c1b:b0:a86:6a9a:d719 with SMTP id
 a640c23a62f3a-a99b89f50abmr116975966b.29.1728626124107; 
 Thu, 10 Oct 2024 22:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSBa8Gzyf0c5jW1IFJ25ESp4Jl/x8cLH1e9qn8bKBeMHzDl/eyfJl+iz57SjBtqqpf6NNGAg==
X-Received: by 2002:a17:907:1c1b:b0:a86:6a9a:d719 with SMTP id
 a640c23a62f3a-a99b89f50abmr116974266b.29.1728626123702; 
 Thu, 10 Oct 2024 22:55:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:fb13:fd72:22f:64e2:b824])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80bfacasm173176666b.119.2024.10.10.22.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 22:55:22 -0700 (PDT)
Date: Fri, 11 Oct 2024 01:55:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] net: Check if nc is NULL in qemu_get_vnet_hdr_len()
Message-ID: <20241011015437-mutt-send-email-mst@kernel.org>
References: <20240817-net-v1-1-699b5591ad3b@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-net-v1-1-699b5591ad3b@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Aug 17, 2024 at 04:00:43PM +0900, Akihiko Odaki wrote:
> A netdev may not have a peer specified, resulting in NULL. We should
> make it behave like /dev/null in such a case instead of letting it
> cause segmentatin fault.

segmentation

> 
> Fixes: 4b52d63249a5 ("tap: Remove qemu_using_vnet_hdr()")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

Jason, you tree?

> ---
>  net/net.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/net.c b/net/net.c
> index 6938da05e077..4c21d91f9450 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -542,6 +542,10 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
>  
>  int qemu_get_vnet_hdr_len(NetClientState *nc)
>  {
> +    if (!nc) {
> +        return 0;
> +    }
> +
>      return nc->vnet_hdr_len;
>  }
>  
> 
> ---
> base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
> change-id: 20240817-net-dc461895a295
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


