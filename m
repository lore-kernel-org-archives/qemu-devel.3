Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052F6CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 06:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl066-0004ts-ED; Mon, 02 Sep 2024 01:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sl063-0004t2-TX
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 01:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sl061-0004j8-Tj
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 01:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725256763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xDp9x5Pbsmfn+2lvTjUXGcaPPPP6EA89pDr5Q0qTY0=;
 b=BuuOU2o2rGgm6vBV+TxUFmMyRPS7Hlkuf5vlM0uXhEAXmlg8rqYkmQMi7oGk1hM0CW228r
 GlLRmqviUtomsZnxrQO7vXX5ZouWJaPct7nPjWpjgcXyPhF43vAC7Jau+wXAG+7/UzMJc2
 /cO5IRvqQd3DUXVXJteTD7+KykU8zM8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-utv1-kMsPNm14Zdm8BZ_cA-1; Mon, 02 Sep 2024 01:59:22 -0400
X-MC-Unique: utv1-kMsPNm14Zdm8BZ_cA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a7fa52f708so556057585a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 22:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725256761; x=1725861561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+xDp9x5Pbsmfn+2lvTjUXGcaPPPP6EA89pDr5Q0qTY0=;
 b=UZYJegDwfSebsNV/BypV/mD6aH9pg7+QLh1O54vxy7K9G9x5hNpHTXyMNU86rr5RYC
 sB9J5ajw9G4kTjtOmFqtR+OmCWhPNji7kftJ0itq4e7xiZxsVh+pNgv8wL0HpMI6YGu5
 E5ttl8B+j+iq35eKmPPPQEJCy0oGjoK/fsKM/IDe+nvWCA8FgtJCjZlrmW4MDB9SxScL
 FBlNTuLqxiwCE3IWjYSV9hque+8pMTMuwpQa1zIMOTmB/Nhn3Fy36zAERuwGPYCMn1dK
 Diw/RyVIUVsuaBC9kC9BGasljcO8/wid+muNEV+2aGDwodPJaYveeDcqdT0WlGEb/lIq
 T4AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmAIyyhPnb4f5Mjds8rt7O4SxCDignhm3rRVrXexkci4pleJx9vYh5WY4cH/PmWX6eYEWjTt51MNeB@nongnu.org
X-Gm-Message-State: AOJu0YxPNidnUhPiQC7yyuppHjBVUWEm4h9c3Xl2DZpfvscx3nwWeDKT
 qZTjRpDe9QkDlwP5g6BFzTkHgDgFVrDmLcKICowisc8XvWqmV8WTQ0piwtPEIFyI9vxgXklwQPn
 SYF2h51Dd4aFehynFKZUPy8vozSTTxEDE98+G1XlNZajX6/q1MUa9
X-Received: by 2002:a05:620a:25c9:b0:79f:b72:fb30 with SMTP id
 af79cd13be357-7a8a3dc7929mr720126785a.59.1725256761517; 
 Sun, 01 Sep 2024 22:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX8inm6xAC0dNQtyd4LIrPPAbgsdM/aeliD/ONSfpLAFWGtN9eLKd9IL+0pYPKhViS0ph0qw==
X-Received: by 2002:a05:620a:25c9:b0:79f:b72:fb30 with SMTP id
 af79cd13be357-7a8a3dc7929mr720125785a.59.1725256761112; 
 Sun, 01 Sep 2024 22:59:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806d3c6b4sm386347385a.85.2024.09.01.22.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2024 22:59:20 -0700 (PDT)
Message-ID: <8125d3b8-1036-49de-95e4-27ad3230abfa@redhat.com>
Date: Mon, 2 Sep 2024 07:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] hw/vfio/pci.c: Use correct type in
 trace_vfio_msix_early_setup()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20240815135245.3325267-1-peter.maydell@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240815135245.3325267-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/15/24 15:52, Peter Maydell wrote:
> The tracepoint trace_vfio_msix_early_setup() uses "int" for the type
> of the table_bar argument, but we use this to print a uint32_t.
> Coverity warns that this means that we could end up treating it as a
> negative number.
> 
> We only use this in printing the value in the tracepoint, so
> mishandling it as a negative number would be harmless, but it's
> better to use the right type in the tracepoint.  Use uint64_t to
> match how we print the table_offset in the vfio_msix_relo()
> tracepoint.
> 
> Resolves: Coverity CID 1547690
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Applied to vfio-next.

Thanks,

C.




