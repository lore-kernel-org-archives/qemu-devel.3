Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D4DC3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKez-0003qk-EJ; Thu, 04 Jul 2024 07:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sPKex-0003oW-HN
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sPKev-0004C8-Ly
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720092590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uff1tZ0HiZ9BC/wKbDvGWNLSdnnfBJ9B+cRzxsc+Hg0=;
 b=KYvr9PxTCq52ToD/3QtLNsV5xF1LNTfemauA7jWpdYY4utPB4nTKSDQ5gxe4hAc7/Zu+LW
 ASY7scmxFbJ9pFs1EpgQuVYz8CTSYfdG4EO+vdOGqDjuBHKBUp01hhNjFEOJuf+HHeYhQi
 BXZnVpcwDtLLpoUwn7kxgh21gpS2wds=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-h9THZCBTPL-oEefUK5zfew-1; Thu,
 04 Jul 2024 07:29:47 -0400
X-MC-Unique: h9THZCBTPL-oEefUK5zfew-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD2FD1955BD0; Thu,  4 Jul 2024 11:29:43 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DE9A3000180; Thu,  4 Jul 2024 11:29:38 +0000 (UTC)
Date: Thu, 4 Jul 2024 13:29:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, richard.henderson@linaro.org, hreitz@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PULL 4/4] block: Parse filenames only when explicitly requested
Message-ID: <ZoaHn87kcpnwFcIU@redhat.com>
References: <20240702163943.276618-1-kwolf@redhat.com>
 <20240702163943.276618-5-kwolf@redhat.com>
 <358eddb4-7d14-4a6d-b360-24bb416b901e@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <358eddb4-7d14-4a6d-b360-24bb416b901e@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 03.07.2024 um 23:16 hat Michael Tokarev geschrieben:
> 02.07.2024 19:39, Kevin Wolf wrote:
> > When handling image filenames from legacy options such as -drive or from
> > tools, these filenames are parsed for protocol prefixes, including for
> > the json:{} pseudo-protocol.
> > 
> > This behaviour is intended for filenames that come directly from the
> > command line and for backing files, which may come from the image file
> > itself. Higher level management tools generally take care to verify that
> > untrusted images don't contain a bad (or any) backing file reference;
> > 'qemu-img info' is a suitable tool for this.
> > 
> > However, for other files that can be referenced in images, such as
> > qcow2 data files or VMDK extents, the string from the image file is
> > usually not verified by management tools - and 'qemu-img info' wouldn't
> > be suitable because in contrast to backing files, it already opens these
> > other referenced files. So here the string should be interpreted as a
> > literal local filename. More complex configurations need to be specified
> > explicitly on the command line or in QMP.
> > 
> > This patch changes bdrv_open_inherit() so that it only parses filenames
> > if a new parameter parse_filename is true. It is set for the top level
> > in bdrv_open(), for the file child and for the backing file child. All
> > other callers pass false and disable filename parsing this way.
> 
> I'm attaching backports of this change to 8.2 and 7.2 series.
> 
> Please check if the resulting backports are correct, or if they're needed
> in the first place.  Note: 7.2 lacks quite some locking in this area, eg
> v8.0.0-2069-g8394c35ee148 "block: Fix AioContext locking in bdrv_open_child()"
> v8.2.0-rc0-59-g6bc0bcc89f84 "block: Fix deadlocks in bdrv_graph_wrunlock()".

Apart from minor style differences, your 7.2 backport is a perfect match
of the RHEL 9.2 backport which I already reviewed downstream. The 8.2
patch is a bit different from the RHEL 9.4 one because we backported the
final bits of the multiqueue work, but the differences make sense for
upstream QEMU 8.2.

So both patches look good to me.

Kevin


