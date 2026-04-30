Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B34CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVgA-0007M7-Vk; Thu, 30 Apr 2026 14:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wIVg8-0007L1-Oi
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:00:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wIVg6-0006lK-BO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:00:00 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82f8cebc935so620865b3a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777571996; cv=none;
 d=google.com; s=arc-20240605;
 b=Q2euWfMgLLcKBkOqQdvqliEHMeCBrCQ21D7Y3LvbxNs8VHl04blJtTJUkTszWnlKYE
 9PYLNIdDI5E2p3Z1dAfqr/bp4VLvEvbLiBVRh894CW9fxW22YfuXr8M0KAnRKAg+s9Au
 hQ72AZuanhjv1Y4a8V20Znw8cnsMjxSMXuOf/nrptuJAUCi0aFrEYvi6+FxpKrpq6QTE
 MrIewW5sjbtsSHqqo6VoxQurIe3c/um7gp/pFTUqKSC4XrMCxQdzhzHtlqgEKcePR0SB
 zo++xagpGdjEQevxUbczUo5L/4HnVmIEdqh9F8CssQTMWx1mkLJjR5c1jLuWUN8vUUXA
 ogNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W0ub+sw+MaRX9tcCcJvZdexi34mPPJ5FpkN1X/DOqhY=;
 fh=3g/RtmIJ0XnJ/LUnge+xkvMPyaxE90w9XFljHdbWMco=;
 b=GiloxtpvUMefftUeJyvfXwnqbo1QjIq8OAevrdurrBvAQKbCAD20X3GMLCnj3q4DAj
 kgXyE6/uv/O0nhAKpk6c/5fs/VtpmzNE/Y8YMGyWSMc+6ObO8iQnONKra/xOShrn+LLU
 BaQp+bmk0a0YQBTM+iLFpf4XE+lUai1TgpblmMuezDniugqg+5lYNeF/Fn3OlHkvA2tL
 MH6Y4kizIPjKo63SEY2/1o34wekJYgDWbI8Q61T3zUvtc679O3FEW1fLiy+8X8Yad2+L
 bR2+ECCnYsEfZTj9TBSuPxAykJuhPF7sxE4kpUl357YEikyl9ISarFNNsAbjqYGt7wsA
 d7wg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777571996; x=1778176796;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W0ub+sw+MaRX9tcCcJvZdexi34mPPJ5FpkN1X/DOqhY=;
 b=iLAR32ILIxJG5X1VtYP/wu3rJQcNNC5xmVG+YDCkvdWd8sKfs53LI5dQwJ2jjq+JZQ
 QhyEjs+6yIyjLYkseZHSadZ9N/SU6XFhRIlhdMGJMCwU7+0FW8AMmc55DtIjVn+hKV9W
 oWRDIT1Skg/aA2SMTifYjj5Vxpl2pu+dQ4WPTbxvVQlgvBOvj54gamT0PYVNPyQTL+b9
 PhKdoVyiJWTnNHwBGq47mVYcXxJUdIR8tWOvs64VN73hH16MJ6hSy/nyhzYfLfquSnej
 72Pu5bYhJkjTL0JoqmkcIhuM3E3ny/t0LEngj4zPO08Z+Rs6BsPrBPB/CSnnzCJErg60
 hj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777571996; x=1778176796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0ub+sw+MaRX9tcCcJvZdexi34mPPJ5FpkN1X/DOqhY=;
 b=jEhG+EfaRradLr0gKhzosAnhR+P1VJhmIBVUa+doTyKeCHyralLgdGvwGowWSh6Uo5
 +itGUz+xUV9YsNlsN654YDiBCQkBR63K8HW+T4bXn96m+JsxDMsnoegzoM9gzxJFSKED
 PyxYJChPDj1vrml722ELb0seKBzidGaAbFdf5okB2/0CMYMAFBFzojp744eS43Qr8EGS
 0hyCV1yk2QhG5kT4LYzlcU1NuNxAPJpeMjCmPG5K7/YuEJ3AE2/91CQEnScbY+5v9cOS
 v58vCii1G2Tzmv9cVu6VdLQoPfOxYOiBJVihvqsWoa9ZY5F1ESDXCQ6VO8mNm6l+ddLM
 Sukg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/caTn7etaop0k+jaq3ZalNLYuuyFJb8M7hBpJDfvIy5otyCMzJ8A8th/CL7WD42gxv9jp15B+r1SvP@nongnu.org
