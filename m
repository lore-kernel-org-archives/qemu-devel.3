Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2118C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojqT-00010U-Tm; Tue, 28 Jul 2026 11:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojqG-0000ql-0A
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:35:42 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojqC-0002Ek-Nm
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:35:39 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c1677c91969so417982066b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252935; cv=none;
 d=google.com; s=arc-20260327;
 b=sPeTKhVCUUJdC/nPZW2t3rY5q9BuKY/Xd7uGSCa79NGTa+gy4Pvv+QdxhGrtOUB1cK
 tkYCBYk5g7rjIqu+j2kExlCR9yjPCXD2uv0WN8zG+A8xZWOaU1lE22m9DqMeiVxtzx0p
 fw2j4CpQ1Ampae10SRSPR7J2j6XN+rgUMGf0bYbf6xJfNqroSs9jn5UpTKAWUBlEeW8S
 PihG1ZmHIP/UFsRYB/aO7tBfqIFbz3WKdk4n0xNPAa33nxEygXyRu1xZYPEYSOfElRpv
 1yEVyM46HPijafvSdelzHK2En1U0V5dGxCOLi/dpd+3T5nS2Y/7cB68uJTHUOySAPKUo
 mf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bNtLwb6th+DGqc1clfZZuDiT8g78E+W4g/BU+0Ht5sU=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=DQ1Io0kpSR8F5pCiAG3V3y6id9JqvV2MBd9KZcyW54axdgIzOXvRN/N5LsJ34NhPlK
 KI/+u7D52EWHwf2IFIGx6kTaq1BYTeCQoIYhX8bzOxfvaSPPy9YG7Ceq7haogM+tcNf+
 KIYNczJ51r8AJxSMqN6sAXHpXQPiREVscqGW/vMJnG9isN+qZfeGRKK4rxApipfBlDKa
 8dWqLKtYRyIVpvDJdWZR5BW3+0D65aAgdkMN9Q5+VHneMRFrfeTJFURl1Z9NSjqkMJxd
 En7NssXvOBgHtI3HQ+BIneOXr2JUdaKza+HvY3btYi5ioLVjFVXzpl3cdojr36UaGMuF
 RJjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252935; x=1785857735; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bNtLwb6th+DGqc1clfZZuDiT8g78E+W4g/BU+0Ht5sU=;
 b=h3TxeqQP3Zttk5ERjnBpHdVgd6LI+A+wEgeLDAog8PppL4ZW8X2dz2Pk0W1s79/52B
 JyBiDqniNznfuZ8v/iAPeqjDwnrSvWJmYym741l4q8D1XWklBwPfzQ8lsqmeZqdlUuaG
 Z4uPyJqPf27Xn4tcnGD4au9ovWyThMusWgYlEkaGwDbWFZuBONiJ4SCMr9cLfVPeGvxw
 3j31M9VsSoV1ij14q8XmEnb0+rrtWtUB8QrIuzJE/2dWzVdvaws6aPLViwNSI/DTN++L
 m6+5onR/8MRvNlzzeU8h0uSbNQ5F4EMLJxY4ZT0bLu6VNt0w86r8W1HWs0hVxEL4l7HL
 jWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252935; x=1785857735;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bNtLwb6th+DGqc1clfZZuDiT8g78E+W4g/BU+0Ht5sU=;
 b=epEQHIBRHSrEaQYmA5bVeQuyPljRBewkK+ryW5qdpZ+P3JcpZmEAYOKrpUs/PIW3Dk
 ucKLrtjd8W7RlaPdYbgtIloVtpm5HwPDEJceMvYK/5/k0AG6KapaagrHO4eFfK/VzwSA
 pLXEuGQfjOLqYcN6m+P2+OMHLvaWA7QbrFWLrO9/qhEaqR2/470CboN271s3zErsWfw4
 zz5luAa8RZ0G/BqMlOjh8j2+VCowTSeFGtKj+l8zF9cRVoOR8G04q/2NcU22nt5Mno2a
 alwLXyhquL5CpnVksrwn9bQSISFMt0TxOYtTBPZLdX3nTjF8iqSB9jFOd2i97fkcm6k5
 srMw==
X-Gm-Message-State: AOJu0YxLSFBSpvlzpt9n9wen75I+48T4eBLvimaCu4DVcyrEySYlgHZR
 VrVV1nfMVLYve631VBKsYkS/YfQGQj4E/rYs9szPOmRlfABFxZ4pGEp4thbRv044U/ta1yPD+ZH
 p6+FrNC+sjfmK3Ce8ZeNiE+EGMtG06zPXAqzdi34m6g==
X-Gm-Gg: AR+sD101RPjt2t2d//79d2YegNeHirbr0Aycdv8MHA+GZbwN34Y4lIRQ7CZM9/wjlAI
 UWWZp9kClU3ptle4VbQFA1jf50hoSEzDN+3L+HwNDn7bWPMMICK8b0r8kjZpkwDWzJuMxnhzHzh
 FHQI2+Bd1crJCUsmHFdwoSd1xNj6z4wH7OtrZJnTf3e3AQ3XGmMSNrOfNE9JQEU4wiAp0qC7kU6
 hxRUi8IVERhAwpMFTFBQv3MyOvFnJz1EcTMl8Umq1kyaLVDXMFvxUrVkmnuWjFwsW74GJVJhozQ
 eB8X4Vsxmzx3H2GEstxyaZDc7Hsk1gKCa/pIOqh+XA8sng==
X-Received: by 2002:a17:907:c706:b0:c16:6fdb:222 with SMTP id
 a640c23a62f3a-c1f7246c31dmr155579066b.48.1785252935136; Tue, 28 Jul 2026
 08:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-12-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:35:20 +0100
X-Gm-Features: AUfX_mzGU2gm4OweVLqis-aItdOGYe39OH3Pb5G8MULZr4wdjKqbTKrTPCYSPAU
Message-ID: <CAFEAcA_b5sWi=wx9ituMtOx=Ztg_SfFsTPdEOG23EUm2CST5HA@mail.gmail.com>
Subject: Re: [PATCH 11/20] target/arm: Rename isar_feature_aa64_sve_bitperm
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Tue, 21 Jul 2026 at 19:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename from isar_feature_aa64_sve2_bitperm to match
> the feature name: FEAT_SVE_BITPERM.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

