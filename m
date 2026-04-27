Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E17FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHy8-0004jl-Uq; Mon, 27 Apr 2026 05:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadhyar.cs24@rvce.edu.in>)
 id 1wHHy7-0004jV-Du
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:09:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadhyar.cs24@rvce.edu.in>)
 id 1wHHy4-0000My-O7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:09:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso717337f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777280966; cv=none;
 d=google.com; s=arc-20240605;
 b=SymAxNYCQnUGfm7QVxDSgHezMoJ+C+scUhRmzmcBxz82zORk265kS8C8GNaXkpvP2C
 4yYoZJnzIuXS9n6J4OYpsne++PHTMLUfRNbNaUc0pr9Q8TEU9fXFTdVh2hbjDuoNNQIN
 i8lUzOeCcKgCuSX03JAQOQK1xy7+qT7U5GQknjCR8tYAUyZ+GfBCH9utn6xHZ3TPfHfR
 Uw6Jf+9JfKCrohBRbhKag1094e37NKPSQPvXJhveuJzKx3s+vogecGB862NFntnX3/PS
 ObRwMk81mgv9H+rrbwvq/e5UuQnfKoy22G5/NgKkGDjQg+a9iHXF+fQMvZhDv9k/uoPF
 gLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gdFdAwGwuIwcz4kdCkPStN3vxPR6Y+5b+BbfLPB0Xyo=;
 fh=AN66mnzcK1FzYLfUmTrgfbB/VA1aqrL9p4wXLzc1brU=;
 b=jhaPuoUrnqj3R78F+uP7vc/yC8N0JbMDgvOd3fVWdfgnB7r/+HOROSfNcTAkfp+PRr
 76cbMICD+pgongOyzvKhallrfYLV4T+9wNR+8PpUluBJp5LMZp+7QLiQblf9e20yFmqX
 0TlSytIcZO3h+lRcA4RWN7DeJPtwfV9X0oFYe20+JAePcz3vlI5vtBHrr+NEF2ntmoOQ
 t35veIH763A0dd7Vr86gwipiKIKZACR89Co5+lJYNU1szsI8nOEMRFMpH1/H/LmMqPLj
 ZCtN7vki6GpT6+HFCF2/Z+9YuGSXvdWP5B3hIn7DuE7Em7XySUBlBQAQcfRrLwdTvsFq
 dEKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rvce-edu-in.20251104.gappssmtp.com; s=20251104; t=1777280966; x=1777885766;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gdFdAwGwuIwcz4kdCkPStN3vxPR6Y+5b+BbfLPB0Xyo=;
 b=ed38zqfui6stF0WZx18mcXkLIGvlORUME+ySeRBq6xZjTnblp5bfeKnilivqNNNzwv
 g81RByOJOon1QTq3BJuu/ktDrz+ftPZ6WMBh1ui6FVl9SNzv0Cii7me/wiCzvmcIwgWK
 KzJagODaVMpkG3qIVpKUoYnh55pnJY/zm5rMJyQhfb9+b158ivT2YrdND3a28elyvghf
 uPHF5AYVFPe0hnHKS0x7A8x0zfTIVwUnmzeLeLPvlP5MBvQC3dZ1tjgSNbHaawWjM6Uv
 cm/+ScPQ0dNv5PQJjJ4zJrkdIFxiGbN4UKcCuJZor9Zjd1qVAKNp4zFHiPW1e9W35kNJ
 mZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280966; x=1777885766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdFdAwGwuIwcz4kdCkPStN3vxPR6Y+5b+BbfLPB0Xyo=;
 b=VVS8fjfxnrWMdYlBNaioZl9TAg659u/se98WmU5CniFF2O60H/3hD0XAsvEdZrqltX
 D5UM95Lga1yNQjnvHsgrd+iGG0jK66U4l2WdD2i//YDE6/zfoL+jmVzaG/6lH6PDXd9u
 a+J8daIWRRT9/5XWdaj6G9u+seH5xhHi5zj7rXPHLRJiNfokFn5Jy+jYYKWpe97ykZww
 lZ1cMuZAUFvYjLtOmMZN8sfsmYZjBKRrr5s5i5ZBcxY4UKZv8xr7L00F4tJuQwMlshsr
 eyzNOro6VnopaFDr+mdTGD1wFPomUdM9v7hE6VJ02sSjA3r5sdIxIczuDPH1HW+UEkAU
 z6rA==
X-Gm-Message-State: AOJu0Yxp++lmyprXgkjKh7AGEnEUa6PfuqoDvdEiJ7PJUyeqDBl/BHEf
 1I2dMqTg5+QwwwO2joUG2T7nrq13XIpZ6p1LfwiPVuLD0XM2/XQUwQXRFzhyP91yVzGVCHG/KLA
 3ITd/OQzBvUUIr3Fg8iA7i+UzVBOQh0PRUqs1rTNB6Q==
