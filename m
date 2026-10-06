Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0D2CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENZ5-0004zX-VQ; Wed, 07 Oct 2026 05:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEL4o-000805-7v
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEL4c-000321-Ms
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791354255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hzBp6ihl1ptjDQ3ae3tTHAsLb81tvGUGwEUX+Kfip/0=;
 b=fPWeO4KUCEOwN9EQxXxSg64UENebtKbGObpPftKe/nJ1DoDLDPqj4Senq7JbChI5kN6RKr
 NZuYO1lavv60GfCBIDLBKxHrjHghcdeqPkTG0C/13wy2czNYR8EfzVR4DLMYhzTPaLl9Iz
 IefnDJlrFzbGs9NlPh9F1awDc6Ai87Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-suKqnCmlNYyIKYsLqZZqqg-1; Tue,
 06 Oct 2026 06:02:06 -0400
X-MC-Unique: suKqnCmlNYyIKYsLqZZqqg-1
X-Mimecast-MFC-AGG-ID: suKqnCmlNYyIKYsLqZZqqg_1791280925
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86D791935D17; Tue,  6 Oct 2026 10:02:04 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DE6F1956052; Tue,  6 Oct 2026 10:02:01 +0000 (UTC)
Date: Tue, 6 Oct 2026 12:01:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v4 1/5] qcow2: do not clear the dirty bit when reopening
 a read-only node
Message-ID: <asTHF2HCT4Ku6XIV@redhat.com>
References: <20260824133729.1141990-1-den@openvz.org>
 <20260824133729.1141990-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824133729.1141990-2-den@openvz.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 24.08.2026 um 15:37 hat Denis V. Lunev geschrieben:
> From: Denis V. Lunev <den@openvz.org>
> 
> qcow2_reopen_prepare() clears the dirty bit whenever the node is
> reopened read-only, with an unguarded header write. A read-only node
> can still be dirty, inherited from an earlier writable session, and it
> holds no BLK_PERM_WRITE to resolve that. A read-only to read-only
> reopen of a dirty image therefore fails outright:
> 
>   $ qemu-io -r -f qcow2 dirty.qcow2 <<< $'reopen -r\nquit'
>   qemu-io: failed while preparing to reopen image 'dirty.qcow2'
> 
> Where the file node below is writable the write is not refused early,
> and bdrv_co_write_req_prepare() aborts on its BLK_PERM_WRITE assertion
> instead.
> 
> Clear it only for a node that is writable now, the predicate
> qcow2_do_open() already uses for the repair. bdrv_is_writable() also
> excludes an inactive node, whose header must not be touched either.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: qemu-stable@nongnu.org

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


