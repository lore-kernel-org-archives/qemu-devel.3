Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE72C531F9
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvAX-0002fE-JB; Thu, 23 Jul 2026 11:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmvAA-0002eD-Ue
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmvA7-0007go-Bz
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784819797;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enhLSCDm+JTvTkDF94wbrSZR+KPQTNZKlc2ClwZQM5E=;
 b=hVZjWKqMt3/Y5rNsaYeiz5ntTx8ywVUwkKQdqGzcdmGIEEE8V2iNJGGUhdTaYJidJUrsbK
 RELmfPqK94moHxhBjabWURIce4/AIzg/xAXY405+x+ZJkeR/dzaskSPCxC8TD9uvo1PmCH
 u0bsshNNJlfN+ZAlJyVe69Dx9FRZFX0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-I4kGMtJkMM-ftGmudo5brA-1; Thu,
 23 Jul 2026 11:16:33 -0400
X-MC-Unique: I4kGMtJkMM-ftGmudo5brA-1
X-Mimecast-MFC-AGG-ID: I4kGMtJkMM-ftGmudo5brA_1784819792
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FB4D1954B25; Thu, 23 Jul 2026 15:16:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFF54196B09F; Thu, 23 Jul 2026 15:16:29 +0000 (UTC)
Date: Thu, 23 Jul 2026 16:16:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] hw/display/vmware_vga: Don't allow guest to trigger
 long running loop in host
Message-ID: <amIwSvAAv-LWbmYT@redhat.com>
References: <20260723124432.353969-1-thuth@redhat.com>
 <28b3741f-3cab-4e7c-b830-01fad0d80d35@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28b3741f-3cab-4e7c-b830-01fad0d80d35@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 23, 2026 at 03:54:41PM +0200, Philippe Mathieu-Daudé wrote:
> On 23/7/26 14:44, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> > 
> > The code in the SVGA_CMD_DEFINE_ALPHA_CURSOR handler in vmsvga_fifo_run()
> > basically does:
> > 
> >              x = vmsvga_fifo_read(s);
> >              y = vmsvga_fifo_read(s);
> >              args = x * y;
> >              goto badcmd;
> >              ...
> > badcmd:
> >              len -= args;
> >              if (len < 0) {
> >                  goto rewind;
> >              }
> >              while (args--) {
> >                  vmsvga_fifo_read(s);
> >              }
> > 
> > Thus by supplying huge values for x and y that overflow the result of
> > the multiplication, the guest can trigger a long-running loop here
> > that burns the host's CPU cycles.
> > 
> > Add some sanity checks so that this cannot happen anymore.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3782
> > Reported-by: Feifan Qian <bea1e@proton.me>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4026
> > Reported-by: Tristan Madani <tristan@talencesecurity.com>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4076
> > Reported-by: Sunday Jiang
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   v2: Use SVGA_MAX_WIDTH and SVGA_MAX_HEIGHT instead of an arbitrary value
> > 
> >   hw/display/vmware_vga.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
> > index f6f9edfd1d9..567806f0e47 100644
> > --- a/hw/display/vmware_vga.c
> > +++ b/hw/display/vmware_vga.c
> > @@ -737,6 +737,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
> >               vmsvga_fifo_read(s);
> >               x = vmsvga_fifo_read(s);
> >               y = vmsvga_fifo_read(s);
> > +            if (x < 0 || x >= SVGA_MAX_WIDTH ||
> > +                y < 0 || y >= SVGA_MAX_HEIGHT) {
> 
> vmsvga_fifo_read() returns unsigned... otherwise:

But x & y  are declared 'int', so at least on 32-bit builds
a large uint32_t value would wrap and become negative.
Although we dropped support for 32-bit platforms, IMHO it would
be better to use uint32_t for 'x' and 'y' too rather than
assuming the 'int' value won't be negative.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> > +                goto rewind;
> > +            }
> >               args = x * y;
> >               goto badcmd;
> >           case SVGA_CMD_RECT_ROP_FILL:
> > @@ -776,7 +780,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
> >               if (len < 0) {
> >                   goto rewind;
> >               }
> > -            while (args--) {
> > +            while (args-- > 0) {
> >                   vmsvga_fifo_read(s);
> >               }
> >               printf("%s: Unknown command 0x%02x in SVGA command FIFO\n",
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


