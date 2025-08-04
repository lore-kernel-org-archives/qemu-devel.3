Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C33C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 10:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uisM3-0000Hm-Nl; Mon, 04 Aug 2025 06:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uisLO-00005P-W5
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uisLN-00084Y-1x
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754302979;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roKcUYbJ74RWI74EySfiYdVlgpWGgeKrAHO/JSYtdg0=;
 b=Ow6/gt06UJ4vRQuyjtTXHBuKXno+LnfcOq7xOmqWSIeWS3+aMKH0hBvekbIl+bTGqKPc85
 QS3cCsvFJ4760YcYyKdCO2ps6QiFrDKCJjGX9HC5BFPOSAOpYucgubN3qkloTYzq4c1V9f
 MwYk1XMEaEcGgR+OKCVijfIwm0JTLns=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-XFuUXBV6N2K061Y6QbnyIA-1; Mon,
 04 Aug 2025 06:22:57 -0400
X-MC-Unique: XFuUXBV6N2K061Y6QbnyIA-1
X-Mimecast-MFC-AGG-ID: XFuUXBV6N2K061Y6QbnyIA_1754302976
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B3161800165; Mon,  4 Aug 2025 10:22:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7F1919560AD; Mon,  4 Aug 2025 10:22:53 +0000 (UTC)
Date: Mon, 4 Aug 2025 11:22:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 1/2] migration: simplify error reporting after channel read
Message-ID: <aJCJ-tqqimnrDDgZ@redhat.com>
References: <20250801170212.54409-1-berrange@redhat.com>
 <20250801170212.54409-2-berrange@redhat.com>
 <CAE8KmOxzskHzPsfUCZP56qmFHC7Rgi8x0HacUuZgzUv4UNiYyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE8KmOxzskHzPsfUCZP56qmFHC7Rgi8x0HacUuZgzUv4UNiYyQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 04, 2025 at 03:48:59PM +0530, Prasad Pandit wrote:
> On Sat, 2 Aug 2025 at 00:06, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > The code handling the return value of qio_channel_read proceses
> > len == 0 (EOF) separately from len < 1  (error), but in both
> > cases ends up calling qemu_file_set_error_obj() with -EIO as the
> > errno. This logic can be merged into one codepath to simplify it.
> >
> >              } else {
> >                  qio_channel_wait(f->ioc, G_IO_IN);
> >              }
> > -        } else if (len < 0) {
> > -            len = -EIO;
> >          }
> >      } while (len == QIO_CHANNEL_ERR_BLOCK);
> >
> >      if (len > 0) {
> >          f->buf_size += len;
> > -    } else if (len == 0) {
> > -        qemu_file_set_error_obj(f, -EIO, local_error);
> >      } else {
> > -        qemu_file_set_error_obj(f, len, local_error);
> > +        qemu_file_set_error_obj(f, -EIO, local_error);
> >      }
> 
> * But should  _file_set_error_obj(...  -EIO) be called for len == 0
> (EOF) case? ie. function is trying to read from a file, at some point
> it is bound to reach EOF.  '-EIO' indicates an I/O error, reaching EOF
> could not be an error. Maybe we could just return zero(0) ?  (just
> checking)

The migration protocol knows whether it is expecting more data or not.

If we want more data, then a call to qemu_fill_buffer must successfully
read at least 1 byte.

If we don't want more data, then we would not have triggered any call
to qemu_fill_buffer.

Thus, a call to qemu_fill_buffer which gets EOF is an error scenario.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


