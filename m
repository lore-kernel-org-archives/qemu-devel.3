Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15869CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 08:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNoEZ-0006HY-SJ; Fri, 15 May 2026 04:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNoEY-0006Gx-2F
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:49:26 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNoEW-0005aS-28
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:49:25 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65c7492a2ceso10075802d50.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 01:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778834962; cv=none;
 d=google.com; s=arc-20240605;
 b=d7nrwTPSfjniCtWIHUqlI5QD1dz+dU0sPtdAEC/iLYfiO2+o6d8gPeRzLjW6e+d6hk
 v26mAS872yB9/QLPvxp54F3j4B/KJogHKAelp39X3/hxyTmAcQDgATBD2yGvyhCmovIG
 6/SWAD+txez49xrTriur9Z1eJeg47EcbQrDGYGIz+oSgu97CvmjlOT9T85y05aADEyht
 52xIEx/Ajdq2scz+REMIW+YEHDLWy1YdkaiyX/6aFDUXJmDCdwKnrrUTuE5c1LMshE0W
 8IKaJlzidtb5K8oybBbRSZu1Km1TddvQDmYDTPeDrjFPUUlW3VyNnUIs6ZNYcxPX4098
 qL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1aQU8qSBHLDH70rkd6GhkO/f0JWFbK/pTxADVkt7U4M=;
 fh=Ayn1XhkevTPgTEqyOLu95RHd3TUepZKYCfpV7siXqls=;
 b=glH3ViWAtZXIqooGi53FuULVqWCndnpX+LxN7zPUW0DkxgZprKm5Ttn54OlBEk31OX
 iscmoYHb2W2A2KTpVXUDVSBRlCdF3fXdMn2SCrAw0Mldh563YkzBPqDivo5Lh2HNLv3L
 9hjoHgzmL/tRHNpaPiwSz3wkm1SVuJhJVloCm1tjRIGOcvejnmpRVXsINxhTG7Qg4b62
 nJ+R4Zx9CLm1NuZY5lCHNehk3T9YHreouLaz9r+WJeQ6ftQm/wDoUwosK4ZIYl0eexvW
 5r8Dsk/V7mUgjmgjw3kMNfCQWvgR7f3TEaezTucs5YHXf13aOK+T7he7j9F2tgOPSkM6
 4T4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778834962; x=1779439762; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1aQU8qSBHLDH70rkd6GhkO/f0JWFbK/pTxADVkt7U4M=;
 b=nZ7ibKvu5c9RKG+fh31xPdsUbqwJ0cMYdYphcJb3pYoVFiRm8ynLdDRkecyk81pKem
 +JvD/qWDKPICpBcCZbrm0PpxKbF3oWoxp2GPGDQ5iLXdfByZqiOKTr+yDTyqodaeaUjT
 qOtP5N5viO/qKPEDv7QcePHC70MZRIobFh//E5K/c79HI1DVXdSscEPeZW5e4l9gpnkF
 XLDLQPFZbPEK0G72J1Dqv6AYW0Q7FbSc3q/sybKQUI21MNC2XE5JWOK4tAukB4YAz4tf
 nEQsfGNCQ7IawELSFkYsIp10cOlyQtJWGhq1FG2rQk6H9N96mmujaUMPveaWtgv5m8Sz
 sk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778834962; x=1779439762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1aQU8qSBHLDH70rkd6GhkO/f0JWFbK/pTxADVkt7U4M=;
 b=py5xyMfEOxAoCUqH80DDfX5DxNq7wBgIDzVWZnJJdFYvS91uxcwviVszPrGM9DYiLv
 YjnUS7/fqi8utqpqXIO5kRkZDoT1hrgX8z+Y+U8E7P1o5ZtFZV2GM9M4SRJTMkEAJ86k
 wQnPpfs4ljU47V795QdXIXY5pcNKGQyI/D25IB4/WRxsfjiUTO3nnPnkEHSvrKtLaYqV
 2XD5rZdPsyNGfl1NOfMGW0Siny4m1NU6EQkDzxopEVuq9Ce9mGrHULx301iLFTTcqLv2
 kNtOfBwVy3faGMj0OE7LprDYtF6lMt0oZ8nk+EH7VA3oCpAQ85JlQ4hjDFX6XB0mfq2o
 +1lw==
X-Gm-Message-State: AOJu0Yxqajl5H0erc74sLGwVrMNPXQ+jWLfaA+vSMMcfaqK8fx28pD//
 OrAxzYyn7nGeSFG6WD7CWSlMBECkreFq4GAeWGYlQAKYqXL/lddQmwUAM0joIEb8tKTQJC+28mt
 cfOU/xlHlLFQLBhVv2IasLSuWSsTShTISuVM3FBca8i8w0ITR3M8F
X-Gm-Gg: Acq92OG4dD5uSYefp31KtYacZOepiBLOEqOxD0Hr3PFJyAm229m2s0cEfe4NEOE4+9Z
 RMGZ9j5BM9dms16La9YIuw89GQnlC/AbW+obddnbqv8G3mJnNfhY8IVTuAGHE5S3y8Duo4QN6NB
 tV7hVAVYNauzXQ0knTV07h7mJM4RIVAfpVj1QTdvCr36ktHGiYyKf1QsQLfRqjHTZ1SBFnrSQ6k
 E4y6ukXm3Zbc+QVtKLQO5AcKTfC0hlosuQySyAl/0Bsmcs6r6Qfkz6GUjOlubjLkl9n9Um1BwZQ
 UGiszkf5OH68aofqzIUR9/Oc//yJuqNFAsuCxPYjgj5Bqf59UfWes0zFL8DoEo3Jnqk=
X-Received: by 2002:a53:c041:0:20b0:658:509a:754f with SMTP id
 956f58d0204a3-65e226bb1acmr2455063d50.18.1778834962165; Fri, 15 May 2026
 01:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260508104723.2144051-1-peter.maydell@linaro.org>
In-Reply-To: <20260508104723.2144051-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 09:49:10 +0100
X-Gm-Features: AVHnY4KLMYBda9biDDKnUFL8TJBDyzlgFrWBE2rhNOoZepw0mONQP_aKlmQdyaw
Message-ID: <CAFEAcA_o7XwLGoaD=4KMb0MMxy9s=EkiP2_US44FkO1ng7m3FQ@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Add -fzero-init-padding-bits=all
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 8 May 2026 at 11:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The C standard doesn't always guarantee that struct and union padding
> bits are zero initialized, even if the code initializes a struct.
> For QEMU, this is potentially problematic, because we often have
> structs that match data structures in guest memory, where we
> initialize them and then bulk copy them into the guest.  If the
> compiler didn't zero init the whole of the memory containing the
> struct, we could potentially leak random data from the host into the
> guest via the padding bytes.
>
> We already use -ftrivial-auto-var-init=zero, which will zero out
> padding in many of these cases, but -fzero-init-padding-bits=all
> closes some gaps, for example cases where we initialize a
> variable with a struct initializer, and cases involving unions.
>
> Follow the Linux kernel in using both options. Compare kernel
> commit dce4aab8441 ("kbuild: Use -fzero-init-padding-bits=all").
>
> This option exists in gcc-15 and above; it's not supported
> by clang, but clang documents that it guarantees zero init
> of these cases always:
> https://clang.llvm.org/docs/LanguageExtensions.html#union-and-aggregate-initialization-in-c
> Older gcc which don't have the option behave as if it were set.
>
> (These options are passed through the cc.get_supported_arguments()
> filter, so we don't need to do anything extra to avoid passing it to
> a compiler that doesn't recognize it.)
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I'll take this via target-arm.next.

-- PMM

