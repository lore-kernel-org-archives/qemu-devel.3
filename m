Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359B3C5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 12:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsJZC-0001YA-FQ; Fri, 07 Aug 2026 08:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahshehab24@gmail.com>)
 id 1wsJZ7-0001Xt-OM
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 08:20:46 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahshehab24@gmail.com>)
 id 1wsJZ5-0004sK-2u
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 08:20:45 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-39c7ce122c7so27614521fa.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 05:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786105240; cv=none;
 d=google.com; s=arc-20260327;
 b=NLbiT037HgfpQy+I76Mdumb89f864N3O/Ws7xXPbCvetsnd3Ziu3abR1Jnql1Th4T4
 FKKlJtZYjmeimJe9TF4ZqjFmEqzUGNcYRTrUsPpt9r3Z1ZNO82B+x8fNd9w3wTrCQsLB
 s6V1lGTM86FEkgbAChnlg/anXOYIDVPSPfvIjhyNFTwtGxhHULI/H9jR59G7lNY1HOce
 qsuqec7Hfi6uY93qDcerNbCwFte58L8e/7u3kCA9yF4pz9LBuRisUilow9R8oA4BPM3D
 M+iFduLiiFba4M8USeJ5DI4U9JZ8SMQpVw0DnGNiSELUQQZoAQgdUZI3CpIPsowK8Nw6
 WegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3r600VAzrZZcPqNnveFqiPmKCez+VS+LhKY4TXZ/BHk=;
 fh=fM7KSPMjImjWzsdKcaV7PeYVprmSf8prO6RfY8kbTFs=;
 b=cW6dLX8ijejPuImsR4ajbEBVOcXTM9V+4ohx+yikDJFj1l8GLX79d/VF9v6pbaSmj5
 vv0YES1et8/DPFQm0OtSPf+aNhLDAeVyfKqNVrVpBHxr13w1ym6TZdOqRJdyG3asjSjc
 DCl7X9T4HE9ksakvMCwDXEsISxHHh1f/AcvtWWGEcjRbmX6z7KZq58/5OikwOmuy5Q85
 43uExX6CAw/FnOAL9aUwkJGR/ElI/QrZFf7bCYNXpzEqpL1ry0lDT8T71HbOdANAME9q
 tGZstaqX0gp1BfeOaNOu3ejt+zmtL8EsaxmRltMyCjtx9Em6/ee6fuKoW8UZAcESFtyr
 QK2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786105240; x=1786710040; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3r600VAzrZZcPqNnveFqiPmKCez+VS+LhKY4TXZ/BHk=;
 b=Fj+AUEBAVcwGhaUpFsoB42+A1GCZBJQd2rItnrkcwMYyBQXNWP0Eulq9EjQbH6iOwY
 mS+ThYI0pV+reFB4Uv5sHzgFWZRu8pBcECNoRHOf4Mlagz6O2x7eu8gnSGXmbOUvHEvH
 7zizehWNycZLTJUwAxgagz3y0y9LSv9BQILgdrwGFRHn56/s8iJTWHWKkr65WougBd6t
 5AFNFWccBrZN7vLwZHWNtFUyCquDb1VKNJfjpuW3TL+JNsUbqlT1pKFkVU6aYAzFp1cm
 1dpftLIUEyohF/m9lipK4F6isUS3RjpqMj9jjVooVasSr+3pPvDhGCiDxQA8n+oiKQmC
 T6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786105240; x=1786710040;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3r600VAzrZZcPqNnveFqiPmKCez+VS+LhKY4TXZ/BHk=;
 b=g6e+zh1O9aQ2QUKTlMZpzfpTYmExci/+ZN+crux0CnvTfvee+fA2KIE4/Gq8eO931s
 FjMxvkSME0lTiVsqwK0tKf7y8brICYkrywDpzaHmrnTmFWXP6JCugy2zNQdz04fabDYy
 +be7jT7Lii92OCrTmwGs7qZj1a9JBPPEJqmsq+e6kTI2kuVMc+Wa++bzMzSRFPBAo7HU
 dbatPrsECgumhMzw7t0iI3cY9PyomyRwsR2jhp7jFHUX4WPBdEdKCutzFnoRn5tZc1TI
 vaoG+I/XQJcDIKEqBoIbbLNCYk2oJrxNauyueSXvMLhyNNeBRIVuJBvHjBAVfqtCih4v
 ei9Q==
