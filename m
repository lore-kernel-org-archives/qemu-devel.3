Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1C4C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 10:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxjD7-0006hh-2r; Sat, 22 Aug 2026 06:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wxjD5-0006hJ-36; Sat, 22 Aug 2026 06:44:23 -0400
Received: from nx185.node02.secure-mailgate.com ([192.162.87.185])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wxjD3-0006Nf-9U; Sat, 22 Aug 2026 06:44:22 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wxjCy-002stk-Ag; Sat, 22 Aug 2026 12:44:17 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787395456;
 bh=z2mRyBF3UQ/7ESwZSn/kr566tDe6K4JlmnRYK6D1bY8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VSRpuS2pci5IxqP/uNIEFAdtjHEVEz91yKSjjbUsECq77V9JF8AaBcfBIP8sDI7AF
 EYakzoOZD1HRqgcSztBqd8N6jMBGRF2vTpTItNFdYUxfCaGJjR/id2xLAtbUCujrMU
 rYPSqE9JClz2RyQ92iXsp/pnW5T5Sj5+JVOxzdts=
Received: from Zeuss.fritz.box (p549f1e64.dip0.t-ipconnect.de [84.159.30.100])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 6ECE8281D8D;
 Sat, 22 Aug 2026 12:44:15 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, kwolf@redhat.com,
 Christian Quante <christian@quante.one>
Subject: [PATCH 2/3] tests/qtest/fdc-test: skip test cases when the 'pc'
 machine is missing
Date: Sat, 22 Aug 2026 12:43:28 +0200
Message-ID: <20260822104329.42121-3-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260822104329.42121-1-christian@quante.one>
References: <20260822104329.42121-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178739545612.2525797.6959177451074578283@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVwd5NJH8+8Wo0Ms5RclUSO5j5rLpdN/iLB
 45cL/oYogCu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4ZMN4DcGJm62MyLKuJ/2zEyS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99ROIQSXp0prcVkrsJtqLDcOMdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEG9vh2CZ3C
 vkagHub+zVCHrxrAiQ9LrFKjKskiGXdOYifNjAo/oI1KsSlinhiZwSTM7upkSXAQr6kxkmkxKd7E
 gmVz1j4MRe+OdlYkVJrlZi4DrT70dovxC24/X+dx3iVqmCy1HzZEftAXffblb7BEVSsx11W4Bku8
 Nj/Jz1tydce5Z/R2EzvIB0T7JlyqARh7gD7AfsXew/h928fQEfP3Kfs3HYoxZ2A8CL74A8BpRjYl
 hQTOv2jJ/maiR5x2CLV1yrn7Tl2/eGlT3vtT5Q2OCSL3g9ZGqqDl/bOPQLPC3/Z0OGzipjuCk6M8
 f274+Da2Hd4FX9oFmG2ssImpaOB9XT7WPa4F3kdskAP3L0dYRrkBIkUL/j1Y48GvmeURQjjEvx/4
 sa8yVmJ5dSGjbwA/dTyOzZbKfVh1v52vI8Y0fFWsl7iHPgL/S2wS+InL5HameBz88ZlqhzmH6uft
 7+t7T3Ji2DeftKOAvi5/VpKfmaaulMf2xZVX1PF0jIKhEOFrbAyeTqRmo8yvsuqp7tk0ZhXEXqw0
 RKuCqvK44RrggSj3Y80OmAux3oN13+ztUzneoLdgui30GBX/jlb5Bz/vlhgZBdfUYxN1da9xu08A
 VGS8eja5zvrtH3VdRWNadC6kk6F/+BWn9gVDEmhUbvIlEHSFE+BGkBaqg7rMm0ncWoEA78u/BXBt
 xWlNUZZl2CeM9R/2gMGq0KWAzmMf+ibVDjtW4oFmrPO6qPB0S9LHBAFRJpw+dgtb/qY19tnlsdBT
 RUqLoSOUfHTfiAsjKPjs7BqXSHvjdU6ko1j7gyOKOKHJ58WhluI91Ik/GOwz9gprGRUHDfs4TpM6
 tty9Xg7woShbkJHRneTq/3E3yiGCIw8=
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.185; envelope-from=christian@quante.one;
 helo=nx185.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

run_isolated() starts every test case in fdc_tests[] with "-machine pc".
A QEMU built without the i440fx/pc machine fails them with "unsupported
machine type 'pc'" rather than skipping them.

Check for the machine in run_isolated() and skip there.  The previous
patch routed every table entry through that one function, so one check
covers all of them; 4e37f749dd ("tests/qtest/drive_del-test: skip pc
tests when 'pc' machine is unavailable") needed the same three lines
four times over.

The two CVE test cases are left alone.  They start QEMU without
-machine and so ask for the default machine, which is a separate
question from the one this patch answers.

Signed-off-by: Christian Quante <christian@quante.one>
---
 tests/qtest/fdc-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index fd38475bf7..f480f4ba09 100644
--- a/tests/qtest/fdc-test.c
+++ b/tests/qtest/fdc-test.c
@@ -690,6 +690,11 @@ static void run_isolated(const void *data)
 {
     const FDCTest *test = data;
 
+    if (!qtest_has_machine("pc")) {
+        g_test_skip("Machine 'pc' is not available");
+        return;
+    }
+
     qtest_start("-machine pc -device floppy,id=floppy0");
     qtest_irq_intercept_in(global_qtest, "ioapic");
 
-- 
2.53.0


