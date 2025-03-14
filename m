Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB3EC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 08:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt0JG-0004OA-Hx; Fri, 14 Mar 2025 04:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tt0JD-0004NA-02
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tt0J7-0004cF-3S
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741940532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KNvYOj1PWqvUV3V988qdpwuRzmZDGWqTQ9n5X1SHleM=;
 b=GYxTBShmjrPJlOqQBWPd+jzqMLiuJscSz0FdMhCXTdLn/T1ggnbrTK9ptvL8shn7jMCJuN
 4u/FX1bqXIXtupz35w4l3R9m3kZj+1FQxpHdpWnZzdhjpT97069nddz3ND1RkZF9KrF09T
 d/jh6nQXqGw4Nkz6i1J7RgtgylideiY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-nDi6zn3gOdyXmWVm21hiLg-1; Fri, 14 Mar 2025 04:22:10 -0400
X-MC-Unique: nDi6zn3gOdyXmWVm21hiLg-1
X-Mimecast-MFC-AGG-ID: nDi6zn3gOdyXmWVm21hiLg_1741940530
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e8f9450b19so41064576d6.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 01:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741940529; x=1742545329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KNvYOj1PWqvUV3V988qdpwuRzmZDGWqTQ9n5X1SHleM=;
 b=KgvNS1vw6aelmUL6Or1VaoJ0hDKUGIVnc8Leh97ccoJ+3MukgGjBDbkoSzTnXzVrOY
 loblifegjDPQpNpjkBVRX+XOgLClReC7gfR5US7Hp/li+USWRFTs0tazT8xEL5MsGh1R
 e5tlqcXxUDWaD+Tw9wAnbI3uK8binlnnbkZTu5qLEbYFjQ/Gg9u6+PjV+UkPzGZZT2H7
 3H+hrZVciKvzHMc3IfqoNiEey35Mk2KRnkski8ZhIlLrOn3PVYEEvJlVcNY6Vq8EdhgW
 JFNE/5JeGqWo0zbvyYuksHdnS9dwo/GYLW83PmnuGvauehMe2WupWqsBz2EwIj2iyU0u
 otdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUvrT0CMFdaHaFtObBBtVYyj+jNfdCKKrWQwaB94JRZyhhsraHMYwJGWd5PXDpKq2HMuPJBO7MaUN/@nongnu.org
X-Gm-Message-State: AOJu0YxZuJkSPkdmzSpfMTDyDePkm5qqLegllSH1TjR03R5ZU7IjrZ2G
 Cjct4xY3ecFBqF6RwyiFxvR2/ApEDY2i9fHuWlxOAETC5EnTkAHRGGhhV4gbuwMntMeDyfrH5LY
 t2eE97XTr/Tv9/jCodkcCxOfyGh/q839K8gUlqrTNi9S2+cbMskWIoZHCdSVWi5Z4Q9fhnA1tbM
 yhERrqd6PNoXEs51WCjBEEddczkRI=
X-Gm-Gg: ASbGncvIVXOqx1gegJe0MMhj9JNj81Ocd7tSKRlrgyFf1Kcau+CVt2N4b86gARdomRT
 9dZ72TC0NKUsROFHpE1uDgHQkAbiEJl3u8XAwqs5BqZhcgOB4Ptclhf7RAEVDaj2qr7ZzH47hkr
 8=
X-Received: by 2002:a05:6214:21a1:b0:6e4:2198:12fe with SMTP id
 6a1803df08f44-6eaead02442mr20229936d6.18.1741940529707; 
 Fri, 14 Mar 2025 01:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH36qbtxADPXZYTomY0J2AqZVEOQz77fllZpZHka5L9kvqlKFSQO6PGgxrjiOKRHq9ypxG4vRw6BDQ5yB6ua1o=
X-Received: by 2002:a05:6214:21a1:b0:6e4:2198:12fe with SMTP id
 6a1803df08f44-6eaead02442mr20229806d6.18.1741940529337; Fri, 14 Mar 2025
 01:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMcbCquaBmWhx3jWBKMC1oLrMZBUVhfWFcW=_5uhVqOep4NWw@mail.gmail.com>
 <Z9GUldol1IQT1uiY@redhat.com> <Z9GY3l2pTkbpMV8L@redhat.com>
 <871pv25iar.fsf@draig.linaro.org>
