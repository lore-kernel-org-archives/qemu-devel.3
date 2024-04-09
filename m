Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBF8C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCYT-0001Lj-R4; Tue, 09 Apr 2024 10:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCYS-0001L4-4I
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:34:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCYP-0002K1-Eg
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:34:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4155819f710so44652825e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712673267; x=1713278067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yM+0/27o2IoHQcBevLZ/8vstUbrIPLtriNpel/hEE7g=;
 b=Z18Fwk0cFOkESsbjk42seGi89sJ4glVMnFwLhDWPmpl53fqewbFloLkysUSGqZM/Tz
 RyYPVrO6O2rTNXqR2bBpP+x3Lvp15HOO0qsHFI/HgYQiXTruN6Kz1HJyplbjOSlS5mMU
 ufKTax6OyQagpdvatp3bJ9MdxhkLjrvWerBh81YwT3eUY2g+sjU+yp+gkDviKXg77CKF
 m27LVq0MlvfqaiwPvP0pv41c1xIyiLkXaUbt8wJfKbPYLu94st2sCNqjHP934JhDj+l5
 nZuurVgyRam0N950XbZRBf99wjNnZY7PG36LStQVPJHRxuA/eA8HlG9jgRZeKC8gRozP
 vDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712673267; x=1713278067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yM+0/27o2IoHQcBevLZ/8vstUbrIPLtriNpel/hEE7g=;
 b=icmx+5Fnk1VGCc+4cSVqJCg5RjWXY9qFEb747mb4B8hh20GOJcqM6lsKeFof1JH9nc
 jCkuVtP4Hk7WkE4NMKzOo3M2R/1mrcJE6oaHbS+So4M1OVFV46fE9Lc4Kuuwu06QYh/6
 zXu0dxoPmv4EZSR1RDzpDU+pwGv1Mno3oHgO5ARnImFZkTo1+hLKDPix+uVSZkeX3XQp
 Jwcx1Ajcv10C7BUcaRXXSmHwNR7iDSP0qq4IZz5e2GcY4et1gxxHkptZEo85O4B2co3M
 Wf/R5rX+/iHjaOeWa/OrluNA2NwPiy9fg2/GDsvls+QglFzL2K4b+16D2r1NWKL+0NTl
 /oSw==
X-Gm-Message-State: AOJu0Yxo6zuRindVPA04POX2Bnt1PWuzesdF2M94FJQsR/PoWbWSi8Yp
 nIOt5ZM87BebMB7jJmPRHoK94LA79dXcmTn2eVadLIf3x1X9GVfJtKUVEf+oU9Hhp3zzaLr60Zp
 9
X-Google-Smtp-Source: AGHT+IGkH2HHaDLXp2PZXpRmx71j4cZc9QEVH88nxpa4dmFj5gxrHDZZdfoJxUNBv21F1uuY/HV1Dw==
X-Received: by 2002:a05:600c:3108:b0:416:4923:1f2d with SMTP id
 g8-20020a05600c310800b0041649231f2dmr7115454wmo.30.1712673267186; 
 Tue, 09 Apr 2024 07:34:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a05600c459200b004161af729f4sm17537443wmo.31.2024.04.09.07.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 07:34:26 -0700 (PDT)
Message-ID: <9a37459f-6d09-4a82-b506-acd574de66cb@linaro.org>
Date: Tue, 9 Apr 2024 16:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2 00/11] hw/net/lan9118: Fix overflow in TX FIFO
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org
References: <20240409133801.23503-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240409133801.23503-1-philmd@linaro.org>
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

On 9/4/24 15:37, Philippe Mathieu-Daudé wrote:
> Fix for https://gitlab.com/qemu-project/qemu/-/issues/2267
> 
> Since v1:
> - Renamed definition as MIL_TXFIFO_SIZE
> - Addressed Peter review comments in patches 1 & 2
>    (add comment, return TXE INT)
> - Trivial patches while digesting Peter's analysis [*]
> 
> More work expected during 9.1.
> 
> [*] https://lore.kernel.org/qemu-devel/CAFEAcA8vvURMn2FaDP9tXtP5eCMs6-XFOCR9ypo=WBH+6g5prw@mail.gmail.com/
> 
> Philippe Mathieu-Daudé (11):
>    hw/net/lan9118: Replace magic '2048' value by MIL_TXFIFO_SIZE
>      definition
>    hw/net/lan9118: Fix overflow in MIL TX FIFO
>    hw/net/lan9118: Remove duplicated assignment

Patches 1 & 2 queued.

