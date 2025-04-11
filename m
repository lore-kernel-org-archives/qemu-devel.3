Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1D5C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 05:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u37Jc-0006hk-Lz; Fri, 11 Apr 2025 01:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u37Jb-0006hb-EW
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 01:52:35 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1u37JZ-0002Ba-3C
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 01:52:34 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac41514a734so277565366b.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 22:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744350750; x=1744955550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipUNxCYP9D6EGTGbQI+G26OHbsyMSDuOpAbeSZztd14=;
 b=U/POQEi/bOV4QwPlX55iFnxSWfgtjWuTQ85Pm9WiRtjPgEorGetGy9TRmSFPdA6uWA
 /tCb4mrcbt0GKNGkxzG4IRj4Mcc9HIVUKG1Simx6LIecBI7xA1RiLKcsAqlAoK9zdQEX
 ftA6Hi8cFg5O9dClQhkkQ9V3GeoOqACkZWDRM5RnEL/dVd7ODPZoNGHehlnrSUIBE6T/
 +K3+AMpMD3WoTAHx1HWTZhOE++gyXwbYfpa8Yu7Nli/x1R2VEAS4ycip90dkK3Gy8Hef
 6606GPzzYgHzA18PeUYY+P5R0wPg7ncOwusjBjI+u2/LhpmzuX5dhpqt08PAGN7Op0tG
 ZGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744350750; x=1744955550;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ipUNxCYP9D6EGTGbQI+G26OHbsyMSDuOpAbeSZztd14=;
 b=LLqB/iyYyzG8AKd09PIaxD/SSLpkfRjOZe4vBYJeXCyOgodMjRxWeinno7iV9NzoyO
 rrOtFVkFZ+fhvuPTz2y/Dht4R0sTU3fwKbkQFgZB5GSfMoCFZuY5NBN2OSBGtKbl/nKh
 GuzRey5iy7ojTkTKtOOKKscBgetiVePx5CifdhIFMvOvfIyNYSrvg+DNZAnZwNfyJIKe
 98evImYVtbK6ETy+lt4rbd37+wf4hP8eNmLW4Zxm+4XjvKmUHasuKwH79jVgwCKTB87I
 u8TuCwsmsPsAohRGLxhxcppFsshx95ztvDiaoRIs7jqtrcwSDTYwdRZUi3gyU4Np/Tcu
 7SqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5nidV1QbdWIzaPb+zykpd6SdJRrJbc2uQjuwbmEWsZQQv1j0M67smTmUF2SLlBO+lix59xQCed+UC@nongnu.org
X-Gm-Message-State: AOJu0YzMWQiL0mZ71wJiQqNEVjKGutOxkzy4TkIXYflP9Lb1R+J1xjtv
 FmGL9Z5zh6lLrbyAwjJe1XEf0E/KP8Uh7gOaWZsCxc7A1Sd4mR3a
X-Gm-Gg: ASbGncuGufb2JIy40BLfhifJpITos1FjgWMUWrmJ8WBbAIKkvxIxXmn41QoUWtOVqnX
 xVkf3c7yzThWW/EXsXCaRtYql9TY8O8IENFAnFQARW1II0d6K/8A4v4CE3pDpj94MnImkGSDVFz
 qx7xSUtsYjJLie0cdu7TKt64x3Edq/0bB+ufEMZQK8AYCWa2UfG2QTrB5lpEqY48+6bVrapWziH
 nP1gQpG0P5FLCWtq81zUWpdPb4Jg5mmwvR1aDrrDVL67OHCnX0ruxkBI7f9PcmaRdf+mytOGYta
 uEnQiK3Rq9l9uKlhQyAsYkdqwwwM9XXx7Gc=
X-Google-Smtp-Source: AGHT+IFt9JwV0KgbABr40rCKIj2x2FOk0iJAvvUGrEImO2MH5hXpXmMy76tAgGFqRrYWtN/Q6nAkdw==
X-Received: by 2002:a17:906:dc94:b0:aca:c49a:aec5 with SMTP id
 a640c23a62f3a-acad34469ffmr96801466b.8.1744350749282; 
 Thu, 10 Apr 2025 22:52:29 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ccd5fesm382951066b.160.2025.04.10.22.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 22:52:28 -0700 (PDT)
Date: Fri, 11 Apr 2025 05:52:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
CC: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_Add_property_to_supp?=
 =?US-ASCII?Q?ort_writing_ERSTBA_in_high-low_order?=
In-Reply-To: <20250405140002.3537411-1-linux@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
Message-ID: <E6D78AE8-68C0-4507-B0C3-D73CFFF65A4B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 5=2E April 2025 14:00:00 UTC schrieb Guenter Roeck <linux@roeck-us=2Ene=
t>:
>This series is needed to support the USB interface on imx8mp-evk when
>booting the Linux kernel=2E
>
>According to the XHCI specification, ERSTBA should be written in Low-High
>order=2E The Linux kernel writes the high word first=2E This results in a=
n
>initialization failure=2E
>
>The following information is found in the Linux kernel commit log=2E
>
>[Synopsys]- The host controller was design to support ERST setting
>during the RUN state=2E But since there is a limitation in controller
>in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>It is supported when the ERSTBA is programmed in 64bit,
>or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>
>[Synopsys]- The internal initialization of event ring fetches
>the "Event Ring Segment Table Entry" based on the indication of
>ERSTBA_LO written=2E
>
>Add property to support writing the high word first=2E Enable it
>for dwc3=2E
>
>----------------------------------------------------------------
>Guenter Roeck (2):
>      hw: usb: xhci: Add property to support writing ERSTBA in high-low o=
rder
>      hw/usb/hcd-dwc3: Set erstba-hi-lo property
>
> hw/usb/hcd-dwc3=2Ec | 1 +
> hw/usb/hcd-xhci=2Ec | 8 +++++++-
> hw/usb/hcd-xhci=2Eh | 1 +
> 3 files changed, 9 insertions(+), 1 deletion(-)

Series:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

