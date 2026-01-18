Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02529C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 23:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhbvZ-0002L1-2C; Sun, 18 Jan 2026 18:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhbvX-0002H7-El
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 18:11:23 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhbvV-0002Fw-Py
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 18:11:23 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso23975345ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768777880; x=1769382680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8U3BbmWHNss/hU7EiYqp9lVgKowrEn4KC1xWRNppbYA=;
 b=xzoLd27ba2SOMNEvQ1BQm+vDoMqAL3JjffWgotvM0eu15KubWkT1E/MGX0GmiUQG7E
 DxZuHrpg4O07m5iVwZ1dsuCsXsJxYZi3LZ+y3ceWGbIXsKTzGzydDUi8UHyPMyQpb81Z
 UgF86Do3xUoekmjyGZD1CRHlYA5sRabGOhf1LSogc9OzsR4wCKABMYGO4njutiVOdmgZ
 Lnr08PzP2nTCpOC1WhP/mM1ghT00n1JVtUpMc+VI9s3oIUTLPKiy/lmuYxhjiMl7HweX
 WBSLr3jjITsP7yM6EyszunY5uwFhIqbU8k8NqoiK4uQiXu1fwaeyLsiofkujLqN+DCyJ
 ZX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768777880; x=1769382680;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8U3BbmWHNss/hU7EiYqp9lVgKowrEn4KC1xWRNppbYA=;
 b=A6CU4xRxD63e/cgB8QhW/5wmhc6Z0mZQQn3rk+Zq/6p0XaR/Mi6iya2nNszrdpmsby
 QTZh9TXybKWcixlXOVmgwURuhgrhMInIIsy86CrV1QV1qnscoUuTgovrntxoLOwGGI8c
 KS8DsyrRABm19yVmIrUoH2URBEn4zcg7zGz4xZiHWXgNvb3mq7Alfm7aFd/l0p5N0WM8
 G7vkXkd0306otxTIlSq27w5ZsXi1qkLC/LkR6M1DuwvM+eL8damJ4Mer32JV8VVAwxMS
 afiy3ZVvEJKvw9zdogmJqdrh/Uv1R2xy7NA5cSy/E4RKHF6dpdGy5DZMpqqnzPguV90W
 jFzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnDrsG1Ao1O8w8/4Laoef6ah/HWBluofvMuQ9lELdAabZdPxCslCoEBN0/5htLjq45XtZKwFwmyj5L@nongnu.org
X-Gm-Message-State: AOJu0Ywd3Vu0PUDAjqvD3Tt6R3QF/vPnoszpk6hdAgNKfiSG0LIldz47
 vGV//5OVsxt2qtbxPVerxgDoZPqD1xlE6cWnH0yfLDHqjzq6u8+sMBWTBNa5HQFlk7w=
X-Gm-Gg: AY/fxX7yKnBtrRknTJDJJGqL1bzoCIB92pcruZOII2U1xwZQQ8VXbx26k0/GUCRU/sW
 ur8qhZ8mt/GIJB1pOxG+G/BG5pM22Vg5mTilLOtQ28oVvIn6cO4eBmdOIVr4xowj6s9XMxlzu1r
 w7SmNH3exDDej57ZknnbS/OT6ILAZLfvJXeEdtFJBPGGuwpcInsL3tptahLOKEoP6gixjXVRtl8
 MPc/8wRBQxMCYdvqMfC9UNhDbIiHbjzSip7v96MSmtyfeR3+iCi6rWZuRs/ppbG1DX9ELhi4YMB
 8BIh1IQjTwEOXaMNv7weeYvTSku8QPKfIlaZ0p3epFiOVG+azPOziTkhCxsXz87B+QZgJ14S1bp
 yWeEjSv3Xpi+EHPOLnKmlHvAJ5se1R+RwcMwV2yNBvk3uuyDPJQzQ/80s+gLYxs/UAcrPZBGAco
 RgaV/Symp61peYnz3EBDK9J7iE9fcN5A==
X-Received: by 2002:a17:903:289:b0:2a0:9923:6954 with SMTP id
 d9443c01a7336-2a717554cacmr76573075ad.27.1768777879959; 
 Sun, 18 Jan 2026 15:11:19 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab9cbsm76205985ad.14.2026.01.18.15.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 15:11:19 -0800 (PST)
Message-ID: <e0d920ea-2c0f-44fb-9896-95d6ef80b86c@linaro.org>
Date: Mon, 19 Jan 2026 10:11:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/18] bswap: Include missing 'qemu/bswap.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
 <20260118193509.42923-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260118193509.42923-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/19/26 06:34, Philippe Mathieu-Daudé wrote:
> All these files indirectly include the "qemu/bswap.h" header.
> Make this inclusion explicit to avoid build errors when
> refactoring unrelated headers.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   block/qcow2.h                         | 1 +
>   audio/audio.c                         | 1 +
>   block/blklogwrites.c                  | 1 +
>   block/export/vduse-blk.c              | 1 +
>   block/export/vhost-user-blk-server.c  | 1 +
>   block/export/virtio-blk-handler.c     | 1 +
>   block/parallels-ext.c                 | 1 +
>   hw/9pfs/9p-local.c                    | 1 +
>   hw/block/cdrom.c                      | 1 +
>   hw/block/hd-geometry.c                | 1 +
>   hw/net/can/ctucan_core.c              | 1 +
>   hw/nvram/xlnx-efuse.c                 | 1 +
>   hw/scsi/scsi-generic.c                | 1 +
>   hw/sd/sd.c                            | 1 +
>   hw/sd/ssi-sd.c                        | 1 +
>   net/l2tpv3.c                          | 1 +
>   qga/commands-linux.c                  | 1 +
>   scsi/pr-manager-helper.c              | 1 +
>   target/arm/tcg/arith_helper.c         | 1 +
>   tests/qtest/acpi-utils.c              | 1 +
>   tests/qtest/aspeed-hace-utils.c       | 1 +
>   tests/qtest/bios-tables-test.c        | 1 +
>   tests/qtest/libqos/igb.c              | 1 +
>   tests/qtest/libqos/virtio-9p-client.c | 1 +
>   tests/qtest/migration/framework.c     | 1 +
>   tests/qtest/npcm7xx_emc-test.c        | 1 +
>   tests/qtest/tpm-emu.c                 | 1 +
>   tests/qtest/ufs-test.c                | 1 +
>   tests/qtest/vmgenid-test.c            | 1 +
>   tests/unit/test-hbitmap.c             | 1 +
>   util/bitmap.c                         | 1 +
>   31 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

