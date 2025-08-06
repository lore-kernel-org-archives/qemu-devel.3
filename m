Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C87C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 08:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujZdY-00014W-S5; Wed, 06 Aug 2025 04:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujZYw-0006WT-NB
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujZYu-0000Xn-NS
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754469111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6TYGElY1ND+IkDZguUOF83eB4qMCh69hAlnBKcZ3VTI=;
 b=ND+Q2f135Sb8fjXjbjtSCeB8N5DqAhuyu0dvM7oHNvR05T93HDv6Melx71mdo3ZpwdbRle
 EqDRZ3G7yHLbp3GPk7iSiIfYhPgRhTrMTDxK90a3ipJPDTsJIXvHI+5BZ/+ekYnmBw1HEi
 cK0Pb6T6bAUwU9zTnXvBJKPGMLKODfU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-PkJptNZZNKy-utrm6s90fg-1; Wed, 06 Aug 2025 04:31:48 -0400
X-MC-Unique: PkJptNZZNKy-utrm6s90fg-1
X-Mimecast-MFC-AGG-ID: PkJptNZZNKy-utrm6s90fg_1754469104
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-32129c65bf8so3786855a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 01:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754469104; x=1755073904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6TYGElY1ND+IkDZguUOF83eB4qMCh69hAlnBKcZ3VTI=;
 b=f/dsytBlUn9XlaWesanwgMN0LB++wF8TcnE4Kku8h7GsItJJIXUwem6lYhm5tq2IvO
 BG6976mMNsImUrttU4Xf85k0PMB4lFdGJidBqZZ5TBC4N8pg6ScFOQe6jaujm15m+797
 eqkxLOxTlLwxCbwlZOFW6FRuSCl53XRUM+05txjnZqOBkBC2gXQ9/vAAv4YRTsWjSShU
 vaRPubL5g/PF25nvgrlpQyNT4+IgvCctRy+Z1/kMmAiqCsP4+n91Qi9O1RCyteNaTwOv
 rNya2l9RIyiNIims+KVfjWtn3dpbGyuvrr48t/Djnt4qKWkOqOuPUmaTt27x/DqsZB/n
 n7UQ==
X-Gm-Message-State: AOJu0Yz1uxRThxuEUfSpRUJHD6EJkZBpvCFUctU7QlN1B04qb/lxol0w
 Y1L+pjTn+rzp/jbfvevOB9Qjiz/RBFw4oDFT9kI+Ot3rKIWLNaqfpb5RMel7HHHDtLsvo9NE6WZ
 BMxDREll9rZgJnGtVskHoBbNilSfvVYA0ZeqGIaBDTIZa6FHIMZgRCufXYYu5FncgwmNTSjwajW
 sgFz1ErRgIAdvDlBoF1FH0Ij2l+hUsjr4=
X-Gm-Gg: ASbGncuUDcMPIeIaTx+ZOWFY/23ju+XEMYTTEtPWTNooFPNTSxJoa1kt9zhHTtWWZ4L
 iF91IsiCYIi9v/EYfKUs4tMzPKW/qHhVxlT/ZeoR5sise+bbF/nVd/ave/HInaMS1jRgrrKniQ9
 eWB6LJebbeXE3+11XXKvQEhzQghZOyN2GswlaAWFSAZcZeasx1kF1aAA==
X-Received: by 2002:a17:90b:582c:b0:313:5d2f:54f8 with SMTP id
 98e67ed59e1d1-32166cf4386mr3157528a91.33.1754469103625; 
 Wed, 06 Aug 2025 01:31:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdSRw3U2YmlR5P3sQyGqdigdBXvLNzIPYpoPTwDhN7nLCPE4OfFiTx8cikwGeAGhznz+ehIWMy9C8rrHH+ooI=
X-Received: by 2002:a17:90b:582c:b0:313:5d2f:54f8 with SMTP id
 98e67ed59e1d1-32166cf4386mr3157461a91.33.1754469103048; Wed, 06 Aug 2025
 01:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-5-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-5-123450810db7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Aug 2025 12:31:31 +0400
