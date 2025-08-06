Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB19C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYzd-0001kr-Hu; Wed, 06 Aug 2025 03:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujYzA-0001Wp-8Z
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujYz7-0001ga-TR
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754466892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qbyNbgJl9dQOxfDltChI6N8IT7G4tc0MpIj1NL0ig6A=;
 b=eSTosc1JlnwRJ6QgGHeWx7I+W2gq8Sv6jN7cz6r+q7dBGdlsui0CWzQ5CrHbuk8N20O00U
 /9FMmthyh9IlRXIIbogXHoyMSOGg0AD9eFzxKEnPGlizHPkk0e8OPKS2gLGDAgr7LTD572
 n2mz+AT0gNio31YK9osVBOQGQq/U7sk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-Dzhu2V-4O02oEuX4gnWFtw-1; Wed, 06 Aug 2025 03:54:49 -0400
X-MC-Unique: Dzhu2V-4O02oEuX4gnWFtw-1
X-Mimecast-MFC-AGG-ID: Dzhu2V-4O02oEuX4gnWFtw_1754466888
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31eac278794so6549104a91.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754466888; x=1755071688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qbyNbgJl9dQOxfDltChI6N8IT7G4tc0MpIj1NL0ig6A=;
 b=TbXkspEo9P0D8MSLnL+vcY3VEJggkLDb6RhfOcoUICLwvNDhBY0sJYuFm7/SHa11mn
 zo0b7C9mM+XKivRDL6UBVYJQQtUUKiy47lcNWRmpJaRGKQFwVZSb/db57fUMGcytEsRY
 qud8oeMiZWhfaP9KmH6qjdpIqpmlZg4y2X+OeF35Zsr48JDlx3IAuC+M9ZUuBoBJk9nP
 D8TTfKFWV7dvUX2PLT4J29FYTWByvi8g8JjbV72gN8J2LMYBkzYbtj4W6Ms8WqQehCjA
 8dkgwIRI8Z34w3vqlQuLAiWukHy10U2zegqG+YT4OKpXsr3Datomi8ImYgtTpB9kenGd
 1gZw==
X-Gm-Message-State: AOJu0Yy/SyB+K9/TtD8wPeyxi4TQIVMNJEH70md5Nn7XwD4dyv1uTyEt
 tSEiGuLxT0WDinDmHX/Iug2T+Svzc8j4UmJTsOXXJOxtLAawAONRkfUZskrjwchz4K8HcusHVRl
 eLiEO3AkVz8Z3GflUVLlv9vfLTIAOmrqC9ngYsfFii12NDdn0OdEeScQDzgCNPzZxJnnOTqeTVf
 g6eop2/6sM2i77tJ80dnbtmqN6DZNxB/M=
X-Gm-Gg: ASbGncta3npMmS/WDZ9+MBmWjA1XdHGNWv4W9Y2uKlLWHTdShi3WlI2FA/9F5nKnG0z
 jXUOivzXBOQwcnQN7nwKpDhWRUc9gAafh4+iAaKRrUjD49r7zwRivR4uO8RX1gMsTioIpT9llu3
 eqvhoHe/UJDymMX/8vBCRnLBCto8sO1+SWi3D7vnI5K9KBb6tYssRJVA==
X-Received: by 2002:a17:90b:528e:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-32166c167d2mr2431099a91.5.1754466888348; 
 Wed, 06 Aug 2025 00:54:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9J/KC3S/3N2IPxPBhqlQFxO3vCElG7dBJn7+KQJ/hvYlobzRb0e179++p0fFphlJRtISwIh/0ijqil/jBUBs=
X-Received: by 2002:a17:90b:528e:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-32166c167d2mr2431064a91.5.1754466888001; Wed, 06 Aug 2025
 00:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-18-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-18-123450810db7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Aug 2025 11:54:36 +0400
X-Gm-Features: Ac12FXwyMEeTYa7LCdzRNlmkHKedu-W05sXYPCAWSj3XqPB-jJYm-jLGA3mYAsw
Message-ID: <CAMxuvay5ysmMXw14SBZtY7M2mJdoq4Fk2MYD-JjXurBCPZwLEQ@mail.gmail.com>
Subject: Re: [PATCH v9 18/27] migration: push Error **errp into
 loadvm_postcopy_ram_handle_discard()
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
Content-Type: multipart/alternative; boundary="000000000000a1451e063bada7e5"
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

