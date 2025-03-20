Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABFBC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 14:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvGUm-0005Ha-JK; Thu, 20 Mar 2025 10:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvGUh-00056Z-0j
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:03:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvGUY-0001Fb-Oe
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:03:34 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso596706f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742479403; x=1743084203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DWgshA8OTIIdBLqESPNQi1EevqOIJBOXPNBXtKqlBfQ=;
 b=eHx0ARgK4v4zJ2Z+3OZD7x+0TzlMi1BEuJqS4286LliQ1khzDeDNjVRhHPSfAvxaHT
 8KNG9pzriixovVL4IbM2IeeHCNG4/Tap5k/d0vtxXRJFdr8aNEyRKQESJYkTlWIU+Jx9
 i7eGXRMcDcz2DHCoFfHbP10KPcpSwjezjgzYPPZeB26clopkWJVeFnJkW/3mdAR1G2Dz
 WXdlidKhTdMc9uW4fWjvEGTmCViFF6CoC7HGXGIKEbcx+zJTp2chwOfUfdGQQQrPx8C3
 bvAFdIVxoFP7w8Ciz2B9nNmjMwbb+F/UL2C4oRGc2MbnJnzrLh72GfAsu5VVDshYHBL8
 OP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479403; x=1743084203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DWgshA8OTIIdBLqESPNQi1EevqOIJBOXPNBXtKqlBfQ=;
 b=udK+QsmFV/DBYM3I0JicjE8P/IKU1U3J8u4jzkDaD/yeuXIhY8u8jyzG6lqIuhwDve
 RCLqFVmWy0ncXQWdfon/SNkp7czBVyVQCy/3Bji3/VJs+Ev26wOmdfNld6JYfNnFcrhH
 c+YC6uk+EfcWD6WyfVPsm0PJ5wuKheq/tx1QKR61CKpGWpcojjlGa222bSDKwSlu3zIA
 ZFfKM2wph5laF56hLWOZpUxQDPgLQL3WHv/39ZzSi7iQ94VjE4VpUkV67+Z65a5xRu+I
 9TkxDbY006uV7W/FxAE4Q+JO3n82gAA3SBaN3hGwGeP6YelDcRWRii7Sg2SzqCaDxjtS
 riBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+8eNyx9X4iKouYJRs+SJrHM0QfAWYhKMPckCA/4wWwT2yAWMJAiyYTzFf5PzEdEcN+wu0WowicBmS@nongnu.org
X-Gm-Message-State: AOJu0Yyb4FZdpB6rubGKXagrc5BoIw9OBjrLhq9Xfv/nZWT4lM9ewzf3
 g55pUpyIJhT3PwJGxidMx/HnGqTuKagJa7Ea7NhEs2TXfbsFkzpSTLEBTOoaDs4=
X-Gm-Gg: ASbGnctuA5gi3sXsgLpP6ReO3Qy3BzDaX3ODI5nejTZMNHRuTEq5ahWsRfv9x4PKnuJ
 LBCmsQACrEtYN0GUEUVdpzVBW1tbWuyCp2AyaTswOPRvMVdreGbXFTvTirtYPW9yGitFAXY13Bj
 9U/yWh4s8Py6rHjeaxXfHcpGhinkOSYa8C+NcvxAqBVnTpFSAkd1fJmOw06zge8Xp/dvgEFOur1
 293QEK0mx3CztA0oSwXrpYhjp1hbZ66zcINhZHh6G6IaPVEgQNuPbhsPdZk3ZNAKCUW4yhJZp/U
 tuDe79PJWRXODMIYv/u3N6++VxJaDeNGUDOvOd5rMlgRd8DfvvqM7weddHShf/NcFk+qMRtmOOp
 vMykk849AIh0U
X-Google-Smtp-Source: AGHT+IGTDQoO7aHWysGbMrPLpNTfSoKHQ39NhGItK6IQbDPcsfg5YtViGUYKhiUO0btx8R+CZgp/5Q==
X-Received: by 2002:a5d:47ab:0:b0:391:23e6:f0ac with SMTP id
 ffacd0b85a97d-3997955ca8dmr3123367f8f.11.1742479402163; 
 Thu, 20 Mar 2025 07:03:22 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43cbasm49379795e9.9.2025.03.20.07.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 07:03:21 -0700 (PDT)
Message-ID: <7bd9e9ee-8b0b-4e06-b513-b66339b33f89@linaro.org>
Date: Thu, 20 Mar 2025 15:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: assertions: add static_assert
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250320133248.1679485-1-peter.maydell@linaro.org>
 <20250320133248.1679485-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250320133248.1679485-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 20/3/25 14:32, Peter Maydell wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Add a new assertion that is similar to "const { assert!(...) }" but can be used
> outside functions and with older versions of Rust.  A similar macro is found in
> Linux, whereas the "static_assertions" crate has a const_assert macro that
> produces worse error messages.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Supersedes: <20250320113356.799412-1-pbonzini@redhat.com>

^ extraneous tag

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   rust/qemu-api/src/assertions.rs | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)


