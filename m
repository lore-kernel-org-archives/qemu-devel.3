Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C723C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 13:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raErV-0002kA-4a; Wed, 14 Feb 2024 07:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raErU-0002jy-14
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:59:40 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raErS-0007B6-A9
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:59:39 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so7257909a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 04:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707915576; x=1708520376; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oT84rcjoTdIUfoYNGrsbmO2JfMCCnCor0zeOhm+7IZQ=;
 b=EtI99MHT5SI11BZu/8rfj7JLP0Lve8ffUr3j72dKqLnDBE6b/epgAqiBwecOxPRSbC
 QFPs/Wn3uTUYk1IxVaotRbDmNbgEkUW14DX4FmfKdi+DbT2WDd/i9kDt0NwsK1XnqY3a
 VDUM83Lz9Xw9FXUCJ77eKEJDkPJOqvIge38CQaJNQPlMGc3Cq9xlStjoGRmVmO9YdxJF
 VJ+lWNphMQMSnv5KNqq2hjIGjdxSbsabEF6PDhnfx1ti5QqesPo2Rb2Eiv/H5Ucx+g1S
 A2ozFSdkweFlumDbkV7MyFl6wZJj/1q21GOTQH40KFfJ3N2oQOwZfT4baFyxdxrHBXpD
 6xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707915576; x=1708520376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oT84rcjoTdIUfoYNGrsbmO2JfMCCnCor0zeOhm+7IZQ=;
 b=wNDbTGwj9NEToCvc+idcHprS+tv2cvYIvPRMrMqKIczvFzaKosA7mCbr4an69QrdtC
 1Wv/vRpoPXaKGV4Nev3uUd5+Z+hbtU9qorXBPXgPI0AyJAkQcszrkbnZa4MC6sa5VQJk
 V5azMEzzQ+QOfuNNsdjn5P1zQH1HsOlmOryW6dflUVHYX7z849rM9h4NPyeAw+FmWUqa
 EJGeSri4xU4QEZRMFZdqooCifTMSik5RbvWrQIy10nrWkmiS0mbxZ+f81btxreLDNJht
 ZBDSv0XhqwPFjatRd1mzEyu8on7X1CZgp+JkLx6Gz1HgJeE+1j6HECCylnrxd3F/Qu0r
 1NEw==
X-Gm-Message-State: AOJu0YzEr77vi0MMpCuboCzGcegQkVPZoJERTOWhSOKu0vfnDNuqbC6S
 ZvJWaNPbM0ou4A2lZ8//8Gyd3lbVbTb2TbLt+AemVoZ+J49L1EbZYEidcf/ogbCmeey4Dw03uxt
 BKxIcKuB5IBX5cE3quRkX7zrjxuBeczZPSBgO7krY5dd4dV6Y
X-Google-Smtp-Source: AGHT+IFCJO/kh4eRWzwELl16BuAX5HWr5yu3nlZdajZINK3329eD8eV5M3Pl2w4fES4vv7b5WMghm9lkMLd8YdgY8D4=
X-Received: by 2002:a05:6402:1491:b0:560:ea74:a67a with SMTP id
 e17-20020a056402149100b00560ea74a67amr2217848edv.17.1707915576694; Wed, 14
 Feb 2024 04:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Feb 2024 12:59:25 +0000
Message-ID: <CAFEAcA_xdVGQbFLB8Hh58roM0ySnUgmT7yBmNFs8XD4NLs_owg@mail.gmail.com>
Subject: Re: [PULL 00/88] qemu-sparc queue 20240213
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 13 Feb 2024 at 19:41, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit bc2e8b18fba33f30f25b7c2d74328493c0a2231d:
>
>   Merge tag 'hppa64-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-02-13 13:56:46 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-20240213
>
> for you to fetch changes up to 78d68f312aec905edcb1dc5549a2c3a6f716605a:
>
>   esp.c: add my copyright to the file (2024-02-13 19:37:28 +0000)
>
> ----------------------------------------------------------------
> qemu-sparc queue
> - This contains the rework of the ESP controller as agreed with Paolo


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

