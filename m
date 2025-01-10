Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507DFE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEPq-0008Ne-5k; Fri, 10 Jan 2025 07:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEPj-0008JA-BO
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:46:59 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEPh-0008Vj-1G
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:46:58 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5447fae695so3480300276.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736513196; x=1737117996; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ghaTg2vDZgwqorFM1d/p1ei1Q5z7osvlhGyoa9AfN+Y=;
 b=umHrTZUwLm6lfvJFd3nNi2h7nU4HWailzDgp24P28nU/fu6ZBkA/O+WTLZA3xR/yXb
 pHNJfm8rPN4asZiNQwb09OtKly7OGG09ZLd1tzuyiYI1tWrdk09sDFmIhfYUFB0uAS6u
 kCQgKgJoCTPx9kCAAZK4l8nMzlDFJFczHLCSevd+FD+fESGZOWaGr7ny1oumkk9lNdXQ
 Dtiet09od0zPnrWO7IiXT0e2yVqevuNxoOb68DxRjxhkrpT5aqn9s8XURF+uZyG81xzX
 Tr64eqxfAVaFpOBw+cQgn62PRORrMRNY5pKpz0NR8J0nY6OxjhjsCfdOAgnL7u1WaYEa
 q/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736513196; x=1737117996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ghaTg2vDZgwqorFM1d/p1ei1Q5z7osvlhGyoa9AfN+Y=;
 b=FJ/7j1s0byg1K2CzNRKHpthZHpo7odNAPMhKsF+QiiaXZbnJBiDlAD0k17xwxVDEpe
 LdU10TlUXh8kVS8O0R1T+CpEmiI8VeFtMFjahcGI5t8qU/kUBLIrwEYhO6ZjPjSitqR7
 ueWwPfWGcKv7z+JMeO65PQ8p+wEhcPiA7RIdkbVszknT0CMZmnDhL4D74k3VKLiDOvfv
 3ybRbZIFWADAdne7JBotS4D/prf1jCUkUHzEohHimJWUEqgr2qXwX/0GGWCz0nOfsBQ6
 A2khTelVf/i5P9B4LB5lSXYoGapWYqgSzZuVkdRnq7V4R8hH2Cems3iFQOUGxwP36QJL
 HD1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq1QiT1chCKXVN961/MMYvVU3Ri45CNJVt64CN9b2yaXj79qR0U+2geAbAwI/b4vSASefm5f6V4HxH@nongnu.org
X-Gm-Message-State: AOJu0YzoDsp/Tmi++lrxWWDM2EVcBsZ5ZttGjoIGNP7RG45Le3Vb/dP9
 zUuB/QUULIcfPncrBhkrGBDN1uSeGkZ0hvMIHIyxBW5c8BHAHZ+ntjjn+IaOGHn6e09GNmD1vSn
 VhT7TqsRjcNKxo887nPAX5dXSA/EUGIOXpSp9Uw==
X-Gm-Gg: ASbGncsMvwUZV/3oJMQ9J4o1QLPOZkB+13+QTLOdVXk5xkaxexKFWCSdMs4gaL2AF9e
 qAsNSlm9zr7FH+d7EssKx5w0pMX/QZYi1wuQhCcg=
X-Google-Smtp-Source: AGHT+IEEYJPH5f75EC68u298zFsB6gU+h/Frj4Um/XhYIDf5Z/xVoZJjoHdu0+1za6rmCWSquL3VAYVWp7t6qnfqo/w=
X-Received: by 2002:a05:690c:60c9:b0:6ef:5848:2a82 with SMTP id
 00721157ae682-6f531238a85mr82670287b3.25.1736513196215; Fri, 10 Jan 2025
 04:46:36 -0800 (PST)
MIME-Version: 1.0
References: <20241226130311.1349-1-tsogomonian@astralinux.ru>
In-Reply-To: <20241226130311.1349-1-tsogomonian@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 12:46:25 +0000
X-Gm-Features: AbW1kvZAlIET7DXkGkPTF_nY6EkyJ1EvHgV1b_Fp86Sdzm5IdgyE99TWlNOWqQM
Message-ID: <CAFEAcA-gfy-hRGzBAhQUf=A2b39wjVL04p_7GMcXfwBq7_vXZA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: cast rpm to uint64_t
To: Tigran Sogomonian <tsogomonian@astralinux.ru>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Thu, 26 Dec 2024 at 13:59, Tigran Sogomonian
<tsogomonian@astralinux.ru> wrote:
>
> The value of an arithmetic expression
> 'rpm * NPCM7XX_MFT_PULSE_PER_REVOLUTION' is a subject
> to overflow because its operands are not cast to
> a larger data type before performing arithmetic. Thus, need
> to cast rpm to uint64_t.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>


Applied to target-arm.next, thanks.

-- PMM

