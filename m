Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB37DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 10:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqkS-0008TS-KF; Mon, 22 Jul 2024 06:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sVqkR-0008S3-1M
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sVqkP-00014c-EN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721645907;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Cpy42h4QR0dQi4xrDY4msMCkizRDfkPfMeN4kHHSHY=;
 b=NAsa/plupVYVLJkw/z2OtQWq6BCg27GAM7jB4YP8nc3kA35t+5HWNhsEdqgVWXBi3eEk7X
 2Hs1YFPsB/gi8kppmlC+Z12ELiT1V7z9/ApKdzIH6aA9483oV8JNv6Qmvp+MA0JAkE2UDH
 1gn7X8Oj4lF4/ga2QdYNjeka+inwVRw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Eo84LIZGMkWH0BLrgIHTng-1; Mon, 22 Jul 2024 06:58:26 -0400
X-MC-Unique: Eo84LIZGMkWH0BLrgIHTng-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b7a4ba59bdso76044356d6.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 03:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721645904; x=1722250704;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Cpy42h4QR0dQi4xrDY4msMCkizRDfkPfMeN4kHHSHY=;
 b=lcZ2SZe5jzREMwdI0z/CUlNFsH8nTluz71mgSasaJsYkG/OdMnM5VPPvQIiu+7BrwE
 yTgu5/2sO07tyMTWDj5SIInlBtTy8Izf/kFDYkD65y/fILzeue0zDdV4f75ldqp+7A6Y
 +bXeXpusnUoYqNI2EcvL/uHWY3xp2JTLM4SwopraT56tfKQooRS5O6aTzwtrIW3iRD27
 QZ6OiyhE+UxzkjajV3gd6S0rVjfM9Vm6dGpp6AzW9+9vTsDvVD4TenLBUQOQ+3CKpKEy
 BA3SHUAOO7rmBRJCtsUmtPi7qPkQgpMYmfJyTgj3+79wF4ADjngLNWQ6HMW8xbI88mwF
 g2FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTVa8JUEM3YFiSVTJZFbPZCr3+eyGlgG0lVuiToCxQJsO8ZR9y/R6x/tyueGPv9WVV3ANjIBmr8nfPCV/EApg2JON3+NU=
X-Gm-Message-State: AOJu0YyYULauUBOJJvpzxve41D3wEjZLjwIUS2QaaptMt7If0CWH9ywb
 SJkRWHXDwSdlGUp2ZdbSbjzWe0O/AyX6M4VEMTK5Deybqg6wYW7Jn1cJYyFe2ETzHZMWNCqMxDM
 kZ6y1Yjh53i0vHibnNITKjitSksjh5rPPd55HjiUQx/9qpFzfF42x
X-Received: by 2002:a05:6214:e67:b0:6b7:a248:3949 with SMTP id
 6a1803df08f44-6b95a6e872cmr97192506d6.38.1721645904540; 
 Mon, 22 Jul 2024 03:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW9uJ6rXuiatJrnBVurqRiYEH5jZ+s7mbq/yEpIAtWKsuHREzota/YAirI1/hOJTAE32hJDQ==
X-Received: by 2002:a05:6214:e67:b0:6b7:a248:3949 with SMTP id
 6a1803df08f44-6b95a6e872cmr97192346d6.38.1721645904115; 
 Mon, 22 Jul 2024 03:58:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b96a49d2aesm14917726d6.84.2024.07.22.03.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 03:58:23 -0700 (PDT)
Message-ID: <24401da3-596f-4ded-a367-4048d0565582@redhat.com>
Date: Mon, 22 Jul 2024 12:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/smmuv3: Assert input to oas2bits() is valid
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org
References: <20240722103531.2377348-1-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240722103531.2377348-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/22/24 12:35, Mostafa Saleh wrote:
> Coverity has spotted a possible problem with the OAS handling
> (CID 1558464), where the error return of oas2bits() -1 is not
> checked, which can cause an overflow in oas value.
>
> oas2bits() is only called with valid inputs, harden the function
> to assert that.
>
> Reported-By: Peter Maydell <peter.maydell@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA-H=n-3mHC+eL6YjfL1m+x+b+Fk3mkgZbN74WNxifFVow@mail.gmail.com/
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-internal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 0ebf2eebcf..b6b7399347 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -599,7 +599,8 @@ static inline int oas2bits(int oas_field)
>      case 5:
>          return 48;
>      }
> -    return -1;
> +
> +    g_assert_not_reached();
>  }
>  
>  /* CD fields */


