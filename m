Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25700CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 17:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vChed-0006A8-UW; Sat, 25 Oct 2025 13:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vChec-00066y-9Q
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 13:02:10 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vChea-0001F5-Lk
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 13:02:10 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b4539dddd99so660042866b.1
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761411727; x=1762016527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QBxCjpGnr58h8AVd77L7obVcKp22ebEt8elSoiTkfv4=;
 b=ezffxBjkfa1zj5fOhg6zVlODQuGSSaBo7PFzUk1guEPacXgzmospHNJ/cQygoZ6831
 +R1ympDZFFPa5S1ZOw7Ox8Vtzev5nWddahiUPwNKMvTm9q24/4HizCyP4yXxmX6449T1
 TROYCfdEVDSf0h/HlGMZlws+V0rokwQRoDJftsuX4+Jfb3H1NhFyPGaBcpBelOcNBJBO
 XNptpU/Jw4VCvX/uBR5rUEOjRkmYTOMCc7TSOxwp3fptTPjUiwsOnvvy6uTqdPpcxt3A
 OzilHZU8bh4GX+lF4BwTmmZC1WQZG2hTbMnCi2c3WdafQ24kd6ayzH12Tqn3Wg1NkoWi
 sUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761411727; x=1762016527;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QBxCjpGnr58h8AVd77L7obVcKp22ebEt8elSoiTkfv4=;
 b=qOpkxuNQ2dnWseej+5pwVCaJn8ssyyl+LTgOtmU23k3HwXGRWBqeadPpJYINwtMCoF
 e6uh63NW5kpxiT+sURSXm/0KcHIfzLWhQrJFYlCfP1LL0o5ZXBO2AeFaTew6Tp7Cg9ei
 p5ZM950VsQunoVgLJOGsO+VpLDyWSFZYkLiUJVSwIEbpGfBEAvuAy1LVK+zDwl9ay8uf
 9JiNyzUtN6SXBPKhk6NBitOy/aB/EcGiakzQY0KdP/ao+TAR9yBg6TlmPoRP9XxW0q64
 9J8k1zX7nrY0MSeAWFQTgUwqfOlt4lUC2pti5KqWe7D3DCPrZWhOaOoI6R1b17jf716p
 9lhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJNUaYtL6+6vm4UmmddwkmQyZQ239bBGGawKmxxf+g4FZidwFNh/kWv7v1HJD4nwTuBACqMzekAtGu@nongnu.org
X-Gm-Message-State: AOJu0YxX/OoLJlBxgVtTZrUSnfVMpZXtSBhhLHwGVRXnw1u4kdogIIJi
 cizSgpUPpQhesy2aPj2nShpZSb6u/S8VemiNkMynrVAw6o17wu1xQUFMqDZyp2rVdDE=
X-Gm-Gg: ASbGncvKV3nYYzv9T8FgMZfp5UUE6cXQbU2/J65p3ZPbQrKwLx6tLV/T5Y6ZFqkaVNJ
 corWl0Rwm739B4jz1qim3DCcnhGe2K5j7BWYCd4Lyhiypv6ENiA29rDwO8WdnVD4+fB4JZVFUtC
 vxzMqVL4apEDfRTbrvzwgo4LE3IcWkFH8X/b6mZ+tD8Vvq2NkyUknhpYLI/T062GucwX/I/4evc
 MsvU/Vhzhq7pt6xCZsGm61dpPmkgiqSLaxBJcOdwaPfVQppVMX34g4IJXLapLALUzTEMrmC7LHc
 dK5v13STdK8X0frEZcULUE9yAd2anFWy7bGu/LfVQ/6+3VxNLmYgHAhR1ZpwARHkNiKdYxQY8wp
 5W4PXDAo00Jc+CwD09TGN0GF/tKBhLvD61fF3rkSyelcc4i830d63ceg8tzf+vAjqAbMG5cN1NR
 YeUQDUWF7iUsy9o4NTd/WKqjTZ/Vri3a++h9cL9HjYKbzUjqZSIL07co2dJXzgqGw=
X-Google-Smtp-Source: AGHT+IF3XkvxeSfA4A75UEk/cUxJjiwMnj3tEh42vzbwDzUmywwANfKhJ4oE074kJryoLdIal9tVEQ==
X-Received: by 2002:a17:907:3f0d:b0:b49:5103:c0b4 with SMTP id
 a640c23a62f3a-b6d51c4bf45mr1294436266b.56.1761411726913; 
 Sat, 25 Oct 2025 10:02:06 -0700 (PDT)
Received: from [10.240.88.227] (ip-037-024-071-028.um08.pools.vodafone-ip.de.
 [37.24.71.28]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8541fc31sm243637966b.60.2025.10.25.10.02.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 10:02:06 -0700 (PDT)
Message-ID: <71f7c067-0aa6-466c-93ad-243013b56a44@linaro.org>
Date: Sat, 25 Oct 2025 19:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/58] target/arm/hvf: Check hv_vcpus_exit() returned
 value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Alexander Graf
 <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Collingbourne <pcc@google.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023114638.5667-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023114638.5667-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

On 10/23/25 13:45, Philippe Mathieu-Daudé wrote:
> hv_vcpus_exit() returns a hv_return_t enum type (defined
> in <Hypervisor/hv_error.h>). Assert we succeeded, as we
> are not ready to handle any error path.
> 
> Suggested-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Mads Ynddal<mads@ynddal.dk>
> ---
>   target/arm/hvf/hvf.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

