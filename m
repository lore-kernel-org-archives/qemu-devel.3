Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1798D60CF8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 23:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDBFK-0001KP-LP; Mon, 18 Nov 2024 18:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDBFH-0001KE-FF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 18:33:27 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDBFE-00081J-GG
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 18:33:26 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2124a86f4cbso2464235ad.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 15:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731972800; x=1732577600; darn=nongnu.org;
 h=content-transfer-encoding:subject:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS7HjFWZNhhpKT97e3Jejn9fQk4qYBkmw7CwLMajyZU=;
 b=WGQuIllldfi/Z5zH0ZRDtemF48KDlupuhcSittx4P4c8eA7L4a4KKmVexeU3xPtQFE
 N9q67ix1ymSgz+z3tPHUmG9JlQJ47SQncJKXKWBh6KxFMQt0xVpRot04TS6vLqiNVwQL
 UJACDt9WEJ6UBTWT+IrQlrdK+gFAM2gFHOsEct0nTrSDzUJwAg/PbPCY4o70yMgj+l7x
 fpoa+YEe7KR8ab1U1r2eFdmBl1m1vR482KPHolMpOTtc7xTQM6XsflYer/T4gU9vuzUr
 iYOnVkIbbiAPc99jctMhCYkY9O9asIUkxtu+LkcYzQC5bcv0oaM1/rWg3F2TNqhso990
 TsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731972800; x=1732577600;
 h=content-transfer-encoding:subject:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eS7HjFWZNhhpKT97e3Jejn9fQk4qYBkmw7CwLMajyZU=;
 b=s4XNuvJ0S2KlJDpCZyqphPEL4cby9T4SX1zTzD9B98SWC1d+H/V87NpoCUaMn9H7id
 Xhzo981zhcCJt9pO9qnUee3hgw8549JgQ1sksNcIr4WuGE4pCZR0Cag0tXFGSIY60pTO
 9S7gPwsRpAuVJ9ABns2CpvO1LbMiWss2eHIYsu/38ZzHaajAVqhrxzLyyGaMhdZZVHrG
 9Dwlu8uUS1b5OGUw3CrNeOtEWSc/E178xlzO3AbY357sY/hnlGyLHiKPVE0Gc1jdoReN
 +czy9wh+ovZCz3NgUEQ2JW60bJB/NmveOUIrkOuPpL3NuWyYYGY7P0m2aBPWMq+ob/hl
 rPpw==
X-Gm-Message-State: AOJu0Yy8/4WymnBRYawD047GtlyJhALOguWDtfy/oJPJZykUNj3I05Eq
 u+NnQO+vP5xxB3oMy8ing1EdhM+SMKfAsHXWtDhMGTtHIF/8Nfl0waM0bO+jBJc2CZZ5FbLZ2Cp
 zcz6jeg==
X-Google-Smtp-Source: AGHT+IGPuSlO/XLOB7zbPK+9uhvJiM2NKbmXxVla/J7dPzyy6ib1F56PB+wo9/aRVJQin7yS05DA9Q==
X-Received: by 2002:a17:903:41d2:b0:20b:cae5:dec4 with SMTP id
 d9443c01a7336-211d0d7ddd6mr215729085ad.24.1731972799746; 
 Mon, 18 Nov 2024 15:33:19 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21253619d4bsm743745ad.173.2024.11.18.15.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 15:33:19 -0800 (PST)
Message-ID: <51442716-467b-46c2-b2f7-8ffdeeca320e@linaro.org>
Date: Mon, 18 Nov 2024 15:33:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Status of some Arm features
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Hello,

I'm currently reviewing the QEMU Arm documentation, and I have a 
question about the status of following features:

8.0:
- FEAT_DoubleLock, Double Lock
8.2:
- FEAT_ASMv8p2, Armv8.2 changes to the A64 ISA (bfc and rev64 instructions)
8.4:
- FEAT_CNTSC, Generic Counter Scaling (hw/timer/sse-counter.c)

 From what I see, it seems like they are already implemented in QEMU. Is 
that correct?

Thanks,
Pierrick

