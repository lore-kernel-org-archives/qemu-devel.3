Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E932C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY72z-0000p6-E1; Thu, 08 Feb 2024 11:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rY72s-0000oN-Ca
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:14:38 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rY72r-00027v-2l
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:14:38 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33b0ecb1965so1309864f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707408875; x=1708013675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heF0cSHATX80qHBQRktHQiHn5vMlOCoImYwMez7a0uo=;
 b=BN7HjPUxZeZSto3IENRwVzi83K/QnHbJBBBpVJZ+XW4v+V5otm8C1CtRJSx9Zdy6Ey
 KaSkZKlQ40kx7gB8y2P5QGupd+RNltdZ3CiSrzobcfyIL40EFGxErx1XGm2Z1q85Q97J
 zniWXKcgb6LydYhXtSJAXaCCnhIUUFIS059DrnetnWddYk+3dsf2294fdxcAP8ZPCupg
 9YP10UP+Fk2LQ/KcN8xS4RZ0RBD31q3GHsXOVuPzIGLdlNlrkP+XkgGhexWnYh/ya6qv
 7Bhq3pPAPxbSMdGM8kej9PRI10xA5DW42QAY9SXOViLZAFpCCv5xamXjMuIjvvTHBXHy
 353A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707408875; x=1708013675;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heF0cSHATX80qHBQRktHQiHn5vMlOCoImYwMez7a0uo=;
 b=q8OEE/LkK2afLsBiNqhPMIytMe4bFqvieZo7GoWOs/J2ruBpI8dHkqgB6MhB4Qchy0
 0z8wlgH2OFUfUtFTCbWbA02195fmC+C7BD4XQMJGHYoZVii35voC9a7QluKDT9OKEaSG
 ksA29w0I1ootYsDbdnPikNnRdQwl0dUc7XpjxgV1vVRARaj9jbw0BLuwiSVs1cuWlHHF
 cUlL5+V9EL5yGWT2plUpNZErONTGEuhBffIoupQbAnUIgKthNvqOhMJUct8gb2MhSmCU
 v4bqTj4qIOwkPNhSl0YBvNvrEyYLvLQs/aniuEe6RPwV1dl4c9viB3ihyw6uuflMG9ai
 VvVQ==
X-Gm-Message-State: AOJu0Yy8HRyXpi0NXYqmm46xhny/rI9JDJg/B6hI/CpNGc4BTEP15q7y
 YLOdYjSZ4o+gsbthempKHE8VntOBl4lsSIpua1ObAUdVuGoi/rHZ8dEkIx+P
X-Google-Smtp-Source: AGHT+IH4ubh++CiIc5ZzNTwExzhqO53v3JTi6caNRo7oirPsTxZ5Jrdd1wqzHvwhhwobXdON/ZrhSw==
X-Received: by 2002:adf:f185:0:b0:33b:234c:ec04 with SMTP id
 h5-20020adff185000000b0033b234cec04mr6800548wro.32.1707408875117; 
 Thu, 08 Feb 2024 08:14:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXM86oZHVot1a3lrvqzUh1b/msYvOC8asWAhx+KyAU2XaV1dO+9YQfzS1cxJA3bxcEFiWUkimAMHQm7pVXT0VQpZ1wgh20=
Received: from ?IPv6:::1?
 (p200300faaf1724007ccdd0ba9e70da1e.dip0.t-ipconnect.de.
 [2003:fa:af17:2400:7ccd:d0ba:9e70:da1e])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a5d5303000000b0033afe816977sm3861638wrv.66.2024.02.08.08.14.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 08:14:34 -0800 (PST)
Date: Thu, 08 Feb 2024 16:14:32 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
CC: philmd@linaro.org
Subject: Re: [PATCH v2 6/8] isa: extract FDC37M81X to a separate file
In-Reply-To: <20240207111411.115040-7-pbonzini@redhat.com>
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-7-pbonzini@redhat.com>
Message-ID: <DA1AA8E4-F862-43BF-AD78-239281BAE702@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 7=2E Februar 2024 11:14:08 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>isa-superio=2Ec currently defines a SuperIO chip that is not used
>by any other user of the faile=2E  Extract the chip to a separate file=2E
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

