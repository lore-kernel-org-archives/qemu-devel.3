Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA898C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GWr-00068f-S7; Fri, 25 Apr 2025 06:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GWp-00064U-UB
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:43:31 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GWo-0000YW-6x
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:43:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394a823036so19373095e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577808; x=1746182608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ctMLHAH8RP3OZzhYF8QHmpkJ3aP35KVo0Te9zm3lY0Q=;
 b=GgjmFsFLjYM7ZmWKKnz9Wi48WwuIv92PuUeqxufxxuXG88V1adl2hgwy4/ondiv93P
 HTNeoCPP3CiLw/Q+QCfqe9cRkvFoZPTUoNzrBb5+ub3bYkY2Oh9ljFz/XbEUxOW7zcsA
 oF/xEh4JnxyA/CdEmWaR3o/C4RNPvpG2EJTyahRNcHTywtT2QFC7y0nsfXOKG6hL32gt
 XfBeq08hcIg+OFcJgwUm3wCF7h61CEk2nh3lpvcGzw0sXnxGpBkoQh6vfbV0NPF5MST+
 bjhlFL2XUiATG2/xV+JGe4Bi8KsgRp6TpZxf3fRWoQMa+3koZh3QO6mEvL/B+qGG8Pu3
 e6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577808; x=1746182608;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ctMLHAH8RP3OZzhYF8QHmpkJ3aP35KVo0Te9zm3lY0Q=;
 b=o5Yq2Lw2LYwpitED5peniTxV2KM2Pn1CocCLC+47TjTNhYqeoVjWPp075iLdyhiicf
 ZbtjO+8KnqTC7fLkXnja+/tXbGQRmRQWDjh44ao2BikYbh4Cm3AaW7YOp8DC6H7HJTD0
 4xWjVLX40dZNy0VfM9ToqFG9jB6SLVqR1RNHdDkwSNHdMXjrsUcbdPfnlB6ExEkmNW+q
 /UNKtU+9fpp1GuT1y2+23PqBFuMK2D1RPUZB4ptsDOhXbrs7NSt+Mp1MTfLpRQ7buYHV
 dVz9udd/a2WUPRArpskNN5AYazrwKKtnVMO3Zbyqv1fMl1R6wtQ1dIlu1IYtqn+3xk0k
 jdHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+dKYmJDQ3USiZdLlYjSQ2o1C9h8c9I0lQUfNLmrDs+/lyQMtuWOajMXBFJtGqLkj7AsZVk771Psgg@nongnu.org
X-Gm-Message-State: AOJu0YygeI4IgRoCW/QbBFWqJW5HZEgyMRguyN9jIwig9GzUCzG9fHCT
 phfnarbXQkxCkvXavKLJ7k/H3yjnoIP+gMObm9ivXzHH3MoOeAm9EEtobqx/N+Y=
X-Gm-Gg: ASbGnctuMOdPFh0RFj/wjLYBsAZzD1cwp2iS+aDN44u9kvjqJQ+PzzOLYxnlMmcH+Qo
 lRwf97w6XNxi9jWKfW+WLCE3ZdSv6kbTDFKNBCDOMYJ7q970NChlEv3zSPQNCsICr4MekgVebof
 YFqVmn2gMRfr7bszCxuUSnPE0rt2BeQgaeflTLR7c+b5Fo4slPgHZiey9r6SJKFgOGpisjUkBdL
 HTcTZbPnjV466cHfXrh5iSaxwUQfPnq60v3pBB3C6fld68lcGkg/P0Wqo00YqPBZHWxHQKYbflx
 CdA8v3jjNBArNYAuvMh0trBNbW4cAV+hrTzufS+SjJhfde1eiLlP6chAnNwSbPVafpSugwV2c3m
 E7RsVEZqf
X-Google-Smtp-Source: AGHT+IFEKqrKVqoWyAvST75KvrPWfZW/LUag+p6hrQeU/QYCFUT7DpYo9k1uIwPoPxzlFELGvQ/btQ==
X-Received: by 2002:a05:600c:4e51:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-440a66059b0mr16289825e9.18.1745577808607; 
 Fri, 25 Apr 2025 03:43:28 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a530a6e9sm20463615e9.16.2025.04.25.03.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:43:28 -0700 (PDT)
Message-ID: <1cd89855-a8a0-4e69-81db-2ef0eab63506@linaro.org>
Date: Fri, 25 Apr 2025 12:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/i8259: Remove unused DEBUG_PIC define
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250423101125.B243A55C592@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250423101125.B243A55C592@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 23/4/25 12:11, BALATON Zoltan wrote:
> The debug printfs were converted to traces so this define is now unused.
> 
> Fixes: 0880a87300 (i8259: convert DPRINTFs into trace)
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/intc/i8259.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Patch queued, thanks.

