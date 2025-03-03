Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D69AC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 18:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpAcp-0006EC-Rs; Mon, 03 Mar 2025 13:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpAcm-0006DD-Uh
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:34:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpAck-0001S4-VL
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:34:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bc4b1603fso7355715e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 10:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741026879; x=1741631679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fM1L8Fh6PrnMEWbix/2pwz7BdwrYAku0XdwTwu2DKcM=;
 b=uOq6JkN/KJG3KKDw65fYE2YmmMC1S89D9qaAAEuEZ74h757O0UVqlVFy3fEhPwEQLC
 sV0UJ0PLOFlUIRV/p2Q06A6NRle0lsnAigWxHiPoYyP3Ihc8RmZG3YUwhPVuytq8Lck+
 t5NFBAs6G4PMsvMKUeFk9JAJETLH1rMWWXUz4nNP31MUep1PBswSPNOSEZFymVYGn42j
 I0KjTe/sAJbtNJIwAzliUeoSqukt5O32NCAl6VfRdRkukvEq8R3QoRmPqtXYvXdE6oMA
 OVceIRjXRnCfXH8klc1qBnxW2QdQjrViDosUP6DqUTPDTuLryPQukPzJu9GoOyCNGHNU
 NWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741026879; x=1741631679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fM1L8Fh6PrnMEWbix/2pwz7BdwrYAku0XdwTwu2DKcM=;
 b=s2/mzFlMa7AJSseyVvi6g4lSmxzbFhA8QfC5mfXJAi0a4Ve2oIMmh4DqqY2WJ205o4
 bDTjZbkxbhBuNgJchUD/b8wn5gDbbwrd8UpmxbpjF+ZqMFjr/RGRDH3K8Rc/BYOFpmMJ
 wc8Y1+n1B4pbh3IYuwnMBbPoZLdTLnSp4+1b2gmDGBXoRL9Ssi/kBiWER6W0MIDtO0wt
 /K0MdnmVRG/Bh85HYDYM847Am+T8h9XdlwAqliZZpHiiej7OR7pCFbCdYMgwe3JWXokH
 asc9UNTAdbihVVdUSc/+PYiRDr7HI2WWzdYiBc/JXLGCOBBUfGfRh3kbAdI0pZ+4HEvZ
 uLRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdVTWYPoXE/TsPI2UCJqntAcKNEGSAKg7UYmFucHqnqVwWmjkQZjDNSkt0SiqTBsfxMVQRDkNiC+RF@nongnu.org
X-Gm-Message-State: AOJu0YzynVTES0AIXjsoP5HbciQpyloDWO02+v3EgIxskhHRqeYgwcIU
 ACKyZ2dFUihAC9OifkscULyxbo0tL6mAcZNgBnOZuWu/gGA959X4qDzg+pcH32VefXdzGMJWZQS
 XB2c=
X-Gm-Gg: ASbGncvp7tUbzLw4R6AZeyy7tfahsDdjkq4q0YkqlNAWgMptUZ2MdSggEfMJKL12niK
 Adr+EkklE/rqgxwpE/ZU+4ldpbPc+qoUvpHmv/SsaQBkrDW9010sa/GSWL1NmUocdV82kwTht7p
 0cbY2e8vwFBcukpuTdRGmXxyYcdQj7JQ5pkjFyUjNixxE6PFo83S7Nycgw2DNVx/Z+ZtzKSHiyr
 c2b21w0crxkg+fJd/OI9M2Wb7qJTasKL0BSysDlzTS0dzwvpkRvaAH8KnFaMXkQ85vWXg+U7urp
 CCiX5GhrzDzzaY8bxC9+uPxd4ToSSgGy0mNv9W9Hb9iwNg99cgBfZ2hw79JmZpNCULsFRBZJaBr
 Bd8ukgX/jKaJG
X-Google-Smtp-Source: AGHT+IG3UTr5B9SIV+pFBg8TqYYH46QBzZx9WCSO8elz85MQwZ/CJPdNvDR0ZvqvrvQPKu1v8Vk41A==
X-Received: by 2002:a05:600c:1c8c:b0:439:9e8b:228e with SMTP id
 5b1f17b1804b1-43ba675892dmr106930945e9.20.1741026879436; 
 Mon, 03 Mar 2025 10:34:39 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab39ed2a6sm133752565e9.3.2025.03.03.10.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 10:34:38 -0800 (PST)
Message-ID: <2defbf2e-09fb-4dce-b012-32b52d520e21@linaro.org>
Date: Mon, 3 Mar 2025 19:34:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/24] target/m68k: Add FPSR exception bit defines
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20250224171444.440135-1-richard.henderson@linaro.org>
 <20250224171444.440135-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250224171444.440135-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 24/2/25 18:14, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/cpu.h        | 21 +++++++++++++++++++++
>   target/m68k/fpu_helper.c | 22 +++++++++++-----------
>   2 files changed, 32 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


