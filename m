Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFFAD1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxPo-0000pj-6N; Thu, 08 Jan 2026 16:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxPm-0000pZ-GF
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:19:30 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxPl-0005fH-4X
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:19:30 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81db1530173so249349b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767907168; x=1768511968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FO50iimhZ21DstKTVyAjmBYCGviuu7Xy6azG/1/SSJE=;
 b=QQJgd8ododBv/k0eket+URg5HSNgE5i1WfnwC9worL9pW5w94KwOkf0NHA4h5hNAZh
 woJh9Ez738zQIA50HTRJ0djzWjIO75JyrGLH+QlTbb+5Hwsn9EFPzC7ShEi062jtSCiY
 e86I3Oy41/4+sOFxM43CwjcP6/YtIV3zOD9QSxjv+PQ29ZqYvP93GGDNwWqs9YNtL8CK
 MB7jvFO5IPd3lCuTOM1DmpLPXREbJxWIfQpJqxy2Hd5+xhVN4cgOfZZgF7rQlgEP0Uy1
 jHZqAWonYN7bgnZ69FMfwSs9td52tqRELngkB2Arp3GAUPnZVcCOHsELq0xLzzNmyMpc
 ZBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767907168; x=1768511968;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FO50iimhZ21DstKTVyAjmBYCGviuu7Xy6azG/1/SSJE=;
 b=tg49bP3kpY/v+Rpw8L1gtZ/55kWaEqlMRJY4gLybgTkriB+ERh5XUZBNY9hpUIewgZ
 h/N6oDfHp3/tIo002iDp/rIwYFusIGhUlgksQdzI3uXIivc5cuY9dpg1+fBWG7FmMN+c
 APoPBvW2fVFTSqdtbBE+LS0IBNcl5d4kBpxfF/jjM1XrXnq0IHC7YudW1nYGnD8x9wYQ
 xi8mC0Q+0EovjtZ9tY7GgCUnNAhKrZDutiZli/fiGnFpyZoc0sCSyad6aGgsjMmbcLWw
 5Od6rjfxbrJdgD3Ze1lft6jC9/CXLvBXVRU+/4hQmrV4yXejl+d53ufdcCK6xPkdhntC
 SXNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX50WxxS+/PBRLVHLwZQxUMvPm0CLcb9G3MYMQikzpQxb+5ao6tJIpIdpcvfHEISc2i6IY0vFhEs75M@nongnu.org
X-Gm-Message-State: AOJu0YzjSrPZ7eIRBW1kWVrPnSUSKYj/GT6/koqCNo+Q2ZBs8srSOfkg
 TfLxsL7IPIkMte5pGPXNrRnH64nL95vFLnwuTXC4aOxgr56DTnNUgBDbvhlXJl0zh3g=
X-Gm-Gg: AY/fxX7yD6Po9rv+CcPJ5OzOtDiF5xqabVckX2AO07ukEvCEPG6RfvF2BgqD2AhUzlx
 QpjxPmOw6RsItWAn8TJKnaG3WazBLpS/zmqtBpwYBFWKdVaWdxXJdYC+sxdv8Lw1FYH93t0y6nA
 K9jUtFHO3x9DrNXrn5qdJs+fGqjo+8x/afYOqoMcokiSwsGRY21mqgChDTKcAEhhSjKnc9BcdDG
 wj+ayMJBKYtkKemQW161vw84nvmAo4bgjWgjdvtCR0b4PnF/7EO5Ik2c+8+tPS0fH32v1NV3/uH
 yuJbui0n83vG2REVIalQcpr9tDAQtsDCIvz+yykDpzLho20Ry/b8iI3O+yxb+kDAzCaX82I5ZoP
 X6KDmf+beMVe2QyW1LwzbJiAWhUovDKxCEPN8SxQ2obdwwn1ZIo6sG068dAsF05MUv6JjN1VT9/
 VxBw0/F6QfdNJAKXJJ0KuqM0s3JZmCM9q+tmHiiASvjp79ghkYEeXOeKsY
X-Google-Smtp-Source: AGHT+IElQNdGre2M/W0s3JYzhdB5QiwVQrOSounUZAMpBIZTFoMm7Mb9sQHRwywxAu1AyeTvdIgtWA==
X-Received: by 2002:a05:6a00:3be2:b0:81b:cd16:7f44 with SMTP id
 d2e1a72fcca58-81bcd167fdemr4391520b3a.45.1767907167726; 
 Thu, 08 Jan 2026 13:19:27 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81dab89f2a5sm986645b3a.56.2026.01.08.13.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:19:27 -0800 (PST)
Message-ID: <5fea4af5-88ce-47fc-950f-2449250ae7fd@linaro.org>
Date: Thu, 8 Jan 2026 13:19:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 50/50] include/qemu/atomic: Drop aligned_{u}int64_t
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-51-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-51-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> As we no longer support i386 as a host architecture,
> this abstraction is no longer required.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/atomic_template.h          |  4 ++--
>   include/qemu/atomic.h                | 13 -------------
>   include/system/cpu-timers-internal.h |  2 +-
>   linux-user/hppa/cpu_loop.c           |  2 +-
>   util/qsp.c                           |  4 ++--
>   5 files changed, 6 insertions(+), 19 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

