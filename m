Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D616BC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHa8-0008Ds-8T; Mon, 27 Jul 2026 05:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHZv-00089B-Hr
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:24:55 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHZt-0001p7-FX
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:24:55 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-81eaf3709b4so25441947b3.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 02:24:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785144292; cv=none;
 d=google.com; s=arc-20260327;
 b=mbrYX0/DYG6fdHriuMKelSRdyO+lpUzXUj4KOsxXQAPc9AwKuwjye8br9rrJ/a11Zy
 vtCvKV/btMQhSRCWoDQwaBuJDD1amRgloierEi9PiE2Km0xma9NJMoHWCJBALZY0n8C0
 6jwaEGaLJ0maXlis8bSy9149HB1L0qcGrx+3UlltMXWya3FmnsV9apO8NpcQ6I+WvJFA
 XJBf1BXYW0iMhgJCKqgvfR+yKa1nzEftWdeJ3Ujym2FXWMQWp67i6BB36AO8SJv1DlsU
 XOSf9N/3xYuu+uKmoySAssSeAlpB738RgQygJBjvAEPrHXlh7Ot5Md+7s225QRVaSx1G
 eKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f/pvHRyl96uTa3Z0GhAVxmp+JRzUxt8s2J7Y12ag6/4=;
 fh=8B4lXkDaKU8Hu7MP52jJmGXpjXI9QItJ0o6HZHTuCWg=;
 b=Ny9lZYB3uKmvuIFkazdMsDTu34A79FPrZQXAzoAN08HXWEM7yaDHEFbvtl3qrUx5vY
 Rf55LrLERR917f58EaFBUboNeCcCOQGctII2C37wyWaNEhEQr8+1/0QkpQtECCVx7SMs
 OD6CbQ3eGNY8t3RRNvj1dzS5ifjhJX0vqtV7jOsh+R/StK+7dKQIGRDWfTPWCzE9eXV4
 qqTZwdLDgo9ja++LXm3A8qJo0E6tgdUVgeDRnrOkjCW5m1zVdlY6XHVzn6lhMAdZtuUD
 NzbddgKuCwppk6Xm+rmp2obqC9Ww3XbowTzwMMZuoBEQnEu7SQN/Zas614ULGfG/17De
 9OnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785144292; x=1785749092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f/pvHRyl96uTa3Z0GhAVxmp+JRzUxt8s2J7Y12ag6/4=;
 b=aFqW1C/o7XuqZmaVXA4f5bXcFfdZ17zGxkY7Mt47lsP9LEogJBtmrWTS1dgKJoA3Bx
 L5/GpTIlX/ue05caos0Lu6HNMPDRvFzpZlJs2mw/rC/Z2N4aHc4lWZV/nnJeOb0BFtlK
 jcHvQpD7XZnn+QAEIlnPxnY43IfRkG91hwTyxkfD0HGvAVCN8SH+IjC3MnPEitQewHr4
 sRey9UJ72P/jo0peSCPVdeavEwd90eVLgNcmK7ZJZlLW1XAUAPG/neFi4tSgs0C7f9FO
 FCH7IfQE2u4j/kZY0LnUHs7dbIXbq54fVcVsTDW1jH+Lbbmo178kgEnCUEB2UnRXFOFj
 Lz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785144292; x=1785749092;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f/pvHRyl96uTa3Z0GhAVxmp+JRzUxt8s2J7Y12ag6/4=;
 b=RhGlhmrhOpJnlmYdbptmJ4IIrqRBLQU1yWkXvCaoNVnGADT4d+ikctHtVRasEvEY1J
 EumPEzJpf19spM29PSYh5dkAOCeuRA2gRWykTfilX1Bmiv1oOoWj+HJ+akHrVFtC+Z0F
 KP4wnhH9oTGOYIWteuVodz9SV0PChQDGyYurxFtDnEP2pVge3feRD/Z+H0nxjuKo92JT
 hARzwsPmEMLa369QJTDmNERtD5Irqstr2mYVIgLEXgb0ExSkWlyDUVWRmVBw9fhjt/nX
 6wNp2+y8nCLA4XeAN/MJFc9Q2UmFgDvJmtPWChR/lMOPjuUsuNtTRgyV+XKNUdfn6JIY
 fKmA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxCWA/ptSWBPVDfgX0ZcjJU+TtwU8XGTXko9gnp76bfTEk5SoHkaQya/NR/1O3uVdilSGAsrOCZUnU@nongnu.org
X-Gm-Message-State: AOJu0YxoC8BIpaZUjP1Rai6ki5rEYzN4FOqEwnU3fxPNZczendomSd7h
 62QjCGINmob29WElQGX1bbNcIe7E9dn9o++tl5NBeJMf02ywTazH7ruEye3V7RPcb07+0zWsJdz
 /i9e4WnJIZF2N4F/DlpWtC16n6/LLWSIdciOEQgDcBIUhhf/UZFG/
X-Gm-Gg: AR+sD12dSZVjJLphUcWKvOFqBHUkhj4JmQ+ojPWPrBTSkI8qrZsdyTMlJsCzTGOX5dD
 vvv3i6n0Kh8z9dbEjGG9/CCEnK6UMbV99OUcI7pBClwJfL245rfyFKGFvPmJCDSl46SPe1JtZmn
 j1E3ZxehubOuPWQtLRWZLzLlKfaoM4J9bdh30neYXtoSDSwUYVXakDbpMaEPH9HT8tbEMKd0M5D
 V2ungUgHGayPFS+5OyOXXcEGv4MXcJn2Ee73BcO30oamf4FSpo+e6DESk4+4gBOa9jBsDtPtuE+
 5wdSu+NMZ/kr+9qPe6rAJhlmRcUislltZTZx9LyWU88bBw==
X-Received: by 2002:a05:690c:690d:b0:80d:c24f:b790 with SMTP id
 00721157ae682-81f69cd9014mr26183567b3.5.1785144291794; Mon, 27 Jul 2026
 02:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260723065320.1314072-1-clg@redhat.com>
 <7e4a2ca1-c930-408f-a39d-d926bd8ba788@tls.msk.ru>
 <6e54009f-2e84-4a22-9316-b0db8f9a1d1f@redhat.com>
In-Reply-To: <6e54009f-2e84-4a22-9316-b0db8f9a1d1f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 10:24:40 +0100
X-Gm-Features: AUfX_myVZvr5zIp_bqWi-kSdVGKi_3jSaR62UAlqoGpF3ofcHaO0r0NyUGw6ES8
Message-ID: <CAFEAcA8SyaLgY1boJMcemOdGqArktkmZJiNugi4PuP5Kd5ZHRg@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch: validate Fixes: tag format and commit
 ancestry
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Mon, 27 Jul 2026 at 07:14, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> Linux uses:
>
>    my $git_command =3D'export LANGUAGE=3Den_US.UTF-8; git';

Does that work if your system doesn't have that locale configured?

-- PMM

