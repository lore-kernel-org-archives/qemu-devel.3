Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582CAC47258
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 00:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVKgI-0000jD-Ed; Wed, 31 Jan 2024 19:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rVKgD-0000gi-0a
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 19:11:45 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rVKgA-0004u6-2a
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 19:11:44 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6ddca59e336so163699a34.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 16:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706746299; x=1707351099; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nCnMFfYJKrRzlkBw1oT+1Z288ehh6J8H8qOP3784EPs=;
 b=ImZ7nGDnEzKXQi5Edi0H6cN8HdhU2tJp+xjZBofN+4yb4NB7O/iYTiZYm187d63q7d
 4IiRzh7/3hSWl+OClLVI0uK1HoAy2UAuKXsGtoo6e88W1mjCaZCLwQ1W0pNJwJCGXA0e
 tuhwDBafMNT8AWGd9KSZ+5xFWRDj9b4vGCrT+qkQO+hoBZUqjClSjO0T5i/WeNu/+WRX
 AxU6e7L7ATHveN/F0fDl4DZT3SQwHVIsfaLl8/gn06Z4YJyAVzxL9n5+c9L9yKg56tYd
 nn6gn/UCM8oigTqzb/Mdyydxd1Y8MyCCmg/29l5jIF+RE8L4JcwVTAN35k0xni6xSupf
 yP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706746299; x=1707351099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nCnMFfYJKrRzlkBw1oT+1Z288ehh6J8H8qOP3784EPs=;
 b=Hd2gKaBccQKCrsK9v5OJLR7GtLJIlxe/JvOuzH7dMYaYl9ZORKs1z8HB/jwmpJeoZn
 92jszElcd7ZfwbYfKKHHF5Bv7lcC9AeJjyKcdQ1dn6Tjhz4kOfm1SfTyzJBZK+HO7U4X
 dlzs+pJW+qDZ3KXZvpMsHmaZr5YYD930r49hKLRYtRxDEDrXQorhT+asBRmQM8qisepc
 EcDfFDptD8RJCzhFLJHP3rsS6MsIr1J03eEtf8+7A3doZKYGgGQEekp4Y7+ZrFXYEcQt
 BmEHlOBNuyHhRe1rY8CIVDg0zYj4IWC2KOaeKedOX6gE1aben2k8ndgHOCgfwWjAAPDg
 QnyQ==
X-Gm-Message-State: AOJu0YwQ0VQ9xzuC/4D/7ytC1hvY5nG7+FIbrYf2dSXrcgHW22wMOlsj
 HOAuoSjIV3ZTtApAL0I8RexaxjUs1jYiNzn8dlJfPxFJ4oK/PKTDMlyrfRtdNmMViXd5hss+iyA
 N+O5z73tRMSfx9o68wwhziKPnRJk=
X-Google-Smtp-Source: AGHT+IFVi93ap1scuRv7zYTOajudVkrxXu+FHyYZMRra6pSRkumqEAcqYNAmZ9RyH/087zoUl/Fhc+ItAkzDz+8BNNE=
X-Received: by 2002:a05:6830:100c:b0:6e1:3b9f:f156 with SMTP id
 a12-20020a056830100c00b006e13b9ff156mr1917809otp.17.1706746299472; Wed, 31
 Jan 2024 16:11:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
 <CAAfnVBn0+627rLGXeLdsvUge0_VegcbTVuQf8rQwtjuJ3hcJnA@mail.gmail.com>
 <CAJSP0QUV7-_C7WS78WytD9zE0aTt4JgqJTHcP-fU2exbmsN6SA@mail.gmail.com>
 <CAAfnVBnfkyCkY5Vsj7FaUWQxGq3YD4q_AE=BsYwnpLki75MxhQ@mail.gmail.com>
In-Reply-To: <CAAfnVBnfkyCkY5Vsj7FaUWQxGq3YD4q_AE=BsYwnpLki75MxhQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 31 Jan 2024 19:11:27 -0500
Message-ID: <CAJSP0QXMarmQ5GiR8944YJ0-1rPtae5yekhvt1xNXwCv6O60Lg@mail.gmail.com>
Subject: Re: Call for GSoC/Outreachy internship project ideas
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e6e1b6061046d6ed"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

--000000000000e6e1b6061046d6ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024, 18:55 Gurchetan Singh <gurchetansingh@chromium.org>
wrote:

