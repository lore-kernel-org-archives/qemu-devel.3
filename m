Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B40E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 05:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUfzy-0001ea-UN; Mon, 06 Jan 2025 00:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUfzx-0001e7-It
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:49:57 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUfzv-0004py-RB
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:49:57 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3863703258fso8728166f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 21:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736142593; x=1736747393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VCmLGmzD2F6J2QbfSwUjmhgNI3SOO1JNMjze/6Q3R3A=;
 b=RO4lkRPTQzZdT+dm4hcJ9yAPz0+ZK9mn3mTz9YulaIN34a4wSOakKuagWGl0+drsu8
 Qro8/3+pAy7Id+g6jV84s5F/a7vCjWlfz7n740FXSzqiveHmHlSt95AfMWjwg8e89/9Z
 Vexqvw4wT2G1eOG0GxS2qt6FdeSUGdRZBW6x3ROtu7N+jl0cIAiGkdKcru19AHVoVvGR
 INDcpPrnRhS2WxZr2vUQPUI2aoMbXirc8i1XpU/JEqezkIhjqVsuos1/MXnsWvhgUL0x
 qgVU0QAoLE9ZWgtFdeCY5xHmaDak2eEEUBp+emdSe2jDN8wjn4Qafn8JFqEB7wYMpV1i
 BXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736142593; x=1736747393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VCmLGmzD2F6J2QbfSwUjmhgNI3SOO1JNMjze/6Q3R3A=;
 b=IOHLJmXyqzxpSAsGZWnv8Lgpf9xwq0EyKxpLWBmISzFOHU5bHknp5IsalcabgtFekN
 LjySJom3u9XYDMZpf8fmSeRBxNlzG8xPhkXHccTQhHG5EQuWhMTHr8f0tTiWegrGwQJC
 tupwocEBfUrHWy0FXn0xftcBT9GMSZmyiXB44Mz6kb4HGpnnvcE/LRnBt1qaIWaWEh3C
 0JqtprWUP/CHVOORDeFeskdHAaWeiuZb3D8qqugmo3W291CqUBs2/sMFTb0oEEOD+4DK
 MmIKLobYAFqbJ/UvkFyfAhZ4vFrbAffGbMiKb7P4hWJxPrJYcsV//3E6oGhzE3f8t9cu
 TVFg==
X-Gm-Message-State: AOJu0YxPv4whB69VCucmmdQr8TbZEK5FXdzgENfFbAvpbimhGMB1+wzu
 U1/CSskZISobwGvjKFYPkNrj5zBZLjqZExEd5agYnV5gtqzdMojYsDnSf9zEGTU=
X-Gm-Gg: ASbGncuDipRvUyriiT6pJYC4RxMcLzTaDgbeaoyMc2pp5Y9RAlvFiOtI+aCkSe/d4xc
 WpCZA89myD5WCwqRpzK2Pz92yIKMwEP+06jgsXvIcYSJUpSTgsOPL7z+3N9oMkCAd43p4BBTcyA
 KKe3MNYyilnUwI1PIcajVidl/6ziapGKBD6xggXM0/bsQGXpCYdLNcT80K7N2ATPWjmIDc/oxy0
 Jm0Hj3VcZce1aKxevBcfsjTv7BCV5+vGZ4CZ+joO66YtGthK+2hcsoZ4gocmxS3sn4YkyGqoCrn
 uiVM6lxl7MN3L36AMHfrQjch
X-Google-Smtp-Source: AGHT+IESIA9XGQTtrDXjhln51iA0e4e4qu49QebmEKhykFDAO28yJvW2s8/PBH3HXeCzyR9FDQIMSQ==
X-Received: by 2002:a5d:6da2:0:b0:385:f07a:f4cb with SMTP id
 ffacd0b85a97d-38a22a11748mr37802830f8f.8.1736142592962; 
 Sun, 05 Jan 2025 21:49:52 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e219sm47624284f8f.84.2025.01.05.21.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2025 21:49:51 -0800 (PST)
Message-ID: <52a4751c-b27c-4670-a941-58d8653992bd@linaro.org>
Date: Mon, 6 Jan 2025 06:49:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove myself as Avocado Framework reviewer
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250103233026.65717-1-philmd@linaro.org>
 <c15e8494-0171-4f30-5bad-e2ff370d5569@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c15e8494-0171-4f30-5bad-e2ff370d5569@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 4/1/25 01:12, BALATON Zoltan wrote:
> On Sat, 4 Jan 2025, Philippe Mathieu-Daudé wrote:
>> While I was very enthusiast when Avocado was presented to
> 
> I think 'enthusiastic' would be correct here.

Oh OK, thanks.

> 
> Regards,
> BALATON Zoltan
> 
>> the QEMU community and pushed forward to have it integrated,
>> time passed and I lost interest. Be honest, remove my R: tag
>> to not give fake expectation I'd review patches related to
>> Avocado anymore.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> MAINTAINERS | 1 -
>> 1 file changed, 1 deletion(-)


