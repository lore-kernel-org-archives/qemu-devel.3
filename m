Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4C4CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ48G-0004RR-8f; Thu, 21 May 2026 10:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ484-0004N8-8s
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:12:05 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ480-0001kj-Fm
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:12:03 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65dead17c24so5930406d50.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779372713; cv=none;
 d=google.com; s=arc-20240605;
 b=YAJ2b02V8yVIEjsDwp9cDnONfv/HVcN0nC7kQyUe0vMtpm2D1KORAj36c0XhQMYDFW
 IwR2lUyE3vu3GB5ggoiRFnIGm4qAGcokCxCq1eYeP75nMxhggwZJ0coqilVdFpkuEBVO
 a4MaUJscnCMFTqRec9K78RI1GPnUIep9GakevHayWyW+dQdf8toyskMZvCqsOko/bD1y
 ljB4L9k74tNp5gFiGNbn1iRhop6JIj8mSUs7H5AVVG38eLubk8UTBHRgUA1mfqGlhWVu
 xNXVRzSMKPxLeBW5ul9pCbHFg/PQaikP8DCe8oHBQeauLl45Ipw8qU8bptr83GPRlFuv
 EBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qPWs35sie46S8s5z3t95FtOk5lKAehKhIcFOa+1tCsk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=AL9Wty7ONb+dBacDA3xO6BgvUR4sxTl/8VIJLQDuw1kXORwzXcrZT4vjGGjbpgWA4o
 AZvoybRjtj6P3eVRYgftlKIRxC29hrO72qpMnz6fJySo9wFrtqxvzwL6aw2zLFxieNtz
 8o0p1rsC+GKp50XIjSC3JqwPeYbzt7W3CFXw6rzz0NU2FkMHEg+OEi+s29A3LtfB0Hwv
 jGzFfvdWRybFmBJPbC8+t4bCBJDdrJh/HKfUKJlvH2lC8hR/eSI5DiiYy/0XPjGTJBYx
 DNqiVkI/ZWEurEhagxEqB4lx8V6EO2v5+c8SpCyjMI/ZibPEKXPrXqQUox1ke0R4ZCWw
 unzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779372713; x=1779977513; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qPWs35sie46S8s5z3t95FtOk5lKAehKhIcFOa+1tCsk=;
 b=MvX9K1Lm6RzXY3R0E6/kwBDReNBM93GaWzm57mFFRmt0/pvNI13Gg8diJCm78ED2M8
 VZ+FyYxlMn7w/iUMrlVa3DX1UlolEj8PHhv//g2Zvno6kxX3uLhgL1Sby5IFIiHpCOjr
 oYgPIvrr7FsrV01C6XEzwLHwPtZX/U0CJCqqAo0RDvv/tx35vp9gnJaabpAjAIKxEk2Y
 iIeA7/bOUvNm3mjO+igdHzo941FWAD2S2oewL8vNOqi2YGrE79wk9Hsl87sVw1RymMjn
 1T/Bxe8xDd5+DOSGR4CF3b5oD67Z0g0v+tLtioOe51mD+l/TAU0d9z1WcWTT6vLDc4B9
 doQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779372713; x=1779977513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPWs35sie46S8s5z3t95FtOk5lKAehKhIcFOa+1tCsk=;
 b=k7ZJL0qL0uvWF1UBDXlpbqKS7QwrWTjTAMoNIF5/P1KsifI+7YayY9lEgqIUS3ouW7
 t4O8dc/qs5MEccmOGHUJWKzlVRZmQmduIUNe1QfZOetByU0JOV3KXbokmVx0uq/+U+Gw
 XBmEmQJ1DlyxNOYfYfZAPAj6d+uQcuaXfEWuaU3Th//PXx3qRIZ01iGcdAkC1AAnfi2i
 Md518q7NwUS0sSYRkSWZpuSl+zr7hxV1mv51abS4ylOrntrLqby6UUhqWdheaDFVgj6k
 Gsamgx38TnWYsUeol9PZhYHap5U8ZZMXgU3/ckJRME+W8m+B5blVAx8pDHHNWOKR3Kib
 6L+w==
X-Gm-Message-State: AOJu0YywOA7BcfPOr2rTo/Hqj99VJ7eGpXOiVNldC62wTvbBKToCc8tB
 wHGmyaGylYmSHYRgquz1kfOZUnztpUcdFIc0uNtkw60lk/jDNwfToryxHwEFyBYXap8IMHUqNZu
 /0AD+ZTPb46RhTnkDjpHMk25rM0aYvojdfksIZ9m2wQ==
X-Gm-Gg: Acq92OHlK1TcexOjA5Xn9ox8N2+tiMOf0tDlZS4KEsi3YU8jlH5kZqttCoffUyFJHe6
 WZ2K7dcw6rD+62BTuI+4rgtER6t0zMxERyCfhjgstOdpMfUq1w9ZvrWGEskDBPfzt9LgRw7g7JV
 G1xUQ2ZX/6/QDcXHqXiQRh8m+WnvLxW/j/2KAebCYqy+7A/60PQ+Xy3AIfxMO1xWcKI7yeMTu4O
 7Irv9yyvCQJmqn2D54Ds5pdopdDMkoQ6NATydGlS8+MjUKHA9Z4E8bi/4lXVaEofpxASgD/KoIe
 TiHmPx1IqZtwmUobn3iSN01MqNF0al/gq4BaoN1zrr293r0aytR/1N/S7YkMMdL5YQxK0HnayiH
 g4w==
X-Received: by 2002:a53:ac96:0:b0:65e:4bcb:2a7d with SMTP id
 956f58d0204a3-65eae30eb83mr2507952d50.57.1779372713462; Thu, 21 May 2026
 07:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-10-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:11:41 +0100
X-Gm-Features: AVHnY4Jhr8fqC5s2SfCloCIwFDaDE-EbXnFLx9mKhs30xM3e-w2CkT_-hg9FJvE
Message-ID: <CAFEAcA9iZSXa7xSC4PSh8enDiJpQhO7xYfc=h9qAN+OTOLQ+FA@mail.gmail.com>
Subject: Re: [PATCH v6 09/64] target/arm: Update SCTLR bits for FEAT_FPMR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008261c90652547ed7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000008261c90652547ed7
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 at 19:24, Richard Henderson <
richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

--0000000000008261c90652547ed7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, 20 May 2026 at 19:24, Richard Henderson &l=
t;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.=
org</a>&gt; wrote:<br>&gt;<br>&gt; Signed-off-by: Richard Henderson &lt;<a =
href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</=
a>&gt;<br>&gt; ---<br>&gt; =C2=A0target/arm/cpu.h | 1 +<br>&gt; =C2=A01 fil=
e changed, 1 insertion(+)<br><div>&gt;</div><div><br></div><div>Reviewed-by=
: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_=
blank">peter.maydell@linaro.org</a>&gt;<br>
<br>
thanks<br>
-- PMM<br>
<br></div></div>

--0000000000008261c90652547ed7--

