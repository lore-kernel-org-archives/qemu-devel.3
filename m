Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EA3CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLBv-0000y3-9c; Mon, 27 Oct 2025 07:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDLBb-0000ap-Kh
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:14:54 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDLBR-00089P-DK
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:14:49 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-63e330a1360so4878903d50.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563668; x=1762168468; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pskZw5DLpP/xDMQMjw31wbkLr9mwhPCBWcUw9JjqcWk=;
 b=sOxCcdL9XTSd1RA6F2/mf2kEgwEaV/Kas8hM2inPNFCyLQgt2kltikoOKV530BQgDM
 o5G5VlEPWmgtgtw68V7qE3POtd4vPOoVb5CoyXQ6XpGE1ejrsc+xWp1MhLNbrCkJWfms
 R3r2ezQaIgnvgxnke1PlZD7Hco5uMZEPWw+y75ALqwl+zJX2ZBKUH/aCzqytsy1sTcN0
 +LAXg43bqhwO3UByGpeTg35CuAyG/dj6nuSm8s9B9/QeM5APZvTb5+58UG3SaqC0qssL
 UIf5zmD9g3rMioBnsrD8baHdyYjD6pv0KemA63qYsLZO1D3koxWEOcm/sIUQibFx64c5
 TeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563668; x=1762168468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pskZw5DLpP/xDMQMjw31wbkLr9mwhPCBWcUw9JjqcWk=;
 b=kZvQkwlfkD/zbxEpQeQkNoob1TSKUcsWw1BrWjXSKLwqbW2YqoHB3WrmbJB2fTkMSo
 B8zhb7ooKGhowiGCNyQlfhJ4iEmxpgIX4otlDH3fubzpZchCtSxam05u56fUsF3lPT48
 BBYJnv7G/XVBTo/EtlLCkrMx7nC7RSTK3CRii7CugGbkuEmnQ1CL1UxylgTRPkLrh/5S
 gazoBqG5MUNh49vZrO/7kkD4ANqfKDjqFso/Yn+EFQiiiyigeKHo1EdPWUUaGQNXDT2G
 PDrsgpdkZIsuWM0w3frM7wdOjMhC/ouD6Sq7ckNMR2xGzvy5Nzrj8OKCR4Irt5qVy4tb
 KZ2A==
X-Gm-Message-State: AOJu0YwhpvKCwuj50gO5fcypQOyJZgvEU5MMmY+gudYc0YXc/HYg2F1f
 atIrx8wIBIPihAs5BKNVobqVRaobTdXACT2LpRxplNxWsqOPtx6VSXbobmOIHKJ57rLZY745IKJ
 Dur+6sVSZVxtfA6mykGRl1pbneFlQugBC7fCtnQaFkA==
X-Gm-Gg: ASbGncuL9kyzE+jp1JmUQY0wArTOO1ZkjCTUe7e8Q3IBf4G3cUkMDj1K3TR5JO2VGqr
 fTCiGxKSbjgPjrkjcter3P6hnU8LsEmEXby+3XabTWff+H64bB1DlwZ9Vbd8nFOdCSmJTBl6lJG
 OCf4sp/WtScPDj1Rg3QhUfzMJpjq+jwc/dw7OKNTZJWemia5UIGtUl8Y6aYJswfzD7crp3baSiZ
 +RrSsY6/+nFzo0yt/1GXI7GpzFW/DyLPuMiEb8vJnQTEQ68eg5QY/sfJ5kVaw==
X-Google-Smtp-Source: AGHT+IGWME6nkNKfaH+Bbk6rsG35FBrEEilNG8kWH1HP6RTwHfHFiNDFyG05H20xRMwXzcHLFqSud9l4o941jY3upDM=
X-Received: by 2002:a05:690e:419b:b0:63e:1c4c:302b with SMTP id
 956f58d0204a3-63f378c4e53mr12969017d50.47.1761563667703; Mon, 27 Oct 2025
 04:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251021145313.4584-1-philmd@linaro.org>
In-Reply-To: <20251021145313.4584-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 11:14:15 +0000
X-Gm-Features: AWmQ_bkH_jL3DWOvxchR7RvXqEKF12Utam3dMdEF2ldn_SnlYqpl2of3h2vWnqk
Message-ID: <CAFEAcA9D+zHH_+UQDPc-GqSH-b8NC9VvoXXJwhOxT8Mtry08Mg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/gpio/pl061: Declare pullups/pulldowns as 8-bit types
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>
Content-Type: multipart/alternative; boundary="000000000000a9b7210642220007"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

--000000000000a9b7210642220007
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Oct 2025 at 15:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:
>
> uint8_t is good enough to hold a property "between 0 and 0xff".
>
> Define pullups/pulldowns properties using DEFINE_PROP_UINT8()
> macro, remove unnecessary range checks in pl061_realize().
> Update the two caller sites.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> v2: qdev_prop_set_uint32 -> qdev_prop_set_uint8 in callers (Peter)



Applied to target-arm.next, thanks.

-- PMM

--000000000000a9b7210642220007
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, 21 Oct 2025 at 15:53, Philippe Mathieu-Dau=
d=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; =
wrote:<br>&gt;<br>&gt; uint8_t is good enough to hold a property &quot;betw=
een 0 and 0xff&quot;.<br>&gt;<br>&gt; Define pullups/pulldowns properties u=
sing DEFINE_PROP_UINT8()<br>&gt; macro, remove unnecessary range checks in =
pl061_realize().<br>&gt; Update the two caller sites.<br>&gt;<br>&gt; Signe=
d-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.o=
rg">philmd@linaro.org</a>&gt;<br>&gt; ---<br><div>&gt; v2: qdev_prop_set_ui=
nt32 -&gt; qdev_prop_set_uint8 in callers (Peter)</div><div><br></div><div>=
<br>
<br>
Applied to target-arm.next, thanks.<br>
<br>
-- PMM<br>
<br></div></div>

--000000000000a9b7210642220007--

