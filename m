Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D9DCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL394-0001ow-T4; Mon, 17 Nov 2025 12:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL392-0001jN-FU
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:36:04 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL390-0003B6-9n
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:36:04 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-429c82bf86bso2641682f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763400959; x=1764005759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MRa/eb9bBJeLe4hxEkwhs6tOVk3XoEKOM6B4xW8GjOE=;
 b=TsJLRLfKwrtidYu+PztCur6ujTxglGkw4Jimkr6nlR50U4ifW+EuVLktCh1AQuAVqY
 PQ5YOYyMUIDhZdM0vwEgxYHZICZyKRNtctGEEp/DtnvAIzIMe6KC76FpWcmhDhOYwxGR
 CLiqUBfUNQHnul0MSCLPgr4dUEMNwwnFT6PFZTOWQC1omzI5kd/jfPprjDDYr6rWo+uS
 WmY4SIm03xCvKicafpMCzvecIC5HCJLZt5ydz6Lp21bFHNNnS2JuReI2vGPlUMHcceeg
 uqZ0lo/+abReuB1YMbr0wnveN+hlzZAjIVyFUw6GVwlcW5j9on909rj7M8LdbTWsHW5G
 wUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763400959; x=1764005759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MRa/eb9bBJeLe4hxEkwhs6tOVk3XoEKOM6B4xW8GjOE=;
 b=MCRl+26UoDeGEQSWBTZVS1W4/gWopKQiBBb82Dv1zDgQABhXTWtDNuLEEUCMt7mQgw
 Kgu7tM1YkXT+g7RQDAiHwK4ytkS5mF8OA//3hSJdLStL4NQcm0M4xcGSPA7mceH37dtD
 +UchsnS9bbBHMmOqkMlkiS3rhukwLZu56aVB2dO2fZpUrN2NhCpS2Tc5TPNyBp/28p+x
 4lb18z3zf04gmWZnKb/E8lpG3wC26Q5YRuxMBfNk6QxOzIqnACSTjO6CA+DgprXWoK3q
 xdcdJ1XHLLXks/AWfd7IMjN6xsC6/uEK0VN3lb70HKICyhUYKYIMKZk1k+SHhtLz6PAI
 pz3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLKFDTYOTCMOgTA99cdrYAbFdfJVgG49NWoBLUwWobnGWl5cxamUEjdukvorU1V6MrKuZPVoSQrG70@nongnu.org
X-Gm-Message-State: AOJu0Yy6ZjruQjYr5ki/XZKtr/S4WIcfizlLECRhUXUVObXa57YXSGpc
 vkmIKlNf4iRFBkG/tcBYYVFqkvpLYzCPWMz+nc7EX1E+34chUkmVGV9zSRahIIp0X68=
X-Gm-Gg: ASbGncvxaiREP/OIOsNtEHoQtht42mBXfYAUFM6C17ex5s/ucFWW3C3O1ZZkW2KvWKj
 CUm9SoNnD8HTJQxvV4hsOWPsytZn/e63Dx7hSCSuZ75x2qRSMvwYICOPWcL/CClTRDVHx29mhfk
 7pm5jyVtwilH2zlW7q/eTw00dQwNojevSA/L2iCQj6+48d8h5wvzR6hAXJyVd655JiS8dDLX40C
 zFBPaIJkiXnCwJGxAanwHwOmFOGIkdtx06OC4LMTfUSQu4QYNQoGoJXJIN+mYPiKD2V2NX+kvuW
 H61S26pC8I/sDWHF+lFvPypsmDdx/TG/udEvlaESbsNhYRJpXSmCC32Vd5kPWhfzaDyC9VsckZf
 wwI+yFYvE9ttrVmmX8Haa1tvGORFti9c7XVSjyet7F/JoIBv0kluysUKJ6rY4v1ULe8iQoaHj6v
 W/2LLVbi5Vx0hh6xcnLrOTlcA0LbU9HDmfpnBPM4BAzyH29NRxWE502A==
X-Google-Smtp-Source: AGHT+IGjNjfRNB0HQG9b6VUSHT900cQhmthYNzz5LR87uTUJ7LtKei98vBXnymZT7JWOsLhPxajb+Q==
X-Received: by 2002:a05:600c:1d16:b0:477:7c45:87b1 with SMTP id
 5b1f17b1804b1-4778feb78e1mr123718455e9.36.1763400958749; 
 Mon, 17 Nov 2025 09:35:58 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a04157c2sm90943175e9.1.2025.11.17.09.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 09:35:58 -0800 (PST)
Message-ID: <ec0655e9-9ade-4d9a-a6c0-19d40a2dd679@linaro.org>
Date: Mon, 17 Nov 2025 18:35:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] Hexagon (target/hexagon)
 s/gen_log_pred_write/gen_pred_write
Content-Language: en-US
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <20251114230013.158098-3-ltaylorsimpson@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251114230013.158098-3-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 15/11/25 00:00, Taylor Simpson wrote:
> The function doesn't "log" anything, it just generates the write
> 
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/gen_tcg.h                    |  4 ++--
>   target/hexagon/genptr.h                     |  2 +-
>   target/hexagon/genptr.c                     | 14 +++++++-------
>   target/hexagon/idef-parser/parser-helpers.c |  2 +-
>   target/hexagon/hex_common.py                |  4 ++--
>   5 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


