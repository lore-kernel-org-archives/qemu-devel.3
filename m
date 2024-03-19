Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBBDC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcXI-0005wV-4R; Tue, 19 Mar 2024 12:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1rmcXH-0005wD-4X
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:41:59 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1rmcXF-00087a-F4; Tue, 19 Mar 2024 12:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=37eFig9oH/QNNmJsKafkT/lGPlPuFsdDQ7kI88JAF2A=; b=sQ36FOras2NZoGlsPF+7
 0qJ27VFS9Wc2JEfliGYgh1ntj3tyueRFvQ7clsr/EnbviBqH5lyPCmtVbLqTTB+yIc0JF1GILR84a
 2339Bs0NkPNAm2z8A09aFkpmat4ExsjtlENAck6AtA/MFznt3gE25UQt6qzeXdaM4F2elDPd2uCmq
 +V15C8yLQLSX/eyMgEEB2jHxuz4bW14SEU6FyGpP3RzOUPWxEkzziPaE+fK0zv3BdVg6cBmvulmXC
 8hdPXRluefJ8qHYJW/B4dWEF+Ugkq/AitJbLD7Ol1l2IJVlLJdqj/vjQ13CQN7/t1iSPOjo2a4GoL
 RMV48vhcYtpIDw==;
Date: Tue, 19 Mar 2024 17:41:54 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Thomas Huth <thuth@redhat.com>
Cc: "Srinivasu Kandukuri (MS/ECP2-ETAS-VOS)"
 <Srinivasu.Kandukuri@in.bosch.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: Request for Support: QEMU IPv6 Port Forwarding Issue
Message-ID: <20240319164154.ptdvishj7cvaga2l@begin>
References: <AS2PR10MB6711590909DD220D9B735920C92C2@AS2PR10MB6711.EURPRD10.PROD.OUTLOOK.COM>
 <3e0a5ecf-fe53-4bfe-9c93-7a7fca0fb157@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e0a5ecf-fe53-4bfe-9c93-7a7fca0fb157@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
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

Hello,

Thomas Huth, le mar. 19 mars 2024 15:28:12 +0100, a ecrit:
> On 19/03/2024 06.53, Srinivasu Kandukuri (MS/ECP2-ETAS-VOS) wrote:
> > Dear QEMU Support Team,
> > 
> > We are currently encountering difficulties in utilizing QEMU for
> > starting a virtual machine image on Windows with IPv6 networking,
> > specifically related to port forwarding. We are using QEMU emulator
> > version 7.1.93 (v7.2.0-rc3-11946-gb68e69cdcc-dirty).
> > 
> > Our objective is to establish IPv6 network connectivity within the
> > virtual machine and forward ports to allow external access. However, we
> > are encountering errors when attempting to configure the port forwarding
> > mechanism.
> > 
> > Here is the command we are using:
> > 
> > *qemu-system-x86_64: -netdev user,id=net1,ipv6=on,ipv6-net=fe80::5054:ff:fecd:585a/64,hostfwd=tcp::2210-[fe80::5054:ff:fecd:585a]:22*
> > 
> > However, upon executing this command, we encounter the following error:
> > 
> > *Invalid host forwarding rule 'tcp::2210-[fe80::5054:ff:fecd:585a]:22'
> > (Bad guest address)*
> > 
> > We understand that the format for specifying host forwarding rules
> > follows the pattern:
> > 
> > *protocol:[listen_address]:listen_port-[dest_address]:dest_port*
> > 
> > We believe that we are following this pattern correctly, but still, we
> > are encountering errors.
> 
> Looking at the code:
> 
>  https://gitlab.com/qemu-project/qemu/-/blob/v8.2.0/net/slirp.c#L824
> 
> it seems like QEMU is only using inet_aton() here, which means IPv4 only,
> sorry, but this likely needs some additional changes first to support IPv6
> addresses here.

Nicholas Ngai's work is still pending integration:

https://lists.gnu.org/archive/html/qemu-devel/2022-03/msg05643.html
https://gitlab.com/qemu-project/qemu/-/issues/347

Samuel

