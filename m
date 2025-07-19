Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46064C83F3D
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 19:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udDfz-0007Hl-De; Sat, 19 Jul 2025 15:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDbc-00044t-Kx
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:52:25 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udDbb-00013G-7j
 for qemu-devel@nongnu.org; Sat, 19 Jul 2025 15:52:24 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7086dcab64bso30337767b3.1
 for <qemu-devel@nongnu.org>; Sat, 19 Jul 2025 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752954740; x=1753559540; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gsw4z5odj4aFcHQH07RztOxT4LhzQIFwvHckF7DSz1Q=;
 b=G1o+4fts1S3iGv/dope2skJVrWJ6GEsWQFbRFed01ffNddArVv4RYwSaQcME6I+UiP
 V/OTBh1ff05wCEjtI6/PsCCTDDMv0o+1j6sDHc7NN8e0MJ4rW6KMb8nhxU/tBFFBlETu
 Ki31+IBtJbyl7gjVugBS3tlOpRaVRrtk9a2lyEvPU/D3aFmsRFpHejaZfATz7//m5Ynk
 yoF9y6Gh6aLV4DPzrgI1MXBYJNKyMcW55kO238QKBREUJAh92uLalDnEji7ItXVGQ1iB
 4dSyIu4RsxDRQM7IPJDe21TlrHMlV7DXvs4iQdYPoiYKLTn6WDtQlHpsbrGpJ+G2TX40
 BXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752954740; x=1753559540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gsw4z5odj4aFcHQH07RztOxT4LhzQIFwvHckF7DSz1Q=;
 b=JaJEOmAZZJjqaSA6yHsjteur9OiBVkOqrdA7I/xg++NSy3lUSGEOKMmBb7my2olfIU
 QUMHlwZKlhMlKzhBM98KzynwnMy0LIip3ol+d9uEuRUFqkFxrxgATCbM9w/LrFgPaAyp
 heks9RLiby6R84mV5RUjprFNh271DtspzzZTe15ZE+EJkbr/inyQj7K6NFhufz6QqZW4
 QJbiV4wU//b9X1hao7pPVvgGr/isQPI6yG11RKs1tByarPNE2/lRKm3gfJiqxfDh29A3
 D4kLeVT7HXhHPCN2Y/8kAbIWPiv2lmJacqLAsiiD40Vmuoq/g3/Y3R31nn084SSz1z/M
 XOoQ==
X-Gm-Message-State: AOJu0YyUQ4rqjAkYf51+f+LThWu6uuMUwkgc6O9GyUwE/Je7lsN0oWY3
 oUtlqnwStubD17/qlZ38sPwJhNhR+bkEGrOrDpyB8kydF8t5ABsO1+J+E4M5+iuM/kjC5Huifnc
 F+aG8+HUzS8aRGZ4Rb40hFKNiFiMsEYgyAjh5aSvQUw==
X-Gm-Gg: ASbGnctLdoPgTtfgCQsXZkJuu3QGFq4thhikKO1dgtybuUZoyOkQI/5Vr4NorZY5G92
 rLyPKVd7yfJqQL9UyF49NWCYBu0CYYTpy3EzaOX8WYuoKCS2XoZ2wALkecOaY25gOmTZoVhvS4F
 s6dmB6sxMzf2fkNTs9TcNQBosLD6WJzzCZCpnF9/nnMuQaV7/Vf2Nm/zB3AzWoxAGHB6bK5hHk3
 cq31tgcqk/4pnlsxpA=
X-Google-Smtp-Source: AGHT+IHvTY79hDjaSgbL/8pS2MalScoB0GDdSMjfyA55ea5+3WG9h6zFflWUT51SPGVasGFkcY5zpL1TSEihlPj7M+A=
X-Received: by 2002:a05:690c:490d:b0:70c:c013:f26 with SMTP id
 00721157ae682-718374a07afmr200134607b3.33.1752954740325; Sat, 19 Jul 2025
 12:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250717150805.1344034-1-lvivier@redhat.com>
 <20250717150805.1344034-2-lvivier@redhat.com>
In-Reply-To: <20250717150805.1344034-2-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 19 Jul 2025 20:52:09 +0100
X-Gm-Features: Ac12FXxrJ2uTiYkzVq3qrEmyN4-2IK1Gd7B_z1hGAzQcMdtwoiLIo5Hb7mVfyzE
Message-ID: <CAFEAcA-E7_kJqZ5oS_SQaCc=fe8Y9pnEnfhR4hXO37bKq6ys7A@mail.gmail.com>
Subject: Re: [PATCH 1/6] net/passt: Remove unused "err" from
 passt_vhost_user_event() (CID 1612375)
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 17 Jul 2025 at 18:43, Laurent Vivier <lvivier@redhat.com> wrote:
>
> The "err" variable was declared but never used within the
> passt_vhost_user_event() function. This resulted in a dead code
> warning (CID 1612375) from Coverity.
>
> Remove the unused variable and the associated error block
> to resolve the issue.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

