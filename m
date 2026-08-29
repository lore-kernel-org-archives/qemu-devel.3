Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E10C61DE2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 12:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0IbR-0001Wp-Se; Sat, 29 Aug 2026 08:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1x0IbP-0001Vf-Hz
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 08:56:07 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1x0IbN-00021B-NN
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 08:56:07 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5b2b92065ffso1960330e87.1
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788008163; x=1788612963; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tBI87hi+w7tju9vmpR81JRr0gonsniLIcX+bUh7+jTE=;
 b=ESJpymtHywBIoIQOnUlhuVd7rtkpvpx/EQz+fReLBYjHjmG2q1ESOrxcRZsK0PVkmX
 G1zaPiedwOzfejbc2U3NC+DE2MfKkuQAcZ/8Et71uL3aeyGPGz57QFx/CMhWmH2N35di
 8/mMNqtV4KLHm6+CYGkUmJJsdGn/BSdBhBc2H2lB95rvUeJH8ADyyEj+TFHc1eEjb7+2
 01INkXKnRv7pD2O3z1ILulaiqV9mThooN+tWzZzPZ6PFVdCatQrv8Tojg1IAEve15GFb
 AgjDmt/Ofux6tkgXkgVKE8c/Ww6vsMRAD6wvGBq97gCRrid/IYqY+mRBH2tsnd4vwDKN
 7wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788008163; x=1788612963;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tBI87hi+w7tju9vmpR81JRr0gonsniLIcX+bUh7+jTE=;
 b=szGZJWWKEMjyGLPtmfjnaTjE4D9QIN4LVGCDL/YnXxWWIAyyLZjhM8bF13nJ2fDI0e
 UN/nq1TBAtJ/ODbhTboPEaUOiiCWPZnC1f1rv7N3467Lr8yZrM/9gPJgedXhxQ8ceU9r
 otTutpRlzcFRIXl+nmPqArqLRhuKKtqGUezSWitZ/idPAx5Gf0t3wuVsdrqbBW4I6YnE
 aOXkrrJw8BOG4887DPqegCvV0pzknG/CKjDMKNj5S1s59Vhz5iI5Ew1uuEaKLyyI6Lyz
 tS7n14D11U6KH/cttcWKIenm4GrB+1WXyt8DTOEm3YG8pVWf6Qetu9E36nNeX6k8nJyc
 Ez4g==
X-Gm-Message-State: AFuF++kfvoFviUHEDGSz+TFIuGP3eFbeCrwkyz90vZpWQAZSnA2SXJms
 xtFOpBAznvp6nxaZTPdHQkkpFBelVQgCUebFF3oQcFuj3F2YySzn5Pw6
X-Gm-Gg: AYBFou1eYWTRgPCpGM285fn+ic9MGrveTgfyu7fSWy4iMHEDzqMXfdIHTaun5PQnB6Z
 LIgyZ+9huGVSGsYajb9UvEBhQt2fz9XEEbvTAs0yJrm3sokD6klzqZsXoVJ19JlD6C0yLmcEIq4
 wOs4hfe4n56Twe2MiOqRwxYIP5q1TPiiYyekG9eRFkhu096CPOtvI8Vt2crvibd5A5KTy9er8Od
 3Z5fNJrpbZZJ2uw+IPXdOhv/GKdaCkVjXXkitgO/6aluLZbMm9fDT7R7Fqhd+Y+CH+n6pGYc+p7
 5cN9LI6UalZGIInJ4kXa53mXSQnfvy1kTHIHa6DQLOJMFM12obT+dk4GXZ/J20KLBxBmpzcqFT1
 iYkTcBUPQX61g+Nysk82Spjpzz52K0GdpDDbUOdwqXafjW7SqB2e3Ze40+iyLrl6oRuo5YcnwWg
 Nu41j5rZuWAkQMXXACJNJXFMYP5BRz/GxN5OONDXVSZXXNlctBwC0pSb+rhQcUn81VqRytyC2ve
 NrT6m8NZNf/+iyZ+ekVwZBrZwO/V1NAK2tmNX4jIjIgYWCxslb/Y8V20dg=
X-Received: by 2002:ac2:568d:0:b0:5b5:e8f1:ee86 with SMTP id
 2adb3069b0e04-5b5e8f1f2acmr3542124e87.2.1788008162896; 
 Sat, 29 Aug 2026 05:56:02 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b5e8a0ce42sm968866e87.57.2026.08.29.05.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 05:56:01 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH v2 0/3] Allwinner A10 GPIO support
Date: Sat, 29 Aug 2026 14:55:42 +0200
Message-Id: <20260829-allwinner-gpio-v2-0-f0ebcb07302e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQrCMBCF4auUWRvphBBTV95DugjNpB1ok5JIV
 Ervbiy4cfk/eN8GmRJThmuzQaLCmWOoIU8NDJMNIwl2tUG2UrcGjbDz/OQQKIlx5Sg0WaMQL85
 3CuppTeT5dYD3vvbE+RHT+/ALftcf1f1TBUUrpNXKaO28R7yNi+X5PMQF+n3fP42OquOsAAAA
X-Change-ID: 20260818-allwinner-gpio-6ea84117df94
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Jack wang <163wangjack@gmail.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch series introduces GPIO support for Allwinner A10 and
Cubieboard.

The support is focused on input/output and interrupt functionality.
The qtest suite is also updated with tests for implemented
functionality.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
Changes in v2:
- allwinner-gpio-test: Added test for interrupt triggered on both rising
  and falling edge
- Link to v1: https://lore.kernel.org/qemu-devel/20260819-allwinner-gpio-v1-0-2a64866dff11@gmail.com

---
Strahinja Jankovic (3):
      hw/gpio: Allwinner A10 GPIO emulation
      hw/arm: Add GPIO to Allwinner A10 model
      tests/qtest: Allwinner GPIO tests

 MAINTAINERS                           |   3 +
 docs/system/arm/cubieboard.rst        |   1 +
 hw/arm/Kconfig                        |   1 +
 hw/arm/allwinner-a10.c                |   8 +
 hw/gpio/Kconfig                       |   3 +
 hw/gpio/allwinner-gpio.c              | 465 +++++++++++++++++++++++++++++
 hw/gpio/meson.build                   |   1 +
 hw/gpio/trace-events                  |   6 +
 include/hw/arm/allwinner-a10.h        |   2 +
 include/hw/gpio/allwinner-gpio-regs.h | 228 ++++++++++++++
 include/hw/gpio/allwinner-gpio.h      |  41 +++
 tests/qtest/allwinner-gpio-test.c     | 538 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build               |   3 +-
 13 files changed, 1299 insertions(+), 1 deletion(-)
---
base-commit: fa19879df1658f96ac07365fca8835b7decd6995
change-id: 20260818-allwinner-gpio-6ea84117df94

Best regards,
-- 
Strahinja Jankovic <strahinja.p.jankovic@gmail.com>


