Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0873C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wenXm-0007Ng-Sd; Wed, 01 Jul 2026 01:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wenXc-0007Lj-Fb
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:31:20 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wenXZ-00021e-NA
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:31:19 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664a10cd4a4so231934d50.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782883876; cv=none;
 d=google.com; s=arc-20260327;
 b=aR9beL8ZzfN1UpFTy6zF+cTAG18kjS1PvNjngWBEylECIDZeLtUSB1fyD7oU4hfa6s
 rpypG9n4K0Z+dGDdgxJj4o8QRCFt8S11PmZXiVS/0wh+oPpiQPHl15yjwq2AQnnvOHCX
 DVBiB6JreEOqVMsMnzFUYiBnd8ahD9xa6IfTmGrIhgJNDpvIHrAHFvdwUu2lhbZY42mC
 7CE37R/i7WCe8PjhUo2JVykw+av63O7y1fO5xop1LKOwwaDukgp3TQ8XyA94Pvtr4SMX
 /1JNsVRI03gKgE2vCXdv1TJH5QvknXh8iISjbygKabYHHZYrftg4PHeLumzNdh8KAiFR
 ycPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qumB1HQNK54XV6pA63sNU72BNvN5vUyyyUMtH71WTp0=;
 fh=QMl3m49tuLtOusuuXCnCOZCsoZiLfsjUwXG2nLBmcSY=;
 b=lNf6zwP9zz/e7/AjK52FVN6VM3Pc5vh7vHbfwct0w0MO3q462ypsue3ePG2ZyEOnX6
 Hw3DQzFVsYhP9kSPRUnFsSzv3U93gs+Decty+lAbr3vVBHq2rYwe6t/Y+Flswsrp1J6Y
 gJRGl0J1tN2IlVbo+YlMSe6cS+UfLLCw1A+orvCcrZLJHRfS52lA8dOvQ7lTIpaawYrn
 Y3Bdyi9T+63umbEHI1Q2t6MHLe8Qw29FQtiBn9Vk7VWYk11nekwoGzZWHjTJbGVBrMsg
 NUBTpQNcCovHzw9/iCdzuxU4URK0AsnkhtTj2Byp1PnykKya9Uco3wMUG53lhlqWEos4
 4utA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1782883876; x=1783488676; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qumB1HQNK54XV6pA63sNU72BNvN5vUyyyUMtH71WTp0=;
 b=NJ8QYcf/y5o1RkE/jCs6L6aJiLOnAq8Lkw2yOts7hSpBW5skuawVvCDAW1YPdTlUvD
 ZrXcwZX60r7tqXuIt70FqicPL+5iFenT43fd4JqYoZdnfCkHG1rqJMbo8sukXbo6nVN0
 oj/tGIk6gr7c3w3WtSI/ibBdhPB3hgPTlQmfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782883876; x=1783488676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qumB1HQNK54XV6pA63sNU72BNvN5vUyyyUMtH71WTp0=;
 b=C31sUvKZITcZjHUwNdkIuwoj5ibKHR+juA8ZrtRInK/sEMJKEeGOCHB+J7V+kwnDUI
 J9Xwu/p9IuXcdIOg/lESMU6aBYIvYGkV5WJRsWivMqhC91YhgdjVrSTuSd6WVH53Gql2
 KWNubmcTO5rHHUTNWzslNR0hh7DFbQraASPMXhgq92unvXqiX1NxLRs3YGF0uswtpeSS
 wragSSaBuOhs58FM042DBQtNDrNp28hCTT6FQAiKhPqzoxwjqC8LCd2DWUV2aHZEvKGM
 WM9tJoWgU3WzAHk9i+Y2bWC99qfcNmKFh8pFZPnU9g1iCiGv8KZtYzN9W1CBpuBu7Xw5
 Xctg==
X-Gm-Message-State: AOJu0Yy4hoMcT/LSrK1Jo7pnN78bKAOhseYxQjSPSmYh304Xl14hXdVe
 +Zj1tpEMM5t18oFHye+82Jod5inefN5V3g4hSxk3Q1XfXduxk1Zn2Flf3/pmBKPJFtIhfxYlk0N
 SyqZPc4s4U8M6lSDKrdQ3N1AMjgwZ1+o=
X-Gm-Gg: AfdE7cndDTwF73aNaIkw+MfcsSWY5d24P71rnC2A6xxOQpzOIG7wWoyjos0s0ZQYzUc
 pbihEuMj2HiC6y/TP3+22w+JYmUkO0KdMSc5Exh/5l4hLCptabGApHewQuIY6oTVTs/EqB+xsAz
 PNVt/Lvj3cuzfLwId/WFdLHoXHK5NcLJTD/bSKv3LzQdP5k+xWxhflYjAfTuJrHtvIJUEXnYmWW
 Z6QOB9NhOul/88nphVgfzEhPY+auYz8wwYnZEEatWSf6419yj4uQwoJ0zEcqjCQ6+Z0NNq6jHIv
 XAKdtRIqUHrmCxltGpHYKTiiSQnWxm7ERmDVE7LZJeYjzHnmftyqkHjxBeArLZpFiBp/SMiAoK8
 NBk6e2ZME2tmaAQ==
X-Received: by 2002:a05:690e:1685:b0:664:ae6b:b48e with SMTP id
 956f58d0204a3-66521d6da0emr143158d50.67.1782883876544; Tue, 30 Jun 2026
 22:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-7-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260610214133.1882563-7-daniel.barboza@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Jul 2026 15:01:05 +0930
X-Gm-Features: AVVi8Cf5S4JHTzWCSpaPslLda1whiSE0GE5opuQv0XFG7BFe1-FGrhcyBnAKaoE
Message-ID: <CACPK8XcDX+x3MFLG+XRJVTrocVugoRio06DUsOLJPLA4D4MqnQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] tests/functional/riscv64: add riscv-server-ref TPM
 selftest
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com, uwu@icenowy.me, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 11 Jun 2026 at 07:11, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Add a TPM specific selftest for the riscv-server-ref board.  The test
> will be skipped if there's no 'swtpm' in the host.
>
> The test has been basically cloned from our Aspeed ast2600 friends.
> Shoutout to monsieur C=C3=A9dric Le Goater for the code.

*cough*

 > commit c3d58a7a26ffbf2ac54ed6d7a3a83f2a7af7159b
 > Author: Joel Stanley <joel@jms.id.au>
 > Date:   Tue Mar 28 22:38:44 2023
 >
 >    tests/avocado/aspeed: Add TPM TIS I2C test

:D

Reviewed-by: Joel Stanley <joel@jms.id.au>

