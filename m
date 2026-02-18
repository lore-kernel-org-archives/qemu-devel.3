Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA19CE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 18:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsmVl-0006g1-JJ; Wed, 18 Feb 2026 13:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmVj-0006fC-Ko
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 13:42:55 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmVi-0004tY-37
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 13:42:55 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-649d4690174so48716d50.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 10:42:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771440173; cv=none;
 d=google.com; s=arc-20240605;
 b=aO2HbIRznlmXqWwFIC9CWdbNKoBzGoXOPoU8v14Rv77SM5+WtfkW46iEQcgeEpvgcL
 kHbjYYn9IhUxn9LVC4WlF/lO64LNdO0Bkw6tVI/nQ6v6wwRKQ9rL7km1Ax0r/2TTg97T
 p0hrU5vzilI3mgpymL0xdsHt7eqKGhxRZNqqdwEHLFTULNr24hDBqLnxyNnNa3gdCmqn
 LupluuoEnDnuyb7n7aWe0IZ7i/dJgjJD5B5kvMkT7gdf1ORU77kL0pKQvcVsEJiqUi2B
 8whhMWzMHQdX5lGojO9zyjY3lLoPs+aG/4767cuJ2R2NFwDPphXI3n5EDTwv236cvLcd
 lsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hborG1zMlrfzhI5hZFpl3ikakzneJZn01y5QKEh6E20=;
 fh=bp/zF/lCzQ95a+KoCb8C3FAd9bD3N8DnnxweD8sZk0U=;
 b=UpLvcfxYpmZboG9SbYftHuHS0iWVCpW0wx/aIbEoSoPLMo0WBWUFBuiCjpNpwsRNuP
 qwylRxGgkaZfvq/lUscco4jcNKznSzVkZncoExt8y/BcSs5sHBNB4Tq3RMhovhJdl7cG
 VDQEzce/Z0TwM8sZcJYPu9L77CX6DxQkVCOJFS/qB/tjE79GtUM4FnRX0GAGBJRMxfBV
 IS1YIwLc0WClNGq8NHsBvQBjh23MxpgKRevURLfJQMb8xzIlrS+v/1kSQUkHewOisMOi
 uRqSF0UKiI1xqyWeCo1lifPelCizH9ThN9QEQ4Xz4OTmuDg1pF18GX+mrk2K1qJGOLG6
 CFIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771440173; x=1772044973; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hborG1zMlrfzhI5hZFpl3ikakzneJZn01y5QKEh6E20=;
 b=ZSnqSfFQSmK3d7GTO+/ezIS0lZqXxbextSIkuoKdXv9YW69771yGniMnGC7FcPqjzD
 sQgCBUJJeH8Fx+v21OSs+HYof9LGpQNoSRWmx/bHTfPVRdQndcmxn+gczPS6hcvtr059
 lWTam4bwUs92cSWxFlpH75EbLPE+sIOISE7aBDns1q4GA5c/72O9eZ7Jfb5PaN7Z9neg
 I9aRWcvloYaaeKUxTEmS39/BhKsTSrOP/8YuhQ8Dad0SvcZOQYRJK5igY6Fw2vGhc24s
 b3pTIHXwx68oWTPTVoGRD8u5XT/7UPlau4FakEYWv/eZuIYdFUVgjHn0gFRb1ZmF9eTL
 g1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771440173; x=1772044973;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hborG1zMlrfzhI5hZFpl3ikakzneJZn01y5QKEh6E20=;
 b=PgjiZNBLZNRjq1pGJBJ6QciXBw39bcjn8j3gBZvFUbbKd2BSRA8t5JzQsmjCELcGBc
 jUXHKWaJzcyJBf70S7XDN4A3cG/k1G69gsIiv3hUwN0WqIfQiuovmK3hJTC5APAw8sh+
 YfSXsp92hv+tcfX35VO+4+ouYkqBi67okCwYC+62SOffD2NMVz6t022XpBt4vBuwW97A
 oo+wt2+niUTOdvtxWSK7uW6jSGGCsWdMyNDV/RvBzBMkfhdAT3Coj6VjQJ7zwRK93LJ+
 yEpFr7IElUorRzaT1JVKpsECKYGbHT14N+tIGWI4puAXEJ3cWpjMBuhge2aXd3xYWlRH
 /fEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCVWen8xbFEg43uWlRLSrOkpqFT+lTRJ9DWX9PpICS+mXrhRXvVsMFIppHYDSXdh/lQcv/W6BrZmS5@nongnu.org
X-Gm-Message-State: AOJu0Yxodv3s+tWnRZo5oAmpY6O8gJQRG9sgICcO0CFmqgE+wKtD4XrJ
 mOCFhQLgpk1NzQQx89t9dmPB5eq4R8eFPKCSYaSTatteBgGf/cFbd9eRBNyDi4+n54cJR81bE1r
 O5aLRDlg2HBR8b3UmphyQtgHrYd0G9/KWqXFaoRHIH2ippRcXzFUH
X-Gm-Gg: AZuq6aLFdsEYDFPrTUnmXligdSFvQ5LdA1bVejRiZvAYiZEk7OyimfIhVV6q4YVMazQ
 jTadYwgzUrPDTBdxL1pdjeqT2OHHlZc6kLkZ0NuDcQ6rQo3YoUopEL1avXgbl7Sii8TPN0fj6tQ
 SjE+89itqrUK9wvXlo29bilMvX0tncj9O9YG1hW3qgHArzuG5Yc/GaHjYtnrGAP7Ht7Vi3x//7z
 snhj5BXyY/YRu88VmFlFDmQzWZBiLQkmGVQBG1EqicaiPTDsI6Lb9luvYCw9QF1nYkUEehuJxbm
 uvgY7tY2GT55PHaRT0nwfghOtIAwOn+ge0y/QxnPBq3c0ck8FWl5z1zX2YXTYRRnpN4=
X-Received: by 2002:a05:690e:12c3:b0:64a:d672:dafb with SMTP id
 956f58d0204a3-64c21a439a1mr11134454d50.8.1771440172666; Wed, 18 Feb 2026
 10:42:52 -0800 (PST)
MIME-Version: 1.0
References: <20260217204754.101223-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260217204754.101223-1-osama.abdelkader@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Feb 2026 18:42:41 +0000
X-Gm-Features: AZwV_Qhd17K0aDB7kMfbTNYEreTagOs09xtRQOe7PJetSsK648YCQ6eV8ZlWL7U
Message-ID: <CAFEAcA9f1t89K6sJARCoXJqyd=LD85ric_u-yWWXTAZ6MLrwjw@mail.gmail.com>
Subject: Re: [PATCH] whpx: remove duplicate include
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Tue, 17 Feb 2026 at 20:48, Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> cpu.h is included twice
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  target/arm/whpx/whpx-all.c | 1 -
>  1 file changed, 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM

