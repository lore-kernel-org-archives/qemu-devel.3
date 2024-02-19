Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215A2C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 15:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc5Am-0001QV-F4; Mon, 19 Feb 2024 10:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rc5AO-0001BM-LB
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:02:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rc5AM-0001Ka-AX
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708354964;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UECnQadqnNWQF/+9DWeNlFOWpH9zp4XslRiv6K7Z1+I=;
 b=a5GIR5N+svS0vUk2dOx8XoIn7ijxwvIkZE690ii5iAYYLgtt8G5k6a0E8BTgaGErjof2A1
 sfUGRMW/9RFy7GlpOGidwTpyNaByqeNSyC8nUGuJA6fpWFt+hrZRfWULjek4Q6+mCt8ObN
 728ML3C89t+orQYgFJ9DbMcmptwmy+8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-hEBK0sGrNDKGNH01LigOGQ-1; Mon,
 19 Feb 2024 10:02:41 -0500
X-MC-Unique: hEBK0sGrNDKGNH01LigOGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C714F1C54464;
 Mon, 19 Feb 2024 15:02:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C90D1C060B2;
 Mon, 19 Feb 2024 15:02:39 +0000 (UTC)
Date: Mon, 19 Feb 2024 15:02:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, yong.huang@smartx.com,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 4/7] block: Support detached LUKS header creation
 using blockdev-create
Message-ID: <ZdNtjcTg0vJHS6mH@redhat.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
 <9e35e621f12478822072e5c740ed65beb77f1238.1706586786.git.yong.huang@smartx.com>
 <87v86kjzwb.fsf@pond.sub.org> <87ttm4ik5h.fsf@pond.sub.org>
 <ZdNsSX2n6fmb7KnD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdNsSX2n6fmb7KnD@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Feb 19, 2024 at 02:57:13PM +0000, Daniel P. Berrangé wrote:
> On Mon, Feb 19, 2024 at 03:49:30PM +0100, Markus Armbruster wrote:
> > One more thing...
> > 
> > Markus Armbruster <armbru@redhat.com> writes:
> > 
> > > yong.huang@smartx.com writes:
> > >
> > >> From: Hyman Huang <yong.huang@smartx.com>
> > >>
> > >> Firstly, enable the ability to choose the block device containing
> > >> a detachable LUKS header by adding the 'header' parameter to
> > >> BlockdevCreateOptionsLUKS.
> > >>
> > >> Secondly, when formatting the LUKS volume with a detachable header,
> > >> truncate the payload volume to length without a header size.
> > >>
> > >> Using the qmp blockdev command, create the LUKS volume with a
> > >> detachable header as follows:
> > >>
> > >> 1. add the secret to lock/unlock the cipher stored in the
> > >>    detached LUKS header
> > >> $ virsh qemu-monitor-command vm '{"execute":"object-add",
> > >>> "arguments":{"qom-type": "secret", "id": "sec0", "data": "foo"}}'
> > >>
> > >> 2. create a header img with 0 size
> > >> $ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> > >>> "arguments":{"job-id":"job0", "options":{"driver":"file",
> > >>> "filename":"/path/to/detached_luks_header.img", "size":0 }}}'
> > >>
> > >> 3. add protocol blockdev node for header
> > >> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > >>> "arguments": {"driver":"file", "filename":
> > >>> "/path/to/detached_luks_header.img", "node-name":
> > >>> "detached-luks-header-storage"}}'
> > >>
> > >> 4. create a payload img with 0 size
> > >> $ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> > >>> "arguments":{"job-id":"job1", "options":{"driver":"file",
> > >>> "filename":"/path/to/detached_luks_payload_raw.img", "size":0}}}'
> > >>
> > >> 5. add protocol blockdev node for payload
> > >> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > >>> "arguments": {"driver":"file", "filename":
> > >>> "/path/to/detached_luks_payload_raw.img", "node-name":
> > >>> "luks-payload-raw-storage"}}'
> > >>
> > >> 6. do the formatting with 128M size
> > >> $ virsh qemu-monitor-command c81_node1 '{"execute":"blockdev-create",
> > >>> "arguments":{"job-id":"job2", "options":{"driver":"luks", "header":
> > >>> "detached-luks-header-storage", "file":"luks-payload-raw-storage",
> > >>> "size":134217728, "preallocation":"full", "key-secret":"sec0" }}}'
> > >>
> > >> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > >> ---
> > >
> > > [...]
> > >
> > >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> > >> index 69a88d613d..eab15d7dd9 100644
> > >> --- a/qapi/block-core.json
> > >> +++ b/qapi/block-core.json
> > >> @@ -4960,6 +4960,8 @@
> > >>  # @file: Node to create the image format on, mandatory except when
> > >>  #        'preallocation' is not requested
> > >>  #
> > >> +# @header: Block device holding a detached LUKS header. (since 9.0)
> > >> +#
> > >
> > > Behavior when @header is present vs. behavior when it's absent?
> > 
> > The next patch adds a member to QCryptoBlockCreateOptionsLUKS, with a
> > similar description, but a different name:
> > 
> >     # @detached-header: create a detached LUKS header. (since 9.0)
> > 
> > Should we name the one added here @detached-header, too?
> 
> Yikes, that's a mistake. When I reviewed this I was somehow under the
> illusion that QCryptoBlockCreateOptionsLUKS was internal use only, for
> the block driver impl to interact with the crypto LUKS impl.
> 
> In fact, as the diff context below shows, QCryptoBlockCreateOptionsLUKS
> is a base struct for BlockdevCreateOptionsLUKS. So in effect we have
> one struct with two fields expressing similar concept.
> 
> TL;DR: the @detached-header field needs to go, as that's supposed to
> be internal only. The mgmt app should only care about 'header' in the
> BlockdevCreateOptionsLUKS struct.
> 
> FYI, this whole series is already merged last week. So this will need
> a fixup. I'll look into it now.

In fact the '@detached-header' added in the next patch is redundant
in the QAPI, as it is never set. So this QAPI field can be deleted.

We do have a 'detached-header' QemuOpts setting which is simply a
bool flag, as opposed to a full blockdev ref, since qemu-img create
doesn't work in terms of the QAPI BlockdevCreate schema.



> 
> > 
> > >>  # @size: Size of the virtual disk in bytes
> > >>  #
> > >>  # @preallocation: Preallocation mode for the new image (since: 4.2)
> > >> @@ -4970,6 +4972,7 @@
> > >>  { 'struct': 'BlockdevCreateOptionsLUKS',
> > >>    'base': 'QCryptoBlockCreateOptionsLUKS',
> > >>    'data': { '*file':            'BlockdevRef',
> > >> +            '*header':          'BlockdevRef',
> > >>              'size':             'size',
> > >>              '*preallocation':   'PreallocMode' } }
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


