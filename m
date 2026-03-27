Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BFC10F285E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6BAw-0001wp-UJ; Fri, 27 Mar 2026 13:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6BAv-0001wg-AQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6BAt-0002vD-D7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774633246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGUlWvrYdtVJTmtFJxoPEtWF4tSkA6a4Db88DvaWTSo=;
 b=P4ihFQ8d+XuVGY78Be+IwyqA8RxWhMvsAWqWN2iUblUF6AGUjTT/yg+d+cnD0S7KcmFdde
 cEB3iPFHfCfn5TSDn7wXzbnhPoj2/0vnsAYz7RHFhSvXUDHcyBJWo/AR0z90QTwBViTNqb
 JbrEM9vB6WyF68N4sH06X1diiRY3vY0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-awZaE-o1NCCGtlDiJ8Vznw-1; Fri, 27 Mar 2026 13:40:44 -0400
X-MC-Unique: awZaE-o1NCCGtlDiJ8Vznw-1
X-Mimecast-MFC-AGG-ID: awZaE-o1NCCGtlDiJ8Vznw_1774633244
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-509044f54aaso70940451cf.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 10:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774633244; cv=none;
 d=google.com; s=arc-20240605;
 b=aJlnwrGx5qzyTUJYVmh3iwxCslYv8Eju6OCIyrFeNTGbHzUb7RpSsnxy5GcLJuK6Db
 C4f9I1FpwdIC7LAgfz6/+J+GSEItIWX7EHi3Uj9DmI7TaKmh82c/yhBVuyhKcOQoLn7Q
 zXmOR/aIJAKxoaKO7SZcsG3C3QV8C3tKgq4RbBgO+LXFmkixbZ5KZ/MWhZ53mOApZ0S9
 0XBgwqjr82ijGAkPYYWwq0u0jkDLA7dtA+CzUZZn+zim5NpQXplto2htFGFSrMYMlQb7
 NO2DuP180IsfYQ+CqSiUrBJQNZUL4DQqmn9eue4x4qJ+bujSKaudCIySkwKwxuyKg3It
 8/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lGUlWvrYdtVJTmtFJxoPEtWF4tSkA6a4Db88DvaWTSo=;
 fh=BeZRKHJnXg5VKpZp9pIG1L6JBImdwLr5Kxe/kRWzq0c=;
 b=ZnEeGXRnSaz+Qz14YzHP7PLr4J8zCEtMJ1RSIng9xRtqu1WimPk5B9KmhQxfUx5KiS
 Ud078/Ac7hSTVQPaeN1O6lVD+8LaGOUDiyiulZ8iEpQshkneduzlXJrSyS4sWhv5oxeN
 6Mgxjuusu/aOJsr/Wer+gkTmv1OPOy/ggqqKPfiweeLHNEWfTKu8kdyN8XXFIYWXPD+6
 vZfVO8tkuAixsNN5BtDYnQTtCH+kqI9S7aXyLWXAN5rbohVUzRhlHboyOgk/DcFEewyf
 /hj5/G7FmCaxQ2+/KEce2tO0YRBEs6v7kpDPlprbUgK25II+i6oRV4FRnIkZf0Q1QRxS
 +Vjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774633244; x=1775238044; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lGUlWvrYdtVJTmtFJxoPEtWF4tSkA6a4Db88DvaWTSo=;
 b=e+ZBpw8rr78NVV/Erdh3s7vIE/kDV1+muquQSe+WfoEqhsrIYdjUlI0dAeoaQ7qkwS
 74/oxtSAhJ0IF2ob6EeBJwTuC3tQN/zMbY4dyzmcHKXpTKttOGey69ooqMH5gZwFhpk8
 PFZnhRYDKk7hu9aj310dLpVghsXFLKrIu9kWKTtZUdo0cYRuXQ/1vSi+r3k+Oq5V3h6k
 VjRyeP3tSf0iTfoMTESYqLrcvchLPAytaogfngY2Io776Kmw7SIOoapgc14dm9o96tLi
 fKX9p6GA0bFYJiUbBPlf18lhRBhfjGhWGdFizsBiri0Q1n8SBUyCn1jVkAkLQVEbhufQ
 QR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774633244; x=1775238044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGUlWvrYdtVJTmtFJxoPEtWF4tSkA6a4Db88DvaWTSo=;
 b=snThP3QU7Bex8ZA+IIS9LHkSJZKwAQofNE0wM9XziY9020KXQ7gAJ5RkDmy8OBX3B2
 WbbHiQ1n9KDEizOT+NoB8VVdvvH1MyeWXSFAz1VF7Fe0uYd9pIxVA/ZgHOcOkamnqBNc
 UfDUST61gdot1TO/AQ5VhWWLOqH5e8mm0c5MdH5mcjbLs0+N0oM5U882g7oiWqTdXR3z
 8h+p+nVHrm9XVjb27SzP9kaUXtsOvbunOBTvj4oRdnaApI+ZcuuHTx/qEbGmA9fWGgjD
 WUB4edlAJjI5iPoqA+oau7HnIIOrkYlohN23NQem5r45FPVbNZvojhS3vE8FGGAnDerT
 MXeQ==
