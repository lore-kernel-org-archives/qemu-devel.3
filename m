Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C6BC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5ii-0001OM-I9; Thu, 25 Jan 2024 14:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rT5ig-0001O7-Qh
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:49:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rT5if-0007zP-3H
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:49:02 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PIXLT8031180; Thu, 25 Jan 2024 19:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=/zu/uyHOmFrlegl1nKNibMZWhpJfFiMDcsFmsUc3Mzc=;
 b=dYGpm0UHTSSjnAYC9hq+H96Efe/SE9AkgHmf/ryLFNPwrvbciGHQkIkaR30d3YbjqwIg
 sj0iFG9ouvlrfwy/eL0TpJ0wi36TcICSblAEznuWeKur85NoYFeIe1JYkxfM2xdnQUFT
 FI9TwsY9k1wyq+ZbP+9GKxhEVAgLpAt714mQA9Kn3SlBe3id/63LP7rxCF6KYWPBQs+V
 uKFp6JFnRc1fHWiYS7dW9/fX5PP7wZyh+u7dOSyUM8kyBe8cLH/VdToeKmH18HKJeUDe
 0XavEyMbmnXsDyvWhVxmXEdIqalXauu0YJurkYvXh8W1Q2dVquhc3wzGqFJRuQhyEQoe TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuu1bvwwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 19:48:54 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PJlrUB003072;
 Thu, 25 Jan 2024 19:48:54 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuu1bvww3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 19:48:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PHOrTa026876; Thu, 25 Jan 2024 19:48:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgtpm1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 19:48:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40PJmpnV40894726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jan 2024 19:48:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E6C420043;
 Thu, 25 Jan 2024 19:48:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75F2620040;
 Thu, 25 Jan 2024 19:48:50 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.21.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jan 2024 19:48:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/3] meson: Disable CONFIG_NOTIFY1 on FreeBSD
Date: Thu, 25 Jan 2024 20:48:18 +0100
Message-ID: <20240125194840.1564-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125194840.1564-1-iii@linux.ibm.com>
References: <20240125194840.1564-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1eVK760VVG0YBbJ0o6nogRaPcNiLLUaw
X-Proofpoint-GUID: YFQaQUA-wygha12mCZAtObvBRJ0V5y5A
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_12,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250143
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

make vm-build-freebsd fails with:

    ld: error: undefined symbol: inotify_init1
    >>> referenced by filemonitor-inotify.c:183 (../src/util/filemonitor-inotify.c:183)
    >>>               util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive libqemuutil.a

On FreeBSD inotify functions are defined in libinotify.so, so it might
be tempting to add it to the dependencies. Doing so, however, reveals
that this library handles rename events differently from Linux:

    $ FILEMONITOR_DEBUG=1 build/tests/unit/test-util-filemonitor
    Rename /tmp/test-util-filemonitor-K13LI2/fish/one.txt -> /tmp/test-util-filemonitor-K13LI2/two.txt
    Event id=200000000 event=2 file=one.txt
    Queue event id 200000000 event 2 file one.txt
    Queue event id 100000000 event 2 file two.txt
    Queue event id 100000002 event 2 file two.txt
    Queue event id 100000000 event 0 file two.txt
    Queue event id 100000002 event 0 file two.txt
    Event id=100000000 event=0 file=two.txt
    Expected event 0 but got 2

FreeBSD itself disables this functionality in the respective port [1].
So do it upstream too.

[1] https://cgit.freebsd.org/ports/tree/emulators/qemu-devel/files/patch-util_meson.build?id=984366c18f1bc54e38751afc29be08c596b83696

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index d0329966f1b..3d67d78b522 100644
--- a/meson.build
+++ b/meson.build
@@ -2403,6 +2403,7 @@ config_host_data.set('CONFIG_GETRANDOM',
 config_host_data.set('CONFIG_INOTIFY',
                      cc.has_header_symbol('sys/inotify.h', 'inotify_init'))
 config_host_data.set('CONFIG_INOTIFY1',
+                     host_os != 'freebsd' and
                      cc.has_header_symbol('sys/inotify.h', 'inotify_init1'))
 config_host_data.set('CONFIG_PRCTL_PR_SET_TIMERSLACK',
                      cc.has_header_symbol('sys/prctl.h', 'PR_SET_TIMERSLACK'))
-- 
2.43.0


