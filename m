Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47329CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHrH-0005Ls-6T; Fri, 08 May 2026 05:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHrF-0005LU-IX
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:50:57 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHrE-00083Q-1l
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:50:57 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-44c4cc7c1cfso1476888f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233854; x=1778838654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DfKQM3UVJoEc4QhpogTQ5Fa9mCfKxdbacabvoC0XvkA=;
 b=nnQTqtn91+13dh/F8DSoOK6T+6C2JCoeYDORf98QDsgJlfrFVNVwjWtpeFzyUkzgdK
 lp+8XWUjE2T+Tvz3ql3NSPzGWJ7iyuk1d3W01qImHco4yG5InLNQEFjcvPoCd5TnDINX
 SVwuVuJrD1FkpCSItH52woFllpDjsAjII22Sj6oVxIUczmtPzcXa3MLgjZCBdNa262yi
 TArTG95/LXKx22DB61sqM5MCueHyAuRkmKdHV+sn/ImWQhiPr/eJv8RoznqIYKI7hPkS
 FgyP9KWH58S+Wm107/rXgqF4y2gE8VKzJZy39VbcEf2BxhabkQ17HPXws/WfDpguuaYY
 TXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233854; x=1778838654;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DfKQM3UVJoEc4QhpogTQ5Fa9mCfKxdbacabvoC0XvkA=;
 b=ZHTBHTqbeueUPU84/QuVfygUPi05DzFS+w4arYAEruBUP2jKlCP2yopxMJRaxDZqyP
 elvny0bfW3Xn2GU5Kw/kged52xDuRzQBz45bwUCfEFbwtfs2t6WWd11gwC9k+nRCRipY
 xN2lINmC5i7x13v+y5t7pjuHlHO6/HgQEXodxXPgT3E3KZl0qJP2PfFqlZJtP6L6UGrn
 1NT92/LGjV5SBKvoJlLEK/yZlm2wORIUmBXmkzn5yO8V7nHh9wC3JjiNdJVR+agwOr96
 Dswq9UFtmenuHdfJASkFJnirYFP4AooqADBeoNbrbDlNHt+mrO843K3AWZYdhbo1+vWv
 EKiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ci99jSdQZWQbmiKTCocQOi+1gIX0cOXrknUtdXcpqoFlxi2b3e/YzKwrg+ZmAlUMLiR8Xcc7OYxKz@nongnu.org
X-Gm-Message-State: AOJu0YyYlh66X9ks6MrNpSpG0KvO+CqtRyBRzKfmqAFEQu56aPw0vgBr
 h5z8tBXQIEPoijoDHx4wWnAYj6106L1bdGqKzQ0H2Yc7xPYctOvE8PZWqHbGe4KP1vc=
X-Gm-Gg: Acq92OHr/bfaqVUoPQa2g5ivgHXrLdWCEHuxXQW21pnGAlzJCCVUoDVD7nRGSnUEZ5P
 kUiBlubOwfZKZe4AGTFOJ+NRMDw3pGuUHsycliSeUM2wKP8MjspzllgiJJSlGx8RdhEFBC85ghy
 JeAAntWP9o6xGdqFwKI2dNNSsmgRJpg7EmQ61DTs8VvxrE4lAdCO5vWyFoE2Ji89+RoWQBTp6Pq
 /MDV8ig7QPIuAHcOEsO8dPoppnSe4y/kfGsV5TnqsyA91YO4Cr2zDvvy4PVhs/Zw4hW7JBrZCKk
 BfPty370H+wBMMJxs0JlWaqZ2ZyPWPGKZ1pc60h9BRqyRrki1edZcJg/86nYDCeDTc+9P8pBQTZ
 zuC8cU+IdemzcTV9YlfOpnNrqb++oMUjfQTj44O4SxrjiCQIVNEPpOW+FKHvWzAoTLD6X3En2c1
 723TX90jsFO3W/Njyddx9QEtN79L9HCQNvnUWJlsu5CMwBHSV6vcqJOsBQkZAm1X25FxmzVQ==
X-Received: by 2002:a5d:5d08:0:b0:43b:445f:3177 with SMTP id
 ffacd0b85a97d-4515d3dc657mr19153836f8f.31.1778233854171; 
 Fri, 08 May 2026 02:50:54 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548bb51d40sm3186268f8f.0.2026.05.08.02.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:50:53 -0700 (PDT)
Message-ID: <186387d5-c8a7-42f3-80cb-0087ce3a396d@linaro.org>
Date: Fri, 8 May 2026 11:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] fpu: Use get_float_default_nan_pattern in
 partsN_default_nan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 8/5/26 00:17, Richard Henderson wrote:
> Move get_float_default_nan_pattern to softfloat-specialize.c.inc,
> since there are no external users.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 5 -----
>   fpu/softfloat-specialize.c.inc  | 7 ++++++-
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

