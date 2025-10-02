Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E36CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PZG-0004Dx-FA; Thu, 02 Oct 2025 16:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PZE-000489-B2
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:06:21 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PZ5-0001Tp-BR
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:06:18 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b5515eaefceso1274596a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759435563; x=1760040363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hifOaJhiQuBVjbS3/gvrqw0O7TvLhtj/hJDO8dLekLw=;
 b=XMRakKFRByz4uv99pXGBzPqs5PYaQTnBaHrTO1DJHHbQLt6cn26emZujiXAoY3TM2L
 +LDscFfrRrafTpxF8bSNPpNry02xGANb+BkRwnR9g0+VPC6gnPkRQIYu21Brjwbt8H4E
 di9jJVa7qefOrhfStUtwUvKjR9s4BmoAdsyQGhfZpqhNEmq0Y7yXmIT8j0OOZ0syg3fi
 AkRWFoU6FvE+V0aQcssUap6Cy7IKLUlez/kCd0fMSrLAVrgh2W6elrwsTWsBAx0jfl3O
 kB7YYLl888zppgogtRrV+sPw6r2HnKtShdQA2GhsvrS6l+XJhluQTx2PuS59G6uSKrLS
 qE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435563; x=1760040363;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hifOaJhiQuBVjbS3/gvrqw0O7TvLhtj/hJDO8dLekLw=;
 b=a/h+8Q+zXkPMkDmKBUToBScnA17UHkYZ0nOwAmo8/Z74zEzPrkI/aagGQf2raMFcA6
 neL2AH/GBKuwFnoN1cemyupDepQzg2N+nwqVInpQG3UJRy3X1Dd/U6t+pBDRgTiPc35L
 iK1dl2KWs/cQ6/zMGmmUQGzgaF4SULH2HCutmqOB/ohVFh+QJd4/5ouJDFQ7uue2ukjF
 Ou42ZrNnALFKx+EbDuTrnour84XHvEqdz1qrjUoUjT3zYu73UkjpTynSIVoLsJGI2SKY
 /kPN5bFFQNkushrILGtw5M8drdNWvDl4IMtxFeLtZcc7PIUOYEXiCpwXsHceYc7hE5Zg
 b8rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTUveOWE7tLTSJ3fs4WVrwNBPJfOG1er23K2Wd1KRQiN8Nn19OBxLzWjXZEEA2DQtK6gwMHe1MGZUC@nongnu.org
X-Gm-Message-State: AOJu0Yze5BAXMrJmzbEJLZqrvd1SszMm1af2PxdzBctTR56ReKSvaatz
 FSXMoqEy+OwuHAZwUTF+cOjeve9X71byD0TLSR/Mf8ybRgwinw4B3Zkh2Q+g2xZrIaI=
X-Gm-Gg: ASbGnctwGzL6q2Y3na2QLcBjOmcgvJcfWyAPwf2PLPwmg5Vd3pAHdBlFgtXXONMJnwH
 zO1/TFQwRz6DqqTG23KWUp06637ofecPa/7QrCYeclc90yf0iY9myMicsjCuzbR7iBCY8pRtoEO
 ixlcCMBf8673tZl9/2uimb9/JVKASgaVxCErd++QY3YCE6xUfiYmAVu2KC0A1E/3D/yjsTv3ERo
 oMqDUHDopE0tp7U6TnpykjsqceIRgs28BLyxnj2iS7vvChxR4KPHeK+84TDM7o62yirbFDa+OF1
 stKJxUbS23cD9oKhmknYp9nBneTFAZmhqkIms3hOkMpUsZvQg7Wql66USJsDrMAuy8I8EZt0nP5
 c34r6D/MzgpP7k9/my37bkk53kBoqzhAFqCl4SHaVTV2sihx/+uuXX4YTlbQxb2w=
X-Google-Smtp-Source: AGHT+IF//1JBe3+PYhBSxA5pkfkPAIKNW4LS9Ynu8xru6hNesXOl7FDOu/qi7B8MsN1YNvi0uiic1g==
X-Received: by 2002:a17:902:fc86:b0:24b:182b:7144 with SMTP id
 d9443c01a7336-28e9a5655f4mr5982975ad.7.1759435562756; 
 Thu, 02 Oct 2025 13:06:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5cc6sm29002055ad.111.2025.10.02.13.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:06:02 -0700 (PDT)
Message-ID: <b6851695-fb80-4fba-b4c3-8d5385f46309@linaro.org>
Date: Thu, 2 Oct 2025 13:06:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/33] target/riscv: Fix size of ssp
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-18-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-18-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> As ssp holds a pointer, fix to 64 bits in size and make sure stores from
> TCG use the correct size to avoid problems on big endian hosts.
> 
> Note, the cpu/ssp VMSTATE version is bumped, breaking migration from
> older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h                            |  2 +-
>   target/riscv/machine.c                        |  6 +++---
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc | 18 +++++++++++++-----
>   3 files changed, 17 insertions(+), 9 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


