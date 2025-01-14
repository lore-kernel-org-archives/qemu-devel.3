Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5FBE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkEk-0001jR-SG; Tue, 14 Jan 2025 11:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkEi-0001jE-Gp
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:57:52 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkEh-0001ye-3G
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:57:52 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so903712266b.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736873869; x=1737478669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LIW6CVO/eS51KvpRNkgum6ONCVUiftzg8pT23bwcWEA=;
 b=ARD7pnnUciZNvHMM3gc7GLWA4cN2NvLPmudXsZ+DcMNMUTSKvWYl17a+NxkoYa7krC
 3IFO7dBhSEDBVbVLkY1O/NXJ4uuHZ0syM+Rom6s21NkW6eakdTREpWxjO//9PKzUcevG
 1HrJMAnR5YHHSWO62zx1BfCo8pEafT/KBLInbjxkAKq97AtRDnjsh6W8nKETKQs7NIwO
 dP+EGVsc0RNMfDUxKhC2pH1VZ0cCEupGjV1J9Yz6A3ZqOSgNSdaLP3MeB8lsn9EKpXTd
 2N5WJEFn016hYe1T5TnZNj7cXKt9zXijYOQnlBUHO3kFqLRRy9moJ7tam7i+Dh5MoH38
 pHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736873869; x=1737478669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LIW6CVO/eS51KvpRNkgum6ONCVUiftzg8pT23bwcWEA=;
 b=piKVMOe7nO9H78A6gI+loVPK0tumMEOxHYvg951Hi+bzN5DZvoVp8WGDjmwc6uBVJa
 V/oF7TKQIxZSeOBRDyUZSbBn3HlIh+fsyMJwZu2j0VnowROFp4vjHBB50ct+JlkRPRJw
 xK35axnHdKA5HFZZY2Ihs55JiMIEtMblu6BGf8KUIgKoLnessIr9il+WjAoVjRsHWfRR
 uzh5yJEEDaexfhgc7FGVZjfd+Zy61ZHooYxZdLYRR/fFW5ua/BoP+jo8Uu0YhTJqJmMJ
 lBO6pVKCWRbU9mhOdYegGrglXE7yIfvefl28V+uZ4ZI9OPJ8HK1l3u/OBXH07UWCKEbd
 sosA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV77Emn33GGqs83UUkl7rrZGiJslAatye7OuCSCDqxzRA2if94esplqzql6KMIQlPS8rHpw9E6u4Z6A@nongnu.org
X-Gm-Message-State: AOJu0YwsV7CfQaoaHpjjGZL6NZHwFyEdOaaau3IPEgJCOP7NQU1MjeAE
 eHpX85sEL0IQT/sQOcGrZxkIi0936cocs/nsJXVpj9PBkNFcNRCUB5p9tzoQwNqjVOUwSzcvYV7
 UEf8=
X-Gm-Gg: ASbGncsl99thi2rtZ0MxffSZZWAjxD5b/OvKyPA7eBoea+w1fqpbBlGKQyds3tuSF4E
 wRxBdayrDm2Icp2vmBO3rWJdHm5KMq3BYlsFmZSxLTVlXGgwAuewBrwwCgnMkckaNFv6LM8DIed
 LOMKALSCgteUKVMlHmpiZEuc4tAP20XcM1o8OJ7XTzwCIxTS6/ZvNDo3r6FYVssEnmCIvQdRe1q
 uJCfwBtCH1AObtTN+dybD3ssFOcVH4HqO1o8L/w662n0HyLWZIzWnYHN9gfrrcPW+mKc/gQQ9Ub
 sV+BOCyTPldwHe1FH71zjff1
X-Google-Smtp-Source: AGHT+IHCWajAQug3mi+auhnW7ijt8V1ncMIZwWcpqRtX2Spl3Ii1ie4hKS0fNGng+LEyttj7e024nA==
X-Received: by 2002:a17:906:f6d7:b0:ab3:3b19:c0d6 with SMTP id
 a640c23a62f3a-ab33b19cfe9mr248648766b.13.1736873868078; 
 Tue, 14 Jan 2025 08:57:48 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95647b6sm649074266b.115.2025.01.14.08.57.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 08:57:47 -0800 (PST)
Message-ID: <2be3d7a0-d80f-45be-9582-b42e532891e8@linaro.org>
Date: Tue, 14 Jan 2025 17:57:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/81] tcg: Validate op supported in opcode_args_ct
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-26-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> We should have checked that the op is supported before
> emitting it.  The backend cannot be expected to have a
> constraint set for unsupported ops.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