X-Gm-Gg: AeBDietzYxyzQ4b2b2XGtTtuCpAFzHklqtYWBVdV1ZurbXGlY/XiRr/iR9YUEPgvNgm
 sWHoLRGmYfqyyw8nGIlToOms1zwyuYVXbNC7dgY1zP24VG7giSQdGXYOGcp22xTJfxdYcWmqMOP
 yfkfvly8C9u/28vyR2/OCllo3eJVw3Hbdp4FtmAJ1Km03wUNE+xsQS3p124Pf7Wr5ZKar/rZDpT
 TkAoM2JIYPZaG5k1/d1m7kqWZP3zxhDh3AuvPWDYAOoFH+3atQvsyv8rdVNGSNPZgFiI6Uz9Njq
 MhmVPG3J8p+HajkcWlrItmS9WJ3k2DQoigbAnnykVjyS1HeXvWWF6P4lZA87LyzLtwUIMMs2w2N
 wN5rhsXSe7JKYxnS3wINj7PKUN314oB4LRT0=
X-Received: by 2002:a05:6000:22ca:b0:43d:50c:6f33 with SMTP id
 ffacd0b85a97d-43fe3e0bde7mr65038454f8f.26.1777280964495; Mon, 27 Apr 2026
 02:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHMzB=iZB24QqPwcMjJrfp4GjCkKKpa_0aG0Qx=YOFGUxab8Lg@mail.gmail.com>
 <a7e8ab0f-dddf-407a-ab1c-8f465734d238@redhat.com>
In-Reply-To: <a7e8ab0f-dddf-407a-ab1c-8f465734d238@redhat.com>
From: AADHYA R <aadhyar.cs24@rvce.edu.in>
Date: Mon, 27 Apr 2026 14:39:13 +0530
X-Gm-Features: AVHnY4I3b6oqhOaBdWw14SNexZkVwGztDPdnGgBqzAHKNE1KIdosoxnvwqdBWCA
Message-ID: <CABHAK8Mca9e2RExFmyNa+1W+sJvuGDiLEytjxANVcuiSHbvR+Q@mail.gmail.com>
Subject: Re: First-time contributor looking to work on malloc/calloc cleanups
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, 
 Peter Maydell <peter.maydell@linaro.org>,
 Lucas Cardoso <luc.fast2004@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000008e222806506d780d"
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=aadhyar.cs24@rvce.edu.in; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000008e222806506d780d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas and Lucas,
Thank you for CC'ing me!
Lucas, welcome to the QEMU community! I am currently busy with some project
commitments, so I will not be finishing the fmopl.c patch.
Please feel free to take it over. It is a great file to get comfortable
with the codebase. If you have any questions about the initial conversion
work I started there, I=E2=80=99d be happy to help.
Best of luck with your first contribution!
Best regards,
Aadhya R

On Mon, 27 Apr 2026, 12:47=E2=80=AFpm Thomas Huth, <thuth@redhat.com> wrote=
:

> On 16/04/2026 15.26, Lucas Cardoso wrote:
> > Hi everyone,
> >
> > I am looking to make my first contribution to QEMU and would like to
> start
> > by tackling the remaining cleanups for the GitLab issue: "conversions o=
f
> > malloc/calloc/free to g_malloc/g_new/g_free etc" (
> https://gitlab.com/qemu-
> > project/qemu/-/work_items/1798 <https://gitlab.com/qemu-project/qemu/-/
> > work_items/1798>).
> >
> > I've checked the codebase and saw that some files mentioned in the
> original
> > issue still have remaining malloc calls that need converting:
> > - hw/audio/fmopl.c
> > - target/xtensa/translate.c
> > - disas/m68k.c
> > - disas/sparc.c
> > Also, this file still has a calloc call that needs converting:
> > - hw/xtensa/mx_pic.c
> >
> > I checked the mailing list archive, and saw that someone else tried to
> > tackle this issue a month ago. They made some progress on
> hw/audio/fmopl.c,
> > but it seems as if they've stopped working on it.
> > I would like to start working on these one file at a time, starting wit=
h
> hw/
> > audio/fmopl.c for malloc conversions and hw/xtensa/mx_pic.c for calloc.
> >
> > Following the 'Contribute/BiteSizedTasks' wiki page, I decided to send
> this
> > email. Could you let me know if anyone is currently working on these
> > specific files, or if it's safe for me to proceed? If so, I'd appreciat=
e
> it
> > if someone could assign the corresponding GitLab issue to me.
> >
> > Thanks,
> > Lucas Cardoso
> > @lucasac00 on Gitlab
>
>   Hi Lucas,
>
> it might make sense to CC: the reporter of the issue (Peter) and the
> author
> of the previous fmopl patch to synchronize. Otherwise, mails like this
> easily get lost in the high volume of traffic on the qemu-devel mailing
> list. I've added them now so they can join the conversation.
>
> I'd suggest that you start with a patch that tackles the other files, in
> case Aadhya still want to finish the previous patch to fmopl.c.
> Seems like there is also already a patch available for sparc.c:
>
>
> https://lore.kernel.org/qemu-devel/69b6addd.170a0220.2bbc48.65e4@mx.googl=
e.com/
>
> And for xtensa:
>
>
> https://lore.kernel.org/qemu-devel/20250730062142.1665980-1-frolov@swemel=
.ru/
>
> ... so maybe best if you start with a patch to m68k.c ?
>
>   HTH,
>    Thomas
>
>

