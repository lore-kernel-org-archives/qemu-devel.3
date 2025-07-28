Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D89FC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 09:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugJjA-0003cE-Am; Mon, 28 Jul 2025 05:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugJbs-0005Ly-OW
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugJbp-0005VP-Jr
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753692804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0zdI+aAOp35DNvhXeKA8jNoZz/yRr2u0N6PM6ZPBLaw=;
 b=dplL1qFxCOovn+pQD6upA18y/utIYMQ/7ZF3ZHcHflopvy+PBaJiGdCBd/poLBO+4mJZco
 +4avHRG9QZaSegEN5Ri1Ir/tfwqfSTOcnq/XVq22985HyO8R9W2pvfVWJ8jGIPA6otxD+6
 25ZrAUk8HMTVZgaktd0ba8fQ/SQv/7o=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-U5Keq0SHOLSpzDOaNJfaWg-1; Mon, 28 Jul 2025 04:53:21 -0400
X-MC-Unique: U5Keq0SHOLSpzDOaNJfaWg-1
X-Mimecast-MFC-AGG-ID: U5Keq0SHOLSpzDOaNJfaWg_1753692801
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-4e7f71f7b23so4322811137.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 01:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753692801; x=1754297601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0zdI+aAOp35DNvhXeKA8jNoZz/yRr2u0N6PM6ZPBLaw=;
 b=p9UXIR/ph2iWS/p125eM7I1l0gCLZoH21BAv8+XbKnnlneVWUeZYqTtgcY2IAfHG3C
 FBdIZzTxyaXBxNIalnoesz5WRGBVye4u9XjOMJevOg5sM3o8BjBt6lyrxW0I15MrguAQ
 G71HelmvEeRWIivKJBSHVkmQgP0FrtYFwSgqcLgbthqxalRBKON3JTB0ToB2eMUr7QRR
 l1go6DdR4S53wabDr9+BtV+mMW7JEmqv7nR3ZtvFLbUDoMB12vnnMaOQMeSSyjXKtM7+
 2kqoIhlSNQI5tfcCmOnZ5I89EpzGoKhWmFdGJZAKLQ8XmGyXXvj01T8YH8wCha7aGrSX
 IPRA==
X-Gm-Message-State: AOJu0YyaH9Ffid+lubcS7UNbGDZH20CDyPhxpOAIsWiSpOt91ukjgaL1
 SRDmcmWvV9gd6meFW543ZmRY0ypDPC1UCp07H+81PR1zaqdDXqHlJEqNqXtSS1ATGlczq9of2Ee
 AsB/DR+32zYeAdW/zjTR5934TWieJ7exxJEx5eC1J7vH7OI1Hpf97ra+mShQE1dzZBpCEvumIE5
 UQpon0AUHHrlVvmhj8UoT1Anpf0aKeAso=
X-Gm-Gg: ASbGncson60iD5CT68HYz3hYroy2LLSCaIJbyHrzlq+g8rmTGwixlGUPRdgr+G/y1Em
 EC21j/IMSgWJeFo16L+EGV95wTTPdv0qULA/Ny/GAagXTfkQaYMlBKFEBvk8Pz482UBz+0+Un9a
 5IWMqMVHoXXf4xbj3tmuEG2Ce9fhvJrfXXwnOUpdqjzQ/GNrbvGmXjRw==
X-Received: by 2002:a05:6102:3ca1:b0:4e7:866c:5cd2 with SMTP id
 ada2fe7eead31-4fa3fa677bbmr3921148137.2.1753692801161; 
 Mon, 28 Jul 2025 01:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFri64QlIu5JhveC3nUcfdSg2QWLMEUz3oqq49vQmvf8vlfKrHe8O24GsFsLJih8s0VsrChWO+F7NWDZdG1r+8=
X-Received: by 2002:a05:6102:3ca1:b0:4e7:866c:5cd2 with SMTP id
 ada2fe7eead31-4fa3fa677bbmr3921133137.2.1753692800800; Mon, 28 Jul 2025
 01:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-9-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-9-d52704443975@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 28 Jul 2025 12:53:07 +0400
