Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021F1CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 12:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGz7c-0007Ro-Fx; Thu, 06 Nov 2025 07:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGz7a-0007Rb-OP
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:29:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGz7Y-0002Od-7P
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762432183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TttrYqoInh0C1gJwc4I58g68bG2IwMO1qY9mrL3Nze4=;
 b=E90LK/g6Uznx8ihp5rOqrj2Kjz1q9uX7gIQwOXVZmopj3cUqXCIHqgwDvlQD1TRagKG1Nt
 dUjl0q2P6G/EComlEltGS+EuDnVuVH5aMeOZmt+Jy5y6mkxY1MUKo48uwokbi6Ua1u4XcU
 yyYS57IV2i9XOI0xbF/NAUVj6H+UItw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-vp6GTd4TPESyk2i6P3d6jQ-1; Thu,
 06 Nov 2025 07:29:42 -0500
X-MC-Unique: vp6GTd4TPESyk2i6P3d6jQ-1
X-Mimecast-MFC-AGG-ID: vp6GTd4TPESyk2i6P3d6jQ_1762432181
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7294180047F; Thu,  6 Nov 2025 12:29:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2A4E3001E83; Thu,  6 Nov 2025 12:29:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B67D21E6A27; Thu, 06 Nov 2025 13:29:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: peterx@redhat.com,  stefanb@linux.vnet.ibm.com,  farosas@suse.de,
 qemu-devel@nongnu.org,  berrange@redhat.com,  armenon@redhat.com
Subject: Re: [PATCH v4 2/2] tmp_emulator: improve and fix use of errp
In-Reply-To: <20251028130738.29037-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 28 Oct 2025 16:07:38 +0300")
References: <20251028130738.29037-1-vsementsov@yandex-team.ru>
 <20251028130738.29037-3-vsementsov@yandex-team.ru>
Date: Thu, 06 Nov 2025 13:29:37 +0100
Message-ID: <87zf8zfioe.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I know this has been committed already, but I'd like to point out a few
things anyway.

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> tpm_emulator_post_load() and tpm_emulator_set_state_blobs() has
> error paths, where they return negative value, but do not set
> errp.
>
> To fix that, we also have to convert several other functions to
> set errp instead of error_reporting.

