Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E963ECCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 20:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAwGo-0001FB-QD; Mon, 20 Oct 2025 16:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwGl-00019Q-2I
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:14:15 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwGi-0002jG-PQ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:14:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so3589685f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 13:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760991249; x=1761596049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HTlBXxT501vvUXl0VG6ZOeVeFMSbAeDpWnXLAE816iw=;
 b=Qy6xq0+HcuyKZu8n+VJ5QgEDseWuDlNNGoy+osqm5f88W55tWuJzaM06Bd6m4owGuq
 pzD83w3ctkblzFRTc8NHsDxq0M8shiUNL7nfjMfL4nH5I6Sns9HHr5fEmUWYonqcfTUm
 mZDbeZOBKPFZHr44vntleMJWRAI6oWWczADazjg8bNmMTFUEL0Jjt8I337+cAuXmgwcU
 tLzpICPlSboLP9lGef5Oa/m5G2GOwzFu7R0D9mBiPMMzDx2YvLfejWgu8ZautdmaVuJI
 sLrevQcW72JxWv81nnUl1WjfrH4esA5Kza0Ma7pCaVcwM517ePB1/1iX1O/padAOdgYq
 gcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760991249; x=1761596049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HTlBXxT501vvUXl0VG6ZOeVeFMSbAeDpWnXLAE816iw=;
 b=TXiL83KREf6Q0gohiPVmTgMAvtlh4PtmdNcPp4eIKnNM9Af2Idbnp7p8hUyEidc7hg
 4GiBWudFmNsXpEADJnwzcI8F7fkcBOwnBERoSFu3Od3zD7FSFTnHoXk/OXH6N+4YVYfW
 D/PO5+0rwoxf5ZefK5I5oTwkD9ao4SgeJ6BxPPxiNDr4eOCcQVaNlaIU2A914/XuircP
 Db3sdyeF5XI45w/dxxtknL61co3kWzXtKhsffdRI0LshZMtmir4rB7cx3GHPqH7S3lHi
 ZYexTxIKNm2pbhuSOubInuCTutNqe36hfV+B3jmxFBOa5QDeBFXIlsHRhfETm7ZRap9Q
 juCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcRKUwNJTPExzrnO4b8tGLDwxdPVgGWI3E/OkdQTQ1oLs6y0dlYuA76RGQlvUZNwaMDW9BqkBLjujI@nongnu.org
X-Gm-Message-State: AOJu0Yy0mTnTRmmD+7heDeKDp2007WVxGRt3/F5UhIKK82zstUm82PC7
 BJ/coOQ+VmcTiTi2DTtlQTK5aOrJ8z760vyOW5VD0zfZpk+yXM0xFkcWoowQW9yr/Q8=
X-Gm-Gg: ASbGncsFASZGHXwIFtHBvvQV3kqGqJ8+ff5ku5DFjYVtd6XYKqHYdG+57rH7FhGqaGZ
 y4idLwC/kmygkpKgThFxpAYA6ii2LzoFptTmtnS3rjskULyZzuiKT7FbHQacOeuDmRAGimaWMN/
 aZ4rphL+NK+EjLLUE8fHPHU4rj7jrplz9Q9tN0JqzkvmX6ciIbK3tJ/M0jWMamPwoc7rxMAdBrz
 mn+IAH+C05WfDjLW7pGaD+Bi0yORghB4QjhkgSjciPGpGpwNXDRHJJes8HcMvnK2Gufl6vBwH6z
 njeZ4Z/PX4TEcrAyT3UzermQE1WuYxSuTntXquBESOZCYIQ37JeYwBnSSI9/lzrcWKl14BDLZf/
 CJe6ccZopdxoMWoPPRxikEDyWH48O/p0WvsAX3zeEu25oY9p0/9Fu0qL1YhLhWVaPkfyW3Eb5J9
 6080oD0i5q6+LDnJxluqNTyrHwlXsr1P0i/unlF7S/hHq4QxFosZx/KA==
X-Google-Smtp-Source: AGHT+IH1pBCu+tgFq81xuLDN55p4o5PQ3bBlSmKkx/x46aNevlNeNzrUGclWri4jW6CK1uXJnP/9Wg==
X-Received: by 2002:a05:6000:2301:b0:428:3e62:3225 with SMTP id
 ffacd0b85a97d-4283e6236f6mr6420531f8f.60.1760991248866; 
 Mon, 20 Oct 2025 13:14:08 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3acfsm16687432f8f.14.2025.10.20.13.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 13:14:08 -0700 (PDT)
Message-ID: <2cffde5d-e76c-4600-8f79-968581ab050e@linaro.org>
Date: Mon, 20 Oct 2025 22:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/tcg/aarch64: Add test case for SME2 gdbstub
 registers
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
References: <20251017153027.969016-1-peter.maydell@linaro.org>
 <20251017153027.969016-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251017153027.969016-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/10/25 17:30, Peter Maydell wrote:
> Test the SME2 register exposure over gdbstub, in the same way
> we already do for SME.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/tcg/aarch64/Makefile.target      |  9 ++++++-
>   tests/tcg/aarch64/gdbstub/test-sme2.py | 36 ++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/aarch64/gdbstub/test-sme2.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


