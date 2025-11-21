Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11ABCFA478
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMLne-0001yT-QB; Fri, 21 Nov 2025 02:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vMLnd-0001xx-EZ
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:43:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vMLnb-0005uQ-Oi
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763710998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UaRrR/bSI9ifC9leQ59k3dsXaJNuvD/OvOK7ugPKPuQ=;
 b=GPltHw1dgFf9BLHPWOjuQktCYFUWiXgMTMyQQb9r5rJuMecy1Mlrxm0ADbErYh2NOD1Q5p
 3ZIIoEnISpQ5PeWdvzQHzQGQR1nLuXZYImx2lQyUBRoW/V5W7MAJL11+MBhK8Dy5cw7p8Q
 rdwaiCv0b6Q1KMtnHikHkBpmDlfEEkw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-IyJrYB0xOiWW4c69wEq0iw-1; Fri, 21 Nov 2025 02:43:16 -0500
X-MC-Unique: IyJrYB0xOiWW4c69wEq0iw-1
X-Mimecast-MFC-AGG-ID: IyJrYB0xOiWW4c69wEq0iw_1763710996
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2e9b2608dso146540185a.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 23:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763710996; x=1764315796; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UaRrR/bSI9ifC9leQ59k3dsXaJNuvD/OvOK7ugPKPuQ=;
 b=Bx1+Pp9UgFYmfkd6NgpG8eKRCx3ySc53HrNn7ceZKQvGICzzYNyOoxL7PHmXfi93BF
 EcK9fFUVUlIqG2CKiOuHjS8/S8rooWm3uDpYptXmFfzKAgr7fthxHFmzvwJN8wU7NbTP
 oRpTaTAQ47cTUxiwi+sgrwPjx7DSBinQMZi8zamu8iqLSwpAVFPBSCZiKk11lEmdELKe
 QqPRKVjgcmd3KUOwmWayuCOMLNf1Qc9p909VJwuSrWvYP+LBy08pvtpfm+S36+fL/6w5
 zzTxiqZzx7iJ11f4C66THwKHsSmHwzJ5ECw3zt8VnylvLL3Jpi4BSbvpwvLjjsZAR3zE
 ZNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763710996; x=1764315796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaRrR/bSI9ifC9leQ59k3dsXaJNuvD/OvOK7ugPKPuQ=;
 b=gWgslwuh2xDVXDDktwLhi26vHbfpGVMEFcAu59G5OGkQfQsglHbg3lhfOKfhLysWLD
 AJyVyXHz0zIkfZAQ3PRtqAFURb7EajNBLkoVoa5Hm+L0bYW0CDy6GKXFM2DqealOWqWz
 MZIcO/zoHHXnjPjy60tMKGgpgDnq/NJRUOmkuG55Ffo8Jfbj++4RUVC19BpWrjgkVQz/
 BUmIf87Hkz1tgpnWilEDz5USt6FoU045sljbuU0THsHx3+kCrNTKOfodRK6PKzYteIiT
 /3WvbAb/TD9wdU1mgLheZyIBHrgi2e2gCWCYUFOZT6FJ4cMLzHtW8wKc8gyEJ1r98CNL
 FPJA==
X-Gm-Message-State: AOJu0Yx875If8cNKClaSH7Iz5L7iyek8fcmYRL8T/lKz5wpIbEM2sUP3
 MWFkvp6uOIgEJQ5V/NtoiHJaj5EYUgIFq/zOKwkQhdqNBEV6+T/opxnbfwMFhLUCqLTHRjjG6+O
 dBUtNds6+Ow0fd4bON6H0npp32jdE09hASZ8BfgIhkTCB96xbU2txbRYvrwku09ud4sPzHQe06r
 Tvjt+CU7gBl16U7M0n3AzMqZxDgkIyYRs=
X-Gm-Gg: ASbGncsi1YyGlFgaKNfqIFY9HjwiqKHKAg/PVRbjIGyz/KIToMdIi+tCeM025uGiOQ4
 9RmVYSUPBDX7+3dmacBKN+RqnUCHcHfSKIA59HzaB/e4HYmCVJfVZpQjslI+4eMCbKQ7xTlbmjC
 rSnYUTZN2KjiLU6W6z9hmeVuQs6w/fDLMtvWxhkBZmtP3RuLjGnWXc3e5PGQikbWbPbThD
X-Received: by 2002:a05:622a:199b:b0:4ed:ae38:6592 with SMTP id
 d75a77b69052e-4ee589409f9mr19048351cf.79.1763710996272; 
 Thu, 20 Nov 2025 23:43:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETP0cHXZT3TQIN11rmLao5OEegQ9+57ZsItOyprELi91KV6ANui+OB+j0cbxmwyqlkyxoABL6wqmfFCHzvktk=
X-Received: by 2002:a05:622a:199b:b0:4ed:ae38:6592 with SMTP id
 d75a77b69052e-4ee589409f9mr19047861cf.79.1763710995835; Thu, 20 Nov 2025
 23:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20251120191339.756429-1-armbru@redhat.com>
 <20251120191339.756429-14-armbru@redhat.com>
