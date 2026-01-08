Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA9AD185E9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 12:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdomv-0001yI-Jl; Thu, 08 Jan 2026 07:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdomc-00019a-TL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:06:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdomb-0003ih-G6
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767873981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ObzYSWyPozb3cNU//aVG7ZEbY5iCX98l1YJCEPJpLpc=;
 b=gAGztgMP5Md+hlMd9QE9dYUt1/cDZekW6UpKS4BeeqHmiW+Whk/icLipyQew7/dCRYPY/X
 dXJZKgreftbsVZEGKSy9AqaA8hQ5aTEAgcRLGA1UtmyPy+xZJg1vIHgwNbf2tyS/Hla7hE
 rPOTdyI7SRv4iNAJ2jGvDqpV1ouQM/c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-xSnOL2gEPkq0dfHBY2-hRA-1; Thu, 08 Jan 2026 07:06:20 -0500
X-MC-Unique: xSnOL2gEPkq0dfHBY2-hRA-1
X-Mimecast-MFC-AGG-ID: xSnOL2gEPkq0dfHBY2-hRA_1767873979
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430f8866932so2346674f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 04:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767873979; x=1768478779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ObzYSWyPozb3cNU//aVG7ZEbY5iCX98l1YJCEPJpLpc=;
 b=TL+UzBHrAfaT68NirFCJK25lnykemi7xhg6vo7tXPUmX005LmYUNYcjbusLgj4zybF
 DkJ2zS8E/xqjbV91uIXVe0/mxo43rTlvtZikkBHFPaok+qpmcvAlJX1KVBjN7bLlrFEc
 Sx5cd0rdll9jpzt9FPpjQeXrFWqKLuc5naDORM9+WDQNTZOamKD1rWjikbyirf7WVS2f
 8Is8CQFlaIvveWcm0axpIPRhTEmhQP3EpAaUu5Y7HZdJPTCvebBAP3DtXUTphXQ/LlNn
 rVNIjUe5kmrMhlyjmGKn3KeMUwasRVGIdwAxef6tCvQ6rPNkTchfmV2JzaO35Pr52tK+
 P3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767873979; x=1768478779;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObzYSWyPozb3cNU//aVG7ZEbY5iCX98l1YJCEPJpLpc=;
 b=g2xZp/OkWg1K9Ozjv38MnLMMhfU26oS/xUJLXzKA1XuKlmHOro4E+xxctl9PEh10v7
 Z4l5ylmcdsoSFe8lF3iyT2maqRchKkM2XCplF2hcfJ3EvuE9Uo6UJyUKM4FO3fHZd3Eu
 +q23Q3EJNbKCU7tWzbB3sVYX79j219r8MSEoJF+lZNnS+iYh2vdkjyZLxxAUV1L+0G3w
 N5UqIH5MkYbzcj3NbVC8I9HpZNjaT3DshR3qm8o3LhkfZEzx/U68EJpoBxlSF7oTfb99
 0/FPFoKf520MhOVkcZmEKaTy0JWh9/PYc/+eW+HQrBr8Zamlw95vfviWiNyUUMUw+YSM
 kSww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHTJwEkrQnwc45LHA9yC86lHVO6KxavwFR6zdQpaWFzYFXKdh4ZqFZ4l5SyyYo5k55WtIS0k+3Ph+5@nongnu.org
X-Gm-Message-State: AOJu0YzlBBwi3tOn4+Q+F50zPFxSOqnEAFmxWA3pE4atd8lS+KbvowT6
 Dm6qy9zRHKE3PWtiZf+6dx8CfOk0ME6AEySxMVAApeZKX0Er3AnuJZteGD+fCv5YQivUv6eNXT0
 8iDr0aPUC9vh6pJfgx54PV+rUEGPURjBWY8Mmb+UnHwhuZ6lQsaZgL0+v
X-Gm-Gg: AY/fxX7aMORYiJ94e0n8g3mau5Pi+R/NBBI3YFKdLhXzp4iQ5k6y0HRUiuZE2uybi0s
 yQSEfL8MHOV2eeUckbIZGTRQSL6NhD8fHuMbVz/PIqEWXlOw4xMMOcvpSTTnf+5qj+sbywr2U8N
 0Bnv3tAfagFknPQmiMAWRODgoYAk/XM8+G4ezlPs2djS9BeE2Q2RBxyl1F944NJNCsSacgiisDE
 j/oSnpQ8vzagtkftXXaUWJIwvPugeltO0xqFy8CYsS3d4xKr2zYxiUDUl/tuQyzUt6MX/esEGo8
 fmwwI1JxQeqPsCQ7Ku2hKqY4ExWpPh2zKgbRnr4ge2PmnkUQH9D6eLRqHBpuVL7YUG8rC/45rpA
 /e5gwYl0=
X-Received: by 2002:a05:600c:4f53:b0:477:7991:5d1e with SMTP id
 5b1f17b1804b1-47d84b3860fmr61006335e9.25.1767873978736; 
 Thu, 08 Jan 2026 04:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrY+X3yPqlbA86VDSKym/jPwMB2tD/BGJs0vls0ClQzS4P7eW0sAkdBB/zyxFQN3Cr/UXNdA==
X-Received: by 2002:a05:600c:4f53:b0:477:7991:5d1e with SMTP id
 5b1f17b1804b1-47d84b3860fmr61006125e9.25.1767873978365; 
 Thu, 08 Jan 2026 04:06:18 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8678cad8sm38969765e9.3.2026.01.08.04.06.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 04:06:17 -0800 (PST)
Message-ID: <c4e89cc0-56f7-40c3-9396-6a9d910079c1@redhat.com>
Date: Thu, 8 Jan 2026 13:06:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/29] crypto/x509-utils: Add helper functions for
 certificate store
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-4-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-4-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Introduce new helper functions for x509 certificate, which will be used
> by the certificate store:
> 
> qcrypto_x509_convert_cert_der() - converts a certificate from PEM to DER format
> 
> These functions provide support for certificate format conversion.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Acked-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   crypto/x509-utils.c         | 49 +++++++++++++++++++++++++++++++++++++
>   include/crypto/x509-utils.h | 21 ++++++++++++++++
>   2 files changed, 70 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


