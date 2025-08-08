Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906C4C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIMy-0001Yi-4x; Fri, 08 Aug 2025 04:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukIMr-0001Xl-73
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukIMn-0008Vu-EZ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754641338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3wgrZDDLhToR7A4ZXVeTiRcGyYTPAAfPkrCsa6nZhzY=;
 b=C70yGPEUOJPRo8gDx4u65jeRkJtTr8To0qbAKiL9xw8D8zsl94fK7bcTdlvSbf5FrqDaHn
 0c0xoTrdNK8DCi3A9tBjG/BWyFkMd+RMGJbVrAMExVgvEdxrYzbV11l22ux2/pWxp7W4EJ
 EyB3D7DlAStCbno/T+fxAcjU9vkqFU4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-81LvAU4xPEaWb7MmNOt7PQ-1; Fri, 08 Aug 2025 04:22:16 -0400
X-MC-Unique: 81LvAU4xPEaWb7MmNOt7PQ-1
X-Mimecast-MFC-AGG-ID: 81LvAU4xPEaWb7MmNOt7PQ_1754641336
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31ed2a7d475so2062042a91.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 01:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754641335; x=1755246135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3wgrZDDLhToR7A4ZXVeTiRcGyYTPAAfPkrCsa6nZhzY=;
 b=In8tMHqafvjCLtu47XR8NTNL40THKUxiy4MbJBndb0MAjrjyDJ9h5bS7pSXw74WsCK
 SP5EeFip+ywYu3ZPJjibjBiskcSj0qOPKyXQXlE9Vcd0pJ13JNvG/qpGzoPPKeJGtmqO
 0H2BSNJIqeRn7bv0aGe6dNLJad1BlIsHbg/3+zAjsErA7eNKmGXhp3kttuhlNyZKRQRB
 z0hc0NSjO0gTi7nmhwU4NJ9jgXRE5W+45+fm0QezlK4zH+iwrj3CE8nqduwWbcy2zsEU
 w1pfYLEAavydK9fFKUx30RQsTMJ17U0GVpVNlR0kfCZMl74Qs2mwJYQ4gJuVQ+iwsnYa
 u7rw==
X-Gm-Message-State: AOJu0YxNwJzONYzwjUyY4Qn1VesREKwpm62Hti0bDPIk7VMQvf+oURoQ
 Nrz8TnYhLSM3A6jfjCHEidu9M1qiUdDbCajNF0+EVxAGxDbxuiWwxJyk9tjo6nW+j1g/CXuntlC
 NT1yB/xdLtsLkLcB93riBIWdf6buyNECOuUqjvULM54Iz/L6DKDyxwWhp0waEa+zCukQJJQ+JpT
 MkNzSB8+zN7vMNrQAa2jhSJj1sL1W3ehA7l1m00nzbyyMd
X-Gm-Gg: ASbGncuqTKtji+dJv2z2BeLhrk9cIR9muaQrddmEBymy/ACfObbUr6v9TxU3HT3u2yU
 FJniVzu7LeTmTt68yS72CQUycxWKt5oMdflVPKiC13dDcCksOQr9kTbkV1SLsQh2TnnymqNLae6
 b2be1gagfMyzw6HDKM1xCNYQ==
X-Received: by 2002:a17:90b:2e49:b0:31f:d0:95bc with SMTP id
 98e67ed59e1d1-32183c4585dmr2805622a91.25.1754641335326; 
 Fri, 08 Aug 2025 01:22:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwGe3VwcMcxUVVZqZ5dIvfo3Q7JgcAlR27GyK5qmZm4kMrc09Xo4OR27WyofhvUWM1IYlK95aiofsi9HIArdY=
X-Received: by 2002:a17:90b:2e49:b0:31f:d0:95bc with SMTP id
 98e67ed59e1d1-32183c4585dmr2805600a91.25.1754641334901; Fri, 08 Aug 2025
 01:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-9-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-9-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 8 Aug 2025 12:22:03 +0400
