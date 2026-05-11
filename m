Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C734CD3427
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNQr-0003K3-3p; Mon, 11 May 2026 06:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMNQm-0003DG-QP
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:00:09 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMNQc-0006r8-Vk
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:00:00 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-694891f8f75so2260234eaf.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778493587; cv=none;
 d=google.com; s=arc-20240605;
 b=NWMgkoRttwMhqga+FMjeH5aP72yrRi3uu2P06P73H/+FY/0+YimInK2Hr/TBSeWGRF
 DzeU0xNzENB7RgHYdQfVDWZTtb5tVPrGp++E/+miDgn4pY/BXWAkGwqUptw6dbpKrIF0
 RO4GMFw+1PIDB9+Ydlh/pZU1PJje+ZplWqNNfrMfqFrpsNx68F/r/rTtje/Y8Bdmokmy
 cUuE32sxLccIMqpuZUftFNiOjn4MP9sQkNpyFNhMBPyIVLn6i4hRjG9wP86MxzCZMZtD
 nhjnHJp07cxlTZSKj1HfmDHLqqdOcvdKP8KzU/kZYk+Wh9n0//dCN06EEWlRweybrxff
 OhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G9hBOOXPj3lV5pqs2TQi9HrfoyJwjeMMB7z0CL/v5tg=;
 fh=qGpafQgbTK4FdUCg88rPA1Em7QTQZu8xPGdzINiWLlU=;
 b=Zq12u1yo0nP48T6yEqWCmia7Ei+kBK8OJahS1Y3uCAI7lNhCcufOF7lkjwQnXZE27a
 CsSIaqqIYtS3zvIaNYEp4K4gzs113SUJPz83kMiI1o3AUekRZ1KKF6yf8Spw+rSYMtcf
 ZBQ29/MOPyDihWpE5//MndsSHjIqjZGNFWpt7fhot2L3Wt4Jojggo9+f933SWr1B20Dv
 nhTa7yMox5VkAlitlJmU8bCVlX5hhZPbbs7wbk5fffn29+JJgjD5zFOq4axSNecQd8PN
 o0WsmmXPegruNQGc3mZyAdfNUR4FdAbtWyZ7in9mFD18HIXV67fjwMoNR+QURQ6XHEm9
 oNsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778493587; x=1779098387; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9hBOOXPj3lV5pqs2TQi9HrfoyJwjeMMB7z0CL/v5tg=;
 b=ZTjCf2/vmmhT8yZ/Pb4pIjaBV3+pjX2qZCHsVdp3fYLFJmF2WhDl9hOK/A7W8/RYlB
 d9WUBT/f9WJf7p5mkrYKuXOtOfqGNDExxf4xt707vyVCIeJ0FmdRG/MGzZ9i+5weF5B+
 sfOxv6qBwXQxYmBxgh45nnTYRWO6MwiOqzkfOi+4C62L8/MN+ykQ86FVoQkSDTeDq/LZ
 IT5cQ0jIgtxo+eG/3vcy7sjeSLIDPx7bMtKzfck4frQhSiMksSgbnP5xUr2YW59XHobb
 vPS0LAGBZTc6XprhRR8SgOQ3d/RbK156/naSiuMvan5V0sejaK3O6mpWKrXeq8ThZptK
 3ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778493587; x=1779098387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G9hBOOXPj3lV5pqs2TQi9HrfoyJwjeMMB7z0CL/v5tg=;
 b=bG/5Rbpcs7fCeTiF0yqXX1gtAQ5BErE/rUOiBmvkMAFRSgyI8Tnr+skNWDNy8NvQD9
 tEQsmHOBRs3c9/BOI+KDkWdacor87BKW4rcCe7V5s8K8AEMvczL3PRhmYGmOV2dd4lpM
 UmPKx6txaPwSiGVU1PmGWivr/r3qsqP8l+8NHUxUZ/0SousV/hX83Kr0joy/wTRHP4aS
 jURALSvZgl3BzqFCn53CpAWKxOFv56bnsfbj3yTHaC0nR4h+Upr+lHC/kwvUNtdfTgkR
 jU+2EfikwbNyQFnlxLIcCebiEcMnIeqGBAAzH9yEwtmyWeLs/kSLRb0PKUB6VYMpTnzJ
 NC+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ94IqzDF3bLg+MuffRm3nBfiSEAFzxhEIWi621dTxgQFbg8dxEhENIeh760fzRacLKn2+dO96dmVE+h@nongnu.org
