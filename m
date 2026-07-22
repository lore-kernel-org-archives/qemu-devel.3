Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2A2C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmUqc-0008Q9-7C; Wed, 22 Jul 2026 07:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wmUqb-0008Pg-75
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wmUqY-00043A-To
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784718641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QEbc3CpFQ1PPCLExeK7MkMzZrEkYFgHC1uQKWvOBDWY=;
 b=cZYymrJ5OxzFXhrZx33ML7iqejF3h234mjUvqewF0cru8ffw9ciuNCugajn3XdwXR4D1Lj
 ooPO/MPfW91lg23/hgMf/TN55k9Y8igKZzeyg+xrORA0affTnPFh4AAfIBJ6nElfY+ftGC
 UhZNK6PwJCsAREDmK9zlm0csf5zf/e0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-Zw3VqOP1M4eICa7TJMrFVg-1; Wed, 22 Jul 2026 07:10:39 -0400
X-MC-Unique: Zw3VqOP1M4eICa7TJMrFVg-1
X-Mimecast-MFC-AGG-ID: Zw3VqOP1M4eICa7TJMrFVg_1784718639
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so4905478a12.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 04:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784718639; cv=none;
 d=google.com; s=arc-20260327;
 b=puAP5qAKan+VVM5uf376qYiYO3GSBseo0hRNMZ/TCF6UhB4+fLQD9jR9fQc4UVemnb
 7iHt5l6lPuCFgZRWBxrN+YOsl1DyXJ6kc57+/kTCBc/oRY3odvA5mx9P9FbcWiVot+P1
 Mkf90ajceISnEuxct3CAvI6b2tn3V3ukEtjC84OjsJZrZWz3iNmw6HshRzn5wTw00s+r
 Nd3TYSBh+bMA1uRb5CKtmnbLJ9OmmOr6jDDj61iogAYpJ9+p7XkpKDjU1TimArqq4TQi
 yFe0jvCIfwOaFKkLL525/X7XBgcYO40ZBo4UgXmOFTZ4IMaOUTb21/q85QN/pQw7t+wp
 nA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QEbc3CpFQ1PPCLExeK7MkMzZrEkYFgHC1uQKWvOBDWY=;
 fh=XeZOgne7iH5XYhdQQU/OH3guajGL76tH0mUZpv9EfpA=;
 b=SVKx6BazlQoubNXz/PMF7fLnKWlE0F8MGuRHR3dV2azDOgvGOGyRVBNqaCPofSSvvX
 kL4vBKeD/8lTFvz+dt1RtNgPoEHjogP2I0ZnFiUxCnpxAQQWgTJrBAJJI/9UqUIkPpPP
 JhZ4wPNH0oktduRBRLeGIT06EBPeCdlOGuNe0Jd2st5kkvCuBUp0cc4W93VxNeLQZiob
 gwHK0U88Y1PlVtbtQxpCC9Fv+V5yo7hvdEQnqu6F7yPi3c0RTQi0jtXZ/cKtOMYwsbwu
 a5gbpfjW0dz4i1v5Ky3VDut2dPAEci/S7VNgE157llRAiTG3jQoIrCPwBhMKulvPbhcp
 OvQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784718639; x=1785323439; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QEbc3CpFQ1PPCLExeK7MkMzZrEkYFgHC1uQKWvOBDWY=;
 b=IhZQE6o5gLV6nCywJB0aaCR/1hjGkYf66i84AoWfMGJ78+/qDYusaFKgNH147wGsiq
 x9UyeC9FFYVRJ8GAg+XlvKEqVWU9YlNAkb8kmR+VOCE+3SKPhfy5MLLPxr2XyCkANQdg
 z4G0SjZsqbACFrMJ+bBQ3zdhI/CL26FkaUTglvwutnCtDWNb3mJ/HXyqKj+7Gcdaxc0r
 m2335rcnk5wlHMJFmkqvAS/yy5M6ZowZsHhGF3LonGV2nspDLWmO1qqTvp/xVaJqQyzM
 dN2g15cE+u6YH5vJJJ7JKOaHilEFivjgQ1RldZhxnKh/XqEjpS9U5/J8MzKTMGCQZY4P
 lUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784718639; x=1785323439;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QEbc3CpFQ1PPCLExeK7MkMzZrEkYFgHC1uQKWvOBDWY=;
 b=S/hWEw6JpTtWJLfwbDeHVU87HACMi3Lwq8y/TBzV8JhB2IzZxtj5TMNBRxCkkw++v3
 aYkALhSCed7eyud6O53zop7IaHmJ58ULoHmGa7uqstZSIlhLw4KTARqgQtMVduj7aIS+
 ZftcBui4rSXH+1dsPtHqKaVAGpwgLurpBzpMvQI4nt7Sq+wR+bHAW+yl0qBUIyhDVKZk
 FExTkz9u2Z901Frri1clBnyFV+59u2REGmiX2hrEZ7bNbGiYiwQbBVWX6pjNsqSFQu7C
 gmLJlB7yOgfZ4iy2Yx/LdFQ0FJc6RJUJUCGdqVToN9xwHCBzP2hYYNcl1/AQEi9vASS6
 EwfQ==
