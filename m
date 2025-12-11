Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C589D43341
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTlgZ-0004yK-Mw; Thu, 11 Dec 2025 13:46:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTlgQ-0004xi-JV
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:46:40 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTlgN-0002L9-DS
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:46:32 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c75178c05fso175268a34.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 10:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765478789; x=1766083589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=COKAfOgPmZjpI+QgZJ0YkXIWUf+NH4PL4PPy+1/vy04=;
 b=bhFSVb7OBlAS6s6uYV1BN8JgCpNMX0QN2TDkB35sXaY6esKshJkHNMGUfkgGRuNG7l
 ViPxHFLFXgoONCagIvha+gSWgDlCCisV2iGBxuOe2DdAbfWLf5vuM8oNOu4cwdoSOkcK
 vBoFDd9ExSNT4v2HLgFz8dwgLViwdRkgIYz4Tx84gGSIeytso8lDKnqFp6aEoQRM2A5p
 PAQwkKj3VjD4KwKa6d0jhZU1vWnEVnc0mOpq+VDNQ3WdX5CM7bPs6bO4m/sRMoWJUQd0
 V07S7tJDgN1qrrFPdkCqTCgXnZmGoy1/jQye/pMo407xURs6udUdMdmoflwCwfPg8jev
 53WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765478789; x=1766083589;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=COKAfOgPmZjpI+QgZJ0YkXIWUf+NH4PL4PPy+1/vy04=;
 b=Wofv7njOC7zYcwdfUew8pkAkz9NEDSiBdrEuvcNI1f6pApQ9RE+GFwhfEPxeCaBlm+
 ir7rqKeb+/ksVOmdkJ/QzIMS/3xidouq41JZEyVIAb9+SrWm/lBAO3/EEmbDnONy6Q4R
 aqCftKSj4Z2Z2cZWFkw514+ka5U2rv3H74p12wQ2qqOMFe7os5kK3tr76RpVr1MCed7s
 v/D3CxXQgSoHdWe+tb10Ls9QTEz5ikzOlQM+gyNZckUapuvqEARL6B8riET3aGtZtT8H
 9k4wpgokFkf0nfdDmpuPxmwM1S2Bjg1GUYLOs0tka8YGuo4/8RU3g9hNA/MaqjNg7ydO
 2Q5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX1DdcyybUrl0HdzmPEjygDTFWEXbaP1lMdtmQF88ubbEitxyH0jlPsqPCcMC32uxxg+bx+rcirqxY@nongnu.org
X-Gm-Message-State: AOJu0YwgUIouEHQX25cf7M55cqG3eIKgBBD7HSNt5gJEVa5ck1QEE65m
 gK/0YQTtaXiILZhBVmGqO7IGavscn8AaZKBaw15kZV+kMtD4tVY+r8CsjnzE1aToZiI=
X-Gm-Gg: AY/fxX4O7vyL2xFf82yIdelIcawzZQ0qr/e+yf47P9bm96jpjCMEHJXYHRI5dsjzRm5
 lU5GKhKkI5cZHoCicDw8TyVdPJur9qbUE4K0+4I5OXHDbgt9xoSufB81+m5gx2PaZV5X5SoEsZw
 ExQpvTYXaDzke1inpfa7tNgl1u8X2V/QVByEG2qgIST8iC5zQxqj/gSPGmekrbckKgrSM2jiVHr
 JbO7TYLmbPMiWibV8mWuIydk7ZoO0GebH2O9MGQ1C7wlOlwXtTmSSVlh5JQ7koI8W6JjJ4gxhFW
 27siHACZ1ROH/3UY/Pov8VIZ0nMMAlTH+9InfHEnBH7XBpzTOQD9WgrF7VsN8dHdbTwN0UBL8J+
 uO1mY5vbLMMZQ3LJpZ6DojYZgFlif/eN8qcJcKLgZ3Q+D53gQu18n/+9kHbEBu5YedUXYx4Nrmz
 yjsHV/eFkpgjBf0dLdrqWfSW6/OQAK4/K3Wou2RlVwn8cZsnzAf/o7spcXalyE3Gpq
X-Google-Smtp-Source: AGHT+IFuSfmvjJp0lk1/VofvpOPdBpZ20CwLoQe0YqzReF7lJPzjmQ+J6IIB0A1YE6qkTqQGLw4iiA==
X-Received: by 2002:a05:6830:4c08:b0:7c7:63b6:89d3 with SMTP id
 46e09a7af769-7cacec1ba6amr4595836a34.19.1765478789107; 
 Thu, 11 Dec 2025 10:46:29 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb321230sm1909482a34.20.2025.12.11.10.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 10:46:28 -0800 (PST)
Message-ID: <f5bd56df-e586-4cce-9325-8ce9ed702e4d@linaro.org>
Date: Thu, 11 Dec 2025 12:46:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] target/i386/tcg: commonize code to compute SF/ZF/PF
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-17-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
> +psz_b:
> +    shift += 8;
> +psz_w:
> +    shift += 16;
> +psz_l:
> +#ifdef TARGET_X86_64
> +    shift += 32;
> +psz_q:
> +#endif

Oof.  Use cc_op_size instead of a set of gotos.


r~

