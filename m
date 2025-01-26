Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4280FC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2Ld-0000AD-TK; Sun, 26 Jan 2025 08:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2LY-0008Vs-6U
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:06:42 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2LU-0001nX-AW
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:06:39 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2165cb60719so61418165ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737896794; x=1738501594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0fMq9EXS+i5I2k7wT8nng/cMlW9V5NAl9kxfbdqWpnI=;
 b=a7OrDau4QnkWSy2mqF+iPK5uBdqm8UXd/hYvUTdnTjgD02n/D0kW+TxQbF3SO/+i5i
 d3b7L+7SdkedkY5Do7J65GNiJ5vqN3BXKDpM/KzgpT4v1gHHTmQ8YyQeYIept3QvCgMQ
 WX3BFHQpE3FS7PFRWQTAZ89yCYmfWNNbR4e5vzD161sDB0RG1Lt6bv7AsySC8gNTn4iL
 7sfxiaS4EsCYco9cvqYf+kqzto5C/mmKYVP+QEyvJ9z5pJj3AcetbsX2wyMNDEt4hx3w
 w22iB0XPwSlP44CJt7jSy8V1GFEl7nR6yGtqAI1ND4K7k8S9NcANz3+HJVJZT0HC8mPN
 CJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737896794; x=1738501594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0fMq9EXS+i5I2k7wT8nng/cMlW9V5NAl9kxfbdqWpnI=;
 b=p4IyBfP9mfmqa8kWnSRooIrdzyHMlWaQYVy2eJ9QbVaW0POz/eWM1wPAJHKQLmiBWi
 QhZmf4sXHkslESagkmmlPY4cN5yPweUlkXwdp9bNmTHivVgRtzjYjG1pI589qyogn5GL
 r2c76034vTXXn5NVVb0Wns0qnEDsOJBLJfu3A76q4BGh5k9HbkO0jRB70T5gqB81AKyF
 v8gqekQsGR7pWmbfw053FngMPGhPTlZfLBj/4MrQpdsZiWzaWqzFR4N72D/ZQqYMm+D9
 4F+12hFfHqAaePDFRPV5NBxRi6os0hnfskZqhogV6VHgmznOmS+yDWXktJhwul+k7iRa
 IUNQ==
X-Gm-Message-State: AOJu0Yx5WPSUz21MswZkq24mb4SCJqixf7TUXReVFARIM46ewxMdQI3p
 tyXWVI4hhIRle6YUne8RS5Gb9OvIn763vNpBaQEvwpbCGe1quwnmCUJgN4xR+IwY2qFTNdtQRRL
 3
X-Gm-Gg: ASbGncupzi5zM29rHQj7nETu8NVbry1/gC3Td1+rUX4sHaQTJYAlmwf72J20vjD7RiK
 wQOfogNJROVOJHbPXFB03FvWyAx43rt5klucknOyib8Bvq+NNbOAD/Pi2wH3GWVOIXtOtIkXrN+
 uewANWPDzdkgjX4T70uLqkI60gnHRPedQK9nr1a+NEsFV9udlP9w1N2/5weV89miYHWO9KSKMMF
 MaeGJvqD7olXDVoa+H3p0Pdm/Dl+kUAP3H1V4pJnupIo9yg6YOalFJMU5YwB01TFtDjPrH0FxVd
 XeMcX8m+aBBb5RjSEmQaeEs=
X-Google-Smtp-Source: AGHT+IGTGq0G4vcURQZAUYE4ABqiht4iiGv4lOt74l6F2s2gsvUPBp9PZgyNe9lVEamPUWC6lq0QwA==
X-Received: by 2002:a17:903:41c3:b0:216:2b14:b625 with SMTP id
 d9443c01a7336-21c35564955mr561150065ad.31.1737896794574; 
 Sun, 26 Jan 2025 05:06:34 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424d642sm45536035ad.216.2025.01.26.05.06.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:06:33 -0800 (PST)
Message-ID: <9559f7ea-8ea9-4c76-a777-9981cfb024c4@linaro.org>
Date: Sun, 26 Jan 2025 05:06:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 57/76] target/arm: Handle FPCR.AH in SVE FABD
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-58-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-58-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> Make the SVE FABD insn honour the FPCR.AH "don't negate the sign
> of a NaN" semantics.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    |  7 +++++++
>   target/arm/tcg/sve_helper.c    | 22 ++++++++++++++++++++++
>   target/arm/tcg/translate-sve.c |  2 +-
>   3 files changed, 30 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

