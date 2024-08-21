Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FA0C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 06:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgfHx-0002HE-QI; Wed, 21 Aug 2024 02:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sgfHf-0002F8-Cc
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 02:57:34 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sgfHa-00088M-KL
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 02:57:31 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 30D772F5DD;
 Wed, 21 Aug 2024 08:57:18 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id OqKYfB4CxjCR; Wed, 21 Aug 2024 08:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1724223436;
 bh=V0ltFp3FBSi+7+/D+phmRT+tbhLTKZK1XGscOFiEzIE=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=DRg4H16tDTPWPVBSXWeNRuIRxQ1TMM4SAk7ko46lR/BiUspsQTjUlJD6R0Zyg0Am2
 eovYgS3fKmtyPwBlt3+k6sB1U4GTQJfB76O2CNDJIusSXifjj717OLTTfoD3rXtq/7
 saf4YYqSePiG3WHZC9C+XyJv5FxzliB9PABSOBaUFBHGlV5pXT8xft3PGu7rX53yde
 WUBdwdtn+Nb6e90xQz24ekwuKBy8mohFEG26HMQL3tX8Zwui8+vYS2AhT3LjkavM5V
 WDRUrJ8knjAU3g4N7OGa/7gGzLHmLSQ+Nfvrv5pvFlJG7M8lg1bNwP511FqHRpXAdT
 vLKvLUwjnEWVA==
Received: from baree.pikron.com (ip-78-102-109-231.bb.vodafone.cz
 [78.102.109.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 2E30C2F987;
 Wed, 21 Aug 2024 08:57:16 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH 2/5] hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
Date: Wed, 21 Aug 2024 08:57:20 +0200
User-Agent: KMail/1.9.10
Cc: Vikram Garhwal <vikram.garhwal@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20240816163504.789393-1-doug@schmorgal.com>
 <20240816163504.789393-3-doug@schmorgal.com>
In-Reply-To: <20240816163504.789393-3-doug@schmorgal.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202408210857.20254.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-1.03,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello Doug Brown,

On Friday 16 of August 2024 18:35:02 Doug Brown wrote:
> When checking the QEMU_CAN_FRMF_TYPE_FD flag, we need to ignore other
> potentially set flags. Before this change, received CAN FD frames from
> SocketCAN weren't being recognized as CAN FD.
>
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  hw/net/can/xlnx-versal-canfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/can/xlnx-versal-canfd.c
> b/hw/net/can/xlnx-versal-canfd.c index ad0c4da3c8..8968672b84 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -1003,7 +1003,7 @@ static void store_rx_sequential(XlnxVersalCANFDState
> *s,
>
>          dlc = frame->can_dlc;
>
> -        if (frame->flags == QEMU_CAN_FRMF_TYPE_FD) {
> +        if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
>              is_canfd_frame = true;
>
>              /* Store dlc value in Xilinx specific format. */

Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

That is a great catch, I have overlooked this in previous
review of the Xilinx code.

When I look into hw/net/can/xlnx-versal-canfd.c functions
regs2frame and store_rx_sequential then I see missing
handling of flags QEMU_CAN_FRMF_ESI and QEMU_CAN_FRMF_BRS.

In the function regs2frame is missing even initialization
of frame->flags = 0 at the start, which I expect should be there.
The
  frame->flags = QEMU_CAN_FRMF_TYPE_FD;
should be then
  frame->flags |= QEMU_CAN_FRMF_TYPE_FD;

You can see how it was intended to parse and fill flags in our
CTU CAN FD interface code which matches our design of common
QEMU CAN infrastructure and its extension for CAN FD.

See the functions
  ctucan_buff2frame()
  ctucan_frame2buff()
in
  hw/net/can/ctucan_core.c

QEMU_CAN_EFF_FLAG and QEMU_CAN_RTR_FLAG seems to be corrected
in followup patch

[PATCH 3/5] hw/net/can/xlnx-versal-canfd: Translate CAN ID registers

As for the DLC conversion, there are functions

  frame->can_dlc = can_dlc2len(xxxx)
  XXX = can_len2dlc(frame->can_dlc);

provided by net/can/can_core.c

I am not sure how much competent I am for the rest of the patches,
because I do not know XilinX IP core so well. Review by Vikram Garhwal
or somebody else from AMD/XilinX is more valueable there.
But I can add my ACK there based on rough overview.

Best wishes,

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

