Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5CEC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNJN-0005wm-Od; Fri, 24 Jan 2025 12:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNJL-0005v4-7x
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:17:39 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNJJ-00070w-FG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:17:39 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6f1be1daeso240650285a.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737739056; x=1738343856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qBZiO4D1FqmlXSnrN8yKjuP8R99OxjLQaJMiyy6bpiQ=;
 b=WmrVrdFyYsvReqWlk5GBs8PDdKtJR0/NI+w6OW2CYIH1EwonVzwa1x0xclkh8AfRFp
 wCLHv8oXe/11X26YjWf9ViBMxJibY4H9PQgluMyoH1DJOoZxRbtOTwOjBL9qO79FMZ98
 IHn2CV/t/uWwt9Bpc8RKPLDddwWs4YccV1CtNtUxmuDA3vAvusrzlsYJBVY8f8n6tO7t
 UXyTdBGjzSjKWVbUhUImgMyQpDaeQg8+ZlbuCG/qwI/+hwVUn0rKKm7C9qUP63DkY9RM
 CNpDqGTDCnlp/6MDhZdgrNrLev2f67ITaEgfAlJvLNSEkQJIhp6NKO4FqOygNsb7JDaL
 9/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737739056; x=1738343856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qBZiO4D1FqmlXSnrN8yKjuP8R99OxjLQaJMiyy6bpiQ=;
 b=h+U+MRhXwITN6W1vUlMkzgL4u5Oh68EDNWX/HHe/4ypQW+YvsH1xElzGA2/SzxnOJS
 HM7Phr8kaoFQTmq13+2qPy/QJd9DXNwpjjurSMaxy9vXwy59lDxgxmxJtLf1E/ekf4vu
 nsjjXcgrFdFPpx8n34CdNsYbWHQoenOUtdotME6dDOFV/DoZlXNfkY99eVyildjyAyei
 k5bx/javB8dXJOFHXu/V/r8bcEe0vhgATHcwD2PF2cxG+HokoUn0ZRMeZXs9C9m/YryF
 MLWiP8wtqiiBmueJW1BTngTzNWpP4ncbKSLly4ONEloDxrKn3GoCNiDBuFQMQexuaQet
 Zlbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe7xw0D5lFyRaBY24NK9KB/V7wHwjpulUkfmUJouxDVHxikEz2JezA0UlAO2uWr/P8Tfw7sA3qjxka@nongnu.org
X-Gm-Message-State: AOJu0YzyU/Swl/Y+//8b1ajzES+a4a5Y/sMh006nftCp6amFltfvk44S
 SW44cR0w1HMqBBXm3L5lKa8udlCdc8XYBzxcRathud8Osyjp5indmOU3fKcoBCU=
X-Gm-Gg: ASbGnctA1QwqIlJULG3MuLpa7jVTP+xSKsJr8Wp6r+CDMIgtIek5jc69rHsv4ILtLjv
 rRt7xlrz72WW/ZYLuesMbPZC5ICKHyMpc+VCknmLZSBxs4v3bgSRZeZvYIyr2RfdaKYhsOO9Q2D
 t2niWXkQegt98k0q3tFEYc+f0272oujUBi813QyHY+ZM5W86EMQBz111LIsdm2fLalXfYQQfth7
 Dlrwe/0t9TUjBC0SgdLI3+nLvBRGmqJqRDjwiN8cjEM7w27LpMSctpBTFPFMTrZfdc/FpGO+3ZJ
 9yaYL5aXmhzrhVsSLIuYpSiW2FwmNOVn/kmSC61mfQCSIX5sTqKMhcJr+4KADis5cQ==
X-Google-Smtp-Source: AGHT+IFW722+xKvMmnKjmql7jzBxWTLNbvmvrCvKC9S7GT32+FnmnPGXcFh1fhDO6Jktvqb5suZ8Iw==
X-Received: by 2002:a05:620a:2a13:b0:7b6:d8aa:7ef9 with SMTP id
 af79cd13be357-7be6320c0f9mr4759858985a.32.1737739055757; 
 Fri, 24 Jan 2025 09:17:35 -0800 (PST)
Received: from ?IPV6:2607:fb90:c9e1:9829:9eed:533c:6788:9f4a?
 ([2607:fb90:c9e1:9829:9eed:533c:6788:9f4a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9aeec6b8sm112525785a.84.2025.01.24.09.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:17:34 -0800 (PST)
Message-ID: <16332db7-6ed6-44eb-b266-8a3e9c7f34b8@linaro.org>
Date: Fri, 24 Jan 2025 09:17:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/28] target/rx: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-22-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x732.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/rx/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

