Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEB3E6FE41
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sme2x-0004QA-3J; Fri, 06 Sep 2024 14:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1sme2r-0004Pb-Km
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:50:57 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1sme2p-0000wZ-4p
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:50:56 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7cd9cfe4748so1978349a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725648653; x=1726253453; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hpK/hu5/ioRA48gY9gIdKGp9GvuMGfz12qv9kb1QCu8=;
 b=jZi3tH7ictj4TDdCsBbA6ud52K6teMIXPR6J1RuTUGydj6CtDL03/pAIHUpk/qp4QV
 mwfwueiycRD/UbSZmvMUKXJpTf4lyCrCJP0f/CZaU0b7v7qNN3Ax8z446qxuh7vxV2PQ
 C36+Cn+jURZI4ThW8uxCJgHgVlH4Yh/u+DXxi3+mT9Y/SY5HYhGnB5nLpKoLQ03bruIf
 whVt1cSA1aF6TSHXoe0C5Bs9OkiZwWKr3//+9AxJA4FsOacNbczrXAB5Q9nWvj/OrrH7
 kZrR0jTNDR30e6EVLq9iavt9lIAj+HrO3XQIF5x6qIU++w8UH0rExVGkHLK8wbVoxSmY
 JRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725648653; x=1726253453;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hpK/hu5/ioRA48gY9gIdKGp9GvuMGfz12qv9kb1QCu8=;
 b=ksY+bUnC0Tuc96mlekeRavXjVf7XAUbpighYy7IhTfF3PXB4xAhKWnWNOiMCCga3+O
 0+BOsRzdKSi1Xv51gACy19B/Awg+uayYrlZyDjqTBoS++kg6beuj5t3V3MU4U7D3ydqn
 aVdXciezZ4MEwCcGXREwXp/q3wklxda5YaxMDcU+A6mX4t5i0+jWqckvFESH46kOCfXZ
 TJYjw3Lcg1R2B5eJfWVaLWkieME8QBwKXeVMNpCU1FH0nUu/pRF9yxLAT+Bwy66xUG5h
 7Qnx6WZXEmhaQn7VTZ3SdaCi0dmr0nwc9pQqZXKTnS845n0P9FGcDX7ypptmaaZRCcLJ
 WuVA==
X-Gm-Message-State: AOJu0YyzSxW6ro1pxXQqkbitMrCP+nRblSIeXFNVLAiBH839n9PmaaRs
 zcgVXs23l9MuQ022aTvaNGFcI9Ei3dPVyyCwQE6DfXCGz1vCiYymP14hvw==
X-Google-Smtp-Source: AGHT+IEe+/91avYw9d2C+EbUMc0xYb8Pa2WE4lw3VIYOaoDRZnT32NYY5uUZIz4S0Zkbj3roax7Wjg==
X-Received: by 2002:a05:6a20:2d06:b0:1c4:6a86:e40d with SMTP id
 adf61e73a8af0-1cf1d1b2da9mr4260912637.38.1725648653416; 
 Fri, 06 Sep 2024 11:50:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718d9261dbasm1426709b3a.163.2024.09.06.11.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 11:50:52 -0700 (PDT)
Date: Fri, 6 Sep 2024 11:50:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 2/5] hw/sensor/tmp105: Use registerfields API
Message-ID: <1d351efc-9134-474e-9d7a-e53af51dec01@roeck-us.net>
References: <20240906154911.86803-1-philmd@linaro.org>
 <20240906154911.86803-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240906154911.86803-3-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Sep 06, 2024 at 05:49:08PM +0200, Philippe Mathieu-Daudé wrote:
> To improve readability, use the registerfields API.
> Define the register bits with FIELD(), and use the
> FIELD_EX8() and FIELD_DP8() macros. Remove the
> abbreviations in comments.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

