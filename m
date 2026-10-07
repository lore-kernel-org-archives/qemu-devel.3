Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA33CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEXhX-0001Ti-TY; Wed, 07 Oct 2026 15:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1xEXhV-0001Su-Ga
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:53:17 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1xEXhT-0000Jd-Jp
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:53:17 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c2e43f3d1fdso613329266b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791402793; x=1792007593; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dHBoIl2qsTA+KFaXWpxd3euMilk3kcU5oT7j4rYpI4M=;
 b=aAUOJQXaxiFFI9HTrJlWtVmtlr6w8WLJeU6cZoBPb6frEoru5r4G4UW71wcY3b/r9Y
 4wVvnsUIuHxeWHK37OpJrrvnfT4dcRQfGIhPZLU2BvS+ptH+k+yM2vgCGBnMepO1BzCq
 pkhI6cxspeJ5QLQqdbg5VB6nmgheroTQxaaheGFZcXkaWqiCL5f/9r0Q/A2/SZrCtrLh
 ZjQzsKp9JscTLYFds87b+w40As6DLOJcnYb4GlC2sLMsr1V2lcYPQKidQ1xKUKJuLOWD
 4O1ycQKqpG/sRLXrbqRHavF/BbKDxSJeB56Tk+IsQ8AHHLkDsQnsqCiY5Mj8QJI12TMR
 bnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791402793; x=1792007593;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dHBoIl2qsTA+KFaXWpxd3euMilk3kcU5oT7j4rYpI4M=;
 b=CpFiGTvy4elGnQf3Ti2T6yxH7dzNELbM95KKtFMwTEfIYsLqt26XO9tgtwswelKfx3
 7tvBR/hXO9iujb8tWZtUJI3/mvcqvvT0/+FhSffGkL4kDbXbx5yoCGPSPN0zSnRTFfrr
 glpTgAFnTIc56IZX5CQHRmb7uMDK51hKyGjhgaWUblmxD9pEO2omXjPRE3Rp1ltA/yDy
 H7sgHfjS2yDZ0PxprkoGxT92joA0HTA+AAEYuacaZUiHPpToLu05jQZ1ZhBxMQ/sZkPd
 4yBvYfF31Y04HBR7MT8Lo2ZtI2wDSJkIFzl/SKlr3Hae5s4JYpSRfRO+tVqLS8H+987f
 cW2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLTG20tpLlJ3P1nrXrFI4+r9bLZd8ATYhIEsx1fDtIdyiXaQF3yaI6paVhAQKmo7xnl4UCIBABSqO5@nongnu.org
X-Gm-Message-State: AFuF++mKNPbGH+6DHAbXsirRWIhBCEz8GaGvveoQjP/I+6L9pjT5FzMU
 aEnOG7noKBgzjaUnSZ14VACwXD0pcXfXs94dmBkeVtx+fTpUQ3pfu0Cr
X-Gm-Gg: AYBFou0jJq2aDffOzQlgGGvkXiwIUig88bmd9Rb/bG1nntB54I5l8PcbmREi462Tg8X
 buthTsm7hP279GzOcnyBZACJ6rHYlICT5CRVwVPRsH5XW3DEpsoQz99iracsFOIs1VqBTgBBZhR
 U+axLVX3S9mWBnvx4FjCX0ogsXiltww9W2L4mGP4nh9zKxNjmhtxgCc0Mr7jxlQn2XPKMKgHEJD
 V+rBnUdPm+1iJqsQMxIcw1Y4Q287N3xuKPss0XqBZKjGEhsWNO2wHu4D1iL+M0ZI81nwU4GHewc
 Guc6c9qHnbWmmQQr3XvBPXJ4CMLYQnu7dU6q4lVlITJLnUdDJGGmYaSFHGzkg+LSqTKRNEsa/wi
 u0n8HzRw6FbFQyNA9dSgh59Sc0pwyVeIhpi58q2UsjMc3af35BaEmWFXP8JGBMd3RWIwvK8tC0I
 1tnO3AHyhopo+9iaaXQUB340M58okjmsQHMf+ohw8eN/bUbSoRPsGQAMeInMkCGcn4WDkqfgyv+
 bzFZVx9S9Rba49qSFLgVqF9fArXZd9bA/A8AbM=
X-Received: by 2002:a17:907:7206:b0:c21:9870:c4f7 with SMTP id
 a640c23a62f3a-c317bdbdd3cmr324645866b.20.1791402793065; 
 Wed, 07 Oct 2026 12:53:13 -0700 (PDT)
Received: from [192.168.1.130] (93-143-204-29.adsl.net.t-com.hr.
 [93.143.204.29]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c317c2fd783sm142872066b.57.2026.10.07.12.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 12:53:12 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
X-Google-Original-From: Ruslan Ruslichenko <ruslichenkor@gmail.com>
Message-ID: <8c3cff58-b6eb-4c2e-ac26-bfb4673662a9@gmail.com>
Date: Wed, 7 Oct 2026 21:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community Call 13/10 agenda items?
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Chris Wedgwood <cw@f00f.org>, dbarboza@qti.qualcomm.com,
 Demi Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, utsingh@redhat.com,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>,
 Ruslan Ruslichenko <ruslichenko.r@gmail.com>, Frederic.Konrad@amd.com,
 Luc.Michel@amd.com, edgar.iglesias@amd.com, francisco.iglesias@amd.com,
 Julianus Larson <julianus.larson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, =?UTF-8?Q?Lukas_J=C3=BCnger?=
 <lukas@jngr.org>, artem_mygaiev@epam.com
References: <87fqyh79ty.fsf@draig.linaro.org>
Content-Language: en-US
In-Reply-To: <87fqyh79ty.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

+Artem_Mygaiev@epam.com

Thanks, we will join the discussion on Tuesday.

--
Best Regard,
Ruslan


On 10/7/26 18:29, Alex Bennée wrote:
> 
> Hi,
> 
> The KVM/QEMU community call is at:
> 
> https://meet.jit.si/kvmcallmeeting
> @
> 13/10/2026 14:00 UTC
> 
> I would like to propose a discussion that came out of Core Collective's
> QEMU sub-group [1]:
> 
>   - Memory port interfaces for co-simulation
>   - Dynamic machines / data driven machines
>   
> This was discussed in relation to recent proposals to upstream some of
> the features from the Xilinx downstream fork:
> 
>   From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>   Message-ID: <20260915160044.345788-1-ruslichenko.r@gmail.com>
>   Date: Tue, 15 Sep 2026 18:00:24 +0200
>   Subject: [PATCH v2 00/20] hw/core: Introduce Remote Port Co-simulation Protocol
>   From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
> 
> There is also a wider meta-question of where the best place to
> co-ordinate engineering (and potentially funding) for these sort of
> features is. Obviously CoreCollective is already a place to do this for
> companies in the Arm eco-system but features that support co-simulation
> are hopefully of interest to a number of the architectures.
> 
> Are there any other agenda items for the sync-up?
> 