X-Gm-Message-State: AOJu0YyBpQA4pIvnBnpMo8pixyn+Du3ekm60hU0r7UOcIVSYlCZ6wraS
 giyKHM7d5WdzqKpP1Y3K4m7fLMQtb0CKm8vrav/utMqsFYzVZjCA4qivbExcHfgVLA4O3qNuc7m
 6FAZ9YIjENHYQLojROGlRzGgxnLiKFwO39kcgE5lsmQ==
X-Gm-Gg: AeBDieshZkodt7hi+PzaE+00wUbaHtH9zxTELbDEva504oeeM430/yIoe3WLRP+RR/B
 cD9rjuKdcUIpd+4w1AHukuJuAv+tDKlSKpsAil83JMTJ/eBerIeiOuO9i9zVjVVGZXZ8mpK0eq7
 M0xH0yRCp8xRMpEsvaR5fPM7c4wIVAVyHjdpwlOCJsPn9dDMU0yTLQOiuVCUxrec314U3VJ+eDX
 HBxwX0+Yg8FVFQjDaibIeN+9qfaqha9MgSsbqO262ImtWcaSG582Z/jT/GauBNK4Rda4Ul9ZsuG
 /Yf5VVzHEk6FZkN2yg==
X-Received: by 2002:a05:6a00:b46:b0:81f:be3c:9c9e with SMTP id
 d2e1a72fcca58-834fdcb6d48mr4736066b3a.33.1777571996383; Thu, 30 Apr 2026
 10:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
 <CAFEAcA9zPTngrm4ZG3t96Rr7bKRrmx7MB6-0QSjd=ntj+X0uNA@mail.gmail.com>
In-Reply-To: <CAFEAcA9zPTngrm4ZG3t96Rr7bKRrmx7MB6-0QSjd=ntj+X0uNA@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 30 Apr 2026 11:59:45 -0600
X-Gm-Features: AVHnY4LRGFExhiNf9pXh5BHjM8t-tPrdvB_Thuur3NozWKiw2QyBfNGUyaLPr2M
Message-ID: <CANCZdfo4LrwUFxgp5E1ovAZVL1VBEkVknPEzrZH3mxZ02hhnvA@mail.gmail.com>
Subject: Re: [PATCH] bsd-user: remove cached host page size and rely on
 qemu_real_host_page_size()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mohamed Ayman <mohamedaymanworkspace@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000006849550650b13b52"
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x42b.google.com
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

--0000000000006849550650b13b52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 11:46=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> On Thu, 30 Apr 2026 at 18:08, Mohamed Ayman
> <mohamedaymanworkspace@gmail.com> wrote:
> >
> > The bsd-user implementation previously cached host page size and mask
> > in global variables (qemu_host_page_size and qemu_host_page_mask),
> > which duplicated information already available through
> > qemu_real_host_page_size().
> >
> > This introduces unnecessary global state and potential inconsistencies
> > if the host page size is queried or changes during initialization.
> >
> > Replace all usages of qemu_host_page_size and qemu_host_page_mask with
> > qemu_real_host_page_size() and derived expressions, and update all
> > alignment and masking logic accordingly.
> >
> > This simplifies the code and ensures a single source of truth for host
> > page size handling across bsd-user memory management paths.
> >
> > No functional change intended.
> >
> > Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
> > ---
>
> This would be a nice change to have to the bsd-user code,
> because it opens the way for us to rename qemu_real_host_page_size()
> to qemu_host_page_size(), and similarly qemu_real_host_page_mask().
> (If I remember a recent IRC conversation correctly, they only have
> the _real_ infix for historical reasons and because the bsd-user
> globals are currently using the more obvious names.)


