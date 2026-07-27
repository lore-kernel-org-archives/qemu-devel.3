Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C79CC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 10:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woIfs-0005pI-Ci; Mon, 27 Jul 2026 06:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woIfr-0005oe-Az
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woIfp-00019o-IR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785148501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BzS556thT9lSoCPvyvVhNQ1kq1C+54xht3hE+ogPc0A=;
 b=aO3Fn0yAidqTsaXttyP76TTlodyJ9oqVrc5HWMn7wCJFzq+IX1xgfRgyemOBKuSeSejO6o
 qs9qSTzLIr1nzJYC3xTg7AvE2PA+BinpcZnnDWlX2IHx77SFRlRQMn7t2iReIvtz8/iucw
 g1t/G9IToaGyS0Jx3SZ9sLwTnhw1Jc4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-vhHdAWBGPLKT3be1LWy4BA-1; Mon, 27 Jul 2026 06:35:00 -0400
X-MC-Unique: vhHdAWBGPLKT3be1LWy4BA-1
X-Mimecast-MFC-AGG-ID: vhHdAWBGPLKT3be1LWy4BA_1785148499
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4955843c6cdso29890275e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785148499; x=1785753299; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BzS556thT9lSoCPvyvVhNQ1kq1C+54xht3hE+ogPc0A=;
 b=VdmPAUX6TQl+EsHvFZ+WH/WJSFb2x6obR1vPR2R3z7sHHjT4WxRT63eu0Cv3jgUD7a
 lm2Zl2uB1MnneUqhb8VSd/t2szU3T3BXKEChi/eWcCPfPIQDEpTnaM5MZaA/yvHD33f3
 L7VWlWhJbBEEab22RUr/SCQkYwFpYuG9paC6NQ1fEoCG+QjxhaqgNJZcHjrrNQWNSBE/
 cwfEGpFAx/pBciZMtb5pFxb5GShf67+KVjshmYGmApT/KBC7q1hMuIXLWQq6KzSLJLf1
 +UOb6L5VQ7akkId4yuW+xdYESOxlQI/tPz7OCjNFhZW2aUOhys6tmnU3ernh5UwYyyjA
 d3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785148499; x=1785753299;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BzS556thT9lSoCPvyvVhNQ1kq1C+54xht3hE+ogPc0A=;
 b=qbXpOJ1ErI7glllo1XFd7eZzmJ2bFDuhtCezM4rEXm3RQWwL4CCLvRZZjNauBvy7pp
 wmoqe1Y+71oM5E6J1sC6WAXxCZVnO+A7jDP0HN5e33M/+lm10LMpDixPLWFPjb83iaoU
 Zm57SjdWqXmjz8dLhO6R5meB96NJcNGdhg6glOCG9jOp5gKnh2Z2Uz1rfhtKdq8vkjg1
 2V8XvpcsqKf7cZCT6fX7K4VlHWGrYvX4pYm5SHvwJyyjcFNvWPdfjuM7Bc1xRGGPSlFw
 JlYHjHZwsxI7MdAjUBCz144g4oBfc6vkFsxf7a9pHg50lqVXihGujXRNxAEZjcHU6P1t
 X10w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlE/4Vt3meEMadSAjteXgu5JkGQJESHHVhYY2xjmFFkTTeJ2Gsywh0f1cC2KBs8s7tCDZciqRT8hUB@nongnu.org
X-Gm-Message-State: AOJu0YxPkqzuYGNJk0Ty9qBhiTqCoj4RYBHMIRl9scnvOS1KkXWsMx9t
 fk57ShRRwcSVIy3Z1/xAb8q4GhN+lkvSQVJvjPrvG3B/GbCo6/TO3hrh/P0zNm9QKKWfwOxgmPT
 mX9Y0UL/jy0HrnKDBFElsCBFs7MqVzjYd/gYpfSwv3Ksq8CL5TuBUaygQ
X-Gm-Gg: AR+sD10x/yDOdBIpMBWruuX7ugytZMVLUGwdCeSL7aWr/tWMBtYRpq3PHHgMS2Suht4
 SB5uqh/jpaBqRTtMKZiZwilaI4neCWeotz0yaD0pIWLgIgXMC/K8DU3HIi0dcplLw+7m97sr/E9
 OHCus4UqG9Ry9UjKPVKHlebJ1FXeDieDWj6/75+Q+UsD3M4cv5cByphAPdjNr6KkOXkvEaaohFg
 DIh0lcwIhmLWJsaWKEAsZUPT9NytKba8xSHeXWvlCadl2wrj9ogpxHiSp0zUfOAdeT15E5HHekI
 isQd21oLtKcVAe0VK+ZZN8tRLRdywSsMEx23N8UqUKq1+Zd/sdqFrvT+ZG1ccnVHTihF3Zqclg=
 =
