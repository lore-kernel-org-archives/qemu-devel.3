Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EC6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 11:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgN3N-0003Oe-Ba; Tue, 20 Aug 2024 07:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgN3K-0003Nx-Ob
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:29:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgN3E-0005Ql-Ej
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:29:30 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso4120138b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 04:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724153362; x=1724758162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2/ndX5KUV6nAEvaky/KhNlrabhUU80diJYJEx4STgBI=;
 b=cEgsDrlHBUgTG1H7C7VUV2MgZyTD/XXvmkoKh67VvsYXFHNxvuZ+1c1QAmmQhh5Bes
 W6PbBbA6eNCWuASGEn4zlamGEdG4XZk04F+aLZAbJsXQwyd4tehp8d/HAiSVzGkJr3XY
 xJacvBXVPMrMp2dPdZfLV2d1O8aoJob8TuYo1NpfVgIRairDgjdmpXAg3pU+lNVEWo5v
 odZIkdmIa7QiBlqRxO1acJRip8W65r+EA0L88lpX80ITfYnO2AlHL+/QeN+4xcgJgWFC
 9pEGttciiK68T3Coc5z+nlTyYE/H8HQah2xkk7ePcuO5Q5x/3qDAZFuiouh8Y5bM2sXE
 nY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724153362; x=1724758162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2/ndX5KUV6nAEvaky/KhNlrabhUU80diJYJEx4STgBI=;
 b=TFYL7QP8NvhEKNPahdkUxvKmJSwNnNRphP+6ScIB0q1jtLX/o7MDo/SLY8HEwaAwsT
 aTfNDOb5i5vQNra5TR2S2yaRs5I0+BwsViT6YBNGjBwG0f2NuZhWpY0BqyjB0VqtV5SQ
 3T+9dVECTyP8dqJ6y1tikat4ILMYHsYDtTvulcY5xalm1AvGd/5Pry1LrC6bdApc2n2o
 fQAbE/Jmp5Dy+XXQGjof0+ItTGCCbPAMuB5+sO5lTBfnUy/uctlP59N/Vf+01Kwzi5K8
 6Gq/YlFjqmcrPaYtWynhEWp2TMcbzNan0Y8XGLJsdzx2Uem8hm/SrxIwCxpkIV8I0kX3
 rYDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf0ulVQ1w8CKFAS//c8mcYTz9xpeEVqacNdrQAUrPjjjRubV0hxbsDFKHDAhfVgjJyrZZOOMKQ+mt+@nongnu.org
X-Gm-Message-State: AOJu0Yziqe2gPw28jlcp/4iObFoqoEMFP0XwlpW8h0Rzf5qky+qZOoCA
 wK+eCJVCr9aQnR28fEUURvNT0ta12gZ5Rr92uXMJzJbXSD2Kw21Ra0ZjOk1zMAQ=
X-Google-Smtp-Source: AGHT+IFKrfWWX/Q6rxNCob/FRG0NcnL3IUE2X8TER+7GpgG9Jz2xmxBuBL1ar3ydofctPVgV1O+UDQ==
X-Received: by 2002:a05:6a20:6a20:b0:1c6:9968:f4f4 with SMTP id
 adf61e73a8af0-1cac700e6abmr4110123637.11.1724153362085; 
 Tue, 20 Aug 2024 04:29:22 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127add43dcsm8050883b3a.28.2024.08.20.04.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 04:29:21 -0700 (PDT)
Message-ID: <72df354c-eea6-49a6-befc-9749aa58b811@linaro.org>
Date: Tue, 20 Aug 2024 21:29:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for-9.1 0/1] hw/nvme late fix
To: Klaus Jensen <its@irrelevant.dk>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, qemu-security@nongnu.org,
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20240820044505.84005-3-its@irrelevant.dk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240820044505.84005-3-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 8/20/24 14:45, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> The following changes since commit 48e4ba59a3756aad743982da16bf9b5120d91a0c:
> 
>    Merge tag 'pull-riscv-to-apply-20240819-1' ofhttps://github.com/alistair23/qemu into staging (2024-08-19 14:55:23 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request
> 
> for you to fetch changes up to 6a22121c4f25b181e99479f65958ecde65da1c92:
> 
>    hw/nvme: fix leak of uninitialized memory in io_mgmt_recv (2024-08-20 06:16:48 +0200)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

