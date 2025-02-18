Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDC8C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 22:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkW0i-00034K-67; Tue, 18 Feb 2025 17:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkW0g-00033r-Aq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:24:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkW0e-0001oy-OR
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739917448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HCcipKxs5D73OMGSZpuSTAu+3vBqsvZiXc+74GEz9nQ=;
 b=QniiJk0Ia1xBbeRTrl9LryL8xbhIeIl+2uAkWdLIWYoB7OSwUpYfdpyLFf+7BbTWAlasby
 LZesYuMCdDw4kHKUuVg9BgbwKXEO8XLZ9gFQWkpJd5j0tjmqoZtouE/KoleuyR3owgjJLR
 cO9Zn17TqHR3i0Hpl3daDe/mjzrkoFw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-jerHfJ53Mf-tKB7gK7z7VQ-1; Tue, 18 Feb 2025 17:24:04 -0500
X-MC-Unique: jerHfJ53Mf-tKB7gK7z7VQ-1
X-Mimecast-MFC-AGG-ID: jerHfJ53Mf-tKB7gK7z7VQ_1739917443
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2f81a0d0a18so12074853a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 14:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739917443; x=1740522243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HCcipKxs5D73OMGSZpuSTAu+3vBqsvZiXc+74GEz9nQ=;
 b=XqIgH81rpucdubBaNM1Ab7yduKBCzXwdJFu7nqcS+47eCE3LqVjYXShvxWjzqIua+O
 Or3cpzmefgALYMM1X4KVIgSDD8uJSH8ptEQNLwz1ZlT+Pf6ZPhcuTU5friGUAdtvKT8D
 DHqKbRzmEp25i43X+s1gNfRoLbkX8iMuL6hGRljqo51tL+DcV0si/zo+ZAlgEsLAau/C
 uZqV5g0MWoo7TJ2zI2ZRLLyya1c4T1EjtrwwJrAzYNeUjMOYwVQdWKxpdCx5S5922qbu
 VMw13LdedkJmrtSn5JCXxV3gp0WwPIiOL1UH4tiYJd2+D1+Yf0Kt848BeN0VHAUAymsA
 FndQ==
X-Gm-Message-State: AOJu0Yzaivh8HT44rPtF1HfR676btFchGFii2Ky3nqGheNJZvIHKJOU3
 h39OzTcxQoMiYlHLfj/jee1c23E6dphLvKT3vlT+4dy2JQFKsYQaK6L+DPS4BP5QI1swj9YJxnZ
 WBoDTQ5MAu9xkPWIXNhdUAAhC/vc2t4dMGA5dS1/t6njgfVCkgWks70ivusu+FUwLZ61xf8f2QM
 IzF0oB/DxeMZn0iXZPctQOQHCtCk0=
X-Gm-Gg: ASbGncudg3YccBlotxKsjonyIgvXxvnBTcyWBOg5k6awSn5pDnX790BDaxhubroHdfK
 yNxLKU0RRfWAHJAmwmKjsroL/JOTWj1tfw6wHJsez4yKXwWmtfScpxL8BrKK3NLJZvnjvQ1xZot
 4Scnp/0RIMOn8Gf/rKdg==
X-Received: by 2002:a17:90b:3d0e:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2fc40f105d0mr23852271a91.9.1739917443317; 
 Tue, 18 Feb 2025 14:24:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfMHdB9N8lJPCxbeV+Llul2EZhMUVmYWL4wReERmOwpL4pKbjOx/h9YwrskCOIr0C4Q8BpPmtFxomlOJ/+WRA=
X-Received: by 2002:a17:90b:3d0e:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2fc40f105d0mr23852237a91.9.1739917443084; Tue, 18 Feb 2025
 14:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-30-jsnow@redhat.com>
 <87pljgsv2t.fsf@pond.sub.org>
In-Reply-To: <87pljgsv2t.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Feb 2025 17:23:51 -0500
X-Gm-Features: AWEUYZkZ8EFyBBXg0oAbj44YhI1qjroveRr4Xd389bYln0ztiof-77kvEaggHng
Message-ID: <CAFn=p-apeB8QCifJ2aWeBHZ0G8YCFC4PcZGjxykE1+afUFxBnQ@mail.gmail.com>
Subject: Re: [PATCH 29/42] qapi: Add "Details:" disambiguation marker
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>, 
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002257d5062e7219c7"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002257d5062e7219c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 5:51=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This clarifies sections that are mistaken by the parser as "intro"
> > sections to be "details" sections instead.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Is this missing announce-self in net.json?
>
> diff --git a/qapi/net.json b/qapi/net.json
> index 49bc7de64e..44ed72dbe9 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -948,7 +948,7 @@
>  # switches.  This can be useful when network bonds fail-over the
>  # active slave.
>  #
> -# TODO: This line is a hack to separate the example from the body
> +# Details:
>  #
>  # .. qmp-example::
>  #
>

Yes, overlooked. The "hack" still works, so I missed it in my tests. Will
remedy, pending your other emails that I'm about to read in a second ...

--0000000000002257d5062e7219c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 17,=
 2025 at 5:51=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This clarifies sections that are mistaken by the parser as &quot;intro=
&quot;<br>
&gt; sections to be &quot;details&quot; sections instead.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
Is this missing announce-self in net.json?<br>
<br>
diff --git a/qapi/net.json b/qapi/net.json<br>
index 49bc7de64e..44ed72dbe9 100644<br>
--- a/qapi/net.json<br>
+++ b/qapi/net.json<br>
@@ -948,7 +948,7 @@<br>
=C2=A0# switches.=C2=A0 This can be useful when network bonds fail-over the=
<br>
=C2=A0# active slave.<br>
=C2=A0#<br>
-# TODO: This line is a hack to separate the example from the body<br>
+# Details:<br>
=C2=A0#<br>
=C2=A0# .. qmp-example::<br>
=C2=A0#<br></blockquote><div><br></div><div>Yes, overlooked. The &quot;hack=
&quot; still works, so I missed it in my tests. Will remedy, pending your o=
ther emails that I&#39;m about to read in a second ...</div></div></div>

--0000000000002257d5062e7219c7--


