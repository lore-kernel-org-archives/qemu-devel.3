Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8990BEF06E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpM9a-0000fr-Qg; Mon, 09 Feb 2026 02:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpM9Y-0000f6-83
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:57:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vpM9W-0008Bw-JC
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770623869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=EuDPFKH0CUApxSbETMSMJcVSp7F1dhGPLx2r7P3FWrA=;
 b=WtofMPo+O1B8NHC3eBMEXQU4/RSLSffnxVcx5ECrNhJldvmuPWKMNjYCN5XWN6sGEGFYH5
 RFc2mKZJfSFErIpAlb3OGRKWh2Q0HhBLJdqVo8VAY7WvSrrv0NQ/5n6AkrsjiOL0SX5RSQ
 ocua7yW9u2Aqf/GwDSoHE81B+BLHpeE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-cCTSg3wwMKCEDfbTthxr2A-1; Mon,
 09 Feb 2026 02:57:45 -0500
X-MC-Unique: cCTSg3wwMKCEDfbTthxr2A-1
X-Mimecast-MFC-AGG-ID: cCTSg3wwMKCEDfbTthxr2A_1770623864
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFC441955F1D; Mon,  9 Feb 2026 07:57:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35C2018004AD; Mon,  9 Feb 2026 07:57:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADF1321E692D; Mon, 09 Feb 2026 08:57:40 +0100 (CET)
Resent-To: bernd@bsbernd.com, fam@euphon.net, hibriansong@gmail.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 09 Feb 2026 08:57:40 +0100
Resent-Message-ID: <87ms1icpsb.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  hreitz@redhat.com,
 kwolf@redhat.com,  eblake@redhat.com,  stefanha@redhat.com,
 fam@euphon.net,  bernd@bsbernd.com
Subject: Re: [Patch v4 6/7] fuse: add 'io-uring' option
In-Reply-To: <20260207120901.17222-7-hibriansong@gmail.com> (Brian Song's
 message of "Sat, 7 Feb 2026 20:09:00 +0800")
References: <20260207120901.17222-1-hibriansong@gmail.com>
 <20260207120901.17222-7-hibriansong@gmail.com>
Date: Mon, 09 Feb 2026 06:24:00 +0100
Message-ID: <87ikc6ebgv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Brian Song <hibriansong@gmail.com> writes:

> This patch adds a new storage export option for storage-export-daemon
> to enable FUSE-over-io_uring via 'io-uring=on|off' (default: off).
>
> The initialization phase performs a protocol handshake via the legacy
> /dev/fuse interface before transitioning to the io_uring mode.
> If multiple IOThreads are configured, the export distributes the uring
> queues to handle requests concurrently.
>
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>

[...]

> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 9ae703ad01..37f2fc47e2 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -184,12 +184,15 @@
>  #     mount the export with allow_other, and if that fails, try again
>  #     without.  (since 6.1; default: auto)
>  #
> +# @io-uring: Use FUSE-over-io-uring.  (since 10.2; default: false)

since 11.0

> +#
>  # Since: 6.0
>  ##
>  { 'struct': 'BlockExportOptionsFuse',
>    'data': { 'mountpoint': 'str',
>              '*growable': 'bool',
> -            '*allow-other': 'FuseExportAllowOther' },
> +            '*allow-other': 'FuseExportAllowOther',
> +            '*io-uring': 'bool' },
>    'if': 'CONFIG_FUSE' }
>
>  ##

With that
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


