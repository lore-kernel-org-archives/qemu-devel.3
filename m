Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666C4E78D43
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMgy-0002Py-69; Mon, 09 Feb 2026 03:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vpMgw-0002Pc-4y
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vpMgu-0007j8-5Q
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770625937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Sfm5S2nI/vExICBiQR7bS6ovPJwscAiJVlhu+EK66k=;
 b=Yzw6LaEPLUU4ufZgBJ5SDqGQ5qz3/AG8tvgngvGrL4Pd+w2aYANJv0FwFi5CULlCC/4uHr
 psUyj1zZ2CNjATO+axJz7gkP71+6R//G86l4oYIOc5dU9pNdZld9tQeBhbbFhE0RXVQIIA
 JCPx5bvmrqIXt/6omuYSeQJ9nsstl1E=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-FyQ-rXAsOL6muz7rLvezPw-1; Mon, 09 Feb 2026 03:32:16 -0500
X-MC-Unique: FyQ-rXAsOL6muz7rLvezPw-1
X-Mimecast-MFC-AGG-ID: FyQ-rXAsOL6muz7rLvezPw_1770625935
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-79620564c62so37417357b3.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 00:32:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770625935; cv=none;
 d=google.com; s=arc-20240605;
 b=IFnv6LzVuKxY6LpyUx3Tjj/11nQoJo75GtTBYpCDbbv70Vv2bRNrR0xf52EvE10nZn
 2x7yfc3z4w+w8djXoTz35GCuwyQ63p8irDKQUMGQUueWHBakDgFCSuf99URGUm3/NgUT
 hSr6E+Zgip7rTTqfMi0EUPULwEsieOoI6YH546Hr3MzQHFlaqeWF2VBjArG1pZyMBjm8
 7YTn1ud/rWbibVOvxNGwMiiVX9PmAKTxV+YoW7UueWAyXMMA660DgYjtuzLKz70yFIwv
 Jxl51IU2hqyWnbv0yfl+q+Tc115Q9/fpZmXuiRuNeA/nNA08eK1MPG8bH7zBrg3rQM7C
 PvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5Sfm5S2nI/vExICBiQR7bS6ovPJwscAiJVlhu+EK66k=;
 fh=kI0MFW9jLDL6Y+9FO2sdRFG4/OGexWUGq5KTpKuYhA0=;
 b=J653ReeyfsEha4EaTjGhdKQEngOyCtr4LtBIWna+hfc6GP3uqm4wln/wmRLVer02lh
 m8IQTVvCv3URbtFWkUNKgG9z1HtTtKnevNpRlkJvyT83Ze4G3Prk9Uotez2oKfXKfYlW
 NrR3yqqCI7lAOqFHHMLh4oSBjmihsdtOydLDanARG4ngphduSHS/EBmRBOjx3+uILMbj
 5WAdLPeTsA5EfB2GNxeaMT6B3DW5Fl7s/p3d+5nyFnEkcmeJUn82mgfCoZ2fvMABfH7Q
 Sj3np2Gkincp5xcwRCvdjCSRpPq3ck3NINHj+V8uExTadaph71OnVdxIIvGHTMVTubbj
 D33Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770625935; x=1771230735; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Sfm5S2nI/vExICBiQR7bS6ovPJwscAiJVlhu+EK66k=;
 b=g4F1FGCqe1KCyiTr4Er7KGlSn2IKQI83RJMzGhb941PWl+i1gcSktANUp6VfklPurj
 2aYpg3Odgk9pgRJf4i0gk9XvTYxfhBI1q9JW1FQqaCMIz/a1Xmv+pfZ2RpxCB3DxzEuO
 44yRFg+vt6LcjZUSyoOb4r3rJzUH3uwq4QVnE/i2bEztZBNtyr1Hj50K9t30Bvl2Sm0R
 /JO/f4b59VoRy/jdMJFfRBLp2BOXfH4yFIpNOgbzx1+VUDxmQ64nUnpZgk0BoGo60KdW
 56BDqvq9A644/wGO5CLLGLO1XTAbmkDZ8HQ31mSlXfbr+HfRiQH5o/Yx53IzApe5YXRt
 A8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770625935; x=1771230735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Sfm5S2nI/vExICBiQR7bS6ovPJwscAiJVlhu+EK66k=;
 b=KFI+DjKWXgFzYqiVMtcKyMug2lPgdVQsxdejU1ROgktrEG8lKyjAJuW9lIycrF6IIb
 Gxh2SMJ4aPgh6rRV3JU7E0awSfQp+u69/CKE3WpwJXckRAd01pT977kSZWT4exZWJ0cN
 Beikh8nl0qonuEEBGn0fpPMPwmMoUtw/LYv/9Js+CrnLXOIdGaJ7a4ERGAquEqy1SwZX
 7q2qbcf0KPE/Ls4ZqYKQW7WASbV2iyI1so3Vu9mgDUwNYbvDlDLyD4jA2n/09GyK07DU
 tmOCnDq2rMrhrpl+K8tSdNvNEptzU6NQox4cmLbPZD6GULOCi/7WcQO39kJJiEUxFDWI
 St4Q==
