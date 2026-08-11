Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543ABC5CFD9
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjbv-0006La-KE; Tue, 11 Aug 2026 06:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjbs-0006Ky-BY
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:21:29 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjbp-0004MY-ON
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:21:28 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8111c0c7561so34222077b3.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786443684; cv=none;
 d=google.com; s=arc-20260327;
 b=mZ/jbqEftdqk2PzkpdP/IuPKfJavca8e+IDlAxEbCQckB27YrDQyuPkFu2dxE7Y8F6
 d7bPtK8l+UZtZO4VWYy4FTKHOqp0WqA2aCf3ngxGyFFvZxJPszSVA3nRwvBaiuFsxYeu
 XwYuJIzLPwi+ftIxpQoUzJPNj1pk5NewjOAZBCk7k/CrIsV8yiITJXmP0paC/Kgau1p8
 s2iihH+d6ShZzsBkxKkJ9wq4MMO45SZhN7xRd7C1fTCnB7+2wwhyZT3U/bkE5E8IXsjb
 GppPnIcP/R+1E+1jimwELvOtLMQJMXBwxtj2NmHzGk5D+EOrQKvNPdiB6YfzvVzSNq4c
 Q9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y6AZvIOMeqq+xm9kNHugzkoGRJ3Z04fLImudWqE4IYE=;
 fh=Bkm7h1qePyNu6XewviHipxJh5Gb0B/9a4YQ4WVdINBE=;
 b=M9MoKYwJfZLypSjmvwuk16oyokS0Wu9PZiuF5bMavZ7Q8/xH8LEpb+qOfl5opv8XjC
 fG8oB630JyOl6zTLmAJGENb6rOgqaWzY3NX2xah3O3K6+k/iX77SAOJ3ockLQkDvPHOw
 UYaTs+zwmN1qqPJEb4gQKwKwo6NeglGbCAESiYTDm7LAAs4Dx+iLdKhWu9qkqE0LloM5
 s4cnuYLdszHSAou9u61XebGbrBoQ2TvX6A2Zw+H0X8+aDahl7Ll4M2uPpdYGb+K/w8ev
 XLhVnOTQ1AaNjf2HOVm89e+QzMFj9R8vCExZ1S0uBmxu6Fjea8c+Kh7OBOtmtiUgsCSw
 D6SA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786443684; x=1787048484; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y6AZvIOMeqq+xm9kNHugzkoGRJ3Z04fLImudWqE4IYE=;
 b=VZacTRzuo41sPeXEr/p3cIxcI98cbnj2rM+I6KU+6jVcSp1NyN4EwBWyDkCRaO2XQj
 xXrnk7ZPjZKHgiJ/CguWFCjoEd2/th2ulaFT8t308IHDCOB6MQhijXJqTDMVoBtpRTha
 SqpBPEGUh+3HARax/wO/hW1VSiFPlpRuRHXKO8zOJkFUTlFUggK22O9+4rxcUvk0o8hY
 uJ5FyQSOSyGwkuDHuMIkONJeaZYwsaZZvXyO4U6CExt6J2A+eZ1QoEs0f/TQxnCbW5Dx
 DckCX0JmJhUj9XcI3BRQBQx+mFOYS5zbXYDi2O4AuYb8aSymjY2WZdRL+7Q799itBPyn
 X7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786443684; x=1787048484;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y6AZvIOMeqq+xm9kNHugzkoGRJ3Z04fLImudWqE4IYE=;
 b=OfzH6Sj12fuSVOVm/8sw/q5PXPaupRTyLe+icBq5Fs1exTz2EpwXSLNJJynX88z8o7
 OR61ALwIXiHQbLrlqzCxIrV1+YrQprd/tMvZ/xrJF0qDS4GewDAbfKgLoscdn8hwa7Kn
 W9SCOHJ5kc3CcElXbwFM69YHqj3pYrd2lg3Fdz+SvYAStVXQfQLgU8ZHgDrusq6fn0ut
 D4pH2VcH2oq2+A3AIx/JKNGZy7DBQ2okvalUsloczvOFycwkIp2L6MgcBBeKyxWmByfn
 Y7UXIUTcuev9+zIfLT5E7jnPyyTpniouTqNHPUpgGpCe2oUL7hUb9PMjGebIRZnugdwA
 th7g==
X-Gm-Message-State: AOJu0YwI5X1ySmyHx+KlKEK770sJQcKDjCaEXtRjxKFBPxWNb0PdQ+vR
 PMCQEcWkeg/RHv7iohnq9dEbRX5Db1rf8T16UVTHqT+4f2yIAqLyyNlYfDxugCXxnfkWTVxM5Pr
 MYMzycV8AR8OBHtq/8Sn1yyUslvdlHeAnkO/RxN5atQ==
X-Gm-Gg: AR+sD13r4axcE8h19yOwmZrjnFu6ZSg3LWusxKQey7by4Dv/g6k3zUOAwELOKLLx5/J
 O/LyPjyItT4dVOgskh6GLPoVZYSI4fhSZpa8naPFhMHs8+Q6eayx1l+WH7SJD9C+ic2Co5/w0Iw
 b2nKmLUjECv/XesFFmxeIgBaWJb/E5pGGloQqaPBkC5mpHViOTzzp84g7+EMPe0Uwc3IAmKLTfA
 HN78JN/Fncb4y2lR/oSKcR5gDBSkxkuv5tR132ZaFhPOv+8RbYr64ziRt++tK4PF+Ec6mmTt231
 uIg+zBRRHtanYe9bbCnUyv+er0vDN4Jjeval6H6qmVLUPWd2uId2pUzwuA9dDZcPe2SqAUGYFe5
 bTwiWRdBpnxVaFFYdBAxW+8QaysJX9547wVDHLlM=
X-Received: by 2002:a05:690c:19:b0:809:fd83:a88b with SMTP id
 00721157ae682-82f28ebd239mr14612227b3.3.1786443684399; Tue, 11 Aug 2026
 03:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260805191257.11303-1-simonxhy0404@gmail.com>
 <20260805191257.11303-4-simonxhy0404@gmail.com>
In-Reply-To: <20260805191257.11303-4-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 11:21:12 +0100
X-Gm-Features: AUfX_mwPDo6LjuL1LyrBvvq4EXbSgoJHfanaE0lE7u8GzdsZJtq8ozUKUIPuTk4
Message-ID: <CAFEAcA99BcdTawef1p6Q24wqMzSgnh74rU6zEF4y5vft22KPBg@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/arm/mps2-tz.c: fix AN547 APB PPC EXP0 MPC ports
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Wed, 5 Aug 2026 at 20:13, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> The AN547 TRM defines them to be on ports [15:13], not [2:0].
>
> AN547 TRM: https://developer.arm.com/documentation/dai0547/latest/
>
> Fixes: eb09d533d87f ("hw/arm/mps2-tz: Add new mps3-an547 board")
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

