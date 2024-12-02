Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B55D7831C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIANi-0005eY-7w; Mon, 02 Dec 2024 12:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIANh-0005ch-3o
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:38:45 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIANf-0003o6-FD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:38:44 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-29654932226so2130946fac.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733161122; x=1733765922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pzR4pE2F97R6pjTffJxcod05ReV9yI9fWs9YO9yA2aw=;
 b=izc8IvsG8t30uiUjxyT2xSAEF6OGcn9r8BB0MbZFEVym1DDmxQ7DWX79OjkoE3ximR
 prjlDGjrbUvehv5lrpTyoQL/r/UcGtMN2xKoHOI+DmVOueUvjr38Mg1rlDRkI58QLKF1
 kVjcfYoRkbGaDxRN2K5ckelLAR/2HEPob4BpFetNmOtt+h/duAW+nrHbQ624sq2CPJqD
 IYV8hGF5oS2Bt67x1ILuUnDSEpDkfPk7LMiYTbw/ouDHG2lydmsImq89JCKmXqK+lGAy
 vF+eN3N3scPD2zFbH8OUt3fMU/LPEorMoOmhrWzM9xERxnrfLdQYeQIQVtm1VOPgeNYl
 GPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733161122; x=1733765922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pzR4pE2F97R6pjTffJxcod05ReV9yI9fWs9YO9yA2aw=;
 b=M5YQBhoBjOxhFshA1cNvNIL9kD+vwt6mad4c0VgH7JijHP7oK8skjafWaYVA89SoR9
 8JzK4uIwaD3K/cozFYlwZplfX54vEyehKnF1a36+CkE95qP2gIIBmttG3/GfMc2E4Wo4
 fEIsEKbV23AmQn/XuPpTaPli2ZrGcHTLGa0divLcV3zWt+x7xarK/nlsJxOUhbg/2ifq
 bE7Zhqf1WNuwKP5Hhyof8WW1ui7YDhnNemGHNm3Z/7ogZ5L3U+S0a0L08g5bOONWZbZm
 6Sd+MTr57ln1IixLljPEf38Vyw/c2ZicOLqi2UeVVx/uMOCQrF11pwYt+Y1LRlbta4Oj
 beWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7VBUlqOzoQKBKGNDEiWp/SNv0OgMvAoW9QFuzSXNUAEchPNzsx0WfldGK68hC9HXJIfu6Hg6+8Lqb@nongnu.org
X-Gm-Message-State: AOJu0YyIr2f8pLy3YvkrTaHPZFDyQOvsme2tP7Dlo7HZRjY7nXgEwtjH
 xMTDcIvF90qZqPd2HDBS7VWMVoEImz79+KBb03kYL/1yJBUJLXPCmgwKDvSiHt6F79FiOJqw1co
 Hotk=
X-Gm-Gg: ASbGnct2knQHYU/IFxrF9bsC0RgmYmCq+DuZaALTJGgDFoIV4Nh7oSxn83lZSsLQTi6
 PO3taYyZ/uZpnv3C7dL5icyb8uASkziAvO8ZY0qQJ2hUWp53mU5VpUSfUvuCfDmbtS9pB700kyQ
 bpi5ffniq0T4Lkt8i3EXl3IWxO/znSaEsKZoItXIbcr8/YYCynlgmz3JYu97JrHxKo0MHtICuHN
 iHWinjD3TXBv9dI4mVm2GR4nPaRQtCUfZrvyoAX46+vmLBkbUd8d9anUECtEOEZ+MXqWLo=
X-Google-Smtp-Source: AGHT+IH08QNIb6E7MWCXn7jb0sjfP3dMkPXOj3azxo9ezr9ZEw3srpQTut2e2msoVcp+0SEvFC2vrQ==
X-Received: by 2002:a05:6870:80cc:b0:29d:afd4:2dd7 with SMTP id
 586e51a60fabf-29de0a3173fmr12340040fac.4.1733161122228; 
 Mon, 02 Dec 2024 09:38:42 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3d3fb1c3sm1823583fac.8.2024.12.02.09.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:38:41 -0800 (PST)
Message-ID: <279c42aa-b2da-4630-8d47-fa5a387634a2@linaro.org>
Date: Mon, 2 Dec 2024 11:38:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 51/54] target/hexagon: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-52-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-52-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly for hexagon.
> Remove the ifdef from parts64_default_nan(); the only
> remaining unconverted targets all use the default case.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/hexagon/cpu.c           | 2 ++
>   fpu/softfloat-specialize.c.inc | 5 -----
>   2 files changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

