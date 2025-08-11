Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D77CA0EDA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 16:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVUz-0004ZX-FI; Mon, 11 Aug 2025 12:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVUu-0004Xy-H6
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:35:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVUn-0004Z7-KZ
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:35:44 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-459e210bd2dso16432615e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754930130; x=1755534930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iitPnH7BC9FEKDij0hTVv9+s82eF19wI4Dq4GfS4fzE=;
 b=cSnTuLGRbw1oVzHCnbkZ/METNLvJPBa3q4gttMAOlheki8bI+UBxKKB9ljhrUEHWkX
 QyAeS7OZLzznUA9LgsWI55QZiWBGRm+DJwVm/IZiwA+iQ27UCiURRjxs7v3WLcjQCzTj
 W/dtFr8ukrcs6H0ANX+TxAHHFftjr/BpDkdajS3zPpEwLelrd3PTkE3GNqWot/IqJ+Sf
 aqfqggmMvhnjtvBt2ZentdlRJyBZy3JOnr3hlvUgSbX/9O6U7EhYhA7DsJUrf0CCi68A
 sSS1lving0+UvKGuXBN42kKdMtsCOAK5AqJKCV6zZDK/tyI0DArOLp1FF46AiIOtkbZZ
 G+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754930130; x=1755534930;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iitPnH7BC9FEKDij0hTVv9+s82eF19wI4Dq4GfS4fzE=;
 b=prgypohL/AgKZtomtDlgKgKFl1PQ8kFVCP14p5lf/EqcYr7wGIRknWQDVzaeW+MijV
 fsqykCBSUUvGuwcNZNWrbVevO/NePTN5aTlyKU0meL1Ym73CfhljK7L/rEkXjwIaufXy
 Yz29eWrSwrCVHF+4wkjy5adKzTwIykGU83dvMrUbneo4Pnvqmvq8BEVyoEYPpAtAWs9j
 yLy7d/gAk2OkjogpWWEl/ETjnCG63+qGWo56euiUb90ZOHfMMzCJzWRThA4BgvTsYMT8
 1gBx/KxJ6sjWCw+J4MCaaVCuzzYiO4lbWjrfskJMU7FYtRNuAOW2RewRdJZ6nwaKotTS
 TA1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOd/xXkPyuz2dPoAM9bJkipw/FnmWUHfCc4RWFoTl36ExijYkVwNK6iDX5/YCSPMtxJjtueHfTWzn+@nongnu.org
X-Gm-Message-State: AOJu0YwynvjN8qhup2tvy4hcPW/+Enb2BAJIMoWC0yDcah1xAKWMdMJQ
 kMvE9d4M/QpI18Cqerv9dueH4ORa0yPT2L7jtB/16sIBbNfSaioBMtNgVq2ZhlZYiWiCa4NKFkO
 XL9B7
X-Gm-Gg: ASbGnct5yy/ZMTG4aUoMAgP8ciP2o6mYO7szqBtbAezVzDl3tfYRTZEaCcJJqd9MD52
 imxeX0yE1GxQssa9raLb/K3xLS4bKZXTH5LocwaAHl/sMP+0UFh1/UR2aYpxu7mEeRTJuTPN+B+
 uDMUg3BTR5ICWGrCJALftXi3fWwQdt9p4HLRoCE84AW/bLi9qODS63KfZBKzgpaSGj4yYyfycZD
 p93emBmPG28uq+FGcfUfWAacoZQJjLi2Y7NU5Hba4Nw6eBV9A3CkyZF7XPsjdt8fbcV7ibcVggx
 wQfMLdfw2wVGsI9Is1dEWzPUH9s369C+kAGiKOqpuTOp4WD6jTfoni/18R9RMgaf+pCjuRqJXgi
 dXYfwPw8M+zEmDHgrIxWzPMSAkeCe0ulsgX+lZjUbtpLDYnzkVLIOD/lOU4NKZCQwbw==
X-Google-Smtp-Source: AGHT+IHLaiBuDpvQKBIABKUFe6t4hkNhHEaBy1w7xazNdDrkqtXX+F6z3OhDmSzWXd+7DNw8RTesOw==
X-Received: by 2002:a5d:64ec:0:b0:3b7:8acf:1887 with SMTP id
 ffacd0b85a97d-3b9111c5c02mr192524f8f.13.1754930130515; 
 Mon, 11 Aug 2025 09:35:30 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bc12csm42036510f8f.28.2025.08.11.09.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 09:35:29 -0700 (PDT)
Message-ID: <1041b7d5-36ea-45b9-9998-b18bff421565@linaro.org>
Date: Mon, 11 Aug 2025 18:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: fix URLs in PCI hotplug test for aarch64
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250811162315.59997-1-stefanha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250811162315.59997-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 11/8/25 18:23, Stefan Hajnoczi wrote:
> Debian trixie has been released. The "stable" alias no longer refers to
> the Debian bookworm release, so URLs referring to bookworm artifacts via
> the "stable" alias no longer work.
> 
> Switch to explicit release naming ("bookworm") to make a permalink so
> the test passes again.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 374a245573b8 ("tests/functional: Add PCI hotplug test for aarch64")
> Resolves: #3073 ("PCI hotplug test for aarch64 fails due to broken Debian installer URL")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/functional/test_aarch64_hotplug_pci.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