In-Reply-To: <871pv25iar.fsf@draig.linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 14 Mar 2025 10:21:58 +0200
X-Gm-Features: AQ5f1JrjewlmaVwmYsRUY4PnZnlM0mV_aLxH5__h5M4_eAYAJi3q0MdcdMopp-g
Message-ID: <CAPMcbCrsvWJu6NsE8P6OYCLtKYG89zSviCoW9_YF+BTUB45HeQ@mail.gmail.com>
Subject: Re: Cross-compilation artifact is broken
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000078b04a06304922f9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--00000000000078b04a06304922f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 6:24=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Wed, Mar 12, 2025 at 02:05:09PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> >> On Wed, Mar 12, 2025 at 03:52:45PM +0200, Konstantin Kostiuk wrote:
> >> > Hi All,
> >> >
> >> > I cross-compiled qemu-ga from current master branch
> >> > (825b96dbcee23d134b691fc75618b59c5f53da32) and found strange behavio=
r.
> >> >
> >> > Configure CLI:
> >> > ./configure --disable-docs --disable-system --disable-user
> >> > --cross-prefix=3Dx86_64-w64-mingw32- --enable-guest-agent
> >> > --disable-guest-agent-msi --disable-qga-vss
> >> > Build CLI:
> >> > make -j8 qemu-ga
> >> >
> >> > Linker wrote the following information but exited with 0 code:
> >> >
> >> >
> /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin=
/ld:
> >> > qga/qemu-ga.exe:/4: section below image base
> >> >
> /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin=
/ld:
> >> > qga/qemu-ga.exe:/24: section below image base
> >> >
> >> > As a result, this binary failed to start on Windows without any
> details,
> >> > just a message that the application is not compatible. I also tried
> to run
> >> > it with wine and got the error:
> >> >
> >> > wine: failed to start
> >> > L"Z:\\home\\user\\Documents\\repos\\qemu\\build\\qga\\qemu-ga.exe"
> >> > Application could not be started, or no application associated with
> the
> >> > specified file.
> >> > ShellExecuteEx failed: Bad EXE format for
> >> > Z:\home\user\Documents\repos\qemu\build\qga\qemu-ga.exe.
> >> >
> >> > I bisected the tree and found the commit that caused the problem:
> >> >
> https://gitlab.com/qemu-project/qemu/-/commit/563b1a35ed1f1151505d4fe5f72=
3827d1b3fd4bc
> >> >
> >> > Adding --disable-split-debug to the configure CLI fixes the issue.
> >> >
> >> > $ x86_64-w64-mingw32-gcc --version
> >> > x86_64-w64-mingw32-gcc (GCC) 14.2.0
> >> >
> >> > My question is, is this expected behavior or is this a bug?
> >>
> >> Your configure args don't include "--enable-debug", so I would
> >> not have expected -gsplit-dwarf to have been enabled, so I'm
> >> surprised that commit casued a problem.
> >
> > Hmm it appears that the meson  "get_option('debug')" is entirely
> > unconnected to QEMU's --enable-debug configure flag, which I did
> > not realize.
> >
> > IOW, we've got -gsplit-dwarf enabled by default for everyone
> > building QEMU, which feels dubious. IMHO only an explicit
> > --enable-debug configure arg should have triggered it.
>
> --enable-debug is more than debug info, --enable-debug-info is enabled
> by default. If you build with --disable-debug-info then -gsplit-dwarf
> won't be applied.
>
>
But as this broke the Windows build, maybe we should disable this for
Windows
until resolve this problem


> >
> > In addition since its breaking Windows builds, it appears we
> > need to block its usage on Windows.
> >
> >
> > With regards,
> > Daniel
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--00000000000078b04a06304922f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><br></div><b=
r><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Mar 12, 2025 at 6:24=E2=80=AFPM Alex Benn=C3=A9e &l=
t;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Daniel P.=
 Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank"=