X-Gm-Message-State: AOJu0Yylne/xmyUfxr8emATlKhV12ATNuytnNrifM40rnRMLDE8ezKf1
 xEr56KxeZSWGOUc1b00HqMHMurcUIFXvo6MgLNMRblE/iNKQalQ6VWB+odXOeZfBKGque/R4OWJ
 FPsonajCz+iEdeCluakxC6IkC3xQyb+4jvrnVwPussLcSRtUOUI/y+IzStYU5CngIVNP9EhV4Y1
 JxqPQBZvUfbhWfjd7WD1ay2QwNlUp3NhE=
X-Gm-Gg: AZuq6aKGQjhocl+cZRgT4Xp77reraS6SYj24rowoEbx0Q9GhHRYiV7zJ4tu0n9ch4/W
 nedYYSLlyp+7GWoQLmtfBpvrmkmoHEXuU8822jkVvGRBZmne/NY6H8jDlkVoW9vGHzAwZb3fNLC
 SaHAzXWuTdS+V5ht9joUUjhdZwvUinESjzu2MzWIrOgfv5q0dnaEiM5f2p0BUzQA==
X-Received: by 2002:a53:b68b:0:b0:63f:a7dc:5661 with SMTP id
 956f58d0204a3-649f1e67b17mr6949200d50.12.1770625935583; 
 Mon, 09 Feb 2026 00:32:15 -0800 (PST)
X-Received: by 2002:a53:b68b:0:b0:63f:a7dc:5661 with SMTP id
 956f58d0204a3-649f1e67b17mr6949190d50.12.1770625935191; Mon, 09 Feb 2026
 00:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20260204093758.1250167-1-aesteve@redhat.com>
 <20260208121818-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260208121818-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 9 Feb 2026 09:32:02 +0100
X-Gm-Features: AZwV_QgR_ZHV1TrEbzhSXwUuzpwCY63Xr9W_hFxjqMXG5n6A-n-q-_kljruIXx0
Message-ID: <CADSE00+KxdxGuO869CnQrqWK7ZhyNmUCSqikDCghoPevAr6XGA@mail.gmail.com>
Subject: Re: [PATCH v12 2/7] vhost_user.rst: Align VhostUserMsg excerpt members
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, slp@redhat.com, hi@alyssa.is, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 manos.pitsidianakis@linaro.org, stevensd@chromium.org, dbassey@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, stefanha@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Sun, Feb 8, 2026 at 6:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> thread borken.

Yeah broke because david's email does no longer exist and so had to
unset auto-cc for R-b lines :(

I sent the rest in a different thread here
https://lore.kernel.org/qemu-devel/20260204093758.1250167-1-aesteve@redhat.=
com/T/#t

>


