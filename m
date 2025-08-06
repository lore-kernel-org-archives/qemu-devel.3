Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B9AC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYff-0002on-Ki; Wed, 06 Aug 2025 03:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujYfe-0002nd-4i
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujYfb-0005iz-MB
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754465682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QLEa9NrZzKdhm+Ao2VSmztVIYTf4G2AXsQTmofjgkEg=;
 b=ZVZYeqDQ8WLxO0p9IPGag5yzyUiHrWdUwwtAhsXbN6GqxSpuC2ra4eESTA3ntIhBEacLTY
 VC5m6wBD2txk/CI4YxiV9Cx6Qta29wxgywhgUA0jarJZSEbLOoKXjWmQXZ0RGzIhWrLLsS
 hkoFXUxpnU9fMh9Z3ISSwEDTULtVv1Y=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-2cmAJVRNPLOz36UEyAxbFA-1; Wed, 06 Aug 2025 03:34:41 -0400
X-MC-Unique: 2cmAJVRNPLOz36UEyAxbFA-1
X-Mimecast-MFC-AGG-ID: 2cmAJVRNPLOz36UEyAxbFA_1754465680
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-539393fdacbso1997268e0c.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754465677; x=1755070477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QLEa9NrZzKdhm+Ao2VSmztVIYTf4G2AXsQTmofjgkEg=;
 b=mbKTxlXvh2LOzkzQmksC5nn55qcTe3sHU434N+8o4k0Xqfj2WBCxINQte1sSSsGpLx
 O0JPA0Xy+bS+tod1dMR6nefcWjundMIrR9obzc1OVfDcDXc7SmmgICraXvQnYr81rKqO
 SdJ6TXUs21h/7VHvzn792PySDmm+ykZbYV/APdYxgTuUmQ+kNshQaxio/kON81pdP/OR
 MKx2hNSCkx7/wkeiQdAFB+a7jxAseOIdUrZjFK3ghg/G82tZdvrXGHt7Vvj7G080kY77
 4drbRwZZoEPlhDgt6k5m68nWBfwG/svv3IpN/FeifiC8kyko3FgQowzPhevqBzszrr4q
 FUHw==
X-Gm-Message-State: AOJu0Yz0uXQsdduB/ULckVqp2dd/VlGL0lDIKnxIKEVsFS0XqBQExuzf
 xrv+aZ2D8pfhg+WDKr+YpH3TpZ2Dk7dT/vc6m18ljf/YYKm+S0sQ/iE7s5SqLy7Un6JNlYswH5h
 ypzEtEBO/y1f84MLsRmbYGt4pTeE5PdD944zTo4E0HmJglxkUVK6d6Cd7WldjCG+NrkHBblMNRF
 IpXTNxa72YPbJe0fbkAwv3ZMrhO5xHym4=
X-Gm-Gg: ASbGncuapTPJ6NkYaVgAV1GXMgpQkfIAEDK9t295YEnTV3B+Tw+B9l9biQNLA3srH98
 zkeMXLgaPxIelXVvGSJW062vJy8TjAv9B7UFtpJ9en4JXw1WnLi5yZiK0pVxiFPgLVPNWe7MNwY
 WuFK2P9EhF5Iq6wrTK3s2NBCzs0F2xeBR8kZ30fUyfQ4cSzlXfLNlBAA==
X-Received: by 2002:a05:6122:2a15:b0:539:3bb5:e4c8 with SMTP id
 71dfb90a1353d-539a153628dmr548483e0c.12.1754465676753; 
 Wed, 06 Aug 2025 00:34:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMzUPDfPebLnaHf5t27TVixx/g6MJrdQ6ZrPyPaNM8n5SkqbRkiZndl4vF/Ji110W17aaEXqN7p9TI+GzTBgg=
X-Received: by 2002:a05:6122:2a15:b0:539:3bb5:e4c8 with SMTP id
 71dfb90a1353d-539a153628dmr548455e0c.12.1754465676300; Wed, 06 Aug 2025
 00:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-9-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-9-123450810db7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Aug 2025 11:34:23 +0400
