Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D2FE6E7E2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDZG-0000wN-JI; Tue, 03 Feb 2026 05:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnDZF-0000v6-C6
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:23:33 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnDZD-0008HM-Vn
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:23:33 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so5171134f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 02:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770114210; x=1770719010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HtNkC/PGc+5BmXmMJ8OJk79RWRhLJa0YDLAm5idEeoo=;
 b=o+PBAAXV9tBXDS69eZho+olOuNKGbTl+fH1Ciqlwd7MrlyDOk882tioc0B4LQy9s77
 YzA1t0LVOzIU2asRtyr+aDHo0VTMX4D1fUNdBQrE2f7FF8OiVSieAB+Wya2dRMeOfGRH
 JLzCGl5RGAS0VpOUIq+FrDscAynIV+Y5XTu2eUCb+3Xw9Mie1xNpUYtoyERgCxnMphVA
 Qma67Py321g5Oayaf5VkVxVwWlpqqg7dz7QS+M2ovBrkR8JedB0A5sJ6/XWml9OJIKAX
 dUBp8ZPiaHU3zotYYqmxfNo3U5QvxxtlYWS1jpyyvKKFPFOaNi7whp9DEfhf1h3LeBIZ
 a/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770114210; x=1770719010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HtNkC/PGc+5BmXmMJ8OJk79RWRhLJa0YDLAm5idEeoo=;
 b=tVvo73DowVdpgJIrOVLDeEtAAQzNRqE6d738lnWY6PinBYL7mbZp9YY+dY/s6wtWG/
 UG/+gHTtL5xtswkVMzqN9tg227o+eln9w8HoWQgFFTQLceIpr4o3iITaNZB6bjHAsahC
 DNS1HQLHWRsO/swM4YaiOaNS9oAQGDfSeLfNDV7s0WSnb0RnLqIMqmUmfdcytHB2D8F0
 Xw5KpnadnGrBCOh6Eg7MvM7QFzVXEV0cX10+oa9PZUQ1O3FOeSfi4dNMvCxS7lr0VjXK
 fcJt7pbOSW9hGg/vxWYsQlMXQ/Y3+DIm0z20MJwVSxvaIlvLbc95TOnrr+1JaqzDP+NB
 1aAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHjExdgWOSHQ/yUlSdvnXoPbGAZZftqhZ3iKFN9L8XOn1IB0KyLRKLf5d1iD1t1QVDnFZfw5IQxbCg@nongnu.org
X-Gm-Message-State: AOJu0YyxBojPRz2qON8bF1rgenpbsDtvQA9QpQcqfxPlC3nPtKa+9Cwk
 wB5YeXfLTtMNThwwxikkTg5kAsPfk95f7eCMg4hrRnW4IFX1dt0YXNmRze+phn9vMnY=
X-Gm-Gg: AZuq6aJnxCbjTM+brkxfyeHcq2KYkHKnBK94wzkYsIidCTFF3AePUBmgb8lqkyaMn1E
 dvjDRunRKZQUnmRNSmvE1jL1vgqzkz9mzmbZvJqecOV9KhuSLnNlL6MXeHsJSVnzujMillotn7K
 jXLomyxBHTdOUx4klBIf6ugioeVWpnHiy1OijdC3KVMET+4gAYEWcUxBJmCZsj0D1mARQRikJDL
 q00dmNaHSkiDQVsDZ+9tweBq21j1d3eMcmPfeQxgCbjhvAqoS99WmikUTdj/GgNklFEi6FH7bcy
 crzRe8RgiQukE2tOBDTyed+Zsh6Syb0ErY7rOdrx/Y3nZYTyYcKilfysxfpR16hE0J8rOaF6un6
 shadaAGs2yxLr/zibCmtO2de4N9LzfVLBEKtvrJKzzmsTPp/11cXVWo+KTzgVox0aujnfSjxnCf
 IXSUI71r6PV67rsyuCzZzOUhiAXEAw+ax89Ti4/MQ7a/WqO2FSsjNHyw==
X-Received: by 2002:a5d:5d85:0:b0:435:a4a9:6f67 with SMTP id
 ffacd0b85a97d-435f3aae6bdmr24650543f8f.42.1770114210278; 
 Tue, 03 Feb 2026 02:23:30 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4762sm49026150f8f.6.2026.02.03.02.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 02:23:29 -0800 (PST)
Message-ID: <2de81e79-dd30-4916-b131-ec57ffb876f5@linaro.org>
Date: Tue, 3 Feb 2026 11:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/nvme: Fix bootindex suffix use-after-free
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <20260125-nvme-v1-5-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <12599ac0-9278-47aa-a723-ab24eafff3c6@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <12599ac0-9278-47aa-a723-ab24eafff3c6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 3/2/26 08:59, Michael Tokarev wrote:
> On 1/25/26 09:42, Akihiko Odaki wrote:
>> The bootindex suffix can be used as long as the property is alive.
> 
> This looks like a qemu-stable material.

Correct, sorry for missing the @qemu-stable tag.

> 
> Please let me know if it isn't.
> 
> Thanks,
> 
> /mjt
> 


