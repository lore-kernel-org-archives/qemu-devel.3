Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7D4CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMvc-0003l0-Ht; Wed, 07 Oct 2026 04:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEHcw-0005Sc-AI
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEHch-0002vW-Ii
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791340840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcxsU9YZHTxQmbiICp3WUHDwdUGeVaNTJP3Lvumpaxs=;
 b=XRVaiZL7FTIDEE3p3861tnTx4hRs18EMt3HW+GygRVBulJ5D7JS72YCcLZpO2Z1spwuDrW
 hb8TNIGASGNA/bKNN0zAm6Kj4SkrhYGDJJFptQc1ZFRFZwPiQ9TKuRiOmQ4e0ustslPyw6
 Ox3PwbGQccB5orNOFOnPBXrRtbwtViw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-HxTwYjn1MM-3ib6z3tSXvg-1; Tue,
 06 Oct 2026 11:49:50 -0400
X-MC-Unique: HxTwYjn1MM-3ib6z3tSXvg-1
X-Mimecast-MFC-AGG-ID: HxTwYjn1MM-3ib6z3tSXvg_1791301789
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F00DB19539BA; Tue,  6 Oct 2026 15:49:48 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7FEF180057F; Tue,  6 Oct 2026 15:49:44 +0000 (UTC)
Date: Tue, 6 Oct 2026 10:49:39 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2 2/3] blockdev: mirror: do not require a root block node
Message-ID: <asUYAuFY65BE-8dE@redhat.com>
References: <20261006114240.478523-1-f.ebner@proxmox.com>
 <20261006114240.478523-3-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006114240.478523-3-f.ebner@proxmox.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Tue, Oct 06, 2026 at 01:42:17PM +0200, Fiona Ebner wrote:
> The mirror block job currently only operates on a root block node. It
> might be desired to use a throttle node as the root node for limiting
> the guest IO, without also limiting mirror operations.
> 
> There is no obvious reason why mirror should only be able to operate
> on a root block node.
> 
> When there is no explicit @replaces argument, implicit filters on top
> are skipped. Allowing mirror to operate on non-root nodes does not
> change that fact and keeps the behavior consistent with the
> documentation for @replaces.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


