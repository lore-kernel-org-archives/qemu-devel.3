Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAF8F94CB7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 01:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFMCg-0001vg-21; Tue, 21 Apr 2026 21:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wFMCe-0001vX-PO
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 21:16:32 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wFMCd-0006IM-Ar
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 21:16:32 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-50d836552daso2636731cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 18:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820589; cv=none;
 d=google.com; s=arc-20240605;
 b=PmLh2jJMEGYH3X6x9waLUM0NdrQZhMiJTA4VUnyRFv87Z0/KkD692+lXh2n3QI6gvY
 7xRdsRwgDkpRkohtS0f7SNHqS9zfuTtIY10NKxwoP9cIu0jdzuGaYnw+9CcfneIjfKBB
 Epj1TwmCAdD8xcptONVaht4Yd9y8DRKI1gjXfAAxk4f9AmLQ0LIhToiU4OerP4F1sGf6
 vxF04QZyMvs639dE3nmibd5UcAhT7HgN8ohP569xbLUZ1ImVke32XIzQ0JeLRDHAxhW3
 /D9mS3qBc12kmInAELGEIcT7HTHhunuIXZjPrjUhDhQzT0L19kxHEmK6IgqB+5brG50o
 w1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RuRCotfbGw39y//NM7F4PPlo6I0sd9XN2Rdo9CWnbNs=;
 fh=/AP7bia0iHDeR8c04cPaf+iCaHk1zqhUreJXpq5QEd0=;
 b=bQGATUV8SPBFBv6o08E6y+VXNOM6CkMuRGJIKmsxItZEqZyobrtYSVvxUJK7NEmsC3
 ZQ9mUSEecTZLNlyN1VxLLkcaFXOeyP5XvbhPsgTG0dHA7PQ4Hl68cVt9bIrqGEWqsKhV
 3N7qnX6k8+2yHPpCftu2NkpILVuT2hibdFjSt6HLfobwaNPxXvh+TlwNnwPL9OVjbL2o
 GgnN1Zr+0dHT1F8SgZ5YjpFlEtf9vU7YLUfzcx8A3Fi/3XBCXIM64XW72uR4pspH+IB0
 uhXT6PGUjTm92C+n69QnShObinavQXTD5omcCOxcAicBiTOsygJfMLqRelS0jeU36meQ
 VfgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776820589; x=1777425389; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuRCotfbGw39y//NM7F4PPlo6I0sd9XN2Rdo9CWnbNs=;
 b=osqUlu9mhCpK6XWTS3C9eiyv36u034nlYxcZxIOrR4JM+Zb+m1diCWiQhya9wlUXNa
 P9lodX3yVbATCP1TR/3inB0NZ0Tf0l9VCnKkaCQsEysQsHc/WCO82oJmFgoYXqeQZxQx
 LEYexptXRCxvOPaIzBrpd6WjShezY5dobQssMaRsAxFHMmB/uwywRfxFOgABq0wBKTKQ
 qQqyvETN2E1trj1sUpjBuoZpUqw6sDlrRm1Tx/AatuPsnkv365NwsALlnqwVc7D0Vi7O
 v10VOKUXn4BUkeNCH1wPDxqgrOa3QjBQwzD9BhgIoDGXthsLIPsHE9TIrPp69ZHqkvEr
 3GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820589; x=1777425389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RuRCotfbGw39y//NM7F4PPlo6I0sd9XN2Rdo9CWnbNs=;
 b=WoMk/t7IOCXD6dPwwlTVrDOf+mCETeWhCZHiz/ihRGkJKsHxXyX+1GePh1djoVRSMD
 wLXhXfbbaR6syxDDmoiHHmmBfls3oWnPEk9jwxxMM1cnDNXGGkKL3EESW6PqRbRK1/m+
 ZH5Kh0BeBS4wiILosFVzseCPZc3/0plgCCHnpGQplxq/XXx5ts/7ITJ/WORRwZBZLKm7
 /9/ZvRXjHBPSMqqLU6MyryWNkZlrwR1JwhB7uM/3rUJcO4zKhN/U0iDdskgn+FS2JqE7
 v+VQxINH2QHzw9FHXbDxYQLa8MT8TBc3qrQ+cUrA2wJlz3S2br/uvgywPO6hg9HJUyFF
 CCFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8azk9fCmUHAKzQuL/kiL64EEU/8prNW/a+fvSu3NdJm61/KiNe2SxtLh8TkdBZFcTcH2V/WcDBKwrU@nongnu.org
X-Gm-Message-State: AOJu0YzW4fYRKAG5u2m91Sf4kVP7T3Ug/N/y72mNlaVhWdtK9u828fSU
 ALJX6rNYp6UzS7srufP4NoQK4dFSUENUPH6E8y+lljuPJKPxq5s/rumgj/HvV0dvzoWYsR2hh9c
 0h6m8ZGuRmXw9Cnc9NWagDihs1F91PndkA1BA8KnP
X-Gm-Gg: AeBDieu7yJ8P6alk6gFO2gdjtoGKvxY5Txlw4/5ZWVaz/3kab75hTb6qEw14NofU7Hn
 VRXmjU9mTS/Yrufo8kYzbBp3eyE/npxz7EJ6o4PCYKf+ljatH0J3CzH2Hd8RWY8KPh7hjPZvZdz
 Z8OoJwAIVcRcvbrW9VDNUflj59DMd+vupdsMQlrLMCK+JG21fZMJFgxAGSBrw2mcAgywNKXjztG
 fQqlhsq3/P6h4GAK77EhlwuDozsT1LCEoqbCZHXnc171Hd/eIssqNemWdJvjOqUWqvOiTHazKXm
 5t8X+3RKuq/WYXls3reVT+/ET6ZYWWsgVAOY3oC/hNME5935IKWJ4laogfc=
X-Received: by 2002:ac8:5d50:0:b0:50e:6189:cd29 with SMTP id
 d75a77b69052e-50e6189d107mr11376631cf.11.1776820588673; Tue, 21 Apr 2026
 18:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
In-Reply-To: <20260421211237.GC466778@fedora>
From: Jorge Moreira <jemoreira@google.com>
Date: Tue, 21 Apr 2026 18:16:17 -0700
X-Gm-Features: AQROBzBGgxGRfTGLft0xcSVfcCkF83NDmMQkxUXr1G5_odfRVrtMSCkpEpRIsBk
Message-ID: <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, 
 "Michael S . Tsirkin" <mst@redhat.com>, Hanna Czenczek <xanclic@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=jemoreira@google.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Apr 21, 2026 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
> > While starting the vrings on SET_VRING_KICK could solve the state
> > machine issue, it still won't notify the back-end that buffers are
> > ready (the driver won't do this). Non-polling back-ends depend on this
> > kick, especially for queues where data flows only from the driver to
> > the back-end. Most implementations likely attempt to read from the
> > queue only after receiving the kick.
>
> This is an interesting question to clarify in the spec.
>
> Stefan

This is the question that interests me most, to be honest. I'd rather
have the discussion about when to activate the vrings in a different
thread and keep this one focused on whether the front-end should send
the kick or if the back-end is expected to check if there are "new"
buffers in the vring after restore.

