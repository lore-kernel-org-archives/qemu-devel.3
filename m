Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D6DC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 04:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBHn-0001qB-BR; Wed, 29 May 2024 00:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBHl-0001pg-9c
 for qemu-devel@nongnu.org; Wed, 29 May 2024 00:51:37 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBHj-0001ai-LI
 for qemu-devel@nongnu.org; Wed, 29 May 2024 00:51:37 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-354fb2d9026so1526964f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716958292; x=1717563092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u1nYdfp4fuN4YG4QO33DKDAeJvAL793XESNugrAHys8=;
 b=MJKOo5J8NaFhskeQ11eHOcP6eYOiE1cUQh4aOrXlHPhnodB8oBdnK30tB5UUYU9kdP
 BZZQLiOGnN7CA4eivRHk5No6DtFm+XK/mlkHpTGsAv2QZvaxvSPNyDlYRmAAIRfM9tJQ
 /MkGSLqT8tSJDkIX1NNV/Dq99mUEhoWwYMxBxO7lGNU0ikCm103/66u1r5xR4K5A3szN
 fUhFeXhcSYzTf2e2f9R3oCm9b0EH6cCItK1fggMCV2mU765prKA3pHi+8Bb1A7lpBYuV
 8TK9+8Y4jcVzFd/ix2+HivtF1V07NkXYJCC/jK4HSL/SrvErno6GGAGVGpcx+zb/W12p
 lD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716958292; x=1717563092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u1nYdfp4fuN4YG4QO33DKDAeJvAL793XESNugrAHys8=;
 b=LxsGWkeXmvgWjesKnlEXBGLy4cPliRs9S1ZYDdtksloN87DN7Z2mRsPt8erMSCmg+8
 v4REnZd1xlvH2IkemqwOskIFp7qZJKlYDq61tdNAwOIUoUWMc5sDQM6eE3cdg5UUB8PY
 sPY7hK4N8DRwHInOS4eAzzmDaf1zUfaE9MJyCZQgx2X4+MeNcc3VMshNMZioHmOsKqDy
 p4neOO+fuf5co51UeDOiyRt1qCWNrXlMSe84+wMDyTIln7FGLKKLVGvIrOK8l0zQKL+H
 GX06JYRGSbcAiPBShIXqES8EyHdbGSG09paKGpHoTzThTfq8GC2V0BAQ8e7AKwC0I3qv
 0NMA==
X-Gm-Message-State: AOJu0Yyey1XJTl3aITRyhLCun89j7dxrUiW4QupJabDvbSVSFf9dn9ff
 ydI25K/X0CNFOAiAh2jSLPhMw3Qjhp2nsn7slGbGWEe2pqL0nkBlkroV7nE5S/fMLQI2t6Q52WS
 N
X-Google-Smtp-Source: AGHT+IGT3NnjnHd9X0oouBZX33hk8pFTpyFyM+V1o+EOw+IGtUHkSyasUXrVcfyfdl3dvCH6VgD+zg==
X-Received: by 2002:adf:e648:0:b0:357:40e8:e574 with SMTP id
 ffacd0b85a97d-35740e8e60amr7150400f8f.37.1716958292268; 
 Tue, 28 May 2024 21:51:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c93b6d4sm677740766b.88.2024.05.28.21.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 21:51:31 -0700 (PDT)
Message-ID: <506f4ebe-50de-433b-8d06-9d2ceddde600@linaro.org>
Date: Wed, 29 May 2024 06:51:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] hw/xen: Simplify legacy backends handling
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240510104908.76908-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240510104908.76908-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

ping?

On 10/5/24 12:49, Philippe Mathieu-Daudé wrote:
> Respin of Paolo's Xen patches from
> https://lore.kernel.org/qemu-devel/20240509170044.190795-1-pbonzini@redhat.com/
> rebased on one of my cleanup branches making backend
> structures const. Treat xenfb as other backends.
> 
> Paolo Bonzini (2):
>    hw/xen: initialize legacy backends from xen_bus_init()
>    hw/xen: register legacy backends via xen_backend_init
> 
> Philippe Mathieu-Daudé (5):
>    hw/xen: Remove declarations left over in 'xen-legacy-backend.h'
>    hw/xen: Constify XenLegacyDevice::XenDevOps
>    hw/xen: Constify xenstore_be::XenDevOps
>    hw/xen: Make XenDevOps structures const
>    hw/xen: Register framebuffer backend via xen_backend_init()
> 
>   include/hw/xen/xen-legacy-backend.h | 15 +--------------
>   include/hw/xen/xen_pvdev.h          |  3 +--
>   hw/9pfs/xen-9p-backend.c            |  8 +++++++-
>   hw/display/xenfb.c                  | 15 +++++++++++++--
>   hw/i386/pc.c                        |  1 -
>   hw/usb/xen-usb.c                    | 14 ++++----------
>   hw/xen/xen-bus.c                    |  4 ++++
>   hw/xen/xen-hvm-common.c             |  2 --
>   hw/xen/xen-legacy-backend.c         | 24 ++++--------------------
>   hw/xenpv/xen_machine_pv.c           |  7 +------
>   10 files changed, 35 insertions(+), 58 deletions(-)
> 


