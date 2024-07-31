Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42217C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 20:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGJu-0000Vr-Me; Wed, 31 Jul 2024 16:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGJs-0000Ub-V5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 16:53:13 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGJr-00068d-GG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 16:53:12 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7a8a4f21aeso821085166b.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722459189; x=1723063989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aBxInppUm/FGthJbf4q4COzdXSGp2c8oasf4X3ybBUk=;
 b=r3wg4JNjVyrITRFmHREq1WpvdC+XdLf+FUiYg17LoUs+J+UfklSqdnr8c3YPNAGqwy
 M9x+wlqxeHlhiTDDXyRJw16AdnkfmbgKq0zAlXSCc2wKaLCdick/GbWnYIAcdFyRT05v
 p613RmPqKtYslm+C/M7WYCry/gnH143i0KuaXbXQlXUVQwtanP/mUUXXZRur/nX5mOM9
 Lj0U6Dz83kTrG6xk+qyddRj9qGhjito/iuPwx6KdQjomANHRNm5/AUntVGIttTMi5WaE
 oAS30FCGFG1YH9Mhcj1eawmUnVJAfmfN0ff7y2HUGqt7XA+e/Z8iiZVNpBLEYeDy4o0I
 Tpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722459189; x=1723063989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aBxInppUm/FGthJbf4q4COzdXSGp2c8oasf4X3ybBUk=;
 b=crokToMs8vGu3ZKPex6EpqaKTeiioIdMIbSHfbB16R3q8I8Esec9H69f5r4NmVrwu5
 WJJOKzJcpX63rtAs+zRJ3WhjrPDvHt8Oe5BmVVn5ESiNPVuWhL56Mb0/ZADu//Qppgg+
 g1eYMQVUZbUIUvejTTJpAvm8wKUUYyKkdj2jO5Ka2QKG8e9ozsBXLsvjZJS07OGhinIv
 RPZC6TTHwDH9bqCbFqEnZRKt0ZxpsIEKGshBJ1AV2GDvEBG3S6eRhIHMbjyWZYSkOoSh
 puZKEJCtQVXNLukovyQ94HWAyguD5hysgYv92GQ1oJzQjePQyTWbxPxyugN3taYBIsz5
 O2GA==
X-Gm-Message-State: AOJu0Yy/1lwfhJ64gjV0kW7q5X1kaFQjtACcuCtCsrNh/1sHKDliIysH
 2R1abqoMU6IbA4SJkslQtXkpWPUYAoAulya4a9zSJx9Imv/I87jmtDvMv4Wmlws=
X-Google-Smtp-Source: AGHT+IEzCHucRisdpg9VSZDtAcPnyLfDI+4umqPopeTXzirpLHoo41dyUfeC7ftK/ZVcIKQiJPmFlg==
X-Received: by 2002:a17:907:9725:b0:a7a:bece:6223 with SMTP id
 a640c23a62f3a-a7daf2d1cc0mr25419666b.6.1722459188927; 
 Wed, 31 Jul 2024 13:53:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab22ff1sm807841066b.35.2024.07.31.13.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 13:53:08 -0700 (PDT)
Message-ID: <36ef1074-686e-45cd-afa3-5e3be806633f@linaro.org>
Date: Wed, 31 Jul 2024 22:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user/main: Allow setting tb-size
To: Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240731144532.5997-1-iii@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731144532.5997-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 31/7/24 16:45, Ilya Leoshkevich wrote:
> While qemu-system can set tb-size using -accel tcg,tb-size=n, there
> is no similar knob for qemu-bsd-user. Add one in a way similar to how
> one-insn-per-tb is already handled.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   bsd-user/main.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


