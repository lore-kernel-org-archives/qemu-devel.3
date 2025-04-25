Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE97EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 12:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8I8r-0005Wz-IT; Fri, 25 Apr 2025 08:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8I8h-0005UM-D6
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8I8f-0004kv-PU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745583999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nrNkAiUNSf3AiXnNnPdD54s46S1PPaV8lHrRmxNG4NE=;
 b=ET5OXa5WQ5s3isgQFPUaTzIM7ZU7/T66WrFhVe8uKBPEdHe5xloVL42Er+Dl68t90H8SBQ
 u9KtBKZzqpFOy+ue9QkHkSy7FrBoqsGeW9l80nYYt9oE9XC3wGP/6kZpUrHNByj5q4sfkI
 dfwqnCbNKFJAuJ2FP6PvKeqaK9XFTVA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-Qj6dNauyPPC-eSVq6ph8ZQ-1; Fri, 25 Apr 2025 08:26:38 -0400
X-MC-Unique: Qj6dNauyPPC-eSVq6ph8ZQ-1
X-Mimecast-MFC-AGG-ID: Qj6dNauyPPC-eSVq6ph8ZQ_1745583997
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cec217977so11472435e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 05:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745583997; x=1746188797;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nrNkAiUNSf3AiXnNnPdD54s46S1PPaV8lHrRmxNG4NE=;
 b=KJszYqgwT1Si0obTxfNOzJFdd12H87y/FPevuMVQablM6qAtSqEHKQ0I8xfTEQpaqv
 l2x3NAOoUxOVE8VcgC3ak33ShN6TOjtMQJo5iqxE9G2yl7dpuIcX8CTGrppeWELhXU8X
 ltoUClW4GF3uwn7IO7kNg09Xmk+S4OaZu5xfTvgx/p2KkX6Dswi8Ia3jPplSFxEv3lue
 JsvfexsV152+xSgC9dhHaDs+2Rg+xebliX+1GwP5+lRJRaEZDkqOIrHx4iqOW2bXGSQG
 LB0zmCTUzt/69bUYB/oByAQ1nGEcoeaUzwCCwjKg7VLK/2HzpE1AmOfcLqyzrnqNRdIF
 z0ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSXftTA1xWU8q6YxjlDEwZn3/rkRFUD/8CIdLhSrQx2FHXUKd9ZVsWKjKnjaoo4wxQdzXCiKZAK0O8@nongnu.org
X-Gm-Message-State: AOJu0YwO2sr9qToC6J+7IYpgPRPBgNYqMqQ7qnVGaFgtsh2G0l90KaA3
 pro7ELf3Fb3OQxxWjTNg9m5Yk02/m77CvJE12cWuaffN31VA+cka0egtUmJT9NcxAiUwysCCxmx
 xq8KzZS0Kd8Vo8jsGJAnG+9KgfLq1C/k0jbp4f86Ofy1h+B0ZYKSq
X-Gm-Gg: ASbGncuM1nZ7KnF5CiM3GWQfe7SoLLo5WfqBVfDN9j9qNptKsHGG77oVdffYwFnLBEm
 t/q4HSWSgVJDLNMiykfxpD+hNPojpRKDDjOOIkNSISWyNU1DmhfgLrjA64KKRzUSKYrqoUZBvKU
 P5spszY11oQP/ENZnlg/xOEKwdmw6zrNB/zI9JjML+N840evn8Ze1uCqM63K1SiJswX1AzwlguA
 vAoZe8SbWP7Fplem2bi+VZU/V2+So02m8G2AG/wdW7eORHQY5CURiEIuIkh2Blx7KlqXrTfFqaH
 Z1oq8YFcUaha6suqA2nQALnyeKbdcMbpjvHmMakza2rBNQ==
X-Received: by 2002:a05:600d:f:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-440a66acabfmr17913015e9.30.1745583997109; 
 Fri, 25 Apr 2025 05:26:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2OThry8LVgUl7Lj2H0VnFzM04DUt9iECE59WPgEKK08XR/cHnIvVRt84J54i5k7+vLpsniw==
X-Received: by 2002:a05:600d:f:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-440a66acabfmr17912825e9.30.1745583996732; 
 Fri, 25 Apr 2025 05:26:36 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-178-177.web.vodafone.de.
 [109.43.178.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408d18daaesm54540965e9.1.2025.04.25.05.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 05:26:36 -0700 (PDT)
Message-ID: <c8d1eb76-cd90-45b2-a6ba-e889e5f5b62f@redhat.com>
Date: Fri, 25 Apr 2025 14:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson/configure: add 'valgrind' option & --{en,
 dis}able-valgrind flag
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250425121713.1913424-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250425121713.1913424-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 25/04/2025 14.17, Daniel P. Berrangé via wrote:
> Currently valgrind debugging support for coroutine stacks is enabled
> unconditionally when valgrind/valgrind.h is found. There is no way
> to disable valgrind support if valgrind.h is present in the build env.
> 
> This is bad for distros, as an dependency far down the chain may cause
> valgrind.h to become installed, inadvertantly enabling QEMU's valgrind
> debugging support. It also means if a distro wants valgrind support
> there is no way to mandate this.
> 
> The solution is to add a 'valgrind' build feature to meson and thus
> configure script.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   meson.build                   | 13 ++++++++++++-
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   3 files changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


