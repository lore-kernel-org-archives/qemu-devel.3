Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11E5C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJT9-0003fA-TW; Fri, 24 Jul 2026 13:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo@managarm.org>) id 1wnJT7-0003ey-Lt
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:13:53 -0400
Received: from hades.hosts.managarm.org ([195.201.36.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo@managarm.org>) id 1wnJT6-0001if-8X
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=managarm.org; s=2021;
 t=1784913230; bh=HqmowP/v7ObXEsHqY8aEsVaE085HZMR0yWot54hK8IE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Xx6dwT18eNTx3WUR9thOjbXW0WZU1xHNqUpXnIFI3zHosTr4lj8WXdGLbj7ekDt37
 Y+YKhbZkl9lz7t6ekf7zTEr71u7+oY2hIMuExtJKetu5B4IPYQ5xlALhx1igwEGGPO
 omUgwfh4ZHktOQvIorWPCZolxQ4GyvxaPceKWhA7IVUAqsG47Esie1z/XE1NesCkqC
 iLNLQzdAs4aeSVNLNaKcl8+O7fR2gzAWIotVSOevEvo0ErUOIErTf4NHUCJpIqZZ79
 SWhZZT3VthevFc20OxOoY4j0jhGdxbUQt8w8z9IiePHLaZQNNzP7lsSX3gpNrt1xZx
 zLtWGjRBNkHRw==
Received: from [192.168.1.169] (pd9f9de93.dip0.t-ipconnect.de
 [217.249.222.147])
 by hades.hosts.managarm.org (Postfix) with ESMTPSA id 47CF73EE12;
 Fri, 24 Jul 2026 17:13:50 +0000 (UTC)
Message-ID: <756408ef-e40b-4f35-9f78-ccec5d3e6e1b@managarm.org>
Date: Fri, 24 Jul 2026 19:13:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix incorrect msg_l[sr]pid members of
 target_msqid_ds
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260724160105.3787888-1-leo@managarm.org>
 <9c278046-3b5a-4d0b-ac55-76a304f1109a@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=leo@managarm.org; keydata=
 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
 a0DXWR3gZZ+Pjg==
In-Reply-To: <9c278046-3b5a-4d0b-ac55-76a304f1109a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.201.36.94; envelope-from=leo@managarm.org;
 helo=hades.hosts.managarm.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reply-to:  Leo <leo@managarm.org>
From:  Leo via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

> The change looks correct in itself.
> Did it expose a bug, or did you found this reviewing original commit?
I noticed this when the 'msg_lrpid' member was unexpectedly zero after a
msgctl(IPC_STAT) call, and printing the 'struct msqid_ds' in question with gdb
revealed that the expected value was not in 'msg_lrpid', but the unused member
located right after. The 'Fixes' line is based purely on running git blame.

Cheers,
Leo


