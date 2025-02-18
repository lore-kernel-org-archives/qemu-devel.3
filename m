Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CE3C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 20:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkTud-0006EQ-0K; Tue, 18 Feb 2025 15:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkTub-0006Ce-6R
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:09:45 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkTuZ-0002NN-3f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739909376; bh=b8O/9LNZnwiHfCC4oEqC0GG4kJY5GHEVp1JOkMCwDeY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=r4EckUBDhRJfn/0oiZN5ATEigYUXWpG9UL0TFwewBrHQuNTp10n+dXu3LtRK2n9Q6
 z52RBSNL7NVWmCMwuvyGlX8nMXZW5q+U9BbCuM4rvMieswbvKBgSQMB93RCSN1bKYJ
 Xy/fn2Hok4QyEk8cgcCbb6WDFOSdMuxGMwvDocRlLgQic1SqORsgJ4iTYdIkFBQIxy
 MaUVfq39CdBX71u0GqFk3eUdqpYVsFW2YzDEtpRtav4IBWHIVSQpWy5SH8b6c0Uv/o
 nhPYj4wuqe8KwWSsXPKWzvCKZplHmp2ZUUdlvhESJeOSd7palDUjY034PLNRWL+b61
 eRrgcmDmnR2cA==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 8EDD03F20C61;
 Tue, 18 Feb 2025 12:09:36 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id 4z5zNqjt6o-Q; Tue, 18 Feb 2025 12:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739909375; bh=b8O/9LNZnwiHfCC4oEqC0GG4kJY5GHEVp1JOkMCwDeY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WvlDXZMclgkL9G9G6c4ZGEfr73pKTFgp9kWlCCJpc6Bf4YWn8qWlLaGx2mPOFJGTY
 RGbS78eoLye5I/mcZsuSEHwneT/+2LnThlH2eA+vGTSxhOadkQrSoNiAogl3dzF0jg
 LcQS5/ZLnJhxMdZmjnmImWXhGVRKj/rxGJNbXbkSWbFKfgPGtAXRi9SpuZvDAL8TEd
 TMKRaI2JxWG5vdNUKuajgdwhinmeYNpA5T+xd1yHfvojmpI1B007hCxyxS7KQeLLuw
 Qzc/t1mgFbQkFek9Dv6Y0CS1PmVqwE6qHcdRbN1XdlHpn6O0cnhtO+Y8BbVBeAFkNr
 Qkbys8XaFBwzQ==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 923BD3F22241;
 Tue, 18 Feb 2025 12:09:35 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id 62E011E60096; Tue, 18 Feb 2025 12:09:35 -0800 (PST)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] target/rx: Reset the CPU at qemu reset time
In-Reply-To: <CAFEAcA-Z13YZaHWfdp0xnW2tQL88OtxwF0nTdSoj2eJkULSbFw@mail.gmail.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-4-keithp@keithp.com>
 <CAFEAcA-Z13YZaHWfdp0xnW2tQL88OtxwF0nTdSoj2eJkULSbFw@mail.gmail.com>
Date: Tue, 18 Feb 2025 12:09:35 -0800
Message-ID: <87v7t7ypz4.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 09:53:58 +0000

> Reset of devices not plugged into buses (of which CPUs
> are the most common kind) is a mess. But having them
> call qemu_register_reset() themselves in their own
> realize method isn't the usual workaround. Instead we
> get the board code to do it (usually in the same function
> that handles arranging to sort out the in-QEMU boot
> loader, see eg hw/arm/boot.c).

Oh, thanks so much! I was confused about how to select the right
starting PC value -- when loading a kernel image, the code wanted to
set the PC to the kernel entry point, but otherwise it wanted to use the
reset vector. That "worked" because the kernel loading code set the PC
after the reset vector was loaded from ROM.

With your advice, I've made the hardware layer register the reset
handler which just calls cpu_reset and then sets the initial PC value,
either from the loaded kernel or using the reset vector contents. So
much cleaner and "obviously" doing what we want.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAme06P8ACgkQ2yIaaQAA
ABH+zA//TcUZR//Y24L7JBfOvoXeEpOVw3bMExkMbegM/JGC2CkYS0bcHUTvp2gX
LCE2GMfC1plkMGgLSTBVGM8EBPp3VzEidNfFA5MBJeKjLVyQJQrA23hePo9qWRER
3uwuubnWqcylKUnLERceknryd982k3O/SfxNXjbCGcIwx+us+eSfjZ4ZH652odm9
udZQrwr/Kgz9Vt5z3aVMp6TzkBPQCCkJTXBQ+LRnOrVl/fBcve1bJACBpc87ucNF
D/5YlgoXqJypAk+YSoeaN3V758CMl4E6db09FIhnoN/jqX3yWyK2zIGDg2whfDIK
TFd1C03slB4MW8dT60ftFITBwMVdcsY3l8AJBM38VH5RHS7JRRqA17dEYaxO5R/H
6Gmoy9AKRmUk1084SAgTcQ/eDfMLtIP/N/XGqpLsIVgh34j6bhOCAhyhUrf8/IV7
+XPMaAAODfIEOi9yZwoUSdBCfpmeneDP4aPTlQahPvHJs0Rxh/X/8JP+YXgYuu+N
dnV40Zx30rHq3Xw+ub0TUgzsOLhpYhGmzUJnlWuAyX627NPwQ4i1NqvuxYfmBz6Z
szk77zSciK0m7SyJlq3QnMqAtb4u5wt174GC69Wq7KsxGVu7qitQGSkPZbXUH65s
8CuMpgWp2iNIqJDMhmjD4msynfgs9W4FfdQY7L5VeUZUZBy7fwI=
=RCfP
-----END PGP SIGNATURE-----
--=-=-=--