X-Gm-Features: Ac12FXxeeNuH991PbPNrjt9a41JeJriO6aV_S9oOdl3KjIz3gMiRhjV80uNLhYA
Message-ID: <CAMxuvawFudjv_jHY6Gz2wfmFFXT9UNwrB1MnmXVpGFBrPr31Yw@mail.gmail.com>
Subject: Re: [PATCH v9 09/27] migration: push Error **errp into
 qemu_loadvm_state_main()
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000682bd1063bad5fbd"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000682bd1063bad5fbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 5, 2025 at 10:29=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_state_main() must report an error
> in errp, in case of failure.
> loadvm_process_command also sets the errp object explicitly.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/colo.c   |  5 +++--
>  migration/savevm.c | 33 ++++++++++++++++++++-------------
>  migration/savevm.h |  3 ++-
>  3 files changed, 25 insertions(+), 16 deletions(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index
> 0ba22ee76a13e313793f653f43a728e3c433bbc1..a96e4dba15516b71d1b315c736c3b48=
79ff04e58
> 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
>  static void colo_incoming_process_checkpoint(MigrationIncomingState *mis=
,
>                        QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp=
)
>  {
> +    ERRP_GUARD();
>      uint64_t total_size;
>      uint64_t value;
>      Error *local_err =3D NULL;
> @@ -686,11 +687,11 @@ static void
> colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>
>      bql_lock();
>      cpu_synchronize_all_states();
> -    ret =3D qemu_loadvm_state_main(mis->from_src_file, mis);
> +    ret =3D qemu_loadvm_state_main(mis->from_src_file, mis, errp);
>      bql_unlock();
>
>      if (ret < 0) {
> -        error_setg(errp, "Load VM's live state (ram) error");
> +        error_prepend(errp, "Load VM's live state (ram) error: ");
>          return;
>      }
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> f3b91c8ae0eee6078406081f0bd7f686fed28601..ad3dd9b172afc541f104d2187a79baf=
a8e380466
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2105,7 +2105,7 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      qemu_file_set_blocking(f, true);
>
>      /* TODO: sanity check that only postcopiable data will be loaded her=
e
> */
> -    load_res =3D qemu_loadvm_state_main(f, mis);
> +    load_res =3D qemu_loadvm_state_main(f, mis, NULL);
>

What's the rationale to make the function silent or not gather the error?
It seems error reporting could be improved below this. Maybe pass
&error_warn here, and add a second TODO to improve error handling?


>
>      /*
>       * This is tricky, but, mis->from_src_file can change after it
> @@ -2407,6 +2407,7 @@ static int
> loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>   */
>  static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error
> **errp)
>  {
> +    ERRP_GUARD();
>      int ret;
>      size_t length;
>      QIOChannelBuffer *bioc;
> @@ -2456,9 +2457,9 @@ static int
> loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
>          qemu_coroutine_yield();
>      } while (1);
>
> -    ret =3D qemu_loadvm_state_main(packf, mis);
> +    ret =3D qemu_loadvm_state_main(packf, mis, errp);
>      if (ret < 0) {
> -        error_setg(errp, "VM state load failed: %d", ret);
> +        error_prepend(errp, "Loading VM state failed: %d: ", ret);
>      }
>      trace_loadvm_handle_cmd_packaged_main(ret);
>      qemu_fclose(packf);
> @@ -3074,8 +3075,10 @@ static bool
> postcopy_pause_incoming(MigrationIncomingState *mis)
>      return true;
>  }
>
> -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> +                           Error **errp)
>  {
> +    ERRP_GUARD();
>      uint8_t section_type;
>      int ret =3D 0;
>
> @@ -3083,8 +3086,10 @@ retry:
>      while (true) {
>          section_type =3D qemu_get_byte(f);
>
> -        ret =3D qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_ds=
t,
> NULL);
> +        ret =3D qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_ds=
t,
> errp);
>          if (ret) {
> +            error_prepend(errp, "Failed to load device state section ID:
> %d: ",
> +                          ret);
>              break;
>          }
>
> @@ -3105,7 +3110,7 @@ retry:
>              }
>              break;
>          case QEMU_VM_COMMAND:
> -            ret =3D loadvm_process_command(f, NULL);
> +            ret =3D loadvm_process_command(f, errp);
>              trace_qemu_loadvm_state_section_command(ret);
>              if ((ret < 0) || (ret =3D=3D LOADVM_QUIT)) {
>                  goto out;
> @@ -3115,7 +3120,7 @@ retry:
>              /* This is the end of migration */
>              goto out;
>          default:
> -            error_report("Unknown savevm section type %d", section_type)=
;
> +            error_setg(errp, "Unknown savevm section type %d",
> section_type);
>              ret =3D -EINVAL;
>              goto out;
>          }
> @@ -3123,6 +3128,9 @@ retry:
>
>  out:
>      if (ret < 0) {
> +        if (*errp =3D=3D NULL) {
> +            error_setg(errp, "Loading VM state failed: %d", ret);
> +        }
>          qemu_file_set_error(f, ret);
>
>          /* Cancel bitmaps incoming regardless of recovery */
> @@ -3143,6 +3151,8 @@ out:
>              migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
>              /* Reset f to point to the newly created channel */
>              f =3D mis->from_src_file;
> +            error_free(*errp);
> +            *errp =3D NULL;
>              goto retry;
>          }
>      }
> @@ -3176,10 +3186,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
>
>      cpu_synchronize_all_pre_loadvm();
>
> -    ret =3D qemu_loadvm_state_main(f, mis);
> -    if (ret < 0) {
> -        error_setg(errp, "Load VM state failed: %d", ret);
> -    }
> +    ret =3D qemu_loadvm_state_main(f, mis, errp);
>      qemu_event_set(&mis->main_thread_load_event);
>
>      trace_qemu_loadvm_state_post_main(ret);
> @@ -3260,9 +3267,9 @@ int qemu_load_device_state(QEMUFile *f, Error **err=
p)
>      int ret;
>
>      /* Load QEMU_VM_SECTION_FULL section */
> -    ret =3D qemu_loadvm_state_main(f, mis);
> +    ret =3D qemu_loadvm_state_main(f, mis, errp);
>      if (ret < 0) {
> -        error_setg(errp, "Failed to load device state: %d", ret);
> +        error_prepend(errp, "Failed to load device state: %d: ", ret);
>          return ret;
>      }
>
> diff --git a/migration/savevm.h b/migration/savevm.h
> index
> b12681839f0b1afa3255e45215d99c13a224b19f..c337e3e3d111a7f28a57b90f61e8f70=
b71803d4e
> 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);
>
>  int qemu_loadvm_state(QEMUFile *f, Error **errp);
>  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> +                           Error **errp);
>  int qemu_load_device_state(QEMUFile *f, Error **errp);
>  int qemu_loadvm_approve_switchover(void);
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>
> --
> 2.50.1
>
>

