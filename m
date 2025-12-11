Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896F3D41D67
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjXq-0000LQ-CV; Thu, 11 Dec 2025 11:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjXo-0000Kz-1B
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:29:32 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjXm-0002jN-Oa
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:29:31 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6e815310aso204885a34.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765470569; x=1766075369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WopK9UUDCdM7pO40qYTW81Q883Z96hlRYOA/L6Lqqko=;
 b=xah4iQaYGdUM3yD2vXjfs5VG6r0FDUeoeUoutPbYXO1sAmbRwHG+YTvMqqN83s3BF8
 gL5vpOyuk1gITauiX5dh7F9Rw2NO7/nkpeSfYRbLIs/jXuQxVKjhO0ZAAXByym9Wj4wh
 E0FIxchkIRQiepz0lCEiahxBFfM9Qga6Uqr9zwcQ2cyyUjylKy2Wdv6LVpvsUX17MkBO
 /CXXPWFi0+ucBRTxOLixr05GDAC8us5JXyV4tN2QJj0+4AXS5rR0sqe+a4s/ZKKj5ejp
 igKe2HNVl/Ged5X36vS3fU/MrMgavTvEPBEA/zNSo9kR8oF3VWDk3HGjFRcboHlC6+mP
 fMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765470569; x=1766075369;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WopK9UUDCdM7pO40qYTW81Q883Z96hlRYOA/L6Lqqko=;
 b=HMHer8YBWd9JdySc4njQipOxvKFRcNyHC7l0QV76t1fDD4tMzy2KDO0ioO2FaVnR8f
 x9+Ze4++DSRbOf36ZYnqSyM1yaTr5ZouV1YjSl4LFM9EkZYa8YIad8yKaDw2G19+dCD7
 6Az3O4WtTJC+i4zcfPOrVj3ZSv4DyCtRy3An2z2jwS81XXcqP8VwYdJPF3JroJtYSGB/
 EWze9wW8kdpadUIhzaYmprMl1HqarpIH/DM3YbnptUs90hqa+TN6ub7eGYftF2nRLRK5
 XeCriLZ/OSw1QVBFv/61bmuNMMymp9PCKizP9xb72TFxs1hqEPsX19w/Tu1nQEWTLNUF
 06Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSQMAix5scTRrTb3jZEb3XAF3ix9N6nHloYqrhfjEfv7fPSs1c0jCFo5JDakP9w78J35DSJU3+/0h5@nongnu.org
X-Gm-Message-State: AOJu0YyWz9fO7IPvaNyNJ35r7lB9CdMt335ykEzQcRDkjfcxTv3kJkIC
 LosNh336Cp686wezy48iHVm0RPAVjo3nbUs+ZxTQ0HwlemuJxGCRerj4d9XeIESH0zY=
X-Gm-Gg: AY/fxX66zxY1aKQwoD2+HpJXrddd5qfb/bpqS6sUfWVtrBLptfiD+8ueEM53p+ZBicy
 sSuTmqNh86uR1o3LVDK5z5XDx7yYSc5h1snUkqC/gyYttz1DCemYiqiqOoT9D0Hoq2GRlTAuwov
 FyR+IztUdDX1wihiaSorsd0OaDHQBVoBDnbzT+Lnvzhw44XIQ2vkvQDb2ttYH/b2odfFYWFoHEw
 SKn75yIpNQV9VrajbTEaHc5PWdtYwcpa2yty0+w5UMKZtOJheXsG86SgRrcq4o8t63g30NJcUj6
 If9EGdQxDgYYqBeuMRw3+Kqr9k/wcRoPFmteJQcktV/L17SEpEPOyBu2y5uXSZCTRDTCzGcHYgE
 7y9WJc9ZOvx5Cr0xSGW0i/V7ikJOAwplMXNhiiF8rOsqRVOcT2h7XqL6P6dObYs5GCn9O1d7ij6
 1EUHUi1x85R5j4fBseFW1Y5wRqT8eohWFdwMlKQNAZSeufEV39/MZP+pPMFQZVD2Lg
X-Google-Smtp-Source: AGHT+IGWsnHTu+222Ol56jJk51nloqt0/UK9jk7ig/ZIE50tgUI+MPu0odBz/6GPHKJ6P0eNyBiV7g==
X-Received: by 2002:a05:6820:4d57:20b0:65b:3c3b:69a1 with SMTP id
 006d021491bc7-65b3c3b7a97mr564172eaf.46.1765470569267; 
 Thu, 11 Dec 2025 08:29:29 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b35f4f923sm1359126eaf.7.2025.12.11.08.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 08:29:28 -0800 (PST)
Message-ID: <f83d2d09-4db4-4eb5-8b92-de6f801e2291@linaro.org>
Date: Thu, 11 Dec 2025 10:29:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] target/i386/tcg: kill tmp2_i32
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-16-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 121 +++++++++++++++++++++---------------
>   1 file changed, 71 insertions(+), 50 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

