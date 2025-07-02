Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E33C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWx6X-0001VT-UW; Wed, 02 Jul 2025 09:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWx6M-0001GQ-21
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWx6E-0000nM-Jt
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751461323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NLUShs5M2XQXIAtBKPIU9h1HTe17oq5w8FuuIcCnOL0=;
 b=RnFHuWk9rrQe49G84plcbTOnOBKWXkGjRaVyO9Aojr7uWn+Jjpyzg4jB6qq6wLx3dp/qXr
 Vlx1LH8SgGjs/Z29i1dqJ8wnDrIb8w2SqVZlJ0IBMl2TnGyghh3XxS6PuX60vGtTQ/s0/x
 hWx2GWlle0Kk8UlEZjh/m8wGv3vg7QM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562--64A5iRmNVyG1riXMY36OQ-1; Wed,
 02 Jul 2025 09:01:59 -0400
X-MC-Unique: -64A5iRmNVyG1riXMY36OQ-1
X-Mimecast-MFC-AGG-ID: -64A5iRmNVyG1riXMY36OQ_1751461315
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF1B81800289; Wed,  2 Jul 2025 13:01:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAFDF1956066; Wed,  2 Jul 2025 13:01:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 122AE21E6A27; Wed, 02 Jul 2025 15:01:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Cornelia Huck
 <cohuck@redhat.com>,  Halil Pasic <pasic@linux.ibm.com>,  Eric Farman
 <farman@linux.ibm.com>,  Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Thomas Huth <thuth@redhat.com>,  Christian
 Borntraeger <borntraeger@linux.ibm.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Fam Zheng <fam@euphon.net>,  Nicholas Piggin
 <npiggin@gmail.com>,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Peter
 Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Hailiang Zhang
 <zhanghailiang@xfusion.com>,  Steve Sistare <steven.sistare@oracle.com>,
 qemu-s390x@nongnu.org,  qemu-ppc@nongnu.org,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] migration: Pass Error object errp into vm state
 loading functions
In-Reply-To: <20250702-propagate_tpm_error-v3-1-986d94540528@redhat.com> (Arun
 Menon's message of "Wed, 02 Jul 2025 17:06:50 +0530")
References: <20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com>
 <20250702-propagate_tpm_error-v3-1-986d94540528@redhat.com>
Date: Wed, 02 Jul 2025 15:01:51 +0200
Message-ID: <87ikkawxts.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Arun Menon <armenon@redhat.com> writes:

> - This is an incremental step in converting vmstate loading
>   code to report errors.
> - Minimal changes to the signature and body of the following
>   functions are done,
>   - vmstate_load()
>   - vmstate_load_state()
>   - vmstate_subsection_load()
>   - qemu_load_device_state()
>   - qemu_loadvm_state()
>   - qemu_loadvm_section_start_full()
>   - qemu_loadvm_section_part_end()
>   - qemu_loadvm_state_header()
>   - qemu_loadvm_state_main()
> - error_report() has been replaced with error_setg();
>   and in places where error has been already set,
>   error_prepend() is used to not lose information.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>

[...]

> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..056781b1c21e737583f081594d9f88b32adfd674 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1196,7 +1196,7 @@ extern const VMStateInfo vmstate_info_qlist;
>      }
>  
>  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> -                       void *opaque, int version_id);
> +                       void *opaque, int version_id, Error **errp);
>  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>                         void *opaque, JSONWriter *vmdesc);
>  int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
> diff --git a/migration/colo.c b/migration/colo.c
> index e0f713c837f5da25d67afbd02ceb6c54024ca3af..808c980b4af3199968771cdc6cca3c2451a2f4a6 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
>  static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>                        QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
>  {
> +    ERRP_GUARD();
>      uint64_t total_size;
>      uint64_t value;
>      Error *local_err = NULL;
       int ret;

       bql_lock();
       vm_stop_force_state(RUN_STATE_COLO);
       bql_unlock();
       trace_colo_vm_state_change("run", "stop");

       /* FIXME: This is unnecessary for periodic checkpoint mode */
       colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_REPLY,
                    &local_err);
       if (local_err) {
           error_propagate(errp, local_err);
           return;
       }

Avoid error_propagate() when you have ERRP_GUARD():

       colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_REPLY,
                    errp);
       if (*errp) {
           return;
       }

See the big comment in qapi/error.h for additional guidance.

       colo_receive_check_message(mis->from_src_file,
                          COLO_MESSAGE_VMSTATE_SEND, &local_err);
       if (local_err) {
           error_propagate(errp, local_err);
           return;
       }

Likewise.  More of the same below, not flagging it again.

> @@ -686,11 +687,13 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>  
>      bql_lock();
>      cpu_synchronize_all_states();
> -    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
> +    ret = qemu_loadvm_state_main(mis->from_src_file, mis, &local_err);
>      bql_unlock();
>  
>      if (ret < 0) {
> -        error_setg(errp, "Load VM's live state (ram) error");
> +        if (local_err != NULL) {

How can @local_err be null here?

> +            error_prepend(errp, "Load VM's live state (ram) error");

Since nothing has set @errp so far, it should still point to null.
error_prepend() crashes when passed a pointer to null.

> +        }
>          return;

Returns without setting an error, and leaks @local_err.

Can you pass @errp to qemu_loadvm_state_main() and call it a day?

>      }
>  
> @@ -729,9 +732,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>      bql_lock();
>      vmstate_loading = true;
>      colo_flush_ram_cache();
> -    ret = qemu_load_device_state(fb);
> +    ret = qemu_load_device_state(fb, &local_err);
>      if (ret < 0) {
> -        error_setg(errp, "COLO: load device state failed");
> +        if (*errp != NULL) {
> +            error_prepend(errp, "COLO: load device state failed");
> +        }

Since nothing has set @errp so far, it should still point to null, so
this will never prepend anything.

>          vmstate_loading = false;
>          bql_unlock();
>          return;

Returns without setting an error, and leaks @local_err.

Can you pass @errp to qemu_load_device_state()?

> diff --git a/migration/cpr.c b/migration/cpr.c
> index a50a57edca754b50e68fa9c294b3c89791e62ba8..0fb9fadac905c83689eed2b1193b282da679b6ef 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -235,7 +235,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>          return -ENOTSUP;
>      }
>  
> -    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
> +    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);

If vmstate_load_state() fails, it should set @errp.

>      if (ret) {
>          error_setg(errp, "vmstate_load_state error %d", ret);

Setting it again will trip error_setv()'s assertion.

>          qemu_fclose(f);

I doubt you tested your changes to the error paths.  This is dangerous.

I did not look at the remainder of this patch.

[...]