X-Gm-Message-State: AOJu0YyldBpk+8MHAdqpuJRK069mb9ngOpBmP8QLOpjzGQvpUeZDO2V5
 O96U88ygoUpPAPNqJagdmxSzTvqpiSVSIZbRnnEAiVOPIzexWTnIBsYE6imhR3k3GdFJVOo3YV6
 MdSfMql+w5DR03144s5XX1fZcs55c7bAQ6wq56MNpl60H8rTN6K52KheVtBH63bnZ/XNmUvE=
X-Gm-Gg: AR+sD10kotWnTLxyFNfNLHXiyvq+n9xM1iF312H4NRNRuRxskKoLAsN6FAIGZA8RkNb
 yYcA7pFceqn1WCOnrAYuvU/wXbXBJCKALYGLp7Ki1ChMmVgFOXZ/igah2Kzaogp5/hNMXetJyNU
 Lqwhc2dk9VlKky3XQZuOYDhiUgHNVbn8oTMBExmpVHYVny4o+/9V/31PhbeznP73sXljttfy4zz
 E8PYSLFqrHK7P8clzZcGN/SpKIi6By570F+DFmGYTSOKm7aMOXx/1KtdfEHetsnMHmdkiGXvhum
 RRbolxaPJB5wieEKAMghAvA6qmmGkuNe/4KAy7bSQ599UTDuHDTBcJxi
X-Received: by 2002:a2e:b8d2:0:b0:39f:a2be:bc61 with SMTP id
 38308e7fff4ca-39fbb3227dbmr23510591fa.27.1786105239776; Fri, 07 Aug 2026
 05:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260730181852.1622-1-ahshehab24@gmail.com>
 <CANiaA1v6qFSMMDBp7dHqKWhW3d7vRQUMXDB3+vDuaWqLGCk=xg@mail.gmail.com>
In-Reply-To: <CANiaA1v6qFSMMDBp7dHqKWhW3d7vRQUMXDB3+vDuaWqLGCk=xg@mail.gmail.com>
From: Ahmed Shehab <ahshehab24@gmail.com>
Date: Fri, 7 Aug 2026 15:20:27 +0300
X-Gm-Features: AUfX_mxdLZnIpHvtQnmuEWEgToVsMBusW1IOy00OEEkr7uWi-ihpUWTv13QoqYo
Message-ID: <CADdZfQQMVd_K_HEzoc0taKaDZm18G95O_ts_jaESFgDHRevHMw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix PC sync in trans_sspopchk for CFI
 exception handling
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: multipart/alternative; boundary="0000000000005933020658740851"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=ahshehab24@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 MIME_BOUND_DIGITS_15=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000005933020658740851
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=F0=9F=91=8D

Ahmed Shehab reacted via Gmail
<https://www.google.com/gmail/about/?utm_source=3Dgmail-in-product&utm_medi=
um=3Det&utm_campaign=3Demojireactionemail#app>

--0000000000005933020658740851
Content-Type: text/vnd.google.email-reaction+json; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

{
  "emoji": "=F0=9F=91=8D",
  "version": 1
}
--0000000000005933020658740851
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><p style=3D"font-size:50px;margin-top:0;margin-bottom:0">=F0=9F=91=8D<=
/p><p style=3D"margin-top:10px;margin-bottom:0">Ahmed Shehab reacted via <a=
 href=3D"https://www.google.com/gmail/about/?utm_source=3Dgmail-in-product&=
amp;utm_medium=3Det&amp;utm_campaign=3Demojireactionemail#app">Gmail</a></p=
></div>

--0000000000005933020658740851--

