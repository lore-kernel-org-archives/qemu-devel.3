Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA81C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 16:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWI6p-0007zd-RO; Tue, 23 Jul 2024 12:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWI6X-0007nS-AG
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:11:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWI6V-0004Z0-Bc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:11:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42793fc0a6dso41138385e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721751062; x=1722355862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OteKzwqLKkOLffUUjRoUJNuuM6gG72vsNnpLPqKxmbI=;
 b=HODP++lJiFITqExvVmxU8qaen+SGVtmKrlpWnOdX0W9Hn8/DFIB8O5LlxWAI8nh7Nc
 uywkQHUiQcmUlQSeImSpNa+/+ekIiAnymMNivyNYdOEyz6dRc45zll+Hv8hc3QXSxzMN
 NV6IlrarnGbE91UYo+oNQm3t1QHZwYsapMAd5CJNO94WYpwuwbSjG+Pg5JK33tahehrf
 RMPthr06tPHzIJU3oN8mNMTjJILfa1klRPc/4BKsKzcu1BatDpMY3EiBDNTpHTYxiBKK
 XnwCIX7Lj23HhtyYgXMv8muboHqRR248naaU6J9CxB0KL4CkcAoBp4zX6TXO+cIVAWmg
 Q+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721751062; x=1722355862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OteKzwqLKkOLffUUjRoUJNuuM6gG72vsNnpLPqKxmbI=;
 b=aPtWw/hmVJ4XI2qSdBkhOm4vtSv3eeqr3/fMzqD5Gco1+9S8qqONXpMRmCqlt0HVrr
 U5aI+OVsAq5Ps6z+0yyjRDR8SnP1ywvp8X5TAfZXKvCrscSs2ARzMvVnjzmfKUm2rbgm
 UxdAiYYkaBrodRUx+6ad5aVoS9Pi7LZ6Fn86WW0+IF09f0YrO5kEbKLz1/ogOZBREDiJ
 MbS6V5UiXQ2YImK960dHa1dSNkk23eH/DS0E1CoYap44BZQpZ6rlIIiIG9sse2Tu8Tw0
 6CT0wi6XFsS7Qrn1sKYuFCmfA4up3Tk58sbMN154skBgXW6ObjzwsZdCGutIx6KBjKGi
 QBMg==
X-Gm-Message-State: AOJu0YyEGSdy7QnoLoLxkULIg/2M0Y3gXbEZ7AP8Lw62uC2fXewTB1gL
 0L1G3hazvXerysK4VSIdlQHC3Nu3w4bX2xcve9RD5lHiWckY/28Kr7+BEseqDZMaeHpPuEO7B+Y
 tCjk=
X-Google-Smtp-Source: AGHT+IFsmc/AdE1cdw6StpkbYJwy10Gc0PkwGlinRKSLE1UDFEA/CYF/9dVSiSVFQMXTh6ovYYidIA==
X-Received: by 2002:a05:600c:198f:b0:426:54c9:dfed with SMTP id
 5b1f17b1804b1-427ed059c10mr23280815e9.28.1721751061787; 
 Tue, 23 Jul 2024 09:11:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684839sm11981124f8f.22.2024.07.23.09.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 09:11:01 -0700 (PDT)
Message-ID: <299aaf66-64a3-49b0-9b31-97513e0b6f4c@linaro.org>
Date: Tue, 23 Jul 2024 18:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/intc/loongson_ipi: Fixes for qemu-stable
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240723111405.14208-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723111405.14208-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 23/7/24 13:14, Philippe Mathieu-Daudé wrote:
> - Fix endianness
> - Fix resource leak
> 
> Bibo Mao (1):
>    hw/intc/loongson_ipi: Access memory in little endian
> 
> Philippe Mathieu-Daudé (1):
>    hw/intc/loongson_ipi: Fix resource leak

Series queued, thanks.


