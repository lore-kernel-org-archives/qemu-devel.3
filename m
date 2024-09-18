Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2FFCDD55D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 22:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr39h-0001n2-4c; Wed, 18 Sep 2024 18:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=hBtn=QQ=zx2c4.com=Jason@kernel.org>)
 id 1sr39e-0001km-RL
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 18:28:10 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=hBtn=QQ=zx2c4.com=Jason@kernel.org>)
 id 1sr39c-0001jf-QY
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 18:28:10 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7DD405C4C5F;
 Wed, 18 Sep 2024 22:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFFBC4CEC2;
 Wed, 18 Sep 2024 22:28:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="DqMCBf/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1726698481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zWmjdRBT0ivUDXNAnsZ9bumBL4RE93ccXi0XEeAeoT0=;
 b=DqMCBf/B5uJIiTmJrKVJFMDkraiFYgXBFcz+QJrZMm3PMEoRiytvqI72S5twJq+Jb1HvEV
 hzEASuovnk20zW5Jrn7aWqq12gxvM6U1ImGn6rowC8n5kpWGQSw7rwy202a4SGLHB13BTa
 VNjg8CfPrmqrOaKxaHuQIfX3o04kK7c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ca5a12b2
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 18 Sep 2024 22:28:00 +0000 (UTC)
Date: Thu, 19 Sep 2024 00:27:57 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Alexander Graf <graf@amazon.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Lennart Poettering <mzxreary@0pointer.de>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
 "Cali, Marco" <xmarcalx@amazon.co.uk>, Arnd Bergmann <arnd@arndb.de>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 Christian Brauner <brauner@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 Sean Christopherson <seanjc@google.com>, jann@thejh.net
Subject: vm events, userspace, the vmgenid driver, and the future [was: the
 uevent revert thread]
Message-ID: <ZutT7bArzCwW5yyf@zx2c4.com>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
 <ZieoRxn-On0gD-H2@gardel-login>
 <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>
 <Ziujox51oPzZmwzA@zx2c4.com> <Zi9ilaX3254KL3Pp@gardel-login>
 <01d2b24c-a9d2-4be0-8fa0-35d9937eceb4@amazon.com>
 <CAHmME9rxn5KJJBOC3TqTEgotnsFO5r6F-DJn3ekc5ZgW8OaCFw@mail.gmail.com>
 <84c3696d-8108-4a2e-90d7-7830ca6cc3b9@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84c3696d-8108-4a2e-90d7-7830ca6cc3b9@amazon.com>
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=SRS0=hBtn=QQ=zx2c4.com=Jason@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

[broadened subject line and added relevant parties to cc list]

On Tue, Sep 17, 2024 at 10:55:20PM +0200, Alexander Graf wrote:
> What is still open are user space applications that require event based 
> notification on VM clone events - and *only* VM clone events. This 
> mostly caters for tools like systemd which need to execute policy - such 
> as generating randomly generated MAC addresses - in the event a VM was 
> cloned.
> 
> That's the use case this patch "vmgenid: emit uevent when VMGENID 
> updates" is about and I think the best path forward is to just revert 
> the revert. A uevent from the device driver is a well established, well 
> fitting Linux mechanism for that type of notification.

The thing that worries me is that vmgenid is just some weird random
microsoft acpi driver. It's one sort of particular device, and not a
very good one at that. There's still room for virtio/qemu to improve on
it with their own thing, or for vbox or whatever else to have their
version, and xen theirs, and so forth. That is to say, I'm not sure that
this virtual hardware is *the* way of doing it.

Even in terms of the entropy stuff (which I know you no longer care
about, but I do), mst's original virtio-rng draft mentioned reporting
events beyond just VM forks, extending it generically to any kind of
entropy reduction situation. For example, migration or suspend or
whatever might be interesting things to trigger. Heck, one could imagine
those coming through vmgenid at some point, which would then change the
semantics you're after for systemd.

Even in terms of reporting exclusively about external VM events, there's
a subtle thing to consider between clones/forks and rollbacks, as well
as migrations. Vmgenid kind of lumps it all together, and hopefully the
hypervisor notifies in a way consistent with what userspace was hoping
to learn about. (Right now, maybe we're doing what Hyper-V does, maybe,
but also maybe not; it's kind of loose.) So at some point, there's a
question about the limitations of vmgenid and the possible extensions of
it, or whether this will come in a different driver or virtual hardware,
and how.

Right now, this is mostly unexplored. The virtio-rng avenue was largest
step in terms of exploring this problem space, but there are obviously a
few directions to go, depending on what your primary concern is.

But all of that makes me think that exposing the particulars of this
virtual hardware driver to userspace is not the best option, or at least
not an option to rush into (or to trick Greg into), and will both limit
what we can do with it later, and potentially burden userspace with
having to check multiple different things with confusing interactions
down the road. So I think it's worth stepping back a bit and thinking
about what we actually want from this and what those semantics should
be.

I'd also love to hear from the QEMU guys on this and get their input. To
that end, I've added qemu and virtio mailing lists, as well as mst.

Also, I'd be interested to learn specifically what you (Amazon) want
this for and what the larger picture there is. I get the systemd case,
but I'm under the assumption you've got a different project in your
woods.

Jason

