Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56B1C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 21:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukUSj-0007zC-JM; Fri, 08 Aug 2025 17:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUSf-0007wD-S9
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:17:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUSd-0007dy-2Y
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:17:12 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso16984645e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754687829; x=1755292629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pISnx3kV9r59gKhQNkK1Cdbe/7w+VLMvvfkhMfPoLgA=;
 b=RC2xCt/WcKJKm+2rC1/qSjisqdS/xaTgztkwRJiFM41hs6mPRaISUVFoC/OS7Occc9
 tfYUqUe/j+qXYmjCsGgt+fZ976nWJAP0JTclWcjPL35yHRss5qdpmEYzi3RELscTcibD
 njW9TFXo7M6alYuOVSd2Ej+xi0RAtocLbnpOSyR2sPag4NPnTgsy7XgukDqwXKN2nqtv
 IxqywEkboEGlrn0p1Ljh0OFDgtAc8ui2KYn4A+kI5PTrznbnKhgalMTVKXBmPnXNQ5au
 yjegHS3D/h/XScJkK1YsmicJ8L/bKNsDIj9ZdhAkeYQBNZzMlY4GAWMpR5+SrJlTCTbr
 Dlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754687829; x=1755292629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pISnx3kV9r59gKhQNkK1Cdbe/7w+VLMvvfkhMfPoLgA=;
 b=wEiNPtzMBeo3pgwivxwaINoUfPYb5FJyxQUumouWkdOisoQPK/3QIzMvQ8itFijzVt
 x10oHMJu4jNhsYQQN46L75SK5tvrO6XSwd8duNf/hw3DGWL4SapXd7jA/ZhYbNAVPXPr
 y1lZ/WJ3ycUlDgJwNOJsScv3YIg5v7yG2X4xiUMnTClOhxQsJsk5zeUgHhA2glaI3MVw
 tLmCCrqmlruPYEFXTVLrJutfBwsyGxBPMD6DNAGsf3yX8+2uftWMWfJhY1aiF3HPw62p
 d3/8pkZi59knt3hFTtxEzhpc57RXgLIa7coJO/x1GKG8GLAOWSSVDcgg5w6kIayR07Mq
 mdhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX89YROd/jDsxFxEV+RBVs7e5VuNvgcJbUT+ld0PW6AyXITX6phGeM60oBZ46Wr+otvsGOwk5O5Nv/u@nongnu.org
X-Gm-Message-State: AOJu0YyCWrYnGx9R9QUUq8b/3+zLVJITFWE3mEY17rlNrn4IiwsFJVU+
 v8ckvay+EAYEXA+V9IDExbNAjOlzppgCwOHm/AigwmoVKmgll/SAFJz2vVqjH/Z2kBo=
X-Gm-Gg: ASbGncvLhcI+d2IKpBoJKSQOJ1mZy+ZMfmSVLPUdgQf+GZhLcxFd0b73UnOl8ICI8aA
 GuheI2UP2g0KX5ybPQbaIkFDUnRW5gFNF6L34DMqSnKkW8OShNuLjBan5gpnk5A3+JxZ6I9dHV9
 KuDQAEj7QfU+BHfsEopoSSSBVtvwQvKZ94l8nXpVZx8eVbQRbMfVuwQnfl/bxMNXM2xCsar/Zpn
 P/M9FefqkMRbfzL16lRoO0f+X6e3OUEWkGxJXBW09Zuzbq5vL7O3f75eGVDXvGX8CsbgkT3+bnC
 fV3Us2dKICGrFaoCCLYIzups/FM5+sXP63x/rxJz0UJjf4PM4MYkJBEixyk8/OU6tnOphCXKY6Z
 WM04Q58aXnbRWFhSc4YM5d23croDuVXF4E1j2k0YA2nwvTAJY8ZjLFesNdbYozIC88A==
X-Google-Smtp-Source: AGHT+IGxdqiwjz3muCXCID0sN8JyDFY480f4ei693jPW7fL3FTPceyz5gz603DUK0mPlPOvhm2X85w==
X-Received: by 2002:a05:600c:1c8c:b0:459:df07:6db7 with SMTP id
 5b1f17b1804b1-459f4ea223fmr33813605e9.6.1754687829451; 
 Fri, 08 Aug 2025 14:17:09 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458be70c5f7sm274532945e9.26.2025.08.08.14.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 14:17:08 -0700 (PDT)
Message-ID: <d386e08a-b5f2-4ba9-b09c-e4db1badc1fd@linaro.org>
Date: Fri, 8 Aug 2025 23:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] cpus: remove TCG-ism from cpu_exit()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, richard.henderson@linaro.org, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-6-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808185905.62776-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 8/8/25 20:59, Paolo Bonzini wrote:
> Now that TCG has its own kick function, make cpu_exit() do the right kick
> for all accelerators.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/cpu-common.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


