Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C164FC44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 05:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmlfo-0002ur-AX; Thu, 23 Jul 2026 01:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wmlfi-0002uZ-Lx
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 01:08:38 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wmlff-0006m4-PL
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 01:08:38 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66N58M8E027377
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Jul 2026 14:08:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=B1Dl3mys7vHaraavgmk4v0y+g52o+6r/K0T7HIU+QE8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784783302; v=1;
 b=gaH5WklxvQ+qdD+YU23eKntgjVhvNOcjCpmZnQX1jAEMPL2XAyWeBAKvJknS2fXW
 tZbaQKs7pGZiFpOhCUZo7iWzjm6LzcBA6hH5Ne+oMXlroGQgO7fPELogXtFlzzca
 /mHW0Qyodl7G/iFBWVtFxjWzS2KmU36bJ/xn4aJsZ2I1Wh9b2FksHidQPOCFjnUG
 ksbhBkUDAV4q/RzpT9tK3RDoIl7up9UWgpqsBngCl6OAjUzPbVHUylht097/23Rs
 1uSp2+5sZ9fIoHQB3IwWPtX1Y/Q6xCbAPa0pCh856wrNfJLdviU90Y6Rgm+KC1Hj
 KiXt7AMzjmsMPwmmt/cvYg==
Message-ID: <bf258aae-58e3-4892-a93d-dddcf06429de@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 23 Jul 2026 14:08:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] hw/net: fix rx_desc_len on migration load
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>
References: <20260722112449.1386162-1-lvivier@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260722112449.1386162-1-lvivier@redhat.com>
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

On 2026/07/22 20:24, Laurent Vivier wrote:
> rx_desc_len is migrated as a raw uint8_t from the stream in both
> e1000e and igb, but it is a derived value that can be computed from
> the register state. A crafted migration stream can set rx_desc_len
> to an invalid value, causing a stack buffer overflow in
> e1000e_write_packet_to_guest() which copies rx_desc_len bytes into
> a 32-byte stack union.
> 
> Recalculate rx_desc_len from the register state in post_load,
> ignoring the untrusted value from the stream.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3869>
> v2:
>    - extract e1000e_calc_rxconf() to recalculate all derived RX values
>    - fix commit message to mention both RFCTL and RCTL
>    - fix commit message to note that igb_rx_use_legacy_descriptor()
>      is currently a stub
> 
> Laurent Vivier (2):
>    hw/net/e1000e: recalculate rx_desc_len on migration load
>    hw/net/igb: recalculate rx_desc_len on migration load
> 
>   hw/net/e1000e_core.c | 18 +++++++++++++-----
>   hw/net/igb_core.c    |  2 ++
>   2 files changed, 15 insertions(+), 5 deletions(-)
> 

For the whole series,

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