--000000000000682bd1063bad5fbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 5, 2025 at 10:29=
=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com">armenon@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">This is an incremental step in converting vmstate loading<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that qemu_loadvm_state_main() must report an error<br>
in errp, in case of failure.<br>
loadvm_process_command also sets the errp object explicitly.<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br>
---<br>
=C2=A0migration/colo.c=C2=A0 =C2=A0|=C2=A0 5 +++--<br>
=C2=A0migration/savevm.c | 33 ++++++++++++++++++++-------------<br>
=C2=A0migration/savevm.h |=C2=A0 3 ++-<br>
=C2=A03 files changed, 25 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/migration/colo.c b/migration/colo.c<br>
index 0ba22ee76a13e313793f653f43a728e3c433bbc1..a96e4dba15516b71d1b315c736c=
3b4879ff04e58 100644<br>
--- a/migration/colo.c<br>
+++ b/migration/colo.c<br>
@@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)<br>
=C2=A0static void colo_incoming_process_checkpoint(MigrationIncomingState *=
mis,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0uint64_t total_size;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t value;<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
@@ -686,11 +687,11 @@ static void colo_incoming_process_checkpoint(Migratio=
nIncomingState *mis,<br>
<br>
=C2=A0 =C2=A0 =C2=A0bql_lock();<br>
=C2=A0 =C2=A0 =C2=A0cpu_synchronize_all_states();<br>
-=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_main(mis-&gt;from_src_file, mis);<=
br>
+=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_main(mis-&gt;from_src_file, mis, e=
rrp);<br>
=C2=A0 =C2=A0 =C2=A0bql_unlock();<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Load VM&#39;s live stat=
e (ram) error&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;Load VM&#39;s live s=
tate (ram) error: &quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index f3b91c8ae0eee6078406081f0bd7f686fed28601..ad3dd9b172afc541f104d2187a7=
9bafa8e380466 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2105,7 +2105,7 @@ static void *postcopy_ram_listen_thread(void *opaque)=
<br>
=C2=A0 =C2=A0 =C2=A0qemu_file_set_blocking(f, true);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* TODO: sanity check that only postcopiable data will =
be loaded here */<br>
-=C2=A0 =C2=A0 load_res =3D qemu_loadvm_state_main(f, mis);<br>
+=C2=A0 =C2=A0 load_res =3D qemu_loadvm_state_main(f, mis, NULL);<br></bloc=
kquote><div><br></div><div>What&#39;s the rationale to make the function si=
lent or not gather the error? It seems error reporting could be improved be=
low this. Maybe pass &amp;error_warn here, and add a second TODO to improve=
 error handling?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * This is tricky, but, mis-&gt;from_src_file can chang=
e after it<br>
@@ -2407,6 +2407,7 @@ static int loadvm_postcopy_handle_resume(MigrationInc=
omingState *mis)<br>
=C2=A0 */<br>
=C2=A0static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Er=
ror **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0size_t length;<br>
=C2=A0 =C2=A0 =C2=A0QIOChannelBuffer *bioc;<br>
@@ -2456,9 +2457,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomi=
ngState *mis, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_coroutine_yield();<br>
=C2=A0 =C2=A0 =C2=A0} while (1);<br>
<br>
-=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_main(packf, mis);<br>
+=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_main(packf, mis, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;VM state load failed: %=
d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;Loading VM state fai=
led: %d: &quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0trace_loadvm_handle_cmd_packaged_main(ret);<br>
=C2=A0 =C2=A0 =C2=A0qemu_fclose(packf);<br>
@@ -3074,8 +3075,10 @@ static bool postcopy_pause_incoming(MigrationIncomin=
gState *mis)<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)<br>
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0uint8_t section_type;<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
<br>
@@ -3083,8 +3086,10 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0while (true) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0section_type =3D qemu_get_byte(f);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D qemu_file_get_error_obj_any(f, mis-&gt=
;postcopy_qemufile_dst, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D qemu_file_get_error_obj_any(f, mis-&gt=
;postcopy_qemufile_dst, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;Failed=
 to load device state section ID: %d: &quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -3105,7 +3110,7 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case QEMU_VM_COMMAND:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_process_command(f=
, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_process_command(f=
, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_qemu_loadvm_state_sec=
tion_command(ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((ret &lt; 0) || (ret =
=3D=3D LOADVM_QUIT)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
@@ -3115,7 +3120,7 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* This is the end of migra=
tion */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Unknown savev=
m section type %d&quot;, section_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Unknown s=
avevm section type %d&quot;, section_type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -3123,6 +3128,9 @@ retry:<br>
<br>
=C2=A0out:<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*errp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Loading V=
M state failed: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_file_set_error(f, ret);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Cancel bitmaps incoming regardless of =
recovery */<br>
@@ -3143,6 +3151,8 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0migrate_postcopy_ram() &amp=
;&amp; postcopy_pause_incoming(mis)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Reset f to point to the =
newly created channel */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f =3D mis-&gt;from_src_file=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(*errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *errp =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto retry;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -3176,10 +3186,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0cpu_synchronize_all_pre_loadvm();<br>
<br>
-=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_main(f, mis);<br>
-=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Load VM state failed: %=
d&quot;, ret);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_main(f, mis, errp);<br>
=C2=A0 =C2=A0 =C2=A0qemu_event_set(&amp;mis-&gt;main_thread_load_event);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0trace_qemu_loadvm_state_post_main(ret);<br>
@@ -3260,9 +3267,9 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)=
<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Load QEMU_VM_SECTION_FULL section */<br>
-=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_main(f, mis);<br>
+=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_main(f, mis, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to load device s=
tate: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;Failed to load devic=
e state: %d: &quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/migration/savevm.h b/migration/savevm.h<br>
index b12681839f0b1afa3255e45215d99c13a224b19f..c337e3e3d111a7f28a57b90f61e=
8f70b71803d4e 100644<br>
--- a/migration/savevm.h<br>
+++ b/migration/savevm.h<br>
@@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);<br>
<br>
=C2=A0int qemu_loadvm_state(QEMUFile *f, Error **errp);<br>
=C2=A0void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);<br>
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);<br>
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Error **errp);<br>
=C2=A0int qemu_load_device_state(QEMUFile *f, Error **errp);<br>
=C2=A0int qemu_loadvm_approve_switchover(void);<br>
=C2=A0int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div></div>

--000000000000682bd1063bad5fbd--


