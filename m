Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F371C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4H4d-0006rk-4L; Wed, 09 Sep 2026 08:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <readqemu@gmail.com>)
 id 1x4Cnk-0007UD-VE
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:33:00 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <readqemu@gmail.com>)
 id 1x4Cnj-0004OO-JC
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:33:00 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso6935805a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 00:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788939177; cv=none;
 d=google.com; s=arc-20260327;
 b=EIGe6GWOefDJtFkLh5QkeJfTjcYP/zYeFgqJ8bmnBGNEmM9NqWzV6lgY8EvnkMeL5d
 TjdiEz2vBzAabhqtBewBS6/E/fOGmnoX6M5YsGXIUdXmjvETvn0OkeDTdDNCvk3UcTn9
 1CVrLLJjsCK3sS/PjAt+fzgALGxZsKylEcCbd1f1eRKPLzNE4pP6wlnUZTtGMe8IsFUi
 0GrQn8E91cNSbg5nv81avyyDyJbZbVzHttqzzbDX3YGZjCiL1mRPK7jtnGiif9yIdLjs
 mxeI8JXpwMZV7/r8UFtERCA/AaTbiYeANj2mtmQuWrZPFlQ6xALQUap8lV0/DTbk1d62
 R2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L1lp+a6grUq9QWrKs7p5Wo+a4nCUMqQfkPzxpyIiF+8=;
 fh=Gg4+Esnrv6Q3zmSkTl2BjbiQzr4/Ze7SUtbskGGAjqg=;
 b=OvpUuulmb9hLFCO11eng6hEbl+cCamNXLvUxVvNByVMGN5eYpzfNYLvOdbEhsDefdC
 QewGM3BQxbpU2BmPVC3Tm0sfudrC5xJFATas3LXhgQTNdgygACsuAYz/3Ug+OSiqzwlo
 JqbePGZhg+b+rHQNFT0eOwRqYzkA/2nuYVuVfcynLkoDlGMnroR+F7UfeqD+kDtXOA2G
 CkpAGwVpUEHoFmE0QaR/vxkKE4SOQyJutkURzLdLxBqPmSk6/N75yQz1eEvZdCVUQ0Ko
 T/OzXrwFKJE7xNx9s7wS02pLmFcN3XXYxTzglRcaSZAZJj0BaGm2RiWNI0LbzYFCLs/w
 bHvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788939177; x=1789543977; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L1lp+a6grUq9QWrKs7p5Wo+a4nCUMqQfkPzxpyIiF+8=;
 b=QktBvQMYFMK3aZpmaDVQjtGbd8JeqTqb6SROYp476j2eY2BmFEKy8ho1qs9R4sXiVd
 S1KSHJpJc55TRjoBAM9gSG2HDOY1eZcycWA/o8QnALi4pbdTuTCkiYFhuoPvAiE3DyD/
 TsQ6w4ADNv60xgcOXRjibnfu+lhuEVVcY5+7Aa/y7hze/zg/QYo2Kjp4hRilUegH2TRG
 VsemNhRflfZDi1BI/6mYXhkZ06poNezDk4/il8/cdggnDEexjvof7nFAgtWDUip8lD7f
 dJxszPamCxTB38UxcowujRz7F1YAD3zPPuPcW23HR6BfaU4nNuThFOfo5lgPaha99G1H
 axIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788939177; x=1789543977;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L1lp+a6grUq9QWrKs7p5Wo+a4nCUMqQfkPzxpyIiF+8=;
 b=KconFZ9S1UARUbKWyMhutagMvOtKFFZPS7++q9i/0GWAjVqL36EZicf+EJfB/YL/K/
 +ckFMIBHgXvR4B7CyZNqXFhpUkXor0odAMvZKG1ePUH4p8iTue717USrjHtIC20jvf09
 wbU+8+TGDCRemgTaNR+hbh6Zim1n9qaZufU0lXp4gTPIB3kGxkiKn+FYI+7g7lCZfm+n
 v1IlDwEiHByzsshxw7xqD0s+8z8upHJhuWuwbkTyrADenNsZCUOsD1hYoXZ6O39V35Iy
 786wQ6sZfFzPS/etQZwSqhYyUC9NXG4PQHFuI91r5QeLJa5fvY0a1oHt7jYs5K0ONuKo
 OAxA==
