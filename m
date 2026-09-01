Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADFAC624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Lck-0007We-RS; Tue, 01 Sep 2026 06:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Lcj-0007Vq-0A
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:21:49 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1Lch-0002kd-JF
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:21:48 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-857ff9fef54so7846777b3.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788258106; cv=none;
 d=google.com; s=arc-20260327;
 b=Fv+E0pxFLh2ytZunkQc1Rt1owQlDDFGgyD2jpk3DGgIX1qR94RpcBfZKWfy11879iJ
 fLxEGI1ApErUUDelqEvZeqlbVCRge7IKKjwdDD/kxaUUgWNp5cBLmQjL+blnEYgnVfWQ
 qkIoCG5Dtk/mzcRySmgDA/MgNjv47nyxacpX/XUP+dntOBkkkM5dnxqYNlQOK6ENgeVu
 jrrA7jYJIObUWuQIjrjwIZxjgDIaHGWJ4klfAZytpFysVCvL6p733ejNk5q8Z+bJw1Cz
 vN5RxqmdUalDeWtny8/vPsZCV8k+EDDlhb8lkDg/6lOBVj7u1+EfFYM/U1CRL5QH3VJc
 jp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=saqhellrFWocQ7FADiaFFQw3HqBJcvRBLe6SXMt4eVE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=bxLIW6e/5UD9Fy8jdizVvGRg20o4gAYYJWOucIg4Jh4TDv3TSHg/Cc+zKKjhngeB/F
 WRb2/xVuINy/Maw1zxvVCwgmXS4Nisg+U2qo+por3YDe0ef49XsTt+ZgyV9vB37Gn6+S
 0n6RzmsXgai823U+hwIkCdORUxwg47Rzw5Pfb4nuCK3rHpQLAq51VcXP/3H/W08n286R
 lAn8riJAinySzsamx0arQTCEFwIY6u+uf0rbmY5lX725gco2GP3XQfSypDikspRTaRwI
 YKFFL6p5O4W3CX98zuCGu8+uuUPjQ40aPYLg7WJWMUM4oAQb2+uCM5fo2nAB0HZDzYzT
 NQeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788258106; x=1788862906; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=saqhellrFWocQ7FADiaFFQw3HqBJcvRBLe6SXMt4eVE=;
 b=j1rDMGJgiOo165ANmiuXTKn0jnS0NftloiO173b/TusE2aPbzciBWBzV8wnAcp4met
 t10M7ToXx1N2NUzO/WhUYKZ5CrUQ1ni0Bxxi1JommlpSbuiP2n5H3cU1pKLV68OvGoDK
 KYkyF1Ydjn6nfBYcr5ZdVq43bJs+3Kirmw9VYt1U2taZcQ2JCShf/B9bWaEUfFcuvdUM
 al17xzL+1ysXSV93e+GQTklWmoA2PXSJCP9hhIANtmBtdwDZu12JtEdy9k40S97s+CmS
 VtbkrkU+nhboqi0yIBYuAc30zk+1zofP+IoHgS55kQImUwDZcNO3ER3D3rHtrsel6iLD
 myNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788258106; x=1788862906;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=saqhellrFWocQ7FADiaFFQw3HqBJcvRBLe6SXMt4eVE=;
 b=MhFmNGKhdxCwUz0LBcd19DC9QHeKs77EcNUUxJakB28kgXhnImwVUSAVljT8d1QpA4
 SBpoDdmwlhcF91ucoWSSTWHmAEAMITy4ZMKIIBJEhkFGsmbqU4PwuRuGx7eMgfqOiaz5
 s3IGF3YnvH82dgwOOoI4QYhT5B+g+/psMRG7YJcaqg18L1YhTsRioSLxhI7GTh7kSQBz
 IZ6LLdqw7q95j/v+pWqxCmjNl19s7FMtGDK42DGk9hJxXK2q3trzkfPYHGmMR9nmxWi1
 bAb+x12A2JdhpbFvquUuMSsq7pG4hhwoYkgJR+uL5rPvHirikuUgp1C8AeCkcYZA9pKy
 ofXA==
X-Gm-Message-State: AFuF++mNk+ks4FSYU7FK43F0CZ3xjZ1+om8Gtas+oD46Y/RNF+GWllKk
 bIrFqstSdfpKURT71zUhjLOwk2rXUryF+V8VM9zDFTiYFf5cNWbs/KHgoJsSJxsjAji2hvwgUnb
 A4A0wurn1agFCl3s/kadYhQW9uz5Uc7eZandsQM2uIw==
X-Gm-Gg: AYBFou0VZnYwzmdBIDWoGXVsZsGT+lC5Pb+S8sbUYyL2NyzT2sorCNmz/60MMl7lAlD
 WqBW0v1ilR94d2Xd5xxy3hvxucSjhBjoV+i2k+4vnQ3scpMQfFvaAyVcwo9Xff4AX5owppK+Gbq
 dzJI72Xe3ar6aveOWQlD4I3hMnvNeK4F2eRfXFIuZKy3q7WyL1/2cmP3EQG+a/QSoGh+9rEfmva
 vn0YgAym44ZTcQX20z/uJg+ZYekvot3dEU/V9GUHGTWa5NZuwwnJTqTKtG1g8zD8+RlTqxCQcmr
 mrDiBtcyTfdQlat0FhHjDq95ed5EqvSLEamzINcYC4U6MzllmvMt4u8Lc3iwTpFegTsKubF6C43
 Tr7mgQ9Q98H1gS7LUI9zRmrfIyvxx
X-Received: by 2002:a05:690c:7013:b0:865:7a80:36b7 with SMTP id
 00721157ae682-8657a803886mr65663587b3.6.1788258105617; Tue, 01 Sep 2026
 03:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260826174213.614571-1-richard.henderson@linaro.org>
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 11:21:34 +0100
X-Gm-Features: AcwNN1VBjtHsQyYXmN1wu_rgG5KRPdv8GejsjQAP23VsaVLskBfokbtEjQ_1Cqw
Message-ID: <CAFEAcA9bC_26m49m-aj9OJUZWiauTD=a80bZpybXpuAi4AcvNA@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] target/arm: Implement FEAT_SME2p2 etc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 26 Aug 2026 at 18:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20260825213000.221822-1-richard.henderson@linaro.org
> ("[PATCH v3 0/4] target/arm: Introduce cpu types max-v8 and max-v9")
>
> Changes for v2:
>   - Based on max-v9 split.
>   - Minor patch review changes.
>



Applied to target-arm.next, thanks.

-- PMM

