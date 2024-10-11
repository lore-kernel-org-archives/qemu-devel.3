Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F740D0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4J-0000ya-Bc; Fri, 11 Oct 2024 13:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1szJ4E-0000hu-KO
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1szIFz-00044K-DX
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 12:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728663158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fyuc/hWT3I2CYHu9KDsrHIHMJyHLKgO/S1pRRemUaS0=;
 b=ImoW80FABFd505gIzsoeCjjX/ys4oPyISku0IP91lJG+pouO70jCEhbbxPKbETJgApbd43
 52YwnyRX5P2UOutGwfyz0ScOaAvczOMgToMncfL/LTnEGIEt2wnliAlleQkYqNBqjpqWBv
 K/6CB9YOwr6DTYgq/EFqvUXfCXW6BJg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-onTae_xqNluFXHRiNtil8w-1; Fri, 11 Oct 2024 12:12:36 -0400
X-MC-Unique: onTae_xqNluFXHRiNtil8w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbec7fbf1cso20881406d6.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 09:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728663156; x=1729267956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fyuc/hWT3I2CYHu9KDsrHIHMJyHLKgO/S1pRRemUaS0=;
 b=CeWSkmDrlENgjTw/7VKwM5fp3msoRvYUb4sn+6cfropeaL/Mq7gZ6uOJi0QSry/uZt
 oCc5FqRfSMFXo08qg0NlIMxwDQQk/W5SgwyWEwlg27uMTxQCVPSHs/HHEgsItowKaipZ
 gZgzEqmIVh9sTv0RwW3KDFlTeOvDo4mh/7IUU6G9rvZkgotupRrpTEwxxzEfcBOOnY89
 PIxgXsrFxtw+nr0CGKzeXoo2URY+8KFdYPWTDH5MwMz5PiZVfhwlZ7HHkVXCx6PbU7hw
 Fdi9sFuDOuAQ0t8LDNBSRZPvKcyhagGublb/vhD3D6ZWa8uSbsQuoSbWBJnynbg1H2tC
 BPeA==
X-Gm-Message-State: AOJu0YwCskT2AjTJb2VCxc3VDGlu8nR2EhZZH4so9i8Qxr9zFjR1+H0+
 8m91NNpr11/Nlxdm00dagf/qRmUSs4Odr5vnIHgnfKQ6D4E80AD5w9oTmyexqDn+UQZSj9Psak3
 g+/XQfDe/LKJHsXkerdy//dUZfDtxWr/5NK1eXKsEBawBI2NvkjPAD3NDeZ40fhMalO8Kqlye2V
 UctEFOiXB1DYdsHo27lUahe27i/EM=
X-Received: by 2002:a05:6214:5911:b0:6cb:e798:5589 with SMTP id
 6a1803df08f44-6cbf0084ad0mr46274936d6.28.1728663155904; 
 Fri, 11 Oct 2024 09:12:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGruG1ZIgK3BFupyROdwNmlbT3/gR+tgud6KTFnTtw0+MtQSzI1N+skgwcyQxpga8JEMydR7VR93prr41HML1k=
X-Received: by 2002:a05:6214:5911:b0:6cb:e798:5589 with SMTP id
 6a1803df08f44-6cbf0084ad0mr46274486d6.28.1728663155408; Fri, 11 Oct 2024
 09:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241011031937.92216-1-demeng@redhat.com>
In-Reply-To: <20241011031937.92216-1-demeng@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 11 Oct 2024 19:12:24 +0300
Message-ID: <CAPMcbCq-m98+DD-=n3TBmqLkmRpGRRZer6j8WaqeDrNUAuxEhQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] qemu-ga: Fix some potential issues find by coverity
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="00000000000050984f062435c145"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000050984f062435c145
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 6:19=E2=80=AFAM Dehan Meng <demeng@redhat.com> wrot=
e:

> v2:
> Split v1 up to separate commits for each logically independent change
>
> Dehan Meng (4):
>   sscanf return values are checked to ensure correct parsing.
>   Proper initialization of n to 0 for getline to function correctly.
>   Avoiding freeing line prematurely. It's now only freed at the end of
>     the function.
>   For correcting code style: Variable declarations moved to the
>     beginning of blocks Followed the coding style of using snake_case
>     for variable names. And merged redundant route and networkroute
>     variables.
>
>
First of all, don't use so long commit title. You can add more info in the
commit
message if needed. Commits 3 and 4 have very long titles.

Do not set . at the end of the commit title.

As in git, we do not see cover-messages, please add `qemu-ga:` suffix for
each commit

Best Regards,
Konstantin Kostiuk.


> Signed-off-by: Dehan Meng <demeng@redhat.com>
>
>  qga/commands-linux.c | 128 ++++++++++++++++++++-----------------------
>  1 file changed, 59 insertions(+), 69 deletions(-)
>
> --
> 2.40.1
>
>

--00000000000050984f062435c145
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Fri, Oct 11, 2024 at 6:19=E2=80=AFAM Deha=
n Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=3D"_blank">demeng@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">v2:<br>
Split v1 up to separate commits for each logically independent change<br>
<br>
Dehan Meng (4):<br>
=C2=A0 sscanf return values are checked to ensure correct parsing.<br>
=C2=A0 Proper initialization of n to 0 for getline to function correctly.<b=
r>
=C2=A0 Avoiding freeing line prematurely. It&#39;s now only freed at the en=
d of<br>
=C2=A0 =C2=A0 the function.<br>
=C2=A0 For correcting code style: Variable declarations moved to the<br>
=C2=A0 =C2=A0 beginning of blocks Followed the coding style of using snake_=
case<br>
=C2=A0 =C2=A0 for variable names. And merged redundant route and networkrou=
te<br>
=C2=A0 =C2=A0 variables.<br>
<br></blockquote><div><br></div><div>First of all, don&#39;t use so long co=
mmit title. You can add more info in the commit</div><div>message if needed=
. Commits 3 and 4 have very long titles.<br><br></div><div>Do not set . at =
the end of the commit title.</div><div><br></div><div>As in git, we do not =
see cover-messages, please add `qemu-ga:` suffix for each commit <br></div>=
<div><br>Best Regards,<br>Konstantin Kostiuk.</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt;<br>
<br>
=C2=A0qga/commands-linux.c | 128 ++++++++++++++++++++----------------------=
-<br>
=C2=A01 file changed, 59 insertions(+), 69 deletions(-)<br>
<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div></div>
</div>
</div>
</div>
</div>

--00000000000050984f062435c145--


