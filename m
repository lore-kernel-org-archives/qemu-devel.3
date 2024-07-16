Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2997EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkq5-0002BT-Ly; Tue, 16 Jul 2024 12:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTkph-00024a-Ov
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTkpf-0003xZ-7I
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721146512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LNZC4qWSDA+U/JYLPXCd+pbgouv/BxVxgEMVLmo6HGs=;
 b=dbC0WM6syELYI45NHu2cwGUaA14iUz3qwvYyHCIxNQG0iys+YrJHtfHWIg2y2F/Gt/lZAp
 w6HxpsxMGBOntfGfGdZvwRgC/nqSGryX7v4t45UngwgZCe1k0kHeQMQIW5xPkzB+TT98/M
 fNFnlKLhfK4b9+1DZfEG6AKJYbgxxAg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-VvxKiUNxPlqLCjdH-hu-sg-1; Tue, 16 Jul 2024 12:15:10 -0400
X-MC-Unique: VvxKiUNxPlqLCjdH-hu-sg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3678fbf4aa7so3296142f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721146509; x=1721751309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNZC4qWSDA+U/JYLPXCd+pbgouv/BxVxgEMVLmo6HGs=;
 b=C/bhVRNJ6rSbJPXLmeVNxYZ6IG9gCmHau2tpUqGMk3/ju/UXEF9mrvnmcJxs+hvcHN
 4P1dy8URRF3JCyuSrfwpCY5MWSHwV+MjHQVrwN63HMG5HbbZEx5fjmSwDyM1kQVfWpOr
 BDlOr5oETvzXgX9YIYIVzMWqAqHXQxpnAJJwm8xdb+OrRpKdHZdm6HwbUkAaez3gKazn
 shddZAHUsUFA66A4OP/BvI83oHXg0t0QOfNERgXMHJ5gpAcSTFwBWIH3iWueooosy2zi
 DpLaXtlouY1Zr3z0gIt0ZTJDEPk4Ad/hO3LpiNSRZ8f/uOmVpyPKVtAAfibC5ZhQwF5u
 IrWg==
X-Gm-Message-State: AOJu0YzcganJVyMvYV1abp6ltjX9KJvEvJF7f77kRn+Q1GnEsYMjjI8L
 a0QuZ6dFiR0kebjdcZW6LOLNs5XX04J8wJ5P1ytOJ2OfDMogA2TZJoqL/XGePREe9Iq/HrNslAp
 uWbPLVcveIRVu5gqgn6XDRDYPfaT/WqnlHdW7WCKyGOnnZwq6Qyk7u5naixtZc4AZx4FFkvF1Jr
 SnExNomQE5Ajc/4T3UOLgPJzfWCmM=
X-Received: by 2002:a5d:5f8a:0:b0:367:97b9:d5ed with SMTP id
 ffacd0b85a97d-36825f66ebcmr1739149f8f.9.1721146509098; 
 Tue, 16 Jul 2024 09:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5IxvmUZfEQH4zEk8CW0alVHEwoh2uQnlAbDeIWZ4FQ6W3iW0W1IkV/rS21dvbiRRy36NJUIhAYYU8oKRu4pQ=
X-Received: by 2002:a5d:5f8a:0:b0:367:97b9:d5ed with SMTP id
 ffacd0b85a97d-36825f66ebcmr1739132f8f.9.1721146508756; Tue, 16 Jul 2024
 09:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240711112228.2140606-1-armbru@redhat.com>
 <20240711112228.2140606-4-armbru@redhat.com>
In-Reply-To: <20240711112228.2140606-4-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 Jul 2024 12:14:52 -0400
Message-ID: <CAFn=p-Zv9e7MFhpGK=PssPYGbe7Q3R-A0CAdYEMbtaY60ATWrw@mail.gmail.com>
Subject: Re: [PATCH 3/5] qapi/machine: Clarify query-uuid value when none has
 been specified
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000042e6c4061d5fa674"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000042e6c4061d5fa674
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024, 7:22=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> When no UUID has been specified, query-uuid returns
>
>     {"UUID": "00000000-0000-0000-0000-000000000000"}
>
> The doc comment calls this "a null UUID", which I find less than
> clear.  Change it to "an all-zero UUID".
>

Technically it's a "nil UUID";
https://datatracker.ietf.org/doc/html/rfc9562#name-nil-uuid

If you wanted to be pedantic, you could say "the nil UUID (all zeroes) is
returned"

but your rephrasing is clear even w/o using the standard name, so I'm fine
either way.


> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: John Snow <jsnow@redhat.com>

---
>  qapi/machine.json | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 50ff102d56..f40427f21a 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -305,9 +305,8 @@
>  #
>  # Since: 0.14
>  #
> -# .. note:: If no UUID was specified for the guest, a null UUID is
> -#    returned.
> -#
> +# .. note:: If no UUID was specified for the guest, an all-zero UUID
> +#    is returned.
>  ##
>  { 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
>
> --
> 2.45.0
>
>

--00000000000042e6c4061d5fa674
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jul 11, 2024, 7:22=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">When no UUID has been specified, q=
uery-uuid returns<br>
<br>
=C2=A0 =C2=A0 {&quot;UUID&quot;: &quot;00000000-0000-0000-0000-000000000000=
&quot;}<br>
<br>
The doc comment calls this &quot;a null UUID&quot;, which I find less than<=
br>
clear.=C2=A0 Change it to &quot;an all-zero UUID&quot;.<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">Technically it&#39;s=
 a &quot;nil UUID&quot;;=C2=A0<a href=3D"https://datatracker.ietf.org/doc/h=
tml/rfc9562#name-nil-uuid">https://datatracker.ietf.org/doc/html/rfc9562#na=
me-nil-uuid</a></div><div dir=3D"auto"><br></div><div dir=3D"auto">If you w=
anted to be pedantic, you could say &quot;the nil UUID (all zeroes) is retu=
rned&quot;</div><div dir=3D"auto"><br></div><div dir=3D"auto">but your reph=
rasing is clear even w/o using the standard name, so I&#39;m fine either wa=
y.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: J=
ohn Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt;</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0qapi/machine.json | 5 ++---<br>
=C2=A01 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qapi/machine.json b/qapi/machine.json<br>
index 50ff102d56..f40427f21a 100644<br>
--- a/qapi/machine.json<br>
+++ b/qapi/machine.json<br>
@@ -305,9 +305,8 @@<br>
=C2=A0#<br>
=C2=A0# Since: 0.14<br>
=C2=A0#<br>
-# .. note:: If no UUID was specified for the guest, a null UUID is<br>
-#=C2=A0 =C2=A0 returned.<br>
-#<br>
+# .. note:: If no UUID was specified for the guest, an all-zero UUID<br>
+#=C2=A0 =C2=A0 is returned.<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;UuidInfo&#39;, &#39;data&#39;: {&#39;UUID&#3=
9;: &#39;str&#39;} }<br>
<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div></div></div>

--00000000000042e6c4061d5fa674--