X-Gm-Features: Ac12FXwojLE14ID537lBDQPStjrtSyJkwSZFthNBmDOQwkDSscEAxSGs6ZZFaWM
Message-ID: <CAMxuvaxjMbvGtwpai6M75zRZMQPVZAusmSX7hs=OeDDThc7-Lw@mail.gmail.com>
Subject: Re: [PATCH 08/12] util/oslib-win32: Revert warning on
 WSAEventSelect() failure
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp
Content-Type: multipart/alternative; boundary="00000000000079b728063bd64548"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--00000000000079b728063bd64548
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Aug 8, 2025 at 12:08=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> qemu_socket_select() and its wrapper qemu_socket_unselect() treat a
> NULL @errp as &error_warn.  This is wildly inappropriate.  A caller
> passing NULL specifies that errors are to be ignored.  If warnings are
> wanted, the caller must pass &error_warn.
>
> I'm not familiar with the calling code, so I can't say whether it will
> work after WSAEventSelect() failure.  If it doesn't, then this should
> be an error.  If it does, then why bother the user with a warning that
> isn't actionable, and likely confusing?
>
> The warning goes back to commit f5fd677ae7cf (win32/socket: introduce
> qemu_socket_select() helper).  Before that commit, the error was
> ignored, as indicated by passing a null @errp.  Revert to that
> behavior.
>

Yes, the potential errors before introducing the wrapper were simply
ignored. I think we should fix the users or maybe just report the warning
and drop errp from the wrapper function. wdyt?


>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

---
>  util/oslib-win32.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index b7351634ec..136a8fe118 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -296,10 +296,6 @@ bool qemu_socket_select(int sockfd, WSAEVENT
> hEventObject,
>  {
>      SOCKET s =3D _get_osfhandle(sockfd);
>
> -    if (errp =3D=3D NULL) {
> -        errp =3D &error_warn;
> -    }
> -
>      if (s =3D=3D INVALID_SOCKET) {
>          error_setg(errp, "invalid socket fd=3D%d", sockfd);
>          return false;
> --
> 2.49.0
>
>

--00000000000079b728063bd64548
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 8, 20=
25 at 12:08=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redha=
t.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">qemu_socket_select() and its wrapper qemu_socket_un=
select() treat a<br>
NULL @errp as &amp;error_warn.=C2=A0 This is wildly inappropriate.=C2=A0 A =
caller<br>
passing NULL specifies that errors are to be ignored.=C2=A0 If warnings are=
<br>
wanted, the caller must pass &amp;error_warn.<br>
<br>
I&#39;m not familiar with the calling code, so I can&#39;t say whether it w=
ill<br>
work after WSAEventSelect() failure.=C2=A0 If it doesn&#39;t, then this sho=
uld<br>
be an error.=C2=A0 If it does, then why bother the user with a warning that=
<br>
isn&#39;t actionable, and likely confusing?<br>
<br>
The warning goes back to commit f5fd677ae7cf (win32/socket: introduce<br>
qemu_socket_select() helper).=C2=A0 Before that commit, the error was<br>
ignored, as indicated by passing a null @errp.=C2=A0 Revert to that<br>
behavior.<br></blockquote><div><br></div><div>Yes, the potential errors bef=
ore introducing the wrapper were=C2=A0simply ignored. I think we should fix=
 the users or maybe just report the warning and drop errp from the wrapper =
function. wdyt?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;=C2=A0</blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0util/oslib-win32.c | 4 ----<br>
=C2=A01 file changed, 4 deletions(-)<br>
<br>
diff --git a/util/oslib-win32.c b/util/oslib-win32.c<br>
index b7351634ec..136a8fe118 100644<br>
--- a/util/oslib-win32.c<br>
+++ b/util/oslib-win32.c<br>
@@ -296,10 +296,6 @@ bool qemu_socket_select(int sockfd, WSAEVENT hEventObj=
ect,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SOCKET s =3D _get_osfhandle(sockfd);<br>
<br>
-=C2=A0 =C2=A0 if (errp =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 errp =3D &amp;error_warn;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (s =3D=3D INVALID_SOCKET) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;invalid socket fd=
=3D%d&quot;, sockfd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--00000000000079b728063bd64548--


