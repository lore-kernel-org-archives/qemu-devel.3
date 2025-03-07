Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C73C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfk3-0002W4-Gy; Fri, 07 Mar 2025 17:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfju-0002VP-I0
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:00:18 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfjs-0002Ev-IN
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:00:18 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so1248635f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384815; x=1741989615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qohjcLyRp8CE1FBzcnS2AFILKhiwJRQYqsBxNZqzUno=;
 b=b3ziNquqYvhaCKDUP/IfI2slglGQ2guARbFTh3ZeuThCbY2xz+FloxRozcnXm5+0pf
 T58Ks1HP8YwNVSRtsCszMRKNEViHb7tRh7jzqfTMBe3O4Pjqh4Z1cOmhhU9fOylKXqO1
 83iVzmA/hB9qBae/t0c4shvBZ7fXUb35FyHlSIYeIFLutFd/LPJp74BlR1aypwpCVAon
 jFoY5ajE7KIo8W3tgMA5UIP5OK/SdDINPMhtgKurmjq1LExVpua7aCNG4CAPHsCGgPfF
 2I86SnXVa1fmeQbn8Ht41hn/h88mrottbfdNqLUw4+WYLraEotJ6U0xM3X8t+epz0y5O
 iDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384815; x=1741989615;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qohjcLyRp8CE1FBzcnS2AFILKhiwJRQYqsBxNZqzUno=;
 b=U0Uxx/I5gWCWNYJP45RLb8B6mBg4xDJWJht3grKb4cVtXfQwQJB6vg9k2Pof4YzHap
 RUeE9YGkYW0t7sKZyHMWQvIeYubbf7L+0wj2pwYtWiBuYp7R1sGOAUcgTWzbfdzcq0WD
 PhBehxMLSr88LyYDeqWMQy/s6oIkSntBT3T+4pHQTTxbx7mpPFEOL21bXAWE/40t5r4x
 5k2IspoPxPAojzJ4MKQ+CaEsxZAA57kAqgplFqqvNw2lLXV9LZk8RrmBXzGhhfs05oUI
 fbC50w7FVkcsHE5iSVTIh5ov79jvxxdcH6RQ7o/A+y7e/QoISFEI9vsBLxncIWxnsFp/
 SbDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkNDzGXncOXXa5WiPa9cB/H30+ZBmtlmpyeakZp/ZrArKKGjMEgCir2Q52cYaODEnXTHMaOw6YelHw@nongnu.org
X-Gm-Message-State: AOJu0YwAs6GwS2zyc+BFIrW6JAOhkU/UmxMyId81tlgjVJMWC9mx7gbf
 3+CjywyXxUyTkyimpujUxlDwxa9pvA0Mpmbb99JVtwgFBzro2nDVuBX+efgUSF1pS+Cez0C6//4
 ZyMQ=
X-Gm-Gg: ASbGnct0BvXbb1G8xJHc3n8/4yCyyfK4n4Q7mMDU233xwiC53wo4lGE/hECeANHOCZD
 UN/A1ACxmBIAn1Zbd0KQ7bSVtlnD77IJWHf2uh+5oDhObhIBdzerCDzXgvBBGx0kQQsoGBI0tZZ
 CFdvmvczYlyxk5trEHubuelDJnbBA65VzgsOBDsrQ2JmXjP0Nxpt0/vu7pMBJVCn3tWqm1aAIa3
 p6NrDWaLgldInNtd97frzwaJPtsdseo3TNIt2IXhAbJ0OXFzxsXc7FT8NzzcrKLRAdjlHI+iUqX
 mzyajAVbwnB63ID2aHhnGbIvTRzU41bgauCQeh7go0o8PKcEIyK756JD9JywBuKk9ztAIPWBZbk
 0Io99+9R8gwJk
X-Google-Smtp-Source: AGHT+IHu9RXbF5B8JNC0fLndc6bj2lnjkB0XbUjRxfKDtWu3gz0pBDLir/w6c7OJghVW4fFrDwxUDg==
X-Received: by 2002:a05:6000:1f82:b0:391:5f:fa3d with SMTP id
 ffacd0b85a97d-39132d81a74mr3844320f8f.31.1741384815044; 
 Fri, 07 Mar 2025 14:00:15 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c015c2csm6506985f8f.49.2025.03.07.14.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 14:00:13 -0800 (PST)
Message-ID: <0107b62e-48a5-4424-b238-9bada9e49217@linaro.org>
Date: Fri, 7 Mar 2025 23:00:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] include/exec: Split out helper-getpc.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307185645.970034-16-richard.henderson@linaro.org>
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

On 7/3/25 19:56, Richard Henderson wrote:
> Split out GETPC and GETPC_ADJ to a target-independent header.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h     | 19 +------------------
>   include/exec/helper-getpc.h | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 32 insertions(+), 18 deletions(-)
>   create mode 100644 include/exec/helper-getpc.h

Preferably include/accel/tcg/getpc.h or similar, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


