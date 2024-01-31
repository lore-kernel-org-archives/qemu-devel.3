Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02413C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 11:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV95j-00017W-2Z; Wed, 31 Jan 2024 06:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rV95a-00016P-LN
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 06:49:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rV95Y-0002go-Mc
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 06:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706701747;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGtC2yTYN4yP74jUMXUMfLUhabJWd41a2GwzIeTlzbk=;
 b=ZHheQ+NUqAInR8hp5+kMEF/O6hgcDa9bJVoxnPWzK26pechmXZVvANdEuy/VtZI2qY9tiD
 3jUNWP6ez++VFB2QbsyWbm6hvcbzREzUZ5wj+mT9pL4l3lqJlO8cgRse7hgMPoEbmI6c6H
 xLjtx80k0gtC4yqNJ8a+Z4uxubAjCOI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-cB9oeHAhOr-O8fTi5MIANw-1; Wed,
 31 Jan 2024 06:49:06 -0500
X-MC-Unique: cB9oeHAhOr-O8fTi5MIANw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7277280C29E;
 Wed, 31 Jan 2024 11:49:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C66D400DF3E;
 Wed, 31 Jan 2024 11:49:04 +0000 (UTC)
Date: Wed, 31 Jan 2024 11:49:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 4/7] block: Support detached LUKS header creation
 using blockdev-create
Message-ID: <ZbozrQuCnfJUZj1d@redhat.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
 <9e35e621f12478822072e5c740ed65beb77f1238.1706586786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e35e621f12478822072e5c740ed65beb77f1238.1706586786.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 30, 2024 at 01:37:22PM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> Firstly, enable the ability to choose the block device containing
> a detachable LUKS header by adding the 'header' parameter to
> BlockdevCreateOptionsLUKS.
> 
> Secondly, when formatting the LUKS volume with a detachable header,
> truncate the payload volume to length without a header size.
> 
> Using the qmp blockdev command, create the LUKS volume with a
> detachable header as follows:
> 
> 1. add the secret to lock/unlock the cipher stored in the
>    detached LUKS header
> $ virsh qemu-monitor-command vm '{"execute":"object-add",
> > "arguments":{"qom-type": "secret", "id": "sec0", "data": "foo"}}'
> 
> 2. create a header img with 0 size
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> > "arguments":{"job-id":"job0", "options":{"driver":"file",
> > "filename":"/path/to/detached_luks_header.img", "size":0 }}}'
> 
> 3. add protocol blockdev node for header
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments": {"driver":"file", "filename":
> > "/path/to/detached_luks_header.img", "node-name":
> > "detached-luks-header-storage"}}'
> 
> 4. create a payload img with 0 size
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> > "arguments":{"job-id":"job1", "options":{"driver":"file",
> > "filename":"/path/to/detached_luks_payload_raw.img", "size":0}}}'
> 
> 5. add protocol blockdev node for payload
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments": {"driver":"file", "filename":
> > "/path/to/detached_luks_payload_raw.img", "node-name":
> > "luks-payload-raw-storage"}}'
> 
> 6. do the formatting with 128M size
> $ virsh qemu-monitor-command c81_node1 '{"execute":"blockdev-create",
> > "arguments":{"job-id":"job2", "options":{"driver":"luks", "header":
> > "detached-luks-header-storage", "file":"luks-payload-raw-storage",
> > "size":134217728, "preallocation":"full", "key-secret":"sec0" }}}'
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  block/crypto.c       | 101 +++++++++++++++++++++++++++++++++++++++----
>  qapi/block-core.json |   3 ++
>  2 files changed, 96 insertions(+), 8 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


