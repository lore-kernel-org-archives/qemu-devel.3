Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E27FEC0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w576d-0001bZ-EA; Tue, 24 Mar 2026 15:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w576a-0001bI-H3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:07:56 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w576Y-00005A-Sc
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:07:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a9296b3926so13376725ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774379273; cv=none;
 d=google.com; s=arc-20240605;
 b=TwUOf9W899vup4G6NBNlxIydNENmXOECdv9Qg5s6Q78lF3b87kOG9oAAVGWtYtmIMr
 sXvJI9EmzhGu0BndIIyC5W+RSKJG/qtC96Zu41hKSvJSaE/0F2rgOw/MXaBh8/EJEf7s
 QIgZr6ky9p8C0qNzym/bsAufPaykPMX65V5u5cnzdSRNbRUzgZAsfJpFEr/yIGFpVvC/
 3k6jHojPt7kNzFfkRHPUaLgOv/F5v+xBC21wrfcGjJuwGO0gjpRv6hYcb2uUe4HVwjQp
 3WhH/ae1OTimgjVEV/HhYa+nIusFVzCAN/uCc0HIN3E5G4gPUdM0U3oIUUuYs5SMfwF6
 g6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L4p41USaMqAlyjLMvAnhRKSZMPrFQRvUypW/tFUEqUI=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=O8f9zI4PljXV2Id83t+g+5tUuEcaG2E/wsvB2bxNsQJk9mEob8fbrGjedDbL9S0DzK
 UxrWQnkCSgw6Cc0AjYYcB/lULhzYAfnz94E5O2P5YH0lnVT7lwThDxqlJlJFtVIst4wE
 5lu9rx0SP6faiApCvXtDTZ5mlkHmnYXOUMfHkmfjoRqqZ5yegMOhDeowajZNE6fu36PK
 q9itI5i9EYdQkmG28+F6gAEQ/pd0KVpaa1q0Jb8VArRycMfjLNDFk0gKbpmR3QxnXfXR
 Dc0XaBo8zE0qkzSgq/GTZu4iC5ouIjN0Cv01lR5nv1hVzNAgY0FR1zdHIuC6XwkcpS8M
 4CTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774379273; x=1774984073; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L4p41USaMqAlyjLMvAnhRKSZMPrFQRvUypW/tFUEqUI=;
 b=sttCKHB7FnmAYaFIrci76dAleftcRkddHOUCmis06zCQAnVGPJ+udEfACYxkD6JhpT
 MzLhZmxRUP5hcgzdKuXGBJ5ONmRL8pC31Nr42MV2vk1qUM74iMIq1s4cdlWv0giN32M4
 m9FH5sOvxEFJ8343Gh1DbFwlKGU4jAmyvLgPG4UaJZjTaQAVnBpU4mJn0wyZXrV6ZD5T
 +4mrx0iX2BQiR8muRF4FcEivx65IOyNzELGUwhhCX0YMBKZe71F2n7lK++MvoQppXDMC
 YZTy/l1XtKKeMfggoFbFzpg200jmm/eOPG76WnnAMoBBTrnt1c8s2tBargyZwQVXWUHd
 epJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774379273; x=1774984073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4p41USaMqAlyjLMvAnhRKSZMPrFQRvUypW/tFUEqUI=;
 b=CQhMosbvsIVUXVVtlBstK8DKAaWlrgDFaXVWBUkA+mDLnU8MgYqmpnPRIhlDIzYHgm
 TG32scnSndECah7QHgLmD8aK730kOTgHYUn6e1HeDrFw0Y+B4tl53SKSTSs20vUD7Nv4
 K3qLLB6UCahjH5R1Vhayehp/1EBJ9o27PLatvffMQsdDG5EpX9xvnwbM8s4C+xU7vzz7
 u6r31IHCNDWE5I2IkEsxTy0tWo6qOaROCjhJb+Q5FyHRJO+j8qYOTtmiDCpcHl/gjkjj
 6yPHZykTJh6AAT4f+3BJsPfMhUXyfdKV4SNWX99Tnn1t8bJ2ppTyb1tT62zOS+CLBvQn
 sSpg==
X-Gm-Message-State: AOJu0YyNlfhl/cmolrZxUHjSAYEtIinfPily68KdZl8CmdkXy1D6TxRo
 x1JoTXTYRLxxMuAM15Cno/JvcGhuywUgx5BM0fQAaCUIV+LNWlpoG69ryRuGShmnIlmil3EwUGr
 6alGUsZiKTicx5qFIlaFR8/WyGCzF9G8=
X-Gm-Gg: ATEYQzyU0mtY6QfNVDPv95OycJEB7owylST8+1ULIO8/9wwG2hSq7F/T64gqP95CfIh
 VgxLkHUWcFyLxM17h2r0N9p5sC8992AZ8+aU9mIj0fV3BbbDLTbHLcPKEm57SpV4dn8LgZ5QcKU
 unox80eIyryPKCllvyPYa8ob0IqtRgjBonferWWYqrCBpyi9FMl2XNE81v3wEMEDdHyHERAB5af
 +aFk5Wt2HCH8I2Ft8XLhfMxJzNrcPK4DazXiK0sV3gJS6UoikmESQr2SoFudqEY2xesaACb8w9n
 cEnrUJx9ZcKi8wNPFaLArpqGRf2pHBl5B4lSNytnY03YCDITKA==
X-Received: by 2002:a17:903:908:b0:2b0:669d:3a68 with SMTP id
 d9443c01a7336-2b0b0a15b81mr8395615ad.19.1774379273088; Tue, 24 Mar 2026
 12:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <de0eb7d07cdae77e9803feccae79f5c9f29277d6.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <de0eb7d07cdae77e9803feccae79f5c9f29277d6.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 24 Mar 2026 13:07:41 -0600
X-Gm-Features: AaiRm52Fb_ZX8-3vp9Ih-AnNERtMMGlAweV0AYKUbxBvHTtM8O5-bYWrTZWD9JM
Message-ID: <CAATN3NqtZEQxzmpUtY80dpRGvuwx=XLRqyf2e6QXVkGfANP-1A@mail.gmail.com>
Subject: Re: [PATCH 11/13] tests/hexagon: add tests for v68 HVX IEEE float
 min/max
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="00000000000044f324064dc9de61"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x62a.google.com
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

--00000000000044f324064dc9de61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/fp_hvx.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--00000000000044f324064dc9de61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23,=
 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Sign=
ed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.bernard=
ino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm.com=
</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/fp_hvx.c | 21 +++++++++++++++++++++<br>
=C2=A01 file changed, 21 insertions(+)<br></blockquote><div><br></div><div>=
Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com"=
>ltaylorsimpson@gmail.com</a>&gt;=C2=A0</div></div></div>

--00000000000044f324064dc9de61--

