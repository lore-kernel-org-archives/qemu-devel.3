Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0493CE8FDA7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 11:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ6Q2-0003HO-9e; Fri, 26 Dec 2025 06:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vZ6Q0-0003H1-GB
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 06:55:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vZ6Py-0006dh-5o
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 06:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766750136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zr1pcU1AXF4WLywzGmimFUqNKl6VFtLflXs8cXBbdbE=;
 b=X+GG38GHA0fnTh+PuYaFqOanQVGcf743OdwVY+tO3pTY59edMaZzWmcExbHqUEyol/bF2m
 yTeKBuxd7u6mMQ3xUmqGjOw6bAh+BlDXBwKY20aADpQPI5bqo0ZyGz1UYwwqUH+aodyyyM
 +E8/L7iYqeDzZEGV6iENhmz9el0ESRo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-g3AxpA8XMsGWJRLOH_ml9A-1; Fri, 26 Dec 2025 06:55:34 -0500
X-MC-Unique: g3AxpA8XMsGWJRLOH_ml9A-1
X-Mimecast-MFC-AGG-ID: g3AxpA8XMsGWJRLOH_ml9A_1766750133
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34c314af2d4so7167745a91.3
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 03:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766750132; x=1767354932; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zr1pcU1AXF4WLywzGmimFUqNKl6VFtLflXs8cXBbdbE=;
 b=lY4T8trDdrcGesBv8gJ1bVBVCtAL4V7iqE1wPteS9T+efckuXMVPaCXWwJ31JUMrua
 Q2fkag80cZFhTQigbIHMvvIiqU+RxWNLCu2i2oB3PCNyyuZKf5AaQ++yx5wdTgTRV5ZS
 qBlkapQ7hDr6CnJBEEQtMkyACA1HQY1BVVD5rvVitL8QE4MrCp7nUQSoJlQYVJ70zLkG
 iOiczKYUBxmmLdtY89Ig5hlK+F+2h/6NRRa0SS/2n+9BbYMWVO0oCUMJSithisj/jDMg
 4RJYFcH29gqcHGWWfyiNvxktFz55k3a8AHJ2TPgDd9kwQZ7R/s+k2vvj2H1Z7g/aC8ls
 W33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766750132; x=1767354932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zr1pcU1AXF4WLywzGmimFUqNKl6VFtLflXs8cXBbdbE=;
 b=qA+qiZ1OfcuSQ/uglR1ef4cEii8SvgvBiyA24+C+NjDRSROlL3urdvM3xmPMdytRaw
 uC/hLkTlfv07d4kc7xkrzfdc+p3Aksiu6UIwG1KanIEmeOyDjeu8+jm06rFc0FlHCwKy
 10HXwJpX3eqKYCpi/472GT/uA8d4thC1QjANaWzsDEBg1TLMuh8QaRr5ROXyEcBu4Klw
 QLh8ce2Ts2GIjFbC9VXxMy5wmwwK3/Eg/c1bJ2RWUtn3IscFzEbL/sIkNR4oxgCZipfW
 EXwDax1ACofsDfUI+F1CMB8Sqa1oZQzUtaZHeBPbndMwbpFFDPLDdfyahj/yaqndcAnC
 YJNQ==
X-Gm-Message-State: AOJu0Yyx4Wa7Fd2t3H0G1TbgPAWlOwchmYx2l113GXr4oyl6CRJ9xvT7
 RzZPiaBAMZxBPjc0DE+oLNZHHGA5JM+0cU0W6d5rCyo/L3ptxILLHHHBAzYah1KWxMddff6wBOy
 +kJZJKGAvLl+7NOxSkzog93URiR/zQhqzNiMMmLXBRo7Vs9UuDedi29m2AO7h34WZ9Sj65PswEL
 MphqT6lc1eJdTCebKXTcnoZKVEyP/KY0qINPksCc4p/w==
X-Gm-Gg: AY/fxX4fgLEgFMyKyytCiER2bUjwOfbCNO1GLI/guCzv3mrQkhwcOlyPKlWIZCniPoC
 P09TjLhT1U+EiKucmeeiLvp4ArpBIXK0OdwNhIg+qtL4udpT6i9pAuarpN54JEqysmMinUWo/iX
 kFuz43L6kHCKAKFF7YDqUw0SaKg+7QRnoNcZoQ9A8YfM5lfQmIIh1hNN/y020++3RCW+g1ceUa
