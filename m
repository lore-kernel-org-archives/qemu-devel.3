Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AEDC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbEd-0001Ee-MZ; Tue, 18 Jun 2024 11:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbES-000199-Kn
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:58:53 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbEQ-0006F6-S0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:58:52 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57c68682d1aso6475706a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726329; x=1719331129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oh/qxZMGwp//C88IgTuSNlj4+X2WfZUSPeqgJQkhslQ=;
 b=r26pbwuYpdU6Gj46plPLcjezf5HgnQR+gBFqEuN2OjTn5NPxOpdD42o17AO3YizdyQ
 ogDRtWWYHUFF6WyoYd//iZi3tD3rBchHxdcBFgoDw/r13OG93A8p1gXXCzGbrhSedI9g
 94iehTg73tsmCeVjX4maa0NPg347KKwzAZS4ZU5v4EqNjg7EEKGpjYAE5fPfskrH0kJv
 QICCtMHZFCk4GNLMP/eSVL+celYuSzKke0ACQekJlvThmHnM6zMKPCdlz+tLI4vbswyz
 rm19A0V6aAL0xKQc6rFyfnT1nytugW/Lxc+126j3XJy6xzF4aRg44pTJJkBDtUP7hi/L
 3m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726329; x=1719331129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oh/qxZMGwp//C88IgTuSNlj4+X2WfZUSPeqgJQkhslQ=;
 b=HSznOHDfhi3clM6nefPGdWd8eulFaXn6nHyU1UD0cUZnAFRFBviO5YhwAgWEeI57UK
 RbKq4NZuSYO1Kp31y8t9hn/ofe21XnIr7ykhP0F9FgJtboQt4jujU/bRBcecEW6nUxjr
 BCAQSpimgGgEDJOLfIIhYJTCx7ReUb+1HcbTS1lFEy3a6aeWxyw7ZQ1DmJ1e2f8979rb
 VQnouw+SVmplfL7G5Hg01qCulhMf0YMZ/tzeyXDglpuMQUif1JEIP5ZeYjOE9m2XdpqP
 fAs7L3hA9xglQLaJUV3A2E1+6FUm/bUN6JO7Mawv2UK/qbzxVesAZ8Pn+XcUqJKxBgwL
 f8tw==
X-Gm-Message-State: AOJu0Yz5LpEv7ht7h+tHRAYasawudUtMys8wRKXXE7x+hwUGgCNjyDev
 /ThsqwbaNcca0QwSogVo1ZHuT3HOL2n5E+RhKDJdyGvIaqeVHoSXjRcBTkC+MQVPIogdYXSLD/h
 q
X-Google-Smtp-Source: AGHT+IF/hrRCZ8plzuHExe8TjARLZAwlsvTVY3UjNrZMX1ZJP7vcCvyhEBX2z8B1xC8yXuonJKEvLA==
X-Received: by 2002:a17:906:f901:b0:a6f:309d:ec23 with SMTP id
 a640c23a62f3a-a6f60de68bdmr800581566b.72.1718726328892; 
 Tue, 18 Jun 2024 08:58:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56dd10d3sm627444966b.91.2024.06.18.08.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 08:58:48 -0700 (PDT)
Message-ID: <42acaa5c-3642-44be-8609-34cd6cb1edd2@linaro.org>
Date: Tue, 18 Jun 2024 17:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/s390x: Fix tracing header path in TCG
 mem_helper.c
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240613104415.9643-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613104415.9643-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/6/24 12:44, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (2):
>    hw/s390x: Introduce s390_skeys_get|set() helpers
>    target/s390x: Use s390_skeys_get|set() helper

Series queued, thanks.

