Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBCCFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 09:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKCIs-0005Vg-1e; Tue, 05 May 2026 05:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKCIq-0005VY-TH
 for qemu-devel@nongnu.org; Tue, 05 May 2026 05:42:56 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKCIp-00006W-B0
 for qemu-devel@nongnu.org; Tue, 05 May 2026 05:42:56 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65c477a3278so2715744d50.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 02:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777974174; cv=none;
 d=google.com; s=arc-20240605;
 b=C8mC3c7PYoRH9Vs9ABiG6DacWqVjNB7epYV58iiQuYuttE+GBkNAfD5v2Bvo3wIOhU
 HAv5haYPDRv1+mV6w9f0Lkuk5SoQsG3BA6ZPcCPrmoKGR4PO2izL2A1QqcbS71+CvDfo
 6DSPMIRVYsYRKwEZZ1isY5FWxe1W0/9gn1ZCDX8G1b06DSrhI223HsYR5ArlPPEPynxA
 r+lud0Uq+uMiSiNyblPpkUr8bGKSCkaeNz7Gv3fLSUzChK51UUwwmtji7XiNfOXRXflC
 +SxPemn/NoawXdk/da4TzBW9dcKkfS+7IKHGIRtTeLcDgbpNolHldc31FyRRszJaW1I9
 Bo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EpMIoVZg+/06wv3gR4Ki1yS7UMu02TMNy56fj6pWlTU=;
 fh=+1firF9KONN4Yc1L4UE+f7hjZIqv5yKMPW+CbJoXUyw=;
 b=Br95OcIFPjAFcWNJO8fRIyDA77DrwhYm97o9ckQUYTvwwHmuU9ewuA4zhkAmHDvXbj
 fzT1UQUfH6EsF3EZU9PuO9PYkVTZivckEE7ROwHvExnL8WUMwlcnqCuIWRa/EO0Yk3Xt
 qNBDjUfm4E2xXb7RALOxwIGwO0P1n4D/UoEka22348pHRCBFESZBFqgRpygPSHKdTjOe
 WBLWNrU9G9JO+O1aGPNv9HeXo2mrVsF56Cxgcsmii9ijypa70lBEGJ+g0HEE21SuvsS2
 yYsD17UKO430/c5ZY5WfDSi1SyPGHtxTRrlthYJGXsEhnhQBk6Xpea4OQRO22f+UoXJX
 IyfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777974174; x=1778578974; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpMIoVZg+/06wv3gR4Ki1yS7UMu02TMNy56fj6pWlTU=;
 b=fp0FUuKviBWzIHQnMMc1dkDJSe1DvMb7O+T2ck2VZCNgpB2MrzprL3+lEHCnHmVpKp
 GrvOZrzDVUDVr3JnVpUt9FX3bfjq1N9wTroTns0JKXHtjys324nGvVsdBqePrliiLNsP
 BUUSulGegrTsNKzNoXbUtUQf2F4fex91y+0C4KiCSOjeV9g3UqUJmyZGvda8GJiXWYc4
 0Kj9JRyhIBOfDKkcrCndukmWxBaGF2ntG9sKKKA6m5rsKI4XvScTzsXp+X+JDt3ydsVH
 csvlsZQKngVR8zOsbsxcKa5hf3auyr24jPwAuucGjdd+Z/6+BuFFmDCixPiVI46Z6/bX
 T9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777974174; x=1778578974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EpMIoVZg+/06wv3gR4Ki1yS7UMu02TMNy56fj6pWlTU=;
 b=Spmged/Wtk0xV6Tl6QGgraHoaXgyleY4vs+AShdxZT5ZoUcWgrrKh/YlRcowRin3dR
 tLDbSvjG8g8HYSRTWIheko9OHGv/IUQf2jhzxMF8gaiJyDdEHavJHKspq17NfaC7F7nc
 SWQ6JVLvNtpg0tmj98/T4PNAJEMbJPkI2k9qPGvrI9ah6AhsrIoSfiiPebtbcY29A4uv
 B4jQoh03QsshGkiyp6e1mlc2zpdbQ/Bjf2I853zjW7/5CrHfwNMyuGkMQerr4XOBQPsS
 rLx2BzfJdJyjAWjdvTrOKg2IFvlzypyR7QQgARfuQdw8pz522KJ4Z6f/dQxuLKoMgCTV
 eLug==
X-Gm-Message-State: AOJu0YwBSMCcpzVPZIWCoYEioCPkJmZjB3UYOjBoFGk4MkA6hKaDMUmL
 WkVL1+8+C/Js2kYyvcmmJSO6j875UfIBsrtq0JRa7Q74IMqRERvcvOExN/TYxN+UrbGq/EcHhXl
 6KYuI0JKlyXkQDaUTITtBMQ4NRdjS2GN7xgIPoFzDJg==
X-Gm-Gg: AeBDiev7FcytsgBgzcXSG8s4QfCH7bP+PBXN23QPTUpawmCmrKzAIsUlB/JxDzOSa0u
 VvdwgE065O9YNlZOUsIZKBXfng/WX0CaFhgfFrfYb4OiDv+Mx2q4kbfFTJUVB5otg6MX5aWN85i
 ktzW5jHClXe0pcZHec7tGOLbHMthuCDdFvvaBdjOccNbiQi7kJ/d083wdr7r/cM4i+qdhAAtG9w
 a+/pKo+Tu4EA0t7vvez23rdEc6lv98gqImrW2zw4vUNQezVGroR2fKoOyRLUOBt8ZhqWH5n1cOu
 PCG/p44XCZzL0VdU5pYUZhe1GfJxkf9Mzae8/Vsa6pv40N5v3n279+xt8Bc/8PhYZHDzvGBd+Ev
 f3w==
X-Received: by 2002:a05:690e:d41:b0:651:b13e:f9ef with SMTP id
 956f58d0204a3-65c3d9a2bb6mr12305743d50.14.1777974174018; Tue, 05 May 2026
 02:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-9-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-9-ef7e3dc94f7a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 10:42:42 +0100
X-Gm-Features: AVHnY4ISPZ0i2Xyv8sGBJLOV5vMt38CxldTF3Vt_FUkWkJkIYEztqU3Ax_wU-T4
Message-ID: <CAFEAcA_JV6n=QwBRCGD2wVVkG9V8GMz9Es8sik9gTcf=NOxDPA@mail.gmail.com>
Subject: Re: [PATCH v2 09/46] qom/object: update doc about NULL values in link
 properties
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 4 May 2026 at 12:37, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qom/object.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 510885218ba..0a82e160cd0 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1714,10 +1714,10 @@ void object_property_allow_set_link(const Object =
*obj, const char *name,
>   *
>   * Links form the graph in the object model.
>   *
> - * The @check() callback is invoked when
> - * object_property_set_link() is called and can raise an error to preven=
t the
> - * link being set.  If @check is NULL, the property is read-only
> - * and cannot be set.
> + * The @check() callback is invoked when object_property_set_link() is c=
alled
> + * and can raise an error to prevent the link being set. If @check is NU=
LL, the
> + * property is read-only and cannot be set. Care must be taken to handle=
 NULL
> + * values for @val.

I think we could perhaps expand this a bit to be more explicit about
the lurking bug potential here:

 Remember that the usual QOM type-casting macros will assert on NULL, so
 you need to either explicitly NULL check before using the cast macro, or
 use object_dynamic_cast() instead.

>   *
>   * Ownership of the pointer that @child points to is transferred to the
>   * link property.  The reference count for *@child is

Either way

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

