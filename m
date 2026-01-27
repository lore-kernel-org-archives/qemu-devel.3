Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49949D2D8FD
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkgvi-0001Kh-P3; Tue, 27 Jan 2026 06:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkgvf-0001Jn-Mt
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:08:16 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkgvd-0006ao-UU
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:08:15 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-790884840baso51499457b3.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:08:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769512093; cv=none;
 d=google.com; s=arc-20240605;
 b=XZlCpy7OK6eeicgZnfvB+N6o1zvS1KJ08KWB1PapR/oDmop2MGG2Y/F+mD1gBEyqRn
 8LRJBjpwxufDi9TLG/w1njGlMHYYUN4xck4P9uwRhEFvuENJjjCm+HDOiAmdfIbz6p1+
 J09xV1QJIrOzzKHOOIk9eB49y/PxzmylxQeXaMd3y/RU+aLmMZMIF8Kg2HE7PkpzR63U
 w4A0Sm6NZLNutG9JVc+5EjNiJvGAVXnPmmjDA5YaUYtFvIpyY8CvCV2k5VyMh+sB10+r
 xpGz0j9MVwh4dSbPB3t6UwDgj6IQ4hYHUrn6FTpgZn0lmLg2l/7ggJ4BktHMr/mYofO7
 QSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5eJNbDbH7i6gHxVBVKbxXmOUgEgn32aasXekgexxr50=;
 fh=dXHoilmhhxY5vg21Ss6PZGFufhldebBfEzqm3qMG63M=;
 b=jkacFg4k+euirgNF1n4jEHzYyJiztx7nwoWxbjZTI9zPiRSqGLKo3FKF3kqYCGdtjn
 3Egt/a11QtxHVWD2w9Ec/nDtCp5y3Xl9MmCbhVVuqYNnv5tYpY6QsGbSqS5ZQOucStan
 MdWx9wDBCjwTphkokrz/GkOHycmCE2zGqijNxnIolKOvNU1f5vFVtXJZuULLrTHyD3zQ
 3ZRYQ1Oa/1NVcg/upruK4ZoznFI7w6SMhJ5a74IMJ7p441GjdDWgggPhlGcYv+fsHLka
 m3IZaGX0byRFkBul8fDQ5r3qW8pLRFFayUsaGT8TRtEadEyhc5/KBxKFpzuvPjwu7aEY
 d+Ow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769512093; x=1770116893; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5eJNbDbH7i6gHxVBVKbxXmOUgEgn32aasXekgexxr50=;
 b=of58tUcHBf2FeheLH+N+9uZX1y/MwNFCxIXUI+Cwtm5Bu8xUnjuPPDJAR+Tft80Sji
 Uk44HPStnrptREsP7o+kp48dSYaXSAeu5yRrdaNZbgbaoQIJZLi68QaCtat1M6CqE5sQ
 DWCJyCEcxPkXntGVcOTQ32VvVsfupBjkTEhClJnLAzyKM2SJmEsOmzHmVwYvB+3goM7/
 y7u/Ez+UmRuXpd2XDchWPHfycnoyjZfdJc+znGs8hQR+ttLuQ2+DQTa46jLvM/uUmTpv
 +E1mXz/kdnyX+kdkfZA0kziLbK71K+4L+K6c2LazfAgBSqWxtFzLP/JbM3aZV1UljSiE
 0eDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769512093; x=1770116893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eJNbDbH7i6gHxVBVKbxXmOUgEgn32aasXekgexxr50=;
 b=bPgAroWNfnw4rZjn9zy5LUeGuWgbs1lfRTvVJ1ulfOYz7kdWcG6MfLc9cIVcPPAZfE
 l97HxiEDinBztnemwT7jk3Ii/QhkVEnwPm5ssxOcHvRN6Xlv+xEPUn42Kxc0euTT7bVH
 3V4DZrk/TxCL2PhaO6CNFGWyjFH6xbGEriPBxwO1g4BG2vFpAbtKPySHj8DS3JwGfprr
 kv/uBarFp1TzGAP86J0XWIzyNCXxSQV+ScKEoAeGh3mTnqxPW6ivPMGqov9L6hV2xhRx
 w9zrm7ZhLzpjTUNlndn5FfcO5DoX7lVn/wazAyLBmt2pGp1WicS82OW/0u4IB9Zghb6t
 iJdA==
