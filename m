Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269C5C369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 18:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u81gM-0001Qn-T2; Thu, 24 Apr 2025 14:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u81gK-0001QY-Cr
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:52:20 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u81gI-0001W7-5m
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:52:20 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2279915e06eso16065315ad.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745520736; x=1746125536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W7J+XZ12y7IV2YYEDm2b2D8ir2IvQ8lU8fLnbf9o9OM=;
 b=ooy25s7UELWLYKKqjRxbWjxYrPgm0U587sUPC9VW+U4NdT79ttd9ZEYM1pjRKvuNH/
 s8dp4/qV9YGvTV3NGsz1Ic0jiy6E2dWRBqHKc1Kq8L6Nn/8KCId9cMs3eKPSa+HSdTcq
 DW7V6/JRXm/Pao+Pfp69imaLeUI1HizXuu/mJ2hyxMvG7oN8ms6UjqRDg5V/kSS0ofAE
 AGX6MHZf5k73x1c9tLmcf9dR8ADqVo5f1l59qZqwK35LW4VpPDEwCGjilnjf4WXBTpS6
 TpWD3wStzsbsMkES/39lRBs0ovDa/fuPyEg9yO3d8fJZ5Hu0XL3oiW/z/vHmShe3ypo/
 D3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745520736; x=1746125536;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W7J+XZ12y7IV2YYEDm2b2D8ir2IvQ8lU8fLnbf9o9OM=;
 b=lnWycC6cF1Ev3frcoW7DF3X/8lUYpNl8bFWU62KaYsHRfwXSknAg8c2vfB5nViahVT
 eUU9LHaGc2z/OTcYr9MjhcE3vesJrI+RSKiyFMejaagJ9lQSNb+d0ci8eac2GGsVadX/
 mfd4rpjW03l9EIa04qPpWyVJtIVIg/XHGqR0+XebF+JumNvGcqSBoucLoL8f0nLzljtG
 eLe+Px8ULmOipTIJyAlPKHAqERbdORO5HhkQSDfyYNTEeb1PQs8qfpqOnfIDA82tGNYL
 0y0siGl+Rz8+QqsxEqnatIOD9VwMjb9GfDV3ZNVBUN7HSPNd244Cp3T/zuX1/fPLUISb
 2Ing==
X-Gm-Message-State: AOJu0YxTLa31O9sMP2P255ARzWf+XZ7Qsb9fWYJrbkl/oUJj9t1NXWIs
 cuAE0DlqF2Cz9DutVfF75RybMfm7LE1/jbD0fvHKhv7HedKQBvQyeDRL5ONR/ipuMRoIzMbdyfJ
 SKnE=
X-Gm-Gg: ASbGncuG01YEdekPSjdt4Ir0sNoYHRmfR386YF9Sl4CaBekYWDBl4fJv3kygW3Wt4kA
 sm/O5Swhq9vjePLf3Iv1rp3UtI1edoA1ZwWqb7rOu2bYZR7GowZ/XGmufWvgD0guGBOvVnhDCg3
 MIZQnJHvYANOEeTEKEX/sL1H3yMHvoDtQTHWdVVWPHiGLmaqcS5fPHJFNU2WS+Mn2F2C/MAC1Tr
 VCxPTC8cVWjSkdv2RvVz1Tzrf+WbirgqAgfg34ID6RCzzIiUKRjzD7k1I1roW+pUM701ANZ0xiI
 +apg6fDZlTS3/PR7CgU7Gb5EvwChPvsgeoU+4FR5EQhn8HSXOa+Hlw==
X-Google-Smtp-Source: AGHT+IFgHmiG7mbG/qfN0p/QNMDydYGP3AHQllGEMJ+OmLF6dbr/0ClhMcu/ALEuPhwP6cZVwrVw3w==
X-Received: by 2002:a17:902:c40c:b0:21f:ba77:c45e with SMTP id
 d9443c01a7336-22dbd47cbcbmr6815875ad.45.1745520736052; 
 Thu, 24 Apr 2025 11:52:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7ec3121sm1562164a12.32.2025.04.24.11.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 11:52:15 -0700 (PDT)
Message-ID: <adc6588a-b8c2-496e-a897-fc73c75d1713@linaro.org>
Date: Thu, 24 Apr 2025 11:52:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] qapi: add weak stubs for target specific commands
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <20250424183350.1798746-2-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250424183350.1798746-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/24/25 11:33, Pierrick Bouvier wrote:
> We are about to expose various target specific commands for all targets,
> so we need to stub not implemented qmp_* functions.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   qapi/commands-weak-stubs.c | 38 ++++++++++++++++++++++++++++++++++++++
>   qapi/meson.build           |  3 +++
>   2 files changed, 41 insertions(+)
>   create mode 100644 qapi/commands-weak-stubs.c
> 

It seems that MinGW does not support weak symbols without any strong 
definition. Thus, we'll need to implement various stubs file and 
conditionally add them in meson.build depending on TARGET_{arch} value.

