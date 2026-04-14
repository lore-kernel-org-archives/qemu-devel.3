Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0C6F531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRxr-0007dX-Vi; Mon, 13 Apr 2026 20:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCRxo-0007ce-GZ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:49:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCRxm-0007it-OS
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:49:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so3476833b3a.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776127749; x=1776732549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=psAieoi9wJYJkxHTxcj1/8XSDLS22akGCnQF77/4XHg=;
 b=uYDDwDR6/2MnOXYpWdKaqdmwPrWSHAvRNvP3wYxJUSxBNy54ue+tqIQe0s9TTGA1LZ
 B0MeQMOEi1nbnjCDmt/1MEZLkgTt9Q4jLN/hdhrbJDu45Cl9mb2MV7rMevoMefxj4sNo
 2F6RZVC9TYAYus5aOY/RyyIgW7bD2mBiDCFNLAaa+TUkOZRNeq8PPi0BqCDMW/+n5Uh6
 n4U+uy/D37th0fW5Z+7EgfUr7c7gLYq+HPRotEdPnfUVlDFbHx3LP4FGM/fy2wWiqdyJ
 sGZalpNJfIo9GR8Y20JIDd6Kh2AX6qrSaWnSCYgxfzsAbiNplus6JHEKta+TDSE3qf0s
 YShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776127749; x=1776732549;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=psAieoi9wJYJkxHTxcj1/8XSDLS22akGCnQF77/4XHg=;
 b=P4VGg+lzOCPqO41Z+jCqY6LIv5LjlaJv2KdeZucTGSeYze4B2Zb/eGHlNU4QTX88aq
 fbacepXoF1xCVE737Un3iJmny3zBPKyTB8yTfbRvL5/lu9XcEaRO5G7DH+qQnMfrONB/
 ahcivEjQ2uzMykcguKQ3zJpTr4HQ9xAHD1d9mBkBptBavqodDXeoGLpSRl6Y+rhlBx0F
 wb8eq8GGhIltH32jZPduU4SFA6o4IHNJjTQbfUraUOq3tiD/0u1DEF20lF3kap1qtn4k
 +cpOYwZq2hm9P9OX1SQOlkm1dqB0e+U3g+25DG721n8PYGprlD/MAUiYnMCJAOdNQTMo
 v9yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9N7gK1HISF4oIL8ThPwkh4cX6z5T82w1DiUDc1NCTSb7EvUakHvNKODI4dW8AYShs3rtMcpqBuLhuu@nongnu.org
X-Gm-Message-State: AOJu0YxUc3NJadwPcsCEF7xklKxJDTiju33aZFKxS1isyUAe8uoaPjb4
 ktrUpd5azcmp3NED8FH8LJFVpin27Y089hMvprenRWZ4hAlrYB03qrDZTIlUSbrIxkY=
X-Gm-Gg: AeBDieuJp4tZe/h8hvQ9acitemHQ2zueLGcIAn1TdOycFmMuRMi2VsaLnqlyVADKtL8
 ssdMUkuyVhN0Zq+J4chpqZ6n1StqqJvMiJZAKBXKZ1sOMPQDD/OwPEVw3AM60wPhTbrrde6ifg2
 tMgAGGXirK7N7K1CN1pzjyOWSaU6MhA/GDwF6XoMnUy6WQ7lZ9MJ68jfmdZZlxI8c7IacgRt15u
 IbkI0XxULI00R3GwkbjSU30iyAzvckuBbodSKrjGGyZFcVnzfv3pYUxDKHYn49W0+sDeUT/Hi8R
 FpCcjPg+S4iVC0D/kWWwe3WMt03lz4ulkfv3B7ee+wxu6/nLYxpX7iA5FRbufueBJ+hIPegms6C
 UMn8v1JUV1sUekzLu8kVPz9xxDZOKWxDNbz/zdmWLDLW/I+mRl9WcQpCRct1katymhWMyKXBRop
 zmPLPX5vTRjSXx4jQP3+8DplC6fIWP1h52t6MQ73S9Gm+NymHUkwayhS+FMMzG6cwgpma/nvPAd
 A6rpT74Jl+sEQ==
X-Received: by 2002:a05:6a00:2c8a:b0:82f:37e3:ae67 with SMTP id
 d2e1a72fcca58-82f37e3b1b9mr4640398b3a.27.1776127748800; 
 Mon, 13 Apr 2026 17:49:08 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c339570sm12406056b3a.16.2026.04.13.17.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 17:49:08 -0700 (PDT)
Message-ID: <f24c4dc6-a2fe-4ffd-a42c-ec7b1b4e8b43@linaro.org>
Date: Tue, 14 Apr 2026 10:49:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/27] monitor: Have MonitorDef::get_value() always
 return int64_t type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260414003001.97571-1-philmd@linaro.org>
 <20260414003001.97571-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260414003001.97571-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/14/26 10:29, Philippe Mathieu-Daudé wrote:
> SimplifyMonitorDef::get_value() handler by having it always
> return a int64_t type.
> 
> Let the single caller (x86 targets) sign-extend the returned
> value, directly handling 64-bit CPUs in 32-bit or 16-bit mode.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/monitor/hmp-target.h |  6 +-----
>   target/i386/monitor.c        | 11 ++++++++---
>   2 files changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

