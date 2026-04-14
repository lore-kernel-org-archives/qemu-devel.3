Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F5BF9D0D6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCfcX-0004pv-P0; Tue, 14 Apr 2026 11:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCfcV-0004pT-SO
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:24:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCfcQ-000718-Pt
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:24:04 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b00ed86fso59553945e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776180240; x=1776785040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XcpB08IqGTESCd4Tvk5H69qp4jm5LyRmxEIX6Us97AU=;
 b=eVbMSwDU9R1B7TdQimiRtYQ95KGGvushWjZUKPxicfVE8zgrzyC200xJYVEjkysCbn
 Dg8C5UnjzlBXank1QiXW/ctz56fbHMBslwGU/dmC1z7z7WsCQmlBAC8mVSy93XSW1z3b
 ow6H/od5Tt9LiPDfbZZH0F2pgdRic0TaZhZ/QU2RvFS4FEntXUuC3P6t8GIqQZiVpe4/
 Ssk5YmiPd1CwChw88q3UOl+AyZixh/I576J8g3aEXaRbr2BKrNf1FgWS11QEmsG1/mBL
 K+cTOcnbH69KS1W/hrXSbm6QDCiiPitjQhOTXPgrn5QW1/lFyj1sLP206eOFUOkCLMT3
 pz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776180240; x=1776785040;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XcpB08IqGTESCd4Tvk5H69qp4jm5LyRmxEIX6Us97AU=;
 b=KDIUUlBi3LAFw/9teV/QFd/yaAxrM4ya3QWgKzZtRjAfFNyihEcYgQWZi9gIj/P2nJ
 0wP1obkr26jxfAPTDbqZ4TjJzDGXMZjo2ZiM/nVgqM+5qPH7S55/KoVpUjSHs9WZeA3f
 P8SCwHD1GKvo8zLkWL1sWxteCgXbCnmZroxY/0sND/hbJSG2F9QhkfawCSR+DWWMNh6+
 Ee4xqKNys8Ucw4gkVfzmBf/7nLUtRwTLl4qyKu7lvILCo4s5oBBK8MLeu8WKxwSTCCNI
 ggZCm907VTdoQos7rnQrT4i0ZBuEIvYR8H0n0NQo4OeTrIYbBkEJJ3jrkTiKKpgVPUtw
 paPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ98kqfna84f/joV9/iI1mqairwRTftmPgwOCme03zjzL04D3kBIt49YFOMkawmGb4WT5CA5Q3ELaoa7@nongnu.org
X-Gm-Message-State: AOJu0YzrZIoHYfLl+7SYbXEJfB6Or+z497ztWg84Vi/3pYdMv05Pn++W
 CW/lQwF2L7CrRwFKqCQqyHzSNeIq6Qwk+V0cNfsc3l6fWSnml287ZQwJtZcx4hisUKE=
X-Gm-Gg: AeBDieuIQAOr4Hahxum9ZKCk9+//zT+HmQC/YU+fwc+TTl/JohvWbAAfVGjUTajgxUN
 AiV8q4h+h5n3neQpa68lFd4O3bVi+0R9/fVK+KwAdetfWQc9KfX3mn+J8eTczbZzwxNpUGPQrgm
 ovhfW2rON2MQXLJtdOFeto6sdItdYjjC+k7ooXBITn4IbYBLJwuCV5UA1dpXHWm7EI94qwWRl30
 UfhLqt7rFtyRYksZezPo9TJamR+lMqCWSnxD9U6Nr7XsmhYJgKI6qZvz2ZTEG9+ykQvyUaM2T+G
 gbUIAOLVU0agg4fmyoE9JXKgEMgEt1PWxUF6XTU1SVRLNeGdWzyM9jvsrht9+/iWrrkObXzsRO8
 WA6cpTQCfYKAwYERhWggXeGT/HIRKirTGhKbzl3pUvoSj4u80/PzCTWOsSX2cD3yelqg+2TLOMk
 D6p/Hn/suvj6zQSdb/TeRjqBnoBVT4WderIWUk3ifKl5oNmi5okejbnRk1m48OgPEerg==
X-Received: by 2002:a05:600c:8b27:b0:488:b1c7:b432 with SMTP id
 5b1f17b1804b1-488d6881e82mr234078935e9.24.1776180240352; 
 Tue, 14 Apr 2026 08:24:00 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d684406bsm118781485e9.24.2026.04.14.08.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 08:23:59 -0700 (PDT)
Message-ID: <f83ecff4-b37b-434b-bfd9-70a1ad998d41@linaro.org>
Date: Tue, 14 Apr 2026 17:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] hw/sd: Improve performance of read/write/erase
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <drbptkndzj4malncmyecbeab4bhpsjfglxq7mxrdolonlkte3o@fsrfbjw2hw4s>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <drbptkndzj4malncmyecbeab4bhpsjfglxq7mxrdolonlkte3o@fsrfbjw2hw4s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Hi Christian,
On 19/3/26 09:37, Christian Speich wrote:
> Ping :) Anything I can do to move this forward?

I left minor comments and expect v4 to be the one being merged.

Thanks for your patience,

Phil.

> 
> Kind Regards,
> Christian


