Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44029E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOx8-000577-3K; Wed, 11 Dec 2024 10:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLOx6-0004xl-5g
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:48:40 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLOx2-0003AY-VD
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:48:38 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-29e5aedbebdso3346477fac.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733932115; x=1734536915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nJjyCd9LNDHGsvmAytswXQ/WT232bNtaFimmBQ3UbjQ=;
 b=ykCNjBLFozbWcaTgQJwN3Y428OPlqwP35XJo0NfefQWSRU0C/nJHSPacBzvE6XDmMz
 bDL4Q3Fncdq0VWHp17RNbG7fPFXH+LhGrwhBfcIv8YNOfopObu9GOBEErhEjt9gTZq1E
 sX9UEFE+y4sWw27dG+5DSfD3Adwoi5GH0fYto2brkvH/2aalHAcgXTFD/48R9cy20255
 g6rX1w5IS4kfkyCvNnrhvvVoowCdV9Ey1+noDubRlmiUn9AcxeZcozdndwyVuJj1zj58
 2KFsw3YEh38wiTvVkQRVND0mi/7vc1QL8pu42arE2fr3B675/P50kSRtEA15fZL/mHAS
 lVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932115; x=1734536915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJjyCd9LNDHGsvmAytswXQ/WT232bNtaFimmBQ3UbjQ=;
 b=M4nwZ4AbMkjnp+ttYNNEvw3UgK23zoyZDVVm+zx5pTMmpKuebkXimlC5sy2RChylOy
 cew+TG2UCCH/nslruc8ETlYUgFnCTsCsZ3tJFSLoTZ6GWp3v2td4m+V2GOAjtczQ4RZ0
 Dn3p3dGjxTnMj8DR7/gqNZDoszUxgV5tivoJi8j/Mm0SSGF4Q9dhxXDiO60SEvjSuzgn
 9Ius+x5hyt/KwkHDZDcdtEgp1cJP8IROV2r3xQCWbr7nPQyc0GTEai0jCQ+SXhERg2I2
 3pXVi815lqJZ3pLRn6aGEXGgNJkIeKOXqglID/IcRwXnvoGk6Ln6fWbaMoQEobrVJgJ7
 dBng==
X-Gm-Message-State: AOJu0Yzw/0bSxaDyQ3YunQ/t+mMYP1hECKqLR5yA8enc6n+oJgduT3LJ
 nf6y1LSzivr/nhoNtHwgjIhwaLEgomeVU6pj51J9uhKu5+t4zC/YTb4xsD3Oeznaxqn+lyzZbBE
 BFGb2hqwo
X-Gm-Gg: ASbGncsPnr4eMMBS3olWJPG1wQpYWJ8ExE4wA0MnXq72dcoyyj/xCKnduJoI1SUhqTW
 dcBXvbR1PrEZ8zTbJy3FPVAJO3bm7qLOEHk5kkS3uKzLiisGnQLS6MBElXitA9I6EvcGLheUnwD
 kz+KKE2t7dzt3SlMeJwpwDxxhhubVtFJtK44hMOVcziTwj9HoWfO15ceMONXybJ40+butzJS7If
 jlG+R426iyXrX0iPWFPPWkn1svfAxQOgI/7n7/G1aEICetmRf6rQmMOExxk4izpfgQvP4E=
X-Google-Smtp-Source: AGHT+IFCXIQ/RqBOUbgL64jfdlsbeqggGMMKUiEFGDmTGHZAgJxqvCsGjehDHgH9R43wnIkuPyRcNg==
X-Received: by 2002:a05:6870:6393:b0:29f:b1d4:7710 with SMTP id
 586e51a60fabf-2a012c700a8mr1705381fac.24.1733932115240; 
 Wed, 11 Dec 2024 07:48:35 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f566e57d9sm3800374fac.16.2024.12.11.07.48.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 07:48:34 -0800 (PST)
Message-ID: <ac709b01-5f90-4c12-9d6f-43a2aaccc2c9@linaro.org>
Date: Wed, 11 Dec 2024 09:48:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] target/arm: Add ARM_CP_ADD_TLBI_NXS type flag for
 NXS insns
To: qemu-devel@nongnu.org
References: <20241211144440.2700268-1-peter.maydell@linaro.org>
 <20241211144440.2700268-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211144440.2700268-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

On 12/11/24 08:44, Peter Maydell wrote:
> All of the TLBI insns with an NXS variant put that variant at the
> same encoding but with a CRn field that is one greater than for the
> original TLBI insn.  To avoid having to define every TLBI insn
> effectively twice, once in the normal way and once in a set of cpreg
> arrays that are only registered when FEAT_XS is present, we define a
> new ARM_CP_ADD_TLB_NXS type flag for cpregs.  When this flag is set
> in a cpreg struct and FEAT_XS is present,
> define_one_arm_cp_reg_with_opaque() will automatically add a second
> cpreg to the hash table for the TLBI NXS insn with:
>   * the crn+1 encoding
>   * an FGT field that indicates that it should honour HCR_EL2.FGTnXS
>   * a name with the "NXS" suffix
> 
> (If there are future TLBI NXS insns that don't use this same
> encoding convention, it is also possible to define them manually.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h |  8 ++++++++
>   target/arm/helper.c | 25 +++++++++++++++++++++++++
>   2 files changed, 33 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

