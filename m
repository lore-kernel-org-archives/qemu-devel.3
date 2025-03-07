Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9748CC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdRU-0002oF-8Z; Fri, 07 Mar 2025 14:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdR2-0002OL-Jq
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:32:41 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdR0-0006zf-QO
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:32:40 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so47965075ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375957; x=1741980757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0or6OEjE+OGp9zcYI11fM1xEyORauwjB9vRtl0EVOZo=;
 b=n6HFdg4W8lOzxVQ77ibHeKnjlIFNPwQmAf/K69KRpI2QoXq+J8agoPXXC93a9aXuoX
 Pf45AZxwG0UOIjBFAx2YCaoB15wyPrI20V5lYVO036Pdb1lFBPJTXBpu+zP2ulMsY6f7
 bian34tBq7pErUk/ZPnN7FteXmSd9I9SIxlxqCJ/3NvJTLnxSiB+JmKbG4py5IQsF/T7
 bRZtTxkD+ekZjcOdiQJgmFx8fj5F2qsAq8NaYJggZQwGlHnL7RFw9jQTV+tlnwmahP0r
 yzD3nQ6pSK1pYpDxlGBzGx+l0SNzjxSzME3FsUYNI6VQvqN8b8dW5/IEwwfstE7cVJcl
 EFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375957; x=1741980757;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0or6OEjE+OGp9zcYI11fM1xEyORauwjB9vRtl0EVOZo=;
 b=WY9DDe1V3Prois6AJpk303uBObjyJ//EuafyCvy0hu838PnsAEJryvIxss7ZNPXP5w
 bMSm6zZKr3fBrOkQicDKVcnd44P8T1aw13btsV7F/ROrl+wu7wrXHC+UiiYHgC1i108n
 I/KGDkRux+qGPWBop8T+s4MNqbUYQm1XUktVr3vTbjhO/ooH+g6sDXmBeOg0eekaIgBB
 nbmbTT0IPm7VV0mKqYN5+YNwfBsGYkpBoezX9OnmFvu+zd6yHzl3ZlMRQQ9AyNTmisE7
 +eP3N2ckGMh75JxGHNKZpz79qViySWjbnxEQR7tGy5rTJlwyTm0yoFoRHG9T5A3V8RrP
 dVwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjKOp6VcAkhxzwBO2fDpJNjuYabF3/EIZF5ACiYREXnntEOE9J3eIyeZnq+Vguv7F5APoWmkptOgHv@nongnu.org
X-Gm-Message-State: AOJu0Yz3MOB7fiUzTzGY13PCj2CpuDnN1IVKYvpEFbOXDoZm8wbDNeP7
 ix1byD7ln0JiPgsenPexdArFjTcR+ztd/ODuvsXzR6wkT+qoh8W9g1A5PyI7w1c=
X-Gm-Gg: ASbGncuKSojvBwJRBpsixThfythW1oKY2gyWsVTyq5BVQIgTdjXF4mUUI2aZXWWG5Da
 dsaccb2JfYRoNT5/sbegSHgUZiPMzD1Blbq51SYfQb3OPV1vMWfyiKZDH0S4e/Bwq5vRIWXVbMJ
 2F8+W6LezFeqDA5kHw8bqoKfZqFj2PaXbibu9ldpx/M2eMa/u0/XiQVq1SpjXFbcYZ3ivrWKXwz
 nv2egF2GJNIS7zqD3xDxqe67zS7H++my+JCxEHCvLLaRbYpejTWUIoTrABBXsMG8BPXCba83n6f
 i/4qsUcj+Gmoz2BUvUq/snNdjbX7yooOIx2qwxVGZ/QHRXv21y6MtYR2iPXsbnTZrlmHxxpOIS8
 ImBgIQLUW
X-Google-Smtp-Source: AGHT+IEZj2VKRcS/HIeRMhhDDCIIuSREFKSqiT5M4gO/PvOFHDP32YVMVLXfD8/ewPuya0N9YDdIXg==
X-Received: by 2002:a17:902:f54e:b0:223:4d7e:e52c with SMTP id
 d9443c01a7336-224288695d3mr74052735ad.5.1741375956762; 
 Fri, 07 Mar 2025 11:32:36 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2242cacbca1sm15033165ad.0.2025.03.07.11.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:32:36 -0800 (PST)
Message-ID: <0d700e16-900f-467b-841a-2e512333f5d1@linaro.org>
Date: Fri, 7 Mar 2025 11:32:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/hyperv/syndbg: common compilation unit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 manos.pitsidianakis@linaro.org
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
 <20250307191003.248950-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307191003.248950-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/7/25 11:10, Pierrick Bouvier wrote:
> Replace TARGET_PAGE.* by runtime calls

The description needs updating for MSG_BUFSZ.

> @@ -374,6 +376,8 @@ static const Property hv_syndbg_properties[] = {
>   
>   static void hv_syndbg_class_init(ObjectClass *klass, void *data)
>   {
> +    g_assert(MSG_BUFSZ > qemu_target_page_size());

 >=

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

