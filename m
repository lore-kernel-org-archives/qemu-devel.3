Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A024109B464
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Yqo-0003m3-2s; Tue, 31 Mar 2026 09:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Yqm-0003le-Do
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:09:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Yql-00030P-26
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:09:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so45504965e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962581; x=1775567381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bt9YZbllBzCG189/lYq4U9OzwVYRBUfKyFyj52TKwNk=;
 b=X0ldAlobyr6thO5YEsFHkRZZ33puYAtiwLepHA9nW0423yNt1MNPGVqsjbPSnuIpfT
 mFToz3vRlZGUgkM1kazCJa6ssWluQPDond3cIKQVoNmy0FVYM3v4o5Rz3SD4GWSMupG2
 KsjXVpSe4j7dClk4oASm7VlBOnIDA3sYArMK6bSS+Cw1c0ycOxsCRJPut1ANv3fZAwkf
 nx/3Gmm2AKwj/HwlOU3hShmS0RFI1GNkKjSWRunk4xSS3bKhfXaA3tE6KvbBZv9254K/
 KZkBNV/exUctNB9neAWDyBPI+dtWh8v4mhnwvkPHVFyBctKKS4Sa4LCUDR6DYEgOvhzL
 Eorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962581; x=1775567381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bt9YZbllBzCG189/lYq4U9OzwVYRBUfKyFyj52TKwNk=;
 b=jY8wrsEgR7fkrLDjJQAFVm31zIGOgyZB3SJVv0KRd6Pv3FUATY1qZoAiJqpNwxEHXh
 yVBD740fPXhh4rTBm/gP4hQqA5g30b4O1nVh7HEFIIY23NeEfqggE0Knm8atlSAgtwgn
 wYkZGFE28cleKyeSToQ9bzZxNoCQu8dD9zALiTgPs0DpmdxPt2OzhFyPjAwGtAOkiQQg
 zgXiXc5BIhLFbcVHkSWMNZPnUna138rpgZt6xs3WwB4cgqOk365j+pvEOrjQStkMPrHo
 Tb/+R5/PmQzoRaDv90VDLu0j/oOlq34/CPj96Y1GroQ8lN+JxvmtiDLnFemCZA3kXK1I
 17ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5RFYA7dBeWOdgjSnCECbq7/5d35h/a4EEpayOBesymZmNa+f4JFs6mnQio2jfk+9moEgbmsfR2uuM@nongnu.org
X-Gm-Message-State: AOJu0Yyz6F0ev0tuFrMpEY9ynKuLukJZCtJ/5+m2wcn0/1vXO+PCgU/L
 SVfmd+XUgQNJChkUoF7e83+e06zxA2k6qnpnBw514ZmAFdSDeHJszhOBwbvnwMOSEpY=
X-Gm-Gg: ATEYQzwurh4y8u18RO1sOa/d1ORRIk07cthPRyRfs9fVvQiLaYyb+BbuPB5gj4PLbiX
 JUDAohRo2oy4BiyXe33tsXrrM4phNO5eh9KZxhQ3zi89+KqnXCgZ5QcsL1NhI8FaX4lnMlG+t2l
 OKg3wDtVDlZOa1+u+GY99EOv9sfr/cIzYYqdm+Jc0mQhhnRd1vOIwzbxCHhV8eMqL+q7Zb/wbbM
 Z8aavtQnlciXChjBa38nkSOrxxfXTEZ/pE2zkNguz0wu1jRo0wyUyzZrT7gDg2qKglJT9mucwNj
 aYwfR0tgsdG8t1fR/H2cfmo09Sqj26DFxi8ppWxFEmIT9rzHU/aZ6wgaCxzWMXZ6DRJigpYdoN/
 pOVCfqWzztpWtrgIaaCMhVXrth2kn44FMHOLCIikCXv+XoIDBCSO6TuIeGAvdq5wPAMtpqcJyAk
 QotWXsQMKtK0n1uUMoTb+t/0rzIy7UiMZM7Hm9ppRbe+DW8ovpadvgbdbYSQ==
X-Received: by 2002:a05:600c:8485:b0:487:1fc:14f9 with SMTP id
 5b1f17b1804b1-48727d77c8fmr307831995e9.15.1774962580865; 
 Tue, 31 Mar 2026 06:09:40 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e832585sm74871805e9.6.2026.03.31.06.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 06:09:40 -0700 (PDT)
Message-ID: <fc135416-51e3-4539-83b9-340b8d111720@linaro.org>
Date: Tue, 31 Mar 2026 15:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] HPPA Patches for qemu-v11
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>
References: <20260330211859.19317-1-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330211859.19317-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 30/3/26 23:18, Helge Deller wrote:

> Helge Deller (11):
>    hw/pci-host/astro: Update copyright and documentation link
>    hw/hppa: Disable Artist graphics card on 64-bit machines

Queuing the first 2 patches via hw-misc tree, thanks.

