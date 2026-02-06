Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700B1EE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPqq-0006sA-5s; Fri, 06 Feb 2026 12:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPql-0006rb-HM
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:42:35 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPqj-0003vP-Jg
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:42:35 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a90055b9e9so11412045ad.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770399752; cv=none;
 d=google.com; s=arc-20240605;
 b=AiCB/W44UNIQmUIHb3vnqjoM6PXdRG5aKM5Dv4l7DO4PWl+WXAZ/lnlVTFcx/NlXJz
 t8sHV6WNMSnHyGS2jr3dMqG3ObsDVtoFwRliD+Zqk6o4OlkU2Pskv9t0IBefo8B+RZG6
 i4BNwhJCPdgdmhVXyF1ywOlqtZAbFS4eC3AFN8hFJKMp0S4LRYklf5bPEljrBu7XTVhv
 IZegLiO/k2cr4wGMkZHr4b3hlTGbidA7HhT8fXIWEgv8CDkty6Q04co9t2wGCOUY5Vpx
 GyxLLVDTGG5ANRu2gjwKS9IV60VVcuVY7Ti/LiHVnorz1bWDHoxvuwR+YqsO1jXDyxOl
 CsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TWrQGoR/mfe4VwCX8d7vKrTvIyzgHMi0/eV2KrOFbc0=;
 fh=KZjezXCSrxx39dO31pbOeDiyxGEGLz3PIZWBEAGptp8=;
 b=EFsJdPUJtj1SXtec8R8E4sAvNMjJ6N5YT8qoUVz0wdN2WQSER6iFmbL/5VrgGowqzs
 C7kRuQtkfjctcLGVWKYLTxKlI3BNS0QbqeShrLGgN7odUWfzfq7VqSkp3h7Ze4YqZqA6
 r81Up/MeD9h4mTRt36kmn4o/EJrhJtvPzxICWJs5LNSUsCsV3ib8n0sD1RHvzrvmwo9D
 LQ51UETVJE15Tr8a+NxtAbVfBPu0uHAc5gXxsox5cdnRGQslpm/lOD8TDrNFvz8d17I0
 YA2lITP/xg6sVy3ZVdQZKVwADZ3ea7VD3ddRhLZ2XkEn2tJ5xrevCiGCsKCW7O1XF7cK
 ElwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770399752; x=1771004552;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TWrQGoR/mfe4VwCX8d7vKrTvIyzgHMi0/eV2KrOFbc0=;
 b=0xxL/m3TH8Xz0IuQg04Q6CE/qqfoaAqd/U+PzVznierxzk2e29T1QjLFZl0f4AgtAt
 DMMfulU5XOAowdpsA7NZxgCeDuxWaqBhJVzTGsZ5R9KGZOJR995rDSntVa9QfTEiG69P
 WW5+PpzL55nUUca6YA8mBtsL7nh2KkiO5afdGt0JwJ2fJXcethaISWV5BUgMzR6+DceQ
 AR9zwmsy47rjJ7LNGTJCsuYI47GqBHYAI6u+naAiKIfVyzI2bPt4I9Fl7ennyO0Nk1Fj
 waXFkCnsLe684nDZMjbn9febWEOU8L0MNfUQfvKgNsiHf4DrucAunMDyIso9/IrWXRbe
 Q41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770399752; x=1771004552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWrQGoR/mfe4VwCX8d7vKrTvIyzgHMi0/eV2KrOFbc0=;
 b=H6cXjBeTXI7UnrPIr7E9jSRTJhDthXwcUGitH6sJ7fOmuWUVfRApFVtu7zQge0rP+C
 x+LkXOhd+MWMf4TygiPzmm1+iEy9TO/uwjO3bQY/xz/sABTR2V1C27JF62BTDHqqSv1p
 PIhV7xQzSE1+S+RVqg509dfsnuRos7QPeIBnqpphouM9CBRBaXqOX7MKE8JIf1JWdPbp
 P9QZ5b3SeTYfXZULgvkSj4OgEbv1e4JIe8SRK3WA3ixn9SidPTk4Z8vgtBgohp7/FhOZ
 ijhMSdba3D3KrmdTNR4qOwdedvRIIUrxvWHAqx3mvDoYj7MaF1Nfzl8FudQLhjeyWikT
 TWHQ==
