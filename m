Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1406BCF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 11:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLAh-0004Rr-AW; Sun, 22 Sep 2024 07:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLAf-0004RN-Fv
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 07:54:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLAd-0001Ra-NO
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 07:54:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-374c4c6cb29so3362984f8f.3
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006069; x=1727610869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uzJepf6g2FweBahKlQGwikve9wa9nyEXSc/xm7j+fn4=;
 b=D2cLfDK6b+aJFcvJ6VxaOudLGSy/QqY5Pn4sgNJ2GGrFx6iT3eS4RywtM4YNbgHvd3
 OaxDGGg5kf2rN70MIwz3TTIcl5JvyHAgmy8WEyUapA+aDRxB8ZpU1tI7a+iFptWOrAF0
 2Z7F8ZrnM2hTkO0JuptrKvZkxtlg+x9Sn1inI6b0DCI6lBShWIDJCQyYlLRRMgDpx6Ds
 HYI0j2iquz/FGp+WsczGkQSMyc1OAdft7ALBMfn+IBDKrzqZiUBkExoDcN6u7oAHro9A
 iQ2UgxpijqeEE+tsd6nre0zcp6CXephNnlO2FH8YLfOaq54VNGt2KIACO6sXcaZr/qZL
 6OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006069; x=1727610869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uzJepf6g2FweBahKlQGwikve9wa9nyEXSc/xm7j+fn4=;
 b=uob4Q66iAfIMafMVJnHjhHMvirhFpwSFPdRgEgdd4eBSE57xkO03oxyVYXLOpxqfpS
 RJei7DfBy38jQFkHNJxsGvGgDH2cUYL5RoroZeDjQF2iaOd2Zlo8uPYvWI/Akw0o1b4z
 16ZHmeJ9VFFxu+kEno5R5M3bPaDVR4vB8lJtI4M/f8UGUMfSqILIVEzGhjmqkinDo0Sc
 kurVIONSYwYRkk3yxVi7amRFxep9s/OIu8WkihVek1+aPoQRdhzHerAAxF4VMcUf4uYk
 LXq2s7GY+/ccAXPWLjSOIiFJT9PUPCh9dnFa7/xli9nV2EQ+OEBs/Q6vsfMTcpTj4N1i
 KHcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeCe7nTxTtPnFIInkKuG1UFjWBGSc+9lIiguiBHYhns3CxDm2pnYqxkDTClBDGGEuxkPG7Y+Nv/Rqv@nongnu.org
X-Gm-Message-State: AOJu0YySdBtMV0mm87RI+53A55gM2oD3dAGQkfRlKQ820/+BteAMMiu+
 Ax7qOp+BLu3AAKFeukZcVYIFHQfEkXKjxfWqKraEfOD9UYAbGW1RoKnfNHRqyu2sJyRUc9Qmhgk
 dznc=
X-Google-Smtp-Source: AGHT+IHpPCgvaaaEwn+V9aA/IAjnpK4yAlfq7deI8QzL0IE+ayc4RIrMtFXOSDJWEbIxDKAxNWqecQ==
X-Received: by 2002:a5d:5501:0:b0:374:c3cd:73de with SMTP id
 ffacd0b85a97d-37a422ea0a4mr7640764f8f.35.1727006069343; 
 Sun, 22 Sep 2024 04:54:29 -0700 (PDT)
Received: from [10.5.50.249] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b7f14sm1075953966b.100.2024.09.22.04.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Sep 2024 04:54:28 -0700 (PDT)
Message-ID: <32d21730-1a71-48d0-9f9a-4bf3f49fbe70@linaro.org>
Date: Sun, 22 Sep 2024 13:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] linux-user: Update syscall numbers
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240918074256.720617-1-laurent@vivier.eu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240918074256.720617-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

On 9/18/24 09:42, Laurent Vivier wrote:
> Run scripts/gensyscalls.sh, scripts/update-mips-syscall-args.sh
> and scripts/update-syscalltbl.sh to update syscall numbers to
> linux v6.10
> 
> Laurent Vivier (3):
>    linux-user: update syscall_nr.h to Linux v6.10
>    linux-user, mips: update syscall-args-o32.c.inc to Linux v6.10
>    linux-user: update syscall.tbl to Linux v6.10
> 
>   linux-user/aarch64/syscall_nr.h        | 19 ++++++-
>   linux-user/alpha/syscall.tbl           | 28 +++++++---
>   linux-user/arm/syscall.tbl             | 24 +++++++--
>   linux-user/hexagon/syscall_nr.h        | 20 +++++++-
>   linux-user/hppa/syscall.tbl            | 41 ++++++++++-----
>   linux-user/i386/syscall_32.tbl         | 28 +++++++---
>   linux-user/loongarch64/syscall_nr.h    | 14 ++++-
>   linux-user/m68k/syscall.tbl            | 22 ++++++--
>   linux-user/microblaze/syscall.tbl      | 22 ++++++--
>   linux-user/mips/syscall-args-o32.c.inc | 20 ++++++++
>   linux-user/mips/syscall_o32.tbl        | 36 +++++++++----
>   linux-user/mips64/syscall_n32.tbl      | 32 +++++++++---
>   linux-user/mips64/syscall_n64.tbl      | 20 +++++++-
>   linux-user/openrisc/syscall_nr.h       | 18 ++++++-
>   linux-user/ppc/syscall.tbl             | 71 ++++++++++++++++++--------
>   linux-user/riscv/syscall32_nr.h        | 23 +++++++--
>   linux-user/riscv/syscall64_nr.h        | 23 +++++++--
>   linux-user/s390x/syscall.tbl           | 34 ++++++++----
>   linux-user/sh4/syscall.tbl             | 25 +++++++--
>   linux-user/sparc/syscall.tbl           | 40 ++++++++++-----
>   linux-user/x86_64/syscall_64.tbl       | 22 ++++++--
>   linux-user/xtensa/syscall.tbl          | 22 ++++++--
>   22 files changed, 486 insertions(+), 118 deletions(-)
> 

Queued, thanks.

r~

