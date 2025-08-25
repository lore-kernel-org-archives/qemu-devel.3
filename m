Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37764CA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 02:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqN1P-0003bJ-V9; Sun, 24 Aug 2025 22:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqN1O-0003aj-0J
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 22:33:22 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqN1M-0005XK-1V
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 22:33:21 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-32597b88e1bso561199a91.1
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 19:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756089197; x=1756693997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFLLYA7jB/OtwpjaFUwXQKBNSNhhCIigv5UNwjXCKhc=;
 b=y6RzdZ//n9RuC014guLWln0qJF66DtCHiHeLqzO9sFhcv+Q9FBLqu6sUC19CfSWFsi
 i6JgYGdywQkUQgOG0QF2OEHXchF8Uygw9j25VjUvZZD0p3s/YRLDENePlvkkbyD6hvNp
 e2TaKYneieAG0O4JvL8ln3u6uQEaS/xFHFYrzZx8uGERHmD7hd4iWtxfctqqjBQDhGOi
 MiVVQx1Zl0N4ETHogOc6cPQEr7N0ssme+Xk1t7ewxbQIuv0mm1UspuM6CPsrmQ1sYFRJ
 l5+UZJG2B86kWOg+N8BR+w7+CvQxBJTDv4Seof49XaQ0l3v2+ypbkQhi5QZn4vhjtr2f
 I0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756089197; x=1756693997;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qFLLYA7jB/OtwpjaFUwXQKBNSNhhCIigv5UNwjXCKhc=;
 b=NV9mXs3BT+Y/l3kY6yJ9iPQa27IGY5ptxv1egibpRY988yG2BxHW8LO037QF2mPZ0f
 nViLe2HZSmUzNwde3gtHhLWeOl7P+kU7GuGZbiIPw/gC4RGRGU0vRJpu+iPkor9ZQNoM
 j0uzfretXEWF147XVn+EZe9W0hq+9prCcrRyJDmQMWC1U6G3a2PyLqPtE5UJkq1WAzhL
 A62/nSyVkxzbEFcHoe++DQkkNFhep5KZ7UiU6vUxFyg4LIiKnTcKjX2n0VG+bdo8f7bg
 lW/ToaZ9QzACZgToKCOA9MiW8+O703MsdEIkrDbSuNz45WXlKYrOzpwopzjoAkRABzh/
 uhWA==
X-Gm-Message-State: AOJu0YwddWk8NZeBbyRG6EyuCNuHdD9vAGIUHvYtQMFwznzQ7u6Vm3+F
 8fqfZyDlAZ3hi/CGO65bclXENd50YF95HjPjAg4cXNB84Tddmfrlt83CS8ztgPG6O+DorQW1x22
 yNboRKQY=
X-Gm-Gg: ASbGncvEy8DnEqHsEBw10hRW32tWFXOyvXtYIEdXaymdeZDglX78RXBZlfAAiTqDU+v
 kYIO4My+1kzitwg6xHzHW5fKJ8h2QLDJwGWcnFlwPp04sB/R8Y5i7I0eiYfLqBBNmQkoYe6j0UN
 MjLiwS6TE89YsawhqETFYj7NIM48njd8FQ1dYHYpNkGZ2bRE5z4sFuUE0GF/29Xr32BTSjGUNtM
 vVRHBb8JrQh7vZHjPe+c5Axf+kpoSB9CRBVXTqPlK/qWVZXJ4ZEV1XCzNfh4DqM1x+W9eaMyiW1
 hKZT1Jo3uj/fMToGuuPnG3j1RQtSoGe3g8+giOAwvs2vbDMMS2fgBit+N9HA8HBuvqJ6u4EKNI/
 r5dryA4c/oizGpqpim1wBJFGamY68WxmKyO58dAhDkYbwCPTDi7Awj+Ck3/yZDYJLvdnURmrDXm
 47GrMT/UnK2idq7f0i54CsLMhtnIMVlEiIt/Z14NRhRAQDuUwJ6qssoPbsTnwvBJtb
X-Google-Smtp-Source: AGHT+IHZDghcFWgOadEkvK67aLv0/hg4NhUoLJqkAiT3rG9BpPrrAE0dzrkZ1K9YWtqw8ulsGKIY+w==
X-Received: by 2002:a17:90b:564f:b0:325:211b:da6e with SMTP id
 98e67ed59e1d1-325211bdcb3mr13131554a91.32.1756089197457; 
 Sun, 24 Aug 2025 19:33:17 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:2b1d:8711:2597:136f?
 (19r3hzjj0vw81f3fs315.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:2b1d:8711:2597:136f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3254aa63deasm5585619a91.22.2025.08.24.19.33.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Aug 2025 19:33:17 -0700 (PDT)
Message-ID: <cf308f63-541e-4c54-b31f-9e9d6aa55254@linaro.org>
Date: Mon, 25 Aug 2025 12:33:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] target/i386: Save/restore the nested flag of an
 exception
To: qemu-devel@nongnu.org
References: <20250723182211.1299776-1-xin@zytor.com>
 <aKmTtaOlPewxllUZ@intel.com> <211ff764-e24f-4afb-81ff-fe0d9a78324e@zytor.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <211ff764-e24f-4afb-81ff-fe0d9a78324e@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 8/25/25 12:03, Xin Li wrote:
> On 8/23/2025 3:11 AM, Zhao Liu wrote:
>> +static const VMStateDescription vmstate_exceprtion_nested = {

Typo exception.


r~

