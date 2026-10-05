Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2BACA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDm7O-0004IX-NS; Mon, 05 Oct 2026 13:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDm7B-0004HH-I2
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 13:04:38 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDm79-0003V8-6e
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 13:04:36 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c2e7950b276so11903366b.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 10:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791219872; cv=none;
 d=google.com; s=arc-20260327;
 b=OJDuBx9Yq6F8X/nJFhbGJXXTDQ/3gq1GkqyadM2I7cXSHB1tIdAXvTE0WPzARVgpS4
 2e6V9E8bZBMBFMDTc03ntsjhlELjpE6+kOcM68emAT1ehnk60IDfeHSsQ5iBt5S1hXj7
 dkFBHKIL2ZqaA5oELNf7bxKgY5AnN4xyN6E605UcpgH3U0enHd58KusDUwAtOIZB3MsA
 CdsfrbVK6HBrsPImyOA29gyvXrz75/Sop6WZxPTxPSoLLUbtrMIutn9qMm1r5z7w78CH
 Crpoa5MmGlP+1GKqzP+skpZgJyjAHz46WUoYuJBwSBM0KRYugzWqWyMb6iXwKKKy8uTF
 /LaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=NAKoQUOvxnocOw8gpULp0eBDNGtXKM+ji9ThG9wJo8w=;
 fh=IWV5i/bmsnDDiumGg7GH/qn1tjabzJqEv+mL/WiBNIs=;
 b=fewBp0VfqOct5o06elUW4FKp4SgM2HqKKU9RQux0dbX5XM9yeizthgNuk1QdH1cbND
 ucLM/geAsyFl2Ek2ZSJwaFwAED5wUdLnZDfq15NEgnGhHnGaLLhsVKKorSiQi0RkWsYU
 77OuyeJRTFRawhjpSobnpblZzbc5Z5v4MdWuIl/D7iTruKNiE8ugT+RN52UeS7tFCVAQ
 LjD0057T3y5Ecp6gs6obQUa929KyKEJewW+ymKSOZ25TMOAn6HZpVyhzNyLvuA4GFusT
 pX4Zk9/6K6dCB45OrZvtnxUTOB3fCzCXDfNebGbXKSE0tqCYuSpwKQPDaxU4qP9B8d7F
 tCtA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791219872; x=1791824672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NAKoQUOvxnocOw8gpULp0eBDNGtXKM+ji9ThG9wJo8w=;
 b=KeCAEg13xxHPFJP0gvAqYFvu/vyohC+Femz3M8ANGVbZ4+Q/i8Sb11hfyY9rhY6AgK
 oL9BvuaAtLUBWfM6eMgiuGwWC9nti6JI0SmyuSraHbVtHdRDE6KG3VqzpS0t+z2pjTDf
 c5TChhPv7cAeDDQnMXkN08yPEfDjPesVrpuwU4QhjttFI5MTBrRAAeCzZAFRekzAUGIh
 fzIWXkDPr7evggseZPmGoMSn0xx1eDqhE0KPJlYJmY8AMncToYtQhSgvBx2BQMWm5yil
 a7zIMvaFiRFE0byXxBdFDlZ87edq78XBK2buLoKYz+QRXptqs+rP0imrAC1eK+e75YEE
 1YJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219872; x=1791824672;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NAKoQUOvxnocOw8gpULp0eBDNGtXKM+ji9ThG9wJo8w=;
 b=t1ZzP9o6+l/0DH21nDg/SvcIc7Bpu3f14zsv3oxULKAo8NRO1ILw6eodh298M/WJ/7
 4/lMUy6OrVZOG7hN9WfROXbAvvpETLO9c8gY3+MhSOmzkNjOONJ4LutFEHSlt4Pp4efF
 zZjDo/tkdZPOeeVSmK4vslNqyPgb0N3DC2D5YB+/sTzNZw/4B3nwLb4cSrNNDcCnyCmw
 fh9YLGfUoy33eek+7Z5rn7ZsfDJbNnrwMTFsWPC1REgN7HC3dbvNVtYuiQf0Hh1tPuX/
 zZGr9eD/zTqWBDxBwsmW++f9coQPMaqlQDlQxzHpCCHVm2MueToPwlzRHa7pj/aZAHmF
 xRmA==