X-Gm-Message-State: AFuF++mX75qkpilzNNirn6OQpl2eixpAp1BwhLG0qWnsORkp4wKdq1J/
 dYVTIOoOAteiRHG6qBKOjWNg2rdkXbkNkWpIXaJ/8PEJhZ4sssf2Y+JMc2IEG+TPyQ2gU8iAx6M
 p6E5H0W+FSKXKQIJCO+sB8gaCtoX6wIc=
X-Gm-Gg: AYBFou21m0YDPG4U33psvgNGsDxWx8vymC8ZB3k/cJRSCtlBHFYAorfN5QBNuLJbqO1
 oYqmRhGyuZyX8HQe6b1S/VLB91zm2mxbAZjcD/47uP5l7IkB2NJfWiKwbgu72swoISc5i709KbO
 xRwvwgPJugdogLdR3dPX58aJoN2IggY4riCueVVdX71DXVIGouURKoZQdoTnuAZM45QYamXGsOV
 mLoyM3SkxOEpytDe2Jk+5UfkGB/6iW1wMO12cGGoDwHk05zjFENuPHR/RIe2E2QbqDrjbptIyHV
 WgzApENwZsLaJ3HY+MfZz2HFPll4eU+K7lSItE4DwTeWcVD41m/iHxR1iQ==
X-Received: by 2002:a05:6402:13d2:b0:698:e614:e4bf with SMTP id
 4fb4d7f45d1cf-6a7e8cb530amr11447107a12.0.1788939177276; Wed, 09 Sep 2026
 00:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
 <20260723200325.24969-2-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260723200325.24969-2-zhiwei_liu@linux.alibaba.com>
From: Qemu <readqemu@gmail.com>
Date: Wed, 9 Sep 2026 15:32:44 +0800
X-Gm-Features: AcwNN1UthEaXlNHv0uiJDAv2G2v1Z8J-UPbzgvVms4BfFSJ9r3khhaCgEsqZf7g
Message-ID: <CAMXXpfZoEHGRXTMzWtmtkBcnp+YO9O=sJqV0M4oyUYKvoPs7hg@mail.gmail.com>
Subject: Re: [PATCH v8 01/11] target/riscv: Add basic definitions and CSRs for
 SMMPT
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com, 
 liwei1518@gmail.com, qemu-riscv@nongnu.org, rahul@summations.net, 
 xiangyi.zeng@linux.alibaba.com, cxx194832@alibaba-inc.com, 
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000002fb934065b07dce6"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=readqemu@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 09 Sep 2026 08:06:30 -0400
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

--0000000000002fb934065b07dce6
Content-Type: text/plain; charset="UTF-8"

> This provides the necessary infrastructure for the core MPT logic and
> MMU integration that will follow.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Jay Chang <jay.chang@sifive.com>

Thanks.

--0000000000002fb934065b07dce6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span class=3D"gmail-il">&gt; This provides the neces=
sary infrastructure for the core MPT logic and<br>&gt; MMU integration that=
 will follow.<br>&gt;=C2=A0<br>&gt; Co-authored-by: Huang Tao &lt;<a href=
=3D"mailto:eric.huang@linux.alibaba.com" target=3D"_blank">eric.huang@linux=
.alibaba.com</a>&gt;<br>&gt; Co-authored-by: TANG Tiancheng &lt;<a href=3D"=
mailto:lyndra@linux.alibaba.com" target=3D"_blank">lyndra@linux.alibaba.com=
</a>&gt;<br>&gt; Signed-off-by: LIU Zhiwei &lt;<a href=3D"mailto:zhiwei_liu=
@linux.alibaba.com" target=3D"_blank">zhiwei_liu@linux.alibaba.com</a>&gt;<=
/span></div><div><span class=3D"gmail-il"><br></span></div><span class=3D"g=
mail-il">Reviewed</span>-by: Jay Chang &lt;<a href=3D"mailto:jay.chang@sifi=
ve.com">jay.chang@sifive.com</a>&gt;<div><br></div><div>Thanks.</div></div>

--0000000000002fb934065b07dce6--

