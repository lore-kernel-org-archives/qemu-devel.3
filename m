Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60025CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGhxx-0006sK-My; Tue, 13 Oct 2026 15:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGhxt-0006qt-17
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGhxq-0006uR-K3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791918906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6pQItpLNj9iHG8udG2WFaVAMclVzFKxcOVXOagydeUg=;
 b=CaloqABfIpsMYdRUxQLAkB0Nk3G0YF8LeTBUUoDGpttHhsOZ69T8/S2V0ZQK0Jmq9nyk+r
 dD/UL9frb38ePIXBw3Whn/m0aypxUX8RInOKpQo7lyHGHV+OlaoZdxUFv2WvYd5MGkJRHv
 WkoOgjRbgccFqowwip8ftFM73+MEcME=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-b4MJXhOvNeSmTQlrHQOJBg-1; Tue,
 13 Oct 2026 19:15:01 +0000
X-MC-Unique: b4MJXhOvNeSmTQlrHQOJBg-1
X-Mimecast-MFC-AGG-ID: b4MJXhOvNeSmTQlrHQOJBg_1791918900
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCBCD180A365; Tue, 13 Oct 2026 19:14:59 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 194C23001D29; Tue, 13 Oct 2026 19:14:57 +0000 (UTC)
Date: Tue, 13 Oct 2026 14:14:55 -0500
From: Eric Blake <eblake@redhat.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] iotests/108: probe loop device setup
Message-ID: <as6CpVowfVzuYTMy@redhat.com>
References: <20261013182804.103882-1-iii@linux.ibm.com>
 <as59GEf23kbWM-Kc@redhat.com>
 <83590b67-3a00-4534-a4e8-9ccf335ddf31@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83590b67-3a00-4534-a4e8-9ccf335ddf31@linux.ibm.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 13, 2026 at 09:08:17PM +0200, Ilya Leoshkevich wrote:
> 
> 
> On 10/13/26 20:53, Eric Blake wrote:
> > On Tue, Oct 13, 2026 at 08:28:00PM +0200, Ilya Leoshkevich wrote:
> > > Running iotests/108 in a Docker container, that has passwordless sudo
> > > configured, fails with:
> > > 
> > >      losetup: /home/user/src/qemu/build/scratch/qcow2-file-108/t.qcow2: failed to set up loop device: No such file or directory
> > > 
> > > because it incorrectly assumes losetup is allowed to do loop device
> > > setup, when in reality it can only list devices.
> > > 
> > > Fix by probing loop device setup, using the test script as a backing
> > > file. With this, the test is correctly skipped.
> > > 
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >   tests/qemu-iotests/108 | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
> > > index 1de718188aa..adbaaf87095 100755
> > > --- a/tests/qemu-iotests/108
> > > +++ b/tests/qemu-iotests/108
> > > @@ -53,7 +53,8 @@ _supported_os Linux
> > >   _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)' data_file
> > >   # This test either needs sudo -n losetup or FUSE exports to work
> > > -if sudo -n losetup &>/dev/null; then
> > > +if probe_dev=$(sudo -n losetup -r --show -f "$0" 2>/dev/null); then
> > > +    sudo -n losetup -d "$probe_dev"
> > 
> > Is 'sudo -n losetup -f' a simpler test?  It prints out the next
> > /dev/loopN value available only if a mount would succeed, which means
> > that it is a stronger test than the existing 'sudo -n losetup', but
> > also does not require a subsequent cleanup.
> 
> I don't think 'losetup -f' attempts a mount, since it works fine without
> privileges:
> 
> $ id -u
> 1000
> $ losetup -f
> /dev/loop0
> $ losetup -r -f /bin/true
> losetup: /bin/true: failed to set up loop device: Permission denied

Thanks for testing. In that case, I think your longer version is reasonable.

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> A quick glance at the source code [1] seems to confirm this: the
> iterator is immediately discarded after finding a free device name.
> The loop-control logic above looks similar.
> 
> [1]
> https://github.com/util-linux/util-linux/blob/v2.42.4/lib/loopdev.c#L1760
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


