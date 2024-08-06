Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91212C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKhG-00059j-TW; Tue, 06 Aug 2024 09:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbKhD-00056i-Tk
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbKhA-0001Y2-Rq
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722952667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uk+h0sC7+k/5uvB2SfC8rdjIUeCnNCSF39u1Stu8xh8=;
 b=CawyUn1Ayvd9E3Eub2gtHwxASlpFBz54zPAwjFvhOTPC+p5g93yC+Bu4jBcb/Xg5YPqTkQ
 /GctlfMJiYhCxM0LIWSIzt0cBCzzFb21wZ4ukLmZTFUlo599un+xm+Mn/2PC0LnUJe+azb
 +YXAC1UkshuuN04YnSzMoj4FwsL2GsQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-UzCF3h4ZODW46fbIihCmvg-1; Tue,
 06 Aug 2024 09:57:42 -0400
X-MC-Unique: UzCF3h4ZODW46fbIihCmvg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7CCC1944A95; Tue,  6 Aug 2024 13:57:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.154])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7B511955D44; Tue,  6 Aug 2024 13:56:16 +0000 (UTC)
Date: Tue, 6 Aug 2024 08:56:13 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH v3 2/2] nbd: Clean up clients more efficiently
Message-ID: <v7g76prhzxmq6gmibbazrgsrjvoiekkpmcdlh2ywzb5kcfj7jk@v2d67bpo2bwf>
References: <20240806022542.381883-4-eblake@redhat.com>
 <20240806022542.381883-6-eblake@redhat.com>
 <ZrHtxrb5dyh3eKJu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrHtxrb5dyh3eKJu@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Aug 06, 2024 at 10:32:54AM GMT, Daniel P. Berrangé wrote:
> On Mon, Aug 05, 2024 at 09:21:36PM -0500, Eric Blake wrote:
> > Since an NBD server may be long-living, serving clients that
> > repeatedly connect and disconnect, it can be more efficient to clean
> > up after each client disconnects, rather than storing a list of
> > resources to clean up when the server exits.  Rewrite the list of
> > known clients to be double-linked so that we can get O(1) deletion to
> > keep the list pruned to size as clients exit.  This in turn requires
> > each client to track an opaque pointer of owner information (although
> > qemu-nbd doesn't need to refer to it).
> 
> I tend to feel that this needs to be squashed into the previous
> patch.  The previous patch effectively creates unbounded memory
> usage in the NBD server. ie consider a client that connects and
> immediately disconnects, not sending any data, in a tight loop.
> It will "leak" NBDConn & QIOChanelSocket pointers for each
> iteration of the loop, only to be cleaned up when the NBD Server
> is shutdown.

Hmm. Offline, we observed that qemu's default of unlimited clients may
not be the smartest thing - if max-connections is not set, we may want
to default it to something like 100 (even when MULTI_CONN is
exploited, most clients that take advantage of it will probably only
use 8 or 16 parallel sockets; more than that tends to run into other
limits rather than providing continual improvements).  I can add such
a change in default in v4.  In contrast, qemu-nbd defaults to
max-connections 1 for historical reasons (among others, if you have a
non-persistent server, it is really nice that qemu-nbd automatically
exits after the first client disconnects, rather than needing to clean
up the server yourself), but that's too small for MULTI_CONN to be of
any use.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


