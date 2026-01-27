Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AA9D2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 19:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoPu-0004AJ-MI; Tue, 27 Jan 2026 14:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vkoPm-000488-0l
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:07:50 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vkoPk-0003jl-EP
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:07:49 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c56188aef06so2483599a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 11:07:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769540865; cv=none;
 d=google.com; s=arc-20240605;
 b=V+wjHdHVFo0bSJIzDeFP71QiiTI6OsmW0rwXpGfH0tLcpS6+DhY2OdCtgThAgV5Fof
 t8bJ82xk70OzEnfLju1jwcGNK2cK123caYL1jdK8z7Fymjw4JU55i/SsIg4rogfd/kAh
 qBf2TIvwRdySldUojSjs6z/dcrOkFhXoHiuzdVicWqOSl9/YLmALnNV/P6mXhibe53mH
 mK/FvZDb0o4RhfhLfGDPV1zsaQztHsOADFQqRKGkhdpGv8B5xiUvB27sBhMoPN49/bMW
 bxFMWJ3deYck9rSzBUJJouhODRLZhZyNqOv3rK5THFynPb3DgFN7NVHojtNAJ6WnUnUr
 wUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jRfcolwHbLqmzvd5zM6o+T5vfO89x1uMY/hPkgo++f4=;
 fh=HMorgUNBgejytIvOYdxrAsrIoD5WoaQ4S7Oaqtzu/uU=;
 b=R60cyd+mzF1N7LaLU2VkPX0Un2J55bv0sZsz3xKCT7sK2R2krgwmAS2WXf67M/bAus
 NlQ9BdueT4YykAb31ype1PyIO/vyggaRhKcaGDJ6xFPOn1nQcAT1J8RykovMzL1Sb02R
 eA6oewa2dDibxSNgYvmHy0Ghv779JmXiDuda0zQSUI15xy7Hf+EZDgMYfovzvNW/GDvC
 3Zqydxqi1V80X1XnqtMVApKeu7EZgz8laC+rg1zhvG/QGRo3K1jAa3PGINfXNMc8miKs
 aHYEMLjcw9d/TMufHpO41QzSyVvdsv3HnzRhCzC1GTTmJnM9xj9bvemnxF95mWa9biuj
 L75g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769540865; x=1770145665; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jRfcolwHbLqmzvd5zM6o+T5vfO89x1uMY/hPkgo++f4=;
 b=mniMATnJwG3HU+ppx1yz9zgmOB1sv1rKMT9Hhiur5bQO/qGa8v5FCLHLdj+021Ra1U
 5l3WzaeIEPAqlCfn8CJskKBdxITm1WH7nQb7UcnP5utq6adpWm4ZlBMwgl1p5aYQGTzd
 qzIe5V6xT0Bjd8uuSLBJAtKUKnLfVSMzzkSp3ACWJKDoEskkOfh/MIwqTNZAz4/Q1kL8
 fiO2KUwBRcOfq/1EfHZxCkhogjs//vzqdFzRa1kaKBK0zdReTa2e1qfMSobzvQteCef8
 tZlb2xZ7u6LkNlzBvtlufJQpZr0nKb+00KIQBPZnsKZ0jvtzlZk9oN2hEKOGeqsh7d+U
 TOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769540865; x=1770145665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRfcolwHbLqmzvd5zM6o+T5vfO89x1uMY/hPkgo++f4=;
 b=GgWnGm0MTf93OhPxe1LbahWt3Nj2ndZwUZ3wmAQiZNvilR8QJ9W5lSBPWJhC2qoR/O
 SDTFWQ6EBZEBbfDMZATTA6Chb5Bk+08knrvuV3QuZCbJihRmWPipvfM+ADObtA2YX0ac
 oyb+5j7HMSSrqssKv+ejfCRMELbF8MSUJZVNP1bGf1Ho41oo1iMLDSbMGJwiajtOAo/b
 PmIw35ja4wvh1jfwIgY4Rys3qt+5vuSat2PJXkmdSHyxfXEJ4zbQWCA1ql022y2sV+G2
 hcsKk/2pwx8itEQnnAf2hyyFOeSRxxU5MhC1EWuKJXTGLCEfU4sgwREm93+3mpv63xLN
 HapA==
X-Gm-Message-State: AOJu0YxzOGhkUiFa2D65wshonRmpbsEl/V8xlCtoFdZ/fgnk0Qj4wblg
 M9Lq9l3g1a4LjA85kgfmK96VWR9IJPpLADmVXXtuOIwbAcz3IeHN9Po3xuzsU1ZyDeOs8qUe+bq
 VFDnJjjfrAniKE7RYgtPMpsk1xs+pcWWEAQ==
