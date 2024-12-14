Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C6FE7717F
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 00:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMFg3-0004zP-Oq; Fri, 13 Dec 2024 19:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1tMFfp-0004sH-9M; Fri, 13 Dec 2024 19:06:23 -0500
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1tMFfj-0005h9-Bp; Fri, 13 Dec 2024 19:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s3baxnvsv0QDjdbqpZIjo+pfDf0zddAKGBM4vYP+R4s=; b=AJ1SV70n7ay56Wph5Xdsr6p6Fi
 ypQHjAi5++9f6K3K8cMFXVCH2s7dvz+JMkaIlBo/lK9PaeDMNi/Q38Sf5hfM4hllCFstq43GI3JIs
 calJyadqr4UGXbq8Y2sW2/hu/MZNMWw46Zc9M5goyZaQtwdZCeR99GZjBBAinedWfQeEgm/T4miw9
 ZTt+YioIM0tfkuWx3koJEJp+NbnzFzNJO4bQjV05qs8YzDJ09d3TCdIMIcpYb3egXDwr+f4ofM95g
 GhRivEcAA2t/BPOBkuZNquIHG/zCQrdwQ3XsDHwrjeYdqxmhmeJPdToREXKyQKnj+itqMXjmg7WH8
 yJISu/bg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tMFes-002sgk-73; Sat, 14 Dec 2024 01:05:22 +0100
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1tMFeq-007HeJ-9B; Sat, 14 Dec 2024 01:05:22 +0100
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1tMFeq-007aKe-0O;
 Sat, 14 Dec 2024 00:05:20 +0000
From: Alberto Garcia <berto@igalia.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin"
 <mst@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>, Igor Mitsyanko
 <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>, =?utf-8?Q?Cl?=
 =?utf-8?Q?=C3=A9ment?=
 Chigot <chigot@adacore.com>, Frederic Konrad <konrad.frederic@yahoo.fr>,
 Thomas Huth <huth@tuxfamily.org>, Joel Stanley <joel@jms.id.au>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, Magnus Damm <magnus.damm@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Vijai Kumar K <vijai@behindbytes.com>, Bin
 Meng <bmeng.cn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Nicholas
 Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Samuel Tardieu <sam@rfc1149.net>, Amit Shah <amit@kernel.org>, Stefano
 Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, "open
 list:Raspberry Pi" <qemu-arm@nongnu.org>, "open list:OpenTitan"
 <qemu-riscv@nongnu.org>, "open list:S390 general arch..."
 <qemu-s390x@nongnu.org>, "open list:sPAPR (pseries)"
 <qemu-ppc@nongnu.org>, "open list:X86 Xen CPUs"
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 20/71] hw/char: Constify all Property
In-Reply-To: <20241213190750.2513964-25-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-25-richard.henderson@linaro.org>
Date: Sat, 14 Dec 2024 01:05:20 +0100
Message-ID: <w511pybi0xr.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri 13 Dec 2024 01:06:54 PM -06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alberto Garcia <berto@igalia.com>

Berto

