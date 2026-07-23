Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB34DC531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmqDS-0005rO-LL; Thu, 23 Jul 2026 05:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wmqDR-0005rB-Fa
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 05:59:45 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wmqDP-0001ta-UW
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 05:59:45 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so451675a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 02:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784800782; cv=none;
 d=google.com; s=arc-20260327;
 b=hszWY2BuYdJB18IVHSINST5mAzQ2PIgloDpsJWfOwOZLl8iQk4wChyiPDBRBciXn46
 y5rh9jP75JiZYrKJlqwhh9Vg4+LXKWG8/Bs02L3TIW7avI1ZV+gX1tb6YY9JqWhTtfKF
 oDK9YjTRaqhmn3S8cAIAMQg65AsCrznTL9aKjKquY7TcqnUF/TMeyqLtKUnl1ZR6hETP
 4tTaPNGZJQWM+SvnU3NCOfhFTlPf06uJFpGuKWnRSruKGXA8IDVGhdBR2Ja+Y0wpCkal
 RJwRBq7t7u+Ppmlmk4XpydG3vashaJLTkPvb+H7ZZ8i7rWkb4sDVgaIloIM3evXlut0e
 RMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FesSiSoTXzalvaU/1YhzwDqI2aLMxL7cpNwL12fVJII=;
 fh=LMvsAK3tja9dIlTy9QzWPgh0SVF0D821BS5OujL+SV0=;
 b=q5PTzKt8j7tXYy5rblYc3M392Cqgci4+b/nYKXT8CRtoLJyUAv1xJZHKfUpXneJNnC
 2gWvRs0HG1he3TD/a6p681Hv4qssciMCBc8LSqJZYeA0BLQMIBRfxvKFZUM8hjq6klnY
 AlRbvHSSjjpS9xs+58+1ehWRq/iwkauesojqEspSRYPXuMlAAFUCk44oZy1jl3PmREZE
 +DjN/eFUkbJsyd41R/d4tq2WvyCcJUdYDsEX5PDrQZpQarh72X5uphqASCaH0rNw3H1E
 QkykPsqOeHs280Th9djZ05ptnli4zaD8yTuosdnHPG8Dg3mGaMlT6UWTyN2wI0msMVQI
 XlcA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784800782; x=1785405582; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FesSiSoTXzalvaU/1YhzwDqI2aLMxL7cpNwL12fVJII=;
 b=RIRus7bYVnJdt8/4LqB38jaXHrXqfelR1j3JCWrhHrGAGZJ2Ct67+lXHZx76aCJKDW
 UmPIIps4u4HCmr9wiyNtlEzGOpiQ5RaN1OJvXzCd+T2cAaHyT1tyCGAbTQxMVZBA4nF3
 poDVk12QTnetejlMX+tLLl4SAI72g1wG5GueYFRjsdiIurUDx716gNW0sSl2s+MLVERY
 LI7TQVn/NM2GCB1NcFk56rs/sjZlcJ1L3dK8cQ/Iu4vbC1Jf6us/b4ycPdfLDc5dJ3Eg
 Bji93knkUhWHowYynPZskiXC+q+CC5dKxDqGd7bo7J8hgl8clNwaLsDKiEYaLODynBMe
 5zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784800782; x=1785405582;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FesSiSoTXzalvaU/1YhzwDqI2aLMxL7cpNwL12fVJII=;
 b=pNA6FuGwQ9GvxWaQoC4vduhHY2FDcKZD/5VYYYa60dHX1MHB1ZNddlnXkU86taEYnz
 n3I+uU2+/s/rrNd+TIB16esonecP3Pezheb6g7Y4G6lfxRcRkqZzgHWJQe/4yTLuIVYl
 koQr8IKcSRGZhTR3fA0A74Q+TAfEMVwaCjWAO81p1bz/e0FPwQymUcmVmrg8UpQ+ioI3
 1fowX5Zxpeom7rZ2tEXD+xOTSlyomHE5A7r9bfts6X+vk2N8sJ17brKBlp1G6s+QPRq9
 L8D58lrtPuIiViiAIWRhM96fJII2A7qdKvOcRsbDW6fjNis0Sf1P9qulyND33/fS641O
 YgeA==
X-Gm-Message-State: AOJu0YwrSo8mjLhGdDD7OV+SJ54vIs+fZ23EKJqZ8fj1/bzItgcvLmIZ
 ZebSGgVqso57ixu5OuiR29RAiWLo5B6ESdRXP3mMqz+4JX+gjP+68LjER+pig0em5Nzc/6twCdC
 eJo0ApvFe400TFM8ftBfEMSsP014gn8A=
X-Gm-Gg: AR+sD10WKBXmpkV3RtZWrrJSk9PvaXEQ5gkTaVaTliKo0XjZ2064sw50Uke8t94vZ5G
 RfKgcqKX56NikNPvah1mqhMfbhHvTdsRAZ1U2xpD0n/ydytz5dEex3q+GwHa703YS3FQAK6fdwy
 iBG8cM35TBlqLPxhQ6w4Io9E4/NMpZ1v4kRtoEhb1/dk62iaK67C8CdUah2yc0woeUxFkJNyyuq
 EaEV7J+yUBcQB7fTDcXJXSHGRQgqqknm188UaLd6fNRNCK1wx5KxpzQsuAU6oAsTUtxUEANZwTr
 YNy1Laqc1Y9HRJV0JA==
X-Received: by 2002:a05:6a20:748e:b0:3c3:9a32:70ac with SMTP id
 adf61e73a8af0-3c44b191b31mr2642401637.48.1784800782221; Thu, 23 Jul 2026
 02:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260723094622.1515831-1-berrange@redhat.com>
In-Reply-To: <20260723094622.1515831-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Jul 2026 13:59:30 +0400
X-Gm-Features: AUfX_mxkcEXAVvrYAqlhgEpDkyXhHVW1090crDu9LDOy0adJAtlAUEf6UvD8MKw
Message-ID: <CAJ+F1CJu27KiD8n1K1p+hUH7HBGSGwObTAUXhiVW_VMohv6ySw@mail.gmail.com>
Subject: Re: [PATCH] docs/system/security: exclude uninitialized stack
 variables as bugs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1035.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 23, 2026 at 1:46=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The -ftrivial-auto-var-init=3Dzero usage guarantees implicit zero
> initializers for all stack variables. Thus most bug reports relying
> on undefined behaviour from lack of variable initialization will
> not be security issues, or even bugs.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Still worth to explicitly clear or set the variable though, since it's
not standard C otherwise and sometimes 0 is not the correct value.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  docs/system/security.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index 52bbf0cc7a..bbc462457e 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -133,6 +133,16 @@ an issue as a normal bug.
>    that affect the level 0 QEMU process. While these bugs should be
>    fixed, they will not be triaged as security flaws at this time.
>
> +* **uninitialized stack variables**. If the bug scenario relies on
> +  undefined behaviour from stack variables that lack explicit
> +  initialization, it will not usually be considered a security flaw.
> +  The build system adds '-ftrivial-auto-var-init=3Dzero', which is
> +  available in both the supported compilers (GCC and CLang) and
> +  ensures all stack variables have implicit zero-initializers.
> +  This eliminates undefined behaviour and usually gives the
> +  correct desired initialization value, eliminating most of the
> +  bug scenarios wrt uninitialized stack variables.
> +
>  * **low severity impact**. As a catch all rule, issues which
>    are judged to have a "low" severity impact on the system will
>    usually not justify handling as security bugs, nor assignment
> --
> 2.55.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

