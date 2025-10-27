Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44461CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKNn-0001n7-Lk; Mon, 27 Oct 2025 06:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDKNl-0001ma-Qj
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDKNe-0005yf-Pg
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761560590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EmIItdnWN+t32Gs5ZJ4Ok0Ea+T8vAlpMJsDXAdvOJ5Y=;
 b=H0y4da1xSCUzO6JQZiT20QgUY+W8zLMVyjiemJp8/i6VFh5h8zw2jZiBBGxQWiuurLM1WS
 Xh8WskxUi6u5X/fCIx9LgiBnpr7HMdnFCePjTjvixVZuNzoM0EWzysbxVpf7eJxTVEnHY5
 dhhMtN1hfcvr6c29UeDnpFE784bSz8w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-nvM3BvoYNd2JmIYb70eBPQ-1; Mon,
 27 Oct 2025 06:23:07 -0400
X-MC-Unique: nvM3BvoYNd2JmIYb70eBPQ-1
X-Mimecast-MFC-AGG-ID: nvM3BvoYNd2JmIYb70eBPQ_1761560586
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13EB71800657; Mon, 27 Oct 2025 10:23:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA9941955F1B; Mon, 27 Oct 2025 10:23:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 03AE121E6A27; Mon, 27 Oct 2025 11:23:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: peterx@redhat.com,  stefanb@linux.vnet.ibm.com,  farosas@suse.de,
 qemu-devel@nongnu.org,  armbru@redhat.com,  berrange@redhat.com
Subject: Re: [PATCH v3 3/4] migration/vmstate: stop reporting error number
 for new _errp APIs
In-Reply-To: <20251025202649.1122420-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Sat, 25 Oct 2025 23:26:48 +0300")
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-4-vsementsov@yandex-team.ru>
Date: Mon, 27 Oct 2025 11:23:02 +0100
Message-ID: <87tszkod89.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

What do you mean by "new _errp APIs"?  Is it the pre_load_errp(),
post_load_errp(), pre_save_errp() callbacks?

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> First, the handlers should put all needed information into errp,
> we should not append error number here.
>
> Second, the only realization of new _errp API is
> tpm_emulator_post_load(), which on some failure paths returns
> -errno, but on the others simply -1. So printing this additional
> number may be misleading. tpm_emulator.c needs a lot more work
> to report good error message on all error paths.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/vmstate.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index fd066f910e..677e56c84a 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -157,9 +157,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          ret = vmsd->pre_load_errp(opaque, errp);
>          if (ret < 0) {
>              error_prepend(errp, "pre load hook failed for: '%s', "
> -                          "version_id: %d, minimum version_id: %d, "
> -                          "ret: %d: ", vmsd->name, vmsd->version_id,
> -                          vmsd->minimum_version_id, ret);
> +                          "version_id: %d, minimum version_id: %d: ",
> +                          vmsd->name, vmsd->version_id,
> +                          vmsd->minimum_version_id);
>              return ret;
>          }
>      } else if (vmsd->pre_load) {
> @@ -259,8 +259,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          ret = vmsd->post_load_errp(opaque, version_id, errp);
>          if (ret < 0) {
>              error_prepend(errp, "post load hook failed for: %s, version_id: "
> -                          "%d, minimum_version: %d, ret: %d: ", vmsd->name,
> -                          vmsd->version_id, vmsd->minimum_version_id, ret);
> +                          "%d, minimum_version: %d: ", vmsd->name,
> +                          vmsd->version_id, vmsd->minimum_version_id);
>          }
>      } else if (vmsd->post_load) {
>          ret = vmsd->post_load(opaque, version_id);
> @@ -441,8 +441,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>          ret = vmsd->pre_save_errp(opaque, errp);
>          trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>          if (ret < 0) {
> -            error_prepend(errp, "pre-save for %s failed, ret: %d: ",
> -                          vmsd->name, ret);
> +            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
>              return ret;
>          }
>      } else if (vmsd->pre_save) {

All good.  However, there are more error messages with numeric error
codes in this file.  I figure you're leaving them for another day.
That's okay, but I'd suggest to mention this in your commit message.