--000000000000a1451e063bada7e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 5, 2025 at 10:30=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that loadvm_postcopy_ram_handle_discard() must report an
> error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/savevm.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> eb90873a750ded354b3db31cba40b44d1be79864..3abe4193e02aae9c813ff07fb388a7e=
e470c8a6a
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2004,7 +2004,7 @@ static int
> loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
>   * There can be 0..many of these messages, each encoding multiple pages.
>   */
>  static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mi=
s,
> -                                              uint16_t len)
> +                                              uint16_t len, Error **errp=
)
>  {
>      int tmp;
>      char ramid[256];
> @@ -2017,6 +2017,7 @@ static int
> loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
>          /* 1st discard */
>          tmp =3D postcopy_ram_prepare_discard(mis);
>          if (tmp) {
> +            error_setg(errp, "Failed to prepare for RAM discard: %d",
> tmp);
>              return tmp;
>          }
>          break;
> @@ -2026,8 +2027,9 @@ static int
> loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
>          break;
>
>      default:
> -        error_report("CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state
> (%d)",
> -                     ps);
> +        error_setg(errp,
> +                   "CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state
> (%d)",
> +                   ps);
>          return -1;
>      }
>      /* We're expecting a
> @@ -2036,29 +2038,30 @@ static int
> loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
>       *    then at least 1 16 byte chunk
>      */
>      if (len < (1 + 1 + 1 + 1 + 2 * 8)) {
> -        error_report("CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len=
);
> +        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid length (%d)",
> len);
>          return -1;
>      }
>
>      tmp =3D qemu_get_byte(mis->from_src_file);
>      if (tmp !=3D postcopy_ram_discard_version) {
> -        error_report("CMD_POSTCOPY_RAM_DISCARD invalid version (%d)",
> tmp);
> +        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid version (%d)"=
,
> tmp);
>          return -1;
>      }
>
>      if (!qemu_get_counted_string(mis->from_src_file, ramid)) {
> -        error_report("CMD_POSTCOPY_RAM_DISCARD Failed to read RAMBlock
> ID");
> +        error_setg(errp,
> +                   "CMD_POSTCOPY_RAM_DISCARD Failed to read RAMBlock ID"=
);
>          return -1;
>      }
>      tmp =3D qemu_get_byte(mis->from_src_file);
>      if (tmp !=3D 0) {
> -        error_report("CMD_POSTCOPY_RAM_DISCARD missing nil (%d)", tmp);
> +        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD missing nil (%d)",
> tmp);
>          return -1;
>      }
>
>      len -=3D 3 + strlen(ramid);
>      if (len % 16) {
> -        error_report("CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len=
);
> +        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid length (%d)",
> len);
>          return -1;
>      }
>      trace_loadvm_postcopy_ram_handle_discard_header(ramid, len);
> @@ -2070,6 +2073,7 @@ static int
> loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
>          len -=3D 16;
>          int ret =3D ram_discard_range(ramid, start_addr, block_length);
>          if (ret) {
> +            error_setg(errp, "Failed to discard RAM range %s: %d", ramid=
,
> ret);
>

note: the ram_discard_range() and ram_block_discard_range() functions also
calls error_report()  Maybe they can be converted too.., let's not do this
in this already long series.




>              return ret;
>          }
>      }
> @@ -2629,11 +2633,7 @@ static int loadvm_process_command(QEMUFile *f,
> Error **errp)
>          return loadvm_postcopy_handle_run(mis, errp);
>
>      case MIG_CMD_POSTCOPY_RAM_DISCARD:
> -        ret =3D loadvm_postcopy_ram_handle_discard(mis, len);
> -        if (ret < 0) {
> -            error_setg(errp, "Failed to load device state command: %d",
> ret);
> -        }
> -        return ret;
> +        return loadvm_postcopy_ram_handle_discard(mis, len, errp);
>
>      case MIG_CMD_POSTCOPY_RESUME:
>          loadvm_postcopy_handle_resume(mis);
>
> --
> 2.50.1
>
>

