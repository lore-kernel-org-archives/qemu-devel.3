Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F713D10384
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOABy-0002hW-LO; Wed, 26 Nov 2025 02:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOABc-0002Xh-3G
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:43:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOABW-0002L7-87
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764143006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GwVKQe4tGCNlHjePycJf4WtiUIlYFWhICGy9rwiJ4yc=;
 b=a+/5smJqJhDw4zVeb9wXViZqKjSNzCOHcg4aU/2IgL8yITYqnQ7Y7VPMQJr+ZANmVOepip
 u8dRlQ+fBDi0tjkANaiLuYT66/v5gy7DErFvSH+dQzwzmH7i5wdpxQ3+xEpJ3nFDk7WkFS
 uXqQ7xGyuiZd+pDPLxJ5rGLc+7yBf8s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-lx8rmbmgNI-DVduCMRVf3Q-1; Wed, 26 Nov 2025 02:43:23 -0500
X-MC-Unique: lx8rmbmgNI-DVduCMRVf3Q-1
X-Mimecast-MFC-AGG-ID: lx8rmbmgNI-DVduCMRVf3Q_1764143003
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso51955105e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 23:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764143002; x=1764747802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GwVKQe4tGCNlHjePycJf4WtiUIlYFWhICGy9rwiJ4yc=;
 b=DColkfTL/hZDGo16oDNUjVZDAxuDgiPgP+oSCD4ZWblUnVHVt5sGby1DiSENIfFIrC
 wdngTvuyOT9ZamuWFeOW/HYz0jJD42G0XyJCLspsmHsqwKyVNvYOhk31tXPoGHyaWC16
 ZztuwmWLMLunEU2mYRYwPQcEWDvVsorB/2Wj43XnUdgTehMq0qZD9Lc7dRqDB5SHha93
 EEUJLG45nzGNliUFdMbz+CQ+K/3wEjPMUvIiY/dO5W2GpG5tJzY0YXDaZwYYq1DE3A4X
 G5XAcAlDhtFWm7aeKkGB3v9EFG3aPIT/rAZiqsWA36JwB7bWzeUGRFX552jKjWD3I668
 2xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764143002; x=1764747802;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwVKQe4tGCNlHjePycJf4WtiUIlYFWhICGy9rwiJ4yc=;
 b=wexor343J9qb+GdFvYx0KiFxAuwY2QlbtcZUkRAMXRxfH1K0xgdwwgbIxWnX6D1o/Z
 CdHt90nf99euEsMzUEnBe3R4QluUa1l3p5a06hvQ7eYwh4uVYaCVMCan0UvUsPAm3PWz
 y99Q3GXdFCpMXJgJhj8oVfwwp26l/XgtLj04EGb/wXcHR5Wf4o66PTG1Jo+RtCfwG/CJ
 DFJkzGMhpw92M0iwevmbKhIB3WbXYTqZffnSDS4gc5ZknC5qp/NDS90K2+64+uhuu4Dc
 /dF804coiII0jGEVOxJp4767oVptSQnDTyDyHt3UNyjgq5BhjYCz+arwMpHxqWc7DvZx
 l2dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUppgwt9/96U/O2aYrkJxNbMpk4YJJmDWZDWK3h/HOYNsha3c+KIdY0Em0QOYl+S83OumLSdDdrSkx2@nongnu.org
X-Gm-Message-State: AOJu0YxYQTLVsmiJ4HcHXVGx4i4wkRq0IYPFUveLj7p+e56FrEiYGKCM
 OYZkTu37M5uDOY7irL/+bcjQYfVT+XBHGfNVw9z+Wqazxb2DWQ4P2dG+TRUhNub5aDbvSg2aFC3
 FsJfiuHiX5QFJsuedB5OyZBV49ueWxHtDLqQrLkiFfzlbWVFZtstGXo9+
X-Gm-Gg: ASbGncsDgHOXepxwtOMkc971Iph37AitByD12G9qkvw3DTWBDckENLXt6wFg/sENZYN
 G90Zb7fWhdbJ/ypCxrbSnOI31CunFQXQuJO81pTCSQc1Fe1JaS1Kta2rHKXk6V8hFuSSjrXDAWT
 9lnwEKKMRjnQG2x+cNBDnZt/2YZKvSUhbDdfH1GDJsscDTroIasCv9+JEyzlC7KM46FFrW6K9ck
 m3xOYrlzto86uS46IgNIrBkyJ7d9u15hBakOvZrj5wMiFCLScSaWMjRFdGvbnQp7EKg/8nf92s/
 JE0+RxcrEqhl+bZJLYFAPAhhsGJFAnrfJ6XWuhaN4TEtIqqN2Fu3HlrECQmvinWVpTuYlqn71ii
 nyg0MaMghKGRI035D2lwl2s8D9xakymcnCQxhcGo2iIHJ0YX+
X-Received: by 2002:a05:600c:3110:b0:477:b734:8c52 with SMTP id
 5b1f17b1804b1-477c0185bebmr198830045e9.14.1764143002624; 
 Tue, 25 Nov 2025 23:43:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI7rVtKNv4T84OSDGXZoIVK3E37+j57aH0vrqYEjQJMGS9Y82Ycu2QFu1uNbvASC9/lHJzLA==
X-Received: by 2002:a05:600c:3110:b0:477:b734:8c52 with SMTP id
 5b1f17b1804b1-477c0185bebmr198829755e9.14.1764143002137; 
 Tue, 25 Nov 2025 23:43:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34fd1sm39580144f8f.11.2025.11.25.23.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 23:43:21 -0800 (PST)
Message-ID: <cc6af1a8-f87d-4094-aeb8-d0c2d0b77e54@redhat.com>
Date: Wed, 26 Nov 2025 08:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 2/6] Revert "error: define g_autoptr() cleanup
 function for the Error type"
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
References: <20251125204648.857018-1-peterx@redhat.com>
 <20251125204648.857018-3-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251125204648.857018-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/25/25 21:46, Peter Xu wrote:
> This reverts commit 18eb55546a54e443d94a4c49286348176ad4b00a.  Discussion
> can be seen at:
> 
> https://lore.kernel.org/r/aSWSLMi6ZhTCS_p2@redhat.com
> 
> Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Cc: Cédric Le Goater <clg@redhat.com>
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

Is that related to CID 1643463 issue ?

anyhow,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



