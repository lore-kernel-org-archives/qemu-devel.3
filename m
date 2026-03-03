Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684F1EC0485
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMWc-0004mQ-5O; Tue, 03 Mar 2026 04:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMWZ-0004lB-9V
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:58:43 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMWX-0002wL-Si
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:58:43 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ca2b32f46so4024693d50.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 01:58:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772531920; cv=none;
 d=google.com; s=arc-20240605;
 b=cABhge+4Ww31KgzHFQBnOfa8IVDGaCBKNdzjNV3A7UxX+I+iHvMDAgM1vhsqF2vi8F
 Ify19UZD+Lp5y4K58QiGM+mgKerKMKFgC/XJn8SvZZgfKkDKhn3E4JsPhwPUZCjNnIZB
 ld5bbi+OFDb9xswZPx5ligpI6dzlJBAix3mfevIJidqDvQBldMLqUIcsZHgwhv2VBXmj
 eaneWDFdtLHzueybVnnvqcXizLvLXiVbj7JVbOdTLmVpAiPkKYbFtq9R8Ciz/qDfzcRi
 yj+YbmP8pqSEN2OlgqEGsL/DlhbMYxhYteIz75LMPC5Ac7o52nhXzoUZO5vNyQtwFyFu
 Qyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5pCey5Ubv1AsOAyW3sQYFrNaoha+uFbjbH8c/Hsyb5Y=;
 fh=pqNLb1D8bcr6Ftek+8H330VOVv7kwixaST+YmWhgoFg=;
 b=kz5htGM9SyaAkVA2t52z9AhRQkO5TyhQ0eB+Fbkr0vRoaFeTQbijt9bv5/y6MQdeit
 hQv22gBSun+qezsbhFxem83LVcE7i+IgDnS7MdP8T5VgeI0wNaJBYyQlecBYz52zEfuU
 W8XohC4WTE9rri/IUAV9h4pJ+JyaHLXng8vJYDy5NB9QaKTq010iG8QMZCzvhZGH2KeQ
 GxG0yoHTFo3+NvxbJi6gEcUVDXjS5LQyrxrfVCPJbmngOjYdzNYCFiRUPVgh/SbGEHzx
 uFT39zqFzsea/2SpFIKA6Jho31HExrkoF3ZiaLH2b0BDf6Nr+N8aGycX3+GVMNqUnsrm
 czig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772531920; x=1773136720; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5pCey5Ubv1AsOAyW3sQYFrNaoha+uFbjbH8c/Hsyb5Y=;
 b=tC8yaGpoVNflvmaGm8TiZa7hkfetGL0XTq5qyW/k6UbRzA4xvWQtCOoM+zXfW65Lnp
 +Ya82mnDzHaRrEufUY8Sp3KVX3+MWGCXsNxxknkJcFby5GKXt+bbj/SNddlnRycexlSk
 TSJlbpYbIBqcxKD5iqg2U/1i5vwj3/2htlb0FUiOk1TNWmaKakzVGbufItirhv1UIS3m
 Gu6l6rUChyeLVUXwGy7qVPkxs8zsC/ib1aXOlMzwiXGsbPcJDc+q7twEpEMiqbnIGmkC
 NFS8CwuruYYKflZg2fENS1GA+3vr2mcpaABlgo8hlRYbHf4No1guDRwqjJxPWAqB8IiQ
 Nf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772531920; x=1773136720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pCey5Ubv1AsOAyW3sQYFrNaoha+uFbjbH8c/Hsyb5Y=;
 b=A+MEUBlf1m8ZnRl/bVPhpP+njlOR7ids0Nc7i2okHxRoi2iCtjOJYFVqYE5KbDugdp
 NxkQ957Kjq6O1e9xxpWVQK1VcHuG+o7ryx5Q55qApVP6Ek66fC2ldqItwY1P/CRoLS6H
 l4Jhxvg5XgUP9Xlqlc0B56nj9wpTwZBY50hgO4WUMAXgXW8N4b78z3bjAPX6GJUY690d
 QkK+NuHHPjqXRwFgmlZkagU/EcP0vUvZD/05PtcTFuRP9rO8WlnYjWfFmwel5DtFgU0x
 OE1PFYqyVoICUe6KTGmSO/m5DgGBoDbijLo6+WDmRLuMEeeIi4yl3uzqAud5esdzQQAg
 Tafg==
X-Gm-Message-State: AOJu0YwDqGTzaBs8IiIfzeZpXOQbPMjNjCwHFVDWRdRbSnfesC0fHxIp
 1AIV8AIlaJ8holn9QSFQTNSwSa7ehshafknuvjepsHL9mu2TjryBDsNnsDptFsAIek2MNOogJ4k
 zl2k1yHDVdH/l5co3YY13M5TRNg3net4g9DVJQtef7w==
X-Gm-Gg: ATEYQzwfKN41/qulwyqwZVZ+5qbJ8x72QceyvyIWMX6ZDd9wO+H8KW+/T4KOwXQBISe
 td5gsHjmS5Ri8dTR3xaAsRepEcRaX5YQEs+iIyBZobvAdzsKnYE/8Xv4y3E3fY9TbkWoo79aqAb
 lKhl3TdmmEV2Dr0D8vB9CiDV6ui3aPrdy++xOizNz7sVlAoASxTg7indTLVtI2Hilrtgt4O8oqD
 74421HeebuEk0ljRMlEfBN+4QsvWoCwuxcuSruKe5f8/fjH3M11ls8OEpXpEfBzCF5+PRZ2ZF1s
 jtRhm6jXeVBwSFFaUok5NnEHpQb+pjPcfa03f9YLfljt3p/vJvei1ppMTgf0ChLgNps=
X-Received: by 2002:a05:690e:4243:b0:64a:cf34:d9ac with SMTP id
 956f58d0204a3-64cc20d2d3dmr9976130d50.29.1772531920594; Tue, 03 Mar 2026
 01:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20260226090704.27699-1-thuth@redhat.com>
In-Reply-To: <20260226090704.27699-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 09:58:29 +0000
X-Gm-Features: AaiRm523zjLlYy9NV7-yZRbLKlTTYbBOfz4UahSJx23BXmZLJYD284RlkqIet0E
Message-ID: <CAFEAcA9g+S7Z4O6VsdH3tQ_zxJLwFq8Usipm5grVvzTMp45d+Q@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Remove the deprecated "highbank" and "midway"
 machines
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007aff98064c1bbffb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000007aff98064c1bbffb
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Feb 2026 at 09:07, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> These machines have been marked as deprecated two releases ago,
> and so far nobody complained that they are still useful, so it's
> time to remove these now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

--0000000000007aff98064c1bbffb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, 26 Feb 2026 at 09:07, Thomas Huth &lt;<a h=
ref=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<br>=
&gt; From: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat=
.com</a>&gt;<br>&gt;<br>&gt; These machines have been marked as deprecated =
two releases ago,<br>&gt; and so far nobody complained that they are still =
useful, so it&#39;s<br>&gt; time to remove these now.<br>&gt;<br><div>&gt; =
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@re=
dhat.com</a>&gt;</div><div><br></div><div><br>
<br>
Applied to target-arm.next, thanks.<br>
<br>
-- PMM<br>
<br></div></div>

--0000000000007aff98064c1bbffb--

