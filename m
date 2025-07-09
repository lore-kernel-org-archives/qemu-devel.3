Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94B9C83F14
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 20:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZboo-00049j-E6; Wed, 09 Jul 2025 16:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZboe-0003uT-Ef
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:54:56 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZboc-00038G-LF
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:54:56 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60bd30dd387so163684eaf.3
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752094493; x=1752699293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4krexRLrrixlB2iStWhrCgL2hrK3sbD4cLG85kMjCno=;
 b=YSE8EGv6fVm8DGmglqK0eBfp2yTIfCbtMNgfK8AaAc/an9p28htNqri2phruZ02bj8
 lFBTY68+8CKNhCHseEZqTcJOk3+Lv+smaAlmNMn0Sbt4b6gB0abzf4LA9KjBPC93Kip0
 Cj2a5rfOiC/TUL8IKxVL+yNo8/ljKhNYQ2KqA4/VbCCBdW0P0Fr5laiiFmAUM5CIwsxn
 KAwMYB2sdcbJ8f4NrtMZuhxyq8P/xg7TLUJbNCHvCYsmkH8hKXMnu8duV+DyP7OVmWNe
 J+Z+RmqeOLJhfBN7tI1catwXAfBgo5UYBjZWM4wOaKsrlsfrbW1XSRWlb9ZV8raemLaO
 NXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752094493; x=1752699293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4krexRLrrixlB2iStWhrCgL2hrK3sbD4cLG85kMjCno=;
 b=s5v6gDNZaga9wkyurQUTn+YkJMhckGnWZwaMOhe7dPysD3Whhr7TDu7V2FfxnV6dYj
 H2lnB7ZnoXT2pbgrhodBFmepAWmcSmJBBgbbwOlYLbVq/yczM0jdS418UL0guQ5S2QGx
 4hjJwlJHNmmR2zqVIvckjUDbtlPYV50B9GtxSwooPTFUDBu4xJiSgZclDXj2uoMwmFdD
 IdKExCkp3UK7fHeTT1gQ0sl1vwLW0fn7cOyRlvvxapA8XSmPdyZXOxAScpj9JgmlIFb5
 M4ztMt656d0OQ1j/HTs4NdJUyJjfe+xhrooFOFGIcRrm0HOF3/o6JA+fi454T4R/P6Vw
 8N+Q==
X-Gm-Message-State: AOJu0YxfyCAMt1FRUVfhyyoqjcfIs+NM4MW8rm25mT+paCe3D5AquzU5
 WCNXOQi93IVZCt3YG64rzQWZbNOSdl8vMFSPD5pQ98FUqOly+8KNpO02cGUORX52+Bc=
X-Gm-Gg: ASbGncvE0qQmGLe7FyA5bdeBOQsScqUp3qF5+LFctlo5RyWQMWsdrNWmImQMlRFlhPV
 AaFcEOeAmb6hzqg6k4XSXUCZTu/wl+Zqx10zaBBPPnHQvbOHXyU3OLzTCzWbCLVUwpOcoHGvWFB
 +2ZnNzQnTyMffVhr/Znc0V/G8ma1cF2ciowdKl0LjWwQL3s/zgE5QeA2TWh+lFwuuo6h0NUew/b
 kOzkkLUZQr8/6agsLqLOd/xN3WoiPvDeQQ20xBAqEvss4FgmeRTUia5LF+qu/jvOaSMkwzK/Dok
 R8bFgy7gospFpL+RcXBgvSM/A7K2RHD+zZn4+b9C4acorcv9dnIrHcUmNpMDhs9XdivEre/5kxU
 cxulDxlhG0qL2nA==
X-Google-Smtp-Source: AGHT+IEvPgNqUwlbQ3oUqypREV1GjLIPoXJirF857aux2aeYWSxIrotRvKlmDrE5sShNR6amLAOTFA==
X-Received: by 2002:a05:6820:260e:b0:613:cafd:610 with SMTP id
 006d021491bc7-613d6ffc0c5mr963476eaf.7.1752094493324; 
 Wed, 09 Jul 2025 13:54:53 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cdfa7844bsm667798a34.57.2025.07.09.13.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 13:54:53 -0700 (PDT)
Message-ID: <a15724b9-a0f4-4323-b8c1-3cdf8581ee43@linaro.org>
Date: Wed, 9 Jul 2025 14:54:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] target/arm: Advertise FEAT_MEC in cpu max
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250709180326.1079826-1-gustavo.romero@linaro.org>
 <20250709180326.1079826-7-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250709180326.1079826-7-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

On 7/9/25 12:03, Gustavo Romero wrote:
> At this point, no real memory encryption is supported, but most software
> stacks that rely on FEAT_MEC to run should work properly.

s/most //?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

