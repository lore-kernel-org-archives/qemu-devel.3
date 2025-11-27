Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7477D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 15:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOe13-0007nG-1Z; Thu, 27 Nov 2025 10:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOe10-0007eM-9S
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 10:34:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOe0y-0001SS-3d
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 10:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764257674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y8r1yOOz9Khbbk1GkOMold/wudTKJBJ7bMRJcmnlAMI=;
 b=G8YsRhvU+P50htATfXJGcVCQdIbKLXpJ8n4kfm+vyrpX78HJEnr/mAPWeO1i0hFcEmaye0
 OThfBHGW7B2ISrV3R+nDrSV5AEm+pEp6xw4OGprrhZUWZ4NtVdSVxIiKXFX9ALlC8y2IY2
 Pe3Kkhqphd6vVhJ39LwVSX8uYuP5B8g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-WDKJHH_iPpGDyIRkrp28rQ-1; Thu, 27 Nov 2025 10:34:32 -0500
X-MC-Unique: WDKJHH_iPpGDyIRkrp28rQ-1
X-Mimecast-MFC-AGG-ID: WDKJHH_iPpGDyIRkrp28rQ_1764257671
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c7b0ae36so799661f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 07:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764257671; x=1764862471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8r1yOOz9Khbbk1GkOMold/wudTKJBJ7bMRJcmnlAMI=;
 b=GN6HbZMWLbLUkB+e2geGE5ZAzPwBuX7vt2C+HRpnLwpaVgeCExQrORFPktEdpQzFBl
 M9QryOdb8vENsYvfzAorQF7kZ8tCtu1hWesGqN8CpKSVV2YPGNMDSlqDIMg/FK2rniuj
 GFXl6SSHuInjv0mzGs6z3XE/v40oP5B3d89ZNqKrGeAKbEdUSyfEhIi704A/u7/Dzwh7
 xwsnxI7jDaV9+3jR+bJNXdVRtfUyvfISuJv5/UHFQzk6E6MuFbc+0i/zafLyREFJDXKQ
 3Oi9KZRh9MNQN6D34RsMXV/UtBi7IzeIYYF4mh4MDV45ub60RTx+xadnnFqnARWwvxvX
 s7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764257671; x=1764862471;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8r1yOOz9Khbbk1GkOMold/wudTKJBJ7bMRJcmnlAMI=;
 b=eQTYfBmytrJn30dAreB7JPtdv/DD8YchBQNuYOmExS7cxIPuwtCJ1J2xK7z/X5RKkY
 J4ZF27Gd0NF3QlaTerhBXmp7IKamRxNjHot75k8i+0U62Kq5C62grV04T+8rwKZoQ6qD
 tey2G7Tgr4kK6Reb5aXl16ruxz3sREs9rARABuoYcSdyy5Pj/LTmeUwpCD1w74ChpmC8
 AjvlQSoEtdObKd19nslRqHv2cEACaRRlo0hyLi92drixxpzkXgd/1g1k4z/DRJtkHasy
 rhxJRXy/tr7qI73oWenno/FZ8SiMioX2Iw4Xlf/zvprWSMf+aAW62UrWCh7klUvgWwDq
 apHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6ulIwJu5hFlGmwaBDANuUQNg+TF+n/t9qW7GS068oLQYjdQm/OHae9aJtGSdJo3k1/vDeEU+mpVKn@nongnu.org
X-Gm-Message-State: AOJu0Yz3YozMnIrbxvqIRdwD7B5ughL1d4RwxHjAMETR45LVESgcIrAx
 FChb8+DAzdYKlno2TkPue9n1DCTUStyf31efHFZG7q8Frr+fuh0i/kb9BGHPHW92cflmUNAzeck
 T09aSep9GrZ0P1VNxDnx0lis7o8fLatPbhGa7Q5zQq9zbyJNKx3vgdhNBViwv3gOy
X-Gm-Gg: ASbGncvsOJlObfPADwpDQW1KuwWIYR6dtbBITVPOBGKbnUH+DxDwOmAlWaOvHERGUFM
 igQf1rUQx1+KV0c+8hiH65Q0cKpmkpxh8m6GOpMd4EP09r4EJg9rvDOIOOELpV/zk6F3Myd9CpB
 aQRyRaMOG8lHdtVT/mGfreRvM+sH+hO3XGiIafVifqxY58FcQhqcBz+JEffrhJYQfXHNFZmgH51
 xBi9BTJeCT5q5BAIlSA3Ompd1UO8gK29cKF49vdF7WUxS8wkTk6qfEYw/+KnSXM0Bu96U1tIpgJ
 9+VrvQTiArd+PDEVitn8AdypK8j0QB8zkUsq5rDDuQYcjuSmPmitopDBD6c2TaoiQXMbv4VdDjH
 q2buh2haAWukIJLIMaZP12X8skUW/3/En9E2qsJkcV45qazsZ
X-Received: by 2002:a5d:584f:0:b0:428:56ed:c68e with SMTP id
 ffacd0b85a97d-42cba652ec0mr32452047f8f.9.1764257671024; 
 Thu, 27 Nov 2025 07:34:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIqsnhWIP23qSq5Dx3s3wyj2bP561pNoO+ptmio1U+aPOSvU+bLm/ZX3XuwB3uf2ZParwZbQ==
X-Received: by 2002:a5d:584f:0:b0:428:56ed:c68e with SMTP id
 ffacd0b85a97d-42cba652ec0mr32451999f8f.9.1764257670548; 
 Thu, 27 Nov 2025 07:34:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca7880asm4206890f8f.31.2025.11.27.07.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Nov 2025 07:34:30 -0800 (PST)
Message-ID: <678d6b37-6799-4029-9ed0-6c20db807e6c@redhat.com>
Date: Thu, 27 Nov 2025 16:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2.5/6] error: Poison g_autoptr(Error) to prevent its use
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jmarcin@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, berrange@redhat.com, vsementsov@yandex-team.ru,
 mail@maciej.szmigiero.name, peter.maydell@linaro.org
References: <20251125204648.857018-3-peterx@redhat.com>
 <20251127071028.2745789-1-armbru@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251127071028.2745789-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/27/25 08:10, Markus Armbruster wrote:
> The previous commit reverted support for g_autoptr(Error).  This one
> should stop it from coming back.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/error.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index f3ce4a4a2d..2356b84bb3 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -437,6 +437,26 @@ Error *error_copy(const Error *err);
>    */
>   void error_free(Error *err);
>   
> +/*
> + * Poison g_autoptr(Error) to prevent its use.
> + *
> + * Functions that report or propagate an error take ownership of the
> + * Error object.  Explicit error_free() is needed when you handle an
> + * error in some other way.  This is rare.
> + *
> + * g_autoptr(Error) would call error_free() automatically on return.
> + * To avoid a double-free, we'd have to manually clear the pointer
> + * every time we propagate or report.
> + *
> + * Thus, g_autoptr(Error) would make the rare case easier to get right
> + * (less prone to leaks), and the common case easier to get wrong
> + * (more prone to double-free).
> + */
> +extern void
> +__attribute__((error("Do not use g_autoptr() to declare Error * variables")))
> +error_free_poisoned(Error *err);
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free_poisoned)
> +
>   /*
>    * Convenience function to assert that *@errp is set, then silently free it.
>    */

broken build, even better.

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



