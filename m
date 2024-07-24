Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF3AC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYiB-0007z8-AQ; Wed, 24 Jul 2024 05:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sWYi2-0007le-Lg
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:54:58 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sWYi1-00053d-2E
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:54:58 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a10835480bso6041631a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721814895; x=1722419695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T1nDqo34E494WR2rm2usofOlPBqPwu6KRcZHT+s6HgU=;
 b=RpE4kaveFogXKKN07MkMo5hMaQ5Ij0Gpt2vzhD7hUizy0MsXZh/ixTM0Xs0ac3X4ze
 M1XD9n7dg3vHlacEOHrJuNe2A7uSeX5kAFAlMpXtNVZAgEq2YKCIiGlLsiOro9xm6Wr7
 m0aalmsKTY2saFwKzgD8RebTn9+x1pFalcWfSIWs/izQN6ILW83Yi8MsShSAsrdW+xWt
 hziZEuT54XThnbu9XLDxLiR6YRmarInRmbupgzmJD6GtpbHRlD6235JEIiseX+TpuQ/p
 q8LtlLOqvRoJ2yGJj6AMU2lVl9UwHIf/LjKtZ1K9flvHkF5rqpagnk6DTwqofLAzkxkQ
 cwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721814895; x=1722419695;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1nDqo34E494WR2rm2usofOlPBqPwu6KRcZHT+s6HgU=;
 b=GsA123QzM17MUy8JTb9Wje9+PX9SmmpTlTqGL4wmOF2UhWu2xHVy9tJFEf7jquNsht
 /VWJfTJvKO6DnjWEeIy+OZXzfnOjPRGH9WNDQPGPjqN2CGyrGpORCIU4C6H1utZiPrCN
 6nZX0kdWQiJl1EKikCuH+YSUWvrb16RWliHYp2vhx4pokTK8F5EXoUc6LonofAxeD79i
 xhFUoTFYCrDf5KaGLfT/R2hXL37V7TCo7ldGyfS8iKUkN/Ilt2cMrtqFGNT1K3erOH9w
 LftuJyNWUswPfG4RxAdjjLMMifJy9a6aX0PRlRDytvrniKycRXypb7CyQfC0qHZ258rU
 zBEg==
X-Gm-Message-State: AOJu0YzCoNdc/S2ke3QGx9NGk9HqTFr9nmlrdTv8a/URIfxg88DXTlnA
 W3wvJmDLFs+t9OXhl2rwqCiEnYUfYEbjlkAXsyP5OT/B8OXk78/GVjFtTaGSl+hWuf/Aldi3TMV
 T
X-Google-Smtp-Source: AGHT+IGLG0iGWcP84GdJntrgoUF14/0Bwh/MwdLP5CQLhkxeruu3Sv6pxiENd0MDBHhJT+PWsQMjLA==
X-Received: by 2002:a17:907:9620:b0:a7a:b73f:7582 with SMTP id
 a640c23a62f3a-a7ab73f7ae3mr78999166b.2.1721814893975; 
 Wed, 24 Jul 2024 02:54:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a87c85d7csm199897966b.198.2024.07.24.02.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 02:54:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 534905F738;
 Wed, 24 Jul 2024 10:54:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] tests/tcg: Fix new cross-compiler warnings
In-Reply-To: <20240724010733.22129-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 24 Jul 2024 11:07:31 +1000")
References: <20240724010733.22129-1-richard.henderson@linaro.org>
Date: Wed, 24 Jul 2024 10:54:52 +0100
Message-ID: <87ttgfw1w3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Recent updates to debian cross-compilers have enabled some
> new warnings by default, which encourage good behaviour for
> userland binaries.
>
> Neither are applicable for our system mode kernel images,
> but we do have a few userland tests that are affected.
>
> The --noexecstack assembler flag takes care of adding the
> appropriate .note.GNU-stack elf note for us, rather than
> writing a dozen lines of assembly template, and so is a
> true fix rather than merely disabling the linker warning.

Queued to maintainer/for-9.1, thanks.
>  10 files changed, 11 insertions(+), 11 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