X-Gm-Features: Ac12FXwLvA1lh9JCwV6OXpVjMI9-q2C7CHmqLvhck1UnkkvOPJP0ky8UEESqCWU
Message-ID: <CAMxuvay0cdcxyoYZEGFysw4+n1ExqwJ7Z+kTrMmm2=qzX8gNeg@mail.gmail.com>
Subject: Re: [PATCH v7 09/24] migration: push Error **errp into
 loadvm_process_command()
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: multipart/alternative; boundary="0000000000006fea1f063af96c2a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--0000000000006fea1f063af96c2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jul 25, 2025 at 4:20=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that loadvm_process_command() must report an error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 73
> +++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 20 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> ad96da3651b89023e4b70ffeecab46d176bae6f5..d40b25d74be46b209be8f28d10b7538=
a5ff2e3dd
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2544,12 +2544,13 @@ static int
> loadvm_postcopy_handle_switchover_start(void)
>   * LOADVM_QUIT All good, but exit the loop
>   * <0          Error
>   */
> -static int loadvm_process_command(QEMUFile *f)
> +static int loadvm_process_command(QEMUFile *f, Error **errp)
>  {
>

better with ERRP_GUARD


>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      uint16_t cmd;
>      uint16_t len;
>      uint32_t tmp32;
> +    int ret;
>
>      cmd =3D qemu_get_be16(f);
>      len =3D qemu_get_be16(f);
> @@ -2560,16 +2561,16 @@ static int loadvm_process_command(QEMUFile *f)
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
> @@ -2588,11 +2589,11 @@ static int loadvm_process_command(QEMUFile *f)
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
> +                error_setg(errp,
> +                           "Could not send switchover ack RP MSG, err %d
> (%s)",
> +                           ret, strerror(-ret));
>

You could switch to using "error_setg_errno(errp, -ret.."  instead.

                 return ret;
>              }
>          }
> @@ -2602,40 +2603,72 @@ static int loadvm_process_command(QEMUFile *f)
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
>          loadvm_postcopy_handle_resume(mis);
>          return 0;
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
> @@ -3075,7 +3108,7 @@ retry:
>              }
>              break;
>          case QEMU_VM_COMMAND:
> -            ret =3D loadvm_process_command(f);
> +            ret =3D loadvm_process_command(f, NULL);
>              trace_qemu_loadvm_state_section_command(ret);
>              if ((ret < 0) || (ret =3D=3D LOADVM_QUIT)) {
>                  goto out;
>
> --
> 2.50.0
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--0000000000006fea1f063af96c2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25, 2=
025 at 4:20=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com"=
>armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">This is an incremental step in converting vmstate loadin=
g<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that loadvm_process_command() must report an error<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br>
---<br>
=C2=A0migration/savevm.c | 73 +++++++++++++++++++++++++++++++++++++++------=
---------<br>
=C2=A01 file changed, 53 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index ad96da3651b89023e4b70ffeecab46d176bae6f5..d40b25d74be46b209be8f28d10b=
7538a5ff2e3dd 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2544,12 +2544,13 @@ static int loadvm_postcopy_handle_switchover_start(=
void)<br>
=C2=A0 * LOADVM_QUIT All good, but exit the loop<br>
=C2=A0 * &lt;0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error<br>
=C2=A0 */<br>
-static int loadvm_process_command(QEMUFile *f)<br>
+static int loadvm_process_command(QEMUFile *f, Error **errp)<br>
=C2=A0{<br></blockquote><div><br></div><div>better with ERRP_GUARD</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0MigrationIncomingState *mis =3D migration_incoming_get_=
current();<br>
=C2=A0 =C2=A0 =C2=A0uint16_t cmd;<br>
=C2=A0 =C2=A0 =C2=A0uint16_t len;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t tmp32;<br>
+=C2=A0 =C2=A0 int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0cmd =3D qemu_get_be16(f);<br>
=C2=A0 =C2=A0 =C2=A0len =3D qemu_get_be16(f);<br>
@@ -2560,16 +2561,16 @@ static int loadvm_process_command(QEMUFile *f)<br>
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
@@ -2588,11 +2589,11 @@ static int loadvm_process_command(QEMUFile *f)<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;Could not send switchover ack RP MSG, err %d =
(%s)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ret, strerror(-ret));<br></blockquote><div><br></di=
v><div>You could switch to using &quot;error_setg_errno(errp, -ret..&quot;=
=C2=A0 instead.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -2602,40 +2603,72 @@ static int loadvm_process_command(QEMUFile *f)<br>
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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loadvm_postcopy_handle_resume(mis);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
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
@@ -3075,7 +3108,7 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case QEMU_VM_COMMAND:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_process_command(f=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_process_command(f=
, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_qemu_loadvm_state_sec=
tion_command(ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((ret &lt; 0) || (ret =
=3D=3D LOADVM_QUIT)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
<br>
-- <br>
2.50.0<br></blockquote><div><br></div><div><br></div><div>Reviewed-by: Marc=
-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marca=
ndre.lureau@redhat.com</a>&gt;=C2=A0</div></div></div>

--0000000000006fea1f063af96c2a--


