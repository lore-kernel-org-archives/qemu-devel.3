Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A749EEE271
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 00:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotz5-00057l-HD; Thu, 12 Sep 2024 20:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sotz3-0004zL-67
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 20:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sotz1-00025p-LC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 20:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726186576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHJ4IM/tUysYaTXWlTAQy/msZq8iS8EY/YzrCyqJg6Q=;
 b=FsGuGSrwA8cb8H/a58JF5iCUWHSFZwCLnTxTUaT/dxFpdoFwdv6eIbZzWybXxGSBV6uNIJ
 faz/J+xjWkhc/TOD2TPCCgqF8npM4zkcR17iztudB7EFNaylmcPdJBif6NBBdPgcJ1KVV/
 rkXx6MVzNG+QbiJ26ehiSBZt2ww1qZY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-86bp6Ay1P2iloPSvGSjpjg-1; Thu, 12 Sep 2024 20:16:14 -0400
X-MC-Unique: 86bp6Ay1P2iloPSvGSjpjg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-206f9b1bc52so16213465ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 17:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726186574; x=1726791374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FHJ4IM/tUysYaTXWlTAQy/msZq8iS8EY/YzrCyqJg6Q=;
 b=pP7PsZi8G3OctfieWSqoH6MD4kNy3TgBjlpSyN0cjcE9TxotnXiOoMosw4wPK0Am6w
 fQRsXXn6OBcQ+O1FG2puTT25+8Z9qhb7xLFEqHuYLMfUGdJ5N9WBuX+xWd03nWP0UZmi
 vQNoPjrTPynXjCJcFRniwBXs/tNSuaDNm+JN7WhjWwW5VSceNhG/bWIO0vFN7si6kKf7
 paf7AAUMvPX/+2liGan96rXcrdSsE//d8TV4vY8+BpNV6W+uyyJ+EO2w4OZhDJdgL1/N
 Aki3cdBSyxfRllzcvcUmGNPCV4WqpvUIlH2jZaO+CmmabE1tuK4fxZoklkpg4AZjVrxf
 RmdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPZ3RfzT+oEATuPfEjPgmrxWrNteTFIwQ93ICNaqYYgMZlkQNk5Aqf9N6GF+c8bdF2Av+IIO0yciYH@nongnu.org
X-Gm-Message-State: AOJu0YxdjE0q7vxwRlIiCohtQMeMfVS2//DoPhncmYA6e5HsOUUn8ppu
 yI8hR8TkM2JjFg2VKpVvD6bjsksqc2H2h3t3TBaOqZSC3dBIaECxDMAUr39luwjl1R2p0cZ7/Us
 LNP6lrauN4WQvjg4303e+51Ia+EyjQXWuDlJyls1AGOnWACGlGfmZ
X-Received: by 2002:a17:902:db11:b0:206:93e7:5837 with SMTP id
 d9443c01a7336-2076e3f8962mr72566915ad.39.1726186573893; 
 Thu, 12 Sep 2024 17:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWolxyd00wfyfo+sIFv10yltIrF2ionuFivfkDoYgnixx/J3U1ySEebStDXAbmntz39p5Unw==
X-Received: by 2002:a17:902:db11:b0:206:93e7:5837 with SMTP id
 d9443c01a7336-2076e3f8962mr72566435ad.39.1726186573266; 
 Thu, 12 Sep 2024 17:16:13 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.31])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c82sm18957405ad.210.2024.09.12.17.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 17:16:12 -0700 (PDT)
Message-ID: <9d879983-e3a7-4832-8bfa-a3db37504244@redhat.com>
Date: Fri, 13 Sep 2024 10:16:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-mem: don't warn about THP sizes on a kernel
 without THP support
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
References: <20240910163433.2100295-1-david@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240910163433.2100295-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/11/24 2:34 AM, David Hildenbrand wrote:
> If the config directory in sysfs does not exist at all, we are dealing
> with a system that does not support THPs. Simply use 1 MiB block size
> then, instead of warning "Could not detect THP size, falling back to
> ..." and falling back to the default THP size.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/virtio/virtio-mem.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


