Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC930C3601A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 14:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u144D-00026k-9e; Sat, 05 Apr 2025 10:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u1449-000240-SR
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:00:09 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u1448-0002PG-3D
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:00:09 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso26741425ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743861605; x=1744466405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=6+IVVyPfN0q9iZOpsY7yXmBnw1CumL3ANdpqFueJfH4=;
 b=l73PKz3E+v09zBsxyrFhTiQzijY19ufwDJ49ZQgOgTG8NXae8N92DN3cFjZfA5qmmn
 dgrLsh9D/tuSwDROmP0tlVhjiw8qNYUf0fQ23RjqiOUyS9LnWOQnT6y9pBiodx8eJl73
 t4v6mZWoH/VdOnq5fHpvC2ARl7/qLGuVUlrRC6kjRVyUelCDnDHowryjvzsymT0rrNzB
 OLSidWnSjPSlL/Kdy7CyuR2dgJRpE2hGkW5k5k0lLxUP4LPFa0wtL7unpwflz8sVxlel
 4iUnZwSC7iuNBkIAF6LH86lroPf94PGaQJQuoBHvS5OqFAv8N5oAq03djoo17l0HmF0O
 fUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743861605; x=1744466405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+IVVyPfN0q9iZOpsY7yXmBnw1CumL3ANdpqFueJfH4=;
 b=ef2qvT/4KN2l9zFPu3iikr6MiEXLc8dF36rv+hlRlFJztZTWEkpAA3FMUd343tf+y4
 oTvz1JJMqKHKLTEgnue4w6DFENKrwo5saKDcIvo1kLTWvDp0J2Z9Lstrp4mfWtsHZxN8
 vxM9bSsKE/gRkUL8eDLhLV0tROl6rA8i3v3/4ReZ6TWqSW+0BDSCh97dXSMG26XZ7qsz
 oUmVXbtmuyo3zCvugX4LbA0tbwloR4rUujym28jN9SU7Fc8lX7bin6KyMEE1ScTCdzrW
 nczP4tkxPU2y2ChIeZR5UBPEguSXbJzOhVt58Z8z8DtPxSf9No4xYe6P/M1HbsOuCqLV
 NSAA==
X-Gm-Message-State: AOJu0YwGJHdom8sBY0hr9u0269nEgXfBC/5gu/id43vfSE1e44XemQkC
 cVuvRhWME5dd2rmIgV/oNumnZctWPyxNpkmX5uHPZyeuD7czgoDyIApLjQ==
X-Gm-Gg: ASbGncu6PgQsYJdwv+ugpk9Y5PTG1gYreC0DbcGTiKhELfdf121YF8GcFmKEsl3sLYe
 /Fb5Jp8vU2NsYcMBKbM2/xtJIe4jgLOk8G258JJczGXlqJRKB+kfZtFS8Gr5nzZp3vXqxFN2DBZ
 gE57B/rOezJcA2dYK+bmVDW7YX+7jNCAbRJHRkPdVDq71cOuIijlzRbstUNYKTLuQF5Yw2AgObB
 myoyBAMxGhjs+A+Ne+74WAEp9KE9VQeToqKI39ejo/njyNmftWme2CPvY/EAuqqhr31yaP84NK4
 t/F/m11nRhj34Y2ph3fPX91nqFFocDSXwJP0JoJy88JcpNinRSXh+7At/A==
X-Google-Smtp-Source: AGHT+IFJZKLAmY/GR+l89d4FLlCFfFw8pEXJkLk/WMGrwMIsDnV/s0b4Rh4mXQQf2G9r9BzZUsoX2Q==
X-Received: by 2002:a17:902:ef09:b0:215:a303:24e9 with SMTP id
 d9443c01a7336-22a89a23f48mr102561135ad.3.1743861605145; 
 Sat, 05 Apr 2025 07:00:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c27b3sm50333035ad.97.2025.04.05.07.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 07:00:04 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/2] Add property to support writing ERSTBA in high-low order
Date: Sat,  5 Apr 2025 07:00:00 -0700
Message-ID: <20250405140002.3537411-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series is needed to support the USB interface on imx8mp-evk when
booting the Linux kernel.

According to the XHCI specification, ERSTBA should be written in Low-High
order. The Linux kernel writes the high word first. This results in an
initialization failure.

The following information is found in the Linux kernel commit log.

[Synopsys]- The host controller was design to support ERST setting
during the RUN state. But since there is a limitation in controller
in supporting separate ERSTBA_HI and ERSTBA_LO programming,
It is supported when the ERSTBA is programmed in 64bit,
or in 32 bit mode ERSTBA_HI before ERSTBA_LO

[Synopsys]- The internal initialization of event ring fetches
the "Event Ring Segment Table Entry" based on the indication of
ERSTBA_LO written.

Add property to support writing the high word first. Enable it
for dwc3.

----------------------------------------------------------------
Guenter Roeck (2):
      hw: usb: xhci: Add property to support writing ERSTBA in high-low order
      hw/usb/hcd-dwc3: Set erstba-hi-lo property

 hw/usb/hcd-dwc3.c | 1 +
 hw/usb/hcd-xhci.c | 8 +++++++-
 hw/usb/hcd-xhci.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

