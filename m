Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE43C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9On2-0000ME-N2; Mon, 28 Apr 2025 09:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1u9Kp7-0008To-IK
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 05:30:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1u9Kp4-0003s4-6I
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 05:30:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf861f936so8205885e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745832637; x=1746437437; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GvwhPIpQn359v0qyBmxyMv9j3ikVx0hz8jqlbk1R8X0=;
 b=PtjJVJyqgHb32O9wJFzZDuaFasR0jRSMOpUMk1SHCc7CFDHnk9hHAJLlOLuS5eMyHY
 OtcZhL72v7qYzNll5z0hSXyAvBFxdYlTFGWEUaurG5wxbJMaIKw7t9KqaAC7hpF3ooue
 /gKFj2fybODNZKPBsUVpVe5q3eFVXxWOay8oKh4ExJflnI5enYiRCBB5aRlXmt2Js9ph
 qo4JDYFh/1SQZFYpI4raJppqbjWtMFkPlzh4CNm1S2MdFOGOeANeXnAQSYradKjhI4cT
 nP6Se44yIhCTL3tgLrtJROBZsXEiqxTbuaL8DVk+G3SCPfaK4LOkcZJETjbH0vTFuXhS
 4KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745832637; x=1746437437;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GvwhPIpQn359v0qyBmxyMv9j3ikVx0hz8jqlbk1R8X0=;
 b=W5NDMlJGLgV6sAS1Gx1Ffx9eUuZByJQN+Kqj0o8FgVxsuUgZEd3kyxziOGDLpIzscw
 Q5rnRmV23nlS6n1vnvLhg3bbhsQOEi8Uos+aa/LhwXczcHjD/n61U59BDor+AvfElPjH
 sESTEeoBCIDulbP5SeUCpIqmcgSe8h8oMU+TEpzg4pLfEfdza8BU52l1MyCOOZwShPFU
 W8VpEzOKeiJWnktsxtdgYe7PzRMRs7/KLsVoZiqla427+wMEfF7qdr9KRmvaYoe/PPVo
 ZVLHh9uPM+ECeUP6Yl4Wc9fdVqkv9uUueBUXZnOKYjxF3ATsUlgexY7k9gedBJ8u2fRy
 2+xg==
X-Gm-Message-State: AOJu0Ywn2LnxCPtCLyzPKx0piK7UXBCOTib71bH99KrzRGDnQy10rKjZ
 +oQKHdmBbXHzTn/SIHXzMq3H8LJEbqCeqdipQyR16MrY/tQj0sNVuq6zn4tQXh4=
X-Gm-Gg: ASbGncuJlFJ3pnWWYlBI6Y6OFjNRggjSIcgIhFNlZYV7X+CoSIxIQw1hVKZWGyNtJrp
 4t84lAOhz6JlkmWOPcfFw0BUoo5Mi4CwcdFWyZTnbcudVHos0XIh3/x7FWAs2tdDyjd9mC45qEb
 8z0y4ElFL0Do0Is5Oj0v9S/jmz1IOJqFMrAPEbWmI3oyb/kI21AfKc3dm5XtE5Tzj00AMUVFlV2
 5ngNMOBy+JnfQJ8io9fIx3VW9FfH3Kb1QOAhC4rd+5TlNuHjsNeSBHmM+F5+8Hrq2KFh2rYXRDb
 jwn8zATFu6xzj4qv8CrkR3n4qrbVNT+AiRXQVeqkcFUqBgo=
X-Google-Smtp-Source: AGHT+IH7pP3BABosasxDT70wYCz04PeaGBsznAR6dqqFdis550g9WRq1VyVxm6JyknoLkveRN+mMtw==
X-Received: by 2002:a05:600c:1d9e:b0:43b:c938:1d0e with SMTP id
 5b1f17b1804b1-440a65bad64mr35411945e9.2.1745832637503; 
 Mon, 28 Apr 2025 02:30:37 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:785:f3a7:1fbb:6b76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a1dc3sm148647735e9.13.2025.04.28.02.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 02:30:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Apr 2025 11:30:36 +0200
Message-Id: <D9I60P8TG036.2ZHSS9EHW4W8N@ventanamicro.com>
Subject: Re: [PATCH] target/riscv: add satp mode for kvm host cpu
Cc: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, "Alistair Francis"
 <alistair.francis@wdc.com>, "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Andrew Jones" <ajones@ventanamicro.com>, "Meng Zhuo"
 <mengzhuo@iscas.ac.cn>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250427132557.1589276-1-mengzhuo@iscas.ac.cn>
 <20250428-00fc862d2d2d628ffa4c8547@orel>
In-Reply-To: <20250428-00fc862d2d2d628ffa4c8547@orel>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Apr 2025 09:44:40 -0400
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

2025-04-28T09:00:55+02:00, Andrew Jones <ajones@ventanamicro.com>:
> On Sun, Apr 27, 2025 at 09:25:57PM +0800, Meng Zhuo wrote:
>> This patch adds host satp mode while kvm/host cpu satp mode is not
>> set.
>
> Huh, the KVM side[1] was written for this purpose, but it appears we neve=
r
> got a QEMU side merged.
>
> [1] commit 2776421e6839 ("RISC-V: KVM: provide UAPI for host SATP mode")

KVM satp_mode is the current SATP.mode and I don't think the other
SATP.modes can generally be guessed from the host SATP mode.

Can't QEMU use the host capabilities from cpuinfo or something?

Do we need to return a bitmask from KVM?
(e.g. WARL all modes in vsatp and return what sticks.)

Thanks.

