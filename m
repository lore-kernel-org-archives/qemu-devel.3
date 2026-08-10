Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36245C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtR0R-0005KA-72; Mon, 10 Aug 2026 10:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtR0A-0005EL-Sn
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtR05-00044g-TY
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786372151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I9V7Nw0RzSzijOIEoqYKYSnE4H5wX1mgpQibTvNRov4=;
 b=huKPwaB9MzW0uf9iNdABQwpDwazNQG5mhK/o8/L8BZDrtVZIXWrBJvb3AYNAMJJJBgl+f0
 DhUWIFP+EYpyVvtQp9KLEqNCQ1CZr7FCIuE6HSBI4+RGdoOXIjicOjgMkUOlfg4a1hMjDI
 tMfU9T6JSvrWMueYlP6ZQ6v0YGLdRX4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-UAyHi8IxNw-MVcIEcQSiLw-1; Mon, 10 Aug 2026 10:28:58 -0400
X-MC-Unique: UAyHi8IxNw-MVcIEcQSiLw-1
X-Mimecast-MFC-AGG-ID: UAyHi8IxNw-MVcIEcQSiLw_1786372138
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9077b4c35c5so36562896d6.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 07:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786372138; cv=none;
 d=google.com; s=arc-20260327;
 b=GzMZRjHghEK04exZEECych7FVrzKDLpDdjfCsPrH5/iD8koOcdcAqxrSPA3g9oB/DU
 Sj1i6YSSeX4o6NMOG9O+MCRZq9e4plCwVoPocsG1VvazzV6IE+jPIO2H9LQQTSgfkmBw
 lbFfuiQEy/zkHsRuKjozhpaBjf2YO+7uLDTIAxvjOuPN+YPZ5EQHw897Lm3HVXJE4ZOI
 dFPrhRK1vx7xJmDZQu9hdErfKEZdWTAPfo7qJ7I/5j5hBk9/wYJgXDYAF6WvljDKpGgu
 k1kFtiG/iyxp9J8LtnA4CZuWP1Metp+OIjMiOrlTMC+bhKmQ3cQENv9kSGtVTt5hSBHV
 W2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I9V7Nw0RzSzijOIEoqYKYSnE4H5wX1mgpQibTvNRov4=;
 fh=6hWWjm5dNq8xXHr4D0jOwOGQH9FGwfwG/MIqWwBvjt8=;
 b=kM5/MRsj6/bO3EGMFgbxQnhtoBJtvul+K2FzWUpd+eWiXm0blBIICX0AWiaqk5czGU
 Ix8MYMMddwbLRqv/+RoNT6FSFk0GqIQsQVfVqUNsoYtiuLhJYQiUp0DRsquf3Ta1+06s
 4shldKkYo7yWAoHqTmYDnQWZxrlA9Gqiqhq+2AHfu1zQdy39UMyUU8gKRDnJGlN++oam
 /Ep9vFeiAEzzQyzCq4eVKtZUt9pNnZDzhW/i01Oz/hsxrGTposwjt5/E5J2A33s7D2FG
 NfuxQUeU/pgVtv5Z/3uh/KVpmOKJVI0lRc8pVzDdoFmXvj7xwwTSuk5MiM/9xZc00gM3
 hA9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786372138; x=1786976938; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I9V7Nw0RzSzijOIEoqYKYSnE4H5wX1mgpQibTvNRov4=;
 b=F9rBKa9bAXNAUB48FajLudtq9s5HYwq84fMi576jqyq2xd2EYYweutbCg95hEovX6/
 xZ7OEESzYaV3r643x2PCSA+AcT+e2aem1EhAa/lhocTCX1wtVQLvQt2kNzqKcY876LXN
 sQujlRpCpdcHxN52RhLM85oJ19mZ3X6sbgjyQIfbJ1hWneS/0Csp0V4NM8qFuKOdpT+s
 plzbF6LWYcNHB748eaLj2T7GPa9wlN+5ibdhY69yUiN8kzWMglVNtLfgZ1mMTkjl3ovn
 QS1NauBuLav0XELdyzrF5vE4yL1IATfqE48jLKWSDfB0+2nNXqAxpUM8CulgE8eyfmaP
 gIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786372138; x=1786976938;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I9V7Nw0RzSzijOIEoqYKYSnE4H5wX1mgpQibTvNRov4=;
 b=lST2rm4sgqgazLA0YiZ87pyDbBUMS7NmP59RRwQ9akdMIsSy3Oy0GOi+jLCDbwqDwN
 tBCFawVrS87O/BUH78oR87rcwPxMT3bchPPbMawQt08hFn9twoZWjjvKkK6LtZYNXTPq
 yaoV08yf9/8ZCD0FVQmtpHzfwew0p3PDIUdAG/2j4VgKG9QHZPPM2xU5ta0eT+NBObP0
 tiG2b5ZMraP5mMK/lJcesnZOa9s55yjNTPseChVkNkPsfhItiE7Rkkdj0kYhvbBsWFdZ
 hfDHLS8Jb0+98D+R6sY5e1UP1RCUvK0RU6FBZjKWytvICQcvrQqxsYa+RglLlUYObD2/
 nygA==
