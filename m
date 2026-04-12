Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F93E937E1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBvXz-0003aA-Ta; Sun, 12 Apr 2026 10:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wBvXz-0003Zt-6B
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 10:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wBvXx-00051o-Je
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 10:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776003140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=87rivFTXbcAlMCa/wIjOgA7mONN7ggw94c5OQZp2pEc=;
 b=KV1lJJwVydjtdR8dTLoO2wR0+AWYE//30xWiNbfLmZlKzsgrNWZHEBxu/pSjv0zviNwIL8
 /efnCIZg6JnLLTro9QQByXQ4Z4XYsmr7GoemG2OSDAw5Cd6a1h3DWVI0FxdzKbjfhfCrQ9
 k8FIiPpo5r0bz9udY1Jwmh6cHgzSg2Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-ZZ7WbYyUN_Wi5qZea6s99A-1; Sun, 12 Apr 2026 10:12:18 -0400
X-MC-Unique: ZZ7WbYyUN_Wi5qZea6s99A-1
X-Mimecast-MFC-AGG-ID: ZZ7WbYyUN_Wi5qZea6s99A_1776003138
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35449510446so3844321a91.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 07:12:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776003138; cv=none;
 d=google.com; s=arc-20240605;
 b=O5cj1rPeRwmk6LcT4eWhRgKeIDlb4ptCBWj7pjEBGS+8Hqs/yCi+ROZJXBLAlCgUEU
 WoAjW5VfIy7/ZIyDnbuWFRd4C3lY+zybAFf79VOVKEhrhLNgTV87g/zQGUbWKKa02mNe
 f+iqZaazVK1hSJRVq/6tjjF07rEQprakCM2nt6QgKHZ6xg/qZAhiz4g1pXXuUPNojLuK
 EPSyyTGlhPQXW4cDJjDW/gM7kumYHswgj/VC4e3xt8a9gz5I/KKHX2dQqgmAecpivmnq
 5+DBhtWyFqlnxRTXevnw0vPpm2RKcxMGknFOmfz/wPWiHPiqXVqdfR8M22l7CRSy1Fgq
 CMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=87rivFTXbcAlMCa/wIjOgA7mONN7ggw94c5OQZp2pEc=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=IBMkvS46zL7bmKqoWfjpOYIHWdnMKMG+Rbr32CahxhFuYs1RnmE+br8qgf+xaYgg4r
 cczRtMt1vgf3HEkfgIlGVlbgQmIdgZ1OPeMvgNA2ct5PzG8cYhFRyDp3hHIsZut8aMuD
 Eh9eY0eXPwr0qbfKDE+GfIWFNrs7jSKp1SN1M68+bNxFMY6XcL6N1P/SZQSbFI17sFuO
 KhVw6vzg/RV6wLU4iNYuF2hv9e5qzxxYxk0WzlUjZLC2SJO1CAHmujSSZhSlIW+rT481
 4dsBuvKDOOsYnCFozjlgIulj1dLOyMDClGFPUjF3k4palsG7TqomLXUt02SIWBmV47ub
 LHFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776003138; x=1776607938; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87rivFTXbcAlMCa/wIjOgA7mONN7ggw94c5OQZp2pEc=;
 b=Q3DA94g96RPVlsP6SRL4Mr47rMboI9ZOM+rjXK6JGlYEBWhFS35qcszUtfwZ94zHmQ
 c1vvD4Jhm+H6F2XmnRRQ2rysjSXX/uTzHoQr1N5h+EX2T7u+GiwDHsbTf2IYPDIiu+I/
 HHelTZKo+zHQo7WNUMTXqEv8ZFL+xP/ZM53Aj3Pnfq0RLBNw9fK1aO0hfBtHD1JgJ++A
 xYXliyTHukJRu0YDyTzBmt8JUXBJ7YpgaXqqTSWj8Ay4i7skThNHCZBOhq7fiOWPUzfQ
 dgPOUYRb8dEj2HCSBqdS1LYHZmApZaVEHAfIXpmPW4Mto4vrKHJd8HMEOQEaclrNU9hc
 brIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776003138; x=1776607938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=87rivFTXbcAlMCa/wIjOgA7mONN7ggw94c5OQZp2pEc=;
 b=F9bpnFfMviTuxWqyGLHhKWEHMHYJcEh11/axacdWXXdT6amIO53F7PMj+IeqZZWO/5
 8qRujeYkL0x1YTECSgd+AvAX0opXu2EOZ2nFI+QkU0gA8Dm6MXhRhgWqhGey4XHAu1/O
 CQWB28eT6UVFIpUR5IbMYn7AVaKxUaM9347ByaGvCIOUyloucpDvMctOi+Sza/EJ9OsE
 zBclevLWvOw3QWJaO2D74bFCWGsWZSi5RQ1f1LQm0YUae0CP4DQGUTqIM8L+o98XRF2Q
 ra/WNtK3N/keoiyQ2R2Pw0AEPhoxZfFArh4tf0PFEjAaGbEU2TGYuLVABbTozC8sSieS
 F18g==
