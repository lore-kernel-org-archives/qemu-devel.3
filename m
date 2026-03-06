Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A2EF01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUh0-00077E-Du; Fri, 06 Mar 2026 07:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyUgx-00076r-2I
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:54:07 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyUgt-0005hH-7e
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:54:06 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso8948032d50.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 04:54:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772801641; cv=none;
 d=google.com; s=arc-20240605;
 b=SEklqxMUPfuEZ1sm3Uu6BrprTb5nKnzsxH7d4qx/S7kgyARfaJt8w2QWFQrwjLv3J3
 xQ9TeTcZVuxAFIhEF0GEiUgMOBEIp3XesyzGWPKAr2XjSN8sh8FWjsjvrNc8a0gANlI2
 C1GNU6xV0H7ELZ13X+/W5m4+BadQV8EccH4muJLEoCEAJQB3mx1WI2A95yDCkEN9pBfE
 iqBuz481zc8xJs8tTFt2SgRof4lI1b5uDivEtnLE+1aq346R+UPL9hTXDYsrIV/sLzzg
 sRPs0E5HeOUpFYHpUt+0Ef7TWVweFa4LFIWenT6FTM/qv1W1CAHQMYhe+ryKO7Z4nPex
 h/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QyDfWh0EHX5c1EIa/rhvrNnOwWKhsiPsTyq2mW/PJZk=;
 fh=2AG7pyJWoK8vpbNM2hKMbyLkNzNu8REApNtwJBETDlE=;
 b=iUs5AmN6RRHf3R4Fr4qGTObtuKbNg/gp5uJcAFIzLnJ2zZRUxfBu3EdmPj2hGhMPMU
 emtWt4HU6vEovdx9ZWWLrT9PSI9+QOos8Sw0JPFlozQvIuy3uf1QIaoSxqVMcCryAyLt
 VzJTVTYMrQ9Q309RxYN6adzcIrBohwTK6lG46OLzLUy61/dDLesOz9Q7vPpOPJbA6kWo
 g7dvGNmFeu1cSuWKCt407S3WAtyLRI+aYz8RNdn7QMS6ANvk35/Jh+sLA1uWeybDfsE1
 q7MMLUJLOJDCfUpAXkPM8ElJ77BUPfYmCn3o5GAl25yyp0lcA9MJ5SwIBraa0HGrBQ0U
 lTaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772801641; x=1773406441; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QyDfWh0EHX5c1EIa/rhvrNnOwWKhsiPsTyq2mW/PJZk=;
 b=kG+3RMirq3gMsaL3TyZ/XvKGXaVa8JAsy/WOM2/DxDvSoV6qMFRY8XX1YUtCZGQsNJ
 hD9He8voOL9BQpOb7Sl6nxFRhzbXWXf9pttrsA2aMqL6ZTlJwMg9wF/dHY5hCHYoFFDa
 suXt/WnyvOkvCjYUsytUg6xglAbQGu+ufE++AXKVP6k7+/9/EO8norgiWQ1yPTgl7xX/
 hbXx57VFkUkn0rVFMV+8LzXIBZHDoyGDyMhcb0y4i3NitU5A6fYTtJj/Sh5bB1TxL1lz
 0y++U8OBnh8b/xE2OmlCM+KzU673YWg/+PhP4n56uBf8l62sDgeiY+9Rc6fz2HDgj9Za
 bgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772801641; x=1773406441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyDfWh0EHX5c1EIa/rhvrNnOwWKhsiPsTyq2mW/PJZk=;
 b=YQoIL+5f4HwbL+l+qEb38Y2vxVx+YyBLTntolvgYiVxMH8+muyvcamqtDINTRj1ysJ
 R5XPscHnzw7spl9ziWePmfmCkOzwYBEPSRb6NELiS35xb7Nm00/XQ2y+eHt2pjFx+m3v
 mzf+CJWocq2cwKsw1c+JDVul6UtDWJi08/SRm7uqLXe1V/uzUq8U8nE3FxP7oS+Hv4O9
 Lqdk0ZeY7bNrvcKhVA96zO2oVTQErYyvrdnl8MStdJbaGscSie25chVSmzNweV9siOQM
 UL73ky2kFlMK5ogIxIXW5WggXo8ZzuV9xUwB0a1nepyj+l/PElJvU2HUs4l0E9EU/YeX
 CZyQ==
X-Gm-Message-State: AOJu0YwMA8Heve71CBK6YYQs0J8Eqa4KGtFhPNqde2Mt2UNUQVfBiv36
 A41y4va3BBPBMiSFFiFunAcLFezSYLty4mb6xgRmLB/HF6K2yJPa3JN46wGfXmFUspEB+CsMrTU
 CuBJsyB5Hzw185pzlQE3qYEfOfS9P9zob+XTBsQsXczediImEzooNndQ=
X-Gm-Gg: ATEYQzzTc/UxEmsEjpf8k4jmLUogUQitAGP7JIdGcGRKjeIk13r7PSu+YxfsgBqNSUK
 Jx0CUe6wjlJ7s82yrND2nxrvg6aCKE8c+UwizvU2odQrET0tWOunyisMpxkfXX8HE+QhD75oYb5
 7rlwQVhqtPw2pUPSA7KsYd2y9mmdppWvYgGFCZGBdewzGO+CmB12Barkf4o0ljH/GDIQ2x0ge4s
 KoK2oNuNDmI+9UdtA34xrIApsfiaeM1JT0YQD+oproClznVgOXNHSLwShZCMVVfhdVTFg+owJF2
 yQDMYXBYAOjSgCm5QaW5+OsmLBqnch/ZaPzYFBP4Qvcu5rE+w0XQw+/UI7ZQ+KeB8Rk=
X-Received: by 2002:a53:b1a4:0:b0:64c:c34c:60ea with SMTP id
 956f58d0204a3-64d1429cc22mr1262174d50.54.1772801640878; Fri, 06 Mar 2026
 04:54:00 -0800 (PST)
MIME-Version: 1.0
References: <20260306120555.2035421-1-peter.maydell@linaro.org>
 <20260306120555.2035421-7-peter.maydell@linaro.org>
In-Reply-To: <20260306120555.2035421-7-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 12:53:49 +0000
X-Gm-Features: AaiRm52HSIL6qLrVWOTWpCpfkak-O272k45vy821NTn72smD642Tdb7aMeWSCDI
Message-ID: <CAFEAcA8ZkfjOki--iPiXGhZ0CEZ5OVVcTtqdbLxQasBW98cMxQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] MAINTAINERS: Remove Chris Browy
To: qemu-devel@nongnu.org
Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 6 Mar 2026 at 12:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Chris Browy's listed email address is undeliverable:
>
> The recipient server did not accept our requests to connect; it
> times out on attempts to connect by my sending mail server (gmail):
>   [avery-design.com 99.83.249.127: timed out]
>   [avery-design.com 75.2.78.167: timed out]
>
> Remove his name from the file.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 37c93f0611..dc4b837821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2169,7 +2169,6 @@ F: docs/system/sriov.rst
>
>  PCIE DOE
>  M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> -M: Chris Browy <cbrowy@avery-design.com>
>  S: Supported
>  F: include/hw/pci/pcie_doe.h
>  F: hw/pci/pcie_doe.c
> --
> 2.43.

Cc'ing Huai-Cheng Kuo in case they know an updated email for Chris Browy.

-- PMM

