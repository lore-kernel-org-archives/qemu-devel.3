Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714EDCD11BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 19:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn1R7-0003ve-Cd; Wed, 20 Mar 2024 15:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rn1R5-0003vQ-CM
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 15:17:16 -0400
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rn1R3-0004Hy-Lc
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 15:17:15 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id EB63480022;
 Wed, 20 Mar 2024 20:17:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1710962229; bh=dqeHXBRyB6860g3ObLHrzozKVnfOjOj3hkTr024IS/Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=hrIV/aZqFjeSSY4rBWFiGIC8VQ+gl5ipD1LaaI0bPp5KOo4qGOIBh3F7SPJ/R5lGb
 /zPT68jMdD4G7I+1F7X5OUDGnNZUB2RNA+Fdd9baGbm36DrjpfTH65Q2vH567Hfddz
 Ba+S2d/VFktJnRtP0Qyo3C84ZfcoL+l1Qsvo+35Y/q0Z1JrqqmZqPzeavnwgbZfTkJ
 j1KqyIIq165Ny2VlmOvT3LttwwawH1PvBNJdOWOjai4xjqfDJ27BF4UUsNl0EbVMYc
 Q6DJ3kE/kIVYj69hz8KdbAGRfRfGfuELAH2cMbMSbjwNnSbFs/S8BR0UA2wKNy9Y5s
 TMl2N3EgqruWQ==
From: Samuel Tardieu <sam@rfc1149.net>
To: Felipe Balbi <balbi@kernel.org>
Cc: qemu-devel@nongnu.org,   Felipe Balbi <felipe@balbi.sh>
Subject: Re: [PATCH 1/2] hw/arm: Add support for stm32g000 SoC family
In-Reply-To: <20240320184759.754619-2-balbi@kernel.org> (Felipe Balbi's
 message of "Wed, 20 Mar 2024 20:47:58 +0200")
References: <20240320184759.754619-1-balbi@kernel.org>
 <20240320184759.754619-2-balbi@kernel.org>
User-Agent: mu4e 1.12.1; emacs 29.2
Date: Wed, 20 Mar 2024 20:17:08 +0100
Message-ID: <87h6h0n26j.fsf@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Felipe Balbi <balbi@kernel.org> writes:

> +    qdev_prop_set_uint8(armv7m, "num-prio-bits", 4);

Hi Felipe.

This should be 2, not 4. From RM0454 section 11.1 on page 250: "4 programmable priority levels (2 bits of interrupt priority are used)".

  Sam
-- 
Samuel Tardieu

