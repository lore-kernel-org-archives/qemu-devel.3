Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E175110F286A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6DO1-0003WE-3t; Fri, 27 Mar 2026 16:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6DNz-0003W5-Gs
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 16:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6DNy-0006BD-03
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 16:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774641744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fupy0qfIfLAlR41+XCwmHe7nB+f8G2ofcRhkBjGSETo=;
 b=NHYMnQ0mHi6fX+AkVx8fnXL7Uvsw+9yJgF8Calv1j7svoLA9Qfs7q3uBGKBCaCMLcXiTkg
 ntDnDNYWLc8VUUWVeYT9+Ym5XhvJFq+UKu3V2RAX0/oGxQzEjxIMEm2QXse5rZZPldGB5r
 NmAWAz05JFswgSP1+a0oGfN7SywFBjY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-E68ngzwfMwC4EWA83pfdjg-1; Fri, 27 Mar 2026 16:02:23 -0400
X-MC-Unique: E68ngzwfMwC4EWA83pfdjg-1
X-Mimecast-MFC-AGG-ID: E68ngzwfMwC4EWA83pfdjg_1774641742
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43ba02dc34bso601165f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 13:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774641741; cv=none;
 d=google.com; s=arc-20240605;
 b=SkdWhODQ2qEpkR4xz8LkFhBc+jRVEmJlunzHqX/T8Fhnm9B6vdhSEq1ztUmXkecdU7
 MnJBpE1IINkiWnqjMrkNG+P4iLH69vMysFA3C0JPARxlauxsXqNc1B5wzOPtATewSqmT
 NP4LNNs4PHITWSS5UGqpf5uQKaFHuaCbvMrY+nVKD6HLJ2gu1Up3m0K4CyT8ZtOiLoZ4
 AEJdqxXE4D9pA2t+1c3xJlLaPWFOZ+p4KPbqBelkLKM8jvumiYG1QJQ5+OPCkKgQDPM/
 hDEuxhamUWGzdf7/V7m0zeWTrUkB0a6PEpm/fDRl4YDCwJnUJpYeiqafx3aWMCQfNKKJ
 vOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fupy0qfIfLAlR41+XCwmHe7nB+f8G2ofcRhkBjGSETo=;
 fh=GjgNRQiGl6kPO04Vpplkzlexv/MeWQhUw+NwuOFNVJ4=;
 b=FLO0rWANhkQI8VXSmS6aKM69Kc/fSOy0fnkSHchAG0T2FcxY59C9arwm9TYh5opSTL
 KU+wJHMGqW4/ixWYbDPIHXC4oNhCrkd3ecvD9n/CadNY6isWe85l7QOuWIiWcxTR1oS+
 sxGBdzkH21cgBAFXeFXZXIpChQyEESow9aKsN1Gnv4WdDLyGw0Jv8bJbbT/SmqY/2Jqf
 8AKbuC/jDzf/tpQ04ohyBA9QIUzaIkyHAB3SBsPFsOeFft/EdsQCTMVaO5nJDb+RPapn
 3pYMOwi0FecdMKAEVfhzvLhQHvHMurldfcoKGCRrOpBva7FRKkVzUjj31Zu8sN1WY1OA
 2oxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774641741; x=1775246541; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fupy0qfIfLAlR41+XCwmHe7nB+f8G2ofcRhkBjGSETo=;
 b=FkMtz65WA98oHFhqH+Y7D30Eo1UVbNb8gtl51APRKm/tJcgw2SMP/spas6r3tXzXVl
 L7eV0ZifQqjLXX7UfVfFYWBrS2V1lCA9WaCrkoZ8w3bPxGC5l3jEtayOOoI+qCWqckgX
 W9eVVw802rxBES5q+0B0vYJOOhOmVFsBok1nfRMj/07SMpFDtIX7vHOLwY2bp6PJR/8h
 F0Xk0MslEC8cGtrGnq1wZjHYOgw8nCVKdjIDEVGMgaLkSgaOsYIPUAp7R62Cyn9+ESmh
 P30fWZbwyg5Ppbt5z5afy5ahrCz3IAKxruefqdDsDbJtMCx2CykONVjTkMPW3WsbnxQf
 8VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774641741; x=1775246541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fupy0qfIfLAlR41+XCwmHe7nB+f8G2ofcRhkBjGSETo=;
 b=LlVJnObqH+TfMyf7bvq0H5q0mcKTMjebJuJLMi5nVlAXl3lscjNhi+Cy7OkMZngXOv
 GdgJO6hLT2GpLbTbYWLdCGqZSWvhdKorRp6zZGiGUmWvwGCio78gh3NFmVEU707A8vdO
 Aoa6OLlqMJJaJJqjuXHcU1wdynTSONeW/YgkC0fFmf7zq1TeyulleN6rr+a1obZ0fxE9
 bHBcpg4UVVFX9uObfMdedtyzF74QXpjFrmtCtZj7fOix0UPCngLPUouzzHmbDvEURg10
 5m4xzyC7ZxaViMv1deCnCA2D4NjPJmHK653u6eEhNJCR2VNNXZcMExNKkeBOvs+J5X0S
 9ExA==
