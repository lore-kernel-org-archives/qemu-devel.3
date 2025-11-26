Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D261D10F5F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 15:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOHEl-0002Z6-U5; Wed, 26 Nov 2025 10:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOHEY-0002PZ-1q
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:15:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOHEV-0004V1-BV
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764170100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+xcAFm9Qkh8FxT+ZIvkdIG2SHlcKGEQWg4p/1nrfU9o=;
 b=UxhJRHI+B5Q1syOBEUA71cYVUsWWvr1tP2UXlLPUW61897NibEWDt3eisPKNozXWpCk5/4
 RYE2HY7Y1BjYSoo8YJq1n4wcXz/KKS94yW+KAUHQCPSAXsm0e1YliCE0nD/QcnoGF92+Zh
 eKfgMEGteTvVdB+LEyNAIKfzbxAD4mI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-oMcRxyGvMGKWDq-OyncyjA-1; Wed, 26 Nov 2025 10:14:58 -0500
X-MC-Unique: oMcRxyGvMGKWDq-OyncyjA-1
X-Mimecast-MFC-AGG-ID: oMcRxyGvMGKWDq-OyncyjA_1764170097
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b7689ad588fso445688566b.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 07:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764170097; x=1764774897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+xcAFm9Qkh8FxT+ZIvkdIG2SHlcKGEQWg4p/1nrfU9o=;
 b=MaEqf6VF7AwVaTmTx9OnNPJoqHImDXj3KtPcq7VoVCDxl7zX6aEF7rM0PMZzYExz5v
 Fq5GwPPdmPLpXGUnBIro64OIvR9vcbNw0ym+AyjHHjjgMDVlCPHxWiDds/KVCaOyHIMd
 4QJNIjUEnpF9Nr9KODgA7cn+3ZU94FtvJZtEn8xgY/uo3MwlYuJdrUVjZNWK9dvr8oVn
 AfuxX47xINAxSEEb13B++D8bWcMZ57QVKWYrkQ+ijpoqZYv5p0Q+U2Mh4unnKAuHzRik
 9TuhbH4zSIC4+NvnYsGaAvnwPF6hszOsRcKmQg9W1GnfYEgmHYgN7fyxliuywZ6PhBin
 +oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764170097; x=1764774897;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xcAFm9Qkh8FxT+ZIvkdIG2SHlcKGEQWg4p/1nrfU9o=;
 b=j479skOX8Uc1/LxTJY/ALzeGTu/6B62c6NeDVr1SsZG53gZQIfJxyvNSjpbP5YuLG6
 Ngr7OdUAnVN98PmH/JAOiAywQ2ikNwq4vQV+8J4woVImAOGQFanrEnWYMbBPglDiWcDP
 lifOEVCP/PL5qvm9k2VA3UdONnnuLhO9ZrXgdWG//RKzzw2Nxoqq+Ca+fbyE773piATb
 zgOw/vCPUzBc+X5Z0pb35KJ7/VT0SYYd7Q+T+uChY49xOvb0nTLbrKLSUSG0riGZmLK+
 R+jJjnoOH3GiqJRYYu60yJSwCLjRVn/EkF48Emu5hekHCOKf+DarZQ3Y0lO59Tdc9fd0
 0icA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwhO8p4+RNv50SR0tclxmWTV66VHTZrVAru9DvRUV4ix7MAtNa4LnUsReJDjGNANCCC6qpaoExu8CD@nongnu.org
X-Gm-Message-State: AOJu0YwYsIQtdBtZ8L1ob4cdJXoTCHh50tVcMEAY+DqqDJeq+UOZq9Ye
 Wcp+7ATdpnqlEw0WXLncDd0jz9fqD25obmDmuOvrlLIKDPrqG/jOu76OxiZGjLm36jVlx7wV8I/
 +yqPZ9yelUsmrvAnsJiIiFSEazVv5co8CNNwJfTCvRN+wPpj0RbivLCCpvKeFyBrr
X-Gm-Gg: ASbGnctwKy+AGfH7Osr8Cbww6NoBacG/yfL9rJQtdL9HSRavy/Yltoz80DPupyhgsCS
 z8nmwwaf3MxlDekRPSXHFod4Rg2WjkWgp5lBsJQA316/ICH0f0XUBcdCifWCe2Bi7/F2hAKNGMh
 vHxDXrbOVPTqTtRGCAtkJEleATsDozhRztdYjRtW6sufvv7ZFG3IZRJoPGsA+uDmy1t/sUtZ+8y
 8ibt6c6/DnxggFk7AKXhndC5/kOCAhjvNUgpaz9k1Ur4p/0umgEUIlxVqnueWQEmU/Dfy5mC4bn
 NwlS8TCVftVhHTsJoEPqoptdjI9QuoZ6hAzQVTZ5VE5jqiFnUobOPidn6We+upiiQdS6dcqO0cv
 C5iwmoDscD6x0JOf+eMvC58Lu7qDp0KDBsrkaQuOGHYptvcdh
X-Received: by 2002:a17:906:17cd:b0:b76:84d1:5dc9 with SMTP id
 a640c23a62f3a-b7684d1609cmr1333625466b.45.1764170097190; 
 Wed, 26 Nov 2025 07:14:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRqqNN9hOGIVMaKm1SrqHYfB1hoODFLMacIIZQUnD3dy+JDSclvvqCX4kp8nENRYyv3nAB7g==
X-Received: by 2002:a17:906:17cd:b0:b76:84d1:5dc9 with SMTP id
 a640c23a62f3a-b7684d1609cmr1333622266b.45.1764170096692; 
 Wed, 26 Nov 2025 07:14:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7654cdac18sm1873333866b.11.2025.11.26.07.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 07:14:55 -0800 (PST)
Message-ID: <620bdcd0-a7e0-4b23-95c9-9752156a55e1@redhat.com>
Date: Wed, 26 Nov 2025 16:14:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2.5/6] error: Explain why we don't g_autoptr(Error)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jmarcin@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, berrange@redhat.com, vsementsov@yandex-team.ru,
 mail@maciej.szmigiero.name, peter.maydell@linaro.org
References: <20251125204648.857018-3-peterx@redhat.com>
 <20251126143427.2470598-1-armbru@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251126143427.2470598-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

On 11/26/25 15:34, Markus Armbruster wrote:
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/error.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index f3ce4a4a2d..fc018b4c59 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -437,6 +437,23 @@ Error *error_copy(const Error *err);
>    */
>   void error_free(Error *err);
>   
> +/*
> + * Note: we intentionally do not enable g_autoptr(Error) with
> + * G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(Error, error_free).
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
> +
>   /*
>    * Convenience function to assert that *@errp is set, then silently free it.
>    */


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