>berrange@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Wed, Mar 12, 2025 at 02:05:09PM +0000, Daniel P. Berrang=C3=A9 wrot=
e:<br>
&gt;&gt; On Wed, Mar 12, 2025 at 03:52:45PM +0200, Konstantin Kostiuk wrote=
:<br>
&gt;&gt; &gt; Hi All,<br>
&gt;&gt; &gt; <br>
&gt;&gt; &gt; I cross-compiled qemu-ga from current master branch<br>
&gt;&gt; &gt; (825b96dbcee23d134b691fc75618b59c5f53da32) and found strange =
behavior.<br>
&gt;&gt; &gt; <br>
&gt;&gt; &gt; Configure CLI:<br>
&gt;&gt; &gt; ./configure --disable-docs --disable-system --disable-user<br=
>
&gt;&gt; &gt; --cross-prefix=3Dx86_64-w64-mingw32- --enable-guest-agent<br>
&gt;&gt; &gt; --disable-guest-agent-msi --disable-qga-vss<br>
&gt;&gt; &gt; Build CLI:<br>
&gt;&gt; &gt; make -j8 qemu-ga<br>
&gt;&gt; &gt; <br>
&gt;&gt; &gt; Linker wrote the following information but exited with 0 code=
:<br>
&gt;&gt; &gt; <br>
&gt;&gt; &gt; /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64=
-mingw32/bin/ld:<br>
&gt;&gt; &gt; qga/qemu-ga.exe:/4: section below image base<br>
&gt;&gt; &gt; /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64=
-mingw32/bin/ld:<br>
&gt;&gt; &gt; qga/qemu-ga.exe:/24: section below image base<br>
&gt;&gt; &gt; <br>
&gt;&gt; &gt; As a result, this binary failed to start on Windows without a=
ny details,<br>
&gt;&gt; &gt; just a message that the application is not compatible. I also=
 tried to run<br>
&gt;&gt; &gt; it with wine and got the error:<br>
&gt;&gt; &gt; <br>
&gt;&gt; &gt; wine: failed to start<br>
&gt;&gt; &gt; L&quot;Z:\\home\\user\\Documents\\repos\\qemu\\build\\qga\\qe=
mu-ga.exe&quot;<br>
&gt;&gt; &gt; Application could not be started, or no application associate=
d with the<br>
&gt;&gt; &gt; specified file.<br>
&gt;&gt; &gt; ShellExecuteEx failed: Bad EXE format for<br>
&gt;&gt; &gt; Z:\home\user\Documents\repos\qemu\build\qga\qemu-ga.exe.<br>
&gt;&gt; &gt; <br>
&gt;&gt; &gt; I bisected the tree and found the commit that caused the prob=
lem:<br>
&gt;&gt; &gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/commit/563b=
1a35ed1f1151505d4fe5f723827d1b3fd4bc" rel=3D"noreferrer" target=3D"_blank">=
https://gitlab.com/qemu-project/qemu/-/commit/563b1a35ed1f1151505d4fe5f7238=
27d1b3fd4bc</a><br>
&gt;&gt; &gt; <br>
&gt;&gt; &gt; Adding --disable-split-debug to the configure CLI fixes the i=
ssue.<br>
&gt;&gt; &gt; <br>
&gt;&gt; &gt; $ x86_64-w64-mingw32-gcc --version<br>
&gt;&gt; &gt; x86_64-w64-mingw32-gcc (GCC) 14.2.0<br>
&gt;&gt; &gt; <br>
&gt;&gt; &gt; My question is, is this expected behavior or is this a bug?<b=
r>
&gt;&gt; <br>
&gt;&gt; Your configure args don&#39;t include &quot;--enable-debug&quot;, =
so I would<br>
&gt;&gt; not have expected -gsplit-dwarf to have been enabled, so I&#39;m<b=
r>
&gt;&gt; surprised that commit casued a problem.<br>
&gt;<br>
&gt; Hmm it appears that the meson=C2=A0 &quot;get_option(&#39;debug&#39;)&=
quot; is entirely<br>
&gt; unconnected to QEMU&#39;s --enable-debug configure flag, which I did<b=
r>
&gt; not realize.<br>
&gt;<br>
&gt; IOW, we&#39;ve got -gsplit-dwarf enabled by default for everyone<br>
&gt; building QEMU, which feels dubious. IMHO only an explicit<br>
&gt; --enable-debug configure arg should have triggered it.<br>
<br>
--enable-debug is more than debug info, --enable-debug-info is enabled<br>
by default. If you build with --disable-debug-info then -gsplit-dwarf<br>
won&#39;t be applied.<br>
<br></blockquote><div><br></div><div>But as this broke the Windows build, m=
aybe we should disable this for Windows</div><div>until resolve this proble=
m<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
&gt;<br>
&gt; In addition since its breaking Windows builds, it appears we<br>
&gt; need to block its usage on Windows.<br>
&gt;<br>
&gt;<br>
&gt; With regards,<br>
&gt; Daniel<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div>

--00000000000078b04a06304922f9--