X-Gm-Message-State: AOJu0YxFdenE+PWkBaBTw1steI/MSZHoPfp/61m4/WCXdfWav1HR56ln
 ZRuD7rW5EvxEuYUCNJtN2VqGCeT60xgAM9BDwZpJDOqlymDJPYnsF4Wq05S6RGqENN3zzOAPNcw
 7rppUwogjKVgKiMlJS8wGPFNnfw97MlD5uK8z27A+Xj0uuhSDh/USJ0ijrgxMBaKtqVQ+dDR40W
 C74IeyOuluo48ucS0M+m7hsjhIhWzNanc=
X-Gm-Gg: AR+sD10XwvJxpfBUm1g5sfx/KoCv5AyjwGWhTsN+w/50KmX4DetBbcN4WkjIZNerrnq
 TuXHT3zSTyiTvmqkfxOuhMh5Vw9CIXdz0VA/MK4OWasalVpBZaHsKTNCUHFmPZ7Ylihs8qcq618
 TKyFKEc2fqYQKJR5hejVEBYYjwgqk89ejuuj6VDxM/vDRWGjvoFu8QRGW1qyA=
X-Received: by 2002:a05:6214:21e7:b0:8ee:fbc5:8110 with SMTP id
 6a1803df08f44-90a5e04ca4fmr24240546d6.32.1786372137575; 
 Mon, 10 Aug 2026 07:28:57 -0700 (PDT)
X-Received: by 2002:a05:6214:21e7:b0:8ee:fbc5:8110 with SMTP id
 6a1803df08f44-90a5e04ca4fmr24239686d6.32.1786372136956; Mon, 10 Aug 2026
 07:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260810140641.161728-1-kkostiuk@redhat.com>
 <CAFEAcA996EVXzZNTH4cSM0iFf8iCdM-ZC=voMJSvnz3B=W9c=A@mail.gmail.com>
In-Reply-To: <CAFEAcA996EVXzZNTH4cSM0iFf8iCdM-ZC=voMJSvnz3B=W9c=A@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 10 Aug 2026 17:28:45 +0300
X-Gm-Features: AUfX_mzdxFi8PI_b3ZI35eelPGlT0OYTcCylpAc-8IFQJdAXo1-6V3LY4H-p4Uk
Message-ID: <CAPMcbCoPWc846PFZA=yeGugkbGLTLqH2MP9eh2AK_Ojcu-uejQ@mail.gmail.com>
Subject: Re: [PATCH v3] qga: Change effective user/group ID in guest-ssh-*
 commands
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Valentino Paulon <valentino.paulon88@gmail.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000a90f400658b22ce8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000a90f400658b22ce8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 5:17=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Mon, 10 Aug 2026 at 15:07, Kostiantyn Kostiuk <kkostiuk@redhat.com>
> wrote:
> >
> > Before this commit, when qmp_guest_ssh_add_authorized_keys adds an
> > SSH key for an existing local user, the agent (running as root) decides
> > whether to create the user's .ssh directory with a symlink-following
> > directory test, and then writes and chowns the authorized_keys file.
> > A local unprivileged user who owns their home directory can pre-stage
> > their .ssh directory (or the authorized_keys file) as a symbolic link
> > so that, when the host or operator triggers a key add for that user,
> > the root agent follows the link and transfers ownership of an arbitrary
> > root-owned file or directory to the unprivileged user, who can then
> rewrite
> > it to obtain root.
> >
> > Fixes: CVE-2026-12080
> > Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929
> >
> > v1: https://patchew.org/QEMU/20260709105707.91209-1-kkostiuk@redhat.com=
/
> > v2 -> v1:
> > Change effective user/group ID instead of checking for symlinks and
> > changing ownership of the file.
> >
> > v2: https://patchew.org/QEMU/20260810104659.82320-1-kkostiuk@redhat.com
> > v3 -> v2:
> > Deduplicate code.
> > Fail daemon when can't rollback effective user/group ID.
> >
> > Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
> > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > ---
> >  qga/commands-posix-ssh.c | 66 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> > index 661972e34e..070cdffcd0 100644
> > --- a/qga/commands-posix-ssh.c
> > +++ b/qga/commands-posix-ssh.c
> > @@ -8,11 +8,29 @@
> >  #include <glib/gstdio.h>
> >  #include <locale.h>
> >  #include <pwd.h>
> > +#include <grp.h>
> >
> >  #include "commands-common-ssh.h"
> >  #include "qapi/error.h"
> >  #include "qga-qapi-commands.h"
> >
> > +typedef struct EffectiveUserInfo {
> > +    uid_t uid;
> > +    gid_t gid;
> > +} EffectiveUserInfo;
> > +
> > +typedef EffectiveUserInfo *PEffectiveUserInfo;
> > +
> > +static void rollback_effective_info(PEffectiveUserInfo info)
> > +{
> > +    if (info) {
> > +        assert(seteuid(info->uid) =3D=3D 0);
> > +        assert(setegid(info->gid) =3D=3D 0);
>
> A brief comment here about why we're happy to assert() here would
> be helpful.
>

Done


>
> > +    }
> > +}
> > +
> > +G_DEFINE_AUTO_CLEANUP_FREE_FUNC(PEffectiveUserInfo,
> rollback_effective_info, NULL);
>
> Don't we also need to g_free(info) in the cleanup function?
>