X-Gm-Message-State: AOJu0YzjBOTKoz+QoXXE1GRzSww1pzyfJzW4cVe3ERYgRznASkcH2xTx
 o2lIpNGAYHTxeJ4Nq9eJ9wI4073aSiCRUPgoQAOVm0WLbZZUPYMKwYL/pgI2ffGVjdcnECprmp5
 f9deOUAK6GbXcWuFlsFgFsrWwPuacQ0RwJoyUkWlFwQ==
X-Gm-Gg: AZuq6aKgfSsqaKvW5BUTOto6Ji+f6lMcDDYLBqG5rn19o8LUj/FuZ7s2QmNxuBZ07cg
 eaBwL5l3eyxFWAQ9oiiaeTR54nElenk9+bSD4p5kKQhWvYFCk9anAW1/e96bkayHHFVnXhmFJT9
 D3xR5WTx3/n7Bpt9UiWq1ZDF5/fO+8EkdoVy7VN5A2YOqaZFbpq7Aw1dKEWBu4rzY5U3bVpJ4K/
 F27Ud3yGUDUG9KdMmW5MBunRm9UAzztGRn39AIpDw6IaOlhPnLh0jDupv4XKeuUAwnWFMLQZ0vm
 uph8Tw==
X-Received: by 2002:a17:902:e749:b0:297:cf96:45bd with SMTP id
 d9443c01a7336-2a95202c238mr36221655ad.19.1770399751978; Fri, 06 Feb 2026
 09:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-13-8d8ff0035372@bsdimp.com>
 <fc65da71-43ac-4bb6-9e5a-3b6bea2a0927@linaro.org>
