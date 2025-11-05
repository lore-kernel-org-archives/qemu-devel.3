Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A383CCFA04
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 06:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGWu8-0000Rc-Uj; Wed, 05 Nov 2025 01:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGWu6-0000RD-30
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 01:21:58 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGWu2-0003pl-Ss
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 01:21:57 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A56LYYL088662
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 5 Nov 2025 15:21:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=YgRjsf5FkEyT0uTQfJQWcgei5Bb8PzG4OZp1Ywmp0dU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762323694; v=1;
 b=WAUfIMYVer8teZjFEcQ+4+Y+ZstBMLxppqLYNej8ojiNT5kWP4BK8DnWj87tAWfK
 M/ucP5SIDmNMdG/bBszoQEUej3pozLZIBN6eyVvvhzwKCYHmjC//psFNTvwh6BZO
 X2eDcCd61ujbVafrk8Wofek+XYyl1ZoHJcrsJuWw5bfFkw9qo7tD5n6WwDwe7oCf
 FybQ7ARmu8MCa2mntOd747OHvE5g4YegvfETkp1nVtM/tr046OkJ60wrGJJ3wCCN
 E7t5bkyxPrbJMCfjAl36EufpWwpDlFMgjFuyKoYXwuqvJgZJNe7COW+HunRPlg5p
 4010xVEH2Wesu2pVpZ1FUQ==
Message-ID: <ee140cb1-3041-4f38-acb2-43d73101ed3c@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 5 Nov 2025 15:21:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/net/e1000e: Fix assertion failures in
 e1000e_write_payload_frag_to_rx_buffers()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>
References: <20251103175851.428816-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251103175851.428816-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/04 2:58, Peter Maydell wrote:
> This patchset fixes assertion failures in
> e1000e_write_payload_frag_to_rx_buffers().  There turn out to be two
> ways this assert could be triggered.
> 
> The first is the one reported in
> https://gitlab.com/qemu-project/qemu/-/issues/537 where a malicious
> guest could set up the device into loopback mode and then send a
> carefully sized packet that trips a bug in the logic in
> e1000e_write_packet_to_guest() that tries to calculate how much data
> it is going to put into an RX descriptor, causing us to hit the
> assertion.
> 
> The second is one I spotted by code inspection, where the assert is
> slightly over-eager and could assert in one valid case of a just
> exactly large enough packet.
> 
> Patch 1 fixes what I believe to be an incorrect-behaviour bug
> for descriptors with NULL buffer addresses, largely because
> that makes the following patch to fix the assertion less awkward.
> 
> thanks
> -- PMM
> 
> Peter Maydell (3):
>    hw/net/e1000e_core: Don't advance desc_offset for NULL buffer RX
>      descriptors
>    hw/net/e1000e_core: Correct rx oversize packet checks
>    hw/net/e1000e_core: Adjust e1000e_write_payload_frag_to_rx_buffers()
>      assert
> 
>   hw/net/e1000e_core.c | 85 ++++++++++++++++++++++++++++++--------------
>   1 file changed, 59 insertions(+), 26 deletions(-)
> 

For the whole series:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