You are right


>
> thanks
> -- PMM
>
>

--000000000000a90f400658b22ce8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 10,=
 2026 at 5:17=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Mon, 10 Aug 2026 at 15:07, Kostianty=
n Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkos=
tiuk@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Before this commit, when qmp_guest_ssh_add_authorized_keys adds an<br>
&gt; SSH key for an existing local user, the agent (running as root) decide=
s<br>
&gt; whether to create the user&#39;s .ssh directory with a symlink-followi=
ng<br>
&gt; directory test, and then writes and chowns the authorized_keys file.<b=
r>
&gt; A local unprivileged user who owns their home directory can pre-stage<=
br>
&gt; their .ssh directory (or the authorized_keys file) as a symbolic link<=
br>
&gt; so that, when the host or operator triggers a key add for that user,<b=
r>
&gt; the root agent follows the link and transfers ownership of an arbitrar=
y<br>
&gt; root-owned file or directory to the unprivileged user, who can then re=
write<br>
&gt; it to obtain root.<br>
&gt;<br>
&gt; Fixes: CVE-2026-12080<br>
&gt; Fixes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/39=
29" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qe=
mu/-/work_items/3929</a><br>
&gt;<br>
&gt; v1: <a href=3D"https://patchew.org/QEMU/20260709105707.91209-1-kkostiu=
k@redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEM=
U/20260709105707.91209-1-kkostiuk@redhat.com/</a><br>
&gt; v2 -&gt; v1:<br>
&gt; Change effective user/group ID instead of checking for symlinks and<br=
>
&gt; changing ownership of the file.<br>
&gt;<br>
&gt; v2: <a href=3D"https://patchew.org/QEMU/20260810104659.82320-1-kkostiu=
k@redhat.com" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU=
/20260810104659.82320-1-kkostiuk@redhat.com</a><br>
&gt; v3 -&gt; v2:<br>
&gt; Deduplicate code.<br>
&gt; Fail daemon when can&#39;t rollback effective user/group ID.<br>
&gt;<br>
&gt; Reported-by: Valentino Paulon &lt;<a href=3D"mailto:valentino.paulon88=
@gmail.com" target=3D"_blank">valentino.paulon88@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-posix-ssh.c | 66 ++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 66 insertions(+)<br>
&gt;<br>
&gt; diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c<br>
&gt; index 661972e34e..070cdffcd0 100644<br>
&gt; --- a/qga/commands-posix-ssh.c<br>
&gt; +++ b/qga/commands-posix-ssh.c<br>
&gt; @@ -8,11 +8,29 @@<br>
&gt;=C2=A0 #include &lt;glib/gstdio.h&gt;<br>
&gt;=C2=A0 #include &lt;locale.h&gt;<br>
&gt;=C2=A0 #include &lt;pwd.h&gt;<br>
&gt; +#include &lt;grp.h&gt;<br>
&gt;<br>
&gt;=C2=A0 #include &quot;commands-common-ssh.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;qga-qapi-commands.h&quot;<br>
&gt;<br>
&gt; +typedef struct EffectiveUserInfo {<br>
&gt; +=C2=A0 =C2=A0 uid_t uid;<br>
&gt; +=C2=A0 =C2=A0 gid_t gid;<br>
&gt; +} EffectiveUserInfo;<br>
&gt; +<br>
&gt; +typedef EffectiveUserInfo *PEffectiveUserInfo;<br>
&gt; +<br>
&gt; +static void rollback_effective_info(PEffectiveUserInfo info)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (info) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(seteuid(info-&gt;uid) =3D=3D 0);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(setegid(info-&gt;gid) =3D=3D 0);<b=
r>
<br>
A brief comment here about why we&#39;re happy to assert() here would<br>
be helpful.<br></blockquote><div><br></div><div>Done</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +G_DEFINE_AUTO_CLEANUP_FREE_FUNC(PEffectiveUserInfo, rollback_effectiv=
e_info, NULL);<br>
<br>
Don&#39;t we also need to g_free(info) in the cleanup function?<br></blockq=
uote><div><br></div><div>You are right</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div>

--000000000000a90f400658b22ce8--