X-Received: by 2002:a05:600c:3113:b0:496:b39f:1a03 with SMTP id
 5b1f17b1804b1-496b56e6dc9mr95130385e9.5.1785148498772; 
 Mon, 27 Jul 2026 03:34:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3113:b0:496:b39f:1a03 with SMTP id
 5b1f17b1804b1-496b56e6dc9mr95130075e9.5.1785148498314; 
 Mon, 27 Jul 2026 03:34:58 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f33b73sm206524175e9.14.2026.07.27.03.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 03:34:57 -0700 (PDT)
Message-ID: <a4525b67-3e2e-488e-a7c7-0480e408bd23@redhat.com>
Date: Mon, 27 Jul 2026 12:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/cxl: Validate Set Feature payload bounds
To: Feifan Qian <bea1e@proton.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
References: <lRjjre9PPucf_bjrOAOLVko0OB0QYPcKJOBHmSHGG4xmSTNr2Y_dHzRiCT5BDRWfoPma6hC4iMdI4n6X5COoum79U7Kj1JgB1B7E703GOWA=@proton.me>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <lRjjre9PPucf_bjrOAOLVko0OB0QYPcKJOBHmSHGG4xmSTNr2Y_dHzRiCT5BDRWfoPma6hC4iMdI4n6X5COoum79U7Kj1JgB1B7E703GOWA=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/06/2026 17.37, Feifan Qian wrote:
> cmd_features_set_feature() derives bytes_to_copy from the mailbox input
> length and uses hdr->offset as the destination offset into per-feature
> write attribute buffers.
> 
> The patrol scrub and ECS paths already reject writes where hdr->offset
> plus bytes_to_copy exceeds the destination structure. Add the same check
> to the soft PPR, hard PPR and memory sparing feature paths before
> copying into their write attribute buffers.
> 
> Without the check, a malformed Set Feature request can write past the
> selected write attribute object and corrupt adjacent CXL type 3 device
> state.
> 
> Fixes: 5e5a86bab830 ("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
> Fixes: da5cafdc4ddd ("hw/cxl: Add emulation for memory sparing control feature")
> Signed-off-by: Feifan Qian <bea1e@proton.me>
> ---
> This is submitted as a regular bug fix for the CXL non-virtualization
> use case.
> 
>   hw/cxl/cxl-mailbox-utils.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d8ba7e8625..1724b09a6d 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1813,6 +1813,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>               return CXL_MBOX_UNSUPPORTED;
>           }
> 
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->soft_ppr_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
>           memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
>                  sppr_write_attrs, bytes_to_copy);
>           set_feat_info->data_size += bytes_to_copy;
> @@ -1832,6 +1836,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>               return CXL_MBOX_UNSUPPORTED;
>           }
> 
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->hard_ppr_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
>           memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
>                  hppr_write_attrs, bytes_to_copy);
>           set_feat_info->data_size += bytes_to_copy;
> @@ -1851,6 +1859,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>               return CXL_MBOX_UNSUPPORTED;
>           }
> 
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->cacheline_sparing_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
>           memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
>                  mem_sparing_write_attrs, bytes_to_copy);
>           set_feat_info->data_size += bytes_to_copy;
> @@ -1869,6 +1881,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>               return CXL_MBOX_UNSUPPORTED;
>           }
> 
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->row_sparing_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
>           memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
>                  mem_sparing_write_attrs, bytes_to_copy);
>           set_feat_info->data_size += bytes_to_copy;
> @@ -1887,6 +1903,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>               return CXL_MBOX_UNSUPPORTED;
>           }
> 
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->bank_sparing_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
>           memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
>                  mem_sparing_write_attrs, bytes_to_copy);
>           set_feat_info->data_size += bytes_to_copy;
> @@ -1905,6 +1925,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>               return CXL_MBOX_UNSUPPORTED;
>           }
> 
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->rank_sparing_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
>           memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
>                  mem_sparing_write_attrs, bytes_to_copy);
>           set_feat_info->data_size += bytes_to_copy;
> --
> 2.43.0
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

I'll pick this up for my next PR if nobody minds.


