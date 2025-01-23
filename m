Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C210C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 16:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tazk8-0000jz-FJ; Thu, 23 Jan 2025 11:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1tazjw-0000jJ-Bo
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 11:07:38 -0500
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1tazji-0007iP-Rk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 11:07:20 -0500
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1tazjd-00HMYx-Tu;
 Thu, 23 Jan 2025 16:07:13 +0000
Date: Thu, 23 Jan 2025 16:07:13 +0000
From: John Levon <levon@movementarian.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, elena.ufimtseva@oracle.com,
 alex.williamson@redhat.com, jag.raman@oracle.com,
 thanos.makatos@nutanix.com
Subject: Re: [v7 00/26] vfio-user client
Message-ID: <Z5JpMb00kKJ7YIN1@movementarian.org>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
 <Z5IV70w1qoR/EXid@movementarian.org>
 <5ea637ad-c108-4fa9-854a-e36ef0294b33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ea637ad-c108-4fa9-854a-e36ef0294b33@redhat.com>
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

On Thu, Jan 23, 2025 at 02:50:16PM +0100, Cédric Le Goater wrote:

> > > Hi, this is the 7th revision of the vfio-user client implementation.
> 
> Well, among the reasons why we tend to push this at end of
> the list are :

Thanks for the steers. Just a note in case you're not aware - most of these
changes weren't authored by me, I'm in the position of picking up someone else's
series. I hope you'll bear with me in this respect.

>   - the respins are spaced over time (1 a year ?)

Understandable, I will certainly make time to be more responsive when I do get
review comments. The last spin got none, whereas the earlier ones sent out by
Oracle got a good amount of review.

You mentioned on IRC that it's worth me documenting previous reviews: I can
spelunk for that data, but it's worth pointing out that many of the patches have
changed significantly since previous reviews.

>   - it's invasive in an already very complex subsystem

As a qemu neophyte I would greatly appreciate suggestions on how to reduce this.
I think the user-container refactoring was a big one (we now barely touch the
other container types), but I'm definitely up for further suggestions.

>   - it's HUGE. See the diffstat below ...

Unavoidable right? The start of the series are generic preparation so could in
theory be merged separately. If you have other ways you'd prefer me to split
this up I'd be happy to do so.

FYI I tried sending out just the specification document (which reflects the
already-merged server side implementation) but did not get any reviews.

> I would introduce a new hw/vfio-user/ subsystem given the size.

Could you give me some further guidance? Are you talking about duplicating all
of the needed hw/vfio/pci.c code into hw/vfio-user/pci.c ?

Or do you just mean putting the new hw/vfio/user* files into hw/vfio-user/

> The commit logs are short. Most are one liners, this is really
> not much for such a big change.

The ones I've written have longer changelogs and I hope are better. I'll take
some time to rewrite the other authors' commit messages for the next cycle.

> Any how, I hope to take a look before the end of 10.0 cycle.

Thanks so much!

Would you prefer me to apply your above suggestions prior to you reviewing?

regards
john

