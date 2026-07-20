Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D98C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljGv-0005vJ-5h; Mon, 20 Jul 2026 04:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljGt-0005v3-CU
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:22:43 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljGr-0001Ic-P0
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:22:43 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6685483aad2so1058540d50.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784535760; cv=none;
 d=google.com; s=arc-20260327;
 b=dC6b9mpXFSG/ywPHRPYirWehSHv4oEs6QjMUrwg1CzWn2G9aR8jvw6TSeQdFVyLeaa
 7QXAYt/wt+adm4w/7jAtWxL0nctZ380I4xx0MorW2PC6EYE9ma0xoNRFpGdHOQLOQyWl
 cPcxKVPy4y+Bbv9rLkml4oNskCzKirs7Uf/5f+vWRe7ZsRvOkz0G143fJzctiokPcYYt
 qGItBtGxYVNjD1b6l8N+484jH1YRWbF5fo+xnBe7xEZVYvLgKStJI2h2d4j+TjkvgLQ8
 kXhvZH4H/BJdAWWSDkEbfOaX6Sz2h73WFMHKyDV05jgK2bpnZxUxHJVB50VeePfGKBu6
 tx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M9A6jkMVVolLkv/BO0tKGbA7QdhmCZZDNiQCYD7HWf4=;
 fh=irEcErfWMJfCUH+Q/yFHLDJyuj3eSefAvVjQyz37IN0=;
 b=o0LpfNt0WLdj2HIi0BbYsFSYwOdRKszmenWMwmIB/ooaykAS0QDbaFkVlZfHytUmEZ
 9+A5BSZ1Dwp6nPZFKUleaZzpdERmyyFTcQnqHmKnEGM+2ttKvy2FtJuqt0H92nlE/W0q
 XOfIvYSxtmtGhX6idtwNE8sylzp+vCDGRm3KMV9cMX2X9bCyjwKVFLejE1wauhSZZe35
 AixH/b4wzCYZT9p86qWipz0hxLeWuq/I4b/Ym5jsQfAm8Btu8R7rraM+yJ81g/1nJbq1
 KTKcyKbgrDAfzbBk4CXDfSF4ZArna5ceeL2XGjVJtElJ03W5oV6nxiYw781O/wkUVrYk
 +Sbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784535760; x=1785140560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M9A6jkMVVolLkv/BO0tKGbA7QdhmCZZDNiQCYD7HWf4=;
 b=igY4sGMQ1W+bTjr6c/qdORxK2AuCGW7ZN+JGb+sUi3LXdg2TsuGjhJleJMrIhU6PUo
 +buRkVPVb0JGVu/AtlYAnS1WMgNnZdmpzTl2n5yuVZFBCOJWYYpySUNCCMkUY1S3TEL5
 odUsGwmT41AS0LK0GQ0bstn+LaeeD6rY2xfeCdZMjuZQPyb2lupyIdm1XyYoqxZKdgSY
 syw7mEjACe3z7x5Vms0k4zZnGHnKTy/KPusCeIlbtAne0p5KLEWcIE/2BEVoTGZfNOmv
 b3v/HM7q19++U9yfVoobLKvmA//gjB30S6+hXllqK5f3udK7m9CU9mPiaVgLM7iKAzKU
 EQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535760; x=1785140560;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M9A6jkMVVolLkv/BO0tKGbA7QdhmCZZDNiQCYD7HWf4=;
 b=SuZSL67onGGQWPaNdpxMupCp31Il4R0vYM9kzsJpWFowWGIsZMFg/40Dlg7XGCHvof
 p2RLHSRgRAYX3MNU/dea8Qkh3BwERiA5TOs8IUxzVYNZaBJ8FKmYAFP73gOgG8seRXVu
 B1c5lVg5wB0f+CAbJKiioJY+4Jhshb5k6PEu/yqjsT+O3q3sffK8mgyWOKmiNuExELzU
 cy0Rxo6Vv/nPbRryu7buVoPn2jyO0aGufC+VeVfSQ0+UWowBMlt4ScmKXhD24fhtZc2X
 JnXwz8+ylXl4bwcseq5d0AS18cSHo0kPQ3Op5GHhwQyt6K8fOvo/dpkvjB9DdJxAjuDj
 Qs2w==
X-Gm-Message-State: AOJu0YxoDLjQA+qDqoxVdOTDgP1+Vl8ifQrRAedpSYTkGORfqNmAVpPt
 oH9rnFK79SYOUmZeDGjbTATtmIsdKdCGCixLUAEP/xZU/k1pAb5oGxjKUWfLOSoFS80MjUoRbDI
 Ccu5HFP7Do9dAfiigW7LTT5v7/Ln7UVwF7bLCYenVog==
