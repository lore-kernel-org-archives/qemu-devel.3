Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25B3C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Gm-0006z9-TW; Tue, 21 Jul 2026 08:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm9Ge-0006vJ-GX; Tue, 21 Jul 2026 08:08:14 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm9Gb-0001Tb-M3; Tue, 21 Jul 2026 08:08:12 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66LC7vM1044992
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2026 21:07:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=bDMJaN5yXd1EQyF3Ntjt61mHO7zEZbcl60qreYhGdzw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784635677; v=1;
 b=o+XcDqwtRB6jM8Rn94IyK+itEOwmLIDVCo4+xqXPZbmwts+uq4Myby2XQDY7Uc2p
 yRPL/wwOmDEPTD2gtqoCbCEoXQKbSJ8wgcSys+ZNRD9TLhD+Wnq+BoPV6ESfqPlw
 3xGoLFvPg+7/R628Ya5u7Br0DeD8uDsiWfQ4ODmXYIOzq+EWihDkSm9/Oh4D9xNa
 NHbFZAOIVhKTE00FNdK/wE4fV1CCWPK8f9LAOSk1yC5BtFCpghN7sCDGwuySY0h8
 PBltNTXiACPR8DHGD++Y/kZmUneH0ttmKs/A31t/xFQWShqUauTXMEmeJ+bBnygl
 D15Hn7vS88r59MbiN82uPw==
Message-ID: <03ce1631-e8a8-4506-8295-e216830d47ae@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 21 Jul 2026 21:07:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/net/e1000e: recalculate rx_desc_len on migration
 load
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-stable@nongnu.org
References: <20260721111126.3278244-1-lvivier@redhat.com>
 <20260721111126.3278244-2-lvivier@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260721111126.3278244-2-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/07/21 20:11, Laurent Vivier wrote:
> rx_desc_len is migrated as a raw uint8_t from the stream, but it
> is a derived value that can be computed from the register state in
> core.mac[RCTL]. A crafted migration stream can set rx_desc_len to
> an invalid value (e.g. 64), causing a stack buffer overflow in
> e1000e_write_packet_to_guest() which copies rx_desc_len bytes into
> a 32-byte stack union.

The value is derived from core.mac[RFCTL] and core.mac[RCTL], not solely 
core.mac[RCTL].

The change itself looks good to me.

Regards,
Akihiko Odaki

> 
> Recalculate rx_desc_len from the register state in post_load,
> ignoring the untrusted value from the stream.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3869
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/net/e1000e_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 46e156a5ddc2..31eb39e4aa40 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -3557,5 +3557,7 @@ e1000e_core_post_load(E1000ECore *core)
>       e1000e_intrmgr_resume(core);
>       e1000e_autoneg_resume(core);
>   
> +    e1000e_calc_rxdesclen(core);
> +
>       return 0;
>   }


