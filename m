Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6EBC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdOn-0007Sx-9J; Fri, 07 Mar 2025 14:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdOW-0007Eq-Fg
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:30:11 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdOR-00051u-44
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:30:04 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22334203781so65102985ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375797; x=1741980597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L5bueJID/4l6Ds0Sf3lpumCyuJZvom5Q0Q7U+dAAY/4=;
 b=ITrf+ypWKT8F7ByQ1wtxVlxCafIbPI2TgxRUuN9tM3YNZQj1xa85CRBE4HsruBkZW+
 ijC3LC+GBi8kqbGKKignhJJUPBH4MGAY182/khuiG8sTpAkZJiH2BtpqIbpe0K20apQn
 AwDnuyYFXfm7mq8iQ7BvcRBK8Uf9z5m2XjesMt4DAE2sGuhca1hxeIF7QK3w9IWYlzhk
 2KLHH+QJP9zwj8tLLxXTv9W0vP53AyHZFBchkbxkGo+bZY+KrdIXp+Kqbw/s+SlH3yqI
 00jW4j+XuwQ9fao2cwdPL1FAPC8yrHnFgWQ0yx3E65kQ4s25ml7Uem6dd2K1qBmOmicn
 KHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375797; x=1741980597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L5bueJID/4l6Ds0Sf3lpumCyuJZvom5Q0Q7U+dAAY/4=;
 b=l56FvYW/YWNh6MJQLXAotsyRSD96t9ej+3+sXM539bn3TROYX+ZleXrC4GgVmC1rSu
 upsxe0/8U1tFl++8wkzqt3iPE7Qrkn9OVEmvRCwdJhJvDtXkeIcAG0YqQtXBZVQlGQru
 4+2OYGAOvB6HZqO8h5r/QR7Ws+N3nnoNDk3aGFQjfguF5a+q15XkvZBKf2tHQSK5V7kT
 HrnVuL5G8Mpd1WqTp2fVyBbLSzjrK09tfFcStsteqkZazOSyNIpC8w/uCOM0BbmmBb2q
 W1x9umQYbY0S9xy5/eLJaTAtmqcvc1czn/YQVaJE7fGsoKQxbRLGXRq5lpOys2VPj/Hp
 9OpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBIamEuUdu6/GGWut6HhnU/FdLAi97OlWzMGTTp0484VfmhCYYJQcMISrU0U2QimKEHaLaWQjQcJY3@nongnu.org
X-Gm-Message-State: AOJu0Yx3LPTYxp/WMH10sEMEm2GTDxVxCZ7s+YH2KCRpfHjUarWUSCxp
 D/4skX7CQp+cXDTDX/h+QaYOjbiEO8JvjrNCN6hXpksaSOX3Q5tMRXuOG7SFkvk=
X-Gm-Gg: ASbGnctwhVYHEKSRteOSQpkZefE3jlIFmCnKMtqY29SExA0uPBciHMjdNOJnhO+kuaL
 1MpgrsK/aMO8Q67sfPPRVdZCY41V9IC511PCsty7Sorijph/YYlbgEVgXp4nzPrurGvnRrqtbaP
 Vo8l0SCWdaLC+oKgvrHgF8pf6LtE3+IUkrpYJAfDgidFZWEpl+9bPFqqXrTBnYZ79hjvM1Ema2V
 /ADJ5Npto57TeLhzbviQhulX0lVB3PC9kwqtNEN4HfGOeif9ZehsV0tgrns5JHr1WkEbjgxmwXm
 j0glSYxdqq0Jkj1G/zC5nmqcMZtMEKkp26r2tmFlXE45K/1bHnFDOuuMJ9ZQOVU7wnFSzgVWDt2
 Un1sP4fBi
X-Google-Smtp-Source: AGHT+IGwIx6bMaisOgOHQqkHd+6ZpmpTUh5UEbMm+YdbJluy1j1/WibBOMneY+ahgwgxFzxR7elRgQ==
X-Received: by 2002:a05:6a00:2283:b0:736:4c3d:2cba with SMTP id
 d2e1a72fcca58-736bc0a2222mr1398969b3a.9.1741375797625; 
 Fri, 07 Mar 2025 11:29:57 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736984f718bsm3646533b3a.85.2025.03.07.11.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:29:57 -0800 (PST)
Message-ID: <4a94d56a-e508-452f-a6f1-99133221171a@linaro.org>
Date: Fri, 7 Mar 2025 11:29:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] hw/hyperv/hyperv.h: header cleanup
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 manos.pitsidianakis@linaro.org
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
 <20250307191003.248950-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307191003.248950-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/7/25 11:09, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/hyperv/hyperv.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
> index d717b4e13d4..63a8b65278f 100644
> --- a/include/hw/hyperv/hyperv.h
> +++ b/include/hw/hyperv/hyperv.h
> @@ -10,7 +10,8 @@
>   #ifndef HW_HYPERV_HYPERV_H
>   #define HW_HYPERV_HYPERV_H
>   
> -#include "cpu-qom.h"
> +#include "exec/hwaddr.h"
> +#include "hw/core/cpu.h"

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

