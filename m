Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D73C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5gH-0000Mx-0D; Fri, 28 Jun 2024 03:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gF-0008WO-6j
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gD-0003DR-FK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:58 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-364a3d5d901so189929f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558356; x=1720163156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kdbiuZydlcNqst37pX9DeYTtEMLTHrNiAsKGNW2EwWg=;
 b=bFw8SkwvoUzB2RVUKPOWBBpGwYmL6Xs34ZYSEQI+761oNtvn8Ef+s6AnhdT5ckt8DQ
 gFDMr/rxQBJT/Tcm4EGtNc0cWSaNZmUOSEcsyB5yC35iCUztT7kPDhcY52zJkVIKt0BE
 Ao75nekFj13s6sSdf8YAL2O2q2VCM0PRsv5moQgJtEQFa1nGHcyY6RnVwQH3PmssyV5b
 FWlPQ0iGvindWzl//IOmEIpXPn2LQcczxvCXYFDCcaGE/2FqeBvWwVaaO9ngZrc+DpY2
 DQ0Egm7N84HDlo00boHbb7I1+puuwmAjfyzdILeypMixFhw302mf83uloZWFGHqo2H33
 zbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558356; x=1720163156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kdbiuZydlcNqst37pX9DeYTtEMLTHrNiAsKGNW2EwWg=;
 b=j3K222M/xn5RNTpVpp3tU7nn/AHMvjg2e8jvHukXk5RDUd54seFLIFZFvC5EYqhj/i
 qDGQWWDF14ffF1SIR7/OD9tkBgRNjgPkFwEOInXZKIkv0gM/RRrJjQFzt8shPlL6NmCb
 3pKT7WmyiUmsOUZF9UxgxaF6Z1tvdPCQnZhYjVzuvqfHE8tdaENFdGEepyUIH9IKDHVi
 0oUuAIxRPwIJKwZE7b1egX34t5SiVnnejoFFZA3TAcNEehyUwf9AHFkhgHcmLyufnrKr
 L9Jb/qgvizJxcZ7p7InW5vivqQon/OAvscWw5fHnmzQDAUdNWABry0WMBfL3A9YbzemW
 NhMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK7iiyqSZLXrKM+lKb3C8bQoLiSqcPocTCsjy6kiE3ROhNvOU345YoajkxgkhJ/gn+er8v+PE77xNc5a1fTQkXweY2vg0=
X-Gm-Message-State: AOJu0Ywu2yIR8lW2V/G0mD8D9qsaxoJ87jYKBLjM19+s1rph4b7L1+4S
 3SHo722tuDT1Ikt9Yd4SJNqEByjN9rAM4a8vue9QFgVzcjpa9MsA/3IkLZD5/xw=
X-Google-Smtp-Source: AGHT+IEgCqtvNtWPQaPp+8lwtfWpAyXFYEOMyZ0Z4X7s/eKiXzHweVkmbiARpQxvKXsdLp2zBF9iNA==
X-Received: by 2002:a5d:4acb:0:b0:366:eef4:ce95 with SMTP id
 ffacd0b85a97d-366eef4cf12mr9427968f8f.51.1719558356044; 
 Fri, 28 Jun 2024 00:05:56 -0700 (PDT)
Received: from [192.168.69.100] (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1030c8sm1315645f8f.98.2024.06.28.00.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 00:05:55 -0700 (PDT)
Message-ID: <81390363-3474-453a-99ab-8f4b1172106b@linaro.org>
Date: Fri, 28 Jun 2024 09:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] gdbstub: Clean up process_string_cmd
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
 <20240628050850.536447-2-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240628050850.536447-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 28/6/24 07:08, Gustavo Romero wrote:
> Change 'process_string_cmd' to return true on success and false on
> failure, instead of 0 and -1.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   gdbstub/gdbstub.c | 40 ++++++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


