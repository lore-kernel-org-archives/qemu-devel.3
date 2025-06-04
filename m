Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839EEC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMo9s-0006TT-IW; Wed, 04 Jun 2025 09:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1uMo9r-0006TH-77
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1uMo9m-0004fq-Fd
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clDW1r158unwtlDsyqPL74tCSQyxdxqdEtDprNG8wHY=;
 b=NPKfllBvakTSo7GW6NhRXojDBfIF2VkzXmXSbfsu6MkQrbSAC44K/ftB2B8ewjM2fo/f0h
 lzkLjHFKD55PZA/ADoQrMl4SeKUB0C9trVlbWdUUAzV4VlEEDPHVw8N+QmteWhZeR/+nCs
 eDHImj4R4ySuyDDUmeCQ4cTBe0eIAZI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-lNlPoC29OFamk-hxzlevLw-1; Wed,
 04 Jun 2025 09:27:44 -0400
X-MC-Unique: lNlPoC29OFamk-hxzlevLw-1
X-Mimecast-MFC-AGG-ID: lNlPoC29OFamk-hxzlevLw_1749043664
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9861180047F; Wed,  4 Jun 2025 13:27:43 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E17E419560AE; Wed,  4 Jun 2025 13:27:41 +0000 (UTC)
Date: Wed, 4 Jun 2025 15:27:33 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: virsh migrate fails when --copy-storage-all option is given!
Message-ID: <aEBJxUIYRaOKBiCL@angien.pipo.sk>
References: <31711771-7caa-4ea3-b763-45db6930e28e@linux.ibm.com>
 <aDctC8i7U2J5bmyw@x1.local> <aEA_EtAKVnk0oYej@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEA_EtAKVnk0oYej@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 04, 2025 at 14:41:54 +0200, Kevin Wolf wrote:
> Am 28.05.2025 um 17:34 hat Peter Xu geschrieben:
> > Copy Kevin.
> > 
> > On Wed, May 28, 2025 at 07:21:12PM +0530, Anushree Mathur wrote:
> > > Hi all,
> > > 
> > > 
> > > When I am trying to migrate the guest from host1 to host2 with the command
> > > line as follows:
> > > 
> > > date;virsh migrate --live --domain guest1 qemu+ssh://dest/system --verbose
> > > --undefinesource --persistent --auto-converge --postcopy
> > > --copy-storage-all;date
> > > 
> > > and it fails with the following error message-
> > > 
> > > error: internal error: unable to execute QEMU command 'block-export-add':
> > > Block node is read-only
> > > 
> > > HOST ENV:
> > > 
> > > qemu : QEMU emulator version 9.2.2
> > > libvirt : libvirtd (libvirt) 11.1.0
> > > Seen with upstream qemu also
> > > 
> > > Steps to reproduce:
> > > 1) Start the guest1
> > > 2) Migrate it with the command as
> > > 
> > > date;virsh migrate --live --domain guest1 qemu+ssh://dest/system --verbose
> > > --undefinesource --persistent --auto-converge --postcopy
> > > --copy-storage-all;date
> > > 
> > > 3) It fails as follows:
> > > error: internal error: unable to execute QEMU command 'block-export-add':
> > > Block node is read-only
> 
> I assume this is about an inactive block node. Probably on the
> destination, but that's not clear to me from the error message.

Yes this would be on the destination. Libvirt exports the nodes on
destination, source connects and does the blockjob.

The destination side is configured the same way as the source side so
if the source disk is configured as read-write the destination should be
as well

> > > Things I analyzed-
> > > 1) This issue is not happening if I give --unsafe option in the virsh
> > > migrate command

This is weird; this shouldn't have any impact.

> 
> What does this translate to on the QEMU command line?
> 
> > > 2) O/P of qemu-monitor command also shows ro as false
> > > 
> > > virsh qemu-monitor-command guest1 --pretty --cmd '{ "execute": "query-block"

it'd be impossible to execute this on the guest due to timing; you'll
need to collect libvirt debug logs to do that:

https://www.libvirt.org/kbase/debuglogs.html#tl-dr-enable-debug-logs-for-most-common-scenario

I also thing this should be eventually filed in a 

> > > }'
> > > {
> > >   "return": [
> > >     {
> > >       "io-status": "ok",
> > >       "device": "",
> > >       "locked": false,
> > >       "removable": false,
> > >       "inserted": {
> > >         "iops_rd": 0,
> > >         "detect_zeroes": "off",
> > >         "image": {
> > >           "virtual-size": 21474836480,
> > >           "filename": "/home/Anu/guest_anu.qcow2",
> > >           "cluster-size": 65536,
> > >           "format": "qcow2",
> > >           "actual-size": 5226561536,
> > >           "format-specific": {
> > >             "type": "qcow2",
> > >             "data": {
> > >               "compat": "1.1",
> > >               "compression-type": "zlib",
> > >               "lazy-refcounts": false,
> > >               "refcount-bits": 16,
> > >               "corrupt": false,
> > >               "extended-l2": false
> > >             }
> > >           },
> > >           "dirty-flag": false
> > >         },
> > >         "iops_wr": 0,
> > >         "ro": false,
> > >         "node-name": "libvirt-1-format",
> > >         "backing_file_depth": 0,
> > >         "drv": "qcow2",
> > >         "iops": 0,
> > >         "bps_wr": 0,
> > >         "write_threshold": 0,
> > >         "encrypted": false,
> > >         "bps": 0,
> > >         "bps_rd": 0,
> > >         "cache": {
> > >           "no-flush": false,
> > >           "direct": false,
> > >           "writeback": true
> > >         },
> > >         "file": "/home/Anu/guest_anu.qcow2"
> > >       },
> > >       "qdev": "/machine/peripheral/virtio-disk0/virtio-backend",
> > >       "type": "unknown"
> > >     }
> > >   ],
> > >   "id": "libvirt-26"
> > > }
> 
> I assume this is still from the source where the image is still active.

Yes; on the destination the process wouldn't be around long enough to
call 'virsh qemu-monitor-command'

> 
> Also it doesn't contain the "active" field yet that was recently
> introduced, which could show something about this. I believe you would
> still get "read-only": false for an inactive image if it's supposed to
> be read-write after the migration completes.
> 
> > > 
> > > 3) Guest doesn't have any readonly
> > > 
> > > virsh dumpxml guest1 | grep readonly
> > > 
> > > 4) Tried giving the proper permissions also
> > > 
> > > -rwxrwxrwx. 1 qemu qemu 4.9G Apr 28 15:06 guest_anu.qcow

Is this on the destination? did you pre-create it yourself? otherwise
libvirt is pre-creating that image for-non-shared-storage migration
(--copy-storage-all) which should have proper permissions when it's
created

> > > 
> > > 5) Checked for the permission of the pool also that is also proper!
> > > 
> > > 6) Found 1 older bug similar to this, pasting the link for reference:
> > > 
> > > 
> > > https://patchwork.kernel.org/project/qemu-devel/patch/20170811164854.GG4162@localhost.localdomain/
> 
> What's happening in detail is more of a virsh/libvirt question. CCing
> Peter Krempa, he might have an idea.

Please collect the debug log; at least from the destination side of
migration. That should show  how the VM is prepared and qemu invoked.


