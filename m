Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81120D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 20:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t844R-0008R8-72; Mon, 04 Nov 2024 15:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t844P-0008Qw-UX
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:53:05 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t844M-0003xc-HA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:53:05 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb518014b9so39076611fa.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 12:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730753580; x=1731358380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=maV6uvj9XwFofKSFV3GccSYMu6V3RFhT/3qCFC/m2uM=;
 b=HfIRLpPMcXCi2qxtLi1tyj4yuvehWzRipKSG2uM0et9+MwaqLlBOnBMCMXfUC204oQ
 62+WPCk/wv74PMCuWCN9vTvjeA/qvxd31OBpJ6RUOlqwmSClovENGcLnCkWnyPidyd0v
 dK7Igd33JUbYBR5EnSK/gb06DskouK2kPMCZNQ1DtI+ksPRiQUV3WO9HFqX2Tnejrxcf
 OdpbwUd58wxHnXAVyS9+LVbPtoGLgNIrcxmZqhrZSKIw7b3Ek7zthston+GRXsWJl/p/
 C2ZLh7rRlEuT3spiRl9pwiHUnmsLiL0XeNBJp4HDmhTSkneSPTafrYjQJwHMvBoXRSrA
 nLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730753580; x=1731358380;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=maV6uvj9XwFofKSFV3GccSYMu6V3RFhT/3qCFC/m2uM=;
 b=ROD2AzsWhr67Vh0DF59EOUij8rp3zV7Juz3HjbAO2gP4PWJHyncOSuuR3TOahvkOum
 5nXAS08F6QN4sMSoU48cnMiNF/cqbDk1HI0JApxWzJ2a/7MtN9kyElnF8eqla23tMzbk
 HrrAzWaWVbC6/qdMbkcI+hsDaxysWg/6V7WjMD4b2DtaFDmDMZWO7wJh79PeUxoopsoM
 3zbEqJV6tDwgFHT6H0jM/USJHnZw3QuA7HOcpsKA4x6jlvFX61pWnThPqNMtUa1XgcDb
 +OYJbu3Yg7wjz/L8wqFe4JKtwpFaS6O12RzVrB99e7I1Wb/VDFaWl3g6GAWU0HUC2CeX
 Xjpg==
X-Gm-Message-State: AOJu0YwjjolIbLtY7NZz4UFpf1lsXteiMYrjoLAn9xWV0k8Bqhx3nLaE
 +dGNTKa7iWR4NYptKLpIeyldHf6eDOn/R2VpBXesrNtbqpJ72vlrRbClq7sEvAM=
X-Google-Smtp-Source: AGHT+IEY6KHYZ+UHDyeH0I1wfa2X6/L7zGOounCp0FG8tZPb3yT4CwMNgP39jBjoiEof6i2xVWas6g==
X-Received: by 2002:a05:651c:119b:b0:2f3:f358:8657 with SMTP id
 38308e7fff4ca-2fcbe095cfbmr111670451fa.44.1730753580095; 
 Mon, 04 Nov 2024 12:53:00 -0800 (PST)
Received: from [192.168.21.227] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d698405sm168150435e9.41.2024.11.04.12.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 12:52:59 -0800 (PST)
Message-ID: <03dd21a0-65a7-4b7f-82dd-1717c0041bc9@linaro.org>
Date: Mon, 4 Nov 2024 20:52:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] linux-user: Allow mapping low priority rt signals
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Brian Cain <bcain@quicinc.com>,
 "ltaylorsimpson @ gmail . com" <ltaylorsimpson@gmail.com>
References: <20241029232211.206766-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241029232211.206766-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/29/24 23:17, Ilya Leoshkevich wrote:
> v1: Unfortunately lost.
> 
> v2:https://lore.kernel.org/qemu-devel/20240212205022.242968-1-iii@linux.ibm.com/
> v2 -> v3: Make the mapping configurable (Richard).
> 
> Hi,
> 
> There are apps out there that want to use SIGRTMAX, which linux-user
> currently does not map to a host signal. The reason is that with the
> current approach it's not possible to map all target signals, so it
> was decided to sacrifice the end of the range.
> 
> This series improves the situation by making the mapping configurable.
> Patch 1 is the implementation, patch 2 is a test.
> 
> Best regards,
> Ilya
> 
> Ilya Leoshkevich (2):
>    linux-user: Allow custom rt signal mappings
>    tests/tcg: Add SIGRTMIN/SIGRTMAX test

Thanks, queued.


r~

