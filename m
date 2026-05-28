Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D6ECD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdFG-0005Zm-UZ; Thu, 28 May 2026 12:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSdFF-0005ZJ-7j
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:06:05 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSdFD-0005fE-Gd
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:06:04 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7c58e6eb2c8so131614417b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779984362; cv=none;
 d=google.com; s=arc-20240605;
 b=JlFx8A9vrw4fgCJyvij2dMMqy1HD+ERo/WBSQ/GnJZXG753qjRbmX+ECa+KdYnqiPR
 JFgdLZNpTIfXIb36icYAK+wOkJM+JSaU5TS8W4MT/GMtDgvaC6nm4pT3jW0oJIdHAbIx
 AB1jMaIFXk2ZeDFl8Ob3oM2P3WXgSJ5aQlLr3aVnMpLBUxLEn40o+I0Z7HPEX+CrbXJQ
 wf13rPbYjl7erWOyUMhWSryMCW9WbFsJJcnAt38A6deGzQPbxzI0x3JcM5ZNUmVw868v
 GNR4nKfBM7kpfditbZpCAkdGHpDNBwFBg8n3eotp1QgXUJtxSOWojp28J3qQgoblGVHm
 xgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3WPDyIonSBCgGlVYifqoCBmZfz+ZrP/eDqswI+ER1VM=;
 fh=MxUZYFALgpSnGiUkZbdUUjGBkVtUKFyOTGo47VeJhD4=;
 b=eRIsYeII9V+wKU+1FNhrcCpkTfWzItNL95VaaZzvwCz28Ih8ZzVe4XO1sPov9TJYs8
 JNB/WRMQPoXb4nhm67uvQrHg+mY7/Lu0PlneVcEVbIfnjVIvKqeJor/k23uabfqK8ebp
 baMAKxJFz55ctpewE7hBAQzsIjjX+Ei+VXEZ3NX0Pq7jvaz0HlsG6GE83IIcrQHAloZo
 AKJvXmTc/3xRUSYIc2qB678wJSoEyBx7SClve89j0Hd7QQ5wUORbrXRWoFueqvTfxQjV
 wvAnNTvnc2Q0idF0NBEvK9CBqS9X4C7ZyTffdqgFJW9BQYeyV92U11CjqPRjLxo0F2BH
 Vgyw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779984362; x=1780589162; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3WPDyIonSBCgGlVYifqoCBmZfz+ZrP/eDqswI+ER1VM=;
 b=ee7+NDaRhxiNCcD8CMRAz7DDnl8s3LwTgY0BNTFDU34Ry6i31G4GUH9GPgq+5sNl+S
 P0PcXnUpqqRWR+YD8tNRC9MuPKyH+pKo3V/NezlXVyoGpB+0yv/KJleZUYJNoZIwjc7/
 LnisVVpdtt9n1T+DIqQktAvCiIB7iv0X+ENMJA3NXdNqyLnvAnJpRpG8EywsxrrEIdM2
 2ahfpzdQM8Yi0x964PTH9emnnzhzXNlYNp9h8do7osHx3H9Zw1ZxYPpfJqSUEi+wsAM8
 icgYF9CD3CZ3v9eiqIVRMr0k5mLA+3kEdoFlQ3R4B71Fn5qPrPfj+C8+nz/fh9kUXDZF
 YENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779984362; x=1780589162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3WPDyIonSBCgGlVYifqoCBmZfz+ZrP/eDqswI+ER1VM=;
 b=f087lH2LCs2etpANMHK/xNwB7l19wOKpFDgSzN/n8ZnzgntHwnn58O2S1Jj/X8ohvM
 3s01rKHoBwlhUC99bZ62iv9q5j9r+B9pmlVxRasgektYQ25nwQzWo3O0FiC896lPC+t8
 zf/q2DMkWCYAQbeHzWErbKGijTroH+X0J678x5GVXQNT09Oj1zxNdjdZd1F1qgwrZibF
 5ILab8nYgAUQxUzzXYX7tfNsEi8ga7oWvbemDei/p8Md6LbTJwjA/YEwPgYvZAs8CAkV
 CgkMcoUxwnV0dLz6v/tQJJcyoMRNwplDc8/6OW8OSFy9AgRrCnHqSk8BhggG8Ws+3y09
 xhWw==
X-Gm-Message-State: AOJu0YxHq99eXOeyQvt0NSm6nUedPu9YQttLKwffgRv6hz9XVjs58Wez
 YFAMPpBlkms7IFecVpt79jQCnv7ZtvFlb0pXJeoDHI9+Ag8Lj8dVqvInMWSep3v4/VgBDG4sr6H
 AS1qR0hZMUIg5337IGvE6fpl1NEI1fRGSp11gsyo3gA==
X-Gm-Gg: Acq92OGlrceVJ5Xo8Yy9zYSnvSiY8+dKxaCdcgnKezsazzuRqY/seHCIboKch8d0zQx
 j1OOzDORd1jL3exNBbp5vw5vf3WdXB1INLFbuLNJfyNhmUmtzz3olDPdXJLPduVvDrOPVNXQTBz
 Vo0qE9XcTHgNsT2zavFs/Zmr3JLMK8LxM44P7CfRkueqmBqWcU5ilIXNP3QzRKdBZ8PzZchVprG
 wiUVZwZIFQbdUaHdlPQCa5UPe/sorTnWvboHg27BZQQ3Gksw2/vgQW7n+vFnO/2yNxiK82beILA
 /9yIgyJuav/awKtIT1qzZNkd2/fuF16y0VBegcnBNKSvMIgzE7sLq/Mfh6XTpXcGUVJSu7/JQ6e
 3MN4m62+VWri1
X-Received: by 2002:a05:690c:368c:b0:7dc:2f45:d036 with SMTP id
 00721157ae682-7dc2f45d29amr46894057b3.41.1779984362125; Thu, 28 May 2026
 09:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260527114320.1581552-1-alex.bennee@linaro.org>
 <20260527114320.1581552-2-alex.bennee@linaro.org>
In-Reply-To: <20260527114320.1581552-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 17:05:50 +0100
X-Gm-Features: AVHnY4Kzu_yhLWNBW-7DlJzmuj9Pp4fD2a-EoJBaUpYYftjQUzoGD_6uwx3F36c
Message-ID: <CAFEAcA_-rY7A0Q2GZcFBVd4WOn8S5TXM4kaAnz_Gzn2wHLnikQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] target/arm: fix WFET typo in syndrome
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 27 May 2026 at 12:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> A stray x slipped in and we didn't notice!

You might mention that this didn't cause any actual bugs because
at the moment we don't use the "WFET" enum value anywhere, only
"WFI" and "WFIT".

thanks
-- PMM

