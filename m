Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C98FFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSe6-0006lg-Ra; Mon, 27 Apr 2026 16:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSe4-0006hL-W5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:33:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSe2-0002v6-Ll
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:33:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso56370435e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777322009; x=1777926809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OdH8vBgTogkdfzV3sx7qVuVQ1u0wH+kzn6JUPF4PydE=;
 b=ymyMQ933GLk+b1AZ7nlRBPxxW+tkhd67460FzbbVmIWw2P4BFO8ZTS8G1WQ6IXASlf
 OJatElGt3+4DSDjMndO3Y5czVohsg+fYWbt1f9AUXeFL6pJ5ZviWhMyQCYBpO0rWyLBw
 RostUyWxQxMO2rboR+3BEiPtGdYV1riQH4ceO26999kBOCjF4MhISOAmtr7A1qU5ZNOH
 99bFBjjZjj04MFwXo2fe3Es11CpotGK1VKbJj0GyurK8Xv4YRtbnt8IZVAzoC+AxRef1
 44lAQbdB7n3jktu+jStMa58QJWKcMZU+PqxX0CjVa+G+jBlGHwd6JydhKAtg1cEy6bLt
 3bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777322009; x=1777926809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OdH8vBgTogkdfzV3sx7qVuVQ1u0wH+kzn6JUPF4PydE=;
 b=X/OU4RhkUSTqBwmMDV0WMx2GQnaEb+jE9GkpBC4e6SeRGBgKemj2z8DGzygfW48quB
 Q2KqGSJN6z+nUMsBo3tNlrddG/QDEAMukzNiIux1yFqMWuwsg01H/UccqdijxTNLZtig
 XJ6BHz5AbnrIhHLsXJyxdb4WXY5C+7MIZK6yvYM02g3b7iYPbYooX+6RckgCv5E1xAHt
 SC3wqfsG6sm0tT2KIaYyEusgVtcwbWSh7TcE7O7wvNZgcdYN1XmKNZdHrA50l0SJoKL4
 3wf7IK8Cz6GE7nk382/phO0zjmZ9R6uRkFhnTNFq1OGqWnOaNIk7oujrP49thq5c710q
 IA7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pmGR907+RtpFSDJSxfFk4oDx+TLcbQl+Xk+3SzBiyj9R6sbalGNrkpRD+N1HQeMO5hJlLhom/KcUU@nongnu.org
X-Gm-Message-State: AOJu0YxM8WQudVwMYs8eJ842LbnpzoImew+vDJ0y5HyKkcdp4bon9Oco
 9CETrD5NszmHhPr6QNBrdfNeD+apJyTR4yAVWtEQ38yhaUB05NM9kxyjma+uoRWgEOE=
X-Gm-Gg: AeBDiesboqC+ZQN8b8FKfJyxFWNUFAqTId1ckt3DG4E+3mkdZz61k3Ci4tgq1tVxkbV
 zP8XHID2yx5lMn7H6w5jJlSCq1hSrffPAabcKUa8cZpx4nzjQVvj4MK3CMUMRGvCI3I6TEQgTRR
 +zM8Jb+z2tgHn/6m+bfo8Cw6irKzjl+DZ2XxoAyIspIdaj9IpNSnHcDEiUjWAi/N50pmxeE6HTN
 shuMUeN07rICwcKggB4C83kKW4DUQnVlVGHo5Vqst9yWV3ixUKkW4QvzLTjBv8BG6qXJtL9gRSq
 Cmfgs/bh11SM4AhhnOkcFmlpqN4HIcEfgsAFYIsHB135Ng8VAPX7tFSo5y6UyZOyeFUPR4WbalY
 p33vs8N7Hoc1cC7lmdXjvEzfQ+mYnnVzuOUlTlUMUVOUHvBrQ8JBK29oQu1l/PkwJsborx99yjV
 vV4Kcu8sD44wwyBo671+Ob9bQ7QJNQ+OxokxM3QtrLT+H9v/OoU7LkPR2xGqfNY7Zylmx9nhPkj
 u10
X-Received: by 2002:a05:600c:34c7:b0:489:e696:8362 with SMTP id
 5b1f17b1804b1-48a77af18ccmr3369845e9.13.1777322009025; 
 Mon, 27 Apr 2026 13:33:29 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77aeb223sm3731025e9.3.2026.04.27.13.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:33:28 -0700 (PDT)
Message-ID: <a59673a0-015b-466d-bebe-745cb6a4d038@linaro.org>
Date: Mon, 27 Apr 2026 22:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/84] fpu: Drop parts_sint_to_float
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_sint_to_float at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 18 +++++-------------
>   fpu/softfloat-parts.c.inc |  2 +-
>   2 files changed, 6 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