X-Gm-Message-State: AOJu0YziMO7pKzbz2UjxtUY+ekB5/WHw3KmMHIS2kAtpr+aLzTkT8QIV
 dJJwQFZcNDHgXB8LtfmVl2BUQZCcLVcC/K3fV4zoGpiQo9Kigq1wthN3JFnWXsg8nXHeu8sacxA
 ZRwHiIPTdH55FhmxB0qRycK/MjXInHH3VFDA3Jt8vJjzVHxMiY3P245K8Xx+zfLaPhfldEq6yh8
 bYtzuhqYl1RbYs6LvJhiNg1W4fy18aZ+D9Wv3zUlc=
X-Gm-Gg: ATEYQzzRdQoW1PV/0Z4I3vr7cZrNUZAy9Oc1Jlf3f26JmIYL+km0KOa8dF2ElX6rfgK
 0GpFkG4XohoLlba5wn8Py72F1PlQ4yKE9K9kC3Xf9BIyj6po9sgARE3LiFEAkHj9U3SQGERV2VK
 3zN2cRYv3ONwKVWROJ9NbY8zjThrpr/BFUjYgOC1TAheSJ/MdnK3+R0UrxeVKJmqMrIr7P9LB+V
 quo0/KDB2352n8IjA5TxLrGSdb++ApAgptdB3ZhOABJSj89vf9jUma+TaAUbTqDVQfNBfQQV1ma
 99Dm
X-Received: by 2002:a05:6000:22c7:b0:439:be67:a038 with SMTP id
 ffacd0b85a97d-43b9ea62f9amr6879573f8f.41.1774641741085; 
 Fri, 27 Mar 2026 13:02:21 -0700 (PDT)
X-Received: by 2002:a05:6000:22c7:b0:439:be67:a038 with SMTP id
 ffacd0b85a97d-43b9ea62f9amr6879522f8f.41.1774641740635; Fri, 27 Mar 2026
 13:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260327174701.364328-1-pbonzini@redhat.com>
 <CAFEAcA8R0qGsaBAQLgAGRgU1H+4JRpRCa8TaeAcdYo25R=dQww@mail.gmail.com>
In-Reply-To: <CAFEAcA8R0qGsaBAQLgAGRgU1H+4JRpRCa8TaeAcdYo25R=dQww@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Mar 2026 21:02:09 +0100
X-Gm-Features: AQROBzBmuXWx5MC46ms14HFqd3CMKI-jsouAwDmTVlc8x4N1VvpXofeDHX7EKcM
Message-ID: <CABgObfYxPmG+M1t8VakdKiKEkunQ8cyLfoo8dtVQTTR4RtxUug@mail.gmail.com>
Subject: Re: [PATCH] hpet: fix bounds check for s->timer[]
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>, 
 "Yuma Kurogome, Ricerca Security, Inc." <yumak@ricsec.co.jp>
Content-Type: multipart/alternative; boundary="0000000000008def64064e06fa5f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000008def64064e06fa5f
Content-Type: text/plain; charset="UTF-8"

Il ven 27 mar 2026, 19:46 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> > (even
> > though HPET_MAX_TIMERS is 32) the HPET only has room for 24 timers in
> > its MMIO region,
>

If we can only fit 24 timers into the MMIO region, should we do one of:
>  * lower HPET_MAX_TIMERS
>  * enlarge the MMIO region
>  * leave HPET_MAX_TIMERS where it is but make realize enforce
>    that num_timers <= 24 ?
>

Lowering HPET_MAX_TIMERS is the easiest, yes. No one really uses anything
but the default anyway.

Paolo


> thanks
> -- PMM
>
>

--0000000000008def64064e06fa5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 27 mar 2026, 19:46 Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; (even<br>
&gt; though HPET_MAX_TIMERS is 32) the HPET only has room for 24 timers in<=
br>
&gt; its MMIO region,<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
If we can only fit 24 timers into the MMIO region, should we do one of:<br>
=C2=A0* lower HPET_MAX_TIMERS<br>
=C2=A0* enlarge the MMIO region<br>
=C2=A0* leave HPET_MAX_TIMERS where it is but make realize enforce<br>
=C2=A0 =C2=A0that num_timers &lt;=3D 24 ?<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Lowering HPET_MAX_TIMERS is the ea=
siest, yes. No one really uses anything but the default anyway.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--0000000000008def64064e06fa5f--


