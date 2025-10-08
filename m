Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D260CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 15:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Vfj-0005vy-K0; Wed, 08 Oct 2025 11:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v6Vfg-0005v8-Fx
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:01:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v6VfZ-0002yR-QU
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:01:40 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so5795f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759935685; x=1760540485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4F5/hkfJsJMznZp9cQnW4c0cmQGf7sSVPlcxHG8kYOo=;
 b=TlM7GqmTAznl4xh1AX0D1dCYTu+48tmmhJAdqAW3BPb2Zm7zqHpEl0P/IeJhHxvwlS
 kPW+ximmNGriK2ZcuvEsIaCnErT8W8aMJZWet99t/XjxNAbZ19IOaLVAYk+1Hs7INE6i
 qI1eLAqPDMHouf3g1zl4f4qCh0uy1lCk+UYwGjYN4M/hqq2jwcsNtOEmFIWq+CUc1IRq
 w++zIwu+wSOmyesunfH7jux1u+chuTCuuemtzT99Q9xwjx/Os436xwt9Iwz5qQTVOeRY
 3EorDJDMOjUnrafiYaPvyPWQDUjiBlm6j2jHPuHzWSI93LHEtJofPvADeYPSYdTIUWWg
 n4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759935685; x=1760540485;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4F5/hkfJsJMznZp9cQnW4c0cmQGf7sSVPlcxHG8kYOo=;
 b=pkxbU57Or+3A/WBK8es+8/ATm7yBojrKMMInX51gp6oMjEIgHzMReQ6qFH75fwLdJm
 C2a9PA+kgLsEdNcG8ha167sI4wIQNXXslQqdNEqGtIizBX4Fu2FbTHQbbxBrwKCKHoca
 FXMfSreSowVIjGKAFb7RTfHYwpqSP0OfX+OSkNwHFCbviVAbdLbRLwbNSApQ+KkjVEmH
 Gx6AFP2ljVqQ+zdOe3jsy1TavvjrRTjy6fSPmgZUZtjWxKscgC+cSf+K3EqlBackvcM9
 Vj2UIvIoYH8LunXQLftF0nvpgHxPnW29I6d9YHEiPBGMxHLQ3nGhPGB7s6fsm0m7h922
 PSEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd6Zb9X2zjTo9QHdb2/LFApJQjQ0diErtAqs1hV0y5/IxKDFqlMfW0JWoq8BzlVr3x8kiz7AQkG6kc@nongnu.org
X-Gm-Message-State: AOJu0Yz0ETlbMCY25Bq2KC/YNUwHgJPFRoU0ry65g5FsDOwl6lQ9gCHH
 jEMN+yan+mtdvIbAz8uAY6ILCK9uG9V3D4ehcVoJw2zBbuvlZX1y+ArxfkRNWIJQ3oktl+nKLPR
 bnBYm
X-Gm-Gg: ASbGncu6G5XY7SWAoZHg4UW1ionpTctVSVs6zR6tSceoej27uA1p9M5AljHZVxQm6QQ
 lEifkK0uK8le+QuC7/UacRw4jymylgnspqw9yFEGfLc9TxB2gzkCKwSQGVNoZqM6enJs8fpDoCw
 PIyFVwwxBv6xMVrl35HppeRRkNE1CZIcQ9aGJ9vyIVmgEadmnZQ/Nufo/h6+S3OCkURLf2m60Vn
 deYRpu5OdVWBxbH9KtUbpheHd5Q/1pN4TQKyYamegg3QgE/mm7A0g8yv8b5jmFpwJC+3dGsX0pb
 KxWLPf/iG8qXWqXzsDyYVBAs9z4W3YJOQlxeWZ64/CjCFoPGZASE8xuCz6SODsIZIo3AhkkKwxz
 XB4/UUQiqTZzmrznKC3GxFbEsZXoU5BM+JEp4JAVk+G/y8TAXQJc=
X-Google-Smtp-Source: AGHT+IG6xEEClz32xk2nxvde7P5Dj+DIbTfxWrK7w3LARm22M3QjfrBeHzABx0cIKBgx3pHLcf3m/w==
X-Received: by 2002:a5d:64e5:0:b0:3e9:b208:f2d2 with SMTP id
 ffacd0b85a97d-4266e8e0a16mr2227267f8f.50.1759935684692; 
 Wed, 08 Oct 2025 08:01:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b5csm30513915f8f.5.2025.10.08.08.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:01:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 036BB5F83B;
 Wed, 08 Oct 2025 16:01:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>,  qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] python/qemu: Replace some remaining "avocados" with
 "functional tests"
In-Reply-To: <20251008131936.71160-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 8 Oct 2025 15:19:36 +0200")
References: <20251008131936.71160-1-thuth@redhat.com>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Wed, 08 Oct 2025 16:01:22 +0100
Message-ID: <87ikgpxwsd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> The avocado tests have been replaced by the new functional tests,
> so also update this in the README.rst files in the python directory
> accordingly.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

