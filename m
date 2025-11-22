Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827B3CFC531
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 12:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMmet-0000PX-JI; Sat, 22 Nov 2025 07:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vMmeh-0000KX-Vs
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 07:23:57 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vMmeZ-0000lB-BW
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 07:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=0J9T8jKan2XZotNTCzEAbhOJeFlORFCDGA2GHoJYyEI=; b=b2SDN1vsEBnzXN3WYNKr29rfJs
 FlwpGx7IYvpiUzU6+oeLISTIUA/3ew79THhDzrAe3uNdDRnpL/HX0Or5Lfqv5vceJPaRI3tz+j4BY
 1mVPX2Q9PqOhAKNXW3jSuPRPS6YU2Yhzwqk/5I4MZjGOPBwAGC+P6SpkctrRcSjDVtbUisrVOUHpO
 xZp3VXHhL0dfX20lh+oofdpgkKRvPhoPi9dnpULIozL+HVQhDBBnfTzpE8gjAzSWKvGTE8j88d1HF
 Rg8tcVQnaS+8q+IlppH7DAAn0/VtAGUhrucwExEStY1xfL7IpDZHI0PtLvv1tKZsn7gCED+yyUUIM
 xsVK6OqEX0EsCUVbk86DMjb1NSBxPmHJJtQ/1S0Yyofl7mxr8UabCIKCDd0Bdj++7SubG78yKV+Lr
 bCMzpzX0bMwMIq+z5EHOqNIvoLpEfUKB97B84doH+x0lrFj6wCgZ1BfjjMK5YoRVN/S2gdCqTlSxp
 qOKC/jQtJUxtwRm3MRHqSIwPNAFhmP4LhUlYBC3Bs6k8FLpYFKHlguM8sUd1EREbfnk6PdjNG/laU
 0MczrnGnDhxe40183F/eUCmpZwgDtaOPvbOCxbMV9D0EFDko5/5RSaGweCxOcNmcDPuoytnua8WVc
 yCFaSymwOyCmiRLgaehseX4+INzyjNOonkRNewLw4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Andrey Erokhin <language.lawyer@gmail.com>
Subject: Re: [PATCH] hw/9pfs: Follow native symlinks when security-model=mapped
Date: Sat, 22 Nov 2025 13:23:29 +0100
Message-ID: <4694008.LvFx2qVVIh@weasel>
In-Reply-To: <f5fee3f9-9075-4d73-96b2-5d026500e295@gmail.com>
References: <5e07267f-b990-47fc-ade7-934209ea942f@gmail.com>
 <13890690.uLZWGnKmhe@weasel>
 <f5fee3f9-9075-4d73-96b2-5d026500e295@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Friday, 21 November 2025 19:32:14 CET Andrey Erokhin wrote:
> On 21/11/2025 17:20, Christian Schoenebeck wrote:
> > Andrey, just some minor issues from my side below:
> > 
> > Git commit log message should not exceed 76 characters per line.
> 
> TBH, I'm not used to sending patches by git, it was just an e-mail message,
> not a commit message

NP. You can use whatever you want (git send-email, any standard email client, 
a script). However patches are automatically applied from this mailing list, 
so the leading sentences of your email *is* the git commit log message.

> >> QEMU issues:
> >> https://gitlab.com/qemu-project/qemu/-/issues/173 (from
> >> https://bugs.launchpad.net/qemu/+bug/1831354)
> >> https://gitlab.com/qemu-project/qemu/-/issues/3088 (dup of the first one)
> > 
> > This should be:
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/173
> 
> Fixed in the attached patch. Or should I start a new [PATCH v2] thread?

Please resend with [PATCH v2] in the subject. Patches should always be inline 
in the email, not as an attachment, and new versions should be top posted 
(i.e. not In-Reply-To v1 email).

/Christian



