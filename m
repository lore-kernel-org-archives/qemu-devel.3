Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5827ED1812B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0NZC-0002Fj-NX; Mon, 14 Oct 2024 12:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0NZB-0002FK-6E
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:05:05 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0NZ9-0005o5-5R
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:05:04 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c9428152c0so5549407a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728921901; x=1729526701; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ky22RCFgM0Nc2p6QyFiFMExDvc6HXcAKbJd9BtAfrsU=;
 b=wmstAVwb6YcVWnVtA+gig0jjPcmhOZ6ueppo05112Rc9vCC0Ra89RAtfYRTdiCICB0
 hOUTg3EJXDdLwa8Prf5lnQVXRg4lrI5oBQ5kR1NW6sWensqYgyg/hdc5K0cL+dmDwQvv
 emnClqt6akh6+UeTDPQdmiDtDB5w3Cyo4vJVAbR29YvePA2TQrfOIpfH9CQhYUN+f7vg
 uJz7m4ttE+VpEevjSl6cdmhUfUq3JR2MLg1psVXC9II8izTl/wePqmWQtv/J/+FpAOIh
 GfbtBB7ZnO6fAyMbH2hYcfJkECpxhhr/VOVHz5qOS0KTngqZTiWBmQCY+w9r722zF7vJ
 IIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921901; x=1729526701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ky22RCFgM0Nc2p6QyFiFMExDvc6HXcAKbJd9BtAfrsU=;
 b=EJTgHxNfjdinDo8yilzP+bvv8xEVIhL9syEdxEgtrXIz3TUcrVX79uzKlpS2GSS3+f
 ZorV99uhgZCNA9rPn+oyMeA/LR5XiqrOUWwUajnkJ5/iVuAHbeozXe8DhFVY/d48RG8C
 qx0XtzQQDeHKTG2ti/M7ErT8KZGsgUcNyB92qBQTpdMOiKbgCI0ZIKn+HcdgK4fpyhD8
 y5F99a6Iqj1JfhIYdiz61U+OgFGBOggRbde3BrbhqDgCkngArqv5IyKgo2Pdh/a8vUGg
 LUbofcud70QCDSuQmq1HoQV0H8A3wD2N71NOXnhauR58w3m+cFc+UtMHWMh6U8nXVBSr
 vAwA==
X-Gm-Message-State: AOJu0YwvRpjHGSbhCv3uSsG/OPrt/6BKVUq5gJoBqr3jQJmqa8xiuM0+
 ytDBi1jIcsIvSBHd8awXOLQLtnZ6OMytkkKGUZ/FC3+0WIMCUug4Ers8xUJz5uJv7Rh3pesmS0c
 162yEpQ0me5LDtaStxvKkLT1ScaAQXeGdJ0YVJw==
X-Google-Smtp-Source: AGHT+IHsiFV3ieP8my/SlS47ZFlZdicUZteTzT0Gm/6QSj2FkPgwdiVV3cOc7Uz05AfN0XopaxBU0QC2Iyezo8VskSc=
X-Received: by 2002:a05:6402:13d1:b0:5c9:3fe:c7b9 with SMTP id
 4fb4d7f45d1cf-5c948ad1dd4mr8791543a12.0.1728921901106; Mon, 14 Oct 2024
 09:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241014110113.173946-1-pbonzini@redhat.com>
In-Reply-To: <20241014110113.173946-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 17:04:49 +0100
Message-ID: <CAFEAcA__ONney4-nSweZQ3EfCzku9o=ktiGEeRYwjnT_7FB-qg@mail.gmail.com>
Subject: Re: [PATCH] configure, meson: synchronize defaults for configure and
 Meson Rust options
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 14 Oct 2024 at 12:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> If the defaults for --enable-rust ($rust in configure) and Meson's rust
> option are out of sync, incremental builds will pick Meson's default.
>
> This happens because, on an incremental build, configure does not run
> Meson, Make does instead.  Meson then gets the command line options
> from either coredata.dat (which has everything cached in Python's pickle
> format) or cmd_line.txt (slow path when Meson version is upgraded), but
> neither knows about the rust option, and the meson_options.txt default
> is used.
>
> This will cause have_rust to be true if rustc is available; and the build
> to fail because configure did not put a RUST_TARGET_TRIPLE in config-host=
.mak.
>
> When in the Rust pull request I changed the $rust default from auto
> to disabled, I should have made the same change to meson_options.txt;
> do it now.
>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Applied directly to git, thanks.

-- PMM

