Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CC7C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWw4j-0001rl-Te; Wed, 02 Jul 2025 07:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWw4i-0001qc-0a
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWw4W-0001hp-NQ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751457370;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=a+uBT2Y0tVr1XoOEvAdC9W699tybqrH6ghtsRJn9B0A=;
 b=Rg5B/7qGCXyFxpvO8HMtPUETemBEcF7MYWq7Zue5Oz+Lx3QWhE0g2CWrRRaAK1r5uWVCsN
 r0Z2AxbI3QuxA50bIP9C9XZ+Epsf2h16ddbgBYbNZXpkEjIRrU+PdwpmKgXlHKk5i7tMvs
 YI6XLYzIIS+Zpp8gLfCJKHoLe3tq2SU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-bTWja2AoMxapzxV1qSMaKA-1; Wed,
 02 Jul 2025 07:56:07 -0400
X-MC-Unique: bTWja2AoMxapzxV1qSMaKA-1
X-Mimecast-MFC-AGG-ID: bTWja2AoMxapzxV1qSMaKA_1751457365
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ACFB180034E; Wed,  2 Jul 2025 11:56:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A63819560B3; Wed,  2 Jul 2025 11:55:56 +0000 (UTC)
Date: Wed, 2 Jul 2025 12:55:53 +0100
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
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/3] backends/tpm: Propagate vTPM error on migration
 failure
Message-ID: <aGUeSRYXgzpKbrxp@redhat.com>
References: <20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com>
 <20250702-propagate_tpm_error-v3-3-986d94540528@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702-propagate_tpm_error-v3-3-986d94540528@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 02, 2025 at 05:06:52PM +0530, Arun Menon wrote:
> - Use the post_load_with_error() hook to propagate TPM
>   errors.
> - The error object is set if the loading of state fails.
>   It can then be retrieved using QMP command:
>   {"execute" : "query-migrate"}

This is only describing what has been done - good commit messages
should primarily describe why it is being done.

> Buglink: https://issues.redhat.com/browse/RHEL-82826

We shouldn't rely on people reading through the buglink to
learn the 'why' - please summarize the important contextual
info and problem scenario here.

> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  backends/tpm/tpm_emulator.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 4a234ab2c0b19b2604bf0dd8cb5f4540c72a9438..816134d7b4de00a75a3d0b928d160595b17be810 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -819,7 +819,8 @@ static int tpm_emulator_get_state_blobs(TPMEmulator *tpm_emu)
>  static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>                                         uint32_t type,
>                                         TPMSizedBuffer *tsb,
> -                                       uint32_t flags)
> +                                       uint32_t flags,
> +                                       Error **errp)
>  {
>      ssize_t n;
>      ptm_setstate pss;
> @@ -838,17 +839,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>      /* write the header only */
>      if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
>                               offsetof(ptm_setstate, u.req.data), 0, 0) < 0) {
> -        error_report("tpm-emulator: could not set state blob type %d : %s",
> -                     type, strerror(errno));
> +        error_setg(errp, "tpm-emulator: could not set state blob type %d : %s",
> +                   type, strerror(errno));
>          return -1;
>      }
>  
>      /* now the body */
>      n = qemu_chr_fe_write_all(&tpm_emu->ctrl_chr, tsb->buffer, tsb->size);
>      if (n != tsb->size) {
> -        error_report("tpm-emulator: Writing the stateblob (type %d) "
> -                     "failed; could not write %u bytes, but only %zd",
> -                     type, tsb->size, n);
> +        error_setg(errp, "tpm-emulator: Writing the stateblob (type %d) "
> +                   "failed; could not write %u bytes, but only %zd",
> +                   type, tsb->size, n);
>          return -1;
>      }
>  
> @@ -856,17 +857,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>      n = qemu_chr_fe_read_all(&tpm_emu->ctrl_chr,
>                               (uint8_t *)&pss, sizeof(pss.u.resp));
>      if (n != sizeof(pss.u.resp)) {
> -        error_report("tpm-emulator: Reading response from writing stateblob "
> -                     "(type %d) failed; expected %zu bytes, got %zd", type,
> -                     sizeof(pss.u.resp), n);
> +        error_setg(errp, "tpm-emulator: Reading response from writing "
> +                   "stateblob (type %d) failed; expected %zu bytes, "
> +                   "got %zd", type, sizeof(pss.u.resp), n);
>          return -1;
>      }
>  
>      tpm_result = be32_to_cpu(pss.u.resp.tpm_result);
>      if (tpm_result != 0) {
> -        error_report("tpm-emulator: Setting the stateblob (type %d) failed "
> -                     "with a TPM error 0x%x %s", type, tpm_result,
> -                     tpm_emulator_strerror(tpm_result));
> +        error_setg(errp, "tpm-emulator: Setting the stateblob (type %d) "
> +                   "failed with a TPM error 0x%x %s", type, tpm_result,
> +                   tpm_emulator_strerror(tpm_result));
>          return -1;
>      }
>  
> @@ -880,7 +881,7 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>   *
>   * Returns a negative errno code in case of error.
>   */
> -static int tpm_emulator_set_state_blobs(TPMBackend *tb)
> +static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
>  {
>      TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
>      TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
> @@ -894,13 +895,13 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb)
>  
>      if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
>                                      &state_blobs->permanent,
> -                                    state_blobs->permanent_flags) < 0 ||
> +                                    state_blobs->permanent_flags, errp) < 0 ||
>          tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
>                                      &state_blobs->volatil,
> -                                    state_blobs->volatil_flags) < 0 ||
> +                                    state_blobs->volatil_flags, errp) < 0 ||
>          tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
>                                      &state_blobs->savestate,
> -                                    state_blobs->savestate_flags) < 0) {
> +                                    state_blobs->savestate_flags, errp) < 0) {
>          return -EIO;
>      }
>  
> @@ -948,12 +949,12 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
>   *
>   * Returns negative errno codes in case of error.
>   */
> -static int tpm_emulator_post_load(void *opaque, int version_id)
> +static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
>  {
>      TPMBackend *tb = opaque;
>      int ret;
>  
> -    ret = tpm_emulator_set_state_blobs(tb);
> +    ret = tpm_emulator_set_state_blobs(tb, errp);
>      if (ret < 0) {
>          return ret;
>      }
> @@ -969,7 +970,7 @@ static const VMStateDescription vmstate_tpm_emulator = {
>      .name = "tpm-emulator",
>      .version_id = 0,
>      .pre_save = tpm_emulator_pre_save,
> -    .post_load = tpm_emulator_post_load,
> +    .post_load_with_error = tpm_emulator_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
>          VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),
> 
> -- 
> 2.49.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


