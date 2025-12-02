Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4230ACFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 07:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQLCa-0005ke-5D; Tue, 02 Dec 2025 02:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQLCW-0005kM-Qd
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 02:53:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQLCU-0000om-Pw
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 02:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764662006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IL/CgLBbltSf5+j/BRqCiq686//FC92eteD4NkdVgqk=;
 b=YpQ4KBgQcC2yNx3L/Vu/oVhYzI1oVbyzrlGNZKm0DII5t3js/ZIOmk4vaeEl1SAJc0jwWI
 YwUC6E/CRKuRyvLk45eZUA5sIWicdR/QQfNlSzByhK+4/QDoQW4+Q1fmor0sT17osKzhrL
 ushk/r8nuXlpLppocU+C2tsdAlpbx1o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-P3-MLQ1CN0qLSVTSnvq0xg-1; Tue, 02 Dec 2025 02:53:25 -0500
X-MC-Unique: P3-MLQ1CN0qLSVTSnvq0xg-1
X-Mimecast-MFC-AGG-ID: P3-MLQ1CN0qLSVTSnvq0xg_1764662004
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779da35d27so60702935e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 23:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764662004; x=1765266804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=IL/CgLBbltSf5+j/BRqCiq686//FC92eteD4NkdVgqk=;
 b=EPbiEv9yy7y9iLCCHI2DDq3QEFNwTPEL7/VxXOBdaUUb/LN1PDR/62HsHB1YOmlafV
 h8T2DbJSbq5XEwLvsio/kRxFNszb3LRFxMnCKSSqkOSZAap2RAUaesWGAK+881Yc/oSX
 Vl8TrphC6O2g9ftQmtvP4noB4eXvQzvSncPYl6wg0RTdTc7Gp3Urm1FektDq0FlTMV2w
 vt5j4QLFoDoGymGEYu7lqPLuMNgW0aRgfFkTIuNcW71S4z3ni7M84mNt0ccIpB3D+r8V
 UyPY4WoujPFUGqT69e4rQIQV/ahffcWeuSxX8foeOc4XcEDfW1drF7mrHEYI2paJnvSh
 s1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764662004; x=1765266804;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IL/CgLBbltSf5+j/BRqCiq686//FC92eteD4NkdVgqk=;
 b=Mdzduh4G3DhgkdZQTQ1RGpPJthNrjscUx1D+otuZl84JzTS1WIHeNsAtG2rgFfjKCd
 wIIQRYQnS23uBVhOjuXccE7HwKzCB5yDRIsgpHVOamtfp6Uh3IUxksHbNpSKqikcOoQk
 Kk+vmu0K4Jg8bQhuElfyO4nLbZrIMPMxRMxCadk2i/kSbBSUhEus/RSm2gZBjo460FkF
 2Sd40tVpKgEbXOa389MFhuHSVFsrlStgOwEMnAewJKQOBHjnEs++KQu+FmB6gCIOdUec
 obeZ7FOB+z+e8FPqvZ8lqr455Ui41/29uRknC6pPSsD4GRl3vT1zVMJv6Zz6rev6/T85
 56cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULt+DVorVMKWT6eJI++QoW/6rkZhbhaW/S/oH5LVFUDU3l9oQ3XgC55gZhtu5HCYV+RSFgGVwyxUst@nongnu.org
X-Gm-Message-State: AOJu0YxLh6oLTg8CvWdWFz499Wd+CKDiYfKWhhT/MdNCpTfeXRpUCVAD
 rizYfXmIK/ntopZ9M30j9dUk1RzqsWsJBd2IM/nOQ2eWcfNIK33cvVBiSssVY8WCTyQ8yTAMcDJ
 XCSkTofi42brzvQ9rEm1uevjHJOwpmYdhnDCh0IeykPhel05qMmZ23MXr
X-Gm-Gg: ASbGncvq2Yi0ykPi0u6Aa2WQTDFZI+ACtt7x3FpErrUARzhay7CSzgWZWw+twVwn+o5
 Zkxf89IzNyFBbJdez5Z6jyIyS9fnAwfrP/ucHzDlrJJa3psvShsrXw8haf0cxMfPOvKZB8GMrS5
 IcaR3hjqkXMujY/TygbGmBaxWd50LU4hPlrvjUUDRMbyLiiLCReuclo5s0S2ZAN/bjZeUu9uBqr
 Ma0unDNAgIQ1B41cwQRRQbo8v8aphZEL2iMJqsKV/2W7yyUfX7NrXlovIEEOSjYl3eX2UBXT+Gu
 JHV1Mf6+tSlfi1G+7+E+05Sh4axWB7dEuDTgs3HkpFppAKdhO0pc5oiED0uQA+ue8WDR23GgzbT
 jURyiMggMYv4vOPoXWXxkQFOW1OpJlDfG6qWNKCLBjJJpLQDl
X-Received: by 2002:a05:600c:45d0:b0:476:84e9:b571 with SMTP id
 5b1f17b1804b1-47904aed576mr279811575e9.14.1764662003801; 
 Mon, 01 Dec 2025 23:53:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3PX0S9dSRq5lvPa6AidCh1TMIFOaFIaF6gSIDGEp1NLsWnwkMpWkAhifqFkDXPwB4vPgkHw==
X-Received: by 2002:a05:600c:45d0:b0:476:84e9:b571 with SMTP id
 5b1f17b1804b1-47904aed576mr279811315e9.14.1764662003356; 
 Mon, 01 Dec 2025 23:53:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479279bf8d9sm8102995e9.10.2025.12.01.23.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 23:53:22 -0800 (PST)
Message-ID: <09a4f4a7-c22e-4da7-ae00-d27f7d566d9b@redhat.com>
Date: Tue, 2 Dec 2025 08:53:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 v2 2/7] Revert "error: define g_autoptr() cleanup
 function for the Error type"
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
References: <20251201194510.1121221-1-peterx@redhat.com>
 <20251201194510.1121221-3-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251201194510.1121221-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 12/1/25 20:45, Peter Xu wrote:
> This reverts commit 18eb55546a54e443d94a4c49286348176ad4b00a.
> 
> Due to the nature of how Error should be used (normally ownership will be
> passed over to Error APIs, like error_report_err), auto-free functions may
> be error prone on its own.  The auto cleanup function was merged without
> proper review as pointed out by Dan and Markus:
> 
> https://lore.kernel.org/r/aSWSLMi6ZhTCS_p2@redhat.com
> 
> Cc: Cédric Le Goater <clg@redhat.com>
> Acked-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qapi/error.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index b16c6303f8..f3ce4a4a2d 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -437,8 +437,6 @@ Error *error_copy(const Error *err);
>    */
>   void error_free(Error *err);
>   
> -G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free)
> -
>   /*
>    * Convenience function to assert that *@errp is set, then silently free it.
>    */


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



