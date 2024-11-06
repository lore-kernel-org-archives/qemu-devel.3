Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA4DD59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jpU-0006f4-8Q; Wed, 06 Nov 2024 12:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8jpS-0006ZG-5L
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:28:26 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8jpQ-0003YH-KB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:28:25 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so9275089a12.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730914103; x=1731518903; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJ6Z0IhablAHNAznrVoBdPj1g4rbQlkoxqgA/azFKb0=;
 b=ssFJwuwAY/3cPMkDB5xqhdFcwMVHTIrN90TKepTMaYASCJyNklKJvJZc1xZe2aeh+S
 cc0lR8qzQBKpCtUyigijjlFlEp9g1tCWXr/6ZOgfXtb8F3snu4LPPLy0exMuvDTjf7iI
 KudwwMCxBhFf6MiBHerdgXHOeleiC01LtNXtzGYePDiX6zXPyfUVYP8O7456wFgJZXH7
 JYzEMytALLa4KiAOHz2CPiUQxisNSBXuJOgg8/+uO7jk4pzVWibgFyH1bkdh07XQKggp
 cBd4ISSAVXFotcgDjrgnhJ6OB2X21ig2GLOvZ+cwUJ1lFCpfN7kHlgcrQUX5A3QHmXHm
 Pz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730914103; x=1731518903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJ6Z0IhablAHNAznrVoBdPj1g4rbQlkoxqgA/azFKb0=;
 b=V+WFHE//MmXNZI5TBJ+8iOhCV0QZSvITeGGKiKaP26WC2ZA3qxvvALT+cJuNitQaiO
 +jTn05C0fL6cLVbCf5Ziap7IYRX/XzPNqOmYtTMgs2lX696E65i6aOSrTtS7Zh2KUfCv
 TD21iVOwZeXIxSxnDXoNvG/nLiJ9rz1/jBiOTPcFimrOt47oZiYeh3MbcX+Tz5NXHwIe
 AMOJWYJ5tY0pzLC3b4466so4p0ArxB/dXzTTPyAE001mWzLdZZTFskkklMbQtofO0kWM
 KYgs0L5q/Zjmd5bGclbkY56p9c6N3wzqZXGOCxoQU53UZaGXw9BOWj6SNen+fPqwQXuQ
 LXdQ==
X-Gm-Message-State: AOJu0Yw38vCg10TqB32dLV56W3Sx6p2yM/H05DmAICt6MecPbcZ/YCze
 wIAps7PevkeE8cSYgjPUTjsEfPMb52snsKnsP+BvcDefHtReNzKdgoHEPCNrCrcnLhS9ltKN+bE
 qcqjbbk2rMniUZrX4RCDpGWgcWaymYgUGG5UD/Im+bGKl8VJq
X-Google-Smtp-Source: AGHT+IFBTx6GNM8x53dGE9+QQOT/z7oQxRzMO1rsdVpcGdk8CLTKDaXpIwleQZSgfKv9lq9jhlwxh4vW6bRhNjIIoFA=
X-Received: by 2002:a05:6402:13ca:b0:5ce:df13:2af2 with SMTP id
 4fb4d7f45d1cf-5cedf132b47mr8986408a12.10.1730914102869; Wed, 06 Nov 2024
 09:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20241105165841.3086136-1-clg@redhat.com>
In-Reply-To: <20241105165841.3086136-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2024 17:28:12 +0000
Message-ID: <CAFEAcA9mmhmfXF8-9ragcp9XPfxygf5OgoAkv6DuCynnDCMYzQ@mail.gmail.com>
Subject: Re: [PULL 0/2] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 5 Nov 2024 at 16:59, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 9a7b0a8618b1293d589a631183e80791ad7bf5=
52:
>
>   Merge tag 'pull-aspeed-20241104' of https://github.com/legoater/qemu in=
to staging (2024-11-05 10:06:08 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-vfio-20241105
>
> for you to fetch changes up to 89b516152777a8b54b117d90690ed9be62ba1177:
>
>   vfio/migration: Add vfio_save_block_precopy_empty_hit trace event (2024=
-11-05 15:51:14 +0100)
>
> ----------------------------------------------------------------
> vfio queue:
>
> * Added migration trace events
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