X-Gm-Features: Ac12FXycbSbHjmIxVtfcODs-1qBcIhIxa-05trcWWsRmJkZHpa8cUwoezvpyT6I
Message-ID: <CAMxuvawG4mp_y=FixVwXDjMcOO6HP0f3v1oJ+3n62D4eVJHf4w@mail.gmail.com>
Subject: Re: [PATCH v9 05/27] migration: push Error **errp into
 loadvm_process_command()
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000a848e6063bae2ba4"
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000a848e6063bae2ba4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 5, 2025 at 10:28=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that loadvm_process_command() must report an error
> in errp, in case of failure.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 72
> +++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 52 insertions(+), 20 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> f37c4455dcf839d46f026fc7c7ff02e2dfffe7b4..cb673f43b174249ff1525dba41284de=
2e5a70735
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2546,12 +2546,13 @@ static int
> loadvm_postcopy_handle_switchover_start(void)
>   * LOADVM_QUIT All good, but exit the loop
>   * <0          Error
>   */
> -static int loadvm_process_command(QEMUFile *f)
> +static int loadvm_process_command(QEMUFile *f, Error **errp)
>  {
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      uint16_t cmd;
>      uint16_t len;
>      uint32_t tmp32;
> +    int ret;
>
>      cmd =3D qemu_get_be16(f);
>      len =3D qemu_get_be16(f);
> @@ -2562,16 +2563,16 @@ static int loadvm_process_command(QEMUFile *f)
>      }
>
>      if (cmd >=3D MIG_CMD_MAX || cmd =3D=3D MIG_CMD_INVALID) {
> -        error_report("MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
> +        error_setg(errp, "MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
>          return -EINVAL;
>      }
>
>      trace_loadvm_process_command(mig_cmd_args[cmd].name, len);
>
>      if (mig_cmd_args[cmd].len !=3D -1 && mig_cmd_args[cmd].len !=3D len)=
 {
> -        error_report("%s received with bad length - expecting %zu, got
> %d",
> -                     mig_cmd_args[cmd].name,
> -                     (size_t)mig_cmd_args[cmd].len, len);
> +        error_setg(errp, "%s received with bad length - expecting %zu,
> got %d",
> +                   mig_cmd_args[cmd].name,
> +                   (size_t)mig_cmd_args[cmd].len, len);
>          return -ERANGE;
>      }
>
> @@ -2594,11 +2595,10 @@ static int loadvm_process_command(QEMUFile *f)
>           * been created.
>           */
>          if (migrate_switchover_ack() && !mis->switchover_ack_pending_num=
)
> {
> -            int ret =3D migrate_send_rp_switchover_ack(mis);
> +            ret =3D migrate_send_rp_switchover_ack(mis);
>              if (ret) {
> -                error_report(
> -                    "Could not send switchover ack RP MSG, err %d (%s)",
> ret,
> -                    strerror(-ret));
> +                error_setg_errno(errp, -ret,
> +                                 "Could not send switchover ack RP MSG")=
;
>                  return ret;
>              }
>          }
> @@ -2608,39 +2608,71 @@ static int loadvm_process_command(QEMUFile *f)
>          tmp32 =3D qemu_get_be32(f);
>          trace_loadvm_process_command_ping(tmp32);
>          if (!mis->to_src_file) {
> -            error_report("CMD_PING (0x%x) received with no return path",
> -                         tmp32);
> +            error_setg(errp, "CMD_PING (0x%x) received with no return
> path",
> +                       tmp32);
>              return -1;
>          }
>          migrate_send_rp_pong(mis, tmp32);
>          break;
>
>      case MIG_CMD_PACKAGED:
> -        return loadvm_handle_cmd_packaged(mis);
> +        ret =3D loadvm_handle_cmd_packaged(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d",
> ret);
> +        }
> +        return ret;
>
>      case MIG_CMD_POSTCOPY_ADVISE:
> -        return loadvm_postcopy_handle_advise(mis, len);
> +        ret =3D loadvm_postcopy_handle_advise(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d",
> ret);
> +        }
> +        return ret;
>
>      case MIG_CMD_POSTCOPY_LISTEN:
> -        return loadvm_postcopy_handle_listen(mis);
> +        ret =3D loadvm_postcopy_handle_listen(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d",
> ret);
> +        }
> +        return ret;
>
>      case MIG_CMD_POSTCOPY_RUN:
> -        return loadvm_postcopy_handle_run(mis);
> +        ret =3D loadvm_postcopy_handle_run(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d",
> ret);
> +        }
> +        return ret;
>
>      case MIG_CMD_POSTCOPY_RAM_DISCARD:
> -        return loadvm_postcopy_ram_handle_discard(mis, len);
> +        ret =3D loadvm_postcopy_ram_handle_discard(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d",
> ret);
> +        }
> +        return ret;
>
>      case MIG_CMD_POSTCOPY_RESUME:
>          return loadvm_postcopy_handle_resume(mis);
>
>      case MIG_CMD_RECV_BITMAP:
> -        return loadvm_handle_recv_bitmap(mis, len);
> +        ret =3D loadvm_handle_recv_bitmap(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d",
> ret);
> +        }
> +        return ret;
>
>      case MIG_CMD_ENABLE_COLO:
> -        return loadvm_process_enable_colo(mis);
> +        ret =3D loadvm_process_enable_colo(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d",
> ret);
> +        }
> +        return ret;
>
>      case MIG_CMD_SWITCHOVER_START:
> -        return loadvm_postcopy_handle_switchover_start();
> +        ret =3D loadvm_postcopy_handle_switchover_start();
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d",
> ret);
> +        }
> +        return ret;
>      }
>
>      return 0;
> @@ -3074,7 +3106,7 @@ retry:
>              }
>              break;
>          case QEMU_VM_COMMAND:
> -            ret =3D loadvm_process_command(f);
> +            ret =3D loadvm_process_command(f, NULL);
>

The function used to error_report(), you should pass &error_warn to keep
reporting.


