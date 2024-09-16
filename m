Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634A8C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 14:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqCfS-0004zH-IT; Mon, 16 Sep 2024 10:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqCfF-0004uA-CM
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:25:18 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqCfD-0007U9-8c
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:25:16 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c245c62362so5016788a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726496713; x=1727101513; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KaPhIxZpgC0ZKYVE0HMI0s/8VDfo9L4b/ntZuZ2jzhE=;
 b=A3wOvQgtoVU1niNYNGlclW8OSd7SHxYupRxbe5y5qSYGY7vlt5M7QRnHiKjFup/CMt
 h46xoY//KdEXZRKRJDtjQr6QpsZqSmy8Hm23aRP3vGJuMQcD96OXItQqb6NSzYnaqjUQ
 aMOu5Bg/4pI2qCq/E+kpqjSUhIF4Zj+OWTYJSlX9CVsatZdzzgPkaP1BReFMW8Au8xVm
 akB2GgVFvMSjj0IRq/rzYW70GAVRUmDr51KJ3NJjNnjNs8teW9GSxZ86blV5Er1/X1ps
 Nb2RgH7KKhvBfcT2lT7xr2H5q0/q/OpblAfg3SzE/qz/VFfCvtsN3hi503Pl+ot7LXJe
 2x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726496713; x=1727101513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KaPhIxZpgC0ZKYVE0HMI0s/8VDfo9L4b/ntZuZ2jzhE=;
 b=hV2rgNmGmC0s0pI/aMVfZcqxOc7RdQhITF+73PvKHY7HU+pMnRkMYX8bWwZxPBU34j
 uC9O5+jTzfv8xG/LA3ZfjNTTHQfaGBVOnKd/PmEgtx7km38uKI9nMGdi8FxXuHdjIEKS
 yGBK0DsCNglCGP9MquPsj0MHSljD93+lT8Qc8yYt9OdCjpuISLcbh8C/7aulXJW4eo/d
 kcBPpZAmxP6Q9wCBFVsJ3Cxx6XARZjB23g5erh5PxtAE++Ciq5qV0YfN8UjPTcHoBCYy
 fbSuyNkTPfodw8/tZPJ+z7LD6wpz06vb5tUiSAMi832+IlJg2twnx8C19jnsf/02dp/+
 hlrQ==
X-Gm-Message-State: AOJu0YxFxUtK9rzNmTKZz+sD2KYsvGei5kdo/DFRo0XbaFWx5Wx/OPNj
 CF7v+ir/xVfhkWycQNZhvv72CvU6GctzxSbH6knSsAGN6UmyYmw+lOKrkBqL095W3YK1j+46Edo
 bKgsbnmcfUQfDA25R8DtwU2E8HGRAEuvjVF+vJA==
X-Google-Smtp-Source: AGHT+IFrom/VhCubfjCsdhCSPZlENgp+w5bvzfj/K4IKyqQ1+kDWiAzEEbXtJBfNzz9fdhgac1Q8yfuK8t7afGsAsFQ=
X-Received: by 2002:a05:6402:1a34:b0:5bf:f1:908 with SMTP id
 4fb4d7f45d1cf-5c413e4faecmr9962308a12.24.1726496713289; Mon, 16 Sep 2024
 07:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Sep 2024 15:25:01 +0100
Message-ID: <CAFEAcA_rc6hVe6m-WZQ5b6n5ACjCEF872KExw09jt6KNJ3tz-w@mail.gmail.com>
Subject: Re: [PATCH v3 00/29] target/arm: AdvSIMD decodetree conversion, part 4
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 12 Sept 2024 at 03:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v3:
>   - Zero-extend results in Widen NeonGenNarrowEnvFn return to 64 bits
>
> Only patch 26 needs review.
>



Applied to target-arm.next, thanks.

-- PMM

