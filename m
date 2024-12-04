Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF0AE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 06:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIicg-0000pe-0S; Wed, 04 Dec 2024 01:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIicc-0000pI-4k
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:12:27 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIicZ-0003sP-32
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:12:25 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434a8b94fb5so2814615e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 22:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733292740; x=1733897540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hRrfNkXsQG4m4T/TGI/qrEl6IDV4kVgcyEmS5Vo+nzY=;
 b=lDTHrLgoDOX6sc8R/ZFlAnAI+oLd9wrBxHpNeGqb00BjmD9gBKmR7ntPCMnyN0SL9j
 1BZwx39ygLD5bIoVG6fqPMV0i1ZEINeeAjyGb01xV27cFr7sXqXJLFdhiEVwG1yjdHCQ
 B+ltuElds2urydmL3ZKW1iYUfhgkWzy60X8Y77TToD0BcpqOoA7gd+C3Ad++LTnJ+zoE
 ImUsmKynh+ybZigkAi3WLrSMRGOLpsO8BHf35ijrnzSrV+fU1qvkk+D0+1M0ywv20rYk
 jTgfOQVCGa1w2Ivio5x9ix4/KtUhhm/BRha/E4E8CufIIx/t7/f0H4vsqJ7N0gN846uU
 cing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733292740; x=1733897540;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hRrfNkXsQG4m4T/TGI/qrEl6IDV4kVgcyEmS5Vo+nzY=;
 b=XXf56USWq6VdGKz0oc37y0pLll3GUGzKB9thghIke6vtioq9r2EnKH+EbQgPDpeEO7
 13mnKLLGbVt7KpfmXeqtJrNufLnzFyrmP0ei7ZNgTnkksC5QQLXE1RbLd9N1qkfipFI2
 ZYRY+shtk/ihgPw/LkgUjZPorq1olppk/ykNIoRbAXnJCY5UM4RVRPkNY5+Jqz0nY5eo
 wDMmjHM0NHw/xsJOx7VBSZ9TdLYn8mAY2Irzj3DBeoqoKktX6iREWcbFr2OcbJwzYoLA
 kp+jBI6VqS0MbuUIPI4ogHw40iT9j6/yBT1BoocXNoXUyf+W29G9/DUkrXlvAoSWgkvp
 Nb1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOy2Yw5xFIxIeTpbbuFmnVsMQsf9DkYPV/SGmWpDv74gec+NsJ7LumdLpCUhjDVs5ErYJYJo21FNSu@nongnu.org
X-Gm-Message-State: AOJu0YygegeoSI+Wn/9qy8erXpWBR0qhsVJRYy05xCNpYTABrrxqwuvp
 v8uJDTgJd+Nzonq+xweQcss3FDzCOGdYxpZt4/s4wZZlzFisYHamk+5IPqBL7eptWms0TQ37xN5
 +
X-Gm-Gg: ASbGncvdSVDUgupTmdM/4VP1xpqcfRz71N/zNmANNRMugCu4C9PO1YKtMDgEQiWSMIH
 p6MwBynZ620OEQj5chH7fT+H1Zg1wqzHunF1uT9r1pIouVOoPtnMZi0XiPumglmZpb+Nk3egHLt
 d9jYmCp5l3U15yrn+IiUtVCzHUTN+fYDsp7RzNOSq3wzs6H0Uqg2yHXw83AaBsVCNgkBbHFP/EP
 Y+G5L9k03iHJUzh6riNQ1njV+TGhqhFMNHX4+zGXK62Oa2rKb+N3r60GKbyCNm/G7iqvHcMS5Z8
 VfGpzOQqalJYdAQ/QDuZ0dxMqgjhr5zkl5GlYa7LBQ==
X-Google-Smtp-Source: AGHT+IG0fRveaMGELXXNmJi9YGCDxvBrhmFC/7uOg/KZCasObt8GqRwuIndg3Nx60GYYyGb4slSycA==
X-Received: by 2002:a05:600c:3c9e:b0:431:559d:4103 with SMTP id
 5b1f17b1804b1-434d1d7f179mr37387375e9.7.1733292740217; 
 Tue, 03 Dec 2024 22:12:20 -0800 (PST)
Received: from [192.168.69.223] (sml13-h01-176-184-15-95.dsl.sta.abo.bbox.fr.
 [176.184.15.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527255asm12337255e9.8.2024.12.03.22.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 22:12:19 -0800 (PST)
Message-ID: <a9267dc0-06a3-4687-8c68-b561ec6f9455@linaro.org>
Date: Wed, 4 Dec 2024 07:12:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] softfloat: Replace WHICH with RET in parts_pick_nan
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203203949.483774-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 3/12/24 21:39, Richard Henderson wrote:
> Replace the "index" selecting between A and B with a result variable
> of the proper type.  This improves clarity within the function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


