Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA93CC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaxo-0003xZ-Ps; Tue, 04 Mar 2025 17:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpaxf-0003wm-Hy
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:42:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpaxe-0003Am-0c
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741128117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0CCNynC/mJBvcPw0xoXJp/mBsj9Y30Sr00Qxfzc0Hbs=;
 b=UilWqwCy1OTPpbR9iBHAlMRg90inI+C+4T3NVxwydo2TW1htHxfngHqpxqsb8L6Zo9s/a8
 bOO87o+Ltt2uD0QIxx3yuttc0a9NRzdQrI8gFLOEmRMvjuiYT1Vw17u8XrB4B3DrXEI4ts
 prNsNs2aYTlXT8cuKsiVUjCwP+zv/Nk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-pC5CETgOOmKc6X3BIpUQCg-1; Tue,
 04 Mar 2025 17:41:39 -0500
X-MC-Unique: pC5CETgOOmKc6X3BIpUQCg-1
X-Mimecast-MFC-AGG-ID: pC5CETgOOmKc6X3BIpUQCg_1741128098
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A5F51800268; Tue,  4 Mar 2025 22:41:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63A9D1800361; Tue,  4 Mar 2025 22:41:34 +0000 (UTC)
Date: Tue, 4 Mar 2025 16:41:32 -0600
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2] iotest: Unbreak 302 with python 3.13
Message-ID: <yybbuxvhv6hwkuslmjwfik7klh5s3izumk44pe6ehfvgkiaorn@cn5pk6wkbxe4>
References: <20250228195708.48035-1-nirsof@gmail.com>
 <20250303084156.GB205177@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303084156.GB205177@fedora>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Mar 03, 2025 at 04:41:56PM +0800, Stefan Hajnoczi wrote:
> On Fri, Feb 28, 2025 at 09:57:08PM +0200, Nir Soffer wrote:
> > This test depends on TarFile.addfile() to add tar member header without
> > writing the member data, which we write ourself using qemu-nbd. Python
> > 3.13 changed the function in a backward incompatible way[1] to require a
> > file object for tarinfo with non-zero size, breaking the test:
> > 
> >      -[{"name": "vm.ovf", "offset": 512, "size": 6}, {"name": "disk", "offset": 1536, "size": 393216}]
> >      +Traceback (most recent call last):
> >      +  File "/home/stefanha/qemu/tests/qemu-iotests/302", line 118, in <module>
> >      +    tar.addfile(disk)
> >      +    ~~~~~~~~~~~^^^^^^
> >      +  File "/usr/lib64/python3.13/tarfile.py", line 2262, in addfile
> >      +    raise ValueError("fileobj not provided for non zero-size regular file")
> >      +ValueError: fileobj not provided for non zero-size regular file
> > 
> > The new behavior makes sense for most users, but breaks our unusual
> > usage. Fix the test to add the member header directly using public but
> > undocumented attributes. This is more fragile but the test works again.
> > 
> > This also fixes a bug in the previous code - when calling addfile()
> > without a fileobject, tar.offset points to the start of the member data
> > instead of the end.
> > 
> > [1] https://github.com/python/cpython/pull/117988
> > 
> > Signed-off-by: Nir Soffer <nirsof@gmail.com>
> > ---
> >  tests/qemu-iotests/302 | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Added to my NBD queue.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


