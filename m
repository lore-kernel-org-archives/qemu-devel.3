Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14F5CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 20:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEvkF-00034o-Rb; Fri, 31 Oct 2025 16:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEvk7-00033u-Bi
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:29:07 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEvju-0002fv-DO
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:29:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477365fbdf9so5176585e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761942523; x=1762547323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=adk+0ju45uaOjjmlt+1dUAWeLDLmgGwn0DteCOL1uUk=;
 b=GiDg5827+RBjpkFThMlABmAXrICEbvkP/IY4CD5RF9IG2bTAbKv4+j37khFQVayTWf
 R3RpdOsfCPT67vINTj6TJCBFbJVxQRy9nYjo5F4009+ZhwimfYVo7xrxCe+nAqv5PnQ+
 JqOoGI3Gd1accwvbzx8jRIAbZCZR+BqTTlHIfpoNTG+bS24QTiN5W9iEbnqig0/nZ+nl
 MYwQaxlYASP2Qx+L+N22G4SHMSzQ9PD1Ij2boZq0pCWIl9sg2lgvr2fkmIgTWFW30LkQ
 YkPFVXocnW1PoVZF+R1GzoPXuGEQqoJ0Uql0FbP6rhPf9WTrfAZWUjTctjnOi4XLnPfH
 Sr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761942523; x=1762547323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=adk+0ju45uaOjjmlt+1dUAWeLDLmgGwn0DteCOL1uUk=;
 b=HwRRAJ5rf0Mo+zaVPhePudTFnJ+fCXE67W7ftPIdycBBgMg4/+SEW/Hb8Oqs/3nzID
 NY90LwAE5uXPWKqDLUEZYlx/jmhI54m1KpYY1BO2tS+xBoU/B7mbxfsXaJM7g7toCsF9
 e+YkpnB5JLTSRsQErdwLojkzZ9ogG4oyuojwCO3OXovXHyO/YQIs95JvcRTGK2U2GG8A
 3tgKiOFERE+ER5mMBGBCOGWbgo66OjaAhLIgVfVmJGMX1b4Tx3wakzLHAuiOHWH+1kPP
 fw7JgQwOcQPPwSFjfI8wrpvXIUQSG/7dsbuKWctb4iR3sSbtAUCcrIMtN7UzKzvTEOI/
 6EXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAg6/foGdCHr3Omzc4ViwkrQMwdhd3XVJJAgKi5E3aqEcqUxHQhecIeBkpTghGLq7Min655aEyJsdm@nongnu.org
X-Gm-Message-State: AOJu0Yw7GN1JwBwySkIopyVIGV4OGwAQxo+op1Cc8B+L4k7XLrw98AY4
 zdqB+vrA6uq9Plxyr+WRXbJFO2Y16roXVeJZ8eGFAPBtG3H5oDnUBAoOHk/VCE+S5cs=
X-Gm-Gg: ASbGnct73oba+/RTNH1kIFYjEdoe4Ej9ptNfrthXHqtZDrf/J1U9lipA+cD62MUuv6L
 maFI3CuK5IFY+iJQBkqNc1foULwmBb/XrWBgFTNLEY8gV1bJW+1aVrgRqNbAuSofNmaIdc/kAMM
 TUn3A6ux20QaM0bAnMQicTuWBY16v5PU/IJgbu03/Tssssnm4DYFIXJ0kycS9ewes7iXqmdivIk
 NwVs4WMHurHMrcwXblJ/ejL8vuyKXyTlqHDNC3nd+tMYL1CnUSs5u2EioF0rV3hYVRAr6i8/GQC
 2f7v2iPef3qhjQVuyhW/qnMQ8vif+dG7RfDIE6pQqGjD1M7azaYdvLzENSw4o1aI6i1lknHKrc6
 gvUU4iRNVB2awW3oossoLcJykRmJKMDNKut7OWukyOtItRFcogit1QoT8VXCv45bwZ/TYNpoXPE
 Gqn5SYBInrGXWbBadlHDcX7uaxd7/6Tc1OfUz9ZnhXLeB0wRZgFSDlmtGGnHo/czRqZg==
X-Google-Smtp-Source: AGHT+IFIkdw2MC7YszCufTbfDfBkePx6XbdYueOL3kd72fMp5NtIiTi9dSLD72jfqcHqiArpsIr1hw==
X-Received: by 2002:a05:600c:1c1d:b0:46e:4c67:ff17 with SMTP id
 5b1f17b1804b1-477307d0a16mr48777805e9.14.1761942523038; 
 Fri, 31 Oct 2025 13:28:43 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c110e77esm5055149f8f.10.2025.10.31.13.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 13:28:42 -0700 (PDT)
Message-ID: <bc0b52b9-19df-43b9-8f20-61f7101b7975@linaro.org>
Date: Fri, 31 Oct 2025 21:28:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rx: cpu: fix interrupts check in rx_cpu_do_interrupt()
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: yoshinori.sato@nifty.com, Thomas Huth <thuth@redhat.com>
References: <20251030165932.138512-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030165932.138512-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 30/10/25 17:59, Igor Mammedov wrote:
> Commit [1] broke interrupt handling, replacing interrupts fetch with a bool
> and then the remaining code attempting to check individual bits
> on that bool value, which effectively masked those interrupts.
> 
> Fix it by checking individual interrupt bits directly instead of
> old 'fetch then check' approach.
> 
> 1)
> Fixes: 87511341c30d ("add cpu_test_interrupt()/cpu_set_interrupt() helpers and use them tree wide")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   target/rx/helper.c | 41 ++++++++++++++++++-----------------------
>   1 file changed, 18 insertions(+), 23 deletions(-)

Queued, thanks.