X-Received: by 2002:a17:90b:3c4b:b0:34c:e5fc:faec with SMTP id
 98e67ed59e1d1-34e9212f72dmr16366634a91.2.1766750132517; 
 Fri, 26 Dec 2025 03:55:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYirxuZnhkEFZ8VcZSpLSrkFO2IFRVSMjvghXalyEf54/A2sDuqyFzQ8bEc7n+z6uzTmlQoOW14KKr4eWOHP4=
X-Received: by 2002:a17:90b:3c4b:b0:34c:e5fc:faec with SMTP id
 98e67ed59e1d1-34e9212f72dmr16366627a91.2.1766750132076; Fri, 26 Dec 2025
 03:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20251225063412.572-1-luzhipeng@cestc.cn>
In-Reply-To: <20251225063412.572-1-luzhipeng@cestc.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Dec 2025 15:55:19 +0400
X-Gm-Features: AQt7F2rcf5IMJJc4ERxY7sERACvnA_idjPNg16bV2msMFSx6G_rvLSAmWUWeoGg
Message-ID: <CAMxuvazP080sV8R34h0LiuzTQp9gta0QRa5JabUeWBYxwtRMAg@mail.gmail.com>
Subject: Re: [PATCH] chardev/pty: fix incorrect return value in
 char_pty_chr_write
To: luzhipeng <luzhipeng@cestc.cn>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000796430646d9921c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

--0000000000000796430646d9921c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Dec 25, 2025 at 10:41=E2=80=AFAM luzhipeng <luzhipeng@cestc.cn> wro=
te:

> In char_pty_chr_write(), when the PTY is not connected (s->connected =3D=
=3D
> false), the function attempts a non-blocking poll to check if the fd is
> writable. However, even if the fd is not writable or if io_channel_send()
> fails the function unconditionally returns 'len', falsely indicating that
> all data was successfully written.
>
> Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
>




> ---
>  chardev/char-pty.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 652b0bd9e7..37a20d5f4b 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -124,11 +124,15 @@ static int char_pty_chr_write(Chardev *chr, const
> uint8_t *buf, int len)
>      pfd.revents =3D 0;
>      rc =3D RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
>      g_assert(rc >=3D 0);
> +    if ((pfd.revents & G_IO_HUP) || !(pfd.revents & G_IO_OUT)) {
> +        return 0;
> +    }
>      if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
>          return io_channel_send(s->ioc, buf, len);
>      }
>
> -    return len;
> +    int ret =3D io_channel_send(s->ioc, buf, len);
> +    return ret;
>


The 'ret' variable is probably unnecessary.

I suppose this will return 0 in general (unless the fd state has changed
after the poll)

So this will likely conflict the behaviour change from:

commit 1c64fdbc8177058802df205f5d7cd65edafa59a8
Author: Ed Swierk <eswierk@skyportsystems.com>
Date:   Tue Jan 31 05:45:29 2017 -0800

    char: drop data written to a disconnected pty

    When a serial port writes data to a pty that's disconnected, drop the
    data and return the length dropped. This avoids triggering pointless
    retries in callers like the 16550A serial_xmit(), and causes
    qemu_chr_fe_write() to write all data to the log file, rather than
    logging only while a pty client like virsh console happens to be
    connected.

    Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
    Message-Id: <
