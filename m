Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5FBEB1076
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzPm-0003ZS-SX; Tue, 10 Mar 2026 11:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzzPM-0002ww-Kd
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:14 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzzPK-0006Z2-Rs
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:08 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b96e579c0fcso448852366b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773158045; cv=none;
 d=google.com; s=arc-20240605;
 b=Djqgs5oCireBxBArFYCJb+gggcSUCaz/ZtCB8NGpoKx94zGXMx4dk/s+t2I50S4nhg
 TBcTLZzLnMcbpY7uNcyUtyEMfxWTElayMqDZaCxQDIWw4VzLwg/OUzqNyJ7RlKYbXjco
 kgWgBtGJEjNNVN23O+DsjQrnFPoNTAMuiEmmwArSF2oyfeklfFp86NB4gw+0e7NoKpqw
 ssJe2+v0vR7usPsKyWRcPOxQZWlEYoSMaIO/J2G7+fQI5uDY5GftKn/fV3iCpeVNm0xn
 dYN4pVKSK4O/3Si/8r8sJq9xZ45raHVP1iDunGqfLQml+2k1+U1B3twPNaZX9uz6S0tM
 E/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8uRUy58M8oRVnlilkQ3mDqq72nvO4jzRshdqCZ6u+Nc=;
 fh=imp3a1zOamCT2wVB4mhTeFcsaqSUAsHzgGZj1DD4DCA=;
 b=iUlh2w38SvsIxTRbYUqSMFlZJvresdhY/xKyF5TpGhbLxxOetvvuQPaKYJWy2nc0VP
 FMXpYnStFYwkWPr28MtdwyfWlU7TM0uFk6PidYwuZboO65lJPnGq9Ez3LhX6GT7ig0iS
 m1wD9IUSPdeNifNtN+KG3PbIFrqQbESsNednuu1pk7wBRCTAOPyC4rGVgsA+foC5GlWS
 k5naWSeHpQLQqLVZth3RnqScUiFcYkHoKEOBwN5DLckPKz2Gt/2XFg0aVzN49GPFRlCU
 08yDt9uL9f6hy/QsC7YMCHdevaeDT3/29kFaE6gk+/IWa/2iSnE/MzcWKaWQ7NvFPVQf
 T9IA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158045; x=1773762845; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8uRUy58M8oRVnlilkQ3mDqq72nvO4jzRshdqCZ6u+Nc=;
 b=DoaaVXVtTCGWGxatgE9r8QP+gIBLpMxM1d3G/iLRCAGNqspvQoIsdI35UbwKrwCRb9
 rbnO8OL/MsPdyA8asCu/4UKAHpN5ZZD0b0s+auTjzKNaAlZMoO/4axMqszFpiieXtUcM
 /hp/1lgKzp8aUrXes5uBuntq7y3+8Vo0oglghjUJXZ38VGxHn+Tp+q2y8S31iG5ixeZC
 FekAyLnPRL6qRrRheX5i6eGy5wPLFFVoMiiMX1c1wJxjuxAAE/KpEH7/C4yFHsnWnZR9
 dXkSrczdPigmCBYWa4iIvCWjhs4DA3ZxGw8bki49yc83/TN9ZSED+PeH5hQsv/u9ibuC
 0xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158045; x=1773762845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8uRUy58M8oRVnlilkQ3mDqq72nvO4jzRshdqCZ6u+Nc=;
 b=wM3UQP9nHTeS/mUsNs6SXOmbKujmJc0S34jOXoJkHqPfy/ZyofSW4AKZzpxhmdrSGx
 FJEDNhw3uoth5mdqiaTrCvaUkagUjYQr2/9O9HEU8j/Sd/vKkseTvF1yYjnwM9CDLIH+
 S6TiDypZINAtVYdguPpU22iRFfsHbHacZ4Prb8OWy/rpcLdCt9aBVBGFCQ+I77hpD5wX
 DW6okz7rTZ1S6olUjnft1nT5kX4r40KxvlESiF9cZIqunuYfyTG8XfDLzXzNU8s5j4H1
 uM71pFOA6qje3fjdhGm3jQ3haMIhtTNhVSJpfhy4N/FPyVYwDg9fze82pKSkBgJEulgq
 cKjg==
