Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D0DFF60EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Udg-0007l4-02; Tue, 31 Mar 2026 04:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7Udd-0007ka-Qy
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:39:53 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7Udc-0005uj-01
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:39:53 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-66c05fb27e4so2558392a12.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 01:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774946390; cv=none;
 d=google.com; s=arc-20240605;
 b=lj0uCQdU8CoUS5yA2/JQwcvv/Dx1xmHxtGRmDGGSx1dVfbqLZ5aLP3FrkaA+/2fzSk
 N0b/x9eF2JZluJIY790dU+b/82/dyVd67aZzh/oIHk6qdOJmjS08dSXx+Bi1/f0GTJXF
 0iq2xwY3RPtUzSPVF0kV8TFvea7T98w0WH1l6EjjVwI3z5haKV+fzQ/ncVBikhBVaVPl
 Cd988ie3WdDlm22pcK/hK7pqNg5PPlJpHEixjq99zYZkqa5/pPSbARt1+jEDvXvm2hE4
 WKECSDv5mNr6k7OkNCpPVK2MpG2+kFlzWJJl5UtWQ62mTNUdpqxXD9Ey9vsUMCel/9cQ
 8Pcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Mwcz0haakFCU/D0XL+UCk3hnf12ysIU7/sbdyEecCEE=;
 fh=pqlSVlMPviOWkSc6ILme3eZ/un+Im5rZB3YQ3T76muQ=;
 b=H88uQpB5aCGfl6V76rx29TBhn5izrIMdWJ4eakfbRgZ7c920jfD635tCwvDrBmrTV/
 9PixJPvDiNL10rOlRfQKELyipZejcytcMloIm9uAK7W17AAOQPdTtMC6ef5CKGfyQbry
 fnbCcny49coHB7tOwc7i3luRTg5Bv5HJfVVKBcTASLucLzJMmONrTCdkjXtLIacS3CvO
 dd0oBSrbuU32GfcXaQDxEfMC6mLwT2dZbkrLmwMvvhRk6HOkvxYaQfyYbckOFmvyZxwk
 wJJfRoFsVahd732mSR//pvfwHAXB9ea/cd3IRLtcEAcy4g2m8q5MdrjqlT+WqZcBZWF2
 J1qg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774946390; x=1775551190; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mwcz0haakFCU/D0XL+UCk3hnf12ysIU7/sbdyEecCEE=;
 b=TycJuUfaFgcPPRa6BspW0yGu/9cWpNZGtQVXUl/UxGdlLgq6oFSAoJz3y03FWJCYoV
 mwOQ8MtSHEe8FGnbF3azoW9IbZ8FYMzvOJgrYLvO/LDoznw9dLSQXobQX49zxfZMFFZt
 +VwEjd+bkoOcOdUuQcw5sWRzp68ngjr+Jw7pytsQa34XKpLaxGMX1OfeKe/2sEgMfH1q
 T+zU3bLnI7+u/tDKODhz2SqV6vPgl+7ZxKJJMcAT5G7Tx+boWgz7CNXzYkGhn36oI1Kn
 HEzjcqL++2i4LePzL0QorTLnulQ4dt8k0OWziyXJ9E0x6rmU1Agnd5ECyw4LvcmXRk+t
 aQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774946390; x=1775551190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mwcz0haakFCU/D0XL+UCk3hnf12ysIU7/sbdyEecCEE=;
 b=ib7BCUg4vZ5MhIfWEKN9+JQyZpLAD8SHQSrVd86LdS5a0FxGS5BNs4S9ni+M8HA0iO
 ryTlwNwe2+hGFxeJXNte7NTWxEaJMKMxVGShovc3x1AK/IpJ320OdQuKlkpA6LNPDjOw
 UZHeAiRVo4BKPIXwPBbg+d7SWlkAMCDnzcpthuYnH6Ciof/ngaLYU5G6nvkxjsJmAyrW
 iYHN3UBCaPn2S96DAWL7U93RJh5s6QxojuzQYgxWhLRc+a/A0DCq9eNduIykWZFJmALs
 5Tb29JugPzFwJ+Gx1RoLtoi4njAilZsOel5SlXWVOzI4vsSKdq/FbAAC+wo64Wr27cs/
 ++iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURxx1YbGyAPtpviQRiib+CGcLsd7uK3kcqAqRDtH+DwI3cpTN5NSNRT9kV5CZEYAg1hclsnd8wIuc3@nongnu.org
X-Gm-Message-State: AOJu0YxbNFmp2x0ku1W7QDLJgbOTvDK3JPEpjn+XIWyTrQZSIOHG0up+
 p/HRtnRHnPrC9/aalXwVYvinvpTcjdrVHwc2d4kaoZwH9ODE2zRn0QjbbxKMhZ0rgv/PIY+F8Zy
 KkzdzsbYxnfx/w14w41mjuwtpKEkZoKIbvgHKKyC0aw==
X-Gm-Gg: ATEYQzxmWk4yvywUC0zfQlvu+kPblBvTMf02AVLbrZ7c9HpqMvHZFBZdqQXelNDsA55
 8SLCA0eUqWyL6yNBSXo/mEjQRs8D3pMEha0+Ex60VrjalW52IEujAr7gTtlIXyNWV9W0DH0B8mu
 f7Taj9v5DbkxthhETqluNcc2GERjQzL4426wY2Iye4qQa59uEqN24WyA8sBhNhjI+QKQYmDpsaw
 WoG1/eSYtqVtxU1SyY6GSNzvekUjLHEyYZlvYreR2R5NCzH2/VpV+LirQgp/q0UHtKHdg+/2oO4
 3UBJfIyR2UGFS8aTqzJx8HJiDrlSGvoarPWdpxLVyqp4xwtrChrjBW+v5ZoB65uDRKM=
X-Received: by 2002:a05:6402:280d:b0:66c:17d5:c1c9 with SMTP id
 4fb4d7f45d1cf-66c17d5c357mr2452079a12.5.1774946389765; Tue, 31 Mar 2026
 01:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260330212817.992673-1-alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260330212817.992673-1-alejandro.j.jimenez@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 09:39:36 +0100
X-Gm-Features: AQROBzDUwHSHWcREH6AEoocuiDxClHUC4-bw1poaVitRsFeNxsPle02VDAsangM
Message-ID: <CAFEAcA9tmFbxt0Z6GrvMGz38=S_MWtMA7W1P2wVD9seSajchpg@mail.gmail.com>
Subject: Re: [PATCH for-11.0 0/2] amd_iommu fixes for 11.0-rc2
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: mst@redhat.com, sarunkod@amd.com, qemu@demindiro.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 30 Mar 2026 at 22:29, Alejandro Jimenez
<alejandro.j.jimenez@oracle.com> wrote:
>
> Hi,
>
> Please consider these AMD vIOMMU fixes for 11.0-rc2.
>
> This series fixes a bug in the current page walker implementation.
> When triggered, the issue leads to extremely slow boot or hangs and missing
> devices in the guest, as reported in:
>
> https://lore.kernel.org/qemu-devel/20260225145831.28275-3-qemu@demindiro.com/
>
> Thank you,
> Alejandro
>
> ---
> Also available on github:
>
> The following changes since commit dd3ee9c63d96b223c8d41bf5d65392eb898be626:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-30 13:54:56 +0100)
>
> are available in the Git repository at:

Hi -- please don't send pull request emails to the mailing list for
normal patch series. It's fine to put the URL of "here's a git tree
you can find these in" in the cover letter, but an actual pull
request email triggers tooling that puts the patches on the list
to consider applying directly.

thanks
-- PMM

