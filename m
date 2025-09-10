Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1007CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 06:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwEaF-0002ei-NI; Wed, 10 Sep 2025 02:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.marud@post.pl>) id 1uwEaB-0002eE-Ug
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 02:45:32 -0400
Received: from mx.post.pl ([89.161.254.211])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.marud@post.pl>) id 1uwEa3-0002Ar-KQ
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 02:45:31 -0400
Received: from smtpclient.apple (oz91-226-196-71.netfala.pl [91.226.196.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.post.pl (Postfix) with ESMTPSA id E2D9764F30;
 Wed, 10 Sep 2025 08:45:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=post.pl; s=dkim;
 t=1757486715; bh=hCW2azXfbE0/56ZgIeWSKxNaa27k8Snr2cPBiaBau1k=;
 h=From:Date:Subject;
 b=igjeEtRmg9fcvsttjqKKPQU7KnUe/PdUQ6QNywWOq4nZa/sRTgUPXEZJJUw1/UCH5
 VG3NXE7KqK/8eRfWcu03hAYwkE+2hiHZICaw5gEqqFX4WoLbY4bjSG3S7PA+pFZkqn
 Bp97LECT7yHFVqHohJ3EPnr5hEnZwE89eKUmPVnk=
From: Arkadiusz Marud <a.marud@post.pl>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Date: Wed, 10 Sep 2025 08:45:04 +0200
Subject: Question: ThreadSanitizer support in QEMU user-mode
Message-Id: <CB3C08B0-0B52-4C27-89CF-8621B2A9E0E3@post.pl>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3826.700.81)
X-CLIENT-IP: 91.226.196.71
X-CLIENT-HOSTNAME: oz91-226-196-71.netfala.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTEoWsKTfC1BQPcsOFWou2DRb5HRsXFqxVdX4LPs6dMR/1m4PRQWTDPRDvh/K01yZQMlM+j+oHNcQ9b9wlaKWw2YgOjnlvDXPoFo6LBEgKH53rB02cRSVxdCtZBW+g0XuIHBzFOcyyw3g/j1nTnBy3hQ8BXrpCC6oKPtSeTPUzqBG4gU0i2QnGiLkdbcS2PcSNsIE00dgDFdDKFsB6tbrVs318iIx6G5IJILEVF30q9jznFu5znvAHn+6RO6QA2Kbs4pX9z23UBI8FjU6crXKy+LhaLtq4V4V1ZSQP0sm2BnZ3QTY4iKwbjTG1wjdEbUwjxfLSDUM9ySa+HYqKfkih3kQ4JltQsPqP+XUQbBt+pajE1j+erdS5kftUDRoTP4Pc59dmg2OMMmnM8u5Riq7n55s8JqZf8jQ5ZL4NNSqPyu+7vC/Taj5iEo6C1mb5DnaDdtzR0RB4yZ2GA47pKBE0FrWNvmhgHcpPFi7Qo1TjHDkADPO6E8sxNuDqwp8VLCAqQlf6fZt7tHqTt4AuJj8zOj0bQ9MzsTLogYCKlzLTu9A3kqTlzxy/uOExsAgSaL5NsY/5Q1NsDsEerh4zGED1DBpxvbouFmRCKa63KemgSx0pnWIB/mTYYP10NV6Ih5MozVACOWhDk+PGH1AhCqr+vl3lL/5EbwJM5XQsTPavAYhw
X-DCC--Metrics: mail02.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
Received-SPF: pass client-ip=89.161.254.211; envelope-from=a.marud@post.pl;
 helo=mx.post.pl
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi all,=20

I am experimenting with running a C++ project built with ThreadSanitizer =
(TSAN) under QEMU.
The documentation describes TSAN usage in system-mode =
(qemu-system-x86_64) with --enable-tsan,
but I couldn=E2=80=99t find any reference to support in user-mode =
(qemu-x86_64). =20

Does QEMU user-mode support running TSAN-instrumented binaries, or is =
TSAN available only in system-mode builds? =20

Thanks in advance for clarification, =20
Arek=