In-Reply-To: <20251120191339.756429-14-armbru@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Fri, 21 Nov 2025 09:43:04 +0200
X-Gm-Features: AWmQ_bmdKUn6ydK6C5Q1jdfMet69rDLS9kOEgzlcXdE8rv6sRstOoduZH2Z6aYY
Message-ID: <CAPMcbCqzp9BwUvRF1kt1CoeftAL3jiVWoWE_3DyrkBx+dyKabQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] qga/commands-win32: Use error_setg_win32() for
 better error messages
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, pizhenwei@bytedance.com, 
 alistair.francis@wdc.com, stefanb@linux.vnet.ibm.com, kwolf@redhat.com, 
 hreitz@redhat.com, sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com, 
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com, 
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org, 
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com, 
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net, philmd@linaro.org, 
 alex@shazbot.org, clg@redhat.com, peterx@redhat.com, farosas@suse.de, 
 lizhijian@fujitsu.com, dave@treblig.org, jasowang@redhat.com, 
 samuel.thibault@ens-lyon.org, michael.roth@amd.com, zhao1.liu@intel.com, 
 mtosatti@redhat.com, rathc@linux.ibm.com, palmer@dabbelt.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 marcandre.lureau@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000064bbee064415f7a2"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000064bbee064415f7a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Thu, Nov 20, 2025 at 9:14=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> We include numeric GetLastError() codes in error messages in a few
> places, like this:
>
>     error_setg(errp, "GRIPE: %d", (int)GetLastError());
>
> Show text instead, like this:
>
>     error_setg_win32(errp, GetLastError(), "GRIPE");
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/commands-win32.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index acc2c11589..0fd0c966e4 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1798,8 +1798,8 @@ void qmp_guest_set_time(bool has_time, int64_t
> time_ns, Error **errp)
>      tf.dwHighDateTime =3D (DWORD) (time >> 32);
>
>      if (!FileTimeToSystemTime(&tf, &ts)) {
> -        error_setg(errp, "Failed to convert system time %d",
> -                   (int)GetLastError());
> +        error_setg_win32(errp, GetLastError(),
> +                         "Failed to convert system time");
>          return;
>      }
>
> @@ -1810,7 +1810,8 @@ void qmp_guest_set_time(bool has_time, int64_t
> time_ns, Error **errp)
>      }
>
>      if (!SetSystemTime(&ts)) {
> -        error_setg(errp, "Failed to set time to guest: %d",
> (int)GetLastError());
> +        error_setg_win32(errp, GetLastError(),
> +                         "Failed to set time to guest");
>          return;
>      }
>  }
> @@ -1834,13 +1835,12 @@ GuestLogicalProcessorList
> *qmp_guest_get_vcpus(Error **errp)
>          (length > sizeof(SYSTEM_LOGICAL_PROCESSOR_INFORMATION))) {
>          ptr =3D pslpi =3D g_malloc0(length);
>          if (GetLogicalProcessorInformation(pslpi, &length) =3D=3D FALSE)=
 {
> -            error_setg(&local_err, "Failed to get processor information:
> %d",
> -                       (int)GetLastError());
> +            error_setg_win32(&local_err, GetLastError(),
> +                             "Failed to get processor information");
>          }
>      } else {
> -        error_setg(&local_err,
> -                   "Failed to get processor information buffer length:
> %d",
> -                   (int)GetLastError());
> +        error_setg_win32(&local_err, GetLastError(),
> +                         "Failed to get processor information buffer
> length");
>      }
>
>      while ((local_err =3D=3D NULL) && (length > 0)) {
> --
> 2.49.0
>
>

--00000000000064bbee064415f7a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Thu, Nov 20, 2025 at 9:14=E2=80=AFPM Markus Armbruster &lt;<a h=
ref=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">We include numeric GetLas=
tError() codes in error messages in a few<br>
places, like this:<br>
<br>
=C2=A0 =C2=A0 error_setg(errp, &quot;GRIPE: %d&quot;, (int)GetLastError());=
<br>
<br>
Show text instead, like this:<br>
<br>
=C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;GRIPE&quot;);<br=
>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 16 ++++++++--------<br>
=C2=A01 file changed, 8 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index acc2c11589..0fd0c966e4 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1798,8 +1798,8 @@ void qmp_guest_set_time(bool has_time, int64_t time_n=
s, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0tf.dwHighDateTime =3D (DWORD) (time &gt;&gt; 32);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!FileTimeToSystemTime(&amp;tf, &amp;ts)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to convert syste=
m time %d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int)=
GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;Failed to convert system time&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1810,7 +1810,8 @@ void qmp_guest_set_time(bool has_time, int64_t time_n=
s, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!SetSystemTime(&amp;ts)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to set time to g=
uest: %d&quot;, (int)GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;Failed to set time to guest&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
@@ -1834,13 +1835,12 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Erro=
r **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(length &gt; sizeof(SYSTEM_LOGICAL_PROCES=
SOR_INFORMATION))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptr =3D pslpi =3D g_malloc0(length);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (GetLogicalProcessorInformation(pslpi,=
 &amp;length) =3D=3D FALSE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;local_err, &quot=
;Failed to get processor information: %d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(int)GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(&amp;local_err,=
 GetLastError(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Failed to get processor information&qu=
ot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;local_err,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;Failed to get processor information buffer length: %d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int)=
GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(&amp;local_err, GetLastError(=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;Failed to get processor information buffer length&qu=
ot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0while ((local_err =3D=3D NULL) &amp;&amp; (length &gt; =
0)) {<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--00000000000064bbee064415f7a2--


