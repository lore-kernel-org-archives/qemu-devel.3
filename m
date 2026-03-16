Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4C2F53D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Br4-0006uj-Bs; Mon, 16 Mar 2026 13:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2Bqz-0006uQ-9y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:35:45 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2Bqv-00053I-Pf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:35:44 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so3204637a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 10:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773682539; cv=none;
 d=google.com; s=arc-20240605;
 b=BhrryZ76PF+ZDwU1gzmayApq/ghSoLebg16ZP3f7ArWDKpj0OpSz0x4qHbo2Cr7LBa
 i199vS9vUJLc5sR5cJUNvYvQSQFWOzut2BWNEZdAlNyqsd51LCtDuv4B1SDwCUQFCG1K
 vqSkDgaGUmZRS40WcG8U4YfLu/ir4Dm2EnGmBaBeVRmzfiM1JN4VxTxZLLiEYESyus3D
 5Spiws+wWcq6+GEueHAUDyFc55Di8gTltBB2f9+aJEp7ll2vX6kV1IPnhrjTAmkafM+f
 cqk2GfOD03Dg6y2QDcbsBR/bJ7MzsAP2HGJ4NQJyq2Sd7hD7ys834eWtKkk2nhg0egu+
 KFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R1AOqV7k2st8wTgAb9rYAn9XYE75HZx2ZawIIm8e55Y=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=BDBND8gypqNcFBYpU58u604toJIP/FdH+jqirDP/ACp01a0xu+hPA8ynib6L/laUWD
 sPsc7RY+18B2Bdy6yBsfpzGS7Z6Q7w0ajqGG51SQmm7hG4VX8CasO/LuyW+UKTwuHFW+
 nxWH5shbWAoHQqjdN5f1KgoeFmB3RKtOn0g4FnJOOwUe0Axm2ktIKHtrEu0tSzvBceZd
 dm/5x0aTA7hiS5V7KU9P+fJOPZCVNV8Kj8rAeYLuTieqhKCdOrjtot/a82foR845Q4d0
 8MG2XR31BHQm/UM0QGP0dWRpOVzuJ8i4/l+It22ebiGb0GUnHq7/hU0d72q7RnqalOkl
 3QrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773682539; x=1774287339; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R1AOqV7k2st8wTgAb9rYAn9XYE75HZx2ZawIIm8e55Y=;
 b=RJ29FHI5bjcjiyKLzE6kGtAqP+8l6TzUsQ4UePkgvDA8kfULrThL42qefuRZmnM3ul
 a/Q9Tg0dGOr/J6TxrGe+IJ9ZAdfKVKcSRQRlZchh1C0ojtgismEr99xvqAH3YOlVryKp
 52uHWxIGoN5Nf1FO6ZHhxySOHz1c/Fd+2dGBJrN9swbx/YAdAxB7KZAJz1aFJljck8xf
 4zjKJffqQ4p/hVAks7kQFdJIduf/8D8r9Tw391+jNbuKaqn/rNNjpAHZYLbIW/FLfTv3
 JMZwOoyLJiYCmpomt7vceR87mhg4eRaQD9WMwC486F0XTSrBac7eFwZBCN7Baa10iedu
 GlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773682539; x=1774287339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1AOqV7k2st8wTgAb9rYAn9XYE75HZx2ZawIIm8e55Y=;
 b=XKPKJp555sSFdbrSKPwRbwAoIn9qG3lquhoZ22KRcNk5Uz9unPSnooAnen3tX74V0o
 3NdPAdKd8/rpp3bgaxw2y8rSMrwOUUUQsOGV+YJM5GbtyIvb5bTRGFtQX++ZDAKLjrsW
 pZwdHgOcqL1ej5nP8sFtI+cSBFDIX9vjied12rPyRs67B37ulkURsg4eOSLAOiXiWVxN
 DGyNgXKvllLytvr2yM5o7Ie/dStphTvo4imBtribZK2jzWbxYGtH7MZSzxzHa1T49fRC
 MsX8pGkDrHHNqkNkv+BeESeH1wQTdkf7fspAnUUKmopII4vNsUmBODQfCmBvH5PJ9ZvZ
 xLiQ==
X-Gm-Message-State: AOJu0YyU+i1IV8CIVr/z7s6HTDFNMFcK37tm4USVtB+aLhZrU0bY6xB/
 y2dWlLW72u06ybn9W7GMa3NQC2agcQtDVJS5bffdagVYLTc/2a9GjbZx1vJkc9kyBNgxQ/hP+Oc
 r3vPIwZHT6QUtrZe/n2QNIYXeTMCoVZo=
X-Gm-Gg: ATEYQzxy2Fpkf+Rw6tETaC3q5kxEake3IwCJNGEtRRU4j1P3gkOaiQHe8v/+FfoEy+O
 iNjok31WO0wNvcGsNbzgF/FBVaTtM2XTI0c+SJqZKUbKX9etUJ3wwdI0H/6Hmv8fA4MhsBUfDj8
 dyfCp38qMlFCCPdb3tjYJ/D5MkfwVTO5dFZjTDq82ZLna0bFT2tywPdjSoWuWcCDVzgiph3MSSD
 5qCIcL9agIVAOJ4UpBICCovmHwjFEHtNAod+E59zdJJnckShZ21ie+fFMncfZtjB2G8yAA9UJTQ
 +bTZT5qQRMOUu5GqsiomcIOGi1t0ide1vavYVA/TpJbcWIbJ
X-Received: by 2002:a05:6a20:d10d:b0:398:6b26:dbe7 with SMTP id
 adf61e73a8af0-398eccbdad8mr12762773637.37.1773682539144; Mon, 16 Mar 2026
 10:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-29-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-29-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 11:35:27 -0600
X-Gm-Features: AaiRm52qhWJqJV0GbUQkDNU3cbUgi-CaqW1IznWJEIUK0MX3sKkrQ5XeZN3S3ug
Message-ID: <CAATN3Nr6DmpnoYZBgokSrQvs1=gEQAQCC2S71u_6e_Ya3zO+Nw@mail.gmail.com>
Subject: Re: [PATCH v3 28/32] target/hexagon: Add PC to raise_exception, use
 fTRAP() helper
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000b0a9c7064d27a5ba"
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x530.google.com
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

--000000000000b0a9c7064d27a5ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Add PC to raise_exception helper
>
> Replace the fGEN_TCG_J2_trap0 macro override with the fTRAP()-generated
> system helper instead.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h   |  7 -------
>  target/hexagon/helper.h    |  2 +-
>  target/hexagon/op_helper.c | 10 ++++------
>  target/hexagon/translate.c | 20 +++++++++++++++-----
>  4 files changed, 20 insertions(+), 19 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000b0a9c7064d27a5ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mai=
lto:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Add PC to raise_exception helper<br>
<br>
Replace the fGEN_TCG_J2_trap0 macro override with the fTRAP()-generated<br>
system helper instead.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/gen_tcg.h=C2=A0 =C2=A0|=C2=A0 7 -------<br>
=C2=A0target/hexagon/helper.h=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0target/hexagon/op_helper.c | 10 ++++------<br>
=C2=A0target/hexagon/translate.c | 20 +++++++++++++++-----<br>
=C2=A04 files changed, 20 insertions(+), 19 deletions(-)<br></blockquote><d=
iv><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylor=
simpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div><=
/div></div>

--000000000000b0a9c7064d27a5ba--

