Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AF61048925
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 00:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw8TL-0007T0-I5; Fri, 27 Feb 2026 19:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw8TI-0007Sm-Lv
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 19:46:17 -0500
Received: from mail.envs.net ([157.180.15.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw8TG-0006lL-EF
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 19:46:16 -0500
Received: from localhost (mail.envs.net [127.0.0.1])
 by mail.envs.net (Postfix) with ESMTP id 6A2981C0094;
 Sat, 28 Feb 2026 00:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
 t=1772239571; bh=43vWZSzvd+MR8tU3BynNjOBNmVca85K4U+RlabSwFlk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KWofh4uUo6Zt9LI+MQso+9PkM1xB224hCgnC0e0E2Y8XAUwVwccPPLEWKv+qCaEP+
 IbXzMnFjsnRceag0LMta8k/9engFj1mReIjL9VGOnRoceOFEj93gq9NXpL7Lyw1+C4
 D8hsnt2YuM7e7pDC57CvnfkBvZ9Emylvt8da9svwlGo3t2wb8AOWuTYctegUpr5Mz8
 R59bdCYmMFZ0W2iRkBXmaB+4ky8iX31NO4BZIICFiSy/q1TyX4luPwB8SgAl1zrmz8
 UzJ2qzMYGpzQfBoKxUnixBC16dW3ZzATphbxvpqxamWhJ+BS3aKMeaq1ETiBrQf0V4
 m2LuIbiqqYN+WsAlgPyjmKEA7nbBfyCKjZz6aYzZ27BW/XJfXLratcif9qcykArvkf
 9+lwq8Lv5CGNju7NofLT6lWRfFNK5NGj01T8ozxtNh37/L62Xdi68TErycGpDAjCc/
 Z29cLjZBDSHjAj7QI0qgtd8xw6b6qgCluZfzXV3vgR48O4LiLDcBwzY0wz4p++phGW
 OkJA2NNdGPSqcDvjwGUAHOczcp3rEsgm2XfSFNI1lsLOxzXcobhk2QxDC8Jony39b3
 4HZ6gIaC4jr5b3JqYxsm6c2T+4dvSy8ME4j3MMK54qe9h797P58eB75vJCLydRfNOf
 zUcXz97I+ARxpr302r+1CZ/0=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
 by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 4QgLEVghjqV7; Sat, 28 Feb 2026 00:46:07 +0000 (UTC)
Received: from xtex1.localnet (unknown [142.248.151.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.envs.net (Postfix) with ESMTPSA;
 Sat, 28 Feb 2026 00:46:07 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
To: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 2/4] bsd-user: Deal with mmap where start > reserved_va
Date: Sat, 28 Feb 2026 08:46:03 +0800
Message-ID: <6039873.DvuYhMxLoT@xtex1>
In-Reply-To: <CANCZdfpKfuP-yxAh42HEi_7ft6kPD_2HR0q28kj6VHNSu5hfWg@mail.gmail.com>
References: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
 <20260228-abyss-mmap-relocation-v1-2-c8ec0476894b@astrafall.org>
 <CANCZdfpKfuP-yxAh42HEi_7ft6kPD_2HR0q28kj6VHNSu5hfWg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=157.180.15.194; envelope-from=xtex@envs.net;
 helo=mail.envs.net
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Saturday, February 28, 2026 7:49:39=E2=80=AFAM China Standard Time Warne=
r Losh=20
wrote:
> Reviewed-by: Warner Losh <imp@bsdimp.com>

Thank you!

> Have you run FreeBSD binaries with this?

No I didn't. I only ran {i386,riscv32,mips}-linux-user, failed to compile=20
tests/tcg/multiarch/test-mmap.c for i386 freebsd, compiler saying mremap is=
=20
undeclared.

=2D-=20
xtex (Bingwu Zhang) @ Sat, 28 Feb 2026 00:41:49 +0000