>              trace_qemu_loadvm_state_section_command(ret);
>              if ((ret < 0) || (ret =3D=3D LOADVM_QUIT)) {
>                  goto out;
>
> --
> 2.50.1
>
>

--000000000000a848e6063bae2ba4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 5, 2025 =
at 10:28=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" ta=
rget=3D"_blank">armenon@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">This is an incremental step in converting=
 vmstate loading<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that loadvm_process_command() must report an error<br>
in errp, in case of failure.<br>
<br>
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br>
---<br>
=C2=A0migration/savevm.c | 72 +++++++++++++++++++++++++++++++++++++++------=
---------<br>
=C2=A01 file changed, 52 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index f37c4455dcf839d46f026fc7c7ff02e2dfffe7b4..cb673f43b174249ff1525dba412=
84de2e5a70735 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2546,12 +2546,13 @@ static int loadvm_postcopy_handle_switchover_start(=
void)<br>
=C2=A0 * LOADVM_QUIT All good, but exit the loop<br>
=C2=A0 * &lt;0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error<br>
=C2=A0 */<br>
-static int loadvm_process_command(QEMUFile *f)<br>
+static int loadvm_process_command(QEMUFile *f, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MigrationIncomingState *mis =3D migration_incoming_get_=
current();<br>
=C2=A0 =C2=A0 =C2=A0uint16_t cmd;<br>
=C2=A0 =C2=A0 =C2=A0uint16_t len;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t tmp32;<br>
+=C2=A0 =C2=A0 int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0cmd =3D qemu_get_be16(f);<br>
=C2=A0 =C2=A0 =C2=A0len =3D qemu_get_be16(f);<br>
@@ -2562,16 +2563,16 @@ static int loadvm_process_command(QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (cmd &gt;=3D MIG_CMD_MAX || cmd =3D=3D MIG_CMD_INVAL=
ID) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;MIG_CMD 0x%x unknown (len 0=
x%x)&quot;, cmd, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;MIG_CMD 0x%x unknown (l=
en 0x%x)&quot;, cmd, len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_loadvm_process_command(mig_cmd_args[cmd].name, le=
n);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (mig_cmd_args[cmd].len !=3D -1 &amp;&amp; mig_cmd_ar=
gs[cmd].len !=3D len) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s received with bad length=
 - expecting %zu, got %d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mig_cmd_args[cmd].name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(size_t)mig_cmd_args[cmd].len, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s received with bad le=
ngth - expecting %zu, got %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mig_c=
md_args[cmd].name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(size=
_t)mig_cmd_args[cmd].len, len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ERANGE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2594,11 +2595,10 @@ static int loadvm_process_command(QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * been created.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (migrate_switchover_ack() &amp;&amp; !=
mis-&gt;switchover_ack_pending_num) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D migrate_send_rp_swit=
chover_ack(mis);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D migrate_send_rp_switchov=
er_ack(mis);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Could not send switchover ack RP MSG, err %d (%s)&quot;, ret,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stre=
rror(-ret));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(e=
rrp, -ret,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Could not send switchove=
r ack RP MSG&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -2608,39 +2608,71 @@ static int loadvm_process_command(QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp32 =3D qemu_get_be32(f);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_loadvm_process_command_ping(tmp32);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mis-&gt;to_src_file) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CMD_PING (0x%=
x) received with no return path&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0tmp32);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;CMD_PING =
(0x%x) received with no return path&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tmp32);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0migrate_send_rp_pong(mis, tmp32);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_PACKAGED:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_handle_cmd_packaged(mis);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_handle_cmd_packaged(mis);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load device state command: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_POSTCOPY_ADVISE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_postcopy_handle_advise(mis, len)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_postcopy_handle_advise(mis, len=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load device state command: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_POSTCOPY_LISTEN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_postcopy_handle_listen(mis);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_postcopy_handle_listen(mis);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load device state command: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_POSTCOPY_RUN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_postcopy_handle_run(mis);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_postcopy_handle_run(mis);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load device state command: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_POSTCOPY_RAM_DISCARD:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_postcopy_ram_handle_discard(mis,=
 len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_postcopy_ram_handle_discard(mis=
, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load device state command: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_POSTCOPY_RESUME:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return loadvm_postcopy_handle_resume(mis)=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_RECV_BITMAP:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_handle_recv_bitmap(mis, len);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_handle_recv_bitmap(mis, len);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load device state command: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_ENABLE_COLO:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_process_enable_colo(mis);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_process_enable_colo(mis);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load device state command: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_SWITCHOVER_START:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_postcopy_handle_switchover_start=
();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_postcopy_handle_switchover_star=
t();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load device state command: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
@@ -3074,7 +3106,7 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case QEMU_VM_COMMAND:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_process_command(f=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_process_command(f=
, NULL);<br></blockquote><div><br></div><div>The function used to error_rep=
ort(), you should pass &amp;error_warn to keep reporting.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_qemu_loadvm_state_sec=
tion_command(ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((ret &lt; 0) || (ret =
=3D=3D LOADVM_QUIT)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div></div>
</div>

--000000000000a848e6063bae2ba4--


