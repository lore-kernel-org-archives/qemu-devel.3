Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D007FCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gG2-0000Bx-Ex; Tue, 14 Oct 2025 10:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8gG0-0000BO-G9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:44:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8gFy-0001bF-CQ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:44:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7835321bc98so5219139b3a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760453042; x=1761057842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bYZJtNgCjcmjfsgMyLVOO+zkzevH8rM6wiw8zu6DUC0=;
 b=UzbflceqNF9hpkICJXiMiVEDpOxMUXbosjulFX7k1Ufg2ZXxmB4VnKCm4KKIqx0N1X
 s8Vj+o0l+GCrvMJqN7+k5y1d+goNuD867Kky6eFrQa8koLF4PHj9DdtVQuCBjXvpOdXE
 BeV8RYbHKkJSDzkWccdP9LuL21Y8rnR/WYAfRXj84Vf0fOBxFrepQU7nJJVuFNJ1Byp4
 vzoOc0W37og0KCEtFhpj3otmZaDUrxPNU6K5lZL+m9z9pE6WnZpWko5nPBlYEiZwnWYq
 jPQqudjRt5zRW9fdCp4FC22JURwcm1mkvIuq4xGxV1lEzYsMZ2kpWHFBusU7uvy174Ro
 P4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760453042; x=1761057842;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bYZJtNgCjcmjfsgMyLVOO+zkzevH8rM6wiw8zu6DUC0=;
 b=vR0I9v5l3yB6ij95Y5K0Qo6X1WDd3UqSrPxFdGLi5gfKG4V2YOnWKmmxhfSVvqG+jU
 NpOJL+mrm4zEyT8BA958D526hL2B8uR8BvcQTT6RlUy3an4UhKznp3rCPg7Byiv6o5q7
 1/mzZKtYDO/ZTGkxGM9h7S7St0mCjQx54WLXrQOkHpeHa46Wx+eEgESPmB3sgcx6EB4l
 hftrviSWwN4PcxYWWunbrTQMXkCIWHyclA4HJxIyRcIao75zia/373XSeJg8mk1OkomQ
 fEeFdTpx3Px2++ogpwgsWku9HH+t28F4+3eODeTx4EO2CljoQUNiVEj7AmMFT1bGZjxl
 3zIA==
X-Gm-Message-State: AOJu0Yy4w9/VJKFuqaHI1ToStSVAvbRa+jj1nhEiwN1/5Z2PEGptsF+b
 R1AiO9qL7y54dX6XSJRtRTpd+KUpl52WDO6CNKfvyRBRckmDZIHoqe+2TQhHwGmrPeFbvAObMGt
 +EnDD9aU=
X-Gm-Gg: ASbGnctAuU/4YbUkLCMplKJw3B7NW6LiMoVJ++vXMB1NFMei2RUHjFlLq7/XZBSdjZt
 WQ48Xgzzsy45PsOmVfwpM9ON1HZGg2b6CPDb3qafhG23C0W9bYbsbnEIZ4po75rnkqWa3f6DBA0
 uDX3HqYt1aOcjb7hGFao/Jw6xXOUmtFN+Du7ZiaKqKV2G80CyyFtZtTeVAuasH0mVutICPgqqfC
 SAffKTUowOkzKtQcHmdHtjTWwefrTHiDLdIK7n3UHGMMBCJA/5i8wZ2fqYc1uI/c/QcRsAMdNS0
 jWoRoQgE27HhQ37JdiEhGlhFtkPi8btDTllUFE5qI8JwQ4zSxqOLakrcjGB9XDJzIctG9OtjQ78
 nndCP2D766CrPZ/ynuVfVdUzIQZ5X7GuZcZjj3QGlYgPbsRMUiZyzD6ubz0p7lMsnHkIWOA==
X-Google-Smtp-Source: AGHT+IH+xOsS/zU1/mrda3BhPPNrn7RuxQiTsdH7wy9qkkiCerwd22MnuVbOp/Ew3dq9jZCIy5vq7A==
X-Received: by 2002:a05:6300:40d:b0:32d:b925:74ea with SMTP id
 adf61e73a8af0-32db9258839mr19630613637.11.1760453041601; 
 Tue, 14 Oct 2025 07:44:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678d821159sm12444726a12.0.2025.10.14.07.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 07:44:01 -0700 (PDT)
Message-ID: <4a90e2a9-8acb-4ed0-a950-4cdb1ea69187@linaro.org>
Date: Tue, 14 Oct 2025 07:43:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/arm: Implement MAIR2_ELx and AMAIR2_ELx
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20251010201917.685716-1-richard.henderson@linaro.org>
 <20251010201917.685716-3-richard.henderson@linaro.org>
 <CAFEAcA8_cotLWg6GTc+TFRJCPwVDG1743TRcXmH+LLJPEpSbRg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8_cotLWg6GTc+TFRJCPwVDG1743TRcXmH+LLJPEpSbRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 10/13/25 06:55, Peter Maydell wrote:
> On Fri, 10 Oct 2025 at 21:20, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Enable the SCR.AIEn bit in scr_write, and test it in aien_access.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpregs.h |  2 ++
>>   target/arm/cpu.h    |  5 +++-
>>   target/arm/helper.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 68 insertions(+), 1 deletion(-)
> 
> I think we also need to set SCR_AIEN in arm_emulate_firmware_reset()
> for the "have_el3" case.
> 
> otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Oops, yes.

r~

