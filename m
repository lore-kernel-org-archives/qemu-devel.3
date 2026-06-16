Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06F2CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZGs-0006Pg-6G; Tue, 16 Jun 2026 15:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZZGq-000672-65
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:16:24 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZZGo-0004Cc-JF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:16:23 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c85d8615b09so2933478a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781637381; x=1782242181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y09laihlfeXrpZoAkvqPVxo5TWCBfKck8F94Kbnt650=;
 b=JD8YVngMpslUVTfxGyaGsoBa++s68GEwI0M7oTan7O7OQj7OSI/cCPVCQnO7Op6RxH
 BlN9lxwyDg6CdmjI+2duDv5cLSS5NBW0fXJUj+5l6Luogu8A67w96eqAqgxssB3RiF7z
 57dvcxm1YtOLuvNfDOh8BazvXgewgCw9TvQyPbu/zJY8Zpuo5jRltRc8UqOa3bxuw+RG
 1S+3HoTHiPwGZDgpNqMrj6mQsubwnbBj7bk5ZylFHOmA3hNipS7TDhcbdPphETXIUf/Z
 BNJvGMFptcdHnoJ8kGkS3IOqXFNOF28RcSCyPfygCnVoXvIGLAOGY9MRizd5E1Ot9Md2
 Z61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637381; x=1782242181;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y09laihlfeXrpZoAkvqPVxo5TWCBfKck8F94Kbnt650=;
 b=BEx7NbMkHg1yDgCzuugSOcgrdCn3WpXPSH9bI6lbDQ7VO3eAhbirXKz+a1ApSSIR2i
 lTOlCaAokY8ox3078Ogr7inBCpnYtaKDdTIZ6PqtG3/nzEgxRppmvWok+1Pm02QpeCma
 ek9evuYnkRuJtHYeRF1RoxVSx8f7gL9EtwGp0OfEQmqNtYfUKYmsG02pjZFMdfo0pj0I
 /N5PNkQgaojBkykOXX/azuNFTAvjZVm9RbivgsuSFhNZPoX420gRm0tdATnseAtsJMxy
 BLUodegVcivedl0cnneeQiFo5Q8nN/OjDsN1TwcD2r8Wb3NJI9LPWg+uyduKKPev1sbY
 cAUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FMCAw3rhzjc5zhDKmBtiPgQmYQ45xAISNjAJP1vtdAwMNtaakn4fKjola7tLsWU+SKwPvkRXcYJov@nongnu.org
X-Gm-Message-State: AOJu0Yxaz3QZFhE9QaULjykCLHWdKHEukgjpWGDXPk1w7RNyQ1+wWKdJ
 qzObbk6AQ4zd9fhzv3wTeCHa8tz5qO7zIohRfXgmFjAFB95uzuclg+t3FjTRjnbHcEj5By485LI
 dPuZx
X-Gm-Gg: Acq92OHnUG6Qkjp/R3QQjKlk5O+vSdagBkQl80iuU64WpC4zDiJFVaFHj4G6D9+vZDj
 OUiBmgWEtE+FweUHqn/+uC2M6T5ryyMMTyFU+ZEQAiz3LGTHFYgvwwzU01/B7HWwuZDyeGNKFZU
 CSqlKN6i2lZb1tCSxICOC7U9GMaHde6XcJtbS+az8iiR8aNNULvWN5f1ZbcaPB1NKfHhtzsztF1
 uNF/DXPn9IPNxk7ZsqrXoHlRZxLDWeNSheghO7hI52LVogWY02Hii4IZywh1zDZbM03xlbPho7Y
 U8V0mA5PpPWyKjwY9nhPzPCADR+QvqcHfE+qBidojSuriG8DnCWZuJyWoY2C5z9se1VV/l9ziGJ
 weWRyzO27MUX4Xg5c4nVfDIxgkirmM0s9WhL9qHPAaKKDypKer1Enz3Jd1RAnYTF8/K3jg9Dr1n
 nzZfT6pKKOl7poKV1nSvfdm7wEvKQb3lhlEsYCSIDSgiigquZda2AE7FAZe8mD1sYY3cXJ
X-Received: by 2002:a05:6a20:9154:b0:3b3:1c7b:ff0 with SMTP id
 adf61e73a8af0-3b8b7cd8611mr749502637.32.1781637381064; 
 Tue, 16 Jun 2026 12:16:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866518677dsm12306307a12.19.2026.06.16.12.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 12:16:19 -0700 (PDT)
Message-ID: <15db05bc-b406-44c4-af00-d6ae88833378@linaro.org>
Date: Tue, 16 Jun 2026 12:16:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] system/memory: Constify various
 AddressSpace/MemoryRegionCache arguments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260616020359.18627-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616020359.18627-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/15/26 19:03, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (6):
>    system/memory: Constify various AddressSpace arguments (checks)
>    system/memory: Constify various AddressSpace arguments (flat-range)
>    system/memory: Constify various AddressSpace arguments (notify)
>    system/memory: Constify various AddressSpace arguments (cache)
>    system/memory: Constify various AddressSpace arguments (access)
>    system/memory: Constify various MemoryRegionCache arguments

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

