Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC57C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOKE-0002Bj-7Z; Tue, 06 Feb 2024 11:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXOKD-0002Az-7U
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:29:33 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXOKB-0001hq-Ji
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:29:32 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d0a0873404so39220431fa.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707236969; x=1707841769; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dFe6+ysmgEERT2tHM6k/XOW/h52MxlnaZ0RJZc1hswo=;
 b=qnh7bkbgJ6jaaj8s6HK+uHpBF6U+vXlquXOOiLGrrAgGmR2oddLxE52HWrRBqYNmP5
 WcOcdPZ+/f+VA8Bm+9zIr4V+2MJZ2Zbaf4tq2qsj3az6QIHFXGGUWJ8XLxW9z5lVKpOP
 7vT7jaM5sKjMFdEJ9XgqazTzGjbEPQDLa75gwjZ75LokTKg9HZQmqbKiQCsC9ErlOBu0
 zzK0yl5PEM+JYsaIuZAdeKiWWc5jR66dkFVoEljbzXcf82HLm90SuWqKLYZbE/avzKl3
 bopLQgOgwkjrDHt6r5wuJVi2whHra7WMmlpvrfp9raFk2bVU4SWme1dWASOMNJcfr6yX
 yfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707236969; x=1707841769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dFe6+ysmgEERT2tHM6k/XOW/h52MxlnaZ0RJZc1hswo=;
 b=m6FYRDKOdsuLAXYvpSiiZ3XnBXJkO3q5dxM2qMPAHZPgzZDf2rnmz3q6WPSw+Sanrr
 28zK30EC0FYzCvkI+7Ih0nQFUVIwuDn5xFRV00tAsTFjUc/arp0IGGIYzKfpx2T0wWRd
 Kk4jva23UDZjzMD4qUvM16xd4LvSwh+UAcqxGVTxs5scX3UlGveE8yBKcQl14Prc7QjM
 3WEkEa/pcMLy0SCEqInIjV8aD1CrZkO49xHFQDmfAj43Rne7s+7L/flJ5WfrEYNxBuqv
 rdrvV2y42zL159A67m+dbZjkUhhr3bbz8GEozZ7bup16BKjuGRHx2Ur4vkRvU/Re660p
 hMSg==
X-Gm-Message-State: AOJu0YwVk7zkBqFmXb7wnOoEyCqYZIod9XRTetc9ZvOiFdgsF1FAduDi
 BpaKZfbV0Jl0rwGwak6wamuISPokwUbcMrFMLsswCCJEQWBHrf4vjAxjlXbvnvrzG4TdbQHuR3E
 Qx84gBWvFKZJNhcKfCPLPqjMADVijwM4oObneaQ==
X-Google-Smtp-Source: AGHT+IH5tiWKnrN4YECdbev3G4VE+nib7t9YiBkY32tqFNikDWrm4L76/M+fy9/lVHZ9tPZlFJG6F6qm9k8T4AHEnPY=
X-Received: by 2002:a2e:2e07:0:b0:2d0:aea9:d8d7 with SMTP id
 u7-20020a2e2e07000000b002d0aea9d8d7mr2374895lju.29.1707236968695; Tue, 06 Feb
 2024 08:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20240131002800.989285-1-nabihestefan@google.com>
 <20240131002800.989285-4-nabihestefan@google.com>
In-Reply-To: <20240131002800.989285-4-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 16:29:16 +0000
Message-ID: <CAFEAcA_gkQz7q+PhiqrVd+YrVJvLt1H=Ypp4av9qn+6mYC6jdA@mail.gmail.com>
Subject: Re: [PATCH v16 3/6] tests/qtest: Creating qtest for GMAC Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 31 Jan 2024 at 00:28, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
>  - Created qtest to check initialization of registers in GMAC Module.
>  - Implemented test into Build File.
>
> Change-Id: I8b2fe152d3987a7eec4cf6a1d25ba92e75a5391d
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> ---
>  tests/qtest/meson.build      |   1 +
>  tests/qtest/npcm_gmac-test.c | 212 +++++++++++++++++++++++++++++++++++
>  2 files changed, 213 insertions(+)
>  create mode 100644 tests/qtest/npcm_gmac-test.c

I've just noticed some issues with this patch, though it is already
upstream:

> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 84a055a7d9..016cd77d20 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -230,6 +230,7 @@ qtests_aarch64 = \
>    (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
>    (config_all_accel.has_key('CONFIG_TCG') and                                            \
>     config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \

This adds all the qtests_npcm7xx to qtests_aarch64. We deliberately
don't do this, because those tests are tested under qtests_arm,
and we don't want to use the CI minutes repeating them all again
with the qtest-system-aarch64 binary.

>    ['arm-cpu-features',
>     'numa-test',
>     'boot-serial-test',

The patch is missing anything that adds npcm_gmac-test to
qtests_npcm7xx, so in fact nothing ever builds or runs this test.

If you fix that, then you run into:

> diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
> new file mode 100644
> index 0000000000..72c68874df
> --- /dev/null

> +/* Check that GMAC registers are reset to default value */
> +static void test_init(gconstpointer test_data)
> +{
> +    const TestData *td = test_data;
> +    const GMACModule *mod = td->module;
> +    QTestState *qts = qtest_init("-machine npcm845-evb");

This machine type doesn't exist. How is this test supposed to work?

I tried:
--- a/tests/qtest/npcm_gmac-test.c
+++ b/tests/qtest/npcm_gmac-test.c
@@ -24,7 +24,7 @@
 #define TYPE_NPCM_GMAC "npcm-gmac"

 /* Address of the PCS Module */
-#define PCS_BASE_ADDRESS 0xf0780000
+#define PCS_BASE_ADDRESS 0xf0802000
 #define NPCM_PCS_IND_AC_BA 0x1fe

 typedef struct GMACModule {
@@ -196,7 +196,7 @@ static void test_init(gconstpointer test_data)
 {
     const TestData *td = test_data;
     const GMACModule *mod = td->module;
-    QTestState *qts = qtest_init("-machine npcm845-evb");
+    QTestState *qts = qtest_init("-machine quanta-gsj");

 #define CHECK_REG32(regno, value) \
     do { \

and then it passes some of the tests, but fails on

ERROR:../../tests/qtest/npcm_gmac-test.c:262:test_init: assertion
failed (pcs_read(qts, mod, (NPCM_PCS_SR_CTL_ID1)) == (0x699e)):
(0x00000000 == 0x0000699e)

And the gmac_module_list[] array in the test claims
"Values extracted from hw/arm/npcm8xx.c", which is a file
that doesn't exist.

Basically this is a mess. Please can you submit a patch
that fixes this test so that:
 * it actually runs
 * it passes
 * it's testing the device in the machine that's in upstream
   QEMU, not some other device in a machine that's presumably
   in your downstream repo

thanks
-- PMM

