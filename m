Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C81C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4e4m-000403-Cj; Tue, 15 Apr 2025 07:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4e4i-0003za-Bs
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4e4f-0005O9-O3
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744715007;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1r0Vt9SO+HOAkulgNbwubjMkc2HKq9YChoxlKi5p5CY=;
 b=KQv/lwkxF6fuN/obUpeKt+0mgyiQHfwdxqylCMaFy6Tey9HIeStws2HHGG2E0qDJxgQJBS
 Aki0U6Xgha+Vtas94d29qjyc1u7zfKgz61fJX/MvFA6stZaP63R600tGmSONHMCRF3S9wg
 qzXO0lgCB9nrs/nG90dUewe7TcnnN4U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-mHJY_LIDPW6qz5HM1mvG7g-1; Tue,
 15 Apr 2025 07:03:25 -0400
X-MC-Unique: mHJY_LIDPW6qz5HM1mvG7g-1
X-Mimecast-MFC-AGG-ID: mHJY_LIDPW6qz5HM1mvG7g_1744715004
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0743195609F; Tue, 15 Apr 2025 11:03:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D63C51801766; Tue, 15 Apr 2025 11:03:20 +0000 (UTC)
Date: Tue, 15 Apr 2025 12:03:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Marco Cavenati <Marco.Cavenati@eurecom.fr>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
Message-ID: <Z_489fbXq-1Ihnhu@redhat.com>
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
 <Z_4zL4y0UbmLJTsP@redhat.com>
 <CAE8KmOz-yGRXo2RiPpnhtcg2K+j38sK6C1eGHvpQf0L_Hfe3vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE8KmOz-yGRXo2RiPpnhtcg2K+j38sK6C1eGHvpQf0L_Hfe3vw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 15, 2025 at 04:14:08PM +0530, Prasad Pandit wrote:
> Hi,
> 
> On Tue, 15 Apr 2025 at 15:51, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > It is actually NOT really connected to lseek, and as such
> 
> * For file and fd channels _FEATURE_SEEKABLE is set  when/if  lseek(2) works.
>     -> https://gitlab.com/qemu-project/qemu/-/commit/401e311ff72e0a62c834bfe466de68a82cfd90cb

Yes I know, checking lseek is a proxy that determines whether
preadv will work or not. This is basically validating that
the file/fd is not a FIFO/pipe/character device. It must be
a block device or regular file.

> > QIO_CHANNEL_FEATURE_SEEKABLE is probably a bad choice of name
> > in retrospect.
> 
> * That's plausible. Because while reading code,  _SEEKABLE indicates
> (or hints) that the underlying stream allows random access at a given
> offset. Even pread(2)/pwrite(2) manuals say that -> file referenced by
> fd should be capable of seeking. So correlation is that, since
> QIO_CHANNEL is an abstraction layer, it supports different
> streams/channels underneath, maybe some of those underneath streams
> support seeking (random access) and some don't. Hence we set
> _FEATURE_SEEKABLE when the underlying channel/stream supports it.
> 
> > In QIOChanel API specification, having QIO_CHANNEL_FEATURE_SEEKABLE
> > set is a pre-requisite for use of qio_channel_{pread,preadv,pwrite,pwritev}.
> 
> * If *_FEATURE_SEEKABLE is not connected to lseek(2) or seeking, what
> is its right interpretation? Why is it a pre-requisite for use of
> qio_channel_{pread,preadv,pwrite,pwritev} functions?

Because that's what the QEMU API specification declares

 * Not all implementations will support this facility, so may report
 * an error. To avoid errors, the caller may check for the feature
 * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.

and what the QEMU API impl defines

  ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
                              size_t niov, off_t offset, Error **errp)
  {
      QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);

      if (!klass->io_pwritev) {
          error_setg(errp, "Channel does not support pwritev");
          return -1;
      }

      if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_SEEKABLE)) {
          error_setg_errno(errp, EINVAL, "Requested channel is not seekable");
          return -1;
      }

      return klass->io_pwritev(ioc, iov, niov, offset, errp);
  }


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


