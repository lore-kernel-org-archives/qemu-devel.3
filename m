Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF63C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwjO-0000fA-PA; Fri, 14 Feb 2025 09:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tiwjM-0000ea-Le
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:31:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tiwjK-0006jC-Ov
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739543505;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWL0nI4rNtHZ9cbbI/JdEOzQpJrGRRA25hYzR2UbS0s=;
 b=PBsLGfqkXzMIbHh+FpTkGX8PbrVPxBbO9K9oNix+xQtfTnVpk6TLNlPhGark0PEySw2R/J
 cfJTwszQBQ9m3BmDXLLp5qk/dKhGwJFL02xVVtDgjIAJGz0vXc/Jl+x9w1eune/RmgxqrP
 Vzz/jb8C7slc88K/6z/vB2Q41m5nYU0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-VjVi0ZcjNYiJsuMd17M0cw-1; Fri,
 14 Feb 2025 09:31:42 -0500
X-MC-Unique: VjVi0ZcjNYiJsuMd17M0cw-1
X-Mimecast-MFC-AGG-ID: VjVi0ZcjNYiJsuMd17M0cw_1739543501
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26CD019783B4
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 14:31:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.144])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 725F91955DCE; Fri, 14 Feb 2025 14:31:37 +0000 (UTC)
Date: Fri, 14 Feb 2025 14:31:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laine Stump <laine@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] net: vhost-user: add QAPI events to report connection
 state
Message-ID: <Z69TxVIQS16yDiS2@redhat.com>
References: <20250214072629.1033314-1-lvivier@redhat.com>
 <871pw07sdy.fsf@pond.sub.org>
 <2c5358eb-1abe-4fce-8b28-7935c71f1cff@redhat.com>
 <Z69MOEAuE9WHjLjT@redhat.com> <Z69Q4bhElTS9bOO_@redhat.com>
 <20250214152834.68f5c9df@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214152834.68f5c9df@elisabeth>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 14, 2025 at 03:28:34PM +0100, Stefano Brivio wrote:
> On Fri, 14 Feb 2025 14:19:13 +0000
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Fri, Feb 14, 2025 at 01:59:20PM +0000, Daniel P. Berrangé wrote:
> > > On Fri, Feb 14, 2025 at 11:18:55AM +0100, Laurent Vivier wrote:  
> > > > On 14/02/2025 11:06, Markus Armbruster wrote:  
> > > > > Laurent Vivier <lvivier@redhat.com> writes:
> > > > >   
> > > > > > The netdev reports NETDEV_VHOST_USER_CONNECTED event when
> > > > > > the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
> > > > > > when it is disconnected.
> > > > > > 
> > > > > > The NETDEV_VHOST_USER_CONNECTED event includes the ChardevInfo
> > > > > > (label, filename and frontend_open).
> > > > > > 
> > > > > > This allows a system manager like libvirt to detect when the server
> > > > > > fails.
> > > > > > 
> > > > > > For instance with passt:
> > > > > > 
> > > > > > { 'execute': 'qmp_capabilities' }
> > > > > > { "return": { } }
> > > > > > 
> > > > > > [killing passt here]
> > > > > > 
> > > > > > { "timestamp": { "seconds": 1739517243, "microseconds": 115081 },
> > > > > >    "event": "NETDEV_VHOST_USER_DISCONNECTED",
> > > > > >    "data": { "netdev-id": "netdev0" } }
> > > > > > 
> > > > > > [automatic reconnection with reconnect-ms]
> > > > > > 
> > > > > > { "timestamp": { "seconds": 1739517290, "microseconds": 343777 },
> > > > > >    "event": "NETDEV_VHOST_USER_CONNECTED",
> > > > > >    "data": { "netdev-id": "netdev0",
> > > > > >              "info": { "frontend-open": true,
> > > > > >                        "filename": "unix:",
> > > > > >                        "label": "chr0" } } }
> > > > > > 
> > > > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>  
> > > > > 
> > > > > Standard question for events: if a management application misses an
> > > > > event, say because it restarts and reconnects, is there a way to obtain
> > > > > the missed information with a query command?
> > > > >   
> > > > 
> > > > query-chardev could help but it doesn't provide the netdev id.  
> > > 
> > > It doesn't have to IMHO. The application that created the NIC should know
> > > what ID it assigned to both the netdev and chardev, and thus should be
> > > able to use query-chardev to identify the chardev it previously
> > > associated with the netdev.  
> > 
> > That said I kind of wonder whether we should be adding events against
> > the chardev directly, instead of against the netdev use of chardev.
> 
> What is the advantage? This already works and is consistent with the
> existing non-vhost-user mechanism.

The advantage is that chardevs are used in many places across QEMU, so
emitting the events against the chardev is more broadly useful to
consumers of QEMU, than doing a special case that only benefit vhostuser
NICS.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


