Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F74CCD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnIV-0003t4-Hh; Wed, 04 Sep 2024 06:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1slnIT-0003sR-QP
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:31:33 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1slnIR-0002Ch-Sj
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:31:33 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1slmzS-0001Jx-2h for qemu-devel@nongnu.org;
 Wed, 04 Sep 2024 12:11:55 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1slmzT-000B56-1x for qemu-devel@nongnu.org;
 Wed, 04 Sep 2024 12:11:54 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 735234800A3
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2024 12:11:54 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id pxS_DPTZL5yF for <qemu-devel@nongnu.org>;
 Wed,  4 Sep 2024 12:11:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 228FD48017F
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2024 12:11:54 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id X6HBgPiXxMeW for <qemu-devel@nongnu.org>;
 Wed,  4 Sep 2024 12:11:53 +0200 (CEST)
Received: from zimbra.eb.localhost (zimbra.eb.localhost [192.168.96.204])
 by mail.embedded-brains.de (Postfix) with ESMTP id EDFDA4800A3
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2024 12:11:53 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:11:53 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <1832886563.20496.1725444713946.JavaMail.zimbra@embedded-brains.de>
Subject: Are floating-point exceptions usable on AArch64?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.96.204]
X-Mailer: Zimbra 9.0.0_GA_4615 (ZimbraWebClient - FF128 (Linux)/9.0.0_GA_4615)
Thread-Index: 9coovJvrd0AO0HcKDIyxuH2twUXlpA==
Thread-Topic: Are floating-point exceptions usable on AArch64?
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.5/27388/Wed Sep  4 10:40:46 2024)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

I tried to provoke a division-by-zero exception on AArch64 using:

    uint64_t value;
    __asm__ volatile (
      "mrs %0, FPCR\n"
      "orr %0, %0, 0x200\n"
      "msr FPCR, %0" :  "=3D&r" ( value ) : : "memory"
    );
    volatile double x =3D 0x0;
    volatile double y =3D 0x0;
    x /=3D y;

When I look with the debugger at $fpcr it still says 0x0 after the msr. Are=
 floating-point exceptions usable on AArch64 in general?

--=20
embedded brains GmbH & Co. KG
Herr Sebastian HUBER
Dornierstr. 4
82178 Puchheim
Germany
email: sebastian.huber@embedded-brains.de
phone: +49-89-18 94 741 - 16
fax:   +49-89-18 94 741 - 08

Registergericht: Amtsgericht M=C3=BCnchen
Registernummer: HRB 157899
Vertretungsberechtigte Gesch=C3=A4ftsf=C3=BChrer: Peter Rasmussen, Thomas D=
=C3=B6rfler
Unsere Datenschutzerkl=C3=A4rung finden Sie hier:
https://embedded-brains.de/datenschutzerklaerung/

