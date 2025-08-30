Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64146CA0FFD
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 21:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usTYT-000622-Pl; Sat, 30 Aug 2025 17:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTYO-00060Y-R5
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 17:56:11 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTYN-0007Th-8c
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 17:56:08 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-327f8726b95so1476333a91.0
 for <qemu-devel@nongnu.org>; Sat, 30 Aug 2025 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756590965; x=1757195765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OQfeGhTmdAS2M0cvthjMRUlBBQ81tXodoVIHuUXSGrs=;
 b=vZOLMC/iwmumHrjjKg2AlVz3spII5hqWCYlh66MlHtDoHbPqYQRUpkM7XJEFPJydpZ
 EbT+FfDpSR58LmaTbxAOWJ7hC60tb63W+YU5Cei9NxpNzk1GYKbo2QM9FBOAUo0C+d83
 /12lff+MNxvOFM18j6FMdI9485Ovt4mojEn3WsLhPoN7L4wpItz3kR+y5dGV7ioXsaaA
 d58LOPpd4Ar4++Dtp50ZZVuLJCnsEbfTPSMKvoCHzXph0d6FxD+MXWPNjGuSV05FK+t2
 LP8+DWlkIECiTWYwLCLDeoQgc3xsk3q7z0oJFV6HaloEN0lfJCX36zc5cpOtDi6B+ZDE
 Ou/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756590965; x=1757195765;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OQfeGhTmdAS2M0cvthjMRUlBBQ81tXodoVIHuUXSGrs=;
 b=SNkb/9SJargszriqP5SpneCJnavHuXg2Lya5yK3YPXqlmMcQeH9daSd3cHXaQnvzt6
 gq3Ysw/6E2s4GOf+90x8dy4zyq+5nOYWO8otZY6cW6cC1YbcpHxtmjWyNrezzWGVKIlM
 ZrkqErgPZF9OXyobCAYwiuHZtXQdioMoDj7usEkeZR8ihS/eoRsA1AWFL1wfxkuFazeG
 szm0mVzLBUWjXRGB6oKBs8aIsixLsnzjjWroPGqbclZeh0fuEy1oak1tF6sHH1oEaMR/
 ZtLVMuc6tL5sfLA2n22QqDgDpkpRVqCMksggRM9GigPVbIMdPL2Ru5C15/mRKAgQKihQ
 G2eA==
X-Gm-Message-State: AOJu0YzTM056TVKhnWtovZb4lCecwk2ZsTH0cZc8i3QB/hqyntxdyJ+I
 iJgsV8SPHNVnmbrOXeetG7F8FQ895A/F53AqvOcZ1CNNcGhOocE6azFzGyW36+eHYkitNR/HaNc
 IZa0+lEM=
X-Gm-Gg: ASbGncs3LBumt8+eHBdAaGbRq2iUe3Zrxit1Ha2t4ueHRDxy/C7XUcpzQpgsda3otAa
 PDO7M5cQ0thcjvFe5HHmavRYW2VE/pqZoGVrSpt2JJBuN76S2xXNO2LYXx0wW1986bkh0827f+q
 TiP0bbYUVs0444nntPFFBxi0vVA9+08oofnhgT1PZw4Y4eDu8+Gn/+KreP/6egQ8uZwCZQQ6lte
 CLe3gXSj47TUJFPAke1R2mdjwq8L564dfalaZgiQeIm79ZMksw6Y3Git/vBklmqWgbfdOu0x3zd
 jmAcfEfaXcURGDlj3AxZPtYXIfCqaNLzPZ1i0+FpzAQibjrVQ9b3/NiHVtORpPE5Yast9+zGfsB
 I7wIpcXovQiGPVsbRjrJyOi5YoSmVCuwZ/aeO2t9foZOvPVXImcVCb5O7pDYsR5gDvXnQr9zDil
 3wEMZMaso=
X-Google-Smtp-Source: AGHT+IFyOyGQ3kjos1rQjkv+Ox+jQ9NmDScMhgrexx1vAWfhCqqPTUTwslFqrLADlmpD2ONGBQsHpw==
X-Received: by 2002:a17:90b:2692:b0:327:2589:7d4d with SMTP id
 98e67ed59e1d1-3280d364babmr5042504a91.15.1756590965592; 
 Sat, 30 Aug 2025 14:56:05 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32745900a2dsm7126209a91.4.2025.08.30.14.56.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Aug 2025 14:56:05 -0700 (PDT)
Message-ID: <3e2296d4-6119-4ea9-9826-74dc2fc05f3d@linaro.org>
Date: Sun, 31 Aug 2025 07:56:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] include: define constant for early constructor
 priority
To: qemu-devel@nongnu.org
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-2-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829180354.2922145-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 8/30/25 04:03, Daniel P. Berrangé wrote:
> Functions marked with __attribute__((__constructor__)) will be
> invoked in linker order. In theory this is well defined, but
> in practice, it is hard to determine what this order will be
> with the layers of indirection through meson, ninja and the
> static libraries QEMU builds.
> 
> Notably, the order currently appears different between Linux
> and Windows (as tested with Wine on Linux). This can cause
> problems when certain QEMU constructors have a dependancy on
> other QEMU constructors.
> 
> To address this define a QEMU_CONSTRUCTOR_EARLY constant which
> provides a priority value that will run before other default
> constructors. This is to be used for QEMU constructors that
> are themselves self-contained, but may be relied upon by other
> constructors.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   include/qemu/compiler.h | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

