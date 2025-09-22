Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC43BCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0itc-0003ip-4c; Mon, 22 Sep 2025 11:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0ita-0003fS-KZ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:56:06 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0itY-0004h0-8Q
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:56:06 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-635fde9cd06so282088d50.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758556562; x=1759161362; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g51y9zwupdPvuJVevVvE4s+gS1j6LXvSBGLH7qWsxy8=;
 b=drwkfFaw/6vCXm1pbWKUrtS8HrwDy2zaWJrd2RvAXBIwAqHHL4aJfDpCMEwWK6cids
 7OK3r8Z3c3HP6ZLHIU95vS3tE24515tWVzheEaKFl3WA6Hh9BnSCmtRaLKAf7Q/dbw0Y
 YppQL6sMpJ1naJUtL25bP78m/sGgTnhZw5s+Fcy3hITM4bvgqGU3iw//a1l6SCys0ruZ
 Oe3pfJWlkxkIIO3ijWOsaIdY7GzF/dmhNZpvK0xeKAMVUmFQaf+CuG/EIOO4SR3XHOYX
 vUQCxsaCiDVBsa4ianzXJIhL1LdoQrmg/Oqv4kqZ5YUlT07oFKPpmwhIrFdmn5nVXBAG
 Tuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758556562; x=1759161362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g51y9zwupdPvuJVevVvE4s+gS1j6LXvSBGLH7qWsxy8=;
 b=pW4RLS2rwVCDHe06eSnodbYNtAhUr28o26kdBWE4eTSFr8HLtF1fmcDlaU+80FTu/G
 daxnCs2G2EmomO/Une+EGwCUzgTRkdWKwtR9jEAn/EQHRxaq4YcxmEj9xJYFcws1lwNr
 2QWco0qsLyZCv93FhckPOawscEPy5ajbq0nmzCUqc32rWGbljYf29mT0KOpaCQF19FHs
 8pT2EerJ6jdqV8VenocAvl/fD5es6hb+eBds5EsWqTuJbAaYCFFv/F0evGxT+12UEjMD
 QMBsfYNT4U1HETdLZX4DBSTRh4jTGm4Ur30GeymaOzSewzDBc+gbbW3juyc/mccdGKZe
 jEiA==
X-Gm-Message-State: AOJu0Yx3+VzarzE9wOXJrys/ONeNllH6jhPXpjtNjSbKhpuGwc+pHfel
 n1IufCyL6LwgulY9QWweslKxCS+3rNH0ao+a11YAJVNP37qFzw1ed9AgZ+aAn48pUoXD2dLtpON
 kAKxuYE2dFFEAjcYUBOXP+Vods/9EOnTA6cHqdbeIYlFzZ82GH0n4
X-Gm-Gg: ASbGnctUcbHdJS6ZvG/O48SdDCav/pqkymyx3IH1L9pK3ty1sJz1ZMfZegDbuZI8JAI
 aDIXpBckBrRbmjW4B6/S1ZTToYOPupMq7YKGtOUNRrMK21bxG2aAVoJ0NrEbQ/1R2ZbYLMRUpVB
 nlGldr2d1ult3I34GZ2f8ZTVAqr0uiTuX4RkQ+lnYyw09BbjsGtG7BFwQx43Wl0je8E/h6eU7cT
 /blBOajZ+Ff/UrvI6eXmYAVezRWT4QYvjBwAg==
X-Google-Smtp-Source: AGHT+IEmtDS33aG15saAcuYztNO0jce1iI/tPcgvtixVVRC3eemRLpgMjfgx8Nt/wVBz0FRvBxzajGZV8Wjug/WyDrs=
X-Received: by 2002:a05:690e:250d:20b0:600:c2be:313e with SMTP id
 956f58d0204a3-634779f3285mr9327553d50.14.1758556562590; Mon, 22 Sep 2025
 08:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250922154843.60233-1-pbonzini@redhat.com>
 <20250922154843.60233-2-pbonzini@redhat.com>
In-Reply-To: <20250922154843.60233-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Sep 2025 16:55:51 +0100
X-Gm-Features: AS18NWAxhaKQ7c9IAzpJdYhCs2fMRTouyr08blNIGdecBMh-_Ei4r85aEH9rYHU
Message-ID: <CAFEAcA83Gi_8R3uOetex+e7vPyYipg7k0W9Yqvn6m2HB1VuHLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs/code-provenance: clarify scope very early
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Mon, 22 Sept 2025 at 16:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The AI policy in QEMU is not about content generators, it is about genera=
ted
> content.  Other uses are explicitly not covered.  Rename the policy and c=
larify
> its scope in the TL;DR section, as a matter of convenience to the reader.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