I'd love to see this as well. This has been one of my todo items for far to=
o
long since I've been distracted with other things (like upstreaming).

I wonder if these changes have been tried against the blitz branch at
https://github.com/qemu-bsd-user/qemu-bsd-user? I just pushed an 11.0-based
version of that branch, but have only lightly tested it. Theres some pendin=
g
issues with some shared libraries on riscv (IIRC the issue correctly) whose
fixes
break shared libraries on other platforms). If you could test against that,
I'd love
to bring them in with this quarter's upstream pull request that I'm
planning on doing
once I get the ioctl patch series sorted out (and it seems like I made
several
mistakes somewhere with it that I need to go patch up).

Warner

--0000000000006849550650b13b52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 30,=
 2026 at 11:46=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell=
@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Thu, 30 Apr 2026 at 18:08, Mohamed =
Ayman<br>
&lt;<a href=3D"mailto:mohamedaymanworkspace@gmail.com" target=3D"_blank">mo=
hamedaymanworkspace@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The bsd-user implementation previously cached host page size and mask<=
br>
&gt; in global variables (qemu_host_page_size and qemu_host_page_mask),<br>
&gt; which duplicated information already available through<br>
&gt; qemu_real_host_page_size().<br>
&gt;<br>
&gt; This introduces unnecessary global state and potential inconsistencies=
<br>
&gt; if the host page size is queried or changes during initialization.<br>
&gt;<br>
&gt; Replace all usages of qemu_host_page_size and qemu_host_page_mask with=
<br>
&gt; qemu_real_host_page_size() and derived expressions, and update all<br>
&gt; alignment and masking logic accordingly.<br>
&gt;<br>
&gt; This simplifies the code and ensures a single source of truth for host=
<br>
&gt; page size handling across bsd-user memory management paths.<br>
&gt;<br>
&gt; No functional change intended.<br>
&gt;<br>
&gt; Signed-off-by: Mohamed Ayman &lt;<a href=3D"mailto:mohamedaymanworkspa=
ce@gmail.com" target=3D"_blank">mohamedaymanworkspace@gmail.com</a>&gt;<br>
&gt; ---<br>
<br>
This would be a nice change to have to the bsd-user code,<br>
because it opens the way for us to rename qemu_real_host_page_size()<br>
to qemu_host_page_size(), and similarly qemu_real_host_page_mask().<br>
(If I remember a recent IRC conversation correctly, they only have<br>
the _real_ infix for historical reasons and because the bsd-user<br>
globals are currently using the more obvious names.)</blockquote><div><br><=
/div><div>I&#39;d love to see this as well. This has been one of my todo it=
ems for far too</div><div>long since I&#39;ve been distracted with other th=
ings (like upstreaming).</div><div><br></div><div>I wonder if these changes=
 have been tried against the blitz branch at</div><div><a href=3D"https://g=
ithub.com/qemu-bsd-user/qemu-bsd-user">https://github.com/qemu-bsd-user/qem=
u-bsd-user</a>? I just pushed an 11.0-based</div><div>version of that branc=
h, but have only lightly tested it. Theres some pending</div><div>issues wi=
th some shared libraries on riscv (IIRC the issue correctly) whose fixes</d=
iv><div>break shared libraries on other platforms). If you could test again=
st that, I&#39;d love</div><div>to bring them in with this quarter&#39;s up=
stream pull request that I&#39;m planning on doing</div><div>once I get the=
 ioctl patch series sorted out (and it seems like I made several</div><div>=
mistakes somewhere with it that I need to go patch up).</div><div><br></div=
><div>Warner</div><div><br></div></div></div>

--0000000000006849550650b13b52--

