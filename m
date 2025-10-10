Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1502CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GbO-0000NO-J2; Fri, 10 Oct 2025 13:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GbI-0000Lc-In
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:08:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7Gb8-0004I9-BY
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:08:16 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-781010ff051so1677926b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760116081; x=1760720881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tkaUDs4C+T+UDhReZVetVMFEKIMAby4SimPGP/5lavE=;
 b=xdNZ77chn+oJ9bmENzR4tihY9UbF6rrvQShtVUbJWIPl/bhYsjTO8BRST1N/nopcec
 gGYi67ivYrYFSwaNFtgV1O0zXDQ3PsPPTXOouGhsQvCB+4deUwZqyy+EAgk4+Ga8JQ8L
 Xw42ilZYo4+ZujSahpjo/rpxY1Kqf22lnyOF6hqBAaQnUaW4cKFuK2bW7feVLnkijlne
 iVJT9M6rGTuC7Q0J0i44sdCFauNDxhOgWngdHyhDJKOgyyAbsuVwfCv7BCY/+z3YlfQn
 G9eYVgStDbf896/+X+UDmL8OBAIOornztDP9foCBndFdYH41c3+66zgR80iys6GKjFCE
 kULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760116081; x=1760720881;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tkaUDs4C+T+UDhReZVetVMFEKIMAby4SimPGP/5lavE=;
 b=NY06qRZ/s853BikNl2GUKFAx6c8TMLhAypdVomWoXcYUJCr/PdmTqeX4bwOcsknmtK
 Et0tSibNSiDJi73UHD9HDP6ll843YG8aM0tPWzpI1l3M1YBxvpW5DV8ce9p5bmZ6Sbd9
 gV0xoNOewwXgo9qzWkahzmNqEYWsdjgGGSSgKZtdquhX7GqwmbBCx8JjhqCCbSJ2LWoS
 kQJxG2zlx9mucsXOpLOoyPIYEJXJ65GuYJR+1S94kC0MNssBB5BRV0RXedCiaCfno30F
 zQfGnHpff5HkTqPKsHAV/qeaF4k30HA+YW75AfQbSFrc4NPShk9P7P2xYC4f5avultCy
 MZDQ==
X-Gm-Message-State: AOJu0YzpJp0zfkGomq8gS3kryux2ouEddJSN7m1SwUJT2XLtqUvYSNAM
 8GIZi9EODrChdKS+bM+Y9ofK59GDQEG5ct6fuY8DKES9OW1gcG9HRn6jiaH3S1uMrRkZ5aiMRZS
 2yTbxn5w=
X-Gm-Gg: ASbGncv8LLgk2P7Tza5CpuJLglL7OOKPZFhiTc6owUJuu9j56Lq/whAhIAAxRtawVgE
 IHsSK3EuR6UUAgi09lE1m5G74FwNaGh+wgz1hFd24KkA4vPRFGj3HMv7On84bDYo885n7Avdwfq
 QVP/fHkGfY4qzyYi/2C3tJVHAN26HCvfAsXmLRcYIvlyEwl84Rrf9+D2lOBV2/E+2Lus30MFFwC
 SEw93clMr0aiEDg3szKlrbjf+kcJMhg3L78qo2evg94xL1nXPEQ6GRxV/KyVA2rqKFVuAzf2drm
 L80UygJFnjosDHG79IwMQ/RSb6XZc1EFfq7Y7RpWbTA8PhRyr7mqDdK5zDJMVqhgo4ovKhxMz36
 TuCUaDFozG8DHn28v0lUENChsuDMrzgnoQgu5Mlq7kfZ3H55kKA1Kqn5J3VA=
X-Google-Smtp-Source: AGHT+IGaahdXnHbA8/AaenVasqSlDt92KNWOCxBkaRh+WhfMGHjGON/Pai4g3TeyM+V3lbsYBbo4PA==
X-Received: by 2002:a05:6a00:3d54:b0:781:be:277e with SMTP id
 d2e1a72fcca58-7938513618fmr13532725b3a.4.1760116080462; 
 Fri, 10 Oct 2025 10:08:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d09aa20sm3513254b3a.39.2025.10.10.10.08.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:08:00 -0700 (PDT)
Message-ID: <e6a08ddb-12c4-46eb-9815-dc8205fe73d7@linaro.org>
Date: Fri, 10 Oct 2025 10:07:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] target/tricore: Un-inline various helpers
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> Rely on the linker to optimize at linking time.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/translate.c | 274 ++++++++++++++++++-------------------
>   1 file changed, 135 insertions(+), 139 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

