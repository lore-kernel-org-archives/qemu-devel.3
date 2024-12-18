Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5574E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxqS-0004ua-9h; Wed, 18 Dec 2024 12:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1tNxqQ-0004tD-BR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:28:22 -0500
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1tNxqO-0001EW-PW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:28:21 -0500
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1tNxqK-0088K4-O5;
 Wed, 18 Dec 2024 17:28:16 +0000
Date: Wed, 18 Dec 2024 17:28:16 +0000
From: John Levon <levon@movementarian.org>
To: Markus Lavin <markus.lavin@ericsson.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Use of BQL from thread in PCIe device
Message-ID: <Z2MGMM56+HzQ/ehS@movementarian.org>
References: <DU2PR07MB8179DBDD123A4615CBD1688EE8052@DU2PR07MB8179.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR07MB8179DBDD123A4615CBD1688EE8052@DU2PR07MB8179.eurprd07.prod.outlook.com>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 18, 2024 at 04:19:47PM +0000, Markus Lavin wrote:

> Hi,
> 
> I think that I might have misunderstood something fundamental about the BQL
> (or possibly Qemu in general).
> 
> I have a custom PCIe device that connects to an outside simulation environment
> using Unix domain sockets. To deal with bus-mastering from this outside
> environment I have a thread created with qemu_thread_create listening to the
> socket.
> 
> If I get a read/write/interrupt request over the socket then the thread should
> perform a pci_dma_read/pci_dma_write/msix_notify. Since this is called from
> the threads context I assumed I should first grab the BQL. Issuing a bql_lock
> from the thread however hangs Qemu.
> 
> Is my thinking flawed?

The BQL will be already taken for these callbacks higher up in the stack I believe.

regards
john

