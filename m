Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DE9D59F5C
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 02:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUFFC-0006CM-0z; Fri, 12 Dec 2025 21:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbn@yandex-team.com>)
 id 1vUFF7-0006CA-Ks; Fri, 12 Dec 2025 21:20:21 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbn@yandex-team.com>)
 id 1vUFF4-0004HO-S7; Fri, 12 Dec 2025 21:20:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B8481804AB;
 Sat, 13 Dec 2025 05:20:11 +0300 (MSK)
Received: from [10.211.141.18] (10.211.141.18-vpn.dhcp.yndx.net
 [10.211.141.18])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6KGIuN1FqW20-qUEV00XX; Sat, 13 Dec 2025 05:20:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1765592411;
 bh=CvzHaP9W6lMABxx0nnrO8cueNmaPzF4mt+LCydWqi5c=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=k/RIYX6V54IlQ+SMFCmHqL22T7ltKzGBHzBvltUVGDN25aNfDxWXRr2N7BbQlYAO5
 37o7QJCaJixl5Vc3KP1ev4tgFeNDj4cOfWCwy3jzZUeBGbVXpjmDvkx8xFG7eiUhSS
 ZP4mtdKrasy1n65B942JF/uN5c+9snAZRu8YEPDI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Message-ID: <8582d6d5-507d-437d-be8c-c8e0b1225769@yandex-team.com>
Date: Sat, 13 Dec 2025 11:19:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] q35: Fix migration of SMRAM state
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, mst@redhat.com, michael.roth@amd.com
References: <20251211165454.288476-1-imammedo@redhat.com>
Content-Language: en-US
From: Andrey Ryabinin <arbn@yandex-team.com>
In-Reply-To: <20251211165454.288476-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=arbn@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 12/12/25 1:54 AM, Igor Mammedov wrote:
> When migrating, dst QEMU by default has SMRAM unlocked,
> and since wmask is not migrated, the migrated value of
> MCH_HOST_BRIDGE_F_SMBASE in config space fall to prey of
> 
>   mch_update_smbase_smram()
>     ...
>     if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff) {
>         *reg = 0x00;
> 
> and is getting cleared and leads to unlocked smram
> on dst even if on source it's been locked.
> 
> As Andrey has pointed out [1], we should derive wmask
> from config and not other way around.
> 
> Drop offending chunk and resync wmask based on MCH_HOST_BRIDGE_F_SMBASE
> register value. That would preserve the register during
> migration and set smram regions into corresponding state.
> 
> What that changes is:
> that it would let guest write junk values in register
> (with no apparent effect) until it's stumbles upon
> reserved 0x1 [|] 0x2 values, at which point it
> would be only possible to lock register and trigger
> switch to SMRAM blackhole in CPU AS.
> 
> While at it, fix up test by removing junk discard before negotiation hunk.
> 
> PS2:
> Instead of adding a dedicated post_load handler for it,
> reuse mch_update->mch_update_smbase_smram call chain
> that is called on write/reset/post_load to be consistent
> with how we handle mch registers.
> 
> PS3:
> for prosterity here is erro message Andrey got due to this bug:
>     qemu: vfio_container_dma_map(0x..., 0x0, 0xa0000, 0x....) = -22 (Invalid argument)
>     qemu: hardware error: vfio: DMA mapping failed, unable to continue
> 
> 1) https://patchew.org/QEMU/20251203180851.6390-1-arbn@yandex-team.com/
> Fixes: f404220e279c ("q35: implement 128K SMRAM at default SMBASE address")
> Reported-by: Andrey Ryabinin <arbn@yandex-team.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

Reviewed-by: Andrey Ryabinin <arbn@yandex-team.com>

