Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77666EF3717
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeJD-0005ko-Kh; Mon, 09 Mar 2026 13:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vzeIz-0005fp-Fg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:22:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vzeIt-0006dC-Eu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:22:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8298fad2063so2361817b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773076919; cv=none;
 d=google.com; s=arc-20240605;
 b=WOoMgLm8p8VlWT69eDtz7msrKN8++FeICTf0xHISmynb56rDeHyfj9LiV4MPuTRzwW
 G23N8DHCyv8XwWNifPsMHfG6cFALmyScsgqTEQzpEwyXCPcxnJ2Jnd8bF4FH9QWlaBlU
 K9J05V4ruqGHhEYMxodCXZD+G2rTGeKspkqAMZTyHt3aE+tc6n2WiMynoRBxntrCwc/b
 s6gF+LOlI60KoWQf2DqqDvh95j8bdeybsnPaYAnQf3lC9KERmFmHQmIn4NyqR7CTFcs1
 R70iWla54CJ6nBP6BoAJY66b531o8CSAmlRg2GwdBzxQrIpE0XBmHE45A5qV6gmX0ks5
 Tr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9r1EBcxnH6VnpirgLTdEuMrhHbiF9asulPwa67ZIMss=;
 fh=yiUwoBOEypY2fM3mHrz5u4mbHkIidyv/b4UPGcEpz+k=;
 b=HuiBBVgBRGi/S4HgQ9toXW4128mrn9WbOUQTEp5yDFAUXZwNV2BEmTKFwqPv18qMSV
 Ypq5759uZJWa1I0pl6unZcCJXTnLY9BwjW7QNy+kK+QE1mqPJ9P84g81JxXCpHDFpqc2
 kRutkpGbQI7rK6qGZF/SO5uxkszPO9O2dof19aK3GUB/RMJ8ReIVBrNFGAEPAQ5b1j6c
 TWI959ENdpNLLPiKjqVC7AWuIQ9iOE4MSkvV0iSqb4Lijpm3rEFcLCojOpFX/MAGZ4nb
 r9X0FmQ3n67Z4bS+w0e6sVjlHlYSG520GtAJMXjxkCJLkK6xg6FfIqj23Nh7tnw6Y7//
 XDPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773076919; x=1773681719; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9r1EBcxnH6VnpirgLTdEuMrhHbiF9asulPwa67ZIMss=;
 b=hEE70ApWHKW5/sYqwR1C7IybKjRiG9uTM9P2LGw/FE3R6Yi3pzH77Vwd643uKg33G+
 fuk+7DMYQUEUvBhZJQZin/M4aWlVMoz6YHnQR5SC+2/EPoeiW2AbFdoToe5Bk2bLEc6q
 ePCL0APDVsVDGhTNImeh4pSSSpZuAAlRpYsTUQL07j0xcEwni+UZXr4mQXu2NILFGL5e
 p/Q3B4xA9tnDolHRm03OKa3pooWojdHAVf0P/GeqgRTNiBOmf/KjLHsaWfKz6mhJh/Tf
 0RtKxXqxw9gQFi1eWXuaaN89Y5x11wtE0ugDxQroHgkB75AyZvhexBYUh3oJPcU2c3w2
 wABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773076919; x=1773681719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9r1EBcxnH6VnpirgLTdEuMrhHbiF9asulPwa67ZIMss=;
 b=BzpxP+Xa+vRoTfP9Bs2sv5QymJEUl59RMZLs/R032KcwDoOJHz41Lip9QdP3EfO+aT
 bwpO+U+E5yZwzLlovahPcABdRfShyQeIEPUdDqoPYVEaYxNEw7qBchgGCyS6AQh3sjSr
 I2wgNKPNoDJsXvkXuYbuV5vsp+LcJlv9Xj+wHzxle91DEvm9BqYGsWRsqsRjCI6BKsAy
 OekKedZ6jOOu67pCgj6/w+LHNajuO09N4kRT7mEHIfLFFrcfTAJEOqA34Ra5LyGmEY72
 xxl1qyckQr+AbJHO7W+Geh5YjoBkqNWCagtJCwSdE+ek992lqRSGmcp3MrLRzcuOtd84
 E5tA==
X-Gm-Message-State: AOJu0YxAzijS3S1J4CYFyb5ZFqf7FiqYy1bX4nqtizCQRBOiTnFdG14T
 BOyecO3VNL0aq38fAu2lN+t2a0XGTuyT3decP+YLeU8ec/yfyQuHoTzchbgsez/XGAJ2dHhivjJ
 xPR34HYd4utI8k1bZt0KXBiiRPXrSrMU=
X-Gm-Gg: ATEYQzyv3iowxWGwfN7+Pj6Fbd4pbf7yaO8qlfZtnkrtQw1qEIH0+ttPgqyIzcJuoHz
 GJ73JDRqrLrN3PcJ6K8MQP9dk99UlgzXplDQQVZM4IkpYc8J154DjYPkhF0y5/iVTLZ9dOs08x5
 AM9yLipuT4eXlMfEpkjNNrkjlsSJ0YBZrJVefFfjmxCCGSAVrmtotV76RE/Z7YjJt8OiEksUhAk
 lqOLjlRVfQrktsEdF7BzYfRAuq3+rKZkKkvwNWWSHzZ7LZgTo4Og1aSmL1VQqaTcWOe1wd83Il6
 GxaaTp4DZmlDM9Kr+Q+GRv1T37WHyJTJrObLTA==
X-Received: by 2002:a05:6a00:3cc7:b0:81f:23b5:dc33 with SMTP id
 d2e1a72fcca58-829a2f6fe59mr10152711b3a.30.1773076919303; Mon, 09 Mar 2026
 10:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
 <20260309144822.877695-32-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260309144822.877695-32-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 9 Mar 2026 11:21:48 -0600
X-Gm-Features: AaiRm52mdyV-EYIn__v1MGCQP-GEmOh2dk5ONFp982Cljb7TgWLNCkW52w7MTh4
Message-ID: <CAATN3NpnwPzr42zhP=gc4T=V_x4TQ36gJj99XnwGtEc018aOXg@mail.gmail.com>
Subject: Re: [PATCH v4 31/35] hw/hexagon: Introduce hexagon TLB device
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000ef4726064c9aa35a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x42f.google.com
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

--000000000000ef4726064c9aa35a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:49=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> Add the hexagon TLB QOM device model.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon_tlb.h |  45 +++
>  target/hexagon/cpu.h             |   4 +
>  hw/hexagon/hexagon_tlb.c         | 463 +++++++++++++++++++++++++++++++
>  target/hexagon/cpu.c             |   5 +
>  4 files changed, 517 insertions(+)
>  create mode 100644 include/hw/hexagon/hexagon_tlb.h
>  create mode 100644 hw/hexagon/hexagon_tlb.c
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000ef4726064c9aa35a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, =
2026 at 8:49=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qua=
lcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Add the hexagon TLB QOM device model.=
<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0include/hw/hexagon/hexagon_tlb.h |=C2=A0 45 +++<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A04 +<br>
=C2=A0hw/hexagon/hexagon_tlb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 463 +++++=
++++++++++++++++++++++++++<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A05 +<br>
=C2=A04 files changed, 517 insertions(+)<br>
=C2=A0create mode 100644 include/hw/hexagon/hexagon_tlb.h<br>
=C2=A0create mode 100644 hw/hexagon/hexagon_tlb.c<br></blockquote><div><br>=
</div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson=
@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></div></=
div>

--000000000000ef4726064c9aa35a--

