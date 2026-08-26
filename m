Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3DEC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDFe-0006Yw-9T; Wed, 26 Aug 2026 09:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDFd-0006YE-2W
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:01:09 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDFb-0008D5-KH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:01:08 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso1670071a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787749266; x=1788354066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xdIse+755ESEtXAf8FTGrtnACDo5SMWBhg0NlB1V6wU=;
 b=GDks4f0wQquwdMNzTqOWq0FBknL+Rjc6nfcjI8i3FLdX6ZHOtHeXn5TMw6eZW5vUA2
 Tt2pt6/OP8VEVKJQap6BSVN0xRzc1IhdUSqP5quJX9E9PjqJHWUGIw/C6y2AtXp5CCE2
 Mtx0uSxaDiDshlQWjEM8SxmDB0p1F9ein1xXV9cz/OLDyZEggufZRbwG1E+U3EfNFH3s
 ANVlxMZmVxdUDLNgkBCXpHwE/DOsLZvVoWpPyopJtkWbCnzrF+dh0hnfH56ra2uwYoTl
 sboHPpX+Xfr/hGUFsQu1Y4PNXQm11cVI+QgzVDflgquXTH3f5XwAvquBREDwz5dhBxU8
 6hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749266; x=1788354066;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xdIse+755ESEtXAf8FTGrtnACDo5SMWBhg0NlB1V6wU=;
 b=eZdjbIdAhTXxdW2w33IKU+IsCtDoaRGKphPrUNjL/Qe+j59E1pBWYaMMfCXP+zjiWi
 yZSc4XYw/jVAN5/jzY709o9YT/YT4nKb6Dvq4fKV0EU67LeqPjCmM7+nYnF34HiaRXEa
 ta+ath9zuNNEOJV46kMZn5NQuSNTu+ufWHsIQz5FfSHPR8fWIBxpKcnjL2bODOk2zBzU
 diXQm5ojYwGeB4NzKl5PviYfJYiO/kCWt9DAnmYKjbyHQHLeSLOOwmsUavfJhxPp2mj3
 tOEilGZ2B8Ixy04KGWhMp+XxErDrtSCLKvET0zfnOhMUoMm0T8kmk+RDuJtKqE+wRAXb
 Q24g==
X-Gm-Message-State: AFuF++nmjZRFlFq2U8Og1uMhChyhhuEMWaLgn/cPQY07mnEH9wpdfbc9
 UmARshcks+Px8voPBBUrMUfvQZnwZvwCXVq/bKZRh4kBFT3cYU4ynQWbGaacogvAHSM=
X-Gm-Gg: AR+sD12J8/gOA/hnQvv1MfEvNFpFpck70Br5N9Rf/8MyImYElf4t0QD2LpjKzwOMDtV
 u7wL5/d0x/XvgNX2mfJeCTgGhpmCDZXX0SLMHv7WO2gm+DVgG4QDK5hV5zfA9XlmYJ/bF93qzLT
 L3/buAB19WIJrLwhViscUPCIh3nL4aJtxdqeFvruFKBeDl/lNgPzq8OjMDN4vZwh0LkZHfN6Xai
 Q+yoKzn6rE+o2ZwtocKiaknMLiQaMGCeTzBVDmZgk7w5GcPYH81mrs/QCyUPk2F6gaBkecq/cPf
 0IfJWw3th8553GQ5mlV/4AvEoQQRhHOc8Gq1MtuFc0CemKrbqTbfvwogMGpxuQ4zVS8dZrqhAbZ
 QzjA5gzFbCL1cTG4p4L/wo/9Dw3n4i7xjwS7WQFZ+p5Jx00VumrbZQJlbChl2SaDWRfPAit/sp/
 iEVshVVlPzMd4zBpEwkANwjmCTG3+kfv18vq/w1MU74JCwJhhSdl+f/dMPaODbqw==
X-Received: by 2002:a17:907:72d4:b0:c24:8a09:8195 with SMTP id
 a640c23a62f3a-c250bb7f3b1mr797939266b.3.1787749266026; 
 Wed, 26 Aug 2026 06:01:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d69a7sm730398866b.8.2026.08.26.06.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:01:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E5FA5F81E;
 Wed, 26 Aug 2026 14:01:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Aniket
 Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v7 048/104] tests/tcg/arm: system tests
In-Reply-To: <20260818192309.22169-49-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:22:12 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-49-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 26 Aug 2026 14:01:04 +0100
Message-ID: <875x0xox2n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

