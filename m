Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC65CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOEL-00057U-Iy; Thu, 30 Oct 2025 04:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEOEF-00052b-JB
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEOE4-0006en-7C
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761813698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lnRHmoB5Cq94aAjyX9z9r8SARznNLbUgTc+Bj2O2Hk4=;
 b=Cr/ihSu6PDDvFEs2yLc1wm9qe6K4oge+k06mfN9z2QpRzZ2aBgfl+aeUDx61sqnC5ehjt2
 4ewSY+EpAoKWnwvUUBGdVLCSgRgFYPLxsouhGbFIpiY8KiHcUb1b8NNO5It6PnQR50E15C
 wiNe04VEx1PFa5wPrEuONPaHfAwtjv4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-VtN8iG1UMU6q4dCpUQwfcQ-1; Thu, 30 Oct 2025 04:41:36 -0400
X-MC-Unique: VtN8iG1UMU6q4dCpUQwfcQ-1
X-Mimecast-MFC-AGG-ID: VtN8iG1UMU6q4dCpUQwfcQ_1761813695
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-427015f63faso422443f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 01:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761813695; x=1762418495;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lnRHmoB5Cq94aAjyX9z9r8SARznNLbUgTc+Bj2O2Hk4=;
 b=td/cUKdCEykDaLJm31upN+pAoQYsiM6lglN5CODYuhsH3zGlRn5po4ACsjX75tcV9K
 9qSpsGTQDcqo5r0LFuc+sDyaqd1XA2VtThAdZvk9T96zUcWb6JTyzO6MQ/2R9m6nck6H
 Wf9RV+5lggsvDeGZK8E72HkBSEB/xEwJWSq2xcXi3evhN0DG3FB20IBevqOapAHkrBXY
 bfg2rRfUFQ6X3PqrRUj1dSd/esXlbkNq9j6kVC2YwSLNNFTvOJM28eEAYCu4cHYgeKE6
 IRUC8WTDlqrn5TN5+MNjWf1Shjy8WXqHvGjy7pCbSDKBrt7fjJBOZL3eYOAok2d1amAY
 rt/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrTOyi4kH2LwOvjmyUcSJUE23GQAdTdhEs0XuFf3t+JoI7Gjq7HK8MYCdYaXEHV4EdZiSIiBlL9u4r@nongnu.org
X-Gm-Message-State: AOJu0YyIQN99u6BcGzoHER5MqPkjbGlPgSS5T0L8l/IAiu8jjnkwlG7G
 pW3ZvkkFRPxhzuVdwXzHFRoVg72dePG2UZegH0x46A3zISzvXsv/EBHkueFLHdPgO24aUtW6AJY
 RhK73QBuWMY7tOf3jUc5Rhxui48SdFq3v6GCisiQa1EZaa3FJddCGmATxqg7F0EOG
X-Gm-Gg: ASbGnctaqe+2Rm4EmJ4XWh2xQwXDZFSDO8WTJAOpQUZvRPyoATvMAmJBVGeda4nuEnc
 Pkc8CIMZkHWndYax1Yd2SH+oJTdz33B0fuJXb85d3VkswKMvF8MejnozTzvtVBDgmzZQ9dRWsA6
 cshC3lbxdsQv8oBHUuEb8Bb/Ww2BT0bFfm0BmYP1q9SzFghWsHK2YoDhZrO55yX5rYRINfRBaZI
 9aRKNW5dlA1q8DcsyC6hUj/f+38f6naIbRxu5Ym3dZIeVzvWh64nH7lcxlL/w0Y+wgACPrm6cxL
 b6P0HFU9TW2AFm6XKGiqBQmaY2kvsZZdnndowMq9z5ghOjpwaFM3C2n8TwoAsplrRqdWlwM=
X-Received: by 2002:a05:6000:1a8a:b0:429:9197:5b31 with SMTP id
 ffacd0b85a97d-429aefcaa88mr5257919f8f.53.1761813695472; 
 Thu, 30 Oct 2025 01:41:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJUgOldO5Pvag4OWP+0tRfmMue1vGq27cPj8qBo20jRh0Ltq+1nf64XBLvFUXwjgGCfnXq4A==
X-Received: by 2002:a05:6000:1a8a:b0:429:9197:5b31 with SMTP id
 ffacd0b85a97d-429aefcaa88mr5257893f8f.53.1761813695028; 
 Thu, 30 Oct 2025 01:41:35 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289a5625sm28438455e9.5.2025.10.30.01.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 01:41:34 -0700 (PDT)
Message-ID: <f58ea42a-8fd9-46ed-aeb3-dd7a15709721@redhat.com>
Date: Thu, 30 Oct 2025 09:41:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/10] python: quote dotted dependency keys
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-10-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251028220342.1407883-10-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 28/10/2025 23.03, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   pythondeps.toml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index 70e83320855..a5cdf94a791 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -32,8 +32,8 @@ sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
>   sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>   
>   [tests]
> -qemu_qmp = { accepted = ">=0.0.5", installed = "0.0.5" }
> +"qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
>   
>   [functests]
> -qemu_qmp = { accepted = ">=0.0.5", installed = "0.0.5" }
> +"qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
>   pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }

Uh, why not immediately using this in patch 4 ?

  Thomas


