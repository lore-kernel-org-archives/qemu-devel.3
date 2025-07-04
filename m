Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121CDC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXkYh-0005DO-Un; Fri, 04 Jul 2025 13:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXkYZ-0005C3-PT
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:50:40 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXkYY-0000n6-7R
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:50:39 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73a8d0e3822so718803a34.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751651437; x=1752256237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qmr+P12L3nuCMlCIGiJaYh9o9rSSDHhsLvCKWcFnCUI=;
 b=nXOFuhbP03Aiv0giT8aM6Ih87o1JK9aSOkTIDk9qPXyzYygPtKvmEqJAVu5AGCUPkJ
 3pCR0N1kLOfUjT34JxDlTQQBSb/3lTIQ8nCxtymX4S8bHv7XgYENKVdGdttwBKiZSkSR
 vCccTcTzj72USllU9+EKNGLPFOsgd3ajXzEnhc9X3pqEi7KlGRNg9vzCkBnGe7keUzX3
 +lsyRVWz+Ge8lZW6J4qcXmtd1/DPe31RFCDWXAvgZtuE93FvPIRs5gfTnmvMluRq32kJ
 oEhVz8eBSvc5wDsCQENgsgdC0iUrmKGg+OAsO7z7P8Xy5wgFBjuIzrfzgpxF7utrfo9s
 aLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751651437; x=1752256237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qmr+P12L3nuCMlCIGiJaYh9o9rSSDHhsLvCKWcFnCUI=;
 b=lsnFTL4aHGGbryldfHZXJCG9TULjGwfRrDfRqUfBtEgY/GvgfLHCqtHgJiphTgeUkd
 IoRAHMK7Z6H3pj+oGd8HQlOdWg1GiURYZMPEjfh1Hve2wKzbjBNghPb7CCLi5kdB2dv2
 zv3j82oGWiNqQrSsuK3apZh3eJxIdm9OaiFSgJ0bZuFC3f57y48WVD9QULN6daM8gv4w
 xrN2ItTFxQWRNxAfaVXgqrZW18OrPUbEPkPOVolDvl7x7AZ3Es2+RVlvhS37moBcEa3R
 yH5WDF9r3FLqAJebkDvu80f55jTT1+T31QspYvIDHDDAsHPim40a9qNZAH8LRYV7QgBH
 lGbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWagZ3+daNqSy5TJ28/NpPj1cmvLftuRUpHlvSo2nsabQRVfad3hzfGEhO+fdy/5ZC/oBwqfd+eyZR0@nongnu.org
X-Gm-Message-State: AOJu0YyIu9RbhOV/Hm6bu4w0lHsFGvrKqPkVZ/bjPFpPjMbIh5hOZnlE
 R/04ZxykZfv8cuBGryfQLL7VizjoRfDDUZ/N2Xua2kYCX7D0VXWRNQqIv9O2OeVp3Oo=
X-Gm-Gg: ASbGncvxsq+IOt2mAD2V0FjOu/HfnJvAGfKZxfEMRXO02V0n+6CIso0u4vHqxgjlQZq
 o8HI2oKxAPaCy7VyJVpuC5AXJqHeo3Crv/P4J6KqNgWzwRj7m6oUYC+VnNI7P15N70JKvcXXc58
 s89cZPh5lOmEFcibT4Yj8aQMYsX4jdMJu30345UsLcHhFOlWgmQmLtJfPHujuIZj1xg3lTKz0sH
 ESE+teJl7M106pENOLgMJwYismixSmWg3LkRjXTIKWsPGRYWgcONziZGb5mOW/0JeaMelLcSs7h
 xPIbdOArxVlvd+Ca2/g70gqdYF9CmYJ7YyEQGUkholo0tyjVq7pUy0IfiVq95TIKZuSmtvIAZNd
 BPm0EhIXBnIcv8vr2IOxG2D0tu5Ysth8talTCOyeU
X-Google-Smtp-Source: AGHT+IGNpXWn+OwHGjBSQpisMuxY0DDQf12uuCH9xu4gvycq2AR+SSZF8S6SloHxBLdMNKuCha64lA==
X-Received: by 2002:a05:6830:4992:b0:73a:e93c:ec22 with SMTP id
 46e09a7af769-73ca485a8d4mr2383963a34.8.1751651437009; 
 Fri, 04 Jul 2025 10:50:37 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f751f0esm454326a34.21.2025.07.04.10.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 10:50:36 -0700 (PDT)
Message-ID: <fa222b10-7bc4-4b99-8fbb-de74db058249@linaro.org>
Date: Fri, 4 Jul 2025 11:50:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] arm: followup on the ID register storage series
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250704141927.38963-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/4/25 08:19, Cornelia Huck wrote:
> Cornelia Huck (5):
>    arm/cpu: store id_afr0 into the idregs array
>    arm/cpu: store id_aa64afr{0,1} into the idregs array
>    arm/cpu: fix trailing ',' for SET_IDREG
>    arm/cpu: store clidr into the idregs array
>    arm/kvm: shorten one overly long line

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

