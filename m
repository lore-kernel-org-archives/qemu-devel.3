Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFC0C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6kh-0005BX-Sg; Mon, 17 Feb 2025 14:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ka-00059U-UO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:25:52 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6kY-0007Vr-Ad
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:25:51 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fc4418c0e1so3031928a91.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820348; x=1740425148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qF7bqHCActl5BJj9aE/yp2Ir8cY9sfwiNMXYvIjrvs4=;
 b=QomEp1TktJdzY1mgZfdA1fy18zdh4DZ0a/isKbat0V1E3HoE1wgLddjY4iZfsmmjGu
 fFCwVO/+LDfzs2iJAWepgHXurhOY2jtELFSxl4ChTZYNOHafW/rQL5FVi1fqWRIq1HuQ
 opUvsHZmhNsduWmy8UCHPzBABh8Z9nR6PXaQ2I34hhYHszZjgsZNuvO6/88xzZvPNw37
 T6O6BVV+8VK942eQrUUFBP2LdyXCGbfcb0tsKL90vm9Rw4Lq5LzhWhvInKWpVuNcXuUw
 V3ehd42UUDcHmOYIbrQ9wMsWseoRcdkPJOK7UEK3kfoSHbL/VJY05EYr68eTi5Orx28F
 bBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820348; x=1740425148;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qF7bqHCActl5BJj9aE/yp2Ir8cY9sfwiNMXYvIjrvs4=;
 b=e7HOd9WpGCuw8dmXpspUucZ4syzHfq+7fUe5IOcDYd8nQGLS/3p6zclg/5Qrwo77tv
 KjAWq3ScMNl1rQ32x5AyEdI5a6SbsdSqmDhQ++UYp6f6yRdaNHg8WBZm/NqyLNru82ha
 ApQpk/apmkOixDjTc9Lc/epUUdPQHl0TyeOVAR83ZQr2SBt9gWBcOc8ikM/EeCqIaCCU
 TbW6FUOzc05y1PaLJDQdqSEz7h/e76O0U4GiyiI3hrfzLa3B9ImS+LH8b43l0zYKXBIA
 Mj9dUDgmcw9mQD/xIRBniGea/95dHQJVF0whDY/AqnokvwBn6z4M7GSvPXRCPk2h6fq1
 LtsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJU0XjM9z2frvF684hcsZfwMraVeSUcnMnD7a+e2ywSGjXQagElXdcFjM9CyytQjWv1F3gDNzN/++L@nongnu.org
X-Gm-Message-State: AOJu0YxxqLrdGnuSXqJzaFXnWwlQRuaNO0PH9kDsAPU2ECcrmG5UaWiH
 GcdVM6QNB24+XNYxdkV+qnbwsLnyyUiT4n20WP0ewtwzILj8sPwyPeWvV9OWEI7bSDbnj/K/20O
 Q
X-Gm-Gg: ASbGncssw+j9XXWL3uxMIGYEMrz8s3zUIj4rnwW/VWzjTHLJRNQy9rgFCNU+wacpTJK
 xwmcQOFMqgeSEtBP9sek9sQvZD1iyN68laWCxb93kVzhxcQ83BIMYbhaEZvPrfwPs4l6+1voBa2
 fKoU8m5JbuFXp5Vkc/NilLje1tp26VKKQMaoERCXUM89u1B2QE+yteoBEL6TbHGgBiVXL2H//GY
 DBE4YEgl0XbB+Uk2flzey70xBAFDhJyAfzIKUb1QLRzCbSlYzcv8XnFStbmpltsa0WE8wtpec4r
 0ChHXK7WwSpMccQgaVUvF+ww8DBEDHSbKYaw0fyH9zYdo9rw1wSp+oI=
X-Google-Smtp-Source: AGHT+IFk/qAjgsgIRB5wLu1YwSvng61OtWHnnX2iq08h1DEZbNYI2KAvtWcXEBmyWAhSvGiHDlBv+Q==
X-Received: by 2002:a17:90a:d610:b0:2ef:ad48:7175 with SMTP id
 98e67ed59e1d1-2fc0fa67226mr30682005a91.15.1739820348601; 
 Mon, 17 Feb 2025 11:25:48 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d537d0f2sm75395645ad.105.2025.02.17.11.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:25:48 -0800 (PST)
Message-ID: <335900f3-541c-43a4-83d8-fc91f3c936e6@linaro.org>
Date: Mon, 17 Feb 2025 11:25:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] fpu: Always decide no_signaling_nans() at runtime
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217125055.160887-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 2/17/25 04:50, Peter Maydell wrote:
> Currently we have a compile-time shortcut where we
> return false from no_signaling_nans() on everything except
> Xtensa, because we know that's the only target that
> might ever set status->no_signaling_nans.
> 
> Remove the ifdef, so we always look at the status flag;
> this has no behavioural change, but will be necessary
> if we want to build softfloat once for all targets.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   fpu/softfloat-specialize.c.inc | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