X-Gm-Message-State: AOJu0Yxox6zxGaVlakuTVlMBY931ssBDZuqQMTAEbIwa7cNk90/u6Np0
 tOoaYYHCPk7nyUR4iiLng6lAiRMh1E7XVXOZ30dfukgR6CnlHMZGZTH+D2sWKtTOEU5GJDs01XO
 KyMercBAc6T9oJ9agkzusE+KI9tmB+VjSfTtTe/UTdCF1wmKTYgaQE9p7eV0FwKbKJg3aOvjyDP
 dJQF+UaqWbC0aF1VlildJ9+JYDTtlCZmM=
X-Gm-Gg: AeBDieubXwu89W3njGrafaNhNqm2goGwjEWm28oyK4OrwFMdX8ahVJwbNmQtXZxm2IQ
 rEKVG3DKv7gR/RMBlnMykKPPsUuKR+9dVMfo0KzCxfx5evFQ207A8vsGxFNK1lbNdtbnltt8/Jk
 7Y+aQnZSEyDbaZhaVsY0Fzq7efFJg7IhRK+yjRvC6NbIBCk1WZgHJcVZ+Um5M/v7ru9nFf8DN4s
 aISeb9zYfLZXte/T3jSzAWw5IS34d4vgVgqDKz07gB/nhGs4fH0z/CWXho1kVz+IhQgw0n3QsqQ
 MgXoZtJxHIhdTKqRwivZyK1j
X-Received: by 2002:a17:90b:48c6:b0:35f:b714:e516 with SMTP id
 98e67ed59e1d1-35fb714ed7bmr326747a91.16.1776003137727; 
 Sun, 12 Apr 2026 07:12:17 -0700 (PDT)
X-Received: by 2002:a17:90b:48c6:b0:35f:b714:e516 with SMTP id
 98e67ed59e1d1-35fb714ed7bmr326733a91.16.1776003137279; Sun, 12 Apr 2026
 07:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-47-231416f76dc3@redhat.com>
 <827423a1-da0a-4734-a8fd-57124262d1bd@linaro.org>
In-Reply-To: <827423a1-da0a-4734-a8fd-57124262d1bd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 12 Apr 2026 18:12:04 +0400
X-Gm-Features: AQROBzA-SnS37sSVI1F19SCoqXWzDWP8UAiQllGqleXhJVzLOvttKAVpVx7eW64
Message-ID: <CAMxuvazCyj9E1JaHSzjGPb02C3-3XZ5DrbJyJVALJTk0+8R92Q@mail.gmail.com>
Subject: Re: [PATCH v2 47/67] ui/vnc: vnc_display_init() and
 vnc_display_open() return bool
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Sun, Apr 12, 2026 at 2:28=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 10/4/26 21:19, Marc-Andr=C3=A9 Lureau wrote:
> > Use the QEMU-style error pattern returning "true" on success.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/ui/console.h |  4 ++--
> >   ui/vnc.c             | 20 ++++++++++----------
> >   2 files changed, 12 insertions(+), 12 deletions(-)
>
>
> > @@ -4354,12 +4356,10 @@ int vnc_init_func(void *opaque, QemuOpts *opts,=
 Error **errp)
>
> vnc_init_func() could also return a boolean.

it must be of type:
typedef int (*qemu_opt_loopfunc)(void *opaque, const char *name, const
char *value, Error **errp);

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

thanks

>
> >           id =3D vnc_auto_assign_id(opts);
> >       }
> >
> > -    vnc_display_init(id, errp);
> > -    if (*errp) {
> > +    if (!vnc_display_init(id, errp)) {
> >           return -1;
> >       }
> > -    vnc_display_open(id, errp);
> > -    if (*errp) {
> > +    if (!vnc_display_open(id, errp)) {
> >           return -1;
> >       }
> >       return 0;
> >
>


