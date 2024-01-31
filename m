Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52109C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 23:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVKR3-0005ZF-A1; Wed, 31 Jan 2024 18:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rVKQz-0005Ys-MR
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 18:56:01 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rVKQx-0002E1-77
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 18:56:01 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55c33773c0aso426632a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 15:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1706745357; x=1707350157; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bd1hw/TuzEFqETcvhRZPDtGnBogWtcVaQ7y3CZd1fks=;
 b=Z2f0HZK+JHEyML3u3mlbwPWrjo08zVi8+AjoL5oD44zj102VjnGXz0ZbwKC/DO7zaD
 nAvL7W2M6udpN0QAsqIlgxCjMslJAGzRv1aQxuV+w0FpcZ2mx5lXB0Pq4F4YUqmlZO32
 /4W8FQu+7RFUCH/6V2j4m/nWQ0uIItDdUuqTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706745357; x=1707350157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bd1hw/TuzEFqETcvhRZPDtGnBogWtcVaQ7y3CZd1fks=;
 b=rXqdk+Gpr4OUE06XNa8MvQau8YgU/UVHt6NPt3NQWEJPk/IYA1RDEwldoVIg6oUUyx
 c6ek2lfIWfGgb/JvY9ETEubKZy4f5MkWYDhDPhi2zrMPBIoeB1C8AQw+c1MHDgDOxV8C
 j8iNyTAz5UXbr0677mD3dkYNRExj6mpHw+PJSvD1a8CnWbeHAXNmHR3KcNxM0Hrmdy/T
 /VQgVvAxRYQgFuCbRBjmDqbg6iYA21Z0UKWGWu1/lRhQXw6OIxinoU41EVeD+R8yRd4g
 BFlBhe0cDTZ0H9LbOGo0naTozCvb8ANQGtqkwIDyUqjA0EgJ9m/Hsy0ed7zNE66gL57D
 7eGw==
X-Gm-Message-State: AOJu0YwniUjM3/lpFDlgsdj7pz9e8uWfyBMmdHgQ6f5itOGtEQUsZWxu
 F4aCZTBnzI5fEBfhLIW/45x4eihF4uAxvPE2WUfZzYHxBPezwQYIWm0u0Dmr9T2Cefr0U61NG+0
 43A==
X-Google-Smtp-Source: AGHT+IFiZ6WRl6x3W7LeqCEgsyxisLDi8NKHvWfHG5uTbQqnge+Lo7D134fDm4azjBEAIX6LnMWQnQ==
X-Received: by 2002:a17:906:80cc:b0:a34:d426:1bec with SMTP id
 a12-20020a17090680cc00b00a34d4261becmr2193534ejx.12.1706745356422; 
 Wed, 31 Jan 2024 15:55:56 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com.
 [209.85.208.52]) by smtp.gmail.com with ESMTPSA id
 p7-20020a170906784700b00a310f2b4b91sm6655820ejm.48.2024.01.31.15.55.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 15:55:56 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-55818b7053eso7407a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 15:55:56 -0800 (PST)
X-Received: by 2002:a50:9998:0:b0:55f:9918:dadd with SMTP id
 m24-20020a509998000000b0055f9918daddmr93014edb.2.1706745355897; Wed, 31 Jan
 2024 15:55:55 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
 <CAAfnVBn0+627rLGXeLdsvUge0_VegcbTVuQf8rQwtjuJ3hcJnA@mail.gmail.com>
 <CAJSP0QUV7-_C7WS78WytD9zE0aTt4JgqJTHcP-fU2exbmsN6SA@mail.gmail.com>
In-Reply-To: <CAJSP0QUV7-_C7WS78WytD9zE0aTt4JgqJTHcP-fU2exbmsN6SA@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 31 Jan 2024 15:55:43 -0800
X-Gmail-Original-Message-ID: <CAAfnVBnfkyCkY5Vsj7FaUWQxGq3YD4q_AE=BsYwnpLki75MxhQ@mail.gmail.com>
Message-ID: <CAAfnVBnfkyCkY5Vsj7FaUWQxGq3YD4q_AE=BsYwnpLki75MxhQ@mail.gmail.com>
Subject: Re: Call for GSoC/Outreachy internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a9ab210610469e8d"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000a9ab210610469e8d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 4:51=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:

> On Tue, 23 Jan 2024 at 22:47, Gurchetan Singh
> <gurchetansingh@chromium.org> wrote:
> > Title:
> > - Improve display integration for upstream virtualized graphics
> >
> > Summary:
> > - The Rutabaga Virtual Graphics interface's UI integration upstream is
> very simple, but in deployment it will be complex.  This project aims to
> bridge the gap between downstream consumers and upstream QEMU.
> >
> > Looking for someone interested in Rust + system level graphics to help
> realize the next steps.
>
> Hi Gurchetan,
> It's unclear what this project idea entails.
>
> Based on your email my guess is you're looking for someone to help
> upstream code into QEMU, but I'm not sure. Last year there was a
> project to upstream bsd-user emulation code into QEMU and I think that
> type of project can work well.
>
> Or maybe you're looking for someone to write a QEMU UI code that uses
> rutabaga_gfx.
>
> Can you describe the next steps in more detail?
>
> The project description should contain enough information for someone
> who knows how to program but has no domain knowledge in Rutabaga,
> virtio-gpu, or QEMU.
>
> > Note: developers should be willing to sign Google CLA, here:
> >
> > https://cla.developers.google.com/about/google-individual
> >
> > But everything will be FOSS.
>
> Which codebase will this project touch? If a CLA is required then it
> sounds like it's not qemu.git?
>

Good points, I think we need to think about this a bit more ....  I hereby
withdraw the idea!


>
> > Links
> > - https://crosvm.dev/book/appendix/rutabaga_gfx.html
> > -
> https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org=
/
> >
> > Skills
> >  - Level: Advanced
> >  - Rust, Vulkan, virtualization, cross-platform graphics
>

--000000000000a9ab210610469e8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 24, 2024 at 4:51=E2=80=AF=
AM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com" target=3D"_bla=
nk">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Tue, 23 Jan 2024 at 22:47, Gurchetan Singh<br>
&lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gurche=
tansingh@chromium.org</a>&gt; wrote:<br>
&gt; Title:<br>
&gt; - Improve display integration for upstream virtualized graphics<br>
&gt;<br>
&gt; Summary:<br>
&gt; - The Rutabaga Virtual Graphics interface&#39;s UI integration upstrea=
m is very simple, but in deployment it will be complex.=C2=A0 This project =
aims to bridge the gap between downstream consumers and upstream QEMU.<br>
&gt;<br>
&gt; Looking for someone interested in Rust + system level graphics to help=
 realize the next steps.<br>
<br>
Hi Gurchetan,<br>
It&#39;s unclear what this project idea entails.<br>
<br>
Based on your email my guess is you&#39;re looking for someone to help<br>
upstream code into QEMU, but I&#39;m not sure. Last year there was a<br>
project to upstream bsd-user emulation code into QEMU and I think that<br>
type of project can work well.<br>
<br>
Or maybe you&#39;re looking for someone to write a QEMU UI code that uses<b=
r>
rutabaga_gfx.<br>
<br>
Can you describe the next steps in more detail?<br>
<br>
The project description should contain enough information for someone<br>
who knows how to program but has no domain knowledge in Rutabaga,<br>
virtio-gpu, or QEMU.<br>
<br>
&gt; Note: developers should be willing to sign Google CLA, here:<br>
&gt;<br>
&gt; <a href=3D"https://cla.developers.google.com/about/google-individual" =
rel=3D"noreferrer" target=3D"_blank">https://cla.developers.google.com/abou=
t/google-individual</a><br>
&gt;<br>
&gt; But everything will be FOSS.<br>
<br>
Which codebase will this project touch? If a CLA is required then it<br>
sounds like it&#39;s not qemu.git?<br></blockquote><div><br></div><div>Good=
 points, I think we need to think about this a bit more ....=C2=A0 I hereby=
 withdraw the idea!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
&gt; Links<br>
&gt; - <a href=3D"https://crosvm.dev/book/appendix/rutabaga_gfx.html" rel=
=3D"noreferrer" target=3D"_blank">https://crosvm.dev/book/appendix/rutabaga=
_gfx.html</a><br>
&gt; - <a href=3D"https://patchew.org/QEMU/20230421011223.718-1-gurchetansi=
ngh@chromium.org/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org=
/QEMU/20230421011223.718-1-gurchetansingh@chromium.org/</a><br>
&gt;<br>
&gt; Skills<br>
&gt;=C2=A0 - Level: Advanced<br>
&gt;=C2=A0 - Rust, Vulkan, virtualization, cross-platform graphics<br>
</blockquote></div></div>

--000000000000a9ab210610469e8d--

