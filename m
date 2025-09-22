Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D582CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hZ4-0002ab-64; Mon, 22 Sep 2025 10:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0hYi-0002HD-8x
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0hYR-0008VV-6Z
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758551406;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmgFegvBqqpeYyALvlhXF3KacoWYlSN2cQFl062bIAU=;
 b=NREhFo+Im/QSSyj1RH2ntxPeMGpShvN6cx1ZKDqLuUEU5QmXVsx5EU92Bp+PkhTPFJnv75
 gqiMtXjsP6gd9cRvQwJ1jIb1fKxpVVQxtgQnEtBD6ZmXTNRUUg6OVUCEZPTI+HAD3x/ZkS
 Ucv/NyxkkqSJBRBhmpsnypLQ7qpli3w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-C6eK-_gfNTq7oZ6MG-OrrA-1; Mon,
 22 Sep 2025 10:30:03 -0400
X-MC-Unique: C6eK-_gfNTq7oZ6MG-OrrA-1
X-Mimecast-MFC-AGG-ID: C6eK-_gfNTq7oZ6MG-OrrA_1758551398
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3577519560AF; Mon, 22 Sep 2025 14:29:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98C9F1955F21; Mon, 22 Sep 2025 14:29:32 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:29:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, Fam Zheng <fam@euphon.net>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: Re: [PULL 14/16] chardev: qemu_chr_open_fd(): add errp
Message-ID: <aNFdRvYAFYMAo31v@redhat.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
 <20250919115017.1536203-15-berrange@redhat.com>
 <CAFEAcA8AE4AcF6VOAPmtNeJi1XRBXityX1mLPw6K9+++VW6EEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8AE4AcF6VOAPmtNeJi1XRBXityX1mLPw6K9+++VW6EEw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 22, 2025 at 02:45:06PM +0100, Peter Maydell wrote:
> On Fri, 19 Sept 2025 at 12:55, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> >
> > Every caller already support errp, let's go further.
> >
> > Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Coverity reports a bug in this change (CID 1630444):
> 
> 
> > diff --git a/chardev/char-file.c b/chardev/char-file.c
> > index a9e8c5e0d7..89e9cb849c 100644
> > --- a/chardev/char-file.c
> > +++ b/chardev/char-file.c
> > @@ -92,7 +92,11 @@ static void qmp_chardev_open_file(Chardev *chr,
> >          }
> >      }
> >
> > -    qemu_chr_open_fd(chr, in, out);
> > +    if (!qemu_chr_open_fd(chr, in, out, errp)) {
> > +        qemu_close(out);
> > +        qemu_close(in);
> 
> Here 'in' can be -1 (if there is only an output file
> and no separate input file specified), so we can
> try to close(-1). Suggested fix:
> 
>          if (in >= 0) {
>              qemu_close(in);
>          }

Yes, that makes sense.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