Missing Fixes: tag.  Next time :)

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  backends/tpm/tpm_emulator.c | 63 +++++++++++++++++++++++--------------
>  1 file changed, 39 insertions(+), 24 deletions(-)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index dacfca5ab7..6abe9872e6 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -308,22 +308,22 @@ static int tpm_emulator_check_caps(TPMEmulator *tpm_emu)
>      return 0;
>  }
>  
> -static int tpm_emulator_stop_tpm(TPMBackend *tb)
> +static int tpm_emulator_stop_tpm(TPMBackend *tb, Error **errp)
>  {
>      TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
>      ptm_res res;
>  
>      if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0,
>                               sizeof(ptm_res), sizeof(res)) < 0) {
> -        error_report("tpm-emulator: Could not stop TPM: %s",
> -                     strerror(errno));
> +        error_setg(errp, "tpm-emulator: Could not stop TPM: %s",
> +                   strerror(errno));

Not this patch's fault: use of @errno is dubious.
tpm_emulator_ctrlcmd() fails when qemu_chr_fe_write_all() or
qemu_chr_fe_read_all() fails.  These functions are not documented to set
errno on failure, and I doubt they do in all cases.

>          return -1;
>      }
>  
>      res = be32_to_cpu(res);
>      if (res) {
> -        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x %s", res,
> -                     tpm_emulator_strerror(res));
> +        error_setg(errp, "tpm-emulator: TPM result for CMD_STOP: 0x%x %s", res,
> +                   tpm_emulator_strerror(res));
>          return -1;
>      }
>  
> @@ -362,12 +362,13 @@ static int tpm_emulator_lock_storage(TPMEmulator *tpm_emu)
>  
>  static int tpm_emulator_set_buffer_size(TPMBackend *tb,
>                                          size_t wanted_size,
> -                                        size_t *actual_size)
> +                                        size_t *actual_size,
> +                                        Error **errp)
>  {
>      TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
>      ptm_setbuffersize psbs;
>  
> -    if (tpm_emulator_stop_tpm(tb) < 0) {
> +    if (tpm_emulator_stop_tpm(tb, errp) < 0) {
>          return -1;
>      }
>  
> @@ -376,16 +377,17 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
>      if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_BUFFERSIZE, &psbs,
>                               sizeof(psbs.u.req), sizeof(psbs.u.resp.tpm_result),
>                               sizeof(psbs.u.resp)) < 0) {
> -        error_report("tpm-emulator: Could not set buffer size: %s",
> -                     strerror(errno));
> +        error_setg(errp, "tpm-emulator: Could not set buffer size: %s",
> +                   strerror(errno));

Likewise.

>          return -1;
>      }
>  
>      psbs.u.resp.tpm_result = be32_to_cpu(psbs.u.resp.tpm_result);
>      if (psbs.u.resp.tpm_result != 0) {
> -        error_report("tpm-emulator: TPM result for set buffer size : 0x%x %s",
> -                     psbs.u.resp.tpm_result,
> -                     tpm_emulator_strerror(psbs.u.resp.tpm_result));
> +        error_setg(errp,
> +                   "tpm-emulator: TPM result for set buffer size : 0x%x %s",
> +                   psbs.u.resp.tpm_result,
> +                   tpm_emulator_strerror(psbs.u.resp.tpm_result));
>          return -1;
>      }
>  
> @@ -402,7 +404,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
>  }
>  
>  static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
> -                                     bool is_resume)
> +                                           bool is_resume, Error **errp)
>  {
>      TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
>      ptm_init init = {
> @@ -413,7 +415,7 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
>      trace_tpm_emulator_startup_tpm_resume(is_resume, buffersize);
>  
>      if (buffersize != 0 &&
> -        tpm_emulator_set_buffer_size(tb, buffersize, NULL) < 0) {
> +        tpm_emulator_set_buffer_size(tb, buffersize, NULL, errp) < 0) {
>          goto err_exit;
>      }
>  
> @@ -424,15 +426,15 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
>      if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
>                               sizeof(init.u.resp.tpm_result),
>                               sizeof(init)) < 0) {
> -        error_report("tpm-emulator: could not send INIT: %s",
> -                     strerror(errno));
> +        error_setg(errp, "tpm-emulator: could not send INIT: %s",
> +                   strerror(errno));
>          goto err_exit;
>      }
>  
>      res = be32_to_cpu(init.u.resp.tpm_result);
>      if (res) {
> -        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x %s", res,
> -                     tpm_emulator_strerror(res));
> +        error_setg(errp, "tpm-emulator: TPM result for CMD_INIT: 0x%x %s", res,
> +                   tpm_emulator_strerror(res));
>          goto err_exit;
>      }
>      return 0;
> @@ -441,18 +443,31 @@ err_exit:
>      return -1;
>  }
>  
> -static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
> +static int do_tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize,
> +                                       Error **errp)
>  {
>      /* TPM startup will be done from post_load hook */
>      if (runstate_check(RUN_STATE_INMIGRATE)) {
>          if (buffersize != 0) {
> -            return tpm_emulator_set_buffer_size(tb, buffersize, NULL);
> +            return tpm_emulator_set_buffer_size(tb, buffersize, NULL, errp);
>          }
>  
>          return 0;
>      }
>  
> -    return tpm_emulator_startup_tpm_resume(tb, buffersize, false);
> +    return tpm_emulator_startup_tpm_resume(tb, buffersize, false, errp);
> +}
> +
> +static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
> +{
> +    Error *local_err = NULL;
> +    int ret = do_tpm_emulator_startup_tpm(tb, buffersize, &local_err);
> +
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
> +
> +    return ret;
>  }
>  
>  static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
> @@ -546,7 +561,7 @@ static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
>  {
>      size_t actual_size;
>  
> -    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size) < 0) {
> +    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size, NULL) < 0) {

As Stefan pointed out, this loses an error report.  Before the patch,
tpm_emulator_set_buffer_size() reports errors with error_report().  Now
it ignores errors.  Please fix.

>          return 4096;
>      }
>  
> @@ -889,7 +904,7 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
>  
>      trace_tpm_emulator_set_state_blobs();
>  
> -    if (tpm_emulator_stop_tpm(tb) < 0) {
> +    if (tpm_emulator_stop_tpm(tb, errp) < 0) {

Big fix here, ...

>          trace_tpm_emulator_set_state_blobs_error("Could not stop TPM");
>          return -EIO;
>      }
> @@ -960,7 +975,7 @@ static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
>          return ret;
>      }
>  
> -    if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
> +    if (tpm_emulator_startup_tpm_resume(tb, 0, true, errp) < 0) {

... and here.  Good.

>          return -EIO;
>      }


