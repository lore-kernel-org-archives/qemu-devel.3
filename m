Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BC9CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIvvB-0003D8-HF; Tue, 11 Nov 2025 16:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vIvvA-0003Co-77
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:29:00 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vIvv0-0001NL-Ov
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:28:59 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-bb2447d11ceso100693a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 13:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762896529; x=1763501329; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iZqZUND+X2tBdz3e/u7lhPrvrKt/w9shgAzcDRtROS0=;
 b=nNsG9XLhR2D8kFwSlBVMMHL6QEEa58SeNbnwQCsLJbF4g3KvjcN8aLfiCG6uGUDzRT
 Xvq5jEDqm76n5sKwVRYTrwTBPPtrDqzGG75nSsyQQCnlwI7iQrpULEPFDob3dJ25jHFN
 cHmbb8MIhjXfst4RfcpB7BRd6eyx+3UDAI1cEihyxkgnQtAxUlpdlNcD7CVU2tLcd8ld
 9kXb1+0T214HDaITOI7Btk1MGf7XAPqqFHxmSn0OSp4xhZbOTp+Nvr8Hmq/hjJY+fp/V
 CcpvRN216+8x+9E2MUQoTiwtdiYJMMtwg0Jnmhw5v81Sz1TZSI+ckR1DckdKAGFbJIpB
 0B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762896529; x=1763501329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZqZUND+X2tBdz3e/u7lhPrvrKt/w9shgAzcDRtROS0=;
 b=CpVAd+dVRVaZBY0t5iTM92PNeIi6LGkCgMtr1dvHPB8pUvC9LwlDyuAAHcaBEubSHp
 p0MUbWSedG+as+Q8X5F0Cb86A1DecFHkeoe0it4YlSR8CdrCP8ZddFa/MAzdnNlJCXl6
 D0dNEerpOH6We+OfDkIOtm0Uv5vMLakhj4Afg6sSy+aHsP90L+QVG0qULadpNzXF5Efq
 Qwqtsq2tD39t4TY8iQ4lnQYGMeA04q13xiQKNC4jEie5VaVdCdAPFVGT8VRUhvqDDmQj
 9bIvkrXVHhxUMWJIWIitwRzSzJvfkYhVxN487sdBEOuk9KbPCs2xEqnwQUnvBNG6XOOV
 B3/g==
X-Gm-Message-State: AOJu0YzH/FXPTNoF0nRfkr/DpVGnVtZkYHo7C+LO5fydRrorqCo/BNm7
 G3YS7Bi+ZZR2PHjBRoC3NwedWp6drROcFeWfxksUi4zquR/EYHRi9s0+lwuCfdkm73DPOcdbd8L
 LKq5tGf2ZEXBrpTEH+YXLXBo9TYB5VzE=
X-Gm-Gg: ASbGncs0jztOWNeQ83a8exKHj1rmLBEbG7nAvtmaghw9bQsnmTuYOHSqjNhoH++cK95
 oZtefPffqLi9cbWImkizVioZwnWKbUg346i2zE6bW0P+ikBTFv1VYwfvTFvKtgzQxigxZ5jCJxO
 FSZGpxC93mnM3NIaiCKo2JDD5CuvjNmq9MA86PCNFYZM5NwhaHTVfOowlho5/os8sqmqk0LwWvm
 A84BEzMO/nsMvaDc4Io4EaX7tNX018E4iVsAmCRWlGuj3hvy72OunaHUb59
X-Google-Smtp-Source: AGHT+IEqBaL9uw2BOxssU6Jv5wZnFOCFIa7RalBcuvF2gDSJZMJAf4Xwo6F9WzgAmBAaDlZYp2KKhI86YQ+xiINvVSo=
X-Received: by 2002:a17:902:ccd1:b0:295:570d:116e with SMTP id
 d9443c01a7336-2984eddda33mr9614755ad.41.1762896528640; Tue, 11 Nov 2025
 13:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20251021205741.57109-1-philmd@linaro.org>
 <20251021205741.57109-7-philmd@linaro.org>
In-Reply-To: <20251021205741.57109-7-philmd@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 11 Nov 2025 15:28:35 -0600
X-Gm-Features: AWmQ_bnufn-9weUIGB54U-Ya9xkEdb9bPyk_AqNvBEyu4xJuXX5BfHNEnQHEUmg
Message-ID: <CAJy5ezqRdrpLvN5T_hZ2ec2FzQfQJvd+Osa9TpcFrOg=v8QW+Q@mail.gmail.com>
Subject: Re: [PATCH v7 06/19] config/target: Implement per-binary TargetInfo
 structure (ARM, AARCH64)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005d8dc306435855af"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-pg1-x52a.google.com
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

--0000000000005d8dc306435855af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:59=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Implement the TargetInfo structure for qemu-system-arm
> and qemu-system-aarch64 binaries.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>


Hi Phil!

Trying to run xenpvh guests with latest QEMU but running into trouble, the
xenpvh does get built into qemu-system-aarch64 any more.
Bisecting pointed me to this patch.

To reproduce --enable-xen, and see if xenpvh shows up in -M \? or not.

Any ideas?


>

--0000000000005d8dc306435855af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Oct 21, 2025 at 2:59=E2=80=AFPM P=
hilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@=
linaro.org</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_contai=
ner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Implement the Target=
Info structure for qemu-system-arm<br>
and qemu-system-aarch64 binaries.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro=
.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></blockqu=
ote><div><br></div><div><br></div><div>Hi Phil!</div><div><br></div><div>Tr=
ying to run xenpvh=C2=A0guests with latest QEMU but running into trouble, t=
he xenpvh=C2=A0does get built into qemu-system-aarch64 any more.</div><div>=
Bisecting pointed me to this patch.</div><div><br></div><div>To reproduce -=
-enable-xen, and see if xenpvh shows up in -M \? or not.</div><div><br></di=
v><div>Any ideas?</div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><br>
</blockquote></div></div>

--0000000000005d8dc306435855af--

