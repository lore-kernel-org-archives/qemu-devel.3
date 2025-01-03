Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF30E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTidM-0003ky-En; Fri, 03 Jan 2025 09:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTid7-0003hc-A9
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:26:26 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTid4-0000kz-FS
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:26:24 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216401de828so160841385ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 06:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735914381; x=1736519181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ykBe4BeZxcH1uoXSoP4aM5wFAFNIbP5016D7mVp3b/M=;
 b=Rq41Sja/94xRqVoHsgLBXP/TCic/X/xyXwtJOP1GUUU669GB58anWbIa3HGfdwQ6JD
 MeCWVfEm1P/cbd45S71hPZulslNkm6d+xfpw1uDlI+1S39J8rtQGpZElVQJL5uvAte7o
 V07jR9RUFmBPSm5Ib1IQCgAcq1m9Y/MIb/vFTz14LVTQcNZMhE12UjVAC60phmWCxoNe
 txX84QLSzG5OpnR2Oc2FMIKW20H/eR6Kp/AbghSiVtalSkVYkGxM1hzqaTNSElzIK3DE
 /pj1rsXR2ORgIjl0B567y+XpfHxkvDEGLiQ0usYr6b/dfTmZfP0YLotOz/oTdxp0Rllw
 S2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735914381; x=1736519181;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ykBe4BeZxcH1uoXSoP4aM5wFAFNIbP5016D7mVp3b/M=;
 b=JK/70i5bhOa4Ba6kPqQ6AowmfKGMud+wxvWQKl+7Ggj0aUK3uj/Cq8IZlmvpH2y+99
 28KE2OyvdbHVo/Y2hsIVeJmgkHphVE7iMayico4qaHy/cgPIp9JCn+Br8313+A9wvIDx
 L/oO3rG/0884PgLLD8gCcs/Tbl2E5ynG+uoNiigUTUe8Y2qxObWXzWCsQe1CsmkJ8pCN
 0A4F3qOBGeDy6T1AkPw9sGlMAyrBu9VgP2adX1H6lMF76QqPc4/hapCAQMfTqaI/Mlkv
 3hlZ16On3FlIhQQE1L4TYDBZDBTFtJZEQ+uMuwlLdQhpOsmJKW3fAAY5JXdfUGF/cc5+
 erDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUBHQJRwMjjUFIxiJD3A4nki9ArNu0JRXugeS2+H/v5NE7cH81DovMx6027ScI5L6SgumReWBvB6qN@nongnu.org
X-Gm-Message-State: AOJu0YxYBFr0rUaupgj1nMo+txYr15hSOw7Wkimu2XnLpXSNlIK/0gy9
 c3Nlr+QSTeY0XuGwOPtICpVdhAFuvHk/DevU3cHNESj3VwqGnUUE6We2PFDCCWaSuj+buHpDBre
 N
X-Gm-Gg: ASbGncv7hMKjKwXAHLYicNrA+MQHxunKesAiDc7EXFMjaumzUog5lq/dPU+tgy0kFU4
 CoBNUPn7co4OLobKcbyDG5hG61vfohHWrsYowdQIAoX3gAO43I1V4FvPJ7DW/xWuJYFARL5PKQ5
 QzRdYHXoUyS7vwndzGgWT/g5THHenoFOM1IQUHsO8qdQHf71ewto6faSr5ssAWklD7lDA0qVMyv
 z4i9RTKCKmREoTmlO56LulXQVnTAyM7fuPgwOdh2Q3AWxkj97fie/9CoB0Wtaza24Ou988=
X-Google-Smtp-Source: AGHT+IH0p+LQgPIhrmE11X2f1T3l0ulGwtBbXm4pfD4jyX34iIyRgYvKEO40h8KlPPjTh1qaqVwf1A==
X-Received: by 2002:a05:6a20:430a:b0:1e1:a9dd:5a68 with SMTP id
 adf61e73a8af0-1e5e044bd9bmr76952362637.1.1735914380920; 
 Fri, 03 Jan 2025 06:26:20 -0800 (PST)
Received: from [172.21.1.122] ([63.239.63.212])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842b9fb38basm24091638a12.49.2025.01.03.06.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 06:26:20 -0800 (PST)
Message-ID: <2d9611e7-2d61-4bf3-bf75-4934ba76b7f6@linaro.org>
Date: Fri, 3 Jan 2025 06:26:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] qdev: Make qdev_get_machine() not use
 container_get()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250102211800.79235-1-philmd@linaro.org>
 <20250102211800.79235-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250102211800.79235-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/2/25 13:17, Philippe Mathieu-Daudé wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Currently, qdev_get_machine() has a slight misuse on container_get(), as
> the helper says "get a container" but in reality the goal is to get the
> machine object.  It is still a "container" but not strictly.
> 
> Note that it _may_ get a container (at "/machine") in our current unit test
> of test-qdev-global-props.c before all these changes, but it's probably
> unexpected and worked by accident.
> 
> Switch to an explicit object_resolve_path_component(), with a side benefit
> that qdev_get_machine() can happen a lot, and we don't need to split the
> string ("/machine") every time.  This also paves way for making the helper
> container_get() never try to return a non-container at all.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20241121192202.4155849-9-peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/qdev.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

