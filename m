Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC4EC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVu4n-0003zv-7X; Mon, 22 Jul 2024 10:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVu4g-0003y3-Rg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:31:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVu4c-00062M-T5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:31:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-368526b1333so1717064f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721658693; x=1722263493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wns12XiTd8yS/K47wHNp8N0+Mz+v6AxoZ6X23UL4GAc=;
 b=rgaxoFsVmr5Q7Ht06HADy8+nKE/MPe5LhV0NHonX+nU79zH0KoaFeWDT6UBrenllaU
 UVpoLnlX0wnuQ7BxyYA62W36U/VefASs7HUhgFrYANty7bvExypaUyop1lLnGkH8bjCq
 QtvXtQQCF88m5VtUkAW9Y96/+dn7j1vYIrnzBuLgrdJ83VIzLCLIsffY5zdQn0fXJRiH
 VuYDJ/R2bvk9MgrrnstTzEj8Bk2t6SXtBRlGXzqQH/6ZmslX9g5uIAaA20GB7D21Bwtl
 LMX9LT+db0x4UnZpeuCj4NauPnp5NQt6Oz3YoVD0Ka4CUpSCGIQNPhb9XZBw5OVqO5ih
 xT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721658693; x=1722263493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wns12XiTd8yS/K47wHNp8N0+Mz+v6AxoZ6X23UL4GAc=;
 b=cFnPW5WSyWZglCLUb7FTKb7oHkIz3TBYKpMrl7/mxtOq/We/zRli1A89tWpWWWgvRm
 UT11NAYukPuBKUBNgj5/iAJUP93V2R0PaEnKtLERgjMABKSstQLtnhk+j2C/VuPY13H4
 jKApymAsmKRJCjSSNrzyGx9Btk7AjqJWx+RQ69MuS1Cz65lWyh+p0WnDTEVjpZ+8DTWt
 WpBwzirXbJldw2QajzUaXzJakYuL6ejQ6ljb6oUPdesSyh127tUUCC6Zs1YqwPeiHtE8
 t4SC6jd6Pc+R7ku+SDs4HBUKpQj6yUMjlntlJ5zv6yS/Wni51qWLy49cVK64uRMaFc0n
 kohw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsyuAo1QwriQR6zYZS2diWA6niW331QbMhWsJY71AGq2wY3O/ru4ahwtaqXG7I68ycXMlAORof5oPTPNtpNdce4eBcKmY=
X-Gm-Message-State: AOJu0YwWqzAk/exb2/y2shDv8l6dKyf9MyQA659fDaFLhPa7dguiLrMH
 KmKVZSlocFBNlqwFgnLmpfjvJiFEpYOTRQkA1ZW+c9P+NxM7xtmNKvbSIL2ygpw=
X-Google-Smtp-Source: AGHT+IE06CndVPmhKCiXB/6m0kNGpgkCM0ji9IshPMwVgF+gVamR1AgNWx0GlomHldeuSFlpKOs94g==
X-Received: by 2002:adf:e8ce:0:b0:366:df35:b64f with SMTP id
 ffacd0b85a97d-36873dc1f38mr6541551f8f.4.1721658693325; 
 Mon, 22 Jul 2024 07:31:33 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a5c356sm157623455e9.18.2024.07.22.07.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 07:31:32 -0700 (PDT)
Message-ID: <ddf31355-5234-4371-b4aa-b72f2e6ff73f@linaro.org>
Date: Mon, 22 Jul 2024 16:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] qapi: allow for g_autoptr(Error) usage
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240722131611.2820041-1-berrange@redhat.com>
 <20240722131611.2820041-2-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722131611.2820041-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/7/24 15:16, Daniel P. Berrangé wrote:
> While common error propagation practice does not require manually
> free'ing of local 'Error' objects, there are some cases where this
> is needed. One example is where the 'Error' object is only used
> for providing info to a trace event probe. Supporting g_autoptr
> avoids the need to manually call 'error_free'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qapi/error.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


