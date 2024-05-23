Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D747C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA3BV-0001i9-Mq; Thu, 23 May 2024 03:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA3BU-0001fB-DU
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:48:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA3BR-0004V7-Az
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:48:20 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-354de3c5d00so733636f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716450495; x=1717055295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4rdqYFkyNFnGGla35++FglrsXfHudAsuNgYo2FmltAA=;
 b=dyvjaO/gv2IXeGFVlXaHc9Wik2IiwHAbejWX9VmtXN1KOGfFzUsDgRSClBTLQnLzEe
 t+dxL0gTdn/DMebrAnmJjYVJTyR/9EoU2EMCq0jqGfE7YGQOKIgxEyLd6nhYLWaBGh4e
 y69stnGWqqFl2jdS+oGcq35nKDopy0DfSwFy/K3oIEEdl1KxAjImhk9CVGbd73cl1Tr6
 BlY7qBiUMgkrg6eZsvjf89wM8N2/ZYRZZC3ng2FfVZWRrGbEtNC1XyhmQSYWeXt9Kk0n
 iQ/vwDMyyQJlCLQKuQH2veqA7tr5dMNw9zCHdd4luNTdsup9tJF/4NNADx1HmPcHpZTQ
 EKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716450495; x=1717055295;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4rdqYFkyNFnGGla35++FglrsXfHudAsuNgYo2FmltAA=;
 b=OPbav+tZG0xWbOlWRJ0ZpGXDi59A82POttM/lMzLgewWd70gBX2v0RgG5H5IuOCRhW
 g/PExwwp2NYK7csa0R8gmSO+rUcsikTrEEW87TTI0N4mPKPsf5Ftb8HaGm1CdMmyAUXl
 WOfg2Kr5Sefb67pBXG7ratZEFTRYQHjtbyjP11kKe5+SR9mJu3Mk1lRHrNqp/Oh1voLj
 8Yk9Igqkl0XMntvcXk7cen5Vko1u19PwImY4lD8y4fE+RTPBNCM+0QNZtpaPxntXSWAW
 gz+VuBLUsEJnnJSMPmh3ZmSlkLM3ePemXxDV3NYUy6EhALn3xMi8xtaYjTX/m4Ar8Qdg
 81Qg==
X-Gm-Message-State: AOJu0Yz5JvT6hvpWop2MYjQx3KjQOXkXbjBQyyV9lLlfNFBNNoccy/tO
 nojEbGhCYLyfvbo6WJuuwvZOWvJASxUNAOvHjQySkjJZ8sHbqauwiwUfBQGRTsJ77mA4+950u5W
 +
X-Google-Smtp-Source: AGHT+IFAggSBVPbKmmMyALH05HTxLPIy+4wTjrStFVvr5PsPcsn2PjYOhvY2trffYILMtX6rTNb/LQ==
X-Received: by 2002:adf:eec3:0:b0:34d:9604:3500 with SMTP id
 ffacd0b85a97d-354f74ff878mr1180049f8f.4.1716450495200; 
 Thu, 23 May 2024 00:48:15 -0700 (PDT)
Received: from meli-email.org (adsl-49.37.6.163.tellas.gr. [37.6.163.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354fc0212c5sm435954f8f.83.2024.05.23.00.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 00:48:14 -0700 (PDT)
Date: Thu, 23 May 2024 10:48:04 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v6 8/8] hw/arm: xen: Enable use of grant mappings
User-Agent: meli 0.8.5
References: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
 <20240516154804.1114245-9-edgar.iglesias@gmail.com>
In-Reply-To: <20240516154804.1114245-9-edgar.iglesias@gmail.com>
Message-ID: <dxhod.epa52okca38f@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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

On Thu, 16 May 2024 18:48, "Edgar E. Iglesias" <edgar.iglesias@gmail.com> wrote:
>From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
>Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>---
> hw/arm/xen_arm.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
>index 15fa7dfa84..6fad829ede 100644
>--- a/hw/arm/xen_arm.c
>+++ b/hw/arm/xen_arm.c
>@@ -125,6 +125,11 @@ static void xen_init_ram(MachineState *machine)
>                                  GUEST_RAM1_BASE, ram_size[1]);
>         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
>     }
>+
>+    /* Setup support for grants.  */
>+    memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
>+                           &error_fatal);
>+    memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
> }
> 
> void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
>-- 
>2.40.1
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

