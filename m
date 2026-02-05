Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38805ECD9B0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 22:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo8CR-0007Mj-Ae; Thu, 05 Feb 2026 17:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo8CP-0007MX-Tr
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:51:45 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo8CO-00079R-1f
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:51:45 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a871c8b171so11008865ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 14:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770331902; x=1770936702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lJX+hbxBlwNGQlHmfbZtRIrwof8ez91cM0J1LSeXGAI=;
 b=dxBKPjWXgaXdPLg/NFH/Tu9pD85YtNvuT/0AjV7ECHysbjTrtttgUd7A7U/zMU8+Uy
 zY3ll4Wd6b82HFLOWK1RPKAFoH6ErRWvSuUWyboH0saN2291aQLOt/OL5u/GyLWZUqcW
 N8SGDgmU4ntRu/wZXwI+BaGZ/KmEJqLQPBrzTLXYWxICFKMWuXpf4TklQzlcuSai/24+
 knm74DyFf7sdPeMF4k9n82ErC0wEHKr8gOtplRx5NxPNdSP4AE/BDSMhDdUoAukrG+fG
 wfUWRFpJWaZtubuRkpMzxks6JtnPzHBygknXFfxbqe8mbctNZgoeDW5EPBmzgHq1fXM0
 BPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770331902; x=1770936702;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lJX+hbxBlwNGQlHmfbZtRIrwof8ez91cM0J1LSeXGAI=;
 b=go6jOsT6nLP5xpJEzePAI/E9XuMIzY9FFeBG+v5omnq6AcFkTrF5ycgFeaq9vQ2wUH
 BydIAJLMQM1zNq9P9O/lREMNt0iZiivJuFH8JlVCCAvXdOjYElWn4Guwv6To1gLUapnG
 GaFKRMo2JLaSY33CAijgYTlrgGKp38QTdxaMclCD1MeBPfWa9oKX27lQnQsgjvgE+jF1
 lVppHjRrT65XpWq/6yLJeYW4VafDNYHJQ+bBnKI6it/+Rj545fpQ3Fh4zvw0syMN3iYV
 ILjOmwUhuUfHnsk81NVf/aIN8QqfR9St21S0rO3txrviSIz3M1ZsuPDI7dP7Q5rFoynU
 KqOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV38kI15NDTVqd67GjjhRp6GCXxzJkDcrFPgPmeOh8wi130JHpjMdlTHoA3IFoS4Csz0O+zvH6d4gVe@nongnu.org
X-Gm-Message-State: AOJu0YwqgTY8U+PfCbsqZftn7jRsC7TWt8/VUbN0pNs6Vl8PCG7zvzJK
 OdqVKo2lUCTGZEj9qj/m21QZamlXopQkXVJF11quV5OXuvQuoykCEYiXsBQBvfo7r+E=
X-Gm-Gg: AZuq6aKtNeuzZOG7iXfx/R+ebqEVdtfGGRwk/LebG/cVsl9L/Pbuc+0O9LXoN6uQDHL
 BfUhm5nxf3yRL1eP07caxDUtcRqxmoeZct6YXAUuQVx/rhISzhN3BIv+DvJX0zT6ewlpsrzdnYm
 cYOo8jUmi42MN1kbimTho95flV9b2wEto2Jgzkl42TcPC8fyk8nMRQHWoZo8PB5UUqDN8AQfCH8
 69dT7aGuv8Ij2hemjox9e1ILrVmISYu4DZ22XFdfIR+DmgTCq1kBPOiDHWzdTghbgXDYtvITyQX
 AjV+3rpxS+oFMipH2iN3AF4KYdsKW404kRJVO1iPKgQFu/Iu7GGfhajpGCDGUciNviJtk5HiIUg
 OB49eGZOK5VwuTavXIhcHzjdcTI77zCF07d1caql4xOmb09FdBXTlZpPwCvk/UgU/KFx0AHxctF
 Yoa1L7YV3HRYlFKTTIltwqTylkdSIi2m63S0c2gmtwyUoXh6XGH8rzK62xKD4qnUH38OAqluNsC
 QV717wKe/UVUSR7QTTOu3xSlhSqLPdU8x9QQ4s80Q==
X-Received: by 2002:a17:903:2f08:b0:295:b46f:a6c2 with SMTP id
 d9443c01a7336-2a9516fb148mr7007645ad.37.1770331902103; 
 Thu, 05 Feb 2026 14:51:42 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:3c5e:852f:abc3:6539?
 (bg30dhzs8j4dh00m37sw.ip6.superloop.au.
 [2401:d002:dc0f:2100:3c5e:852f:abc3:6539])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a952205e83sm4906945ad.81.2026.02.05.14.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 14:51:41 -0800 (PST)
Message-ID: <455b6a6e-21be-4d24-ac1e-290309758996@linaro.org>
Date: Fri, 6 Feb 2026 08:51:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] bsd-user: FreeBSD needs this too, so drop linux
 ifdef
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-2-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-2-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 2/6/26 03:26, Warner Losh wrote:
> This is more of a toolchain than an OS issue, and all the toolchains are
> headed to requiring this. There's nothing Linux specific about it.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   common-user/safe-syscall.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common-user/safe-syscall.S b/common-user/safe-syscall.S
> index 74f7e35694..2f714cfbe8 100644
> --- a/common-user/safe-syscall.S
> +++ b/common-user/safe-syscall.S
> @@ -22,6 +22,6 @@
>    * assembly needs an executable stack and the whole QEMU binary will
>    * needlessly end up with one. This should be the last thing in this file.
>    */
> -#if defined(__linux__) && defined(__ELF__)
> +#if defined(__ELF__)
>   .section        .note.GNU-stack, "", %progbits
>   #endif
> 

It feels like you dropped the actual subject line, letting the first line of the 
description become the new subject.  Perhaps

common-user: Drop __linux__ around .note.GNU-stack

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

