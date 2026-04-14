Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0438BF9D0EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wChqN-0007BI-KT; Tue, 14 Apr 2026 13:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wChqL-0007Ak-Vv
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 13:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wChqJ-0005qV-8A
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 13:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776188788;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8i//lCPbqSQI2wwFqteQhbNktHcAh6x7fp8bX53YhQ=;
 b=MzJL4IZRtPkIcngmM5reWoJlHKhLf3R3nZ7+hOcH53O35jyu4QmgfSpwU2fPDMzpR1K/OQ
 8WvAnJlFQsSvb1PHIsBub1FZfE/W3Yqs8jV0Fw4ibyxsKpt3WQwlO6g042b8Gv5SIWeWTA
 PGoOTD+QvxzbCODPN+CBOdpLJHlMJeg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-zhJmOYoePtu-P-oR58bRgA-1; Tue,
 14 Apr 2026 13:46:22 -0400
X-MC-Unique: zhJmOYoePtu-P-oR58bRgA-1
X-Mimecast-MFC-AGG-ID: zhJmOYoePtu-P-oR58bRgA_1776188781
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 786D118002F7; Tue, 14 Apr 2026 17:46:21 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E777A1955D88; Tue, 14 Apr 2026 17:46:19 +0000 (UTC)
Date: Tue, 14 Apr 2026 18:46:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Cathy Hu <cathy.hu@suse.com>, qemu-devel@nongnu.org,
 Cathy Hu <cahu@suse.de>, Fabiano Rosas <fabiano.rosas@suse.com>
Subject: Re: [PATCH RFC] qga: Add selinux-helper for guest-exec subcommand
 (bsc#1237450)
Message-ID: <ad59aPHDUueFq2z7@redhat.com>
References: <20260327102515.502822-5-cathy.hu@suse.com>
 <acaVRtE-NPUa5Ujy@redhat.com>
 <3d54a532eb5b3111d8f8849458a009493d3d8845.camel@suse.com>
 <ad5ypLQMlHQm6ATh@redhat.com>
 <db21d9d4fd3a1489d5a25d7b7f0c49e3787ee9af.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db21d9d4fd3a1489d5a25d7b7f0c49e3787ee9af.camel@suse.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 14, 2026 at 07:13:14PM +0200, Martin Wilck wrote:
> On Tue, 2026-04-14 at 18:00 +0100, Daniel P. Berrangé wrote:
> > On Tue, Apr 14, 2026 at 06:51:12PM +0200, Martin Wilck wrote:
> > 
> > 
> > > > If users want to support an ability to have arbitrary command
> > > > execution, then that should be done with SSH over VSock, where
> > > > the guest owner can choose whether to require authentication
> > > > first or not, and use SSH authorized_keys if desired to limit
> > > > what commands can be run for a given recorded key.
> > > > 
> > > > These days systemd installs magic to allow SSH'ing directly
> > > > to a guest using VSOCK addresses, and libvirt further
> > > > enhances that to allow SSH'ing to a named VM.
> > > 
> > > Thanks, I wasn't aware of this feature so far. I suppose you're
> > > referring to https://libvirt.org/ssh-proxy.html. I'll need to
> > > experiment with it. IIUC this works for local libvirt connections
> > > only?
> > 
> > Yes, vsock is exposed to the local host.
> 
> And it can't / won't be implemented for remote hosts?

That doesn't make sense conceptually. Think of VSOCK as the equivalent
of a UNIX domain socket, but between host & guest.  If you want off
node access, then IP sockets are what you want, either directly from
the guest, or tunnelled to VSOCK via the host.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


