Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43FDC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 13:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURfV-0002lr-Kx; Mon, 29 Jan 2024 08:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rURfU-0002ld-4p
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:27:20 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rURfS-0005Qh-Ek
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:27:19 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33ae74e5394so729581f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706534837; x=1707139637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MVLiCylvxDCbitczUXNP0NJd41XUW+Rx3bSfLrZKRGU=;
 b=oZRvo3TyMqQf4oa4oMFwXypF8L9YSSbqp3e9sAfE5bnhSeTLDUKcpp7atiVQYCjSWT
 uAsfhxtEhJo7dMiIzrqk6VYgHkgwi1MPD/k8gizMpJ57eUfkH+by+KtHt+14lfaFp5kz
 8yov+QEZ6z0ZlA9Lm/BV/LHBqkE7O4/jvQRqlFu+tkhoICsKFflpyQxHUPiwUuKCknHn
 2QN54gQDNCk9SVkVotwmd0T0g7TzOlGyTPpezge0JLXFWQsqIiamdNPYlQi730ZJ+YX4
 AdmhcbgfGdeJByHWFDjfgEtIUsLXIK8tzsCBmIRx93/FCgVctHZ1B1p8h8342+XudPYq
 b3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706534837; x=1707139637;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MVLiCylvxDCbitczUXNP0NJd41XUW+Rx3bSfLrZKRGU=;
 b=VDxHyI8WLqUUAfTZTdZDI93hIOBjeEsdNPiQTpjs54NjtPQsesbCxrDP+2I3uEp9/j
 GPgsaPqecFA+XSvQfq8S9pyIpiaQRarcQ9F+5xC3HtFdXJhK1YUtKD8sb4buRpNdjem7
 rHrlKFnxjLicsxjMXfXh1Fh1kWtOWlt/EZ+bVOVSjwUBDj8o3dqQNIVAxLHkWsTvjQ78
 BJDWz7nfMbSS4gQqX/6X9aXWSPQ53+0SWWWXZBB6LNoWCFTmUnhrPbFrtO9O3hGFZWUO
 xbulZ8DX7+XWiuX6sAkvM4i8kENWvLpOani1bxh0SS9/H7PJP9XOg5Dsrl39R/ApEJLu
 Gq/w==
X-Gm-Message-State: AOJu0YwcORlTT644ba3+312KQrd/yfzhtgsssxRiH2gaA5cFRfO4D3/b
 d0+NCQgtuy7f2rEBHLx+4Jh9ULzO4EwK7v9OoIZgpKnubq0jg86tbYklfmfqEpE=
X-Google-Smtp-Source: AGHT+IGodC3SlzWnBs1kKER1rX6zvIhwZPBmNvs2m0Q3o64PAIw6gFfBaS6uyViRl5mY2Vf0gYsFvw==
X-Received: by 2002:a5d:47c3:0:b0:33a:f1f4:f4b9 with SMTP id
 o3-20020a5d47c3000000b0033af1f4f4b9mr1476764wrc.57.1706534836903; 
 Mon, 29 Jan 2024 05:27:16 -0800 (PST)
Received: from [192.168.69.100] ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adffbc5000000b0033aedaea1b2sm2671161wrs.30.2024.01.29.05.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 05:27:16 -0800 (PST)
Message-ID: <f30a3fbd-2e11-4c36-8107-014f23b6bb95@linaro.org>
Date: Mon, 29 Jan 2024 14:27:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: remove unnecessary "select PTIMER"
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240129115811.1039965-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240129115811.1039965-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29/1/24 12:58, Paolo Bonzini wrote:
> There is no use of ptimer functions in mips_cps.c or any other related
> code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/mips/Kconfig | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



