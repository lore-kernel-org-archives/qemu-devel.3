Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD083C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 21:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTU7n-0003sC-VM; Fri, 26 Jan 2024 16:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rTU7m-0003s4-Fg
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 16:52:34 -0500
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rTU7j-00005r-Ej
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 16:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1706305945; bh=AFl7S6eapc/1WeaK73InImADkR4LS9FiIyob68oLHgE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Gq0e+gSfDx4sD3KHEXTG51fw2qu+u/JNA6yvkMHNM7kNV9pUmM4ZzTXIlI9PKk+V8
 gNu6By16hITXKuR2ATS9nVJZt5fJqwH3knkTrMfHQhxmuls5pTiFSBfGsHiKsDl1tR
 U50BrKZ719BbgwjZhTcGKuoJLnpnZBcWHwOZ0KLI=
Date: Fri, 26 Jan 2024 22:52:24 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: Re: [PATCH v4 4/4] hw/misc/pvpanic: add support for normal
 shutdowns
Message-ID: <79dc2259-125b-4f46-a80f-ab13ed935cb7@t-8ch.de>
References: <20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de>
 <20240107-pvpanic-shutdown-v4-4-81500a7e4081@t-8ch.de>
 <287bcc2b-3268-4622-a649-8ce6b7e4f8a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <287bcc2b-3268-4622-a649-8ce6b7e4f8a5@oracle.com>
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Alejandro,

On 2024-01-26 13:47:33-0500, Alejandro Jimenez wrote:
> On 1/7/24 09:05, Thomas Weißschuh wrote:
> > Shutdown requests are normally hardware dependent.
> > By extending pvpanic to also handle shutdown requests, guests can
> > submit such requests with an easily implementable and cross-platform
> > mechanism.
> > 
> > Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> > ---
> >   docs/specs/pvpanic.rst    | 2 ++
> >   hw/misc/pvpanic.c         | 5 +++++
> >   include/hw/misc/pvpanic.h | 3 ++-
> >   3 files changed, 9 insertions(+), 1 deletion(-)
> > 
> [snip]
> 
> >   -------------
> > diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> > index a4982cc5928e..246f9ae4e992 100644
> > --- a/hw/misc/pvpanic.c
> > +++ b/hw/misc/pvpanic.c
> > @@ -40,6 +40,11 @@ static void handle_event(int event)
> >           qemu_system_guest_crashloaded(NULL);
> >           return;
> >       }
> > +
> > +    if (event & PVPANIC_SHUTDOWN) {
> > +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> 
> I would suggest that instead of directly requesting a system shutdown,
> we should follow the same convention/handling of the other pvpanic
> events and emit a QMP message signaling the specific event that took
> place, to help a management layer application that might be listening
> to determine the cause of the shutdown. It can also be a helpful
> signal to let us know if a guest is (ab)using the new functionality.

This sounds reasonable, thanks for the suggestion and patch.

> If you agree with my reasoning and you'd allow me to piggyback on your
> series, please add my complementary [PATCH 5/4] change that implements
> the suggestion:

I picked up the patch and will test and resend the series in a few days.

[snip]

If one of the maintainers reads this:

Maybe patch 1, 2 and 3 could already be picked up as they seem not to be
controversial.
Then I can also continue to remove the UAPI header on the kernel side.

Thomas

