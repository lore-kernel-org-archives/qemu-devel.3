Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25741CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 21:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4QPA-0004AQ-FO; Thu, 02 Oct 2025 17:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4QP7-00049k-GA
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:59:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4QOz-0002R7-LO
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:59:55 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-27d3540a43fso13583365ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759438779; x=1760043579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTOxIzTP+BQAaBPTpPJZVfyMCXreeqVAdciU9zNX6g8=;
 b=b//izObPWgMQGP5gdINqdO7qwZUrQY5OgWTIslCvQNxfRl52sSSshlce2ksIExJ0AD
 szq47cPo+P0fR5ADKhzSixCZLp4UZE3uDLlYBjSBnfoanm3XqYFW4hbUyhjowM4h0TTe
 7wlqeqkNcCQs2TS3JO/AMLsNoPHdSwQE8GoyccpTdpKFf9dd3SYS4B45PoXkMz1bjlD4
 Jwd5y6A15ycPu+YUYvQkn2gRlVhU6FI0TuHPyN6hu2bHSe2SMZT3b9ynfO+qyzJsEluK
 3wnlBUtLa1fXeVm34wwWTR6YY2dtbCrg6IZ6I+QedzDlPrp2v8351sMP+5DWE/yKe0NW
 Rrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759438779; x=1760043579;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UTOxIzTP+BQAaBPTpPJZVfyMCXreeqVAdciU9zNX6g8=;
 b=Q0jYonPFgQaj/VEbeAXPtHKyp5o5fPRDDQ5sNOgocr8EYg5jQ0yQBI9oVWZnKm5Dno
 UvFC5FQdhYpLT/IUeKjLOAnRVfHNU2o2HNiScYdFkvtxopHJsEgo5fQsKmZajgJvekf6
 PyBUhkLOT+IoHPMAJg+K0wvxkwOrBTzZHGCXafc2buCYTxNzP92I5rd02guU+uoSC9sM
 qCUPaVHST9St6yyWa5iXtu/vW/5uMlHjAz1k3CnqRVm+fsNkU7aTExYvDsgFmsf9D304
 dMwQ1gF+O/mthnZORIkgaUWypZB71Q705pcJQihO+8QJCCydLreuLwzmEb5YOy1QrsEg
 z40w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6oTMrgCGJW5cpXJD2C/m1RQZ4S82GL9G2f8j7v8IQFn8Uouk6GuSaJDyIiuUeIX0XH9E0L3pRqNiJ@nongnu.org
X-Gm-Message-State: AOJu0YxJEGqXqQD0T/cmF9PfbZMLXohlUmUmN09t2hmphDnIgFLlUZs7
 6vnfe1n3vAPzi7krMcVRTCYPzL+7ITcGwuVbmf3hyYzcCgylcOoz7tQuWFNTiZbM3eE=
X-Gm-Gg: ASbGncsaxwueVzPaDkCfyisWE/HdNpD+xicFW3FINUKnCUg+n3DVnugDuEatq0H7cK6
 BM9ninn3eRVt0RyBeB65tXeFPZXbBcjODkj236WBJWAhASFunPf5HF1aQlRLIJYvg0gRa7X8gBd
 8ErOfe/tadyKazfVQb/mwqdGG9rtwN1JGGidji1dbcFrwWEYFmtl1UumcQ1VWx0LYZ/wArxCE+X
 pzZ1zoiopf9oxOw1X8ZDLo3DwxlzbpGVMjV/iVpRJ3TyA0qmUwUOZW7Bd0OU3v1p+qCefidBhVt
 fQOhsg7camdEMFps9PO4flicN1tmh5NecgonMTB657O/IPWcDQx9yiIJNX1Y66Nw1xuq1zRzl/d
 RyxpnQBdWJXdauxJH1zmmOkGR9QcxB6Zx9PnIP5VZQy3amHVZXRgpmekRJxjmrJU=
X-Google-Smtp-Source: AGHT+IFkd6hPOCdgOkXjbtDL/remZd1SyI8NHK7JioMLWIsDW+XXdAN7axwHvFQJJt6z1Ups7vWJ4A==
X-Received: by 2002:a17:902:cf42:b0:260:3c5d:9c2 with SMTP id
 d9443c01a7336-28e9a65c737mr5752815ad.48.1759438779370; 
 Thu, 02 Oct 2025 13:59:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1b88f1sm29823135ad.78.2025.10.02.13.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:59:38 -0700 (PDT)
Message-ID: <fbd75cad-a1d3-4d5d-be46-434ece81b8b5@linaro.org>
Date: Thu, 2 Oct 2025 13:59:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Update tf-rmm to support FEAT_S1PIE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251002185910.584990-1-richard.henderson@linaro.org>
 <20251002185910.584990-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251002185910.584990-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/2/25 11:59 AM, Richard Henderson wrote:
> There appears to be no tagged release with FEAT_S1PIE, but
> it is upstream.  As is the PMU patch we were carrying.

I didn't find the PMU patch upstream, so keeping it locally.

