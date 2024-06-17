Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08200C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 17:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGQ5-0004HG-El; Mon, 17 Jun 2024 13:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJGQ3-0004Fv-EI
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:45:27 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJGQ1-00015H-Bg
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:45:27 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-6819d785528so3338235a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718646324; x=1719251124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TZycXPIJeATqTBwgqDIlWYvGVpaGv3tewO1hIk0yg6M=;
 b=cwKNTbrOhN5ydejZYywHFbeFPqdG4k5dOs+3OqeQsGvkGPKa4KWNtAT79uwRsHTL0B
 FPFCaKudDv74dC/D6kf8JsObJISrIwhSO4u6QrM+s86ja25rbjjfMMIcP6hOs4G61YfM
 HsyQyQrtErq1ofBxT446OTTz31pfEqEbRyAuua7+qw28jdKHq3WqB2PqRQVzb46HFc2i
 5JgWdkMZC5t4LBTo30DdQ2LKmwo3qBMpLevOmTRNaHqCM8y8R9/+hvvbZrgWSW5Ica9m
 RL2lMMvaB8BnEa4ArgGIQ1AzWu/wkZJR8+8eVJQp2W2two2h3HO+vbe/EkPKuRCnfO5N
 eGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718646324; x=1719251124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TZycXPIJeATqTBwgqDIlWYvGVpaGv3tewO1hIk0yg6M=;
 b=WMyvt4skVkDrx08cgO9+xqvvylB41SD+XlADojPMpCEpq0ok5bx4IEypTa1Zxp4+nU
 FAKpftxkmQQH+mUEJhdsKqWAJRf4lDDMMaqPSwj46Nqy1SiZUV1Qj5B/hngIaw3jn1xh
 v8dGrf798aELCr9pYZETp0ZPZ2oVb44aodKOKsr/t849D1e12oHSzAb6UwhDF6odCYca
 Cm4eE37ekLLS9Q1gyLCvdA0XWTM2U2M3YrAzj+xbJhmKcHsEO0bLeUkXEyGEWcoSMOYv
 CGAVU6XL2GZ2JqdoHOpocKk23Xpw34MjEe1A02JLu95M22nl5cjNm+H+guTxEPPVCxl/
 FNnw==
X-Gm-Message-State: AOJu0YxsRt3Avn0HYmGqCkUVWTaoZY89t12DpE2ikWvvXTH7GHYeNzoE
 FjTpKHOR0XNwpboLiDiE0S5imgVeZT9+zXaFAevIJzwb4sKHNa15jo1MaykSgSQ=
X-Google-Smtp-Source: AGHT+IGyLPcmSTMUDaE+Im/mrZrYIu53/NPjCo2Oj+ro668O+0Ir9c0fsPVXc2bbCZ+nMChR3sIl2Q==
X-Received: by 2002:a17:902:d511:b0:1f4:5c81:ba97 with SMTP id
 d9443c01a7336-1f8625c1461mr115677685ad.9.1718646323703; 
 Mon, 17 Jun 2024 10:45:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f06123sm81925855ad.209.2024.06.17.10.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 10:45:23 -0700 (PDT)
Message-ID: <76ba68c3-64ae-43dd-bed6-8312232b221c@linaro.org>
Date: Mon, 17 Jun 2024 10:45:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/ppc: Move VSX vector with length storage
 access insns to decodetree.
To: Chinmay Rath <rathc@linux.vnet.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240613093318.314913-1-rathc@linux.ibm.com>
 <20240613093318.314913-3-rathc@linux.ibm.com>
 <6638b813-f4ef-4587-b94f-3c24d90ca09e@linaro.org>
 <358b393d-7c43-4a28-b8da-8221df5031a5@linux.vnet.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <358b393d-7c43-4a28-b8da-8221df5031a5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/17/24 03:40, Chinmay Rath wrote:
> static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
> {
>      TCGv EA;
>      if (!ra) {
>          return tcg_constant_tl(0);
>      }
>      if (NARROW_MODE(ctx)) {
>          EA = tcg_temp_new();
>          tcg_gen_ext32u_tl(EA, cpu_gpr[ra]);
>      } else {
>          return cpu_gpr[ra];
>      }
>      return EA;
> }
> 
>> If you need to modify the resulting EA, then you also need to make a copy for 0.
>>
> Hey, didn't properly get what you meant here.
> Did you mean : Since I'm using a tcg_constant for 0, if the EA is to be modified later, 
> this constant would be an issue, in which case, I should make a copy for it ??

Yes.

> Considering that, there are no tcg level modifications with this EA.

Ok, good.


> However, the 
> underlying helper method, which considers this EA as a target_ulong type does modify it, 
> which I don't think should be an issue.

Correct, that's fine.


r~


