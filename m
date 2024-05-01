Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C30C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 16:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Chl-0006El-1R; Wed, 01 May 2024 12:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1s2Chj-0006Ea-Ik
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:21:11 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1s2Chh-0006yA-Ek
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1714580466;
 bh=ymVuawzDEW9SMq0u/TAhdnHPrtfevmTqzRLHgaQRd5I=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=ut3swUxffKURKD48Y4qwS3OYx3qPBE92gGbGrpU8Rk0/sxpEsV6AAanSbAoXLh+7J
 22t0X8iCvTE3G6BwMperEXB9dOf6qRsmnMHb03eWlwcgcMvCIi6jqlW/xOuIuqIFjq
 uVOP65xnyquzxszqppp4ZUE2XHcFd0MswsJchQGo=
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id 37FB1128167C;
 Wed,  1 May 2024 12:21:06 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id XXTzITcmKT8v; Wed,  1 May 2024 12:21:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1714580465;
 bh=ymVuawzDEW9SMq0u/TAhdnHPrtfevmTqzRLHgaQRd5I=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=XSkjwUvkCCvjBVJ6BZOgFDsKL1jH88ghagkXXG24jTziRXooe9OJKT8bvlnDcrFPT
 ME20Xh/oaJYP49Z7Y9Yc0s8+sRF2H4kxDLym7YMDgy8V+Ivpr6qdKw+RRRkD/0tHWp
 5WAVXRzmWMc6K2OylAgx1g2Mu5n2OfSs1E9VA16M=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown
 [IPv6:2601:5c4:4302:c21::a774])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 76F361280355;
 Wed,  1 May 2024 12:21:05 -0400 (EDT)
Message-ID: <c97f84c7d6e026450644466313b6347b00841a43.camel@HansenPartnership.com>
Subject: Re: [PATCH v10 2/2] tpm: add backend for mssim
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Markus
 Armbruster <armbru@redhat.com>
Date: Wed, 01 May 2024 12:21:03 -0400
In-Reply-To: <2825c9bb-a4d5-4196-b025-5f46571b3953@linux.ibm.com>
References: <20240430190855.2811-1-James.Bottomley@HansenPartnership.com>
 <20240430190855.2811-3-James.Bottomley@HansenPartnership.com>
 <2825c9bb-a4d5-4196-b025-5f46571b3953@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=96.44.175.130;
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

On Tue, 2024-04-30 at 17:12 -0400, Stefan Berger wrote:
> On 4/30/24 15:08, James Bottomley wrote:
[...]
> > +The mssim backend supports snapshotting and migration by not
> > resetting
> 
> I don't thing snapshotting is supported because snapshooting would 
> require you to be able to set the state of the vTPM from the snapshot
> you started. I would remove the claim.

I thought we established last time that it can definitely do both (and
I've tested it because you asked me to).  Snapshotting and migration
are essentially the same thing, with snapshotting being easier because
it can be done on the same host meaning the same command line
parameters.  If you migrate to a different host you need the socket to
point back to the host serving the vTPM.

To do this easily you simply keep the vTPM running while the VM is
undergoing snapshot and migration.  If you're thinking of and extended
down time for the snapshot, then it's up to the vTPM implementation to
store the state (or simply keep it running for an extended time doing
nothing).


> Rest LGTM.

Thanks!

Regards,

James


