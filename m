Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C7606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bp5CM1KX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqMk-0006P9-Cv; Fri, 30 Oct 2026 13:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMqMh-0006OP-Kh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMqMX-0005Sn-Oz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793381156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4e24YNhNgAr9GAHFFvSfucjjQCxQNePcq3tV1Oh3ifU=;
 b=Bp5CM1KXz9fIMRb12bqCox1tQVLRrdal0cbI9drhnq2TTirZiFaMlDvMHBq7REa3ZdLRka
 7CZfyvypXFuO3BgXlHMjS9b7VDYNyNmr68dpYiO5ize+kOFI/lCc1E6c6Jp4z39gwqY20t
 BnmSt760MZtOjZHuH8dI+vRd2nG3OT8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-6-gYWplyNVedz-rwiz8nsg-1; Fri,
 30 Oct 2026 13:25:50 -0400
X-MC-Unique: 6-gYWplyNVedz-rwiz8nsg-1
X-Mimecast-MFC-AGG-ID: 6-gYWplyNVedz-rwiz8nsg_1793381148
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49F071955EAC; Fri, 30 Oct 2026 17:25:47 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.76])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F1491956087; Fri, 30 Oct 2026 17:25:43 +0000 (UTC)
Date: Fri, 30 Oct 2026 18:25:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 1/3] block: add bdrv_open_backing_chain_until
Message-ID: <auTTFW6aKUds7qHQ@redhat.com>
References: <20260915140444.1223798-1-jean-louis@dupond.be>
 <20260915140444.1223798-2-jean-louis@dupond.be>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915140444.1223798-2-jean-louis@dupond.be>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 15.09.2026 um 16:04 hat Jean-Louis Dupond geschrieben:
> Add a new function called bdrv_open_backing_chain_until.
> This is used to open a block up until a specified backing chain.
> 
> Modified bdrv_open_inherit to accept a new arg
> 'open_backing_recursively' to force to not open the next backing.
> Adjusting all references to keep the existing behaviour.
> 
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>

Do you actually have a use case where limiting the backing chain is a
requirement? It looks a bit like premature optimisation, because for
running a VM, you'll open the whole chain anyway, so it can't be
unworkably long.

> diff --git a/block.c b/block.c
> index f0a6042e61..9763137d8c 100644
> --- a/block.c
> +++ b/block.c
> @@ -83,6 +83,7 @@ static QLIST_HEAD(, BlockDriver) bdrv_drivers =
>  static BlockDriverState *bdrv_open_inherit(const char *filename,
>                                             const char *reference,
>                                             QDict *options, int flags,
> +                                           bool open_backing_recursively,
>                                             BlockDriverState *parent,
>                                             const BdrvChildClass *child_class,
>                                             BdrvChildRole child_role,

bdrv_open_inherit() already has too many parameters. Can't you just pass
BDRV_O_NO_BACKING instead of adding a new one?

> @@ -3733,6 +3735,54 @@ free_exit:
>      return ret;
>  }
>  
> +int
> +bdrv_open_backing_chain_until(BlockDriverState *top_bs,
> +                              const char *base_filename,
> +                              Error **errp)
> +{
> +    BlockDriverState *curr = top_bs;
> +    int ret;
> +
> +    GLOBAL_STATE_CODE();
> +
> +    if (!base_filename) {
> +        return 0;
> +    }
> +
> +    if (bdrv_find_backing_image(top_bs, base_filename)) {
> +        return 0;
> +    }
> +
> +    while (true) {
> +        QDict *options = qdict_clone_shallow(curr->options);
> +
> +        ret = bdrv_open_backing_file(curr, options, false, "backing", errp);
> +        qobject_unref(options);

Does this actually do anything? I don't think curr->options can contain
"backing" options when you opened it without backing files. It would
already fail during the initial open because bdrv_open_backing_file()
doesn't absorb the options, so they are considered unknown:

$ ./qemu-img info --image-opts driver=qcow2,file.filename=/tmp/overlay.qcow2,backing=foo
qemu-img: Could not open 'driver=qcow2,file.filename=/tmp/overlay.qcow2,backing=foo': Block format 'qcow2' does not support the option 'backing'

(Using 'qemu-img info' as an example that uses BDRV_O_NO_BACKING.)

In your specific 'qemu-img measure' implementation, it seems even
impossible to specify backing file options in the BDRV_O_NO_BACKING case
in the first place because --image-opts disables the partial loading.
Which might actually be another reason not to do the partial opening at
all because it's inconsistent behaviour.

> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        bdrv_graph_rdlock_main_loop();
> +        if (!curr->backing) {
> +            bdrv_graph_rdunlock_main_loop();
> +            error_setg(errp,
> +                       "Did not find '%s' in the backing chain of '%s'",
> +                       base_filename, top_bs->filename);
> +            return -ENOENT;
> +        }
> +        bdrv_graph_rdunlock_main_loop();
> +
> +        if (bdrv_find_backing_image(curr, base_filename)) {
> +            return 0;
> +        }
> +
> +        /* Switch to the next layer */
> +        bdrv_graph_rdlock_main_loop();
> +        curr = curr->backing->bs;
> +        bdrv_graph_rdunlock_main_loop();
> +    }
> +}

Kevin