X-Gm-Message-State: AFq9FYITt8DKb8erV13BPc1MYiYh0cqDzEhG9MI5ynWyepjLZ027uTGt
 8BoFz+XfJRae37aZmNeCjcw/HnylUhcST/YkJimItpEIdW7HtjweVlipWUtF1HjG5ze2KcXk79j
 ehC5ijPWWg0CFL2DdRMdkTNx/h1p8GQY=
X-Gm-Gg: AYBFou1eOEaJ+8xzaM+3FiOaVqKURgx3kA6QcMylZmk5j8zkPzwpt0FGw1SrrypGkLR
 Up3fKf5TdgyEjhtocF/fq67DsiHNjpqa8QpOfzo/guHTPNtscBxrCdy257lrYa2LTvwLknoP3s/
 o6udj3vCG+vAC53D0QdP6ISo17CC4LI3TyoLCqL1L6x6bVmXLP9fMTvzd7xYy3JIXukoEYE8Pgv
 3t8fiywNV4CpAJOs6Fzj3lHLDHyE2tjjPeW5GdYrkKERLd/thC13J6/BS8VSG6UDMhToF3G8sUm
 UJuhiosKdKZ8KCB7YirfHPVNeME0QJKPr1r0hcvm9NOTuBtv+3I435Lgs81atp75fV0=
X-Received: by 2002:a17:907:72d6:b0:c29:519b:3aee with SMTP id
 a640c23a62f3a-c3161574e40mr20852066b.33.1791219871861; Mon, 05 Oct 2026
 10:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
In-Reply-To: <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2026 01:04:17 +0800
X-Gm-Features: AclHuK8ENZFOh_SRK0jEPu37tvuspcw939ajkZizDPlK2UHNqjnC1qL0OLasOZU
Message-ID: <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 6, 2026 at 12:25=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> Ok, but I'm not sure it answers the why.
> >> Could you explain the benefits?
> >
> > Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-binary =
because
> > The following original code would return -1 for some user-binary
> > +    SysEmuTarget arch =3D target_info()->target_arch;
> > +
> > +    if (arch =3D=3D SYS_EMU_TARGET__MAX) {
> > +        arch =3D qapi_enum_parse(&SysEmuTarget_lookup, target_name(), =
-1,
> > +                               &error_abort);
> > +    }
> > +    return arch;
> > So basically assigning any value for the user binary is valid.
> > SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmuTarg=
et.
> > -1 is another option but easy to confuse.
> >
> >
> > For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
> > "target-info: Statically initialize target_arch"
> > doing that, I am not sure.
> >
>
> I guess there is a (good or bad) reason for which sub variants of
> targets are not reflected in SYS_EMU_TARGET enum. We should double check
> that before doing any change, as it might have other consequences.


You=E2=80=99re right to ask, and I need to correct my earlier suggestion:
leaving user-mode target_arch
 as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by ARM
code shared with user-mode builds,
including cpu-max-v8.c, where its result indexes a two-entry array.
For aarch64-linux-user, the sentinel could therefore cause an
out-of-bounds access during type registration.

I checked the distinction: softmmu needs the full system-target
identity, including variants such as mipsel;
user-mode variants such as aarch64_be use their base TARGET_ARCH
(aarch64) for this enum. I=E2=80=99ll keep the full TARGET_SYS_EMU
 value for softmmu and use TARGET_ARCH for user-mode builds, rather
than leave the field at SYS_EMU_TARGET__MAX.

>
> >
> >>
> >>> "target-info: Statically initialize target_arch"
> >>>
> >>>>
> >>>> Regards,
> >>>> Pierrick
> >>>
> >>>
> >>>
> >>
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

