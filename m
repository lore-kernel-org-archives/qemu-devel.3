Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBE8D4694F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 15:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viaZ4-0008KJ-Fj; Wed, 21 Jan 2026 10:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viaYz-0008JF-0L
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 10:56:10 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viaYv-0006SS-Dw
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 10:56:07 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BC8D06012A;
 Wed, 21 Jan 2026 15:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D39FC19421;
 Wed, 21 Jan 2026 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769010963;
 bh=4TjTjYI5qR9thP/obItWoU71Z8KkvxTl9t5zRG4RR5k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QkUVZ36E5w2sLGxbh3/taWHHURUcuKKboV/ZtrW/yEh2VzFNYvV2EZPbYA6R6VTyw
 y5fjCUv6tH8FNm9ZR3BsvhgsfVqfzpEPJSWN4+55wQXtekhY0tu7XAcTxhgcmfBhXC
 NzGJwKXHYGZ93og0AyyDQ03UrqZUDoyAmXZc+mybzMELhGikjN6P4lJQAwjqwSM1us
 zVO2f70Gl+z+jpGsXWh1X/vnZ7PXMDERYv1Or+yDUufXkCMc/CB0OEnXXFIaB89jT/
 g2b0/LP4T+3l7Bs74e9mOW5ADbizV2I/c0YwaaFWYbSzjtJhxDbb6MdTaSIt/Tov/0
 NI8PxviOxVsQw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1viaYq-00000003t6V-24Zc; Wed, 21 Jan 2026 16:56:00 +0100
Date: Wed, 21 Jan 2026 16:56:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Michael S Tsirkin <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-devel@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 06/13] scripts/qmp_helper: add support for a timeout logic
Message-ID: <aXD1Nb4MU2XYI0HL@foz.lan>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <2539e524dd467af51f8286bd1b201feaad06c81e.1768993993.git.mchehab+huawei@kernel.org>
 <20260121123927.00001daa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121123927.00001daa@huawei.com>
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 21, 2026 at 12:39:27PM +0000, Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 12:25:14 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > We can't inject a new GHES record to the same source before
> > it has been acked. There is an async mechanism to verify when
> > the Kernel is ready, which is implemented at QEMU's ghes
> > driver.
> > 
> > If error inject is too fast, QEMU may return an error. When
> > such errors occur, implement a retry mechanism, based on a
> > maximum timeout.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> A few trivial comments below. Either way this seems fine to me and
> should make the tooling easier to use.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > ---
> >  scripts/qmp_helper.py | 47 +++++++++++++++++++++++++++++++------------
> >  1 file changed, 34 insertions(+), 13 deletions(-)
> > 
> > diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> > index 40059cd105f6..63f3df2d75c3 100755
> > --- a/scripts/qmp_helper.py
> > +++ b/scripts/qmp_helper.py
> > @@ -14,6 +14,7 @@
> >  
> >  from datetime import datetime
> >  from os import path as os_path
> > +from time import sleep
> >  
> >  try:
> >      qemu_dir = os_path.abspath(os_path.dirname(os_path.dirname(__file__)))
> > @@ -324,7 +325,8 @@ class qmp:
> >      Opens a connection and send/receive QMP commands.
> >      """
> >  
> > -    def send_cmd(self, command, args=None, may_open=False, return_error=True):
> > +    def send_cmd(self, command, args=None, may_open=False, return_error=True,
> > +                 timeout=None):
> >          """Send a command to QMP, optinally opening a connection"""
> >  
> >          if may_open:
> > @@ -336,12 +338,31 @@ def send_cmd(self, command, args=None, may_open=False, return_error=True):
> >          if args:
> >              msg['arguments'] = args
> >  
> > -        try:
> > -            obj = self.qmp_monitor.cmd_obj(msg)
> > -        # Can we use some other exception class here?
> > -        except Exception as e:                         # pylint: disable=W0718
> > -            print(f"Command: {command}")
> > -            print(f"Failed to inject error: {e}.")
> > +        if timeout and timeout > 0:
> > +            attempts = int(timeout * 10)
> > +        else:
> > +            attempts = 1
> > +
> > +        # Try up to attempts
> That reads oddly because of the variable name.  Made me ask myself
> "How many attempts?"
> Maybe  " Retry up to attempts times" or something like that.

I'll improve the message. The goal here is to try up to at least 
timeout" seconds.

That's why we multiply it by 10...

> 
> > +        for i in range(0, attempts):
> > +            try:
> > +                obj = self.qmp_monitor.cmd_obj(msg)
> > +
> > +                if obj and "return" in obj and not obj["return"]:
> > +                    break
> > +
> > +            except Exception as e:                     # pylint: disable=W0718
> > +                print(f"Command: {command}")
> > +                print(f"Failed to inject error: {e}.")
> > +                obj = None
> > +
> > +            if attempts > 1:
> > +                print(f"Error inject attempt {i + 1}/{attempts} failed.")
> > +
> > +            if i + 1 < attempts:
> > +                sleep(0.1)

... and here, we sleep for 0.1 seconds.

> 
> Do we care about a sleep at the end?  Feels like a micro optimization that
> isn't needed.

This is not a micro-optimization. It is more to ensure that we won't
respin it too fast.

What happens is that QMP interface asks the BIOS to send an async
message to OSPM, cleaning an ack register. When the OSPM reads the
error, it writes 1 to the ack register.

If we send messages too fast, the logic at ghes.c will detect that
the ack didn't happen, imediately returning an errocr code.

On such case, we sleep for 100ms before trying again.

In practice, on my Ryzen 9 machines with QEMU emulating ARM,
even under massive error injection, 99% of the time no retries
happen. The worse case scenario I got here is that sometimes
Kernel got stuck and took between 5s to 10s to accept the error
submission.

> 
> > +
> > +        if not obj:
> >              return None
> 
> 

-- 
Thanks,
Mauro

