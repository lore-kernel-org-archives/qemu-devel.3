Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12F4C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 15:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXN1P-000138-Nx; Fri, 26 Jul 2024 11:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sXN1N-00011q-5a
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 11:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sXN1L-0000nd-N6
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 11:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722008293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lcv6Pe6hQxAmcA6zPSkaK2jCPHrotiCeNTHUHSn32sQ=;
 b=B4Pxzenvt7UJcShr7JKfEgdwMyZWLzlgtSpRoYHOkvp64/9AKo0YpwRbd6RbUqnaz2M3Ez
 P1xqmaxHZBFPoU7imve6Mh4kUiAOaxpOaSotpVGWcporueDKxVWC3O9TMQ0dy9XeH6DJN9
 OD+YYP3pGrvSkHHIh2MPex6oSx4JdnA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-98SKVh_XN8CpfcDejzEYaw-1; Fri,
 26 Jul 2024 11:38:07 -0400
X-MC-Unique: 98SKVh_XN8CpfcDejzEYaw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85839195609E; Fri, 26 Jul 2024 15:38:06 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76A031955D42; Fri, 26 Jul 2024 15:38:03 +0000 (UTC)
Date: Fri, 26 Jul 2024 10:38:01 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>
Subject: Re: query dirty areas according to bitmap via QMP or qemu-nbd
Message-ID: <spi5wsadgvijq6venwx74c5exat6635h4xf5v6aaf2t3bzvijq@dkfqlhzhcvl3>
References: <a8ceec92-4b4a-4ee6-b7f7-b6b9d804a5e9@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8ceec92-4b4a-4ee6-b7f7-b6b9d804a5e9@proxmox.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 04:16:41PM GMT, Fiona Ebner wrote:
> Hi,
> 
> sorry if I'm missing the obvious, but is there a way to get the dirty
> areas according to a dirty bitmap via QMP? I mean as something like
> offset + size + dirty-flag triples. In my case, the bitmap is also
> exported via NBD, so same question for qemu-nbd being the client.

Over QMP, no - that can produce a potentially large response and
possible long time in computing the data, so we have never felt the
need to introduce a new QMP command for that purpose.  So over NBD is
the preferred solution.

> 
> I can get the info with "nbdinfo --map", but would like to avoid
> requiring a tool outside QEMU.

By default, QEMU as an NBD client only reads the "base:allocation" NBD
metacontext, and is not wired to read more than one NBD metacontext at
once (weaker than nbdinfo's capabilities).  But I have intentionally
left in a hack (accessible through QMP as well as from the command
line) for connecting a qemu NBD client to an alternative NBD
metacontext that feeds the block status, at which point 2 bits of
information from the alternative context are observable through the
result of block status calls.  Note that using such an NBD connection
for anything OTHER than block status calls is inadvisable (qemu might
incorrectly optimize reads based on its misinterpretation of those
block status bits); but as long as you limit the client to block
status calls, it's a great way to read out a "qemu:dirty-bitmap:..."
metacontext using only a qemu NBD client connection.

git grep -l x-dirty-bitmap tests/qemu-iotests

shows several of the iotests using the backdoor in just that manner.
In particular, tests/qemu-img-bitmaps gives the magic decoder ring:

| # x-dirty-bitmap is a hack for reading bitmaps; it abuses block status to
| # report "data":false for portions of the bitmap which are set
| IMG="driver=nbd,server.type=unix,server.path=$nbd_unix_socket"
| nbd_server_start_unix_socket -r -f qcow2 \
|     -B b0 -B b1 -B b2 -B b3 "$TEST_IMG"
| $QEMU_IMG map --output=json --image-opts \
|     "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b0" | _filter_qemu_img_map

meaning the map output includes "data":false for the dirty portions
and "data":true for the unchanged portions recorded in bitmap b0 as
read from the JSON map output.

> 
> If it is not currently possible, would upstream be interested too in the
> feature, either for QMP or qemu-nbd?

Improving qemu-img to get at the information without quite the hacky
post-processing deciphering would indeed be a useful patch, but it has
never risen to the level of enough of an itch for me to write it
myself (especially since 'nbdinfo --map's output works just as well).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


