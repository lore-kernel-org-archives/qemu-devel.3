Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C26C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thRTj-000211-7P; Mon, 10 Feb 2025 05:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRTh-00020F-BP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:57:25 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRTf-0007aP-SI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:57:25 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43946b5920cso3566415e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739185042; x=1739789842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gez+urdnjqBbe2XALvqKAWztHG+Ra3lu/GrLaAkRIJE=;
 b=NalAwgDDZt/bsE4b9xO+ok/vlSUuLpUimiZfWfmoMSaUst3fJFZNM9Kz+PMznX0AMJ
 6yZN6n17sOLIW5llsrYrJr4mddoSx3NdXxTPohCxRGP7NSCFEPnCHLJJNdIfGnEJXDIH
 u5MijSdnjOs/G8U7x5oXBlzY2sIOmTut5USG8f9zeYqJLUqElhCOs0rFcfwxIruM7XkU
 n8UIt75L5acW6iSL4DxGiMcpPXlIPdv01ZDZhq9J1Uwi0kCOzvsdhM5AEBRGGdeJI88E
 z/vMzjKVNybLFvE4P8rHUI74znq04FB/eQ4Yj02lUajfemJh7OO3q0+cpk5f0R/q9rvd
 7xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739185042; x=1739789842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gez+urdnjqBbe2XALvqKAWztHG+Ra3lu/GrLaAkRIJE=;
 b=CvCu8BPhbuMP/npH4R1Nh8U0S0OZn+daVipO4bjT9nwbVUehUXx4kG/GFJBvx2biN/
 qobUCw/Ze2aFxy2g5EMOtodvm5Xh4wJ9rrMhOvXQKWVeN5A25XAsSc3Sl8ifiWVLStnW
 hmG/cb2J80wc6q1C2Z4XCQmBGnKSMsVYhD7hA40W9VZnCgsV66Q0Ril7EB+Fbwm3SI07
 9JscFtxyRcOuizn+llOiMc3jpnJ0gbPVZJg0/hgBei0Y8XPpKTSu52kP8vvwOaW7h2BW
 Pbw0QsE4DpJBlh/1yKuN2pcE1zCTo2yCH8atLt6e1r9bM+J1tUzBv/paLPXDWxCV2pyO
 /GOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMrqIOA8nfW6KBVxcdn1mOQA/eOcAJ7AJ5Yc/VOkJTetBCYgpLHEV09ofgYdT9nk1L1BNiYzolNKCz@nongnu.org
X-Gm-Message-State: AOJu0Yxz854Zrm5LN2KpJ26bNlUzhvFkDt4p+q8ELvuOWJR3rsN8LU6y
 gAGASuwKeZDRMxduSYVB8Az4WdjMMxdaLhEapHLGp11j7TfYS0zp7iHJ7i1Yq39N0icsQgBPCVD
 84YU=
X-Gm-Gg: ASbGncuwva1hraxLfrSC7Phke1bH+IBZN1M1EAhGRswqdsckzzxglSpoP3cpgwNQikB
 fU1WTrGXFljV2/m5hxBwVHrb48q5PlmVjK8fvkpTDjYaFFz2ot21OrWdcvAfYM7Jpy+pZ7aQQ3D
 v4k2bNy9wQdBUvYn8pNJX2DOqkYBMNCO1nwp8L8hOipyb5Rl3ACyOK9rNP2dNnjVOkzrcklpNte
 YfjML8ToMfMq/slYg7Vc3Vx6225sAoMqPvqfCrLE32PQaBviSqd6AOXn4htwUHvSAABU5OmOnPW
 7X4ivS4zKx+aiuF8x0L1vUAlYSNfZFHDFchEr814TokJNGiFEZLznnRLu77WhyY+
X-Google-Smtp-Source: AGHT+IEeqFsDeik1Qhg2Q1aI3NWDX2dspcsBRf3rCWfdwQhMY0pIMeO1hhjgkiwPKClUh5G0K96Pkg==
X-Received: by 2002:a5d:6486:0:b0:38d:d9bd:18b6 with SMTP id
 ffacd0b85a97d-38dd9bd1a2dmr3815513f8f.28.1739185042145; 
 Mon, 10 Feb 2025 02:57:22 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcf35b15bsm8398922f8f.64.2025.02.10.02.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 02:57:21 -0800 (PST)
Message-ID: <ac64b0ad-d442-4283-92c0-423800d8d804@linaro.org>
Date: Mon, 10 Feb 2025 11:57:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] monitor/hmp-cmds.c: Clean up hmp_dumpdtb printf
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo
 <arikalo@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jia Liu <proljc@gmail.com>
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
 <20250206151214.2947842-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206151214.2947842-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 6/2/25 16:12, Peter Maydell wrote:
> In hmp_dumpdtb(), we print a message when the command succeeds.  This
> message is missing the trailing \n, so the HMP command prompt is
> printed immediately after it.  We also weren't capitalizing 'DTB', or
> quoting the filename in the message.  Fix these nits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   monitor/hmp-cmds.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


