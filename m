Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56ACC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhrRz-0002c2-Ak; Fri, 01 Aug 2025 11:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr8e-000156-Sa
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:53:40 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr8d-0007VY-Cn
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:53:40 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7086dcab64bso10175267b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754060018; x=1754664818; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K2Flps1wUJ4YKWz82H9+fZOE8T3TMBZIQw/IC7Xl6dc=;
 b=VTbs8FOYinkn735zhKfugyOSl6iV/sVwOge3rU9RzmTMxxf0fqBwy6ibx2UBMyqkr/
 Pv/15ZfWhc41ssy/xtz44e2IOkigU8LAnbypGQnRXU4cC/MieVJWbKbMf8v9esE+Vocb
 5FQJoyxUtgBE9GtWdMn5T05Fs90eRyxBPBbcTDBIGMWx1uBbj2ZmO+eHi1AuR7LVYAh1
 Zbqnu+n9bbzt5lRkzrgwEnMWaOkwZnHf0Hhil2jko43ISdp97nYaP+gSLaJgvbxnMCQ9
 OQ6cjKrTRMvj4giI1H9aA8xyIdltFYD3+0+eFEy8QNBHkYBFnvCGGSO7Hb80FPMqUtQ+
 PO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060018; x=1754664818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K2Flps1wUJ4YKWz82H9+fZOE8T3TMBZIQw/IC7Xl6dc=;
 b=QrsD2/HSkQe0GbPaf8eNbCZ3rTyv46MaEJwU4NqSWE128BL/Lq/yWJjDoBmPOiJLqG
 tciLIeXUrkn497wE1LrbWmWLOn2JjjbDMlzu1XgTCF/aCKjr2ybhh9eY8FWBZl778UjO
 FmBW+leRPcVRBlAJPgB/p3DxB/rGA9SWW+bJCrl587cIhTkwybivnOKoIxqBEI+xaLGm
 DzFQSAhVXRI/iggzTrCsB0Z2K4LF3yURnKOcB4bjVMtjQ4Drk2m57BQSAILPXUjdV0eI
 l6FcR+s3Tek3CWj5TAZAewZ/786PmmgGxqo98agR74zWXRU/RYtRwQ2YvJ/D0+/LyOVf
 Bs+g==
X-Gm-Message-State: AOJu0YyqFgMR2z3TBn4rAh1IKr9o/8bcibCs71k0/sNTShk+lWCM8njI
 dujut90EfUej1Zh7cec39wsod3C8rm/ug+rpkJlqMWWcsbjLwo4tTheBO9Tl1uU6JRsEaxPndYZ
 0KUES1sT1391yK2BJjZHdZ1w5Xzn83s6Foaa5Ir2bFOPL+yKFPVAC
X-Gm-Gg: ASbGncuZ2NlLPEyoKHfk9To3jOZ1wZEsW50Mh+0h1A4AMUcTxql7nHVsoMhi/cjjahp
 ARqDAfJFqdBBfmYZDfNIelj8UPgszTsq/L0bmTmJelbFsNKi2nldyz65CwVnuR7bE2XtZF5pvwH
 88MBlxM21ITwZJs2niA8cEoVKxXt9w3Dp6bJ1oVsqQM/064HSOrBMM4fn8EfKzSCQDYaEH6f/vD
 gUT0YP1qCxjqe2PC74=
X-Google-Smtp-Source: AGHT+IFoGeYTCNdrqoIgJ61vpSmhoBfDKiOGJgtRMqtrdvag1uKxLjjP1L8J5sWMC1Zay4m3RAqQtIy3MeT8n4npbRE=
X-Received: by 2002:a05:690c:6911:b0:71a:125b:784f with SMTP id
 00721157ae682-71a465a8269mr135735527b3.11.1754060017781; Fri, 01 Aug 2025
 07:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-4-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 15:53:26 +0100
X-Gm-Features: Ac12FXypki3AWBRT95r4DN2_cEHv_ASZ2UN1bLm69AtWL_ZEn0sF92kLaNXUNNg
Message-ID: <CAFEAcA-XN8uNLUb_PJpt1ZLm4P=aMU_hr_a9SoeH98R=9yPFGw@mail.gmail.com>
Subject: Re: [PATCH 03/89] linux-user: Move hwcap functions to {arm,
 aarch64}/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 30 Jul 2025 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For get_elf_hwcap and get_elf_hwcap2, change the return type to
> abi_ulong, and pass in the cpu.  We must do these targets at the
> same time because of the ifdef dependency between TARGET_AARCH64
> and TARGET_ARM.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