X-Gm-Message-State: AOJu0YwkemTN6Sda4UDPm2f29Y+HtFNTWb+xDNeX74rA+Wya3KUKhRLn
 Qj+F0UgXV5EQBBFQCp59SE5lDeInkW8dkmFV2Er0ePq8sfvP+9aoqH6EeJ3uoUc3LdtOHIVjBBJ
 he88dWOmqRlc/DFmFj5kNvdMCjx1DAdo3/3DBrYBmnxCzJ8xLNiJk
X-Gm-Gg: Acq92OFDOV7R7l3plJM7Zbljale3I9jUGOKCn/KD39ZJsQCn18GCed6ZSJ4dRJCYDsH
 XWRUG+v3FAMDuDv3sif8aiYxVmGbGJCHmF1Bw9DMswiTvZhBWHERrtBHrFQL07uAN/N/Ppatw0j
 SEJ8r87zgtNpCLeBVB9vQBTNO5DLyZ+K1/UoGmPXT/EPbnHGYLQFsXkQ9NN3//ofNR00fGRds/U
 kSHiPhA7nPC1GtA3sBHJA87XWmWyWbwfBNTpu0gf+Df8DSdWjxg8rm91qt/7C400+813uKoFTBm
 GW70Ct6Q6mS7kaIYivF0Sj1RyC04o9fQcKp8CFFiYL0cSPvbiSSZsTJP61yYP9Id+T8=
X-Received: by 2002:a05:690e:2112:b0:651:c268:479 with SMTP id
 956f58d0204a3-65c79d7b701mr16357573d50.57.1778491672370; Mon, 11 May 2026
 02:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
 <735327c6-f23f-42cf-9b8e-a651d8ee7770@oss.qualcomm.com>
 <CAFEAcA8eKM_DNK4kWX0DNudMiq__uZ-MQM0L-2CfWL39CgCyJw@mail.gmail.com>
 <CAJ+F1C+XzzsGRwLjUCYiDaS9OGXMq5oc3QM5pm4obZAgLP7Z1w@mail.gmail.com>
 <agGVRFsSh1mbKc4U@redhat.com>
In-Reply-To: <agGVRFsSh1mbKc4U@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 10:27:38 +0100
X-Gm-Features: AVHnY4KyvWFlfcbivUpILCv8NDsqvbvQBsq1zGqMIhQHXDXbQFxJV9ax2ylMeNs
Message-ID: <CAFEAcA8XfDGZ4kytHk63BmLfHMOGgtiAxv8M-MaY1Xh060=d_A@mail.gmail.com>
Subject: Re: [PATCH 0/9] tools: Move more tools sources into tools/
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc34.google.com
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

On Mon, 11 May 2026 at 09:37, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> IIUC, the main reason to want binaries in a specific location is
> so that tests find them in that location.  That is a valid historical
> approach, but meson offer an alternative approach that could be used
> instead.

It's not the only reason, though. The other half is humans.
People do run QEMU and the tools out of the build directory quite
frequently, and so the location of the binaries in the build tree
shouldn't have to depend on where we put the tool sources in the
source tree or where we want to put the meson runes in the
meson.build files. Just as we prefer to have qemu-system-foo
in the top level of the build tree, I think it's also preferable
to put the qemu-bar tools binaries there. It's more consistent,
and they're easier to find.

> We can set the test environment so that meson modifies $PATH such that
> all the built binaries appear at head of $PATH. Tests then don't need
> to assume a location for them in the build directory, just let execvp
> search $PATH as normal.  For execution outside of 'meson test', we have
> "meson devenv" which sets up a local interactive shell environment, or
> we can launch the test via the "run" script which wraps "meson devenv"
> for a single command.

I definitely don't want to have to run a separate command to
set up an environment: this is painful whenever I have to
interact with python venvs, and it's not something I think
we want or need here.

I think the least-worst option is that we say "all the
meson runes for building executables must live in the
top level meson.build even if the sources and most of
the meson runes for the source/object files are in a
subdirectory".

thanks
-- PMM

