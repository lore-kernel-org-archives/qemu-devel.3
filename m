Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F65C5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 22:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2N9-0002sU-G0; Tue, 27 May 2025 18:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uK2Mz-0002qt-VY
 for qemu-devel@nongnu.org; Tue, 27 May 2025 18:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uK2Mx-00006d-Ei
 for qemu-devel@nongnu.org; Tue, 27 May 2025 18:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FL1I9zEbL1hm9XOn7raUbREc4M+pAeDSti3FX1wz7dQ=;
 b=IfbIQOL3DMhVgccdi5yzRFgvn1plwjYjbMV8ATA5imOe9I5AP581Wi/8vYiOnv/MOsXjnb
 fdSTwIee7OU/mLKWZuQvfougutmWnENS03svrNpSAjHnD+lraXNKfOgHOpA3nt5nlZDi61
 Yf3X+wAo363bQoKv5lagYemjP0NG8KE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-e7EqTwkpMg69bhOOkP_f6g-1; Tue,
 27 May 2025 18:01:55 -0400
X-MC-Unique: e7EqTwkpMg69bhOOkP_f6g-1
X-Mimecast-MFC-AGG-ID: e7EqTwkpMg69bhOOkP_f6g_1748383314
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E03F219560BC; Tue, 27 May 2025 22:01:23 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D91419560AA; Tue, 27 May 2025 22:01:20 +0000 (UTC)
Date: Tue, 27 May 2025 17:01:18 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 1/4] nbd: Add multi-conn option
Message-ID: <e5qupmbs4innc4d5fqi5wjgc4xs3dzng2h22uqdpprshm7zfsf@zddd3w6jefoj>
References: <20250428185246.492388-6-eblake@redhat.com>
 <20250428185246.492388-7-eblake@redhat.com>
 <877c33qzzn.fsf@pond.sub.org> <20250429091422.GG1450@redhat.com>
 <87wmb3jkoh.fsf@pond.sub.org> <20250429111958.GI1450@redhat.com>
 <87o6wfnqzj.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6wfnqzj.fsf@pond.sub.org>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 29, 2025 at 01:31:44PM +0200, Markus Armbruster wrote:
> > In the context of qemu that might suggest having separate
> > multi_conn_requested and multi_conn fields, where the latter can be
> > queried over QMP to find out what is actually going on.  Could even
> > add multi_conn_max to allow MAX_MULTI_CONN constant to be read out.
>
> You decide what to do with my feedback :)

I've got a local patch that adds the ability for
query-named-block-nodes (and query-block) to output image-specific
information for NBD that includes how many connections are actually in
use.  But now I've got a QMP question:

My patch, as written, makes the output look like this:

"format-specific": {"mode": "extended", "type": "nbd", "connections": 1}},

by changing block-core.json like this (partial patch shown):

@@ -208,10 +223,12 @@
 #
 # @file: Since 8.0
 #
+# @nbd: Since 10.1
+#
 # Since: 1.7
 ##
 { 'enum': 'ImageInfoSpecificKind',
-  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file' ] }
+  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file', 'nbd' ] }

 ##
 # @ImageInfoSpecificQCow2Wrapper:
@@ -284,7 +301,8 @@
       'luks': 'ImageInfoSpecificLUKSWrapper',
       'rbd': 'ImageInfoSpecificRbdWrapper',
-      'file': 'ImageInfoSpecificFileWrapper'
+      'file': 'ImageInfoSpecificFileWrapper',
+      'nbd': 'ImageInfoSpecificNbd'
   } }

But that is different from all of the other image modes, where the
output looks more like:

"format-specific": {"type": "rbd", "data": {"encryption-format":"..."}}},

note the extra layer of nesting, due to historical reasons of being
added in a time when the QMP generator was not as nice on supporting
flatter union-style coding.

Must I create an ImageInfoSpecificNbdWrapper type, with the sole
purpose of having the same (pointless, IMO) "data":{} wrapper as all
the other branches of the union type, or am I okay with my addition
using the flatter style?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


