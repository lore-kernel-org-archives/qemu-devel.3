Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBC2C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 18:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Eb5-0003Ts-VQ; Wed, 01 May 2024 14:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1s2Eb3-0003Ti-7N
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:22:25 -0400
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1s2Eb1-0002VZ-3K
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1714587740;
 bh=nlC8u5FNep/I5qxNcgxypJDAaWmD0zfcfY0gi9iaGdE=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=sB783Rw6XFEvSN5LwnBq24CYSakzoXusCJA14khLCkVakgpjDA1m0vfo7ag/ObU8t
 mPMygTffFIdjFAzjTbxkepo7+sfLQNFI+4AgNdpIZnlhqhJpZXX8tCz5KFBBeGJvZF
 bfVAGD/mD6vneJHPBJw2YklOY8Nh4mER8xECRFao=
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2436812817E1;
 Wed,  1 May 2024 14:22:20 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id dhCky9v0qs23; Wed,  1 May 2024 14:22:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1714587739;
 bh=nlC8u5FNep/I5qxNcgxypJDAaWmD0zfcfY0gi9iaGdE=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=gxn9N9DcoWyTE94+l46DQjLpNFK8Wj3zRpJbPGfVp/vJ9cFqKV9RyIaad6c5JPMWb
 1L0dd0Pk05u+yCgiofrDBiwd18JIxXe3E50fM5dgKfgL1HtH4J5pH7T1WjNEdNWlMy
 ZzuEDXPRhqCRXIcxvX6UN7gLVawLe0I2APij/G4w=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown
 [IPv6:2601:5c4:4302:c21::a774])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7514012817D6;
 Wed,  1 May 2024 14:22:19 -0400 (EDT)
Message-ID: <251dffb90c274efbb4b5e0cae21745287730c02c.camel@HansenPartnership.com>
Subject: Re: [PATCH v10 2/2] tpm: add backend for mssim
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Markus
 Armbruster <armbru@redhat.com>
Date: Wed, 01 May 2024 14:22:17 -0400
In-Reply-To: <b7bc97f6-ba49-4ee8-8c59-cf79712933f1@linux.ibm.com>
References: <20240430190855.2811-1-James.Bottomley@HansenPartnership.com>
 <20240430190855.2811-3-James.Bottomley@HansenPartnership.com>
 <2825c9bb-a4d5-4196-b025-5f46571b3953@linux.ibm.com>
 <c97f84c7d6e026450644466313b6347b00841a43.camel@HansenPartnership.com>
 <8347cf6a-7c9f-48f8-a3a7-4053aefd2176@linux.ibm.com>
 <f10810369c716e53dc9568868cb8b83efbe5be19.camel@HansenPartnership.com>
 <b7bc97f6-ba49-4ee8-8c59-cf79712933f1@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:fcd0:100:8a00::2;
 envelope-from=James.Bottomley@HansenPartnership.com;
 helo=bedivere.hansenpartnership.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2024-05-01 at 13:20 -0400, Stefan Berger wrote:
> 
> 
> On 5/1/24 12:52, James Bottomley wrote:
> > On Wed, 2024-05-01 at 12:31 -0400, Stefan Berger wrote:
> > > 
> > > 
> > > On 5/1/24 12:21, James Bottomley wrote:
> > > > On Tue, 2024-04-30 at 17:12 -0400, Stefan Berger wrote:
> > > > > On 4/30/24 15:08, James Bottomley wrote:
> > > > [...]
> > > > > > +The mssim backend supports snapshotting and migration by
> > > > > > not resetting
> > > > > 
> > > > > I don't thing snapshotting is supported because snapshooting
> > > > > would require you to be able to set the state of the vTPM
> > > > > from the snapshot you started. I would remove the claim.
> > > > 
> > > > I thought we established last time that it can definitely do
> > > > both (and I've tested it because you asked me to). 
> > > > Snapshotting and migration are essentially the same thing, with
> > > > snapshotting being easier because it can be done on the same
> > > > host meaning the same command line parameters.  If you migrate
> > > > to a different host you need the socket to point back to the
> > > > host serving the vTPM.
> > > > 
> > > > To do this easily you simply keep the vTPM running while the VM
> > > > is undergoing snapshot and migration.  If you're thinking of
> > > > and extended down time for the snapshot, then it's up to the
> > > > vTPM implementation to store the state (or simply keep it
> > > > running for an extended time doing nothing).
> > > 
> > > Which part of the code injects the state into the vTPM so that it
> > > resumes with the state of the TPM (PCRs, NVRAM indices, keys,
> > > sessions etc.) from when the snapshot was taken?
> > 
> > We've had this conversation before too:
> > 
> > https://lore.kernel.org/qemu-devel/f928986fd4095b1f27c83ede96f3b0dd65ad965e.camel@linux.ibm.com/T/#u
> > 
> > But the synopsis is nothing does.  The design is to be entirely
> > independent of vTPM implementation: it will actually work with any
> > TPM obeying the simulator IP protocol (MS reference, ibmswtpm2 or
> > even your swtpm) but the price of this is that the user has to
> > preserve the vTPM state, by whatever means they deem appropriate,
> > independently of the VM snapshot image.
> 
> Unless your backend can retrieve the state upon snapshot save and
> inject state into the vTPM upon snapshot resume, 'snapshotting' is
> not working  (correctly).

That's too narrow a definition.  Snapshot is working if you can capture
and restore the machine state.  A qemu snapshot can helpfully capture
some device states, but not all of it (Devices that are passed through,
like accelerators and AI units, are particularly problematic).  How you
get the external device state (IBM cloud has an elaborate scripted
state capture for GPUs, for instance) is up to the person implementing
the snapshot.  For this case, the added doc specifically warns "... the
state of the Microsoft Simulator server must be preserved (or the
server kept running) outside of QEMU for restore to be successful", so
I don't think there's going to be an expectation mismatch.

James