X-Gm-Gg: AZuq6aKGbxQux0zeCKMX3dnURKAYICekceGK1Mnq0lnbkFDMcfQFq/+XCsFS3nB/+ni
 cL1mVaIExFIYfi+jZk9XdQ0A0HLSMxhOH1tD6ksT09xSscYWHjp1dGlYYkn8ZJNvFjZ/0uz25sa
 sAD5F6se2mKJcxnGI3OCyQIb9GyzPJANNyL9zFZoijgjjaCZLvcqNNVkTM0c7LxG5Xyipeem2i+
 bU6XQnm6+uD0PKsY2K3FvAgMYeyQanbYC6IbuJCxgRv4xiu5luVfswW810IvM1zErE0+UKBFXf8
 GVHsm/48qyf/ccYvoSSLg0MJ010=
X-Received: by 2002:a17:90b:37ce:b0:353:42ba:13b7 with SMTP id
 98e67ed59e1d1-353fecc6bc0mr2608084a91.8.1769540865417; Tue, 27 Jan 2026
 11:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20260122223423.1076448-1-marco.liebel@oss.qualcomm.com>
 <CAATN3NoZiPj5wfVm6+4MGEnrVX4sdZhnS4Wj7-_0SUe5u0wZ5w@mail.gmail.com>
 <CAJ+KCYO7YK7RSMz=LwT3H8vHK5Y5KJWa9oWb=ZweQ10DA4jpGQ@mail.gmail.com>
In-Reply-To: <CAJ+KCYO7YK7RSMz=LwT3H8vHK5Y5KJWa9oWb=ZweQ10DA4jpGQ@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 27 Jan 2026 12:07:34 -0700
X-Gm-Features: AZwV_QhsmlepTykhyUypECMuR_LIBWPYZ-c4XI0jaaLVwxrSpSorRtZEO-YZAUE
Message-ID: <CAATN3Nqtq3ioP=9ch4=9jo0B3Q4tNrgkfrDm7sG0MLuFprC3pw@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Change DisasContext packet type
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 sid.manning@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000b2e633064963567c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x529.google.com
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

--000000000000b2e633064963567c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 3:07=E2=80=AFPM Marco Liebel <marco.liebel@oss.qual=
comm.com>
wrote:

> On Sat, Jan 24, 2026 at 5:41=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gm=
ail.com>
> wrote:
>
>> This patch would be alot smaller if you kept pkt as-is and added a new
>> member
>> Packet packet;
>>
>
> That would reduce the patch size, but it wouldn=E2=80=99t remove the risk=
 of a
> dangling pointer
> and would introduce an alias instead. Is there a specific reason we need
> to keep the
> pointer around?
>

 There's a bunch of code throughout target/hexagon where a variable named
"pkt" is a pointer to a packet.  If you really want to get rid of the
pointer in DisasContext, do 2 things

   1. Name the field in DisasContext something else, e.g., packet.
   2. Don't eliminate the local "Packet *pkt" variables in various
   functions, e.g., gen_end_tb.

Then, it will be clear that "packet" is the actual struct and "pkt" is a
pointer.

Thanks,
Taylor

--000000000000b2e633064963567c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 26,=
 2026 at 3:07=E2=80=AFPM Marco Liebel &lt;<a href=3D"mailto:marco.liebel@os=
s.qualcomm.com">marco.liebel@oss.qualcomm.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"l=
tr"><div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Sat, Jan 24, 2026 at 5:41=E2=80=AFPM Taylor Simpson &lt;<a hr=
ef=3D"mailto:ltaylorsimpson@gmail.com" target=3D"_blank">ltaylorsimpson@gma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"ltr"><div dir=3D"ltr">This patch would be alot smaller if=
 you kept pkt as-is and added a new member</div><div class=3D"gmail_quote">=
<div>Packet packet;</div></div></div>
</blockquote></div><br></div><div>That would reduce the patch size, but it =
wouldn=E2=80=99t remove the risk of a dangling pointer<br>and would introdu=
ce an alias instead. Is there a specific reason we need to keep the<br>poin=
ter around?<br></div></div></div></blockquote><div><br></div><div>=C2=A0The=
re&#39;s a bunch of code throughout target/hexagon where a variable named &=
quot;pkt&quot; is a pointer to a packet.=C2=A0 If you really want to get ri=
d of the pointer in DisasContext, do 2 things</div><div><ol><li>Name the fi=
eld in DisasContext something else, e.g., packet.</li><li>Don&#39;t elimina=
te the local &quot;Packet *pkt&quot; variables in various functions, e.g., =
gen_end_tb.</li></ol><div>Then, it will be clear that &quot;packet&quot; is=
 the actual struct and &quot;pkt&quot; is a pointer.</div><div><br></div><d=
iv>Thanks,</div><div>Taylor</div><div><br></div></div></div></div>

--000000000000b2e633064963567c--

