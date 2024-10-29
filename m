Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B7AD3A670
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 17:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5pfS-0001tP-88; Tue, 29 Oct 2024 13:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5pfP-0001sn-BH
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:06:03 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5pfN-0004mE-Rm
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:06:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso53998135e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730221560; x=1730826360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PkpUJV7hMa7BM00qylqF1QL5dJ4OlpRsQdA5/f6IlDE=;
 b=BmJqj/m/l6RrE8H4/o9gf75mwhXI8YvcT2tZf2KQzpQdRkwB/ySiB7/EH7K+eWj6tO
 A7DVtxhjy91cjEK1g211Pxu3ob7Dgboki3ldNQvLWnGKpJ1F7x0a/AWL61+/Hcln6kMk
 d7Li/7pGIZaNKhO5Fvmys4Z4H8qAREitGMm48fCh4GLv2MYqjnPn54TkbulqhdhNB3c7
 vPZyGQec0BRYMjYx2BqrswBZJV+LUkXwqCsHecR7TqNxUQM/nYqcl+XHvG30Ahxcp5qJ
 o/dMSfuyOnZ7Oa7t2Jx8XE3rGSuw0A37bKjyFkj4QWfEEL+7jdPkGcO02Jkrs9T6vZVS
 lUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730221560; x=1730826360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PkpUJV7hMa7BM00qylqF1QL5dJ4OlpRsQdA5/f6IlDE=;
 b=luzvszRxJSgoSjNzRhcVeRdZmdVLIJfu+Eo6FYzrEYh/JuDFUCipcnvhqT0YGL5QV7
 4dDvGXLH5qg0MxJWpuXUq2ZIgPLNcbWqWBTl0+/VUWGGgapg/MQWIwhTvHfRaK+UzQ+3
 j36UNOKANfV/VU0BPU8n+As0A++gfxcZPZNd+LsIYXP57U5Ldun6uxOK0EYkARGgWVJG
 MQwxA3RSudMPXW4sengVBVlCubV+/IqfHQs68gdfMyBIKWx65MQStBHppZn+ScvzhgYW
 PbpBB450QkA2JOCiafcXeQLf/SVJIt7wKn3WGmnrd+oI3rENMei37AlrdER62bz/gFah
 367w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6sK5J3KQOagkCtdwLlU5vnYoH6vTHMJiuldG6aaEv2oC6GCEEU8cP0XGKUlCZZ67vlNIpFcGOdUWf@nongnu.org
X-Gm-Message-State: AOJu0YwYToboMcO+fRpREOFAErlOKq3rOR+DhdXJadEzEE5juekqRIKH
 szw5iQaax6fhSdXXqZiFT9DoluxFsrkhHaZgETSfD5Xaukic1uDUqovrV8g7u70=
X-Google-Smtp-Source: AGHT+IEbYjPwPKe42XRQd1tt5B93dG4sN0UFEEWN4Qi8MzxWq5h4TiUuHCjtm/cb/5g+4QWLyQIJQA==
X-Received: by 2002:a05:600c:1c82:b0:431:5503:43ca with SMTP id
 5b1f17b1804b1-4319ad16173mr99812185e9.28.1730221559883; 
 Tue, 29 Oct 2024 10:05:59 -0700 (PDT)
Received: from [192.168.21.227] ([89.100.107.89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b47aa8sm13142740f8f.51.2024.10.29.10.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 10:05:59 -0700 (PDT)
Message-ID: <36e339ee-276c-4239-81d0-4145c4edd0f2@linaro.org>
Date: Tue, 29 Oct 2024 17:05:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] qom: module loading cleanups
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
References: <20241029122609.514347-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241029122609.514347-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 10/29/24 12:26, Paolo Bonzini wrote:
> Paolo Bonzini (5):
>    qom: remove unused function
>    qom: use object_new_with_class when possible
>    qom: centralize module-loading functionality
>    qom: let object_new use a module if the type is not present
>    qom: allow user-creatable classes to be in modules

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