X-Gm-Gg: AR+sD109QCsFoIkeqJE3sOYr/byEnDwHsMC506vB8PzYUSZmFABclknB0pnpPr1qZLm
 J0xM4a7HEhd5QQwdMZmoyog3Jxaj/Cw7DgnmKjl+Sk1LfTfkqSwrkr+Y55iMQAHt8v+mJ9/I3OQ
 Ur51YvoP7X8nfVJhRoOcGuQp14nNRI3xW5VBS3w0UCTS4ttFGmi5F5dXwg0GhelULseQsvs+Nyc
 kQvLg9gkc9jS7BZYS22+8GvJfvMx57tEkhUFLMrEYIglRPjzwsgpEPjggiZKyTLc+jjcohzjas8
 zIig4nb4mYB3zjZ0hrLoE1Dhg7NMHY2TMuVp3KCSCvYPgg==
X-Received: by 2002:a05:690c:9a93:b0:80d:bb95:5a06 with SMTP id
 00721157ae682-81ef273600amr41900147b3.5.1784535759878; Mon, 20 Jul 2026
 01:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260719152318.69501-1-matthew@pq.io>
 <20260719152318.69501-3-matthew@pq.io>
In-Reply-To: <20260719152318.69501-3-matthew@pq.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 09:22:28 +0100
X-Gm-Features: AUfX_mwGf65FjEX05iB-5HXxEQZ8mfnEaP4ePX9p9ffPeDeK_uWqh3EbPEWrhTU
Message-ID: <CAFEAcA9Mqtk65y9jJCWZgmRUMwgV+Sz7Y=R=Pp5R5huNj8cLjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/usb/dev-hid: add apple-mighty-mouse
To: Matthew Jackson <matthew@pq.io>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, 19 Jul 2026 at 16:24, Matthew Jackson <matthew@pq.io> wrote:

> +
> +/*
> + * apple-mighty-mouse (USB type name; legacy alias `apple-magic-tablet`)
> + * --------------------------------------------------------------------
> + *
> + * Internal symbols carry the historic `amt` / `apple_magic_tablet` /
> + * `USBAppleMagicTabletState` prefixes =E2=80=94 kept to minimize diff c=
hurn
> + * since this file's user-facing identity flipped during the 2026-05-09
> + * fresh-eyes rewrite (see header below). Only the `-device` string and
> + * vmstate name are user-visible and were renamed.
> + */

For QEMU upstream this is a fresh new piece of code and we
don't care about its development history -- we would rather
have it be consistent.

> +/*
> + * apple-mighty-mouse device =E2=80=94 FRESH-EYES REWRITE 2026-05-09.
> + *
> + * Goal: macOS sees a USB HID mouse from Apple that "just works" for cur=
sor
> + * motion. Not Magic Trackpad multitouch =E2=80=94 that path needs deep =
RE we don't
> + * have ground-truth wire bytes for. Instead, present as **Apple Mighty
> + * Mouse (PID 0x0304)** =E2=80=94 Apple's wired ball mouse. macOS' gener=
ic
> + * AppleHIDMouseEventDriver / IOHIDPointing chain handles standard boot
> + * mouse reports natively; cursor motion works without any vendor-specif=
ic
> + * SET_REPORT / multitouch protocol.
> + *
> + * Why this works where Magic Trackpad emulation didn't:
> + *   - Mighty Mouse PID 0x0304 does NOT match AppleMultitouchTrackpadHID
> + *     EventDriver (which is the driver gating cursor on PID 0x0265).
> + *   - Mighty Mouse uses standard USB HID boot mouse protocol (3-byte
> + *     reports: button + dx + dy) =E2=80=94 no proprietary 1387-byte Rep=
ort 0x44.
> + *   - Single USB interface =E2=80=94 no SET_REPORT-gated multitouch ena=
ble path.
> + *   - bSubClass=3D1 bProto=3D2 (boot mouse) =E2=80=94 guaranteed-bindin=
g driver match
> + *     across every macOS version.
> + *
> + * Single interface, single IN endpoint, simple 3-byte boot-mouse report=
s.
> + */

Reading this comment prompts me to check with you whether you have
read our AI contribution policy, which at present is essentially
a "no AI generated code or text in contributions" policy:

https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-gener=
ated-content

thanks
-- PMM

