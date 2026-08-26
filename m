Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7671EC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDFY-0006XW-BQ; Wed, 26 Aug 2026 09:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDFX-0006XI-E9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:01:03 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDFV-0008CB-Mg
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:01:03 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a1a546a6bbso1524859a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787749259; x=1788354059; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xdIse+755ESEtXAf8FTGrtnACDo5SMWBhg0NlB1V6wU=;
 b=rt1j+Wyv7tP8QdY5myxBaIYxJ9tWxAnZr7M/goxNl4AGrf1+3NJALr4kdCfO5yAOMM
 4puXxmwKF7GEMR3yv20xqVANxCbwFeq3Jj/dqimkjTLgloLeGwxTMnmIqxMA+PL+Nc7P
 UzuOmCe5tS+3sBiLpYQRNzoBtebuoOYZ2yis3HN3f6lpPjuOv9s8KFSxvWgASKbfHI4K
 mc8kGJsDtjMSrGloWU6+QKzSnJjuq/6PmdYbT0l7fDUqJXvbH04yeTJ0pGsBr07UMb9f
 Lncy4+Fao0JKtIx2rB3GJt1+6vq+fKaVmlQkWbaCmbtbSh6YkCwUCyOzWWFy7JMe2FFE
 PAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749259; x=1788354059;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xdIse+755ESEtXAf8FTGrtnACDo5SMWBhg0NlB1V6wU=;
 b=E4VmXTX/IqjClJSZ7oHWD86Ihf7qy+E0PQVbdpGkh8IDRECMhVyhoTv2/8puuiNGk2
 Ct0RJEIhEzTBzPzLqnuDdDU5NLLE301JM8uMVIZvd/ikdNRFexTdpXxBhQbBm2YG79Wx
 /HgO5OVhHfKZJo0ydO6WRs+Yq9LDhGeVsYq7agPBCih7MEqHidYvw3rhwKgceBniQeLU
 EQpDGkIC0XQuoduLHcCcBBtT7IYzQSkOgyWHmjbXb3tHhNOu1iPw+TdWnRP45rnNnHjU
 Kqt3jkIhRpF0xOZbOSuZ/+ykDSQ3WYcYu4xPaeat+QowiH0bfMAnaSyqp8R/Z1ZseE2H
 fV/w==
X-Gm-Message-State: AFuF++kLmT/tzhfdsDH/E0n50MYjYUizoOnOYyrtUlorYXNOMHlEcJ/9
 y3+NRRoOOXAT6tml9L3O98RG5+lTMHmQZLThRW6NP5TKiCmW1Y36cMx0pxetPlpebqI=
X-Gm-Gg: AR+sD12Scv0KuzwiMfNXjEXza61XI2gbkspjwR7gmqBUgVbdtM01cIS1kfovii7WXQi
 ab9NpYxxWKd7NHBwgIeTRw9E54ThaR1XI8TLTNDF/A/P48EpdUAIZBQqD3XvUhbZQp79ZUtPXIB
 Z9Z/dNJtqXFIl9os4gjMm0yCQJ19nc5hROdWOZA0YXeDuegdqAlUp93bunOu28Z/Xo6/gm/skx9
 GdI+dIgh+wD55WfypOSz9NfblbZpzfL3aDczvtZIJR8C+GvXKadutG4n4A0KNR7BRaF1GIA57rK
 WjebCjCHt4A4f8aPJYL0OFfTeW0Y8sh1iYmWUIojHEWfoh19aIXpE4J0GKzDLa+TuAGzzDRpdDn
 fSn1k/1MFxMCKnCqv2vzgHn5lmU6I98VCZg/3ctfGf9k/PHABoVgaohh0ZcAD5PRgCZ81xk/BEc
 M9w9MJvZtV5arBtJeD/hP8TpJ38/+8Daj2gAFGYNB4NNwBwQ==
X-Received: by 2002:a05:6402:455c:b0:6a1:f93c:f0a6 with SMTP id
 4fb4d7f45d1cf-6a5df63b5dcmr7215909a12.12.1787749259367; 
 Wed, 26 Aug 2026 06:00:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8b641fsm4548894a12.3.2026.08.26.06.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:00:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1B9365F81E;
 Wed, 26 Aug 2026 14:00:57 +0100 (BST)
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
Subject: Re: [PATCH v7 047/104] tests/tcg/arm: user tests
In-Reply-To: <20260818192309.22169-48-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:22:11 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-48-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 26 Aug 2026 14:00:57 +0100
Message-ID: <87bjapox2u.fsf@draig.linaro.org>
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

