Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42272C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 15:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc5iF-00066Q-I2; Mon, 19 Feb 2024 10:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc5iD-00065u-Oq
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:37:45 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc5iB-00088s-V0
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:37:45 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-512a9ae6c02so2105009e87.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708357062; x=1708961862; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3W8vUsYbI3285HmSqOIdXBQsmkxsPBBq9uF3wTbWky4=;
 b=SAS0eD+MC6WIw73x316/Uw3gpmBmYIB3fBwyHH2tTB8FvUw5mPR7it9rVihzxfs+eM
 1txAQ2Sb+JJq/Xkb8fW0cNY8BoTLlNXaDrA+rWX8CKZBWoM3LF3/nkII5M7+Cx6v64ie
 dvjz4efvpEl9oFbF8FFeix4uS41CLUEI6jZH5LMFiRF1On77DyptiBjmOjR+4OBxkN2U
 l0CArrD5B6mmm9kYmwN1Emvsl3xzYQru2KyBGwIkLL9FR0VUaH7HYI1OFAaD0XwVUN09
 CEZHTLiNaFGHsSjYFg0v6fEmJM+hIzgzdFMQAWQhoNZsur1IfFwm45VeSCVid3CYFQBY
 ULLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708357062; x=1708961862;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3W8vUsYbI3285HmSqOIdXBQsmkxsPBBq9uF3wTbWky4=;
 b=P1SHg3JcdKVi05XIy3KP94vF0w6OwLsAPbugVMH+qrJJ+lw3ctAXMYzPr+ruFwNFZl
 sjsjXjNnxNHwAQrNvHakO+3TK8kXRcf6uSKS1eNFn/SxJyx/O9C6wnXvt4AMy/CM+fyG
 b4bhbMVN2Gpjst532NzzS5P16mN9bDNyvD2zpjh1/m+mOERZgVrtV1xX836NB+2lDjhr
 YUqsdPKDZhx9YJ8P7rrcZmNEgpWbq5f2aCwjmWX15c9ZdoyTRQTW/Jcv89QJ+NRkhG8q
 lINBPpJPC9/ZvWcM7veFt6j786+7U74poHBASouPUeiy1QXMMT+WaDyVO+bE3Od0PoVy
 XV9Q==
X-Gm-Message-State: AOJu0YwhZviHHdCoKPeESmGQD5QeurGGMX6nZqhJsSM1W/s98g3Lpja3
 jSy7W2nAHLRpRyqCAXhgAL4XusuqsSqN13ggz/BXVhVxKv2iR+RIFnKzamW6hJvxY1/bZBamwhS
 DRannpD82/qT7SND3aEUmk16mNVudQRpNgY0RA7LBBkgM2w0J
X-Google-Smtp-Source: AGHT+IHu0A+nqjThcvyN7v7yH1q72zcLm+PBvXY2M8Ys+VjOIolt/1l9NkaDsYCPA5x15dkhb2gZnobcnqW9MhD3ctA=
X-Received: by 2002:a05:6512:11c5:b0:511:a2ed:f6c7 with SMTP id
 h5-20020a05651211c500b00511a2edf6c7mr7330365lfr.11.1708357061724; Mon, 19 Feb
 2024 07:37:41 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2024 15:37:31 +0000
Message-ID: <CAFEAcA_BB5-eieVGuqqXn3aS-Vmc7OcTFmv5e=i5HgNw3Kp2FQ@mail.gmail.com>
Subject: dropping 32-bit Windows host support
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Our msys2 32-bit Windows host CI job has been failing recently
because upstream MSYS2 are starting to phase out 32-bit windows
host support and are steadily removing i686 versions of packages.
The latest is dtc:
https://gitlab.com/qemu-project/qemu/-/issues/2177

The writing is clearly on the wall for their 32-bit support, judging
from the "2023-12-13 - Starting to drop some 32-bit Packages" news
item at https://www.msys2.org/news/ and associated discussion at
https://github.com/msys2/MINGW-packages/discussions/19326 .

QEMU on a 32-bit host is not likely to be a great experience, and I
suspect we don't have many users using 32-bit Windows who couldn't
use the 64-bit version instead. Our Download page points users at
MSYS2's packages, and they have already dropped the 32-bit QEMU
package build. Stefan Weil's binaries page, which is the other thing
we link to from Download, has no 32-bit version newer than 7.2.0.
So anybody using 32-bit Windows QEMU must be building it themselves.
Plus, we've already deprecated system emulation on 32-bit x86 hosts,
so the only remaining "supported" config is with the NVMM or WHPX
accelerators.

I suggest that we should:

 * remove the msys2-32bit CI job entirely (we will still have at least
   compile-time coverage via the cross-win32-system job)
 * document that the 32-bit Windows support is deprecated in
   docs/about/build-platforms.rst and deprecated.rst
 * update our Download page to remove mention of 32-bit Windows

Any objections?

thanks
-- PMM

