Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC80CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWC2-00045w-L7; Tue, 16 Sep 2025 09:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyWC0-000459-Ed
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 09:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyWBy-0003mt-1q
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 09:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758031077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyyhLOkTb5kKS2McMp5qgSCM5rMRPvJA6pq9WuO5Gqo=;
 b=R/MjeR3uep3gxmkl+MqhhAFEMsgKgXglpAXcStVPKXsdN7pXMv9SZXlERfIYFC5UOvz+F2
 FgCQiT5tPt1XCCKRMFZbbAx7u7cNx9EzEFqEpq3BbTquB2C7MYIqWeIBHb6s1ZWcSR1nz/
 XBQvZduJJnop5M6Fh8PIpCd6yGklBb8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-7ZAC-B00PW2dqF-rwmhiqA-1; Tue, 16 Sep 2025 09:57:53 -0400
X-MC-Unique: 7ZAC-B00PW2dqF-rwmhiqA-1
X-Mimecast-MFC-AGG-ID: 7ZAC-B00PW2dqF-rwmhiqA_1758031073
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8286b42f46bso671199785a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 06:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758031073; x=1758635873;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZyyhLOkTb5kKS2McMp5qgSCM5rMRPvJA6pq9WuO5Gqo=;
 b=oyAV25Affd7F4UB7nGFoI7g8bqfpWlhUDhT8DOzYtXmCCYdUOxoGGgab0oaJe+K3yP
 9wNHM9xdXZzLeBc8D/wJOJ4vMhtWNN7kgJPvoNhbW1+Yem4Q+Iun2UN2DiX2KqWK2sA8
 TSN/8sFicVxJaTnM/Hlflol/EOy+oZP/nHMk3JsWMvCAQ2Wp7SfohqxJ4W1WVLzjLavs
 XDSiKM50e8CwgceO7r1+4cU94H810Xh/esVeJ3Qk1f9bYAUyUVwnUf4xF9Z1dVZw+w1S
 SoXpmVWqJmhALuoojKdUqT1823RuzjAaF/9YIo/PxI8we/WNfdOMVlXZoTOI3mxkvQiK
 +aGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcrCIRIxXVMfq+NF7hxPsFTdFWB7oIAZjo7w/7gDG8DJ1nnTDO9dATVBw2A6j3JhKMfdBXlOD5PBg0@nongnu.org
X-Gm-Message-State: AOJu0YxJvmoRdoXF8nt5Qa9avANttOO0H6V/35Dliy7dsVI+0Jh4w1tD
 kJc5RLIMXd58NkuT1JQzqOrRXDdr9ztbtzM8HrnT+n4KSdAcqVbEuSkTok+3/OGXE6ZooUG/W65
 0J8BA0axOaeTuf521yNAegHTH3I3yOFR3bdEIUcn+LJi5wJFbGe04GiSj
X-Gm-Gg: ASbGncu5ts7nGYn/mt2Yybup2Y0h4dlIFzoE99cj++xb5y6NB18TF6c35HWAdlQ9biB
 9J3uIm8VIUbDagNsdBSuWkIRhhVT4ff5o5eGBYzNLsLnxd59zOp5YYnOkNDnMPYV85QtYQelO9X
 gcTlNUJ40WD6eCGNAI3pK1XV0x18rp+/wWFZvxcyNqv9IDmkpfs1U6d2yxWrxGgMf7HPcFeB7B3
 EidC+TbXPW4K6U2i3gfnWhEp37TOVMo4PwxBcpzJKQLa7ry/ZT+mmSrPnAUJtFBNQEosirANRdv
 P2AO3XUixasKMklcnvjRez7Pt9rv1vvM
X-Received: by 2002:a05:620a:40c2:b0:829:2036:23e9 with SMTP id
 af79cd13be357-829203624f9mr893006685a.52.1758031072997; 
 Tue, 16 Sep 2025 06:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbSNaLt8psTnHo9geRmqzRZTd6FuTRQcr5ZzQGpDsXiQ8BtFZXJkJlXdHmj4Lvun8xAanqcQ==
X-Received: by 2002:a05:620a:40c2:b0:829:2036:23e9 with SMTP id
 af79cd13be357-829203624f9mr893001785a.52.1758031072189; 
 Tue, 16 Sep 2025 06:57:52 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b639cb2562sm81729631cf.13.2025.09.16.06.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 06:57:51 -0700 (PDT)
Date: Tue, 16 Sep 2025 09:57:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v5 04/13] handle result of qio_channel_set_blocking()
Message-ID: <aMls1F7VyCzE9-jg@x1.local>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
 <20250916131403.368343-5-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916131403.368343-5-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 16, 2025 at 04:13:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Currently, we just always pass NULL as errp argument. That doesn't
> look good.
> 
> Some realizations of interface may actually report errors.
> Channel-socket realization actually either ignore or crash on
> errors, but we are going to straighten it out to always reporting
> an errp in further commits.
> 
> So, convert all callers to either handle the error (where environment
> allows) or explicitly use &error_abort.
> 
> Take also a chance to change the return value to more convenient
> bool (keeping also in mind, that underlying realizations may
> return -1 on failure, not -errno).
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  block/nbd.c                      |  4 +++-
>  chardev/char-socket.c            | 20 ++++++++++++++++----
>  hw/remote/proxy.c                |  6 +++++-
>  hw/remote/remote-obj.c           |  6 +++++-
>  hw/vfio-user/proxy.c             | 11 ++++++++---
>  include/io/channel.h             |  6 +++---
>  io/channel.c                     |  4 ++--
>  nbd/server.c                     |  4 +++-
>  scsi/qemu-pr-helper.c            |  9 ++++++---
>  tests/unit/io-channel-helpers.c  |  5 +++--
>  tests/unit/test-io-channel-tls.c |  4 ++--
>  tools/i386/qemu-vmsr-helper.c    |  6 ++++--
>  ui/vnc.c                         |  2 +-
>  util/vhost-user-server.c         |  7 ++++++-
>  14 files changed, 67 insertions(+), 27 deletions(-)

No need to repost, but just to mention (if possible to be touched up when
Dan queues this..).. it's still good to always have a prefix for subject.

IMHO we can use "treewide:"; qemu started using it in a few commits.  Linux
kernel used it much more.  We can keep the trend, IMHO.

-- 
Peter Xu


