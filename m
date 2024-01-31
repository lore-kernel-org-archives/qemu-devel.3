Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B4DC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV8Fi-0004rO-Ec; Wed, 31 Jan 2024 05:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rV8Fd-0004hA-OK
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:55:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rV8FU-000146-7Q
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706698515;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1kT8gFAXjvNkdmg7VFaKQP0MrzdMnCiqgaJz/8f2Qn4=;
 b=LP0kYBkvQAQJER8rclPtSO61dihDtP/ZMZOgEjcV+1xIaxLZUAF+Mlq+T07f+C+PpIQRDW
 tcTiRQPbiGFmncZXsS1g/DJTxDi/RHvj7jJk4yYFDwoIGPegKanZy+Hi0/YDAaoRurhQSF
 xBMmInZX+skvE/1/Adn8I39NWwYx3GA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-wKLE1SMoPZ-DKcIQPTcevg-1; Wed, 31 Jan 2024 05:55:12 -0500
X-MC-Unique: wKLE1SMoPZ-DKcIQPTcevg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6D1985A589;
 Wed, 31 Jan 2024 10:55:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E005C2590D;
 Wed, 31 Jan 2024 10:55:09 +0000 (UTC)
Date: Wed, 31 Jan 2024 10:55:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 1/7] crypto: Support LUKS volume with detached header
Message-ID: <ZbonCqvVUC7fH_I2@redhat.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
 <d597f01ce328442940f5dd4653cf7ec75fe0ce02.1706586786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d597f01ce328442940f5dd4653cf7ec75fe0ce02.1706586786.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 30, 2024 at 01:37:19PM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> By enhancing the LUKS driver, it is possible to implement
> the LUKS volume with a detached header.
> 
> Normally a LUKS volume has a layout:
>   disk:  | header | key material | disk payload data |
> 
> With a detached LUKS header, you need 2 disks so getting:
>   disk1:  | header | key material |
>   disk2:  | disk payload data |
> 
> There are a variety of benefits to doing this:
>  * Secrecy - the disk2 cannot be identified as containing LUKS
>              volume since there's no header
>  * Control - if access to the disk1 is restricted, then even
>              if someone has access to disk2 they can't unlock
>              it. Might be useful if you have disks on NFS but
>              want to restrict which host can launch a VM
>              instance from it, by dynamically providing access
>              to the header to a designated host
>  * Flexibility - your application data volume may be a given
>                  size and it is inconvenient to resize it to
>                  add encryption.You can store the LUKS header
>                  separately and use the existing storage
>                  volume for payload
>  * Recovery - corruption of a bit in the header may make the
>               entire payload inaccessible. It might be
>               convenient to take backups of the header. If
>               your primary disk header becomes corrupt, you
>               can unlock the data still by pointing to the
>               backup detached header
> 
> Take the raw-format image as an example to introduce the usage
> of the LUKS volume with a detached header:
> 
> 1. prepare detached LUKS header images
> $ dd if=/dev/zero of=test-header.img bs=1M count=32
> $ dd if=/dev/zero of=test-payload.img bs=1M count=1000
> $ cryptsetup luksFormat --header test-header.img test-payload.img
> > --force-password --type luks1
> 
> 2. block-add a protocol blockdev node of payload image
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments":{"node-name":"libvirt-1-storage", "driver":"file",
> > "filename":"test-payload.img"}}'
> 
> 3. block-add a protocol blockdev node of LUKS header as above.
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments":{"node-name":"libvirt-2-storage", "driver":"file",
> > "filename": "test-header.img" }}'
> 
> 4. object-add the secret for decrypting the cipher stored in
>    LUKS header above
> $ virsh qemu-monitor-command vm '{"execute":"object-add",
> > "arguments":{"qom-type":"secret", "id":
> > "libvirt-2-storage-secret0", "data":"abc123"}}'
> 
> 5. block-add the raw-drived blockdev format node
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments":{"node-name":"libvirt-1-format", "driver":"raw",
> > "file":"libvirt-1-storage"}}'
> 
> 6. block-add the luks-drived blockdev to link the raw disk
>    with the LUKS header by specifying the field "header"
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments":{"node-name":"libvirt-2-format", "driver":"luks",
> > "file":"libvirt-1-format", "header":"libvirt-2-storage",
> > "key-secret":"libvirt-2-format-secret0"}}'
> 
> 7. hot-plug the virtio-blk device finally
> $ virsh qemu-monitor-command vm '{"execute":"device_add",
> > "arguments": {"num-queues":"1", "driver":"virtio-blk-pci",
> > "drive": "libvirt-2-format", "id":"virtio-disk2"}}'
> 
> Starting a VM with a LUKS volume with detached header is
> somewhat similar to hot-plug in that both maintaining the
> same json command while the starting VM changes the
> "blockdev-add/device_add" parameters to "blockdev/device".
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  block/crypto.c         | 21 +++++++++++++++++++--
>  crypto/block-luks.c    | 11 +++++++----
>  include/crypto/block.h |  5 +++++
>  qapi/block-core.json   |  5 ++++-
>  4 files changed, 35 insertions(+), 7 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


