Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18EDCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v99Kl-0002H3-D4; Wed, 15 Oct 2025 17:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Kj-0002Gv-W1
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:46:58 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Kh-00066Y-W2
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:46:57 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2909448641eso186355ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760564814; x=1761169614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QjD3Yd/6vCQEwpqN3GL5RgwGi/koBPsvmoacpl/y8OE=;
 b=ePZaPhCTSyfr4Vr27m0uH54vEaSVZHy1bkBylUg+Hf0zW8oBBrJbAj4gIpSeghQMRN
 pxluLlt8HtXGu3D9EZq7MKq78qmrOF6SxEMYCQ08H3eTMbhLt5esxLbjR3PlPL+XvHu9
 BAUEcIjiVzaAHtrBiZW7BJZlsnwtVnAS5uq6Memws2vjKD5acdSwewqhVBn2F/x0j/BH
 1yxHKMtKQsvaQrI8VqC94je3zZh8/ttvuH7n9GjrVeTuzMDZOLc2zU5+SsBEO4vSmr1E
 5ZH/vOmTJo17SMjx6uhpR0yJypmvA4PC5yJwUzH0MpuFIqo6SwRgiCTWFArGO6GcicL+
 x44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760564814; x=1761169614;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QjD3Yd/6vCQEwpqN3GL5RgwGi/koBPsvmoacpl/y8OE=;
 b=od4te0gph1QQfpzZy9xElNFiNyOh6E00IT99laRlJ+nCGBKMZBQJzxifo/BrkKXNeO
 rUPbPVuH4N1QLTykh0mj59W11evmdjs6I1eS0Ty8CfbpRfN9Cn90lxRrIYlXIap//K0v
 iWjHf7bU/qLITGU+EKzXh2qAX2UmbedKpprGVZRjvqX5zlTk3UnVmdC4mhxE6U/2g/VG
 0DJHGi669jgwCuHPBkrhutBIwQ3UPKZtC1sv5JGCYD+zO4l8J3egg3QpF+pXX3jI+hTO
 QoU/vil6HIp07V4AFKMWs9+LRH66mUCcAt3UwkYA1CwrIxuWsOUyE5Ficu+MXTjFlrK1
 R8FQ==
X-Gm-Message-State: AOJu0YwEuR5q1WUuzWnr2T7ZGrLV1271lpIen2xNRhsVyMXiyCsUw64o
 HQqPwGssCAAYhssrIc/UFHKuH5fCrPyylORrpwCCpdVUCGy/HN9sUJJO6a+VndbmLnmC+szvsTL
 Je9gNzgM=
X-Gm-Gg: ASbGncsWmGxVExwv8OQelQWTgnPPJBG5DcYgItsG3552HOt2huZqphM1umnK4HdZ0Bx
 WCmiVznVQeNg9AUjIv8qSyDlrcxIYzbaiJzAe3ngH3KP09ls5rAZQqx2qj+f01BnDsfR0ypuaAz
 gv7qzdwIVDdmsnaeq0/Z0yftNBXNvWq5dSovcFj8pj4BOzvmGs/CdVC6tbycBxyZ+bmc33saSCa
 aszd59gL2BpAOELJuyPNtw4qEgn7gb6ND13MoIsnuUZpr4Etcp+K0HFZlzqcvtnWjlFlFpAMYoc
 EhORKAQYFI1N/hDN9dxkDYTkDJsV3B7u/Zx2HEMpBrUOzWkGTCIc/5jb2jDIyt7CgG6ez1Ki5b+
 9vDDtu/BAU7IUhrg9j+0aYMPGM48Ew0xVYo/qvjDxQ/qpPXRfdMbm1F+y1J1C5QxpML8ayLZ9vk
 QxYG0qgmh2pyHNC7ujlw==
X-Google-Smtp-Source: AGHT+IGoKgpXTG87hf8yask2QZ3B24tmpi9ufVzQiCTP+Cf3lZIY2tx8SEemm/y2xHq0Iu7TgB6Rdw==
X-Received: by 2002:a17:903:1b43:b0:24c:af27:b71 with SMTP id
 d9443c01a7336-29091b7f501mr15708655ad.20.1760564813655; 
 Wed, 15 Oct 2025 14:46:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b978537f3sm3800156a91.2.2025.10.15.14.46.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 14:46:53 -0700 (PDT)
Message-ID: <02201484-702f-4955-8ab1-6f60ecd9c647@linaro.org>
Date: Wed, 15 Oct 2025 14:46:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] target/arm: Allow aarch64=off for TCG
To: qemu-devel@nongnu.org
References: <20251002101648.2455374-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251002101648.2455374-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/2/25 03:16, Peter Maydell wrote:
> Peter Maydell (2):
>    target/arm: Clear AArch64 ID regs from ARMISARegisters if AArch64
>      disabled
>    target/arm: Allow 'aarch64=off' to be set for TCG CPUs

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

