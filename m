Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58E3C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 06:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufBrg-0002xl-UP; Fri, 25 Jul 2025 02:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufBrN-0002qP-5x
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufBrD-0007VL-ML
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753424675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AeQ7Z5jHh0tdelWQ9L9irAjCcWPnkuMCwU1yNoGwdXg=;
 b=aTBr/YwU0fp4/5996+7Wh5H9XIWWUBhI9FCyqvum+Z4qStNCKd3eC12OE66xEIVn9ed6A6
 BPgEh9NnBN6QfaNNou7ywX1nBOIjGDjF6QX36Vceor3hOZRVk4QyTqXmK1iAuFb3sFwmQ6
 1bITyAsHHxZ3TPwAXJ2F+gfyW0fLuP8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-9RvqcWN8OvqwhM4HlWzBPA-1; Fri, 25 Jul 2025 02:24:33 -0400
X-MC-Unique: 9RvqcWN8OvqwhM4HlWzBPA-1
X-Mimecast-MFC-AGG-ID: 9RvqcWN8OvqwhM4HlWzBPA_1753424672
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4560f28b2b1so6137705e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 23:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753424672; x=1754029472;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeQ7Z5jHh0tdelWQ9L9irAjCcWPnkuMCwU1yNoGwdXg=;
 b=HI5HS4dq9kq7XWprLmnAmiy7YhEnfOKQyHH9WkRkarc8j8QJUgnqNxJhGV4kDTzYuw
 bMd2BPCfxFrs+5q5voTwL7SOD+OkIje7u7rIwPBTjC7xg/BwsuTxnvRGufwhgRjaKjGR
 W/tr/CoyRJQHMTzZjSxdJTdZvc2IpkoO3Axcbgi+m82vYSMfhjgPcEB2ex/V6MkmUPbI
 1w8SmI7E1XALIQ68sotWfWlY5ubDg7XT1a470W7lIDmdKzPnQkPV8IIg4LpP5WLyYQEt
 MA/SMngyZEu9KiXxWJeDYSgYq1S5z3/icY9dd9y1ZyQF1gbiCVDcS2ULJVBtolEaZN9s
 F2qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCpdhia3/m+EotU85gEqhgTMZp92N6rDlQmHAncB3BRhGoZoLMXmjsI9kwbOzrMkSvJxK2qPaOehA1@nongnu.org
X-Gm-Message-State: AOJu0YzBCT9aeA+jbhTvhSUZLeI6IM1TZG+EG5zgV/4T43HLxGu5Prmy
 fnaAf4/oba/Hzpdqa+FG3gjbVkXs9NkreLtEhsTkMyZBD0vjVApLgdZy1DszYV/4Cu4Z0cGJli4
 utSyj5nweQFbAql9T7CwNOYXVcE2jP1F0qq46znHxoSS8tvezt3mRsgp+
X-Gm-Gg: ASbGnctNZqVd8H1QsqXOcKnTsr8GL9NJph00UqoWzAGWDWliTmi7vTuBzM1/4tmb5ny
 XAl/7Zkk7l8Oh6z+nSF1V8l81TLoAzVGlNap2hZ8/4ixMLfe/lHcqEst1OgZY31ucyP8j1zRp4+
 +MQ1rUD3jE+DwsKZUvz88Om04VzLGLCDAcZz+uepQMI/m4nm/K4Z4tsdMQmNvyW+1JqYq527Qt0
 SSoInMR1ZdGh1sMMwKo3j66McGbrK+GYyN3NleOYTRuwnhoRlS35LMW01puFzuo8tULe8ba74Sy
 WwirH1hhNejUjhoEMT9oLznZf2h+aSdoiWmuWcGALrTtwKsXRVEJ4qklDVZvMyje7EXIVFq9s7l
 9oWY=
X-Received: by 2002:a05:600c:4ed1:b0:453:1058:f8c1 with SMTP id
 5b1f17b1804b1-45876304c42mr5110975e9.3.1753424671921; 
 Thu, 24 Jul 2025 23:24:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC1Sbgn4lbb/WPvRg0+4drCfb7cCreuRZtunbliTntCYlbDaf48+IL8SoHo+R0UENJNsVoCg==
X-Received: by 2002:a05:600c:4ed1:b0:453:1058:f8c1 with SMTP id
 5b1f17b1804b1-45876304c42mr5110735e9.3.1753424671483; 
 Thu, 24 Jul 2025 23:24:31 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-089.pools.arcor-ip.net.
 [47.64.115.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870532b5asm41551685e9.5.2025.07.24.23.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 23:24:30 -0700 (PDT)
Message-ID: <cef1f755-aaf0-4411-8e1c-2c50e3a57770@redhat.com>
Date: Fri, 25 Jul 2025 08:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/qxl-render.c: fix qxl_unpack_chunks() chunk
 size calculation
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paul Durrant <paul@xen.org>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20250221134856.478806-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250221134856.478806-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 21/02/2025 14.48, Michael Tokarev wrote:
> In case of multiple chunks, code in qxl_unpack_chunks() takes size of the
> wrong (next in the chain) chunk, instead of using current chunk size.
> This leads to wrong number of bytes being copied, and to crashes if next
> chunk size is larger than the current one.
> 
> Based on the code by Gao Yong.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1628
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   hw/display/qxl-render.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
> index eda6d3de37..c6a9ac1da1 100644
> --- a/hw/display/qxl-render.c
> +++ b/hw/display/qxl-render.c
> @@ -222,6 +222,7 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
>       uint32_t max_chunks = 32;
>       size_t offset = 0;
>       size_t bytes;
> +    QXLPHYSICAL next_chunk_phys = 0;
>   
>       for (;;) {
>           bytes = MIN(size - offset, chunk->data_size);
> @@ -230,7 +231,15 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
>           if (offset == size) {
>               return;
>           }
> -        chunk = qxl_phys2virt(qxl, chunk->next_chunk, group_id,
> +        next_chunk_phys = chunk->next_chunk;
> +        /* fist time, only get the next chunk's data size */
> +        chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
> +                              sizeof(QXLDataChunk));
> +        if (!chunk) {
> +            return;
> +        }
> +        /* second time, check data size and get data */
> +        chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
>                                 sizeof(QXLDataChunk) + chunk->data_size);

Looks reasonable to me, and I think it's also simple enough for qemu-trivial 
(now on CC:).

Reviewed-by: Thomas Huth <thuth@redhat.com>


