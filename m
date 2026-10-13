Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87E8CC6B1D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiT6-0000sc-6Z; Tue, 13 Oct 2026 15:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGiT3-0000sF-LS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGiT0-0001Zp-CU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791920837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dzI7k6tP5IwAQaJkYJKfBSuLXHScHWBq4MGPfz4Iw90=;
 b=MQRe0AKS3dsUFttQFbMpSoYrXzmBbXGSApeZ51hVikFEBsUcGAxgyyuiK4UodOl0xv+WPf
 eZTEpm+xHs9cGjqTJF8vuThf6F44PHY87h7ONWe1i3P6lGnBIiemNmzaWvMDxYSUQDQu9k
 PqbKqtx/j79N+/Dj4XnEnPFcXBalNMM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-MN7e-qskOUKYVkr6sHBZOA-1; Tue,
 13 Oct 2026 19:47:12 +0000
X-MC-Unique: MN7e-qskOUKYVkr6sHBZOA-1
X-Mimecast-MFC-AGG-ID: MN7e-qskOUKYVkr6sHBZOA_1791920831
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1679A18007EF; Tue, 13 Oct 2026 19:47:11 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E34161800592; Tue, 13 Oct 2026 19:47:07 +0000 (UTC)
Date: Tue, 13 Oct 2026 14:47:05 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 akalenyu@redhat.com, Kevin Wolf <kwolf@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v2 4/8] qemu-pr-helper: add PR_HELPER_CLEANUP for live
 migration
Message-ID: <as6HWIAzh0dmJRmi@redhat.com>
References: <20261013181752.1299456-1-stefanha@redhat.com>
 <20261013181752.1299456-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013181752.1299456-5-stefanha@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 13, 2026 at 02:17:48PM -0400, Stefan Hajnoczi wrote:
> Introduce a new vendor-specific SCSI command that acts similar to
> REGISTER AND IGNORE EXISTING KEY but also discards multipathd's state
> (including /etc/multipath/prkeys). This command will be used on the
> source after live migration completes successfully.
> 
> This cleanup step is necessary because multipathd will register the key
> it has stored when the path comes up again. This is undesirable when the
> guest has migrated to another host and can interfere with the migration
> process or the application running inside the guest.
> 
> Add a qemu-pr-manager protocol feature bit indicating that the new
> PR_HELPER_CLEANUP command is available. The command has no CDB fields
> other than OPCODE and the response contains no data aside from the usual
> result and sense data.
> 
> Note that the linker needs an explicit libmpathcmd dependency for
> mpath_disconnect() even though qemu-pr-helper.c already #included the
> mpath_cmd.h header before.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
> - Explicitly reject PR_HELPER_CLEAN commands in scsi_req_new() because
>   this is an internal command that guests cannot send
> - Add missing "forget" in comment (typo)
> ---
>  meson.build              |   2 +
>  include/scsi/constants.h |   1 +
>  scsi/pr-helper.h         |   3 +
>  hw/scsi/scsi-bus.c       |  10 +++
>  scsi/qemu-pr-helper.c    | 146 ++++++++++++++++++++++++++++++++++++---
>  5 files changed, 153 insertions(+), 9 deletions(-)
> 

> +++ b/scsi/qemu-pr-helper.c

> @@ -667,7 +786,8 @@ static int coroutine_fn prh_read_request(PRHelperClient *client,
>      }
>  
>      if (req->cdb[0] != PERSISTENT_RESERVE_OUT &&
> -        req->cdb[0] != PERSISTENT_RESERVE_IN) {
> +        req->cdb[0] != PERSISTENT_RESERVE_IN &&
> +        req->cdb[0] != PR_HELPER_CLEANUP) {
>          error_setg(errp, "Invalid CDB, closing socket.");

Worth removing the trailing . while you are in the neighborhood?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