X-Gm-Message-State: AOJu0Ywv1Gpe8kj9/XoqWEIvRwPBjpv/Z97fWl6A9MADAgaDkYcy+5N8
 j9fSX9Ak8+Bg90eFB/mCkqHuQ8VIChM774LzMd0/ZCF81bzZY6YIvlbaEbMz6s9zxugiVIAy708
 Q9qOtboH56L7dbv+yvZYIWGgrnuelrSCbjFP9cmSplog6HAgR34LNR1nLmEPhY+7YoNDkzFKvMi
 go8b9rcEjWI1HqLgQzzGr2NPZ2T+fhGhQ=
X-Gm-Gg: AR+sD11tuH17d8DlxZammIqaXx2YvUA2bCD5FcSqa4mCZHaH9aZXlNaKg45apmGrJQC
 KPvBko+wwHkV2PGykASgRvvmo7+eSiGIH4UxCSUem6Q1DcBpZOZwy4QNtRmbAbAnbpfoMJHONyb
 jC/JSDM18MENSvFLr/1l3u/yonsNzD2sZt3yQcPqxznh3stD3IUDXQR6OVsuzUjGJtd/QEWabHr
 lNdgYJB0K0jNIUaUhsFL9EO9jvubRqOgZ3b4Q72YuaI97PGROiR+npL3aSgIUmZMJk9DC3eqHT0
 Tw==
X-Received: by 2002:a05:6a21:c14e:10b0:3c3:bf10:419a with SMTP id
 adf61e73a8af0-3c3bf1044efmr20102415637.71.1784718638587; 
 Wed, 22 Jul 2026 04:10:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:c14e:10b0:3c3:bf10:419a with SMTP id
 adf61e73a8af0-3c3bf1044efmr20102388637.71.1784718638166; Wed, 22 Jul 2026
 04:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
 <ag8yBA7jpCo9dYR_@x1.local>
In-Reply-To: <ag8yBA7jpCo9dYR_@x1.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Jul 2026 15:10:26 +0400
X-Gm-Features: AUfX_mxpQu5__smB8QJULCuNGTbbW-00dXUdJygGM95v3zx0hmeGOnUKRwfWp1g
Message-ID: <CAMxuvayB3ywMQqE1rE0M4sKLLg5H0H8Mh69r=AcA+wwfQqT28g@mail.gmail.com>
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=mlureau@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, May 21, 2026 at 8:25=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, May 21, 2026 at 06:54:51PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> > (inherited from memory_region_find()), but both SEV callers were failin=
g
> > to release it.
> >
> > Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

If nobody object, I'll queue this patch before it is forgotten.


