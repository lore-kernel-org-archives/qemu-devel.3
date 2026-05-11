Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0611CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRiB-0008FK-Ox; Mon, 11 May 2026 10:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRhd-0008DK-Uw
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:33:57 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRhb-0006XB-1e
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:33:48 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-67e9e343b22so5081295a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510024; cv=none;
 d=google.com; s=arc-20240605;
 b=DO6sKTvB2afXmJI1OyzmmVcV4Sa7pURqSmx4A++Qv2us+hv0vMtdxkTvjEb0khV3nz
 kWhJyL3WknDZZNjqmzrrpoShr7cpN/MiuSChkllYoHXgcgzj3l6Ol+9Xye+pBkerQ2NM
 RXPo6ZcJ1zCKSsG/EcrfGchevhEhJ4WsNRtlz7UO+4RjtntZ7jUbGAzIU0//QSosdvqu
 i1ngtLD29E5pSOU5cms6xegT1/WRhyk8gOVNLPkYZG3xIVg94B/WNvL7Zk+m8nffAEtb
 xFz4JYu+ImRcatxetPN7gtIdza77AIfOErCNMCHvpXc0jrv9wYJHvgQrPgD7YOU7nMnd
 hdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dMiKxnwj4kix6XqCs3wmtBcSPTJVyJXP/efIdat9BnY=;
 fh=o3NcXXNApN2T5QEs0RCBGBe7+cAP9cEBwYxeG+eDZ8E=;
 b=StE6aJiObfJyfKU3oeytlB9u9x8s7mNx6ytIbCswpb3yvNszjZX/9oegsoyrYlV4Sf
 lHbu/kuHZigrsHqlpTrbDV9BzAC9JRJKe1o7RTAWo6mAIR2Rm5bbeqFI2wNeD2VLkao0
 r6dOLFDlMnxxO7q3/FSFES2ZaBUQIlZNsX2VCl4nyqLvwwi50SjNscmGJwgvIkwOuib6
 ADJ6tLiChFuCFvBp4Eh80MuME3MyreTWZ1/6mI3T/55MGgIlwlhRZhve/AcTvEAMVWJD
 Uuvs6snrO/oiLcfJbbigagqhVgEttjxiIu8VqHLgW9IhvtjAIwsXIfMBoCTQHdRYvStT
 BCRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778510024; x=1779114824; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMiKxnwj4kix6XqCs3wmtBcSPTJVyJXP/efIdat9BnY=;
 b=y2esZkcJvacYHOfcWnF2aRnGNNolfU8Wk2828WtHlPFTV0L7qIzbDLnUpAJy/pn+gs
 7Myng60JXq6MMk3ohPqsBPppxzewN918YNFW+/JTZ7PE/+weIUrPqzJJYK3/MAF8u433
 Hyeyw6E0ifmf1wXVmFpWllA+MyqoyLKf2m29VunGiCVQpJIjWasW87VUK02g11+qH2X2
 KLtpI99pdukHBOrjnp49bheiSt0EbXz9o1ZtvbUs65t41qfu6gLoFOm9BeFE34gbSrEt
 3oNtfa7fs7zW5YYTKgMiSiSDCm5Jmh0gmd/kxxe88sdcLJzm1WrrqUuWo26bygYybm7D
 EqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778510024; x=1779114824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dMiKxnwj4kix6XqCs3wmtBcSPTJVyJXP/efIdat9BnY=;
 b=lDj7rJEEvgPjGO86gVoL1enUmBpWJs5xdNDN/TZgOLUvGQ/R1FPxGCXI0e8jchl3e/
 zPBl4RD6J9lUL4f+12FUU5mVisw5nojwUiSqJ9tiltczu4bTJxJpbIACd4zPL3eASovj
 C4aNmdnyaqYE0Qp26T8ssvn6k3q/FdiqxXAoeKjt7rc+JYsUC4ferQnHwBbELkRAHJux
 62cY4lDWeHdHG4oZeW3eluS06r1jocn1EUTRGKAw3gMzq6unf9gbdqJDkOKHGwiAo5WO
 TjfaOYY8PGkZX3/N+U0C1hlQgrgTe/aYRURzHC6XeXW/SQ2/R2rKCP/9bW/x7Vnt+ZAk
 FwpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4VAmHia0SyzYXG+3SEbeM9unoWn8BSRFhoUPEMIMcUaQbl0OKKXNb/kzAmG7QTiN4ePGahhYubLTF@nongnu.org
X-Gm-Message-State: AOJu0YwA59mvfkEByoaxyFeg87tLXrF/1s8/gI+ScsQhJ2QsMOS8EnCb
 SSlgLbEJQvsnhMtIwQRKu0sWxCE8dAPktaj1dH6e8rGI3kx/pPURe0rQdbV+CSP+8hELQFGMTYq
 6JlNdApkqn7QT2LI53tGrbewYa/cbgUO7D3ZRj/zG4Q==
X-Gm-Gg: Acq92OHWvjrjYtwUFacpS0tqpA2O3Iqu1vQtrx3LN+IIzVOLEVGe/pjxvfxNVbSBrLP
 ZEgzDaDXjCQ6bCxsXvxtdHFoL2PDK5tYEU2iXEcGkqd0dvoX0M4wpHsfeeUCYsrO6xCJLnggiX7
 A0P1/+rT1MBvGr1okADOajbL4tHlyL3m9v8Eri8qj4deQnTSi583UZRjeGyf8buGz5/BFeRfxp5
 mIGQq8pfXyECfsKH6kNIbN4eL/9LjKgHFwq5lT+sktx8kRjsmx7EyNTfE4Fv8Vea4yc1VWD4fah
 jM6d2mSr+oEvKXnLBOsQzbEbx0/4RWCzsfq7/E+QB6Zq3AE8LUPpU51bGTZxcrlpdPo=
X-Received: by 2002:a17:907:7b96:b0:bcc:ad8e:cffc with SMTP id
 a640c23a62f3a-bccad8ed0bcmr457501466b.33.1778510023830; Mon, 11 May 2026
 07:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-34-c413f3605311@redhat.com>
 <CAFEAcA-tSqa7SQUE-f5yTq_P9eW6p_XrnNSnHZjw4g=Z2WncAQ@mail.gmail.com>
 <4f90d39a-560f-4922-ac54-2c975dae249d@linaro.org>
 <CAFEAcA_LcHgtAAYFjqm+P68ULwSRJWfr6LipMg9YsviyWDxH7Q@mail.gmail.com>
 <CAJ+F1CKFcPy3NtKgVfUruN_Mp1498EiQpRNz65HNE6YeqJD3CA@mail.gmail.com>
In-Reply-To: <CAJ+F1CKFcPy3NtKgVfUruN_Mp1498EiQpRNz65HNE6YeqJD3CA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 15:33:30 +0100
X-Gm-Features: AVHnY4IvOAwGbP63OcIwl8KYe3nViuFBGjk2dfTwMRKmTlUXWHXktfQP2nn26_4
Message-ID: <CAFEAcA84KeXuCKKd6B2P13OrH1Du9Y-hgehQZWb4zPSFSVuSHA@mail.gmail.com>
Subject: Re: [PATCH 34/41] hw/arm/virt: free flash devices and OEM strings on
 finalization
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 11 May 2026 at 14:01, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Yes, in general, if a device creates & keeps a reference to an
> instance, it should be a strong reference (we don't have support for
> weak reference the way gobject has for ex). It should then unref it
> unconditonally on finalize. Is it ok if it is addressed in a follow-up
> series after this one lands? I am afraid it would delay this series or
> make it longer, and a shift its focus

Yes, that's OK.

-- PMM

