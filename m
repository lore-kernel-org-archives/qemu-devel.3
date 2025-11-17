Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F4FCEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvQV-0004Ic-Mi; Mon, 17 Nov 2025 04:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvQD-0004CE-DN
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:21:21 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvQA-0003El-Q3
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:21:15 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so2880288f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763371273; x=1763976073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=III72Ho9IlNOCr/5k47sjrKlIdtp9lY8lgErplLPBO8=;
 b=JJbLdP5NwjtC1kxlxKUpj5p1frg5oUIEsBw9XMRTgFg/H97HoQN9k/A1fLi0X1e0R6
 cS5aGkykcQuM5qJuaKxAPAVRLvIMcn5mDPLxFE7GRH8HHllw+gkgeVJynriW2qxA1+jp
 m23r2ecQZNBFr2qSCnLs7Y9PTzkeZ7WIZhntRcOtKQM8v3l8xxSGh/AfpDCEolut+601
 MCbXpgLmLcljXD6PSncoZWHJlYEAaRSvRmAdmZE6cBwMUoIgx2t5JcSkmnl65CvebrtQ
 uuTVkBzGi4cJbqIzCkL0N4jk3VBsvM0CpAIoPyjL7gNkp1noF3lLEOO5VEWfmtEpIDk1
 VCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763371273; x=1763976073;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=III72Ho9IlNOCr/5k47sjrKlIdtp9lY8lgErplLPBO8=;
 b=W6X+6j6tkLBpgf5wuifqXXM2IuT7hshR1absenxm5Ed3IDk6wnRYZzcmPYYqqvNYQP
 53aF6BmQOEb0+gQbf0P50LYDl643RlRAdc/jafIpmTc9ntzCvB6M/hmPaGxISPgMFbRg
 kWyweD+nMoMjPd3vXIWqNSAfLO45qwJN18XmOQNX72GnVAtZJGTkoOmn7srHCZ060YkA
 3a3JyuAx1hxfTn2yua1h5k4IJqjpKKwzL9gfuH7nb0XCMndptgdR8Dxo3CwbqAX4MX4K
 eG9PgvCMAspw73HtFKD8F3LkNkSFG5KViKIVB9qVTIAtUQEp8YT8M6ADlce/6VkIgEK0
 wBzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpLNNLzjWuEHXyjekfQyxczjELAt3m5qq4um68alzjb60CJTOcpDBrGHerSX/iiDka3cFPq9Csc//N@nongnu.org
X-Gm-Message-State: AOJu0YxUww2FvEz9W1zQitL9eP2pE3bRe7RSSWoZDR+/nwN131i9Gxmh
 cGBsxdB+tiFgUK1reLgigB6a2Js46ns3//03WBSo4DJu14Ld8BpgXPrEXJ7zgkHFm4Pl/X17Mmt
 VvJb5yj8=
X-Gm-Gg: ASbGncteLnE3i9j2kjkrv3dMMqGOpSFa/K9ljwmuVFInGpUjZl642JDjosY3W8Jiixj
 3SmFkG+VNohNqij6IXOcof5Y3clA3Zykid9prbrV+BPt9a+FjxwupBCLMfz+16655gRGdC6z+hc
 W0ofcgB7oGeFgHwu+mRSOmo7M1uu1F3KBICVNcl0gHaIar9mBEsAO/2vO5m9s4dkptfDByQLQms
 wFvxLGxzhlypjzb4Us1lFKxviP3x0mzDL80+6GMTExkkMZXfXGKcQ220kvvRiSIhZX5Djc0VTOB
 356nIlNyqntoReCzu/w/WGFo8G6NXmRsVmdTMwMOODoFPzCM1DlxZOxsGgrz6xyn7h3HlhElpBB
 u7o84cyAajDhCjEzEhN1hp2qIDooHL9P/brEl2ratic4yHub8rFz2QX/PUvpB8/0JW7XpjERVxF
 NhcW7JixqIYFf8Ux8h3gmE6suYDY+I4o0yKhy113BVYDCNP9MUuSMsv7VHUIK3hMvd701sx0E=
X-Google-Smtp-Source: AGHT+IE190KU/Em8FKFHxrBkf3gF202CjI4gzMAn6ecOwU84Qn2OvYTOZribWu+/RTc3nU9+Uelm1Q==
X-Received: by 2002:a05:600c:1d0e:b0:477:9cc3:7971 with SMTP id
 5b1f17b1804b1-4779cc37a15mr43565295e9.20.1763371272973; 
 Mon, 17 Nov 2025 01:21:12 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c97745f79sm10961897f8f.23.2025.11.17.01.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 01:21:12 -0800 (PST)
Message-ID: <29dfac8d-2f00-4060-971e-6b9655acbaf2@linaro.org>
Date: Mon, 17 Nov 2025 10:21:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] scripts/clean-includes: Do all our exclusions with
 REGEXFILE
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104160943.751997-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

On 11/4/25 17:09, Peter Maydell wrote:
> We currently have two mechanisms for excluding files:
>   * the REGEXFILE which excludes by regex
>   * special cases in the "loop over each file" which make
>     us skip the file
> 
> Roll all the "skip this" cases into REGEXFILE, so we use
> a single mechanism for identifying which files to exclude.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   scripts/clean-includes | 24 +++++++++---------------
>   1 file changed, 9 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

