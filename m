Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32B4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLZ5-0006r6-Ay; Thu, 02 Jul 2026 13:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLZ0-0006q9-3M
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:51:03 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLYx-00063G-8K
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:51:01 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cacd69a9c0so1612305ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783014656; x=1783619456; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6xBaDytMtIhIwsSAE0MsXjT/no4IM3Jq/Rg4JLY/Ow0=;
 b=ljdg1bkMIR1rRTqPEScINlyB91e93fGxrgmNobbcKKNUxyy+p4W4Iv3sSP3uh5li6o
 b2l4DLy+A0RyG9qQMi2Yax9PbY9yWfNiIeKDPZ7nEzti8pc1jEkElQNso9K/+QiRtrct
 FwIwioA4o2CxUsTJTKh/R66MDxNvPtkJRrauhmY7XdeKsTxq5zwd8SxzBzC/W7bjeyuP
 WO0LVB1aXLDZimli++FRU2V5j9Jy3OfWcxH/Xlhba20QN8a8z+A2/EBU0RC6V1giu1cj
 9/gDxW4etxcuznVwevheGmVDaRk9u3H7DN4FibTaXsK59jkKrjf2sRxLGhHVkS7sZNAh
 p2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783014656; x=1783619456;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6xBaDytMtIhIwsSAE0MsXjT/no4IM3Jq/Rg4JLY/Ow0=;
 b=r7apO1YWdNWurmYNitW70TY9gsvVP3xJzyboEr4VKQrW0rzR+0AKlJUP5/f6rGqBTj
 e/12hnHV3cHoytDMtJzGkbpw/dhZQ7pkDpmTXpkXLX9DkMj18sdL/40UcGJgIxe6KC2a
 MK6Q1YGyJryEytAo5UwEEZx1dTDiiFLHSe2YHlVFZEWdWXylED1VGi+14LXOL/aeC7BT
 0LwaIIu1b3WWrmPOjnKuEu0nO+ydnnj5WmYi3B/dXb+NRDxj+pnO8pVSuyYGvJSGqwly
 JJS+5dAQr2rZoYMSWwvWgP1eybnBxa+aIN9CZi7iSVphP/cmpN3iDT8BT/5sDZcT9/Ot
 Hrkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RquXMH4jaRZ4DAozig4pd2EBRUvEn0dXXrp+fbWP+h9JNCGLdXNCXTLkq6dbxNDIuZD6YxRxJmwvDSU@nongnu.org
X-Gm-Message-State: AOJu0Yz73FPq1LwguJv4oYhVTeeZLu2zu3myyT42T0a84On3FVHGsHt3
 PsWMowEB1kG3K3Ig3UtQbUM0J0LdTSh77nvnqiaQz5TExKwgbPHZzcwwIuBnhyyLChA=
X-Gm-Gg: AfdE7ckE7OAxag02ytIaZZvtbR0M72NVZvyCWcZkykQdqXV2TC60vyqRT6GpIaUnny8
 yLKHSACq6oiW7AjjPr+ilPkh6OM1aoKdgOlFGfYJ1qq5EvSw4CgBj0KW+ODs+CR/v0euDAVzYPx
 Z1Hm1ORHeL/arAZJgomICyEGZLIEI2A95WB/tXWl5RRGYRYELI3vDmqJby9slZlbMkfQ9MO3BkT
 rWo+aO3cGCzAIlfM84p0Xk6StorpSgMlLf455Q6GaOa8HzkPJj0XeMYpdaHmey5CixGcj14ZxM1
 ty274sBubntdn+HrkZpyKCqvHxVYLLEGswg0otk3umMOvoSkn12VjU/X5pOlijTBpexS9d2ZNks
 64pbiXcYNPwSAZUfv/WEVYOFu5FWRjPR8fRcKqcYb/DIOVCF+IeeE8OzsoqJYdDpPQytHiv1tLJ
 M7IGgZro2tRpX0lAvEQ06eQQQHMBqPJoi9UkebnRPChpM4lYvSv0Hmnx9J2g==
X-Received: by 2002:a17:902:f610:b0:2b2:67ca:5ff9 with SMTP id
 d9443c01a7336-2ca90b23590mr62849595ad.0.1783014656130; 
 Thu, 02 Jul 2026 10:50:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9aa05054sm16966975ad.77.2026.07.02.10.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:50:55 -0700 (PDT)
Message-ID: <2d9dc4a5-e124-43f4-9101-0119127ea80c@linaro.org>
Date: Thu, 2 Jul 2026 10:50:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] gdbstub: Introduce GdbBreakpointType enumerator
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-23-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-23-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Introduce the GdbBreakpointType enumerator to better follow
> code related to GDB protocol handling.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   gdbstub/internals.h     |  7 +++++--
>   include/gdbstub/enums.h | 12 +++++++-----
>   gdbstub/system.c        |  6 ++++--
>   gdbstub/user.c          |  6 ++++--
>   4 files changed, 20 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

