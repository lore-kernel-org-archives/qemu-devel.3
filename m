Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3FAC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6fb-0005LU-I1; Wed, 16 Jul 2025 14:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uc6d4-0003uH-Ro
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 14:13:25 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uc6d3-0007vx-9p
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 14:13:18 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5373b62bdb4so1310298e0c.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752689596; x=1753294396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cjFqfHyGl+l2DeX2nCvra4CnmLYud68pFPe96jjv6Y8=;
 b=t3oPuBSoA3CAFEfDdvNqEwQTuTh7txy4KmPa3wpjFgk35z3zzXnrc9SpNb3c33GpV4
 VScW66Y7zivih1admv27mXOebmE4iTF8OBKaA+2iRGRFGaD0ryGILn8o94FHuasG4QuR
 lMWPffFLUqAOBLIuR29IIUnAWqVBNxYOYTR0YuMCviaPoAuetQfW8rmLry+6Fvtb8lhq
 TR89S3tPtUNW7rFUOBjW/6JudkyUXKUUrjyc8iRYA4I1WGhE66mgjBBRFuMptprnclT2
 o22Gu6w9dq5lNIEBxUt5lXPpE9iZmBqY32Pot9XaEFBnFGtd0Xv+I3UGO5Jz8noYItHk
 nnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752689596; x=1753294396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cjFqfHyGl+l2DeX2nCvra4CnmLYud68pFPe96jjv6Y8=;
 b=kp3ZIi4J9mtFqiVhK/CyuWP+e9UB4uppgYuJZsPR/YWapFfAqxQDWs0QfAq8nuEbS8
 DATwoyPMMEmfP77VaIg7nKY3fu2RP5KJ/6RNzs08PBCM/BDqVOiMMrYE3wBFrpnwrmVC
 1p93mnjA5IGTEw9WMpNpuQGHIFj8G/DbktJNQUOTRb9VJMxgkucKqBAVk7IU9owyI1te
 3ULIipWT8wLFP3qO5mN+uGRR5wXdx1oLolrvRcWKKduCakH/glrTnvQsxlIfGNQiWDsd
 P2qksMyhHAm4OyOtUUbx6MEgtBmwWcxt7UkjuS4ua+DjC84lW+AC3vTUAMThbJVvxLGw
 ZqRg==
X-Gm-Message-State: AOJu0Ywy5AoHBy19AbVuS8d0PkSzy3y1bz+tJLRsFwy6hBVjiGZIBVwh
 DRWPQyVQ5voJ6ZE9JhphxWFbab8RKD6+ctzNQUT/AAcRgFOACELg+cxrV6QMmBZKpSQs8qmiYsm
 vZGKo/VKRY54QOT5bweQGqVrNGU8Hp4tVW/31PGQMWw==
X-Gm-Gg: ASbGncvdXrWS9LkoeNkoKIGyMXcDrpII/uP1bZBdYQ6ewR0Qoqo/pXTDni4xbme+x9q
 b2YorMe6/HVxpEzS8rHs7uwLKEyiESTXRa7C0AVi9OzZ1NL7jEL0tX9L7rc4mycEo+qf+jcNa/G
 QUyEDU+ll44h/s1x+v82tXYef32hfGl6kZY2gi8hIg//o4yJaPBbqLh4UC1nfw2NEdOMIppUyGf
 FFQL8M=
X-Google-Smtp-Source: AGHT+IG888u3KDeZ/hn+COj8WVG4qKdOz7Mv0i6RscFCABSPiwRFCOB/AGuGvpxxNk5WURHndZBsuOVS/O870eUXD9E=
X-Received: by 2002:a05:6122:2896:b0:520:4806:a422 with SMTP id
 71dfb90a1353d-5374dde2768mr335456e0c.3.1752689595611; Wed, 16 Jul 2025
 11:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250715212335.2215509-1-pierrick.bouvier@linaro.org>
 <52c5ed4a-0225-4360-b1c8-e3866041c4b3@linaro.org>
 <1de7b0a3-846b-4e7b-b4a7-1b753f61ad0f@linaro.org>
In-Reply-To: <1de7b0a3-846b-4e7b-b4a7-1b753f61ad0f@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 Jul 2025 12:13:04 -0600
X-Gm-Features: Ac12FXxyn71ofdPfjAAV5ECKeXYPmgj6FFRSBA8wjgd-HhYwIAZBnq5cBWHe1EU
Message-ID: <CAFXwXrn3oUHeo=h2OZshZj3C24bf=tY6Mdz+rDX4YO0MAk70xQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] aarch64: update test images with new trusted firmware
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, jean-philippe@linaro.org, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bf923f063a0fd863"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-vk1-xa2b.google.com
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

--000000000000bf923f063a0fd863
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 July 2025, 10:50 Pierrick Bouvier, <pierrick.bouvier@linaro.org>
wrote:

> Do you plan to merge FEAT_MEC for 10.1, or prefer to wait for 10.2?
>

We have missed the soft freeze window. It must wait for 10.2 now.


r~

>

--000000000000bf923f063a0fd863
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">On Wed, 16 July 2025, 10:50 Pierrick Bo=
uvier, &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouvier@=
linaro.org</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_contai=
ner" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
Do you plan to merge FEAT_MEC for 10.1, or prefer to wait for 10.2?<br></bl=
ockquote></div><div dir=3D"auto"><br></div><div dir=3D"auto">We have missed=
 the soft freeze window. It must wait for 10.2 now.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">r~</div><div class=
=3D"gmail_quote gmail_quote_container" dir=3D"auto"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"></blockquote></div></div>

--000000000000bf923f063a0fd863--

