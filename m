Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F61CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZyk-0000E3-SA; Thu, 14 May 2026 13:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNZyf-0000Dl-K3
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:36:05 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNZyd-00034J-ME
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:36:05 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65c7a459105so235161d50.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778780162; cv=none;
 d=google.com; s=arc-20240605;
 b=LprW4Wr0ijLK3PFE0YnHDKApafrKaQV2xnTEVgsuTI6kGBal9pUbPVR9kNLbHscn5N
 pD6rXr8p7A45UWld2TJeU0hE648s/euw2qBtw+nGm5zRWyuqOz3gXU6BwQ0a3vQwGWJR
 moOqvpVvC1LP0DIwNew80LKDAYgYxwdMqkUJ1o6r2de6tYIacRPEu7Ci3EYdHYADhWhu
 dVOon/FWLh/fTXEwA/KvEC2B2S5RFKT3OweTGeb/BtyKv3TjEuQ6GCRSAd2UZ29q+LpP
 2FT8cyult7F3k2oJrIGIwqCwfGkZ7khvi2WiY4o2WauVyD9bTKbYqQdLYkAeSCg5evgV
 skSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oDgOKfVGUrQWBlYdPZ3hwHwt58ogjpkTnj7319BA9b8=;
 fh=+RWi3Lci8WhnfnLghM7RWP/oBxhW2BqfGTnRaZfzOtM=;
 b=USVDUPqAtCVDNNQmkDKP0pXXaoP5AJcF7U4CHH2DGXN7Ki7nk/t0lnGkFwH4ENWbGK
 ibKlJsK8IZqkGh48BkxkSFNEbBtylbQt5dSBmwh0AoPcD2oInXAAR0iXx7+8O8JmutUU
 FvtI1wMxhTYnzWuwa4/dKbftfqvsmk7SishpN4Wq7YIzc7ryazsWSViHrE1EK3oniSsi
 S/qTvDScZuMYE4DRSQKUBkKQPl7SHsF3QPg+qBkEho4a4SfWuHuPo1acfSDQcbFaiOHl
 oYYD/Qc4M4kvzspjc6wP+zyJ18V5ocOjEmRs4TT1oMUKlgNajC/bOEjRA+9K6fzfSnVZ
 BZ8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778780162; x=1779384962; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDgOKfVGUrQWBlYdPZ3hwHwt58ogjpkTnj7319BA9b8=;
 b=TzyWm9eHB38Sn9UOetl/xKOGex6LYsEaVitYPwKkCRf97iv4ll3PlC7zSkEch9ZPlx
 XfMfmVJ6Ig+tQTSRxZXAEAkFbHxb52w97ZVbMbXkwKdMCvjIVnNqiuQth2snwQ+OFQwx
 x8HdrdLuLMCIxSDhwppyMmtWW2+HDHV089vFkN1RWg9gVUcYZ1pwl1dV0WlKjyr+HJ0B
 V0+HfBSc+H8MME15ggAjt8sUxsn4euOP/iTJ2lQm55zr5sngNaSBQg0m2QHEdJ/h2dQY
 crIA9fNj9Ca0Pu/oEEo1z8EdLDlR4B0udO1NBZkTopBo9qXg2/swNGT2XYmQeE/KOdb/
 mKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780162; x=1779384962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oDgOKfVGUrQWBlYdPZ3hwHwt58ogjpkTnj7319BA9b8=;
 b=Cak9IiMixiwGfEb12CfcORcu1zKl9wL4rOH3W3IzVnCzNd1f2i0CWuF1DBKU5BRiON
 lhg0cH4j5OmZCCz4m5F05UQdDpJ2hdCijHurzvgyKgHsjII5nHSDg0wPlGWsI9lJLv2F
 vVImi0/PGycJLDsOMzTxJIVDsACHefI5HBK55MixZm1QqItRcsoEioV2uV1FlyPrDQKL
 DTIfFit0B4Ab26YCmmhan5bewSBm2nzV55bK1R7RGEGsxMrPhsddM1tT3NYAlxwSV1Tr
 w88QAnH61cxxUUpKGHv2IO76+N8ajpacm4Cw4OlU/quUsFTsOHtePmcmSdmmctAbTwP9
 FNsQ==
X-Gm-Message-State: AOJu0YzZ8MA4pONjXWBMNlUdGjOvlfB1IiAsQsLseQyEmB1FuO1x88k3
 6N4l5nRk/C889INytq4Kft2aQ2t5g2DooCzwCUx7ZCSYr3Tp/u7Bghq6+aGpsOXlrv5ycwGdlC/
 QgPifGZAd3w+dEIrdB7Oro5AaksM2ILnxXCvcY+yNlA==
X-Gm-Gg: Acq92OFjlw7xu9iyQVfgisGi7SQdRfcYUl68UnvbReKTzC6gNqO+d6kzu9Ey7/+v5Gb
 TV0ICtr4+JNMYGWqwwmVnfvaSxX6kRNRAQsn6T83VxmgK3845irObnech0nnW3uE+M9eoww8Z7G
 voirQOYA20WUE4M2sR3syKFP/FQJmVus/75srute70HUvXRkKl+k6AK22taTJZMY/oMTOneX5tS
 Q2IBlf/iMcEW22LkLDDnZsCoCWv6MkdZBcdCmeWFLkvW4+v3OnIwcL32//psqMvbuqiS3zBtv2v
 Cnm0w0o8/zFq524NmdX6c1yJ68nzt/j0B7lOEP8Hx9G9EYYfaarnuw9WUwr/bKdDw5E=
X-Received: by 2002:a05:690e:1587:10b0:65e:16ab:9d71 with SMTP id
 956f58d0204a3-65e215fa7dcmr380293d50.20.1778780161824; Thu, 14 May 2026
 10:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260507160518.444797-1-richard.henderson@linaro.org>
 <20260507160518.444797-28-richard.henderson@linaro.org>
In-Reply-To: <20260507160518.444797-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2026 18:35:50 +0100
X-Gm-Features: AVHnY4LQLdGQ4v_KtSNlf9IWMaNAxPaD7e9UlFcEZpqb-c17SEqAjE4fNT-KpCk
Message-ID: <CAFEAcA-YQxWu1NQsEnNtPZydKWkHnzGFpJs-edj99iTRweMD4A@mail.gmail.com>
Subject: Re: [PULL 27/29] fpu: Return struct from parts{64,128}_scalbn
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 7 May 2026 at 17:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> At the same time, export.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Do you have the fixed version of this somewhere (i.e. one
which updates all the callsites to expect the return value
rather than modify-in-place) ?

thanks
-- PMM

