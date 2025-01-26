Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25551C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcAYi-0006TG-Uw; Sun, 26 Jan 2025 16:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAYb-0006R2-2X
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:52:41 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAYX-0005fA-8D
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:52:40 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2164b662090so72178705ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737928354; x=1738533154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D1GvOfSNAyr8cK3AQFIX2hSLOM56gWAF0kBSxFP8y+c=;
 b=ylyDrZKbBuLFM71b0t3dyZJdekc/X8U3rirzUGKIwl4AlKES47243kl1IVqFheSpaF
 f3BbIFJnLgeYObe/j5b6f4XsBPmfLB03OvyR4/JcYAzJvJpj0c8hthCjx4VztcW7r4z2
 ciIRfehgxFY05MTRSpFdZTOx43eRy/We+DTXLMr9Gh+/Ufs4CvOelDBj1a2ZdilkvIXt
 JDdU2ILCqOQb8Y+Y9loD5Bsph4qRAFf7ZWpNkixVULDWZqUyC92AAXCcOn4Y8h+z6Z90
 /unnpcrcslHmgBriWkTS9R2hjv0DURDgAEev/pbeSs6gLDMjAQLY+czbTrFqFxzvl6OM
 0IOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737928354; x=1738533154;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D1GvOfSNAyr8cK3AQFIX2hSLOM56gWAF0kBSxFP8y+c=;
 b=fo4XH9dZrjDUO+zY1nunrkvnoUKw4JN9oeFMxnieivcM5TfJ3IyFUtDAvxEh52UTSf
 RLtWEHQQe4CLYozrmEELOAvKvaC7RWGPmqRkAiq+d0cMxmfHjBGNPFDtIIWsdYheW7fp
 C08ulhI7mZOMLVI+JEYmtvxAhFKHpf53attUXTcd/Q7K7LUN5+YAXIw2pHMY7ngT8KTK
 Az2wK8j1lS2LjeEK/0WsEv5jBs6TyPEXAC3CGEXa5f1wll03194rt9hX+eJaaE3Q11Hu
 mrw6o3jcy+PIvNOq3fQtsg7j+n7evMdmn9+jz8YmY99JQrBLlJfqwm29EexCOP8fK4ea
 VMkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/YqTl62W8BjJj/gnVcVNa2yEeHck60tYbbbjEpXrcLGa1PMhn2bpSzW7pZpuUo7MPBJEvETuiRpCH@nongnu.org
X-Gm-Message-State: AOJu0YwKTOI7R/2YbLxHSBBCYrzS0G7JSxxAzGWFKnNGPkOx4oIoDVnq
 alf0qNZ6hz6d8vkmJ81X/DAzeVXxzFCFalC8yeEHsJrLziNdsutTu+OWxiMPQP4=
X-Gm-Gg: ASbGnctqF6waDsxht11XtZOSbV6X6Cf31m9eTLcFnvAsXMUbyMyBN1cXN4biZMGyT0K
 YiIYoCuihuHQgc8w543c20Z/nAqEmfCSrFnEST/D1FCg3Es4LACKRjSy5BzdXrVPoYbYJZKkGZP
 zpqks6Zi0R3dH+lnZAuzLMz6wZJL8ORB30HlcYJcI6xbIkN321nDdBb7KRFeTN86qcrc4CK+kIl
 WOkbAw0Fial/KxW4gcwj5sJiTsfkJoekbOufvsXuAQ+f4IT2zqwk6anl8TVKgZClAuBmJWJppWj
 +99/OtyO6VTncn5n9Qy1twgdhBt5PwQSDUH9465st/8vP5I=
X-Google-Smtp-Source: AGHT+IHvdzbNbow+VnF4W/GugwOi8ZAhdlLX2Y2gWnQnK8MRMIr0ocw0xcQE3JrO1NkICGqeGeL9bQ==
X-Received: by 2002:a17:902:ce01:b0:212:63c0:d9e7 with SMTP id
 d9443c01a7336-21c34cc00f8mr568636415ad.0.1737928354675; 
 Sun, 26 Jan 2025 13:52:34 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414ed3bsm50055965ad.193.2025.01.26.13.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:52:34 -0800 (PST)
Message-ID: <45949f2e-4650-4fde-af1a-afb4256ba1de@linaro.org>
Date: Sun, 26 Jan 2025 13:52:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] hw/vfio: Have VFIO_PLATFORM devices inherit from
 DYNAMIC_SYS_BUS_DEVICE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125181343.59151-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/25 10:13, Philippe Mathieu-Daudé wrote:
> Do not explain why VFIO_PLATFORM devices are user_creatable,
> have them inherit TYPE_DYNAMIC_SYS_BUS_DEVICE, to explicit
> they can optionally be plugged on TYPE_PLATFORM_BUS_DEVICE.

to make it explicit that they can be

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