X-Gm-Message-State: AOJu0YweBfKMpu73bq6qcyJWAZ1gTKPsz4Gnx8vLr4Bg5kk2SYMpQDJ+
 w33amzrBo0EsK/Nlj81XpmuBg3cSW6jsvUMpnrbocFLSmbimzZ/p4baWUG6GNbBGLE6WTuf1myq
 R+3aJSvL4y5Nhasb66ynSaoVG1CfX8liOEjSEf6gr+bsTKv+UKFwPTu8=
X-Gm-Gg: ATEYQzyXR9VnBgOyUvrqaeyym8k4NS2H3JazBj9rLdJPgldSd2xF3wheKgCATMVY4er
 u2nXnjey9S07ZiPw1au2C80A+itQW6SSoOnj96ighHfQpW0wBvaThkMlHG+5eAlrOP2jTrPCNVB
 TCKK1nSKLSpM22GqHLRHSr6tMt0HIel/j1dlD0EfNJy36XDoZRocWEKBJXof/EzThjSAM7l1m2T
 riTeqO8VUcXKCsqCzcT1LhLz8VbABiXwZrXs8H1cdZpUF9qf939P3+0SmpjLOFKaZx7bKeY6Hs1
 4ENMBIhfpLq40XObw1s+V9J81R8pcqeHA8+/AqypdU4lJbnen6h0IWefF3K/DjYOQERh49IdQvS
 sbQ==
X-Received: by 2002:a17:907:98d:b0:b93:5351:7e30 with SMTP id
 a640c23a62f3a-b942e026243mr881588166b.61.1773158045253; Tue, 10 Mar 2026
 08:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260310151432.92531-1-harshpb@linux.ibm.com>
In-Reply-To: <20260310151432.92531-1-harshpb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 15:53:50 +0000
X-Gm-Features: AaiRm50Ub_zCH62mI8pp4eJ0RHbHcRxwJR6A62QKNFZEa-o2K0xxC9vfOAQ3DsI
Message-ID: <CAFEAcA9FjtvJanmbvpAXMjY0zURZch9PruHUsXEXOtPiVJgarg@mail.gmail.com>
Subject: Re: [PULL 00/10] PPC PR for 11.0 soft-freeze
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

On Tue, 10 Mar 2026 at 15:15, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
> The following changes since commit ae56950eac7b61b1abf42003329ee0f3ce111711:
>
>   Merge tag 'firmware-20260310-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-03-10 13:32:30 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.0-softfreeze-20260310
>
> for you to fetch changes up to 8d00b61217814fa6809768b8d2ca13167ad4106a:
>
>   MAINTAINERS: Add entry for MPIPL (PowerNV) (2026-03-10 20:23:46 +0530)
>
> ----------------------------------------------------------------
> PPC PR for 11.0 soft-freeze
>
> - MPIPL support for PowerNV
>

Hi; this has build failures:

https://gitlab.com/qemu-project/qemu/-/jobs/13431423411

../hw/ppc/pnv_sbe.c:279:29: error: format specifies type 'unsigned
long long' but the argument has type 'ram_addr_t' (aka 'unsigned
long') [-Werror,-Wformat]
  277 | qemu_log_mask(LOG_GUEST_ERROR,
      | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  278 | "SBE: skiboot_base 0x%" PRIx64 " exceeds RAM size 0x%" PRIx64 "\n",
      | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  279 | mbox_val, machine->ram_size);
      | ~~~~~~~~~~^~~~~~~~~~~~~~~~~~

You need to use RAM_ADDR_FMT for printing ram_addr_t values.

https://gitlab.com/qemu-project/qemu/-/jobs/13431423381

In file included from ../hw/ppc/pnv_lpc.c:28:
In file included from /tmp/cirrus-ci-build/include/hw/ppc/pnv.h:28:
/tmp/cirrus-ci-build/include/hw/ppc/pnv_mpipl.h:54:9: error:
'__packed' macro redefined [-Werror,-Wmacro-redefined]
  54 | #define __packed __attribute__((packed))
     | ^
/usr/include/sys/cdefs.h:217:9: note: previous definition is here
 217 | #define __packed __attribute__((__packed__))
     | ^
1 error generated.

This header shouldn't be defining its own private macro
for the packed attribute -- use QEMU_PACKED.

Not a compile error, but I just noticed:

This header should not include osdep.h. The rule is:
 * all .c files include osdep.h first
 * no .h file includes osdep.h

Also, the fadump test failed on the functional-system-centos
CI job:

https://gitlab.com/qemu-project/qemu/-/jobs/13431423958

AssertionError: 'b'fadump: Reserved '' found in console, expected
'b'fadump: Firmware-assisted dump is active''

thanks
-- PMM

