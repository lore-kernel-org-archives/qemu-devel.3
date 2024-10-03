Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC47CF34B8
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 15:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swO9e-0006Sd-MU; Thu, 03 Oct 2024 11:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9c-0006S7-TF
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:54:12 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9b-0003TL-95
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:54:12 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37ccd81de57so719426f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970850; x=1728575650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c843wxbyeWr0PK2rolzVgkj/k6k9WwlEcUAwJhAwqOU=;
 b=OJ7/k6hvgLqUetPaVkKpaHYw/9GYgSheNXgzVyN9Q7061Shfz4VhG0YL4n4KjRsZm7
 FdNfSaFy+TNxIwWvT9lLSjltac2e2jrAYt8/qQ0Ky50gZ3rC2aGI5h68bP/xsYgG24XJ
 muFEJP36i/IFChkBdmifY2f/TsZ8Z+A4H1z3FVi/dt4Xwzo3v1zIpTc61RXNhJKd0nd1
 RQ7Ti1ZYbwk5yaxisyLciylPaXWfxHqCifhj9NZqqzIsKnPo6oLtIGxVSLfziCKrte43
 q2s1rxq/RG5Pq5GnMT+na2pQp+vPyEMBODu2ab0rDqgu7f6tlKc4BkHHLOMAv8MR2cEZ
 Zkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970850; x=1728575650;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c843wxbyeWr0PK2rolzVgkj/k6k9WwlEcUAwJhAwqOU=;
 b=tXkO9frKHEQfz21IN6CXlxC9OlQssYh2dUhuA8w4FTuQc/ksgRbtPWAiLlqdDJBMEf
 AZ/L79p+QEIPiLN6TU0o+i503micrf7i0hEVlatBicAcxyIxSV9xYdrVufvMbxe7wra3
 Thq1cT1Q+xGUWAUWD+Prxg++Z4irT57jIqgff88oOy2H1UlAhCuOZw2Qo7nsUHAw+mIR
 fYrmOTgucCFhzm/j2ETpBlL5FgFFlhXL9tHJn8hDawl/eiEVGyGB+f+w4zo2Je17TlN1
 yNihqi5gDuo0AIBnDWq5iyPQCKD5/BInZFBbCP4X4xXGq3fSs7lbmkcbwxGYST9DdUP4
 RlOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfKHUErXh63R0jOv9lHgalvUggGdlZFFamjHFsAVwCTVbeESfuqCcrvUFiNRGwHuhwVNx8REYw+NQn@nongnu.org
X-Gm-Message-State: AOJu0Yx0VzHbdYf9d9ONGyz3Oeu6IUKv4VfOiUU7N/IGvnXo1AlZWvQL
 QnIlnOeRIqUIX4nkdVz91+EM+9MIvFco0o5XvHxtPPBKt21K9uaWeuKp7plIbkY=
X-Google-Smtp-Source: AGHT+IE49337/xHzf68CI50Z42jC2EYmbqZAgQbOYARtkwz3B/d5jG0NETrr1+bRMHv8u15T15GR9A==
X-Received: by 2002:adf:e605:0:b0:374:bf6b:101c with SMTP id
 ffacd0b85a97d-37d049dda11mr2602162f8f.7.1727970849708; 
 Thu, 03 Oct 2024 08:54:09 -0700 (PDT)
Received: from [192.168.13.175] (49.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.49]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082425f5sm1544489f8f.50.2024.10.03.08.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 08:54:09 -0700 (PDT)
Message-ID: <947533e7-ddc4-4242-887b-3d6bde2c7a84@linaro.org>
Date: Thu, 3 Oct 2024 17:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] testing: bump mips64el cross to bookworm and fix
 package list
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241002080333.127172-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241002080333.127172-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 2/10/24 10:03, Thomas Huth wrote:
> From: Alex Bennée <alex.bennee@linaro.org>
> 
> The mips64el cross setup is very broken for bullseye which has now
> entered LTS support so is unlikely to be fixed. While we still can't
> build the container with all packages for bookworm due to a single
> missing dependency that will hopefully get fixed in due course. For
> the sake of keeping the CI green we disable the problematic packages
> via the lcitool's mappings.yml file.
> 
> See also: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1081535
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> [thuth: Disable the problematic packages via lcitool's mappings.yml]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v5: Adjust the patch subject
> 
>   .../dockerfiles/debian-mips64el-cross.docker  | 18 +++----------
>   tests/lcitool/mappings.yml                    | 26 +++++++++++++++++++
>   tests/lcitool/refresh                         |  2 +-
>   3 files changed, 31 insertions(+), 15 deletions(-)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


