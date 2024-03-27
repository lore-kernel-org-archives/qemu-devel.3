Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6702BC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 17:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpX3T-0001pk-OU; Wed, 27 Mar 2024 13:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpX3O-0001on-KH
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:27:10 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpX3L-0000h6-3H
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:27:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33ececeb19eso4607598f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1711560425; x=1712165225; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LOeWq64vcMpyC+dfgqU4qcoJI/qjRuI1jSd1ZXO7Aa8=;
 b=Y4yRJF7FZiBkHevRqyl57Ja38pfJ2RwREmUVEnfRrBIonFI1fftuz8BezxT5WXMsEi
 ngsjpFTaIyhXh1hukVDlVMKnDMxvLuka14SVNq1Oq279EnwyLxx0vk8C+ojwf6EGc30a
 7Mvbflv7kYki4jsvA6Qk7vNfLH+vNDc2JB23w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711560425; x=1712165225;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LOeWq64vcMpyC+dfgqU4qcoJI/qjRuI1jSd1ZXO7Aa8=;
 b=AAX4WDpGDsc1MtpmoHazwsI6J4Ih8uCiIpIhGxpIz+vCOl9joM9Nx4HclF1/lUidmG
 botSlRH+gpDkVHOLXWZaTTbRqn8xGj/lBOXfTb7elNJlT9CYGkflH2puc1STH+uGNHfo
 gbTC8RTfisrSP8NSFYrWyimNP7LI+EACuo4YWl8otSvuwM4/0gEdNapPfHkbIf/XXIiC
 nqbhKk9Ko1OquZHcYcfx6Yc7hvMWIrYkYQcglh2ljylrw6WhQQvL/sretGwtkDmkkc6q
 UU6skjI4LBVvfYW7wgDCOJxe7mSvmwd0cuSQqtnOV28K3nalexgXTvM1LOH19StkHVbd
 kXZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH7ZM45M2XfHy5U8yXp7o7u89dp8jyW61/nKmXtpriGp9ijDKiig0Pkg8wE+vFMk4f12k7njo/2vgkoTtrYmINJityDGA=
X-Gm-Message-State: AOJu0YyoGwQUjgZn/8m/EHl9Br+FE/Hqskn1mTlDWYgB1pLnm4btaBYd
 mtApcp4QI07Kzty9Sp7mz+J7UFLugJR2fnE2S7yVH2UFMHamVXMN+jjZ5ygzCvQ=
X-Google-Smtp-Source: AGHT+IHr9JM+c5QDCOdkTDoDNItACvq5s9onzO3m1fxTIw9ef9+p/5BHroxQSnJUYc67vBX8mZewQg==
X-Received: by 2002:adf:eccc:0:b0:341:d64e:4966 with SMTP id
 s12-20020adfeccc000000b00341d64e4966mr424121wro.61.1711560425465; 
 Wed, 27 Mar 2024 10:27:05 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 fa7-20020a056000258700b00341c6b53358sm10953709wrb.66.2024.03.27.10.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 10:27:05 -0700 (PDT)
Date: Wed, 27 Mar 2024 17:27:04 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH-for-9.0 v2 16/19] hw/xen/xen_pt: Add missing license
Message-ID: <71182998-214b-4e38-8420-79edb92ec09c@perard>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-17-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114143816.71079-17-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=anthony.perard@cloud.com; helo=mail-wr1-x432.google.com
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

On Tue, Nov 14, 2023 at 03:38:12PM +0100, Philippe Mathieu-Daudé wrote:
> Commit eaab4d60d3 ("Introduce Xen PCI Passthrough, qdevice")
> introduced both xen_pt.[ch], but only added the license to
> xen_pt.c. Use the same license for xen_pt.h.
> 
> Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Fine by me. Looks like there was a license header before:
https://xenbits.xen.org/gitweb/?p=qemu-xen-unstable.git;a=blob;f=hw/pass-through.h;h=0b5822414e24d199a064abccc4d378dcaf569bd6;hb=HEAD
I don't know why I didn't copied it over here.

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

