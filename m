Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41D0EDA682
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRQl-0001b6-J3; Tue, 03 Mar 2026 10:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxRQj-0001J3-Qc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:13:01 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxRQh-0004Zs-Kn
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:13:01 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso5357458d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:12:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772550778; cv=none;
 d=google.com; s=arc-20240605;
 b=Puxs1K9zwMebfKbnh15D5YWNXzGmGq3LR1pumwx+UFF57ZiJITBYHRDwFRG6Kt0K1+
 tbXZ/136UNK1pBFXhrD3KeZB5ufKIJ5nxF3X5F7nwCW9u4a7oOO6C437kcIBRQ6V8KPq
 6axSGlBep2tPt2sYFz7Dr7FitOdQ8ObqlTPxqdO0GeXt05wHkt+i2z1WID7T7BciB5VB
 1elDudyLeBwVft6fdLfvV8P2UdEjGVIeF2C6D4QZAwVclvJCaE04eMposn+HiA6peZDu
 sU8e4kJopotulnMnbEBOP8RopvLcCmJ4O/XDdshuV3Uegj9T+Ww0LBUtBRLrx68EG3sW
 3FMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XFNJONuyhx9fILaHKjiZ06HlxX56FG4QbYLqYDjn9Tc=;
 fh=1dkRRyHgAB2NAl0f6EvVoSrjPdHhex7FMRVhnr6JuSs=;
 b=bjryiGRgEkh2UpReHprFfJm9TfDxLJ8DwvclqN5k3Yy1kMrSNOg5RsSzQAM26MZ08E
 nnX813TMU37ppB0svQw6NW2BOH862+GSWkEZ5PUepK0FMwxm9Gu3V7duIQna4R3KnWAP
 V/RfXDyRKtKtSdS7stk2nOhMd4x9YopnyitOlMw2rHhH5dcyB8hFjhpmsFixR9ZnSpHt
 pHWS0i7I3IB3liBTK+CoWNGjgYb4fwF36L0PSjotElI3yfX9RpBkQrX5z/QC7kLeNM9Q
 DsBKa7HO9w89I6kp5zcZCne3BG8DVxiRHLf5VI2IgJSIYG22dd1gRfoTH9fbGbS8GQDG
 fn8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772550778; x=1773155578; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XFNJONuyhx9fILaHKjiZ06HlxX56FG4QbYLqYDjn9Tc=;
 b=Y0SS62kJ2wMENdf/husIwrT8gUPnbRVG2XcaTozYyQqBb28sTtjYgf19UZ5ElKLMJB
 FP6kAXomybj2uC8aZBTcYdOg7f4XfTPxuTYit2KZI07JsT/UnTtqUKsbkhZsP8Yz1gPe
 q+JBYejgsCOGIXuRbKueRQf+LD7Cb4HmfDjWT9p0dk2APySOcK/ogi2HMYW8eMVQW/VD
 +Zi9abCudlbW9OrDlD4nr8hYB0JVQMrebgI11Cyvy7tJytL9IDuH+9xnpDd2y5n8MIC0
 oiLjKDDOl+nov6oFSXQ2Fuhe/fv8glDrx7Zur7gCrGWJdjJ6qcSWtod6TAwFT7whmogU
 889Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772550778; x=1773155578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFNJONuyhx9fILaHKjiZ06HlxX56FG4QbYLqYDjn9Tc=;
 b=sdxGjIJ+pC9k+SoPzHoK3dCalGbg1BFrPAr+J4S/P0PeKT7O4CkMp8d/x7cXv2Q2nc
 udOYhxZ/nI7VdtCtwA+ZZS3MHjLjEoXcWJUBaGAm8a+0iT/qMLqOlUM8205JiztSSZbE
 UwuML7tXw+fVDv8LjZiTVpqCJYEQI3baeGpiV/FOLafIAZHz+eXBi4kuCLfRuFJqmwAu
 cwdei9N0cCbC24CFQT59Dn7vKQFhQcpWT22vRlh6r/MSAmhq8FXQlvXFmQ25iglfBcfX
 iaOI+qqdAdnA7rpIDV6k57Pgo51MufbEhsfw/0/IThmDa7RvlgbVehaPp/s+P76QqjC1
 bflw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIItZUAAPRz0pYhTaIPAHGLhS3wrRZ8097nB+0idELn074RDgZNQ90gNEpAhzm3UP2hISq6TwKgktM@nongnu.org
X-Gm-Message-State: AOJu0YzksBRVoMjNP6TPff7H+eqgvxcLShuoLNJzdp/81XKJeNiQVf0l
 yQDI//4f/BcZWFyuBCz4ky/Y61sYhO5Bi2y92GGMuwQ3Ml8wmpGdNfm2+XmpEUAtq8kGbOGZi8R
 WYpnwgSXVbhTsK+42DuaJm2V6HSEJfiY7sH8OOgHHaQ==
X-Gm-Gg: ATEYQzzr4jpjHCQm9aLEK9dotiFFKb3gAVb+Nlc/9N2eetDFOQ4c4J6NHkP28sIEZjW
 +0WAGAU7VnhhWdxh7abWb4SdDz26TB+dBQD025Oeq7gW6qxsp6c+RVszsAKYhSGzOpG1dDoAcAZ
 JSsI2BvzmPxhsA8BWi6Y5zcpoXRWVAzlCrNaYhekca1dc+Q3m66fbosC3Srlm053j+LL7YtK00n
 HqEzTrRLjZ9qW+yTiPyz5CE15FNr64gPkFfGfRMiqnZKiEPGhS/Ko2CpTdIf9w2EGeElW34L01f
 5u683ceNvDeqt9hspdhqv/w2YWSZPWeBCNcUrynWE17zSc6hQFEhRCd9YRKaYr2BTL9ahhuxtB7
 w4g==
X-Received: by 2002:a05:690e:4499:b0:649:443f:ab2a with SMTP id
 956f58d0204a3-64cc2183cecmr12815874d50.37.1772550777693; Tue, 03 Mar 2026
 07:12:57 -0800 (PST)
MIME-Version: 1.0
References: <20260303143928.1747116-1-eric.auger@redhat.com>
 <20260303143928.1747116-8-eric.auger@redhat.com>
In-Reply-To: <20260303143928.1747116-8-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 15:12:45 +0000
X-Gm-Features: AaiRm50oLXH1wUDKl3YErBgl7t5X-mXJf6g31-oeCs9GInEqCKfTJYmew7SGxdI
Message-ID: <CAFEAcA9zpPwoHtVkbOxPmqNWm1FGcgFieXMsNU3esuXj0BD2RQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] target/arm/machine: Fix detection of unknown
 incoming cpregs
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 3 Mar 2026 at 14:40, Eric Auger <eric.auger@redhat.com> wrote:
>
> Currently the check of cpreg index matches fail to detect
> a situation where the length of both arrays is same but
> - destination has an extra register not found in the incoming stream (idx1)
> - source has an extra register not found in the destination (idx2)
>   where idx1 < = idx2
> Normally this should fail but it does not.
>
> Fix the logic to scan all indexes.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: 721fae12536 ("target-arm: Convert TCG to using (index,value) list for cp migration")
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

