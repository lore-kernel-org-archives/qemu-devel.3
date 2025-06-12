Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169F5C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPjyJ-0004Kh-Cf; Thu, 12 Jun 2025 11:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPjyH-0004KF-PS
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:36:05 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPjyG-0000um-9w
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:36:05 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7111d02c777so8607157b3.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749742563; x=1750347363; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pE3dXpj0aU78BzL+r7JOJkXrxfff4V+18vm+u08QL6w=;
 b=q6RcZ3HGPagjfwOYeQDrlBIe1dR3vB/YwHE/8pxFwETfwupP9yOslr4Db3mJMIQEbm
 P1B37grCKr0LuRDWv6hmjar/RJpMNS/oLNfWI8rxjWG7/WCGU8TxgHssYGYNlXoUcOaI
 57ugG/W3V5XNVj8w6fdXGTtIrVTc0CUoJBl4kEqVUQgOmYSZGO6pUI127a96wCYSwGtW
 f82ZpGarhiGu5XFg1J9KDeyGUt3bkrjoNkYvCq9aVYRrbazrQjzFvBP3mlJjj2wzkf9b
 HpCzyJnHFw2ssGgE6phddNJSHBd5y3G8hNoJCGiqb38RBqNOnQEXTvxJGDvAzMFZaxfc
 BuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749742563; x=1750347363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pE3dXpj0aU78BzL+r7JOJkXrxfff4V+18vm+u08QL6w=;
 b=n68qVrlFrhe/P9qoLUNyZvYYLSaiGbc9e9Qm+196vhVuoicUD/dXEDqf+2AosXi9R4
 1PG6rnx7y3z3fvoNnJ6luzTSsy2xqR26mnflGLy51gbSWdr0Ra68WQ28l6OkCTqUoNnY
 U4JM31AeFAryVOIR2c94ngTBCDLmmUubf0bIvKMBVOeZ6cVHEcKF8pvWnDQk7yJbrQz6
 4uL+jqQ+ogjDCXz3MIiddJ00B8wf8fVx5zvtm8EeyQKq17ddclgLJdtHPeEvpUxqK75R
 6OGTVbVSlSzCmJflozzKD7ZW379D/9LF7tcCuY42EvHtetN0YcGw9Qnj3X/4APg+1F9s
 iM2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvq0UzT3DcJQ4Z0qi8QNAGQiJOskqBj0HLh67TuhNWH4o51cHpHEqruE3r2YYH39ms06c15d7M9vSo@nongnu.org
X-Gm-Message-State: AOJu0Yy2Qlt88NP4MN1Tz27cSZtfsWlZUBzCOSxmGbDWmQQX1FZVItiR
 cVB+66Ip9bpJDseYG5fqf1WNrCJYpIzhzxSLPU8ofrYEAB4GKwTySMBHGfgi8okpHIGR9Zmer4B
 NBePrwFaupqmVDZu72nyTE5gUA27wI8TOc2G8y5lwfQ==
X-Gm-Gg: ASbGncvp0r9gOI6DcTS3g4k6pPGCL0o+8PYwbJqpe/lvRkWh2i+aBHbQPi5hoLwqO/S
 lZHxO+SLnnCqed9YiDx8zRS76gBFKauIo9LUnohWASHdkcWtuEuH/qRu5mLgh2sqhYidZnywcIo
 QpvS53RKTPSf10hnoxIBN+zr6T9I/XnhXU0E+0EnSRsRb2
X-Google-Smtp-Source: AGHT+IH2bhKZzKb6cAcO9aAfVWto22hSljzV0S+7R7pK1D5q7Y11fAWUU2asfygNKJWUNlKlB22V1KDNnY4CSfoYMMM=
X-Received: by 2002:a05:690c:6203:b0:70d:ed5d:b4dd with SMTP id
 00721157ae682-71161f29c5amr4894467b3.25.1749742563057; Thu, 12 Jun 2025
 08:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250515153907.151174-1-cohuck@redhat.com>
 <20250515153907.151174-14-cohuck@redhat.com>
In-Reply-To: <20250515153907.151174-14-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jun 2025 16:35:51 +0100
X-Gm-Features: AX0GCFtP59qPc4EAjuw9klqXVx2ltBaNeP6BsMTmWbNtC3d5QuHXLs0a9yWRCu4
Message-ID: <CAFEAcA_Ju4QBUwiOyt9thPxuAFMcm6jVTZHpE8FFJeed5cJgsg@mail.gmail.com>
Subject: Re: [PATCH v7 13/14] arm/cpu: switch to a generated cpu-sysregs.h.inc
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com, 
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 15 May 2025 at 16:40, Cornelia Huck <cohuck@redhat.com> wrote:
>
> Generated against Linux 6.14-rc1.
>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---

Does it make sense to include all these extra registers?
Some of them are not simple ID registers at all,
for example ID_CCSIDR_EL1 is an array of registers, not
a single value (in QEMU, stored in cpu->ccsidr[]),
and CSSELR_EL1 is not an ID register at all, it's a
normal read/write sysreg.

tahnks
-- PMM

