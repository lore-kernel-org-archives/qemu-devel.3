Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E353D1CA05
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85dF-0003dO-Ut; Mon, 04 Nov 2024 17:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jwkozaczuk@gmail.com>)
 id 1t85dE-0003d3-DB; Mon, 04 Nov 2024 17:33:08 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jwkozaczuk@gmail.com>)
 id 1t85dC-00053Z-U0; Mon, 04 Nov 2024 17:33:08 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539e4908837so666470e87.0; 
 Mon, 04 Nov 2024 14:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730759583; x=1731364383; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZUSHr7evpQ/YtIN+NFNUOQ1Uw801Nu8ZWwJhTR7+DA=;
 b=J74tEDhcDOv3/zC92ooeVhlc61gXle/niO42Ey2EPzWfja4F0CzjZ48M3P27HLidTI
 R3YWUzCWn0ACIKKWyU16Opqw3Q9iF8PpHnmcQ3iejM/MnayvbMaaA+K5iQbEGXU3mOZF
 PfU6fCQhcUsLiGuuuO1u0BIKRAb0/bpiUEseIk1VncRMY76osaJ0LwWEbryxUdoX6JCD
 TrMpSqSyHHdnwaL1X+Met8h79scpOL95v4ml4DPIyz4s0kAfX9tRonI32a3cfox3z4UL
 apojVrcTzQc4Ub/0rskQA4CbxzKROu+4v9bAmXpSVVFEBTF6Zs77DU2pR4IbfPyI5iVg
 Z8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730759583; x=1731364383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ZUSHr7evpQ/YtIN+NFNUOQ1Uw801Nu8ZWwJhTR7+DA=;
 b=cMSJ5rIdXJS0vxKQelfRq0gwA6h4x4habZT1/eu5tnaZdo0bOa9VWfnt5QDYCBP4Sg
 +BxkOPIKwE20ILacb2kG6GtmBm+Z0l8Iof4uBf4mfmZxLnW/yI5YHMC+gEYEYHOrRjlo
 OVwQAOIHdLZu2YHkdydBGTo39/DcUZu/S6SsNSyNAfYEdUbgF++DkDkdnZTszHpmyVic
 KkT4V9YqrSrgVzKzkIC6AJ8DE8cBNl+zYPYy2BTJczYfH+svxoTjsWES4b48FYdZT274
 dCOhTBk//Db9gZiHQzMSeAWK3Yub2t1Kv1DUEHOcfZWOIV5h4kJ8io0sUr0X0+1MAFez
 RNFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAtFp7aUK8c+ovTr6sCwXtdmGod3k2+JK52nMuil2clval8Q8TZW7JODTgW07kWuiWgsT5otjtJj683TU=@nongnu.org,
 AJvYcCVl9Xc5KDRo3MMHm63S44CeNr7ATItLp5t60Fjg69844KbnLq7pMe+oUSWv9wBXZtisALA0ohF5Dry8FA==@nongnu.org,
 AJvYcCXP3Za8yCkNLkDABvtpk7/+udp4+JMfIf/FkDNZzxNmavq2G0Mx69YOO1vghnvjAnvMrQNh+lXaAr9D@nongnu.org
X-Gm-Message-State: AOJu0YyIn/l6ocLQ7GAiIoCNwZ34IVNy9r6n0TBRquqewgIm4MMw2MIZ
 QjF2/FdqOQEGz49uORcrQlM9HwYMOUCzoDblODnPm8LuulujKQihEEKUpHBrErcrvWtKldgisYD
 /dJMwg4cEakz2SxDJtew2rq6SlWLveA==
X-Google-Smtp-Source: AGHT+IFo3Uh8lfIJ2sMn+Ef/JpQfVSKET0eSQKxNa5X7SffEu9scnNhrwBDMilqAzyIM4d/kLSyhCAkCCiJylhgwBzI=
X-Received: by 2002:a05:6512:651c:b0:53c:75eb:526a with SMTP id
 2adb3069b0e04-53c75eb555emr2164534e87.9.1730759583199; Mon, 04 Nov 2024
 14:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20241029-issue-2388-v2-1-e335658104cf@samsung.com>
 <ZykZHvL_PtMMttqX@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZykZHvL_PtMMttqX@kbusch-mbp.dhcp.thefacebook.com>
From: Waldek Kozaczuk <jwkozaczuk@gmail.com>
Date: Mon, 4 Nov 2024 17:32:51 -0500
Message-ID: <CAL9cFfMgQQ3ETjGWzW7_K+MNOKUa4rsf8s3X49vmm4862n5VHg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/nvme: fix handling of over-committed queues
To: Keith Busch <kbusch@kernel.org>
Cc: Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000025fac506261dde4d"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=jwkozaczuk@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000025fac506261dde4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have run my tests on the OSv side with small queue sizes like 3,4,5 and I
could NOT replicate the issue. So it looks like the V2 version of this
patch fixes the problem.

Thanks a lot,
Waldemar Kozaczuk

On Mon, Nov 4, 2024 at 1:57=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:

> On Tue, Oct 29, 2024 at 01:15:19PM +0100, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >
> > If a host chooses to use the SQHD "hint" in the CQE to know if there is
> > room in the submission queue for additional commands, it may result in =
a
> > situation where there are not enough internal resources (struct
> > NvmeRequest) available to process the command. For a lack of a better
> > term, the host may "over-commit" the device (i.e., it may have more
> > inflight commands than the queue size).
> >
> > ...
>
> LGTM
>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
>

--00000000000025fac506261dde4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have run my tests on the OSv side with small queue sizes=
=C2=A0like 3,4,5 and I could NOT replicate the issue. So it looks like the =
V2 version=C2=A0of this patch fixes the=C2=A0problem.<div><br></div><div>Th=
anks a lot,</div><div>Waldemar Kozaczuk</div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 4, 2024 at 1:57=E2=
=80=AFPM Keith Busch &lt;<a href=3D"mailto:kbusch@kernel.org">kbusch@kernel=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Tue, Oct 29, 2024 at 01:15:19PM +0100, Klaus Jensen wrote:<br>
&gt; From: Klaus Jensen &lt;<a href=3D"mailto:k.jensen@samsung.com" target=
=3D"_blank">k.jensen@samsung.com</a>&gt;<br>
&gt; <br>
&gt; If a host chooses to use the SQHD &quot;hint&quot; in the CQE to know =
if there is<br>
&gt; room in the submission queue for additional commands, it may result in=
 a<br>
&gt; situation where there are not enough internal resources (struct<br>
&gt; NvmeRequest) available to process the command. For a lack of a better<=
br>
&gt; term, the host may &quot;over-commit&quot; the device (i.e., it may ha=
ve more<br>
&gt; inflight commands than the queue size).<br>
&gt;<br>
&gt; ...<br>
<br>
LGTM<br>
<br>
Reviewed-by: Keith Busch &lt;<a href=3D"mailto:kbusch@kernel.org" target=3D=
"_blank">kbusch@kernel.org</a>&gt;<br>
</blockquote></div>

--00000000000025fac506261dde4d--

