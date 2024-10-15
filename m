Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01337CFC501
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 00:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Vng-0005wO-2I; Mon, 14 Oct 2024 20:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t0Vnd-0005wE-Ud
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:52:34 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t0Vnb-0007yp-Ti
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1728953542;
 bh=a1agV5FVUnaR02ldSz0VFuAR88TFMvVHq3Qh7ZAPNXg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=lvoYke4X+TJW6dUEe37uNgW00RZrZmzBUqlEbjEdQyzCBg0srLSO/aUwh6IPlAwKR
 WG9fu20a/gJZ/EeEUb5iHogNAGEewLiUIz9b9saIRFJQhzQNQipswc3ladUvueoKlT
 Avwo+gRLw7Ug1mlNb/vZ1rINstan96YjmMRWgL+pmoF1O/9/jM3+9cgCrwzfw1L1UX
 yP7Bjt/ZgBMXvdcFNYdtehrfzMCmYjrhbcEuCxZ1aL7rZ/WU1dxdh1pGAR9CNfdcm4
 FNCYvqNZeRhTekb5N7TLzRRt/WU+JHeLyEI8vCy69yr6pSU5CWwjYgu3p60qpK/0nv
 BSkqvkbAFF0sA==
Received: from [192.168.68.112] (203-173-0-39.dyn.iinet.net.au [203.173.0.39])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B9673649A0;
 Tue, 15 Oct 2024 08:52:20 +0800 (AWST)
Message-ID: <50e53816509f6c3d51e55349817adb3612b604d8.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] hw/misc/aspeed_hace: Fix SG Accumulative hashing
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, 
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com, 
 evan.burgess@seagate.com, peter.maydell@linaro.org, Alejandro Zeise
 <alejandro.zeise@seagate.com>, Steven Lee <steven_lee@aspeedtech.com>, Troy
 Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley
 <joel@jms.id.au>
Date: Tue, 15 Oct 2024 11:22:20 +1030
In-Reply-To: <eff3385f-6d43-42e7-8b36-7225e2fee7df@redhat.com>
References: <20241011053825.361544-1-clg@redhat.com>
 <eff3385f-6d43-42e7-8b36-7225e2fee7df@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 2024-10-12 at 08:20 +0200, C=C3=A9dric Le Goater wrote:
> + Aspeed reviewers. Sorry about that.

All good. Seems sensible in concept and from a cursory glance, so if
you want to tack it on:

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>


