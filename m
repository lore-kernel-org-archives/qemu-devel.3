Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58415D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAWA-0001Ye-4i; Mon, 01 Dec 2025 15:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAW8-0001UB-7o
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:29:04 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAW6-0002k0-Kz
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:29:03 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-642fcb9c16aso3729813d50.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764620941; x=1765225741; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h0/PVEe+OG5R8qU0DjpSQOGVAZRlFTiLbmtjUjjJLFM=;
 b=D6n9HsBCFltYW9RXylZEEK11v1aIi9IPIldgmhJ4SYRp/8B3E5Pvgg1QhJKMqWiY2M
 3JprxqMPwN+jo653d6w9MQTxo7FyqQ0cho7WE0AKk2F5CkWWWi/Kfjs5wRs3zEkGyUnn
 aaxxBXBdVWzcpqrmSJAXZCKUb1NlG4cLwBo+qnQCn2InZfoglyNEhscp+UZxx62CcVC+
 Mvvlhon+x5yQBd5l4XdgRabssjGRVLnwbegh2wB+4919HxSag8E2T6cl/3cPmrQpdsly
 CE0sB5hx7URqP4SJLDDB1lR4oxTF8TmNzeMH56+Z7E+U3hLPptCvT8tpBCwYg0pR/Hmy
 diuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764620941; x=1765225741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0/PVEe+OG5R8qU0DjpSQOGVAZRlFTiLbmtjUjjJLFM=;
 b=YvOnkr15vmPIs9ZQbyFahDQxsRx4eayqRfQSQejJ3LVnvBCPmDQpR4t+Wh3+SKuhnh
 eD03eXAc6UNC0NdqSuEc75varLgi/tfJLup9oAjXBD+O6N3SJW8SICltS6MLyr4zCR8l
 Q3f32p6bQiSV2MO1gtKz2DdZDWFVe/E487aXXyMtZPrT4gqAoLlbuJvIG9ahURaXx558
 3lKCS/L7divxtbvE3d15mvTPWWuwg4KaAQdAjHK5GQuH4NHe9A5jpTVakwgTFqyAMMlg
 R4GHI7poyG2tnKF4Z5VvNbnUIUXZSa9ITqvnxpJEL/51RHo4Svbpq14dxsudMHXQW1pd
 VFHQ==
X-Gm-Message-State: AOJu0YxC2Axr8GbaPUaIPhfgifIEskCCZ3HCYJvjAlqy3c5w16M9OEJH
 SwWI1UPs6iBhWCeQ2REem8VFdOAguPA7E7rnS7HnH+vptGJmL4hhM4pjezwjXwTNqxRo/wZLojR
 yAN2HmntdkgmXnJ9fAl/kHWceEgSF9+E86uIvC+w8X1jaIpNUk0P5gSk=
X-Gm-Gg: ASbGnctf7VjwsBl+rBrspYoL61BZ+dol5ZQl/pS/7Vcd6gboh5b2RG1j1hDiojf+jOw
 j5Yy97kByZYfwjH6CIiYc1ahThsUMnxtzPFQTSb+lmsLWWEXPIFsM4OXQ+ITFS4gNSwEvcXOdXu
 Qs131MDw2keVdi3481dn35Memh28pM4axPheOnRN5HAENrSdqtonVtGw/isRieuLmqpboQRVg8o
 K9oMnOuytEIkQTiC4Q16JBDWmreDR05QRK0m88RFsGjUsGyoYQe1thkw7rxXcikbdVGHeRyalU5
 dsZSBQc=
X-Google-Smtp-Source: AGHT+IGCiYkJ6XdGi5NuCYNGg67z6r5qDqvOco+JutFH1mms+Avc+5z3nb5w0w8NLf1d5rg1Qf9RHqP2xH28mpeAPL0=
X-Received: by 2002:a05:690c:3348:b0:783:6f8d:e7a6 with SMTP id
 00721157ae682-78ab6f506eamr409285447b3.51.1764620940934; Mon, 01 Dec 2025
 12:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-7-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-7-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:28:49 +0000
X-Gm-Features: AWmQ_bl422m74TqYJr4hXuxsfp84--sf18JXuHoSL_E6C1tttOj5qRfDNvVbOZU
Message-ID: <CAFEAcA_dQw1vci_=5WnkF7f0XnGzZ2jE8WWzv2wG99LuP=urXg@mail.gmail.com>
Subject: Re: [PATCHv3 06/13] hw/arm/fsl-imx8mm: Add GPIO controllers
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
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

On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> Enabled GPIO controller emulation
> Also updated the GPIO IRQ lines of iMX8MM
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

