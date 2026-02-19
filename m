Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB451E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt0UD-0007n2-6u; Thu, 19 Feb 2026 04:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt0UB-0007mf-Lg
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:38:15 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt0UA-0005k9-5A
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:38:15 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-649e97f1e99so589848d50.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 01:38:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771493893; cv=none;
 d=google.com; s=arc-20240605;
 b=XpUeA9eAdvSWu+WIx32cxUmjO/wD8U3mr+AfivPY+EG+NFr7ye9cLS9PwvEUT2KMfJ
 1x+rjaO6jERxfOgmZb9HHXOsI/eDriExb5ZznRmSjcQsT8ZZb5VFSYMcqC68M6IdqB3r
 1ySsBEcVDyIisa2dJu9L1Yl+U2RbC8Olyf6SQTU+HDqy0i9c8m/aMD0EcrkUm+OCFZfx
 ycB14QI0JC7Ni5KADyOV3bXuWpjVmKcWz5d0HGSO0FtU8sK2RUwsZUYARFGnGmChcfBM
 WZkvEvv1f5H2N81CX023SJu7CxDoR3D0ooZyI0L9HnXWksHAq2qKidzaBpKDL9l08xBk
 JT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gpuxha4eRNUboHr/8D8+pnu56CeGJjt6qpHHARu8F6s=;
 fh=i4wshauNREuUPUWCN+OkRWXFCVYoSMN0/GGwAmMe7Uk=;
 b=Jnyx61lMO5MxWv192wBGoaxeQhQq+rpcJMXoO2cKqMoedNZDR2IH2kFDnUZ6zQyPjP
 pGkOdMbfHMsB72bLoPvYoRFa+TWNaMbNxRNyUuYrdIAlBLcouGI2heSQoJEjuGxFgFZm
 Hi/3m1Y5D982dTWYZrK2uYx9bx3K+gYO11hKUa8HvzLaquBeg30gVH6GCA7YQwHLhdsd
 npDIiZYeTlZ5KmCLVASca852Xl8XHNbYxEXDaJyzXjeVF43rJstxqB3017m02CawKmw2
 tt2bNVkYVZRfX8KiZdG4I/M/l9jZ0fhcX4Pf9JtY4s1brkNBp+1LFot3ReMSozF0foD6
 grXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771493893; x=1772098693; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gpuxha4eRNUboHr/8D8+pnu56CeGJjt6qpHHARu8F6s=;
 b=cEXupcjhTEV3fblp62VxNHmBEQB/nFbV6XVCVl/9y2lgwCVLzTUoSarYQbDW7ClcbS
 YcaWGsBvAaqnsIWVd/ufrYq3ehV98OndSTjnPzHLrA/VED9wb/Z2XnuTwe/UJCtrNXuw
 N3LBYKk2GiRnXPDFoaKf+rVzE+zBOscbUqf9hroWSAKQr3DPKIEfLQlKtgn5RpfQ77RM
 W1TqG7LUT0e5gxkkwbReQ6/uU6L+U+4Q68niN00pnz2t/SCskvoPn5heco41MNjF8F2E
 bYQtzmKtAGNfjzA+Y521WoYBXX/yDlYtshyLvB1ZJQ7h5rc/5TnQZ6IxKneWZon/60GF
 9QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771493893; x=1772098693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpuxha4eRNUboHr/8D8+pnu56CeGJjt6qpHHARu8F6s=;
 b=FLzTSYGaRmAcL6x1xSwY67PbVgR0mjqd4zFsnk3jBbEymMku8sQ90WqVrlnB8d8X95
 5NgWnA2OLqrEEmh667dJWZXiyU6riCXXwqivu1UsICjJvpTTK+WVdEt3MIcZV9iXZaSY
 7/o7FGg/X5sfQyO4T1RXvVPs5JDqYV3kimxoandgcxloj3lTSUHOGpOS6AK/QQIHgXJM
 1unktg7OYrFtFZJOHUVGHKsRzxkKfXAAVpPHubfiM7pjCKD7/dv3mWobl5narKqa3JAg
 S8P+qvpGpGrdS0bUliNDNxkwOzTJttsZ+43BFSTJqBBFMGw3ZkCrcgnSUgQesevtIsbC
 EfWw==
X-Gm-Message-State: AOJu0YyhbTMQDAeXYNOl1cDrlICLEaKeGn6U89C2Evcb0SfktYUqP8Qb
 My51bEWCyxBiRSCfFlrqUVB1OiBNo7pCUH/smadbmoYt5/e6XMG4Mdvi6dLsjly4T65XlhZxpJC
 oLuAUVuQzz0b/k+zk8TOQvij0Yl/34T+F+ZiOODxgfg==
X-Gm-Gg: AZuq6aL4WjwWknwqwcuu8H0FE+hzqCncGLST2+/CDjXOp9BYmtiCT6PX5lhHueWEXq5
 IRRWxPlpybMWpWx3HJdrw9p/KIzW5CjUhGjwNZx3+TpAyLQ34JY6LzD+TCXXJlaUdZYYFfzNkFi
 CrsJw1woTx2JrJFuZrS8nVP7/C5dUNMSPSp2go54P+kwAjdIQK+AHKbW/OmfXTwkLdmw7hFXDxd
 hLiuafn46sTjQGuCWkQfPOQHy3CNVY+7PDMeXpgWG8wgNGSwyt8qC+VNadGiQHCxWzRQIoIqlXW
 PF4NmWZz5ldDD3etv5DdPT7aCRWwI36nfMUoOwYivTTU4Qz5vKibv2LJXpW3q/QXvbErobf5ecN
 fmQ==
X-Received: by 2002:a53:b6d1:0:b0:64a:d607:30d7 with SMTP id
 956f58d0204a3-64c614c5a1emr1352603d50.78.1771493892946; Thu, 19 Feb 2026
 01:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 09:38:01 +0000
X-Gm-Features: AZwV_QgPxQm_4WHz5YVXddgB8CRBzKT1jW4-rQRItT93j70YpskswASSwVfG8rI
Message-ID: <CAFEAcA__tnvy9dUUPrEG8jynGGSp9iz0H7Q2MFGdw4--NDH-ng@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] target/arm: single-binary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, anjo@rev.ng, 
 Jim MacArthur <jim.macarthur@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 19 Feb 2026 at 04:02, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> This series continues cleaning target/arm, especially tcg folder.
>
> For now, it contains some cleanups in headers, and it splits helpers per
> category, thus removing several usage of TARGET_AARCH64.
> First version was simply splitting 32 vs 64-bit helpers, and Richard asked
> to split per sub category.

Thanks, I've applied this to target-arm.next. Patchew says the
last patch here is the same as it was in v4, so I've copied
the R-by tags from Richard and Philippe across.

-- PMM