--0000000000008e222806506d780d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Thomas and Lucas,<div dir=3D"auto">Thank you for CC&#3=
9;ing me!</div><div dir=3D"auto">Lucas, welcome to the QEMU community! I am=
 currently busy with some project commitments, so I will not be finishing t=
he fmopl.c patch.</div><div dir=3D"auto">Please feel free to take it over. =
It is a great file to get comfortable with the codebase. If you have any qu=
estions about the initial conversion work I started there, I=E2=80=99d be h=
appy to help.</div><div dir=3D"auto">Best of luck with your first contribut=
ion!</div><div dir=3D"auto">Best regards,</div><div dir=3D"auto">Aadhya R=
=C2=A0</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, 27 Apr 2026, 12:47=E2=80=AFpm Tho=
mas Huth, &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">On 16/04/2026 15.26, Lucas C=
ardoso wrote:<br>
&gt; Hi everyone,<br>
&gt; <br>
&gt; I am looking to make my first contribution to QEMU and would like to s=
tart <br>
&gt; by tackling the remaining cleanups for the GitLab issue: &quot;convers=
ions of <br>
&gt; malloc/calloc/free to g_malloc/g_new/g_free etc&quot; (<a href=3D"http=
s://gitlab.com/qemu-" rel=3D"noreferrer noreferrer" target=3D"_blank">https=
://gitlab.com/qemu-</a> <br>
&gt; project/qemu/-/work_items/1798 &lt;<a href=3D"https://gitlab.com/qemu-=
project/qemu/-/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gi=
tlab.com/qemu-project/qemu/-/</a> <br>
&gt; work_items/1798&gt;).<br>
&gt; <br>
&gt; I&#39;ve checked the codebase and saw that some files mentioned in the=
 original <br>
&gt; issue still have remaining malloc calls that need converting:<br>
&gt; - hw/audio/fmopl.c<br>
&gt; - target/xtensa/translate.c<br>
&gt; - disas/m68k.c<br>
&gt; - disas/sparc.c<br>
&gt; Also, this file still has a calloc call that needs converting:<br>
&gt; - hw/xtensa/mx_pic.c<br>
&gt; <br>
&gt; I checked the mailing list archive, and saw that someone else tried to=
 <br>
&gt; tackle this issue a month ago. They made some progress on hw/audio/fmo=
pl.c, <br>
&gt; but it seems as if they&#39;ve stopped working on it.<br>
&gt; I would like to start working on these one file at a time, starting wi=
th hw/ <br>
&gt; audio/fmopl.c for malloc conversions and hw/xtensa/mx_pic.c for calloc=
.<br>
&gt; <br>
&gt; Following the &#39;Contribute/BiteSizedTasks&#39; wiki page, I decided=
 to send this <br>
&gt; email. Could you let me know if anyone is currently working on these <=
br>
&gt; specific files, or if it&#39;s safe for me to proceed? If so, I&#39;d =
appreciate it <br>
&gt; if someone could assign the corresponding GitLab issue to me.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Lucas Cardoso<br>
&gt; @lucasac00 on Gitlab<br>
<br>
=C2=A0 Hi Lucas,<br>
<br>
it might make sense to CC: the reporter of the issue (Peter) and the author=
 <br>
of the previous fmopl patch to synchronize. Otherwise, mails like this <br>
easily get lost in the high volume of traffic on the qemu-devel mailing <br=
>
list. I&#39;ve added them now so they can join the conversation.<br>
<br>
I&#39;d suggest that you start with a patch that tackles the other files, i=
n <br>
case Aadhya still want to finish the previous patch to fmopl.c.<br>
Seems like there is also already a patch available for sparc.c:<br>
<br>
<a href=3D"https://lore.kernel.org/qemu-devel/69b6addd.170a0220.2bbc48.65e4=
@mx.google.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lo=
re.kernel.org/qemu-devel/69b6addd.170a0220.2bbc48.65e4@mx.google.com/</a><b=
r>
<br>
And for xtensa:<br>
<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20250730062142.1665980-1-frol=
ov@swemel.ru/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore=
.kernel.org/qemu-devel/20250730062142.1665980-1-frolov@swemel.ru/</a><br>
<br>
... so maybe best if you start with a patch to m68k.c ?<br>
<br>
=C2=A0 HTH,<br>
=C2=A0 =C2=A0Thomas<br>
<br>
</blockquote></div>

--0000000000008e222806506d780d--