--000000000000a1451e063bada7e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 5, 2025 at 10:30=
=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com">armenon@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">This is an incremental step in converting vmstate loading<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that loadvm_postcopy_ram_handle_discard() must report an erro=
r<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0migration/savevm.c | 26 +++++++++++++-------------<br>
=C2=A01 file changed, 13 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index eb90873a750ded354b3db31cba40b44d1be79864..3abe4193e02aae9c813ff07fb38=
8a7ee470c8a6a 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2004,7 +2004,7 @@ static int loadvm_postcopy_handle_advise(MigrationInc=
omingState *mis,<br>
=C2=A0 * There can be 0..many of these messages, each encoding multiple pag=
es.<br>
=C2=A0 */<br>
=C2=A0static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState =
*mis,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint16_t len)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint16_t len, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int tmp;<br>
=C2=A0 =C2=A0 =C2=A0char ramid[256];<br>
@@ -2017,6 +2017,7 @@ static int loadvm_postcopy_ram_handle_discard(Migrati=
onIncomingState *mis,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 1st discard */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D postcopy_ram_prepare_discard(mis)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tmp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 prepare for RAM discard: %d&quot;, tmp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return tmp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -2026,8 +2027,9 @@ static int loadvm_postcopy_ram_handle_discard(Migrati=
onIncomingState *mis,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CMD_POSTCOPY_RAM_DISCARD in=
 wrong postcopy state (%d)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ps);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state (%d)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ps);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0/* We&#39;re expecting a<br>
@@ -2036,29 +2038,30 @@ static int loadvm_postcopy_ram_handle_discard(Migra=
tionIncomingState *mis,<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 then at least 1 16 byte chunk<br>
=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0if (len &lt; (1 + 1 + 1 + 1 + 2 * 8)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CMD_POSTCOPY_RAM_DISCARD in=
valid length (%d)&quot;, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;CMD_POSTCOPY_RAM_DISCAR=
D invalid length (%d)&quot;, len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D qemu_get_byte(mis-&gt;from_src_file);<br>
=C2=A0 =C2=A0 =C2=A0if (tmp !=3D postcopy_ram_discard_version) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CMD_POSTCOPY_RAM_DISCARD in=
valid version (%d)&quot;, tmp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;CMD_POSTCOPY_RAM_DISCAR=
D invalid version (%d)&quot;, tmp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!qemu_get_counted_string(mis-&gt;from_src_file, ram=
id)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CMD_POSTCOPY_RAM_DISCARD Fa=
iled to read RAMBlock ID&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;CMD_POSTCOPY_RAM_DISCARD Failed to read RAMBlock ID&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D qemu_get_byte(mis-&gt;from_src_file);<br>
=C2=A0 =C2=A0 =C2=A0if (tmp !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CMD_POSTCOPY_RAM_DISCARD mi=
ssing nil (%d)&quot;, tmp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;CMD_POSTCOPY_RAM_DISCAR=
D missing nil (%d)&quot;, tmp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0len -=3D 3 + strlen(ramid);<br>
=C2=A0 =C2=A0 =C2=A0if (len % 16) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CMD_POSTCOPY_RAM_DISCARD in=
valid length (%d)&quot;, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;CMD_POSTCOPY_RAM_DISCAR=
D invalid length (%d)&quot;, len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0trace_loadvm_postcopy_ram_handle_discard_header(ramid, =
len);<br>
@@ -2070,6 +2073,7 @@ static int loadvm_postcopy_ram_handle_discard(Migrati=
onIncomingState *mis,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len -=3D 16;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D ram_discard_range(ramid, star=
t_addr, block_length);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 discard RAM range %s: %d&quot;, ramid, ret);<br></blockquote><div><br></di=
v><div>note: the ram_discard_range()=C2=A0and=C2=A0ram_block_discard_range(=
) functions also calls error_report()=C2=A0 Maybe they can be converted too=
.., let&#39;s not do this in this already long series.</div><div><br></div>=
<div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -2629,11 +2633,7 @@ static int loadvm_process_command(QEMUFile *f, Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return loadvm_postcopy_handle_run(mis, er=
rp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_POSTCOPY_RAM_DISCARD:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_postcopy_ram_handle_discard(mis=
, len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load device state command: %d&quot;, ret);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_postcopy_ram_handle_discard(mis,=
 len, errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_POSTCOPY_RESUME:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loadvm_postcopy_handle_resume(mis);<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div></div>

--000000000000a1451e063bada7e5--


