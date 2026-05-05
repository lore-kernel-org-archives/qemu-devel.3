Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C90FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 14:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKGzu-00052W-Jd; Tue, 05 May 2026 10:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKGxp-0003hu-Of
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:41:35 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKGxd-0005Fa-4A
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:41:32 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6587cee8b57so5921299d50.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 07:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777992078; cv=none;
 d=google.com; s=arc-20240605;
 b=kvKoRQ8WRMiZTfmBe4G9laDAKfaGHSQdr0KGAnK1JFL/1kyB82O2GNh9vo5kHjrXqv
 ppcQxcwMRK9WkwOVzuBaIowOetwnh84Y6yFC5gjlOvFeB47vN1S62ZQ+UjTkLY/cKEZ3
 CnH1iiM4UTYZed7q0J8Da4i254P0onohVTKeMALjrWaqRF4hyjCfeieEdIoi5RN1Y6X+
 5GJ1vxHQToU0NDYB73IQqkLDEP2WD06IQTEzLDolfR9SMcRqYB8fWBvqmKV+PyM+Fvvd
 syjqKSPPDuXUv11/w3DTDlff8NqDByNW/agCTwIkmYuyEmNqwNVZLguMVdscmRKT5xkW
 MOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f2IcNbqyjB1DTx++eb6ScHJC7s/SOOYZAKcNqTGF2nU=;
 fh=+1firF9KONN4Yc1L4UE+f7hjZIqv5yKMPW+CbJoXUyw=;
 b=KfZaPhi+cWmYhCfOoySqNjoeuC+mqO2sg22QZmNEPdEoVvNR5UupGjqM9Q3f5CwMrn
 rlCfw9UaZDBylXd6MAKYxgX/q2msCYBWtZ5H00JdyHrLZGmQN0/CgM1iwluqDt59d/ov
 mj4yggekDeF3Yzzkqb+tnnp0lWfhUs2yMe9O7Y5CperR0hZg/1mfUJVZCjl9y2ZWXypQ
 XjCoPIeHQTTrEMEwItuU7/8A2xOF+NGoQ4V1w2BecvGgsp6It7SUvO2vha24qvzkxlFQ
 yXMP/FYN45gxmAuTTI0VaPe3zCyOZNaAfWOFp6qHIGSFuawyldWkW98DyBS7gFxMPYwd
 faCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777992078; x=1778596878; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2IcNbqyjB1DTx++eb6ScHJC7s/SOOYZAKcNqTGF2nU=;
 b=BOrpQwmhvougWcFlY3AEAluriyOF8si3tNnzJeWWICsJVOgf/Lezi0/MWvMMGxfeKB
 HBrla0ScQz0zBvoyOZ6l1Gb9l9ooEs5tl0mU79O9qFrKshEz3hDWV0WMmMUVDgCY/mtt
 ugSsa+ER64nYX2jmx+dOvWKMWmpo3sAz8BUxHw6syDCHZarjwaqxlA8LmPYC36n13gwr
 hul0iDTXwvxwgGJRzxkwhOKzrlY3hnclB0lcGVQ8Ha1Gar2GekNEYfrESW7kPprggL1u
 w5qkZOoFRKY0n/5FLPWiCpU2aCq/eIUCHhoB1SOwVwZcjAb1KUeZP2g8fx00Fo7IqRmx
 SB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777992078; x=1778596878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f2IcNbqyjB1DTx++eb6ScHJC7s/SOOYZAKcNqTGF2nU=;
 b=g/PvIzIqO+0h0n7rDe+kIqXb8ctxYOQ1WFoi4hNHLF0vjD2j104C1XOOSg6t7j0T92
 +zt14E7iHv/9VfMJYYWxlNs61p/XuqUYm1RTYAcR3anexnAQsJ6IIHel+IxSOi0qPJWD
 5p1cprvyyfWlf7uJG6fL27O3LP/zW/MuKLO+ByZCCVbuPV8ycqDZbH2d8f+NDVjjcUpo
 qoc+cD71pfdRey/gmdvDS9oPaeNHXYys8sGMH04Q08rimmlWOYe8KgFca5UmyQkXfs2V
 SDNZRtexmhTIVwIa3fFjJslpIvnxaYIMXg93TRmo3Vg88toqoK634u2qKeEaUusHKgAC
 8apg==
X-Gm-Message-State: AOJu0YyQLT02AewPb2j17VAEc6KHM2fb/lgKZUVRsGG9jtgaowkZrrlE
 EW17aZiUrirSyxjsOvmt/vCDD6HspSubpB+KnZ1TYbAniYD2q1JwXKVLrih2DejhG2ro0d9IWir
 m1CF7KpAmwvhdLtuyqgCo1Y5EE9FwAwyq971Np58ydg==
X-Gm-Gg: AeBDieu2/WoGj0R3ya6XyMVKz0OggSreFtz4IKEIL5zafJW7pDO25BOsjWhONsAMnjj
 mUFZSTvsfERYbPpGUqXIPjLScRp3SyEEm88lRBfv4XUyF2AiAEZXX7pX6kgh5fmUUGz9ANH8+HE
 f6lBVonCq40EgquV+FrHbO4rUTHUKDnVd434ockB3bPS0EQQrJm5PZHvKlCTBiXRlhfsZnztdPY
 mBk8coF/n07e+vjKv0buRAKzTCIEN24oDurw00E31jUrBVk+A78I5J54Yt1duho82MwVfCHd3f1
 7LWsPb7hvhrc1ICCLKc/p+wQDQAb2hQe3TM9qtHgdq/ZUfncG2TVdHSyM6uBPFeqbmU5fFjXs41
 jdQ==
X-Received: by 2002:a05:690e:1697:b0:65c:67fa:b42b with SMTP id
 956f58d0204a3-65c69c75effmr3530786d50.7.1777992078329; Tue, 05 May 2026
 07:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-8-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-8-ef7e3dc94f7a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 15:41:05 +0100
X-Gm-Features: AVHnY4J0MaPCn18_eAvIqe-ZW-dXXkQbSbRCCuus58z5kN7WQZONlpPmkR-dr-0
Message-ID: <CAFEAcA9PWJOtiw4-iJ0GZs7=3ZnbH1RdH-GWXi2hFA1jetcOpw@mail.gmail.com>
Subject: Re: [PATCH v2 08/46] hw/xlnx_dp: reject NULL 'dpdma' property rather
 than crash
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 4 May 2026 at 12:38, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The type-checking macros (XLNX_DPDMA(val)) which crash on NULL.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/xlnx_dp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 50e6ef10984..876cb3d6642 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -570,6 +570,12 @@ static void xlnx_dp_set_dpdma(const Object *obj, con=
st char *name, Object *val,
>                                Error **errp)
>  {
>      XlnxDPState *s =3D XLNX_DP(obj);
> +
> +    if (!val) {
> +        error_setg(errp, "%s cannot be set to NULL", name);
> +        return;
> +    }
> +
>      if (s->console) {
>          DisplaySurface *surface =3D qemu_console_surface(s->console);
>          XlnxDPDMAState *dma =3D XLNX_DPDMA(val);

What fails here? XLNX_DPDMA(val) should handle NULL, as mentioned
on the other patch. And xlnx_dpdma_set_host_data_location() checks
for a NULL argument.

thanks
-- PMM

