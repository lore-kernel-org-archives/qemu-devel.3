Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D41EC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 11:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugM6U-00036J-Kx; Mon, 28 Jul 2025 07:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ugM0a-0005Ds-W9
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ugM0Y-0003Id-LL
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753702024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rwlUW9ghW8nYUIBQlv0/85ewNY2p6mT0yGrKFV+xEmI=;
 b=RukQznrd4zR9Wmvt8IIyxy3cUU+tJbvUxZLuePuSnWHaKbIxRKS488hLxVnihDk6C4U8NO
 bTKWONHH2kWqKupawAIEhaInE1OuJIAcwWvM5nw46899O1Ct+tBrNKKuCVWu1/K5xIYL/7
 PlPDHRs4ERCnHBcN7+GbNF4OFuzWmOA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-xcFXUE-TOOqAMr4SlppgsA-1; Mon, 28 Jul 2025 07:27:01 -0400
X-MC-Unique: xcFXUE-TOOqAMr4SlppgsA-1
X-Mimecast-MFC-AGG-ID: xcFXUE-TOOqAMr4SlppgsA_1753702021
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-7073b4fb53eso21416726d6.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 04:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753702021; x=1754306821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rwlUW9ghW8nYUIBQlv0/85ewNY2p6mT0yGrKFV+xEmI=;
 b=L8OjFC2d8v3jl5wgdacmacmnZ5E4mIRG++z0podJo3qQQq8VAxRmQNlhYcCWVVvfJa
 pCsBkUo+7vnhk9XepakrBQkz8GhEtQn70d5FlWW+Q8ng/k0yHxCYM8CaJm3E9xzE0234
 FjQU+H6xNVvxBl0Xz+n9LkRMiwF+QWjNPu59IvNCTgdXrmh/0FjsFZD4YZ4RkUCvcQLA
 2z22FZZ8S9U7uBiehHEZZUkR9+HyFo5oLL3s4DUCF/fMcMB3D9nwfAvU2xfvbTYr0zBp
 hkSReZs/U2p1bXCdKt47WpxfwSiIB3KNQH/JujRm8daFReLbnHt6BKJ25Y6jdBKTYLrI
 5tCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVegBA9WobQjy/+9Y9fM+HT5ppN8NonVxAAukBLYuGd2iCEWyg0iAQIbSnieHLUV56DlkpeCuk5sToU@nongnu.org
X-Gm-Message-State: AOJu0YxeIWN4rRfSWIhH4+/+gGKkXdFU33T/uY0BHh2fojwdRMTCptKu
 KlDjCvbDKfnuZ4YriNPnX3nZ+MTQquAsDn1xAx8oOSx/DcK7hhGGFzsDE/MgskPVaXNI6SYWp9X
 jCRqZqLLnYM+Pknj0c0Jr3TLwuXzurTsUOYjC/VZtpUrOS0F5TXgG9o7/nWmOiWS/Tv4ZKOiaLU
 3fWgcnz6I4ppoz2qalORoA60MQF9P4L3I=
X-Gm-Gg: ASbGncsXZst+psnyuCNj6Djtxn3d88c9TbSK6FCU4q+eh9zgg+Zm+oUjuD96nT30bYc
 gtmuJL3352NrDwPZ690jQepZqbsKFyIpUBeL36pUy5Yt2veVcWrZ0NbQ8SukpFaQqfPe5pATduC
 tyAUXx64iJaKl4VEP0JWXR6oQ=
X-Received: by 2002:ad4:574c:0:b0:707:4668:3314 with SMTP id
 6a1803df08f44-707466835a7mr39277066d6.1.1753702020724; 
 Mon, 28 Jul 2025 04:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHWmPW1x0f5ZXVOwoewoMiOqBrQb7mKuRoZ+/sjs6npSaLIw5VYykHidwr4xY19ew8tDrk8VzS6dIKHUEHJPc=
X-Received: by 2002:ad4:574c:0:b0:707:4668:3314 with SMTP id
 6a1803df08f44-707466835a7mr39276786d6.1.1753702020261; Mon, 28 Jul 2025
 04:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250717115246.3830007-1-armbru@redhat.com>
 <87a54or29i.fsf@pond.sub.org>
In-Reply-To: <87a54or29i.fsf@pond.sub.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 28 Jul 2025 14:26:49 +0300
X-Gm-Features: Ac12FXwMLehkJX_nNKcKXfg2dtuwuAarCsXSGw5M7vn6noB3W1yjv92TtgKJako
Message-ID: <CAPMcbCo44oAMKMFMvnLtOWKdL+E9kJmkOnFP_i1-iZn1JnVrtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] qga: Doc fixes and improvements
To: Markus Armbruster <armbru@redhat.com>
Cc: michael.roth@amd.com, qemu-devel@nongnu.org, eblake@redhat.com, 
 jsnow@redhat.com, berrange@redhat.com
Content-Type: multipart/alternative; boundary="000000000000f5d597063afb9142"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

--000000000000f5d597063afb9142
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Markus, feel free to do PR with this

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Best Regards,
Konstantin Kostiuk.


On Mon, Jul 28, 2025 at 2:19=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Markus Armbruster <armbru@redhat.com> writes:
>
> > This series touches only doc comments.  I'd like to get it into 10.1.
>
> Kostiantyn, Michael, would you like me to do the PR for this?
>
>

--000000000000f5d597063afb9142
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Markus, feel free to do PR with this<br></div><div><b=
r></div><div>Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk=
@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><div><br></=
div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail=
_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Konstantin Kostiu=
k.</div></div></div></div><br></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 28, 2025 at=
 2:19=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com"=
>armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com=
" target=3D"_blank">armbru@redhat.com</a>&gt; writes:<br>
<br>
&gt; This series touches only doc comments.=C2=A0 I&#39;d like to get it in=
to 10.1.<br>
<br>
Kostiantyn, Michael, would you like me to do the PR for this?<br>
<br>
</blockquote></div>

--000000000000f5d597063afb9142--


