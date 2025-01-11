Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41FBE7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 09:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWXq7-0005g1-Fy; Sat, 11 Jan 2025 04:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWXq3-0005fs-Tf
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 04:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWXq1-0006CL-NP
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 04:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736587880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1/wH/5fKdszX346OiTjW1PvYq6zDlZtFeBtOaIb4d0=;
 b=QQYPetAOz2XwHpgecllSbUca5zIwsZ9PlQkNh/5rcIYbih/ReaiXQn7oFR6EUpq2CeWoN+
 h6D4toKyoqd/N01BcluRxjdhyAM2dqvkHvR/BmAvLabnPeZ0o8wwxHlUkB4guVIKIfV/27
 8NgbTNbvB5il+l00DRHlKYRmmct6hfM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-MwVbTKdKMlGajL_XPedgWg-1; Sat, 11 Jan 2025 04:31:16 -0500
X-MC-Unique: MwVbTKdKMlGajL_XPedgWg-1
X-Mimecast-MFC-AGG-ID: MwVbTKdKMlGajL_XPedgWg
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa68fd5393cso314596466b.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2025 01:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736587875; x=1737192675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1/wH/5fKdszX346OiTjW1PvYq6zDlZtFeBtOaIb4d0=;
 b=SqU0+cetQBwjVFMyfmtaNtzUa33lHSqPiCaTuHcKYopQXx/9imKvOslsK+02aFBzDN
 lOvXA7PX3bXT0O/QopCY97htwRlVEdnQvIJ/ctJel9bizYsso+1CuibxjLBZ+Wwr1DV3
 xouCCC8SouA5V7a/UUwzQ/rxLWuOJIhKdGD8pTqHhbFErXn9ivNf97Hro16NO0ZcmCIp
 LwcHbNr6PpTOGkFypqaVFfxkw6cwSjKSitk3tz0WPpIbwjnr/QwrjJQDX//UJgfENYpw
 JZnxNpasaaODTDIa7E9awwBqbztDUFoH2L5a03h0TCBdlxv3kO93oxZaOmiToRilnHLX
 BXJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNoTiA+Prk33w0YLA63bNMaEGxhJS5xaLtW1eCUUyQXRJ3zI4auEXctZB/V+xOqO3j00oRa5zN9ep3@nongnu.org
X-Gm-Message-State: AOJu0Yymgkv9Ngw4siK3xiKY2euGbDFMZOKM+Gcf4fHtKm6mPE2mRzhM
 b/358zIbZTrQh9O1V4JZoQeLg1uta7G8CatyRLPC65jyhzgorY0xAI+hp11lan6BqtoVgh5Oa/D
 XnmHTmMlQMwGJbySixK1+fKyAdWgqG7TXqK0VG8iaUs/3K2c+j4ArLUK4N8d39PyKwzND6sLdBG
 jwPKb63JdnLBICrW996ARCpLMKMLc=
X-Gm-Gg: ASbGncuvzUIVdwf5AtORNHrpEyCXY+n4MKpLnRPaz52aqoU++py9B8Fz0V+8sJeO6j2
 F9vi5v324ZGm1nCq0uRZdwBFB/O1NQ2z8aDscvA==
X-Received: by 2002:a17:907:7e9b:b0:aa6:9540:5714 with SMTP id
 a640c23a62f3a-ab2c3dab0a9mr820898666b.25.1736587875204; 
 Sat, 11 Jan 2025 01:31:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqbFN5vk2SWAfsjGte/vW6kaFbAJSVDzJoasw253LdFjUgDjaCX2bSu9CcX4YzR+7ZF6efuVGd7HuDg9FFEGU=
X-Received: by 2002:a17:907:7e9b:b0:aa6:9540:5714 with SMTP id
 a640c23a62f3a-ab2c3dab0a9mr820895666b.25.1736587874326; Sat, 11 Jan 2025
 01:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20250110104619.267564-1-anisinha@redhat.com>
 <20250110104619.267564-2-anisinha@redhat.com>
 <345e6d53-04ef-4c5e-b940-05c892ed87bb@linaro.org>
In-Reply-To: <345e6d53-04ef-4c5e-b940-05c892ed87bb@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 11 Jan 2025 15:01:03 +0530
X-Gm-Features: AbW1kvY258y9EufkqNU5xnQS5yuexRXnlYqwZPxKD5-m4jlE2SSsTUQ8GFp9G0Q
Message-ID: <CAK3XEhNeTGWWKZnU60uYFmQJN6c8_eZ0ZAVJGz_NeeeE2U5iEQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] libqos/fw_cfg: refactor file directory iteraton to
 make it more reusable
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 armbru@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 10, 2025 at 9:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 10/1/25 11:46, Ani Sinha wrote:
> > fw-cfg file directory iteration code can be used by other functions tha=
t may
> > want to implement fw-cfg file operations. Refactor it into a smaller he=
lper
> > so that it can be reused.
> >
> > No functional change.
> >
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >   tests/qtest/libqos/fw_cfg.c | 62 ++++++++++++++++++++++++------------=
-
> >   1 file changed, 40 insertions(+), 22 deletions(-)
> >
> > diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
> > index 89f053ccac..b178d0b1b8 100644
> > --- a/tests/qtest/libqos/fw_cfg.c
> > +++ b/tests/qtest/libqos/fw_cfg.c
> > @@ -60,6 +60,38 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_=
t key)
> >       qtest_writew(fw_cfg->qts, fw_cfg->base, key);
> >   }
> >
> > +static bool
> > +find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
> > +                uint16_t *sel, uint32_t *size)
>
> Please use QEMU coding style.

btw, checkpatch did not catch this. I suggest we also fix checkpatch


$ ./scripts/checkpatch.pl patches-v5/*
Checking patches-v5/0001-libqos-fw_cfg-refactor-file-directory-iteraton-to-=
ma.patch...
total: 0 errors, 0 warnings, 78 lines checked
patches-v5/0001-libqos-fw_cfg-refactor-file-directory-iteraton-to-ma.patch
has no obvious style problems and is ready for submission.

Checking patches-v5/0002-tests-qtest-libqos-add-DMA-support-for-writing-and=
-r.patch...
total: 0 errors, 0 warnings, 178 lines checked
patches-v5/0002-tests-qtest-libqos-add-DMA-support-for-writing-and-r.patch
has no obvious style problems and is ready for submission.

Checking patches-v5/0003-tests-qtest-vmcoreinfo-add-a-unit-test-to-exercize=
-b.patch...
total: 0 errors, 0 warnings, 111 lines checked
patches-v5/0003-tests-qtest-vmcoreinfo-add-a-unit-test-to-exercize-b.patch
has no obvious style problems and is ready for submission.


