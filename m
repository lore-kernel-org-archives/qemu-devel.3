Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6C6E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNu6T-0001Ts-9l; Wed, 18 Dec 2024 08:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNu6H-0001T0-Ng
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:28:31 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNu6C-0008PN-8c
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:28:27 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so4678850f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734528502; x=1735133302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LhbI7QzymBM/wDdE86HmCxxmMCcz85iIDJAgr8RkU/8=;
 b=cpEaHyw3ijRIvWfSIxa6TxvRi7vawK0GoI5Aog4DoBf1ww0lqPOzmbKqjgbg5SpiHE
 ehPNEeodDnz+SLfod1yKXTGw/gACMY21rJcJXG3kYHyp9ncO2FTH5dVYADCU9Gvr6Sg6
 OPfqZxtDzje3YP8tkqRNoUV2Z0eNrpcbcWLN3inOWZAkWR7ExGASntocd6aG0qniwsC8
 bHjTYhU0nt+mYWmAIDOYdgBfebvKsJTIi848W8h7RJoAYgA+TPDZCURX2qi1yaHHZcEM
 c3Fd3kDegj9hNd1krBgSr1T6Ove3rQHcYbu++1IQuNPAaa1UBPDimSwhNXhqT/Bmtu2h
 zW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734528502; x=1735133302;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LhbI7QzymBM/wDdE86HmCxxmMCcz85iIDJAgr8RkU/8=;
 b=sIa9ARZ+s9u8BZYW+vFrhGjO4HbUsKI/awrABFHmQLfgPeu9bPW+X6FZnvXo4kzKnp
 soNyZHY+gsytii6Sxu3sGF6vdl9raSB6aQvP/+LkiX88+0mP5RKTNIF2LxwCy/r/a2o2
 0Q2HZL+OJ5Ifcw73H8Wp7Dp9EcGmcZwePmZBpcAxqgEmxUpoNUxJp1KMSSjx8EMfpT8q
 rrwyNjJxA6gQ6P02oOaF0+JYvJdoM/W6LHPmrC26yjGQzFCztMAHuFy60lZcLpBL1a3U
 xUBM0S874bU1mX+AUsJFVs3DN8IGT5bjbIEVSVbPeJPwSp41/0fCAaJfol/mKte6waBy
 aYxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqYUXTfnxJTtQ67OaiNxQeg/QG92AOjHqk8ScZL3F7LQ2D9pZxH33LgtaExhUQafRAuPV6P1eFN9yl@nongnu.org
X-Gm-Message-State: AOJu0YwML9ae/kG38pt/xnV/BxNg4dZsa9hL/ByIss+jX0DAo+CsZuMD
 lvzQFgEgsjPMLoDF+fKPB7AU/4KSFiluv9fx7sF0k/w935Gc5eeN08/hB40hpDA=
X-Gm-Gg: ASbGncsFVBn8lh+6a/P6C7kY5Owmzrd9eaETbZ2/LPb6i/3Mzp0PSMon0zOB8NfL//L
 37UGy2QR7ciCytkEvi7ZW9OjGA/JNprSbbOClSu9kwJhLwp+EopG4Z3O1eKqcnNgDqzx9UFz48/
 T5pzS2nTiIqASHZ5s40zsnDFMdLj/0jITlIZ6VO6VTe+qhBeXMpxe9gz+TEnwJJdFbfYKjKBrDL
 6xAb/xGB8ah8EKygbFMT70+ScHUo/obWdGZg3IKz00A5OApUvUjOJyJFAfOP1JVcpSg+/zb
X-Google-Smtp-Source: AGHT+IHmhMkNquyvYye6xsoKWLS9jZaAIFOscnVY3Rmu1gfXFHRaMBv4uaSt+aH6jHYGiGD8mVUgWQ==
X-Received: by 2002:a05:6000:4913:b0:385:ecdf:a30a with SMTP id
 ffacd0b85a97d-388e4d60130mr2818047f8f.33.1734528502364; 
 Wed, 18 Dec 2024 05:28:22 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80605casm14229082f8f.86.2024.12.18.05.28.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:28:21 -0800 (PST)
Message-ID: <0fbf4b4e-a0ea-43c2-a4c3-27e2ed8608f8@linaro.org>
Date: Wed, 18 Dec 2024 14:28:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] rust: pl011: always use reset() method on registers
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-4-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212172209.533779-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 12/12/24 18:22, Paolo Bonzini wrote:
> For CR, the ugly-ish "0.into()" idiom is already hidden within the
> Default trait.  Do not repeat it.
> 
> For FR, standardize on reset() being equivalent to "*self = Self::default()"
> and let reset_fifo toggle only the bits that are related to FIFOs.  This
> commit also reproduces C commit 02b1f7f6192 ("hw/char/pl011: Split RX/TX
> path of pl011_reset_fifo()", 2024-09-13).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device.rs | 23 ++++++++++++++++-------
>   rust/hw/char/pl011/src/lib.rs    | 13 +++++--------
>   2 files changed, 21 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


