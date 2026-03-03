Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF02EDEBE0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUBN-0003rn-6p; Tue, 03 Mar 2026 13:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxUBD-0003mN-KY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:09:11 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxUBB-0002f2-LE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:09:11 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c70bc5b4e86so2268231a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772561348; x=1773166148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=++HJY4fHq3T4KG7KRgJLBvqQdb3rlHthH62/ICn4t6o=;
 b=VyzDoIicJhyaSFfkhCSyjuctY8+VhR3/jEixqa3VtDC2tI/OcwW5f74ruJbcG6RWdd
 3gsKiwFaRSkmH7oji0AmxfjsFi6KFKfps9uhJs6t0GQcUgtyEHOjzL5wkJ1GdI2GfRIX
 WfCVE3dv6yspUZbqkPB2qe/lypziZMQqywCD5dQNrpRV0lY+Mu8NeD8EISV/sA8/VLS3
 X5Kx6+f1q3cXLqlQHmm00tgCuiNNsNqcluYlZMNKSDUude5n/Qp7uw9LebepWhvokTr3
 OYGfPmqEbndvFQHfolZtb/1v6tqqtvurLI0DvEeZUqRmST4qWhnlXMb84N8vUWuIAgF/
 WcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772561348; x=1773166148;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=++HJY4fHq3T4KG7KRgJLBvqQdb3rlHthH62/ICn4t6o=;
 b=mqG3Ao8nYfNvXFJcIsfKDR3hM/Ag5toS4QkWOFgg4ptf8vnSlrRbNyTMXz0CmTyzs0
 inKjx66peY5XYS7pR/2hcXzyFlMIaPbghgBDhkrD3ATnPQCqvuMIOWn7haEIKu2aO+ng
 HiLyyNxaCOJ7pcN0uFag4uhDmY/Yeu00a6ROAzJcRb/pcoasrkgWo75Bs/Jv9AjjIPfw
 sSaE95AZEZNMyEINg8LFGlnUdvU6i9rNBMHWaHBdSB6povIJysK+BbPOY3PvNsRe6pJ6
 90kuiwfRbaKOTFzIP9AcMiBOLNPuMOypI19uYRnvM84Hwy0KvYkXmtOxA4w+dcppksGP
 L6lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk3ydZRN4UizySQgBri5viTn7wi6PPYnM464UYUKcaabZJkDwM04ocDW7KyHHl9405wqwY9j6r3D9p@nongnu.org
X-Gm-Message-State: AOJu0YyQJaGp6BCZL12a+rQIJMM5VtO0K6InBdzogKr8afXzCtU5NKlq
 BJzq8f5AS1QCYBbu9gtmw6RximvnbnD9TVcWXsBWRAmVi+S1t1ym58cxDb4Tlvj/kPg=
X-Gm-Gg: ATEYQzzUuAd2gZuCk/4ewttwvFsdSNrzGKCPwWAob2sQVeCOX6OchuLGhNqIuWUieC/
 TeurL+0T6F+Ub4l+8p/zsJqXSGk3GQWYuaqtLLNS+BSNyQrv4yZoywIO2v/o/4sAoj8BCM1KyZA
 zABTSLOTwSRsxesnCFXowNSu0k1+kzOmzsg3VNyO4/EkalK03BtF73o4+CvVfa5Nh0D45CsL6q6
 GPHvXi9lGW+mUGP6qqGHAhI5GqULWKk0rgb7Ph+J1rOHHUAz3iY5BqIyxH2Bjzi7yWAWTentMoA
 iHOTIXCUfrnc72VmWNBkPuVZzYS/wuXz3mznd5vM3d9k1HjuDE0PVayM4Ffu4ApX545bQq2TANj
 ynHLZYOYW8Sv6PVxm6qkSiVogaBbMl+AKIINQfOJjUzjZpgsl0qI3P5JmvS90C2TLeqQg+2N4JA
 UzQSN9PrsIKv+qYOSgGgM9VFGtHRFYk4WWwBYGgfJZO0iQyW7bNduHKxuv5X4H0PSblexC
X-Received: by 2002:a17:90b:2e0b:b0:358:f0d0:1a19 with SMTP id
 98e67ed59e1d1-35965c4965cmr14628384a91.12.1772561348044; 
 Tue, 03 Mar 2026 10:09:08 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3599bf8aba4sm2915372a91.0.2026.03.03.10.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 10:09:07 -0800 (PST)
Message-ID: <b1306fbe-025e-4d04-bd54-4f51512b3c8b@linaro.org>
Date: Tue, 3 Mar 2026 10:09:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] plugins: prohibit writing to read-only registers
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <20260303-setpc-v5-v6-6-15c77cfe184e@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260303-setpc-v5-v6-6-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 3/3/26 5:07 AM, Florian Hofhammer wrote:
> The opaque register handle encodes whether a register is read-only in
> the lowest bit and prevents writing to the register via the plugin API
> in this case.
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   plugins/api.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