>
>
> On Wed, Jan 24, 2024 at 4:51=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.c=
om>
> wrote:
>
>> On Tue, 23 Jan 2024 at 22:47, Gurchetan Singh
>> <gurchetansingh@chromium.org> wrote:
>> > Title:
>> > - Improve display integration for upstream virtualized graphics
>> >
>> > Summary:
>> > - The Rutabaga Virtual Graphics interface's UI integration upstream is
>> very simple, but in deployment it will be complex.  This project aims to
>> bridge the gap between downstream consumers and upstream QEMU.
>> >
>> > Looking for someone interested in Rust + system level graphics to help
>> realize the next steps.
>>
>> Hi Gurchetan,
>> It's unclear what this project idea entails.
>>
>> Based on your email my guess is you're looking for someone to help
>> upstream code into QEMU, but I'm not sure. Last year there was a
>> project to upstream bsd-user emulation code into QEMU and I think that
>> type of project can work well.
>>
>> Or maybe you're looking for someone to write a QEMU UI code that uses
>> rutabaga_gfx.
>>
>> Can you describe the next steps in more detail?
>>
>> The project description should contain enough information for someone
>> who knows how to program but has no domain knowledge in Rutabaga,
>> virtio-gpu, or QEMU.
>>
>> > Note: developers should be willing to sign Google CLA, here:
>> >
>> > https://cla.developers.google.com/about/google-individual
>> >
>> > But everything will be FOSS.
>>
>> Which codebase will this project touch? If a CLA is required then it
>> sounds like it's not qemu.git?
>>
>
> Good points, I think we need to think about this a bit more ....  I hereb=
y
> withdraw the idea!
>

The project doesn't necessarily need to be in qemu.git. Just something that
is related to QEMU. Past projects have included rust-vmm crates, libnbd,
libblkio, etc.

If the code is used in conjunction with a QEMU guest, then it is probably
in scope.

We can discuss further if you like.

Stefan


>
>>
>> > Links
>> > - https://crosvm.dev/book/appendix/rutabaga_gfx.html
>> > -
>> https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.or=
g/
>> >
>> > Skills
>> >  - Level: Advanced
>> >  - Rust, Vulkan, virtualization, cross-platform graphics
>>
>

--000000000000e6e1b6061046d6ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jan 31, 2024, 18:55 Gurchetan Singh &lt;<a hre=
f=3D"mailto:gurchetansingh@chromium.org">gurchetansingh@chromium.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Wed, Jan 24, 2024 at 4:51=E2=80=AFAM Stefan Hajnoczi &lt;<a=
 href=3D"mailto:stefanha@gmail.com" target=3D"_blank" rel=3D"noreferrer">st=
efanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Tue, 23 Jan 2024 at 22:47, Gurchetan Singh<br>
&lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank" rel=3D=
"noreferrer">gurchetansingh@chromium.org</a>&gt; wrote:<br>
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
rel=3D"noreferrer noreferrer" target=3D"_blank">https://cla.developers.goog=
le.com/about/google-individual</a><br>
&gt;<br>
&gt; But everything will be FOSS.<br>
<br>
Which codebase will this project touch? If a CLA is required then it<br>
sounds like it&#39;s not qemu.git?<br></blockquote><div><br></div><div>Good=
 points, I think we need to think about this a bit more ....=C2=A0 I hereby=
 withdraw the idea!</div></div></div></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">The project doesn&#39;t necessarily need t=
o be in qemu.git. Just something that is related to QEMU. Past projects hav=
e included rust-vmm crates, libnbd, libblkio, etc.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">If the code is used in conjunction with a QEMU g=
uest, then it is probably in scope.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">We can discuss further if you like.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Stefan</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
&gt; Links<br>
&gt; - <a href=3D"https://crosvm.dev/book/appendix/rutabaga_gfx.html" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://crosvm.dev/book/append=
ix/rutabaga_gfx.html</a><br>
&gt; - <a href=3D"https://patchew.org/QEMU/20230421011223.718-1-gurchetansi=
ngh@chromium.org/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org/</a><br>
&gt;<br>
&gt; Skills<br>
&gt;=C2=A0 - Level: Advanced<br>
&gt;=C2=A0 - Rust, Vulkan, virtualization, cross-platform graphics<br>
</blockquote></div></div>
</blockquote></div></div></div>

--000000000000e6e1b6061046d6ed--

