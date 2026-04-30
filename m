Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4614AFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITdQ-0000uH-7I; Thu, 30 Apr 2026 11:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITdJ-0000ti-0M
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:48:58 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITdD-0003zR-Tv
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:48:53 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64eaf8aa893so872224d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777564130; cv=none;
 d=google.com; s=arc-20240605;
 b=IfciLnEFOZmQvch64XU8fILaKb4CTS6t8JSrFUE7xssJz6gg4mxI6m5p/5DYk9Ndq1
 q0OQ+ww3RNvHa6eELW8NDEFuXN5QLOU9bPVoJHC2fP9Nx/Kwgprhm8tRxDG6UDNTs3X1
 wLxEr9LbGEKSl+rbgrQIKZXqqMFhtLDMtsoM/lpSGEwpZEchr3UM0TPHdYK7mGjz7Fc6
 fyTC2yBT6o8FkHKF02rSHrXZVipJYPIIlEPjpHZarx5kO19WARXvwN4YJ33uFu0y8AaV
 rgXMByTiqT98bih98a3KiRWcHNtiU95dznONRR34Vx81qveRe945BA25VJkIv8HR03Ot
 3koA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cy+FrtKdiXTwWMcABDhwFsT4sxdsP6UzaGrtK70XbD0=;
 fh=TY0pstkCkk7axbyimUXQMiBzpNM8x5gBc3j5ZXXNigM=;
 b=lAj0jX0+UbnnxvsnHSBgWi0Z3wK/HvVxbLW/jbi3plO3tseB9TrV7MrzPPW0WAt9Im
 werp/ElpbKyeX3PTmE4QXwbcgC/Z9u5m59mAFH5Lby1oW7HEsPKhoRzUieeJsYCOmWMa
 NkLwmYNYETAixC6+2kN+PIPm9TC5VvI2ocbGkGrpX/ippFkEaJ5mKhbhA8uR9CQtLfj4
 +3E3eaUhPIcKkSnzpZHpegoyIHo5n61JcBKb7BThdC59fCa6liGKtdsqi0FwyUgPvnRF
 LJewk9sF9SMvtwmyWWLuaBcn7w6els0oCZo8GH2m3hV9D0isKEyjbTx996Bwyhvmw7PD
 cCRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777564130; x=1778168930; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cy+FrtKdiXTwWMcABDhwFsT4sxdsP6UzaGrtK70XbD0=;
 b=CI0wr/EnltG4Qj1oynZ/b2AxCgiwGyalVmHqR0cn25W/BkqblzvLy0Nz53et6ggAcV
 6/nHFIt+++GGy3OofEnFDUjSUEcCQIui8jJ2tkruE78/IE9cJSsN3nR0BwIKUtzf9Dt9
 2JvelKsQmti23sPrN6RK1NmDoe5x6/R8KExaBdbjd4li6RSNnmMFIpDI0iE3czSxzBfo
 q07OAVd5FS9BtIY0B3UfBnTdJwstwSGao96duxtq1CRTsdk4+cH1kd1feDnh/6UDXESA
 pZ34f939QFlpto8rdSYuKs9CMqt8xy8RWFsOepzGTErMvEwnsbKNRT1+hGDsxzS1OWHm
 jFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777564130; x=1778168930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cy+FrtKdiXTwWMcABDhwFsT4sxdsP6UzaGrtK70XbD0=;
 b=MgJ+fQz3k6gwIfH83So618s8JiruyPG7jRv2kx19+FQ2nUjHWwCAQDutuFlUsEkEjQ
 m308h/MfxdRkjEf9BrCechuQYnp289+DGxopoyHUYw3ovJ+AcRIKXFBNIQFuCZnH03WL
 dMiYxB9IuAjhmfLKqLnFtUM9f8sfl0/lbGK4cBE91BoqweZtP6fi0Jz5ftyUJv4H1h/c
 U0rdItxrq8HLCtKymFRZ2BgYIV+0mVv4vOymQomnlsmrr92eHlp8J3TBO2vmFesMeX2V
 R5VTIKYh0tc9zyvaM0LXdQMLqDIxKNpQ15mbGzzXS1ohc2i2+aj7xFE9E4Iq1BAnj6E0
 GsKw==
X-Gm-Message-State: AOJu0YzRzyfjir5m7pvOo6HmSGz2U3acLlq20qv7DFNaI0BSK7UZ3tTM
 xOAUcFGqCNkn5H/XEHbPErMwzlYdNn0orEKoR3YNr/U+4JYpr3IvuAnND4YjOWfweaTbD1Tah+J
 U9EvJgXf25saDF1gWDy4f2AqDNZZj+Tao/IaK4fCxkQ==
X-Gm-Gg: AeBDievLWMR8sCGbeZxxLtT4qXG7RA+/j7eaDXEjtCRRk0JEJJOe4pW0bT4jPWazDn3
 LIC+x1je6IDVO18uDdjo+JZ7FF2uodhYS/ADPzgKF/zQm0ldR1AqVF/B0tUEHYrPNNABIOxzjBj
 z479OL/IttBRxWVUVXSAwMw+TrpU2QCxRjgYx40O0xvlSu9VRhUbqfmn/1nBdO6AAdTFkv80CQ3
 x+XaAuL/CJX9LV+BcyjoTXJAViV7s/naNEsDUGurpQdIsCcUc/4Lj01XN97hG0UlacpCF8q+t88
 KJIXMPi1yiF6g5X5W9E2SVcQms16Cf8LQ3RIrgsUJUf5oVfYGrXqxIyPvh9PemORo0FJ7rVAKxE
 b4A==
X-Received: by 2002:a05:690e:c44:b0:651:b108:be59 with SMTP id
 956f58d0204a3-65c18f2fb77mr2627563d50.44.1777564130424; Thu, 30 Apr 2026
 08:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-7-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-7-c413f3605311@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 16:48:38 +0100
X-Gm-Features: AVHnY4KCwHwYRmcgHuCq-7lWAsAGFbBdL8GY84dHBVtbAKUtfFZ_h_WPWRtL2_M
Message-ID: <CAFEAcA-Q33zfAfST-4qZNcHSR0r9J_g5RVPz9_Cgbeg=2q0QoA@mail.gmail.com>
Subject: Re: [PATCH 07/41] qom: skip link property check callback when
 clearing link
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Mon, 27 Apr 2026 at 20:44, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> When setting a link property to an empty string (clearing the link),
> new_target is NULL. The check callback is still invoked with this NULL
> value, but callbacks like isa_ipmi_bmc_check() cast it with
> type-checking macros (IPMI_BMC(val)) which crash on NULL.
>
> There is nothing to validate when the link is being cleared, so skip
> the check callback entirely when new_target is NULL.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qom/object.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index f981e270440..c50334b3023 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1903,10 +1903,12 @@ static void object_set_link_property(Object *obj,=
 Visitor *v,
>
>      g_free(path);
>
> -    prop->check(obj, name, new_target, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> +    if (new_target) {
> +        prop->check(obj, name, new_target, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>      }

I think that this would incorrectly allow setting a link
property to NULL on a property that uses
qdev_prop_allow_set_link_before_realize(). If the device
wants to forbid changing the link prop after realize, that
should include forbidding "clear existing link to NULL" as
well as "set it to some non-NULL thing".

Fortunately almost no users of object_property_add_link()
seem to use a function other than either
object_property_allow_set_link or
qdev_prop_allow_set_link_before_realize. The exceptions
I think are just xlnx_dp_set_dpdma and isa_ipmi_bmc_check.
So I think we need to fix those, and make sure the
docs point out that the check method can be passed a
NULL object.

thanks
-- PMM