X-Gm-Message-State: AOJu0Yxx+xu34CiGsg+sqifUs+fNVVPGAzEHxBOKmzKZY5xHg/IP803U
 GwyO9yHsrYOEEK27NsJ6Z4NPKjZtuEFXeo+lwH8KDS5zNv3Z9aW5KYo50DehQ6K63JSyYjH47Pg
 asB84okUa1ZMG5FdwZi2ciW0CE8cZNp4FefbXQLIu2A==
X-Gm-Gg: AZuq6aJMUS+h18/BcxfVBc5p5N9SMeOLL5WY5WteRTyNjCqDW3RXNSAW3tbMSpCGVXM
 wwCYPsEHuZS38NYmf70htTAMvPqnA56uBQC+ZCY/VSxEwJ7CQr0IWO0NGBraiDeVE5b4p6ZF3Un
 mTueo9ot+EZQSRA+TbAID5KPEL82Oo/IEoxYjebCHxeddnhqYaav7PedzPLrl3eDUnEWuOCWzdq
 u0Z4lfHIYhCnovxUBV82poYLYXz29+9daoQU0YvJ6SxjMbppSnrr0BJL9HvzMe4Ibt/3Q==
X-Received: by 2002:a05:690c:c512:b0:794:2c3d:7952 with SMTP id
 00721157ae682-7947aa17dd7mr9459697b3.3.1769512092654; Tue, 27 Jan 2026
 03:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
 <20260121134114.9781-12-mohamed@unpredictable.fr>
In-Reply-To: <20260121134114.9781-12-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jan 2026 11:08:01 +0000
X-Gm-Features: AZwV_Qi0_LfpwjKOz7tFzgkomsBbNs8WuqXxxRgPZlzPkcSE6ohNE3TkiWlg0UU
Message-ID: <CAFEAcA9P=3izrg-D9gEZ7spj8gJtan-GQzz_mes7P0OhLzekXA@mail.gmail.com>
Subject: Re: [PATCH v17 11/21] whpx: interrupt controller support
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>, 
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 21 Jan 2026 at 13:41, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  MAINTAINERS                        |   1 +
>  hw/arm/virt.c                      |  10 ++
>  hw/intc/arm_gicv3_common.c         |   3 +
>  hw/intc/arm_gicv3_whpx.c           | 238 +++++++++++++++++++++++++++++
>  hw/intc/meson.build                |   1 +
>  include/hw/intc/arm_gicv3_common.h |   3 +
>  6 files changed, 256 insertions(+)
>  create mode 100644 hw/intc/arm_gicv3_whpx.c

> +static void whpx_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    GICv3State *s;
> +    GICv3CPUState *c;
> +
> +    c = env->gicv3state;
> +    s = c->gic;
> +
> +    c->icc_pmr_el1 = 0;
> +    /*
> +     * Architecturally the reset value of the ICC_BPR registers
> +     * is UNKNOWN. We set them all to 0 here; when the kernel
> +     * uses these values to program the ICH_VMCR_EL2 fields that
> +     * determine the guest-visible ICC_BPR register values, the
> +     * hardware's "writing a value less than the minimum sets
> +     * the field to the minimum value" behaviour will result in
> +     * them effectively resetting to the correct minimum value
> +     * for the host GIC.
> +     */
> +    c->icc_bpr[GICV3_G0] = 0;
> +    c->icc_bpr[GICV3_G1] = 0;
> +    c->icc_bpr[GICV3_G1NS] = 0;
> +
> +    c->icc_sre_el1 = 0x7;
> +    memset(c->icc_apr, 0, sizeof(c->icc_apr));
> +    memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
> +
> +    if (s->migration_blocker) {
> +        return;
> +    }

Looking a bit more closely at this, this is odd. Why the early
return? This looks like it was copied from the KVM GICv3
from prior to commit 59ad421d6. But in the KVM code before
that commit, the reason for the early return is to avoid
the "read the ICC_CTLR value from KVM" call that won't work
(the migration blocker is for the "no KVM API to read/write
GIC registers" case). And in the KVM code after that commit,
we restructured the reset to not read the register in the
reset function, so we don't need to test s->migration_blocker
at all then.

Probably you want to follow the pattern the newer KVM code
uses, but either way, this early return doesn't make much
sense for this whpx code as it stands, especially as the
whpx code isn't currently setting s->migration_blocker...

> +
> +    c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
> +}

thanks
-- PMM

