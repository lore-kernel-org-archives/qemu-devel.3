Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7D8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHMoW-0004XZ-06; Fri, 07 Nov 2025 08:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHMoI-0004U1-Sy
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHMoG-0007Rz-Ox
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762523243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fdbq7J/h4wv0hUcx9iKFa0MCoNSx5idQuCGZSu1mMU8=;
 b=NpMRlt/3mHE/blQBv/QnH3jPB/EV8sm3xCAbOtx+Y0c3oejlEliqYeqRJNksE+t4xDhL4H
 Zh6QAxE04cFmYRP8EwtUEtV2lpV5J2SaOXHKKLSNot0fas7WkwErTkEx15uLWGPdCScF6h
 qA02DucajVR/H7r631f++eLGjQH1FDA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-da3zFN-bNTejuiMt8LubmA-1; Fri,
 07 Nov 2025 08:47:22 -0500
X-MC-Unique: da3zFN-bNTejuiMt8LubmA-1
X-Mimecast-MFC-AGG-ID: da3zFN-bNTejuiMt8LubmA_1762523241
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12934180028A; Fri,  7 Nov 2025 13:47:21 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.87])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A5FB19560A7; Fri,  7 Nov 2025 13:47:18 +0000 (UTC)
Date: Fri, 7 Nov 2025 07:47:16 -0600
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH 5/8] qio: Let listening sockets remember their owning
 QIONetListener
Message-ID: <shwq3okkzyii6s7baffpwdqhy66xjgtcbj7z6htge7ok2hpdqc@fhcn3kv4mfr6>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-15-eblake@redhat.com>
 <3nyd5oqiiy5egwfuup4ibnw5kgb555ijshpiafax3xdjgvcy6b@a7qwjdlkpuwi>
 <tbqcxj4r75324cdzbqrtvpxmaciydtwdg2gflmbtvgvt33ur55@nrrnhgg3ztjk>
 <aQ2r_Qx67zt8MMwg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ2r_Qx67zt8MMwg@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 07, 2025 at 08:50:16AM +0000, Daniel P. Berrangé wrote:

> > > > +++ b/include/io/channel-socket.h
> > > > @@ -49,6 +49,7 @@ struct QIOChannelSocket {
> > > >      socklen_t remoteAddrLen;
> > > >      ssize_t zero_copy_queued;
> > > >      ssize_t zero_copy_sent;
> > > > +    struct QIONetListener *listener;
> > > 
> > > Commenting on my own patch:
> > > 
> > > After re-reading docs/devel/style.rst, I can see that this particular
> > > forward declaration of QIONetListener is not consistent with the
> > > guidelines.  I have to have a forward reference, since the style guide
> > > also forbids circular inclusion (net-listener.h already includes
> > > channel-socket.h, so channel-socket.h cannot include net-listener.h);
> > > but it may be better for me to move the forward reference into
> > > include/qemu/typedefs.h rather than inlining it how I did here.
> > 
> > Then again, include/qemu/typedefs.h states "For struct types used in
> > only a few headers, judicious use of the struct tag instead of the
> > typedef name is commonly preferable."
> > 
> > So, to keep it simpler, I'll just justify my choice in the commit message.
> 
> I would really rather we avoided the bi-directional pointer linkage
> entirely. AFAICT, this is only required because the later patch is
> passing a QIOChannelSocket as the opaque data parametr for a callback.
> 
> It would be preferrable if we would instead pass a standalonme data
> struct containing the QIOChannelSocket + QIONetListener, and then
> avoid this back-linkage.

Reasonable; a bit more verbose in net-listener.c, but less impact to
channel-socket.h, so I'll do that in v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


