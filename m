Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22AFC531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmw9t-00005Z-Pw; Thu, 23 Jul 2026 12:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmw9q-0008WN-GX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmw9o-0001OA-S6
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784823624;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4n7lwqGkv7gGrvOnha76mLZu76PJ3Gb+lZDI3u8mAU=;
 b=GRkp/O/hqz0I7TymcoHEr3jbNxEeT3TYyTqof4N9rrM+MmpB7HqB62HeYV4qvIU6BltyR+
 NshZ/tEWJV1PR7hT/WJQg1f6/8w2qFZx8gm0QTSnfRtRWPo3b16/MBTiPEvoCWXUXmLZQ5
 SWhKDT1Z5z+/XgUnxiTcurCiTJkWgKk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-fr0jV-T2OYyTX3J6oJgiXQ-1; Thu,
 23 Jul 2026 12:20:21 -0400
X-MC-Unique: fr0jV-T2OYyTX3J6oJgiXQ-1
X-Mimecast-MFC-AGG-ID: fr0jV-T2OYyTX3J6oJgiXQ_1784823619
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7292A1956067; Thu, 23 Jul 2026 16:20:19 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C7E9159F; Thu, 23 Jul 2026 16:20:16 +0000 (UTC)
Date: Thu, 23 Jul 2026 17:20:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] hw/display/vmware_vga: Don't allow guest to trigger
 long running loop in host
Message-ID: <amI_PfSHixCEVZKN@redhat.com>
References: <20260723124432.353969-1-thuth@redhat.com>
 <28b3741f-3cab-4e7c-b830-01fad0d80d35@oss.qualcomm.com>
 <amIwSvAAv-LWbmYT@redhat.com>
 <7f8e11c2-f7ea-4362-9840-a295a7def315@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f8e11c2-f7ea-4362-9840-a295a7def315@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jul 23, 2026 at 06:18:28PM +0200, Thomas Huth wrote:
> On 23/07/2026 17.16, Daniel P. Berrangé wrote:
> > On Thu, Jul 23, 2026 at 03:54:41PM +0200, Philippe Mathieu-Daudé wrote:
> > > On 23/7/26 14:44, Thomas Huth wrote:
> > > > From: Thomas Huth <thuth@redhat.com>
> > > > 
> > > > The code in the SVGA_CMD_DEFINE_ALPHA_CURSOR handler in vmsvga_fifo_run()
> > > > basically does:
> > > > 
> > > >               x = vmsvga_fifo_read(s);
> > > >               y = vmsvga_fifo_read(s);
> > > >               args = x * y;
> > > >               goto badcmd;
> > > >               ...
> > > > badcmd:
> > > >               len -= args;
> > > >               if (len < 0) {
> > > >                   goto rewind;
> > > >               }
> > > >               while (args--) {
> > > >                   vmsvga_fifo_read(s);
> > > >               }
> > > > 
> > > > Thus by supplying huge values for x and y that overflow the result of
> > > > the multiplication, the guest can trigger a long-running loop here
> > > > that burns the host's CPU cycles.
> > > > 
> > > > Add some sanity checks so that this cannot happen anymore.
> > > > 
> > > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3782
> > > > Reported-by: Feifan Qian <bea1e@proton.me>
> > > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4026
> > > > Reported-by: Tristan Madani <tristan@talencesecurity.com>
> > > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4076
> > > > Reported-by: Sunday Jiang
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >    v2: Use SVGA_MAX_WIDTH and SVGA_MAX_HEIGHT instead of an arbitrary value
> > > > 
> > > >    hw/display/vmware_vga.c | 6 +++++-
> > > >    1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
> > > > index f6f9edfd1d9..567806f0e47 100644
> > > > --- a/hw/display/vmware_vga.c
> > > > +++ b/hw/display/vmware_vga.c
> > > > @@ -737,6 +737,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
> > > >                vmsvga_fifo_read(s);
> > > >                x = vmsvga_fifo_read(s);
> > > >                y = vmsvga_fifo_read(s);
> > > > +            if (x < 0 || x >= SVGA_MAX_WIDTH ||
> > > > +                y < 0 || y >= SVGA_MAX_HEIGHT) {
> > > 
> > > vmsvga_fifo_read() returns unsigned... otherwise:
> > 
> > But x & y  are declared 'int', so at least on 32-bit builds
> > a large uint32_t value would wrap and become negative.
> > Although we dropped support for 32-bit platforms, IMHO it would
> > be better to use uint32_t for 'x' and 'y' too rather than
> > assuming the 'int' value won't be negative.
> x and y are used as signed int all over the place here ... so reworking that
> goes way beyond fixing this problem. Could we please get this patch merged
> first for 11.1, and if someone then still feels like reworking the code,
> this could be done for 11.2 ?

Ok, then the < 0 checks should be kept.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


