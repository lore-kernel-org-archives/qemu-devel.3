Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFDFCA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 12:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuVg9-0005PL-0u; Fri, 05 Sep 2025 08:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuVg6-0005Ok-Rw
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:36:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuVfz-00089X-4v
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:36:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b84367affso18581025e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757075775; x=1757680575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rO+oCn32uCo1MWSf29NZGWpICXnmHs5Lb05VFvZZYQc=;
 b=yV/FjPvxAZdVQpF4hTLZKOsWzC4A6WYmYBMDQPn001o8UxBmdJ+Eo7wLnm/a51SCLP
 GwPXHzjX/o4V0m4Iam1ad0lmqX0OqN5mTK4eMGJdMCogksuz30goTp4JQQaweKCVY7ny
 NVFH81xcXAS0Ws2MwzIAUJ+jigG2jrghlemCjTgV6ikE0w7H/asgCYnyUcXluA21t358
 lsvcN6mur1zHC/jkxH0JT8AeIyxgchnJmAJhEcUAuXxOutTI4YuZ62UD9YlT0WsI8kTX
 7P97LUjbM8ylUjHR/W7TBqFuqS+T949T0OMOjSgh0m1gNNmqCXEVf7UXnYvFCpttwnq6
 H+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757075775; x=1757680575;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rO+oCn32uCo1MWSf29NZGWpICXnmHs5Lb05VFvZZYQc=;
 b=QlcfWw/Z7jg0wuukc7vIRKQ1gsVGg+12rQbj/aVCpvJt5wSZvk+lnMNp+C9GTeKvId
 MSMAFP7iekKrjybU3QC9D6yANFOC6ri0Mv6LtuQidpPiJDrWpZH8OKaqyNXjJzqq6uVo
 3CXN/iwEtkZv0DrCh7Dqz9KVq8Ng5gCRGjyzLKfSrwXnkloAN8G3ugjzpRzunuTEc6Vc
 F4nTYqgImNypGNyfgXe3qRsVbf0D1mK1jiCNbcxv6zvPgy06pjXP5LnaVqOvix+236/z
 w41f78doi9XN1yl0F/7TUA7yymDJ40XRksGS/wCotnuq/OB4QE3/nsCtZUydX0aSGvL/
 db9Q==
X-Gm-Message-State: AOJu0YxCt1NR0Xr2lBfGj3oqkY45wAAm9L6YJnSbrBS1YN0eye0eBLo4
 BPiiaoH1L4G3lGqXTj4fajdQATsF3qnjSMj1MRm1ECSmyQJOzkhUyvdfxwc7JNH/gC4GO3tB5ow
 Ou4mwAaU=
X-Gm-Gg: ASbGncsbfgpCxJz4B4DvGfkcQnhMW8RpyKRTRL2Bjri52GTYtywxEj0ytgH+2+ra5Xu
 HslSKeTXPcxA75xCdOBTw+7NPqIIvg/caOK2MNiaDkxowAOpT36KEZ19EyDqriAXpHXyjsza130
 i8LfKu63fulOCWQX+eQK7vqa8Usa5Nsg+IR7Fs8NpKYPHvZ6PnzjZZHnTZR1gwNvrB1aH41xRzm
 nJQLX3pll7xTPs9nvo55MRMEIv2mA4rq4XEITQ9FfhWQp3M3Xzx5AuPynC8tzpvp/hc+MZykzSl
 QHYJ+37aEuqVvKk1pMj2OXXvGnCqq/K2+xRnSRPxZbD3U5NdYNPOJ8G1+FD6QuAjykj7QOr3sjW
 QkAQ+S6hsk6yE6AnxOPx/ImwSiOMEtt2DpiE2
X-Google-Smtp-Source: AGHT+IGEU4QvGt5yV+lR+9IEvv0iVQ23bjwdrmvKmQFxCIzWeXnG3eCR9dpynJ1OP4gRA4TpSpi9Gw==
X-Received: by 2002:a05:600c:1914:b0:45b:8ac2:9759 with SMTP id
 5b1f17b1804b1-45b8ac29906mr169687515e9.23.1757075774624; 
 Fri, 05 Sep 2025 05:36:14 -0700 (PDT)
Received: from [10.175.133.6] ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm195728215e9.19.2025.09.05.05.36.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 05:36:14 -0700 (PDT)
Message-ID: <d6ba7cb3-0cb1-43b7-af58-b4ac83674fa4@linaro.org>
Date: Fri, 5 Sep 2025 14:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250905075048.100496-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250905075048.100496-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/5/25 09:50, Richard Henderson wrote:
> The following changes since commit baa79455fa92984ff0f4b9ae94bed66823177a27:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu into staging (2025-09-03 11:39:16 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250905
> 
> for you to fetch changes up to cb2540979264c8d3984e26c5dd90a840e47ec5dd:
> 
>    tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts (2025-09-04 09:49:30 +0200)
> 
> ----------------------------------------------------------------
> tcg/arm: Fix tgen_deposit
> tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

