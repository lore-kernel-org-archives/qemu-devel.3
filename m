Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF9FC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqq9-0005Yt-87; Thu, 10 Jul 2025 08:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1uZqpP-0005F4-St
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:56:44 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1uZqpO-0006qY-F4
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:56:43 -0400
Received: from movement by movementarian.org with local (Exim 4.97)
 (envelope-from <movement@movementarian.org>)
 id 1uZqpK-00000008YqN-1wXo; Thu, 10 Jul 2025 13:56:38 +0100
Date: Thu, 10 Jul 2025 13:56:38 +0100
From: John Levon <levon@movementarian.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PULL 08/25] vfio-user: connect vfio proxy to remote server
Message-ID: <aG-4hkfLDEpDsqo6@movementarian.org>
References: <20250626074529.1384114-1-clg@redhat.com>
 <20250626074529.1384114-9-clg@redhat.com>
 <CAFEAcA9qtR40k6KAiMk2ij4kArVSdLJAH+zRVnTxaVOhOYr1jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9qtR40k6KAiMk2ij4kArVSdLJAH+zRVnTxaVOhOYr1jw@mail.gmail.com>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On Thu, Jul 10, 2025 at 01:33:17PM +0100, Peter Maydell wrote:

> On Thu, 26 Jun 2025 at 08:51, Cédric Le Goater <clg@redhat.com> wrote:
> >
> > From: John Levon <john.levon@nutanix.com>
> >
> > Introduce the vfio-user "proxy": this is the client code responsible for
> > sending and receiving vfio-user messages across the control socket.
> >
> > The new files hw/vfio-user/proxy.[ch] contain some basic plumbing for
> > managing the proxy; initialize the proxy during realization of the
> > VFIOUserPCIDevice instance.
> 
> Hi; Coverity points out an issue with this code (CID 1611806):

Cédric sent me the reports separately. They are (as far as I'm able to tell
without a coverity login) all false positives, except the uninitialized variable
one which I have sent a patch for.

The locking reports don't realize the proxy->lock is already held.

> > +     * Make sure the iothread isn't blocking anywhere
> > +     * with a ref to this proxy by waiting for a BH
> > +     * handler to run after the proxy fd handlers were
> > +     * deleted above.
> > +     */
> > +    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
> > +    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
> 
> qemu_cond_wait() has essentially the same semantics as
> pthread_cond_wait(), for which it is a wrapper.
> pthread_cond_wait() is allowed to wake up spuriously, so
> any use of it must be in a loop that checks for whatever
> the actual thing you were waiting for was:
>   while (something) {
>       qemu_cond_wait(...);
>   }
> 
> What is the condition this code should be checking ?

But rethinking about this one, it's theoretically possible, I suppose, if we
happen get a signal before we actually close. I'll figure out a patch, thanks.

regards
john

