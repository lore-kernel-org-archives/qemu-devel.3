Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25857CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfK4-0004OV-92; Tue, 13 Oct 2026 12:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xGfJx-0004Nn-BK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xGfJs-0004oe-Uo
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791908739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pOyq8dxoYiOgO/ZzqkzqWVuLBrAcSNrbQecsYIRS55g=;
 b=TqabRHF1Q0Co6YQjoegggAyWM+aKV7yL9DYnrA0M/UREkTllJfPuof9GAdax7ZOf0w7/Yk
 /An1WjyabHmySG1Xg8/liScobk3LgMQv/Z9fgzL7wU7ZoxgEAaVMni6CATDeV+BHtcdOws
 CGmLjwZbqQdrFvtINM55BzPChjn4aVU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-E5CkkFShNwuP42GUnZ1EnA-1; Tue,
 13 Oct 2026 16:25:36 +0000
X-MC-Unique: E5CkkFShNwuP42GUnZ1EnA-1
X-Mimecast-MFC-AGG-ID: E5CkkFShNwuP42GUnZ1EnA_1791908735
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAE9D1955F11; Tue, 13 Oct 2026 16:25:34 +0000 (UTC)
Received: from [100.90.56.12] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89A071956086; Tue, 13 Oct 2026 16:25:31 +0000 (UTC)
Message-ID: <75739957-f97d-41e7-8439-cd73cd12be25@redhat.com>
Date: Tue, 13 Oct 2026 18:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] pr-manager-helper: add PR_HELPER_CLEANUP command
 support
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: akalenyu@redhat.com, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20261009153058.1089786-1-stefanha@redhat.com>
 <20261009153058.1089786-6-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20261009153058.1089786-6-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/9/26 17:30, Stefan Hajnoczi wrote:
> qemu-pr-helper now supports the vendor-specific PR_HELPER_CLEANUP SCSI
> command. Add support to the client side.

Hi Stefan, up to this point it's all good; qemu-pr-helper works in SCSI 
commands so a vendor-specific command is the obvious way to add the 
functionality---and I'm glad the feature negotiation worked out.

For the next steps, however, I'm not sure about using blk_ioctl to send 
the migration done command from SCSIDevice to BlockBackend, which (if I 
understand correctly) implicitly exposes the command to the guest as well.

In particular, perhaps it makes sense to add a migration_done callback 
to BlockDriverState and BlockBackend?  They can be called either only 
from SCSIGeneric, or from a new block layer migration notifier that 
walks the BlockBackend list.

If instead the command is not exposed to the guest, please just add a 
comment explaining why.

Thanks,

Paolo

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   scsi/pr-manager-helper.c | 20 ++++++++++++++++----
>   scsi/utils.c             |  3 +++
>   2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
> index 26ef3876f0e..fa6611ed676 100644
> --- a/scsi/pr-manager-helper.c
> +++ b/scsi/pr-manager-helper.c
> @@ -38,6 +38,8 @@ struct PRManagerHelper {
>   
>       QemuMutex lock;
>       QIOChannel *ioc;
> +
> +    uint32_t proto_flags; /* flags negotiated with pr-helper */
>   };
>   
>   static void pr_manager_send_status_changed_event(PRManagerHelper *pr_mgr)
> @@ -129,8 +131,9 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
>           goto out_close;
>       }
>   
> -    flags = 0;
> -    r = pr_manager_helper_write(pr_mgr, -1, &flags, sizeof(flags), errp);
> +    pr_mgr->proto_flags = flags & PR_HELPER_FEATURE_CLEANUP;
> +    r = pr_manager_helper_write(pr_mgr, -1, &pr_mgr->proto_flags,
> +                                sizeof(pr_mgr->proto_flags), errp);
>       if (r < 0) {
>           goto out_close;
>       }
> @@ -160,10 +163,19 @@ static int pr_manager_helper_run(PRManager *p,
>           return -EINVAL;
>       }
>   
> +    /* The command is only available when pr-helper supports it */
> +    if (cdb[0] == PR_HELPER_CLEANUP &&
> +        !(pr_mgr->proto_flags & PR_HELPER_FEATURE_CLEANUP)) {
> +        return -ENOTSUP;
> +    }
> +
>       memcpy(cdb, io_hdr->cmdp, io_hdr->cmd_len);
> -    assert(cdb[0] == PERSISTENT_RESERVE_OUT || cdb[0] == PERSISTENT_RESERVE_IN);
> +    assert(cdb[0] == PERSISTENT_RESERVE_OUT ||
> +           cdb[0] == PERSISTENT_RESERVE_IN ||
> +           cdb[0] == PR_HELPER_CLEANUP);
>       expected_dir =
> -        (cdb[0] == PERSISTENT_RESERVE_OUT ? SG_DXFER_TO_DEV : SG_DXFER_FROM_DEV);
> +        (cdb[0] == PERSISTENT_RESERVE_IN ?
> +         SG_DXFER_FROM_DEV : SG_DXFER_TO_DEV);
>       if (io_hdr->dxfer_direction != expected_dir) {
>           return -EINVAL;
>       }
> diff --git a/scsi/utils.c b/scsi/utils.c
> index daee90ecf0e..1ee68e68221 100644
> --- a/scsi/utils.c
> +++ b/scsi/utils.c
> @@ -29,6 +29,9 @@ uint32_t scsi_data_cdb_xfer(uint8_t *buf)
>   
>   uint32_t scsi_cdb_xfer(uint8_t *buf)
>   {
> +    if (buf[0] == PR_HELPER_CLEANUP) {
> +        return 0;
> +    }
>       switch (buf[0] >> 5) {
>       case 0:
>           return buf[4];