X-Gm-Message-State: AOJu0Yw96o/GEmKP8UM20c/q5Lg9I/c5njRmbEzSBwiUSMKK2U7YKtbH
 jgwMpBG7aZP6O0Gz3Ul1XyXD/53TRQRQEnKiQXQDO9YbHXCzTIkBuwHlzfHgHNQPtWPVBlQib6o
 8GYW10RoLvA4lydEz3SB7WEZpMiJAE+vN1fsL/z4FPfEyIIvWtX1IkeH35aiMuSw31TA48PLrAb
 HpX0Uj/lJdwfb9IZCrippTiefIeW+xunI=
X-Gm-Gg: ATEYQzx0PxbwvSMeK+rt7czkBfU6yTo8jovozk6db3KWW2JkzLhqXLqnM4Uw3Vag1Sl
 rYb9tw3ICT2YJiD33RYrMXdlAr3/NS5z8uhPvqpvVCQXU6D+iJI/yr43ZkSPE5BA2xd5eUq3f3l
 Kjm2XyhWuw1p+UCQ+/YmWD4nSXDFsfYocCQdUt3o9N8XNyvnv1xvHDJr1dPbCXS4Lg1MshX70Gq
 VJohEfU
X-Received: by 2002:a05:622a:1aa9:b0:50b:404a:746e with SMTP id
 d75a77b69052e-50ba39128ccmr44161791cf.47.1774633243652; 
 Fri, 27 Mar 2026 10:40:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa9:b0:50b:404a:746e with SMTP id
 d75a77b69052e-50ba39128ccmr44161351cf.47.1774633243145; Fri, 27 Mar 2026
 10:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260317094806.1944053-1-peter.maydell@linaro.org>
 <CAFEAcA_VF9iztXv9hEp1BvVoqphFM8qnmh1nJC3VUKRbVMeB2g@mail.gmail.com>
In-Reply-To: <CAFEAcA_VF9iztXv9hEp1BvVoqphFM8qnmh1nJC3VUKRbVMeB2g@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Fri, 27 Mar 2026 19:40:32 +0200
X-Gm-Features: AQROBzCjl2n4oCvMnHdS4qcNs-fWLSq-dzP2aP5H8G5iVCo0_iliEYgktI8knB4
Message-ID: <CAPMcbCp_TZOXOAgnnMWWUY_8U903NVRZVYLzXxHHDG2h6-yZMg@mail.gmail.com>
Subject: Re: [PATCH 0/3] fsfreeze-hook: fix bashisms, syslog fallback logic
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000010a0ea064e0500a1"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000010a0ea064e0500a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 7:03=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 17 Mar 2026 at 09:48, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > This patchset fixes some issues with the fsfreeze-hook guest-agent
> > script reported in
> https://gitlab.com/qemu-project/qemu/-/work_items/3339
> >
> >  * the script is a #!/bin/sh one, but it uses various bash-isms.
> >    Most are easy fixes, but getting rid of the PIPESTATUS usage
> >    is a little less obvious, so that gets its own patch
> >  * a bug in the logic determining whether to log to file or syslog
> >    means that if the logfile doesn't exist on first run, the script
> >    will create the logfile but log to syslog (and then log to file
> >    on second and subsequent runs)
> >
> > NB: I have tested this by setting up the script and running it
> > manually in a temp directory, but not as a "real world" fsfreeze.
>
> These have been reviewed, do you plan to take them into a pullreq ?
>

Yes. I keep it for comments from other people.

Do you prefer to merge it into v11.0 or v11.1?


>
> thanks
> -- PMM
>
>

--00000000000010a0ea064e0500a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 27, 2026=
 at 7:03=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 17 Mar 2026 at 09:=
48, Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D=
"_blank">peter.maydell@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; This patchset fixes some issues with the fsfreeze-hook guest-agent<br>
&gt; script reported in <a href=3D"https://gitlab.com/qemu-project/qemu/-/w=
ork_items/3339" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qem=
u-project/qemu/-/work_items/3339</a><br>
&gt;<br>
&gt;=C2=A0 * the script is a #!/bin/sh one, but it uses various bash-isms.<=
br>
&gt;=C2=A0 =C2=A0 Most are easy fixes, but getting rid of the PIPESTATUS us=
age<br>
&gt;=C2=A0 =C2=A0 is a little less obvious, so that gets its own patch<br>
&gt;=C2=A0 * a bug in the logic determining whether to log to file or syslo=
g<br>
&gt;=C2=A0 =C2=A0 means that if the logfile doesn&#39;t exist on first run,=
 the script<br>
&gt;=C2=A0 =C2=A0 will create the logfile but log to syslog (and then log t=
o file<br>
&gt;=C2=A0 =C2=A0 on second and subsequent runs)<br>
&gt;<br>
&gt; NB: I have tested this by setting up the script and running it<br>
&gt; manually in a temp directory, but not as a &quot;real world&quot; fsfr=
eeze.<br>
<br>
These have been reviewed, do you plan to take them into a pullreq ?<br></bl=
ockquote><div><br></div><div>Yes. I keep it for comments from other people.=
=C2=A0</div><div><br></div><div>Do you prefer=C2=A0to merge it into v11.0 o=
r v11.1?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div>
</div>

--00000000000010a0ea064e0500a1--


