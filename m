Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2958BC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFxH-0007cv-S3; Thu, 03 Jul 2025 05:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXFwz-0007LY-U3
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXFww-0000rj-HT
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751533783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HMz8lPUCbmAq/erDgqbz5buvunCwm3+0KBJvheIFTK4=;
 b=QFQHxokjTB70fX7AMZiH/eNoKiMLndcu515AeMsUP1qRi31gnqPPwcn7JssOtP8hUADbAb
 bGzXaVA5f+LVZpJSvxqv2UJPz3YzjJZxWNLkwBvjUUfjUXQDShFk3mvozT7nRGaXl+W/wh
 2X7p6+OXxTJxP2MlRO9NbQPp8o8Fx0o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-Qmi1zFjANb-8253aPvFKKw-1; Thu, 03 Jul 2025 05:09:41 -0400
X-MC-Unique: Qmi1zFjANb-8253aPvFKKw-1
X-Mimecast-MFC-AGG-ID: Qmi1zFjANb-8253aPvFKKw_1751533781
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so377090f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533780; x=1752138580;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMz8lPUCbmAq/erDgqbz5buvunCwm3+0KBJvheIFTK4=;
 b=lf6vkkc7RMhspXYdjPA3CbIThT6F8eeMQl8FrZrUxXjDmNQwX4IVj3a9HSN17gw0DV
 /SQQLM/sG1NUoECi+cWgxUrOsMb7CpD3BYs4lnB6sh3qO6NnFPqoEKHixkzR4IKyRjC1
 ZMMRdnRy0EMpWj5yXFNI7x9yom6/fsNAo6omGtNAMqn60eU8vga8tMJUOzTjaIcIqzAO
 OAERnktUoUzBj0rWtn/ddcpecFJpHyiFyChlVX97j4zpo62Fq5+lS9+XceaXPRvcDje5
 r3rU7a2NtolUzsgjJLG8AEYyOd+Rygux++BfsRCktDZiHecA/dYETIaOmXyjYflHOzuv
 zJ6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIhhFf/2bbLLjuyRL7kn1NrNmuGeKoOjYJjKYjQqD2/Tu2mgUmY+lCtMQdK73nKKYD7EN0aILp5w80@nongnu.org
X-Gm-Message-State: AOJu0YyeIUPtui53WtX3GtLapIugeUuL75uy6PnomctVxpecjiSuCClo
 DXX4/maNOWYta6Ol7nKnYFxMtDXbzBdYL2QjmM+fdkSaLnubG/cWruEEpQBf7zG7bdIBUeTDGvb
 UPC0iP6rH3kqT6Efvuqi8RTwg3oX5pSsBmdBGa+NF8FmAK4407tkAojYVtlDQgf+N
X-Gm-Gg: ASbGncvuVJrU6To8Yizfg0//PM1uSTq/myyHe8O/RaBYOmxNs/fb26sS5LEt8WbJvEy
 3xhCYjXwoZRMjihHSdy36DsaTpxJYBWT+xzZanDY98v25/V2laXnZg3xoHQWkbVyNV7O47pPa7N
 OlsG/9CVOQg7IRgImQEf9ClZcxF8QMdmc7F5yupLtN+MiiW54b7GP4KnpdFbATejGfmS3t0nftQ
 XPUIFkbnBRqcSnCCLRwFcZNUCoWTxbGCymGRaRzR5zO2U4QCl79Fdd/6tvm5JPQq9MAaalP1eoS
 vku4eWAxpNAefg+PI3ETIeWH4mLiASFKLFrc26Jx+KgDpONXPDVS0/H/ZplD
X-Received: by 2002:a05:6000:40ce:b0:3a5:298a:3214 with SMTP id
 ffacd0b85a97d-3b3434aab9bmr1674101f8f.13.1751533779790; 
 Thu, 03 Jul 2025 02:09:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+OBkMfy81MkOIujCjmDEoDE47i2E6f4ZxnRlRRk+6V8mtyjST1FWYV0ajTOXWJPYi9ocmNg==
X-Received: by 2002:a05:6000:40ce:b0:3a5:298a:3214 with SMTP id
 ffacd0b85a97d-3b3434aab9bmr1674062f8f.13.1751533779267; 
 Thu, 03 Jul 2025 02:09:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52b9esm18331350f8f.61.2025.07.03.02.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 02:09:38 -0700 (PDT)
Message-ID: <13a7f1a1-dc2c-4682-8d9e-b0ec0dbd2b64@redhat.com>
Date: Thu, 3 Jul 2025 11:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] aspeed: Deprecate the ast2700a0-evb machine
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "reviewer:Incompatible changes" <devel@lists.libvirt.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250703052400.2927831-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250703052400.2927831-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/3/25 07:24, Jamin Lin via Devel wrote:
> The ast2700a0-evb machine represents the first revision of the AST2700 and
> serves as the initial engineering sample rather than a production version.
> A newer revision, A1, is now supported, and the ast2700a1-evb should replace
> the older A0 version.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   docs/about/deprecated.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 42037131de..5a3ed71a64 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -315,6 +315,14 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
>   better reflects the way this property affects all random data within
>   the device tree blob, not just the ``kaslr-seed`` node.
>   
> +Arm ``ast2700a0-evb`` machine (since 10.1)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``ast2700a0-evb`` machine represents the first revision of the AST2700
> +and serves as the initial engineering sample rather than a production version.
> +A newer revision, A1, is now supported, and the ``ast2700a1-evb`` should
> +replace the older A0 version.
> +
>   Mips ``mipssim`` machine (since 10.0)
>   '''''''''''''''''''''''''''''''''''''
>   


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




