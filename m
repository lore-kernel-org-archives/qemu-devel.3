Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B89CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 22:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzjaN-0003D7-Ff; Fri, 19 Sep 2025 18:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzjaL-0003Cz-4c
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 18:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzjaH-0007wx-Gj
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 18:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758320879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8G05ta62cOL350AVcsLCiA6y0mYETBvDvNk7YaVXCMk=;
 b=XYeg18FVSUdubcBZ+jhbzKVu0/OEgm1ripM3wPeLJA1NVVoSHptx+EDWe2nTM8dOy1Y391
 PHQVONk1Imni2xItQ8vdbIWb22xrmx975d4nDtw6wlqk5RTQNLEozChiggpcNeAlKv/gTK
 zKGc8eS5AOAxV0Xo6o5jyfFJY5RHiH4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-ZH2VlRGEOYuDfi4Zln1lYA-1; Fri, 19 Sep 2025 18:27:57 -0400
X-MC-Unique: ZH2VlRGEOYuDfi4Zln1lYA-1
X-Mimecast-MFC-AGG-ID: ZH2VlRGEOYuDfi4Zln1lYA_1758320876
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45dd66e1971so21511105e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 15:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758320876; x=1758925676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8G05ta62cOL350AVcsLCiA6y0mYETBvDvNk7YaVXCMk=;
 b=L/mLlhsL211qOowN9HI9pxZouTSsIXPVSGse7jUVQ/NTECKVBIKMlYe75k3/FTiPxA
 EHawKPIwxZPGIXW85fzM/ok5mZPfC2+x8tPY0OoGVskW2zxlBqAmS9gzjopaKsgWqWbT
 27joeQJwUEHCFIf6mTPRLnvoKTESZ5tVuOdjq7kwglxrOsu0lHycybaNDaEcSh8YRfn0
 Wh59ChRLkhGeaQb0Nu6ucUxUzkQhBwbiXjOo11EJAbSdv+qvk4AxKQk1Qr65W0RR/7zq
 tlNuPUSh/rd4PR641TvWMDsX/Qj0xVpc9YTAeI3WzttNJrPBnM7y92ZY52nLlfHv+j66
 2DFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdQL3N+MJGZXT6hJnit+B7Z23ZEEyRTsUl6cftatbaM60lJB+nzp+HA3+guRG6aJDHy2SVjzMjMRpw@nongnu.org
X-Gm-Message-State: AOJu0YxTZ3q97ANi0YNISlhKLG6Ak8JwNbAUuD6diMxSSdQDEab7FYiW
 RGCGm5Qv36sf3NyXP3fIZ8dhpfzeQWPrmsnKqQU8ZkgLoqIQlt1h/r/UryJFduDujyJ1zjQJZ0+
 azAflMvClvM6UzVzCdKCaBGw6wyR+zOGbs3VNVOrNteTYohlcJvzOaWeL7okm8xRMfXIXDaUNYy
 /+UyiGZvmtcZcvR+3LZ0XqIC2s9zlrYW0=
X-Gm-Gg: ASbGncsZ2wT687lgSkbzgK9m8Td+ox3g5ryQ3+Ke24yG9N0vbfzAVslmLzPYPtDZazC
 9LS4cX1UzvbeWsb9g2LXd8YrElfd9LzmbGqiDaJzcQqG1MCh0QwVg/Z4nwsCP0IBA435IhI4aPn
 sqNhr1IFiHBC3al6rySw6XzarS7cBAlyUWoTTLBmnsdkKC+RAPcXBYa4dO8/pc/AOKg1F9Pvcev
 61Peg94rNX42uetvJZyR3zg
X-Received: by 2002:a05:600c:1f85:b0:45f:2d21:cb36 with SMTP id
 5b1f17b1804b1-467eb6039dfmr39017815e9.35.1758320876218; 
 Fri, 19 Sep 2025 15:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxHIkdw83pwAJ9blhdGR49GfS1U/G3D/MoXoJw3/e/GCyfRaLc+fU8mGwDU+2ZJsd8aC82nK7p3mWSgT1FHi0=
X-Received: by 2002:a05:600c:1f85:b0:45f:2d21:cb36 with SMTP id
 5b1f17b1804b1-467eb6039dfmr39017665e9.35.1758320875832; Fri, 19 Sep 2025
 15:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-7-marcandre.lureau@redhat.com>
 <4b093127-5a2f-45f8-ba5c-674522b6d7d4@redhat.com>
In-Reply-To: <4b093127-5a2f-45f8-ba5c-674522b6d7d4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 20 Sep 2025 00:27:44 +0200
X-Gm-Features: AS18NWBW3KNK41Nb5CmCJyA_cmh09lPS-uoAzGC16Zl5hS7Ax6cDPgggYLMeoQc
Message-ID: <CABgObfYsFdq2X5Hz9qLdUFPoWuO6ci=WgfHO6dTVAvCGMwZH7Q@mail.gmail.com>
Subject: Re: [PATCH 06/24] RFC: configure: use the same machine as the host
 triple by default
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Li-Wen Hsu <lwhsu@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 19, 2025 at 5:11=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 9/19/25 15:33, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > IIRC, this fixes build on msys2 - although I can't reproduce. Maybe wit=
h
> > some other host, on *bsd?

msys2 should have host_os=3Dwindows, so rust_machine would be
overwritten to pc below. The only cases where this makes a difference
should be cygwin, which is not supported, and wasm32 (I guess the Rust
triple to use would be wasm32-wasip1-threads).

Paolo