1485870329-79428-1-git-send-email-eswierk@skyportsystems.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 27eb85f505..ecf2c7a5c4 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -129,7 +129,7 @@ static int char_pty_chr_write(Chardev *chr, const
uint8_t *buf, int len)
         /* guest sends data, check for (re-)connect */
         pty_chr_update_read_handler_locked(chr);
         if (!s->connected) {
-            return 0;
+            return len;

--0000000000000796430646d9921c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 25, 2=
025 at 10:41=E2=80=AFAM luzhipeng &lt;<a href=3D"mailto:luzhipeng@cestc.cn"=
>luzhipeng@cestc.cn</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">In char_pty_chr_write(), when the PTY is not connected (=
s-&gt;connected =3D=3D<br>
false), the function attempts a non-blocking poll to check if the fd is <br=
>
writable. However, even if the fd is not writable or if io_channel_send()<b=
r>
fails the function unconditionally returns &#39;len&#39;, falsely indicatin=
g that<br>
all data was successfully written.<br>
<br>
Signed-off-by: luzhipeng &lt;<a href=3D"mailto:luzhipeng@cestc.cn" target=
=3D"_blank">luzhipeng@cestc.cn</a>&gt;<br></blockquote><div><br></div><div>=
<br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0chardev/char-pty.c | 6 +++++-<br>
=C2=A01 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/chardev/char-pty.c b/chardev/char-pty.c<br>
index 652b0bd9e7..37a20d5f4b 100644<br>
--- a/chardev/char-pty.c<br>
+++ b/chardev/char-pty.c<br>
@@ -124,11 +124,15 @@ static int char_pty_chr_write(Chardev *chr, const uin=
t8_t *buf, int len)<br>
=C2=A0 =C2=A0 =C2=A0pfd.revents =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0rc =3D RETRY_ON_EINTR(g_poll(&amp;pfd, 1, 0));<br>
=C2=A0 =C2=A0 =C2=A0g_assert(rc &gt;=3D 0);<br>
+=C2=A0 =C2=A0 if ((pfd.revents &amp; G_IO_HUP) || !(pfd.revents &amp; G_IO=
_OUT)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0if (!(pfd.revents &amp; G_IO_HUP) &amp;&amp; (pfd.reven=
ts &amp; G_IO_OUT)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return io_channel_send(s-&gt;ioc, buf, le=
n);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 return len;<br>
+=C2=A0 =C2=A0 int ret =3D io_channel_send(s-&gt;ioc, buf, len);<br>
+=C2=A0 =C2=A0 return ret;<br></blockquote><div><br></div><div><br></div><d=
iv>The &#39;ret&#39; variable is probably unnecessary.</div><div><div><br><=
/div><div>I suppose this will return 0 in general (unless the fd state has =
changed after the poll)</div><div><br></div><div>So this will likely confli=
ct the behaviour change from:</div><div><br></div><div>commit 1c64fdbc81770=
58802df205f5d7cd65edafa59a8<br>Author: Ed Swierk &lt;<a href=3D"mailto:eswi=
erk@skyportsystems.com">eswierk@skyportsystems.com</a>&gt;<br>Date: =C2=A0 =
Tue Jan 31 05:45:29 2017 -0800<br><br>=C2=A0 =C2=A0 char: drop data written=
 to a disconnected pty<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 When a serial por=
t writes data to a pty that&#39;s disconnected, drop the<br>=C2=A0 =C2=A0 d=
ata and return the length dropped. This avoids triggering pointless<br>=C2=
=A0 =C2=A0 retries in callers like the 16550A serial_xmit(), and causes<br>=
=C2=A0 =C2=A0 qemu_chr_fe_write() to write all data to the log file, rather=
 than<br>=C2=A0 =C2=A0 logging only while a pty client like virsh console h=
appens to be<br>=C2=A0 =C2=A0 connected.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0=
 Signed-off-by: Ed Swierk &lt;<a href=3D"mailto:eswierk@skyportsystems.com"=
>eswierk@skyportsystems.com</a>&gt;<br>=C2=A0 =C2=A0 Message-Id: &lt;<a hre=
f=3D"mailto:1485870329-79428-1-git-send-email-eswierk@skyportsystems.com">1=
485870329-79428-1-git-send-email-eswierk@skyportsystems.com</a>&gt;<br>=C2=
=A0 =C2=A0 Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redh=
at.com">pbonzini@redhat.com</a>&gt;<br><br>diff --git a/chardev/char-pty.c =
b/chardev/char-pty.c<br>index 27eb85f505..ecf2c7a5c4 100644<br>--- a/charde=
v/char-pty.c<br>+++ b/chardev/char-pty.c<br>@@ -129,7 +129,7 @@ static int =
char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* guest sends data, check for (re-)connect */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pty_chr_update_read_handler_locked(chr);<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;connected) {<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return len;</div><div><br></div><br></div></div></div>

--0000000000000796430646d9921c--


