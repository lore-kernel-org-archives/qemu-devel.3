Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D206AC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucUDp-00079p-Bk; Thu, 17 Jul 2025 15:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucRsh-0000lA-0e
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucRse-0008Sh-5c
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752771287;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1hnP2N81isxfdjl/8L9hYbyrsJxStRUl9RGndJBQ54o=;
 b=iyuSEm0kAuhG4P//mxJbtFBrQPnZ+Fut75TNhxm1FWmRxkUXSN2gwGBK7t3X0KY/MJeQEu
 /KJ6bjYkVaA3CHh6AL0USHlaycLrHWyPxOW4dpmQkmC918r0+n8X73j8RsWilzIf0lwV2t
 XgFKCb+F8sc4f6Ff2mtenuID0pdrrbI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-NN1KyYkjNbyZNDgpuLxsWQ-1; Thu,
 17 Jul 2025 12:54:44 -0400
X-MC-Unique: NN1KyYkjNbyZNDgpuLxsWQ-1
X-Mimecast-MFC-AGG-ID: NN1KyYkjNbyZNDgpuLxsWQ_1752771281
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D6BC1800296; Thu, 17 Jul 2025 16:54:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.171])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC9FF1800D82; Thu, 17 Jul 2025 16:54:32 +0000 (UTC)
Date: Thu, 17 Jul 2025 17:54:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v5 07/23] migration: push Error **errp into
 loadvm_process_command()
Message-ID: <aHkqxfMNeA6_YSBP@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-7-1f406f88ee65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717-propagate_tpm_error-v5-7-1f406f88ee65@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 17, 2025 at 06:07:30AM +0530, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that loadvm_process_command() must report an error
> in errp, in case of failure.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 89 ++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 67 insertions(+), 22 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 22d73999595384519c755c9416b74ba1263a8bb9..98711bb38a4548d4f168459f729f604a78716c25 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2540,12 +2540,13 @@ static int loadvm_postcopy_handle_switchover_start(void)
>   * LOADVM_QUIT All good, but exit the loop
>   * <0          Error
>   */
> -static int loadvm_process_command(QEMUFile *f)
> +static int loadvm_process_command(QEMUFile *f, Error **errp)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      uint16_t cmd;
>      uint16_t len;
>      uint32_t tmp32;
> +    int ret;
>  
>      cmd = qemu_get_be16(f);
>      len = qemu_get_be16(f);
> @@ -2556,16 +2557,16 @@ static int loadvm_process_command(QEMUFile *f)
>      }
>  
>      if (cmd >= MIG_CMD_MAX || cmd == MIG_CMD_INVALID) {
> -        error_report("MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
> +        error_setg(errp, "MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
>          return -EINVAL;
>      }
>  


> @@ -2578,7 +2579,7 @@ static int loadvm_process_command(QEMUFile *f)
>          }
>          mis->to_src_file = qemu_file_get_return_path(f);
>          if (!mis->to_src_file) {
> -            error_report("CMD_OPEN_RETURN_PATH failed");
> +            error_setg(errp, "CMD_OPEN_RETURN_PATH failed");

This is a wierd one, according to the docs qemu_file_get_return_path
can return NULL, but according to the impl it will always succeed.

Suggest creating an earlier patch that fixes the docs and removes
the check for failure here, not least because this existing error
message provides no useful information, and none will be available
since it can't fail.


>      case MIG_CMD_PACKAGED:
> -        return loadvm_handle_cmd_packaged(mis);
> +        ret = loadvm_handle_cmd_packaged(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>  
>      case MIG_CMD_POSTCOPY_ADVISE:
> -        return loadvm_postcopy_handle_advise(mis, len);
> +        ret = loadvm_postcopy_handle_advise(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>  
>      case MIG_CMD_POSTCOPY_LISTEN:
> -        return loadvm_postcopy_handle_listen(mis);
> +        ret = loadvm_postcopy_handle_listen(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>  
>      case MIG_CMD_POSTCOPY_RUN:
> -        return loadvm_postcopy_handle_run(mis);
> +        ret = loadvm_postcopy_handle_run(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>  
>      case MIG_CMD_POSTCOPY_RAM_DISCARD:
> -        return loadvm_postcopy_ram_handle_discard(mis, len);
> +        ret = loadvm_postcopy_ram_handle_discard(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>  
>      case MIG_CMD_POSTCOPY_RESUME:
> -        return loadvm_postcopy_handle_resume(mis);
> +        ret = loadvm_postcopy_handle_resume(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>  
>      case MIG_CMD_RECV_BITMAP:
> -        return loadvm_handle_recv_bitmap(mis, len);
> +        ret = loadvm_handle_recv_bitmap(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>  
>      case MIG_CMD_ENABLE_COLO:
> -        return loadvm_process_enable_colo(mis);
> +        ret = loadvm_process_enable_colo(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>  
>      case MIG_CMD_SWITCHOVER_START:
> -        return loadvm_postcopy_handle_switchover_start();
> +        ret = loadvm_postcopy_handle_switchover_start();
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>      }

Can you ensure that each of these have unique error message strings,
as if they ever appear, it will be important to distinguish which of
these nine commands actually failed.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


