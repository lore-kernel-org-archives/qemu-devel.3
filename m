Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E92FE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 12:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt2rs-0002Uq-Qz; Thu, 19 Feb 2026 07:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vt2rq-0002UI-2A
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:10:50 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vt2rn-0001qf-BN
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=VKcZw4shJXaD3sECAVsM48iYTgcRMa3oDUvt25bGHY8=; b=Be+YDOuGo3ZYsYD
 n43Ds4bRqiW2xtFwI4f6PKf4Qkpnek2XU0cX7U3AqpNg0zl2SPLexDEUXRcSnMTK6lqwJpg9lktOr
 NbrZbSCqZF8/fc18eXyoDe53O6K5pwH4mL2bqJ0RZ+S8HTKVBYti/jaUO7eEvy0wWLrNriXqDhT+W
 G4=;
Date: Thu, 19 Feb 2026 13:14:20 +0100
To: deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 1/4] hw/hppa: Add BMC on 64-bit machines only
Message-ID: <aZb-gJgA9fHFrqc7@hive.localdomain>
References: <20260218201221.20958-1-deller@kernel.org>
 <20260218201221.20958-2-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260218201221.20958-2-deller@kernel.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/02/26, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Prevent adding the BMC with it's serial ports on 32-bit machines, even
> if they have a PCI bus like the B160L. This fixes boot problems with
> HP-UX on B160L.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: 557bc5260cfd ("hw/hppa: PCI devices depend on availability of PCI bus")
> Cc: qemu-stable@nongnu.org
> ---
>  hw/hppa/machine.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index c3680667ae..d6aeb793c0 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -376,7 +376,9 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>  
>      if (pci_bus) {
>          pci_init_nic_devices(pci_bus, mc->default_nic);
> +    }
>  
> +    if (pci_bus && hppa_is_pa20(&cpu[0]->env)) {
>          /* BMC board: HP Diva GSP PCI card */
>          dev = qdev_new("diva-gsp");
>          if (dev && !object_property_get_bool(OBJECT(dev), "disable", NULL)) {
> -- 
> 2.53.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

