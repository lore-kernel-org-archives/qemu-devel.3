Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878A1C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 11:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPJHI-00086c-Uw; Wed, 11 Jun 2025 07:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPJHG-00085z-VA
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 07:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPJHF-00055G-4T
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 07:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749639952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aF7LWn17pkhhg22fNCmAQAxb3U/YTglkfbLytrggQjk=;
 b=dhhJZpuS5yx0EDU95OS/vsugysx0jHjrUh4PMFF+ApDSRtZsYLDjc8F/TalPlyWC13t3Bh
 MJSLvFvNl7ew5K56UudDJcDfPodeI59d5GTb2b9BvAOipTWo4r89hEm2hQ7HN1ZQrc0jpE
 h8qhRPvIgTvY+Ll5Dwqz7sH7WQuVN3I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-qOFr8jewMVGFSpP5Sy6B_A-1; Wed, 11 Jun 2025 07:05:50 -0400
X-MC-Unique: qOFr8jewMVGFSpP5Sy6B_A-1
X-Mimecast-MFC-AGG-ID: qOFr8jewMVGFSpP5Sy6B_A_1749639949
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d64026baso40082535e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 04:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749639948; x=1750244748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aF7LWn17pkhhg22fNCmAQAxb3U/YTglkfbLytrggQjk=;
 b=jaO7U2A1b2K1GJXc6kpSD0w3uougOhc3vSZzlhlEDD5B5XuzL7dwKMRZkMqFfGoQ8O
 0W6iDEWDDQk2AtDoqrLUKURC5q4AiOIDAlStCcSA4oPwpb+fw4MdLUaGojPsAB+tGDnc
 K42xkZYlzKmsEDcD1DYBokgar8hyPd501bJcTGRVHH8+AH65bOjRwqxmR5YV8wyHDfyS
 u2Wi/GRZ8qX95pY9yAOF44hHncO+URaOgRG7jIf2eBP9yOaWw0/UAYV913DRkwwX0G/4
 f19fudnZnrROAqQ6O37FXutmJWZbKI7y3lHcpDvbsqnZFVL3tYzFDkxUm0X7EXWn9pBh
 bJ6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+6xbrsBZZYYYvWh5JGm5s4WfzcycfU8PJeP0okCSobnVGkCD8DBMrS+rt6cxOZPxeXbEzOuqNV+VV@nongnu.org
X-Gm-Message-State: AOJu0YywEpR56RWlvPWtTeX/pxhS5AbqT619kuTSeOSFmoDp/nMuuPli
 1oc6NanZiZRKEtAo65QvMG9sSBk/PjGV7brfAB1eYe5Eu23WJAj8yetJ+D/tSXp96ErTNs8ZbRO
 5XyHdfm7axG5MCats8Z3/PIFIJJZCrQQZHttzi1q1XvLiNZPYGgxeVitOTqaylZVr2gA7/oSp9p
 GXKMtf87Q2HH67i+L4kl3a0snWcdAk+O9DliBkuKEBCg==
X-Gm-Gg: ASbGncs4DY5pITgaIkwmrHo4GfyjHDYpvhNoS88YK4Vc3hkvkfKRNfpHecATLm/pheV
 wf9qrGslL475KEBvccP7mNkppKePz2RLpdnLfxMIzJ3bLNHkfcI4KZ046siiYPGP3iR+Cot3q+I
 fUeg==
X-Received: by 2002:a05:6000:2301:b0:3a5:42:b17b with SMTP id
 ffacd0b85a97d-3a5586cac26mr2035174f8f.29.1749639948388; 
 Wed, 11 Jun 2025 04:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqo/U5r7IN+KQsjwCtgoOdkY5TI/BNjAE9vGFM4UAA6LPlNIgj0XiGaASxFbBAWGx0yHGQda4X/5DGZQtrwqw=
X-Received: by 2002:a05:6000:2301:b0:3a5:42:b17b with SMTP id
 ffacd0b85a97d-3a5586cac26mr2035153f8f.29.1749639948099; Wed, 11 Jun 2025
 04:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-2-shentey@gmail.com>
 <CAAjaMXbtcyB3J3AvGh8ZW3MSi41uMaE+TkZwipCs5pg6wvYJ=w@mail.gmail.com>
In-Reply-To: <CAAjaMXbtcyB3J3AvGh8ZW3MSi41uMaE+TkZwipCs5pg6wvYJ=w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jun 2025 13:05:35 +0200
X-Gm-Features: AX0GCFtBBKwf6_WTw-AJEPOpstVJA4JtOOxuTIxppkBOv4rxO49_WvdS7Lv5c60
Message-ID: <CABgObfYgoYBJmZjin_Wj8JeEviFMM+vFa_QX_8Np+1n9apq4kw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust/qemu-api: Add initial logging support based
 on C API
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 11, 2025 at 12:57=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:

> Maybe we could take this chance to remove the requirement for trailing
> newline? Not urgent, and also something we could change afterwards
> anyway. We could also introduce log_mask_ln! macro but now I'm just
> bikeshedding.

Good idea; there is no "formatln!" but I think you could use concat instead=
.

If that doesn't work for whatever reason we can indeed add it later. I
had the idea of a struct that wraps the logging functions
qemu_log_trylock() and qemu_log_unlock() and implements io::Write; at
which point, implementing log_mask_ln! (or _nl! following the unstable
format_args_nl!) with writeln! would be trivial.

> Besides that, I think it'd be useful to have the macro re-exported in
> rust/qemu-api/src/prelude.rs as well. Please add it for the next
> version.

Yes, I agree.

Paolo


