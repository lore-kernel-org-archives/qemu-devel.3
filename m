Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58B3CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENcA-00020X-DW; Wed, 07 Oct 2026 05:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEL6Y-0008Pl-Ny
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEL6Q-0003IB-L8
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791354367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B2e+JsMEsSvJCy/b0oR/ffD1+7AkmhAPg9HYgH1Rk14=;
 b=S+iP65FhrYTmDYmDocHF7xBZxSoekrcA6fkVFWS7uMIuH6jlJC07vtXqvPycFPKY/FLLJ6
 WbXV0k2oeZGORka0KBE4UN1aT2SxDKp4gn1J1rbEzoe9H0RIFiMA3hzYWpJFfHnm62M5VX
 EUluCUe9G45BzOCxK/acVpDowXp73j0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-bH8J3CPtPCq_WEG2WzWhJQ-1; Tue,
 06 Oct 2026 10:19:32 -0400
X-MC-Unique: bH8J3CPtPCq_WEG2WzWhJQ-1
X-Mimecast-MFC-AGG-ID: bH8J3CPtPCq_WEG2WzWhJQ_1791296371
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 638D9191322E; Tue,  6 Oct 2026 14:18:57 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DD161977338; Tue,  6 Oct 2026 14:18:52 +0000 (UTC)
Date: Tue, 6 Oct 2026 09:18:46 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, qemu-stable@nongnu.org
Subject: Re: [PATCH qemu 3/4] block: report flush error during bdrv_close()
Message-ID: <asUBLx7peVoGvX6w@redhat.com>
References: <20260930132140.2342574-1-f.ebner@proxmox.com>
 <20260930132140.2342574-4-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930132140.2342574-4-f.ebner@proxmox.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 30, 2026 at 03:19:24PM +0200, Fiona Ebner wrote:
> Flush during bdrv_close() was introduced back in 2012 in commit
> 80ccf93b88 ("qemu-img: let 'qemu-img convert' flush data"). However, a
> failing flush was quietly ignored [0]. Report the error instead, since
> this could mean that the image contents are not as expected.
> 
> Adapt the iotests accordingly. For all tests except '080' and
> 'qsd-migrate' the failures come from blkdebug configurations. For
> '080', the failures are also directly expected, because of invalid L1
> table size and offset. For the 'qsd-migrate' test, the error happens,
> because the QSD node which is attached via NBD to the source VM was
> inactivated.
> 
> [0]: Note that the errors reported for qcow2 come from
> qcow2_inactivate() which is only called as part of
> bs->drv->bdrv_close() after bdrv_flush(). In particular, adding
> > 'once': 'on'
> to the blkdebug driver in the relevant test case in the 122 iotest
> shows that the failure can be silent in case of qcow2 too.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---

> +++ b/tests/qemu-iotests/026
> @@ -103,13 +103,13 @@ if [ "$event" == "l2_update" ]; then
>      $QEMU_IO -c "write $vmstate 0 512" "$TEST_IMG" > /dev/null 2>&1
>  fi
>  
> -$QEMU_IO -c "write $vmstate 0 128k " "$BLKDBG_TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "write $vmstate 0 128k " "$BLKDBG_TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir

This creates lines longer than 80 columns. Adding \-newline
continuations is an option. But there are plenty of existing long
lines in the iotests, so I don't see that as holding up this patch.

> +++ b/tests/qemu-iotests/122
> @@ -357,15 +357,15 @@ target_fails_flush="json:{
>      }
>  }"
>  
> -$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG".orig "$target_fails_flush"
> -echo "qemu-img convert exited with status $?"
> +$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG".orig "$target_fails_flush" 2>&1 | _filter_json_filename
> +echo "qemu-img convert exited with status ${PIPESTATUS[0]}"

Interesting churn from $? to ${PIPESTATUS[0]} on a line added earlier
in the same series. But using PIPESTATUS when there is no |, while
valid in bash, looks odd, so I don't mind.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


