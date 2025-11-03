Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F66CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFtK9-0005Wq-70; Mon, 03 Nov 2025 07:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1vFtK3-0005WX-Lw
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:06:07 -0500
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1vFtJx-00021M-Iw
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:06:06 -0500
Received: from movement by movementarian.org with local (Exim 4.97)
 (envelope-from <movement@movementarian.org>)
 id 1vFtJo-000000060yZ-29a7; Mon, 03 Nov 2025 12:05:52 +0000
Date: Mon, 3 Nov 2025 12:05:52 +0000
From: John Levon <levon@movementarian.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PULL 09/25] vfio-user: implement message receive infrastructure
Message-ID: <aQiaoBcgnwJEYG5j@movementarian.org>
References: <20250626074529.1384114-1-clg@redhat.com>
 <20250626074529.1384114-10-clg@redhat.com>
 <CAFEAcA9+EyeWE0QSUhgd7+i3din8J76jnhTuDB7i9hu3x-urOg@mail.gmail.com>
 <CAFEAcA88jVL4Qwb4MEzdcqeXDjob1NZ3-k_ZtwPCgG+9U6fkNA@mail.gmail.com>
 <aQDKmM2FFKAusenB@movementarian.org>
 <CAFEAcA-cLQTTeuwcCfYRXwv-434_mttDO0oXr_UuaOmkHX370w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-cLQTTeuwcCfYRXwv-434_mttDO0oXr_UuaOmkHX370w@mail.gmail.com>
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

On Mon, Nov 03, 2025 at 11:34:36AM +0000, Peter Maydell wrote:

> > > > Hi; Coverity suggests there are some issues with this code
> > > > (CID 1611807, 1611808, 1611809):
> > >
> > > Hi; it looks like 1611807 and 1611808 (the resource leaks)
> > > are still present in this code in current git; would somebody
> > > like to have a look at this?
> >
> > Please see https://lore.kernel.org/qemu-devel/aG-4hkfLDEpDsqo6@movementarian.org/
> >
> > I believe them to be false positives.
> 
> That email only seems to talk about the locking issue (1611806,
> 1611809) which we've marked as false-positives in Coverity.
> But 1611807 and 1611808 are "failed to free resources" issues:
> we allocate memory into reqfds and msg, but in the error
> exit path (e.g. if we "goto fatal" because qio_channel_read()
> failed) it doesn't look like we ever free that memory.

Sorry, I should have pasted: Here was my reply to Cédric below.

Looking at it with fresh eyes, though, I'm not so sure, at least in the case we
alloc instead of freelist, we need some form of recycle on the error path. The
whole function needs a big refactor for clarity...

> *** CID 1611808:         Resource leaks  (RESOURCE_LEAK)
> /builds/qemu-project/qemu/hw/vfio-user/proxy.c: 411             in vfio_user_recv_one()
> 405         if (isreply && msg != NULL) {
> 406             /* force an error to keep sending thread from hanging */
> 407             vfio_user_set_error(msg->hdr, EINVAL);
> 408             msg->complete = true;
> 409             qemu_cond_signal(&msg->cv);
> 410         }
> > > >     CID 1611808:         Resource leaks  (RESOURCE_LEAK)
> > > >     Variable "reqfds" going out of scope leaks the storage it points to.
> 411         return -1;

vfio_user_getmsg() I think takes ownership of reqfds so this looks OK.
It's hard to say without the full analysis.

> /builds/qemu-project/qemu/hw/vfio-user/proxy.c: 411             in vfio_user_recv_one()
> 405         if (isreply && msg != NULL) {
> 406             /* force an error to keep sending thread from hanging */
> 407             vfio_user_set_error(msg->hdr, EINVAL);
> 408             msg->complete = true;
> 409             qemu_cond_signal(&msg->cv);
> 410         }
> > > >     CID 1611807:         Resource leaks  (RESOURCE_LEAK)
> > > >     Variable "msg" going out of scope leaks the storage it points to.
> 411         return -1;
> 412     }

Same as above.

regards
john

