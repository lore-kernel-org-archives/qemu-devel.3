Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CD2D132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wYg-0003MV-Rv; Mon, 04 Nov 2024 07:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7wYd-0003LY-UK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:51:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7wYc-0003ge-FN
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:51:47 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so36802685e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730724703; x=1731329503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GmZU2pEnAcia0FAzIIQMVq4nToWsveKrIXo4CaOxMDo=;
 b=w0I0Ptp+9Ca6L80kXBIYTOLpQ96OFYgoZzfADaYbVEF7raHmOsiGKYRXnTaLu4NbKX
 xZGccayZIAi2urGch201yP6Z4HlKJ4Pi9VS//VdJUNBmAyl/dcy2RyufdUR9j7R7Qcuk
 NYvDr+fhSqUz6ECckWRTkl+cTfQx8pszID5LAFbV9lbkHp3/yoUPlClueeWe561RvxU5
 uQ9Qtvs+5h2dklqyiP+tpT83Cbqtlx9pnfnrvOTE/x9dcVQJ1EYVDB1lMckelfK7yKkk
 HfukRlcKEhqHeuq3srzkKj6FBMnEEKV4J68BHfXk+xY4I+uCJb5/82CIJXHKCfvgE58M
 OTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730724703; x=1731329503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GmZU2pEnAcia0FAzIIQMVq4nToWsveKrIXo4CaOxMDo=;
 b=oXa8i1fP4pu1Z0c7HTHb8zoEgBp+mAehvS8BEjCfIfR/eluEn7lXZSBhs4NLwSVqpG
 WsW/Mjx2Z34262D7aqBqJFnCgHrKZLSek91b+ALV++K1mSNiwmSlv6yA1nc1MzZPpOC4
 N20+07QBoEOl2IRWHiRDUHsGkopC0w68QVs3J8qQjNLLoV770LsF7GBjDXwt8gNtUfX8
 0P/7Z+xSnux4529jFzhncC67G1gS/HxMKiesLScQqUACEaDtObNLqnbKJ3FUyOcnbd5v
 oATTipOD4KQmdsHhxmG7Qrdh5Bhs2n4Hja9QT/16IsSiEbbCC1VLSwAvbMaYg0zs0qZF
 7+GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnoEsASWZYmVHCHm04oDNbBhrMgO2XtH2zeX+elSZuSei7yi44pPmVvSqGHVcRnSKI9EDdDZuivsK7@nongnu.org
X-Gm-Message-State: AOJu0YyHeXwlnoLKpp/yV1ujDv3xzeJDR6QPbCaR8XzIjctgvmzMj0VL
 bunpfeWOnkTpuyCiUURapX7xbdmN4fB3Yh6ng13xDOEQIq0U9EcJ3kp6C9Ovbzg=
X-Google-Smtp-Source: AGHT+IF/uefJAJ1DJ6G0XZcOTlZ+PsIFi7pYavAuC+aOxJVxpi+jmuEyHQTgB4m2fC9EXTKqNdwSIA==
X-Received: by 2002:a05:600c:190f:b0:431:6153:a246 with SMTP id
 5b1f17b1804b1-4327b6fd999mr134105965e9.13.1730724703656; 
 Mon, 04 Nov 2024 04:51:43 -0800 (PST)
Received: from [192.168.21.227] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5bf429sm150089285e9.12.2024.11.04.04.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 04:51:43 -0800 (PST)
Message-ID: <91fbafbd-ba52-4315-b696-9f2c4bcea534@linaro.org>
Date: Mon, 4 Nov 2024 12:51:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Inquiry About PC-Relative Code Generation in QEMU
To: Coekjan Yip <ycoekjan@gmail.com>, qemu-devel@nongnu.org
References: <CA+Oymobc=DOOuy431LJHTq4sOPiLRjpxyTzFp-zRE+NXOCim2g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CA+Oymobc=DOOuy431LJHTq4sOPiLRjpxyTzFp-zRE+NXOCim2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 11/2/24 12:05, Coekjan Yip wrote:
> Dear QEMU Community,
> 
> I hope this message finds you well.
> 
> I recently started studying the QEMU TCG code, and I have noticed that QEMU
> seems to support generating PC-Relative Code (`CF_PCREL`), but this feature
> seems currently enabled only for System Emulation in version 9.1.0, while it
> is not available for User Emulation. Could you please clarify if there are
> specific functionality or performance considerations behind this decision?

User emulation does not have multiple mappings of the same physical page like system mode 
does.  This is because in user emulation we have only one process to emulate.

> Additionally, if this feature were to be enabled for User Emulation, could we
> consider the code generated by QEMU as Position-Independent Code (PIC)?

No.  Treating the guest code as PC as a variable instead of a constant is different from 
generating position independent host code.


r~

