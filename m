Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A09EF36BA4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 03:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB2CQ-0006Ke-43; Thu, 09 Apr 2026 23:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB2CO-0006Jy-Mm
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:06:24 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB2CN-0000wJ-5P
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:06:24 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so244880366b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 20:06:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775790382; cv=none;
 d=google.com; s=arc-20240605;
 b=BYwr811BRtsJeakIn6WbZUHl/dV/y749FSYCKg2nXDFbdn10xdmM2XZHjYshdD9PPh
 aUJDknOYIdY+EGfutXV6UC/1eB7HSUfZQl5BMUF3ImrOtpxk1CX9cKR6foWur1uvFvnp
 yDMJ6aqR8lQLus8BQ1nETSr9LrXezdCTeXeeSEuwxhQU2pGCY8RMm97oYrAOrGjpyqJ1
 81ecsMKgdGBdK/kmohiT1ToSLlRFEcjT8M90tu+2zuoKxHuDlQnr2NuxD5omHDKcPu36
 BWwphtgZIU3bOJZ2K8s1AqWtYaUNT5x7WEdrjHpGbTJnnepFjpkhDLm5RJsLMVyVUE8b
 EMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O/v9BNw6moGVWKKKvr6uhW7rv9fKfG2kNcmDfAY1m2U=;
 fh=XKSN9paJ64y8+2A8hyFkzRThM2aineFmGefUDO9sU8g=;
 b=WWj77w8GXnb1y4aDuLqdQXYAKU34XPwjmk+nWIcCqH3zPd/gyRA++ExVxr0XE08JhI
 FxmDA05CtgWm+YJobX4ig88ilguxGHdjujGEWwWX8UFI+69SN/E05zxZIbS8VEQWDGQw
 XjjrWJG7sXwWSbpvUp3jX/D3KUGOfsbiEwbKSXTUg2DKrQsBRImi0DbJ4EDccvCHADnK
 Sc+Py2Wr81BssLCLLaXKWwNtx73gh4RsdKg7xX8Luf59oa+S2qVlgat13wN/XeiM7SS8
 fr8Mqnawlh33AvEsl+RE11v0kj4/ccPSxEfRE0xDAAumrm+0k5k4hn6t8KL4OriSOMk/
 oL6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775790382; x=1776395182; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/v9BNw6moGVWKKKvr6uhW7rv9fKfG2kNcmDfAY1m2U=;
 b=aEGI4oz5wQ0qdJ4fezkPdCezIR5HMkG2tL5UhJiaZu50MvWVwYrmikNtNF/JiboDX4
 101+XhmsJB2YDzE7jORtwmtnTzUf0AU6fU7P1n1Uif7noawbWa3x/rY+Y/bjgr/+0zQJ
 F+pu6uyALH32+xyG0j5dn3zLbi/9i0dgMnmGG2iTrdCsXG+/gIEW7qV/d77GAPIK2f2x
 4gndQgph/9awsXMho+9R5V9o8lOLxju9kyaAxyvJ1azakkARNzqvpOaKDupOlXIq9hv/
 iJoJnGhGVRTA+EnQNPRAsoowCqIc0DtoSIjTYr/WJJkp81SuoCl25cAoFXJWe0wDp9T8
 S1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775790382; x=1776395182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O/v9BNw6moGVWKKKvr6uhW7rv9fKfG2kNcmDfAY1m2U=;
 b=fWrQG63cNbtjH54KhkT2fK61nC5xtf04v28e9a/rPh7IwjKqCrFFsBjahADyUg0tCf
 4uPxC5YYt9IG7Qh/01DDLVMZ1wotfW/ulVk7EEDTRSs6MrLEfiD1Y7tchkytCDXwMQ2k
 wP4MskAO8kn9LpEE4oq9AwulQNbYnBkV2g+4E+GbyRaALtQ3zNQH/qDOkfCOyxKfypdh
 IOsHBBc7bQnYMTkV7tsVn9GNy7ZLz2sHO0a9DCDBsz0m8Sdn5GaBR+CDjJI4HvJzMkx9
 uxB6J6BK6URgd7rdQvSphOuYAHdtmGzn6TDswOuL1q2wDib4hLFm4w5xappStCIGeX8l
 JwEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmxRHSIpTMPeL+qYJ6CQdjdBmR6RDKPHmVY7RTuukHM8f/UUyZxZ7LtrYO3bf7GZ4Mlu/TUMOyAhKQ@nongnu.org
X-Gm-Message-State: AOJu0YzCh5hsD1veoHACUawmqF9MmLdICewrO1Ip8hhn5AXAlkzsRN+d
 KUJ5kwALK0bxInGIEbhhnTRvV8+o9KQ5cuK3hXX4wrF5AhaX7dUTjJ2Wm1By8YZNEBb1MtZIYSQ
 qO2+hw00/kmdOFwthH6Iv6KmRj+20I/I=
X-Gm-Gg: AeBDieuN5DRtXmkZIfZBP6TyA9yx/YvxgDn07d5/YXWWPidfcSv4i9IwatsaiVgiGMH
 Tq8Ha5IrpkHpWhEQU2swwRthSoyNtmB3Oi+DfYMqez9ZSNb7Xx/lGR6Uyht8eP1iw1aEmsMdyv4
 CKjRBmdg4dfxWMMgZVkl9njdkT2+Gt6YkOq7Z+j3ZX4Mfld/KmBbvVMWgm/FS7eH3WbAYzYblkU
 K7pDbqNPU2wJQx3KiuzxdzzDhjqwLp+eNmToBTWlOvvEw9XM6eVFhouS+YJHgSjYMQhUHcObl5n
 ekGajAV4cbgKuNG5uB3uNRN157I+zjeoGvfXlA==
X-Received: by 2002:a17:907:3c92:b0:b98:6177:2ef8 with SMTP id
 a640c23a62f3a-b9d72612784mr82268066b.20.1775790381443; Thu, 09 Apr 2026
 20:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <177564643888.23414.7922925369077631439-0@git.sr.ht>
In-Reply-To: <177564643888.23414.7922925369077631439-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 13:05:55 +1000
X-Gm-Features: AQROBzAva2_Qh1Tx8hnXXDaGLJoqhCGmhvqVq6R6AXgDcblNHBydD6B9lMG6cHo
Message-ID: <CAKmqyKOnVOx_xe0ZVm6y84mNk_wMhty7+Mh8XsR6sE1fmXEkUw@mail.gmail.com>
Subject: Re: [PATCH qemu v2 0/7] Update opentitan uart (part of supporting
 opentitan version 1)
To: "~lexbaileylowrisc" <lex.bailey@lowrisc.org>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org, 
 Amit Kumar-Hermosillo <amitkh@google.com>, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Apr 9, 2026 at 5:31=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> Second revision of the patch set that updates the OpenTitan uart to
> version 1
>
> I have made changes as per the review comments from last time. This is
> now split into smaller commits. The first renames ibex_uart to ot_uart,
> and the rest introduce the various changes step by step.
>
> The details of the version 1 of the UART are found here:
> https://opentitan.org/book/hw/ip/uart/index.html
> (This URL is added to the file header in one of these commits)

Can you include a version as well. So we can say we specifically
support version ... (git commit or release is fine)

Alistair