In-Reply-To: <fc65da71-43ac-4bb6-9e5a-3b6bea2a0927@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Feb 2026 10:42:20 -0700
X-Gm-Features: AZwV_QjAqgS8l9kDyNQSqtAn_fdKa1ABO9cbUCRJM50PMKaMmtuC5WN-lpYpomU
Message-ID: <CANCZdfpejMooJe+1Rdu727ro6HCN5r2=6btsY-p_-EX25nFGwg@mail.gmail.com>
Subject: Re: [PATCH 13/24] bsd-user: Add semaphore operation constants and
 structures
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000053d7bb064a2b506e"
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000053d7bb064a2b506e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 7:48=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > Add System V semaphore operation constants (GETVAL, SETVAL, GETALL, etc=
.)
> > and the target_sembuf and target_semun structures needed for semop(2) a=
nd
> > semctl(2) syscall emulation.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> >
> > diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> > index 62b9bc752b..becd04efb4 100644
> > --- a/bsd-user/syscall_defs.h
> > +++ b/bsd-user/syscall_defs.h
> > @@ -95,6 +95,26 @@ struct bsd_shm_regions {
> >   /*
> >    * sys/sem.h
> >    */
> > +#define TARGET_GETNCNT  3   /* Return the value of semncnt {READ} */
> > +#define TARGET_GETPID   4   /* Return the value of sempid {READ} */
> > +#define TARGET_GETVAL   5   /* Return the value of semval {READ} */
> > +#define TARGET_GETALL   6   /* Return semvals into arg.array {READ} */
> > +#define TARGET_GETZCNT  7   /* Return the value of semzcnt {READ} */
> > +#define TARGET_SETVAL   8   /* Set the value of semval to arg.val
> {ALTER} */
> > +#define TARGET_SETALL   9   /* Set semvals from arg.array {ALTER} */
> > +
> > +struct target_sembuf {
> > +    unsigned short  sem_num;    /* semaphore # */
> > +    short       sem_op;         /* semaphore operation */
> > +    short       sem_flg;        /* operation flags */
> > +};
>
> abi_short, abi_ushort.
>
> > +
> > +union target_semun {
> > +    int     val;        /* value for SETVAL */
>
> abi_int.
>
> > +    abi_ulong   buf;        /* buffer for IPC_STAT & IPC_SET */
> > +    abi_ulong   array;      /* array for GETALL & SETALL */
>
> abi_ptr.
>

Agreed.

--00000000000053d7bb064a2b506e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 7:48=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; Add System V semaphore operation constants (GETVAL, SETVAL, GETALL, et=
c.)<br>
&gt; and the target_sembuf and target_semun structures needed for semop(2) =
and<br>
&gt; semctl(2) syscall emulation.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/syscall_defs.h | 20 ++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 20 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h<br>
&gt; index 62b9bc752b..becd04efb4 100644<br>
&gt; --- a/bsd-user/syscall_defs.h<br>
&gt; +++ b/bsd-user/syscall_defs.h<br>
&gt; @@ -95,6 +95,26 @@ struct bsd_shm_regions {<br>
&gt;=C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 * sys/sem.h<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt; +#define TARGET_GETNCNT=C2=A0 3=C2=A0 =C2=A0/* Return the value of sem=
ncnt {READ} */<br>
&gt; +#define TARGET_GETPID=C2=A0 =C2=A04=C2=A0 =C2=A0/* Return the value o=
f sempid {READ} */<br>
&gt; +#define TARGET_GETVAL=C2=A0 =C2=A05=C2=A0 =C2=A0/* Return the value o=
f semval {READ} */<br>
&gt; +#define TARGET_GETALL=C2=A0 =C2=A06=C2=A0 =C2=A0/* Return semvals int=
o arg.array {READ} */<br>
&gt; +#define TARGET_GETZCNT=C2=A0 7=C2=A0 =C2=A0/* Return the value of sem=
zcnt {READ} */<br>
&gt; +#define TARGET_SETVAL=C2=A0 =C2=A08=C2=A0 =C2=A0/* Set the value of s=
emval to arg.val {ALTER} */<br>
&gt; +#define TARGET_SETALL=C2=A0 =C2=A09=C2=A0 =C2=A0/* Set semvals from a=
rg.array {ALTER} */<br>
&gt; +<br>
&gt; +struct target_sembuf {<br>
&gt; +=C2=A0 =C2=A0 unsigned short=C2=A0 sem_num;=C2=A0 =C2=A0 /* semaphore=
 # */<br>
&gt; +=C2=A0 =C2=A0 short=C2=A0 =C2=A0 =C2=A0 =C2=A0sem_op;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* semaphore operation */<br>
&gt; +=C2=A0 =C2=A0 short=C2=A0 =C2=A0 =C2=A0 =C2=A0sem_flg;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* operation flags */<br>
&gt; +};<br>
<br>
abi_short, abi_ushort.<br>
<br>
&gt; +<br>
&gt; +union target_semun {<br>
&gt; +=C2=A0 =C2=A0 int=C2=A0 =C2=A0 =C2=A0val;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* value for SETVAL */<br>
<br>
abi_int.<br>
<br>
&gt; +=C2=A0 =C2=A0 abi_ulong=C2=A0 =C2=A0buf;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
* buffer for IPC_STAT &amp; IPC_SET */<br>
&gt; +=C2=A0 =C2=A0 abi_ulong=C2=A0 =C2=A0array;=C2=A0 =C2=A0 =C2=A0 /* arr=
ay for GETALL &amp; SETALL */<br>
<br>
abi_ptr.<br></blockquote><div><br></div><div>Agreed.=C2=A0</div></div></div=
>

--00000000000053d7bb064a2b506e--

