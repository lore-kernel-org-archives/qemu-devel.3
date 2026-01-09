Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9E1D1A63D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDmV-0006cA-7W; Fri, 09 Jan 2026 09:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr@darknavy.com>) id 1ve2Nf-000415-KB
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 21:37:41 -0500
Received: from smtpbguseast1.qq.com ([54.204.34.129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr@darknavy.com>) id 1ve2NZ-0007JH-EB
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 21:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=darknavy.com;
 s=litx2311; t=1767926236;
 bh=s9S370S8RXeJ1FD8f8SM/PQYUuYKGXkFVvnBpvOhwFc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=tgXLIROQo7OXOsELu1MWvuoLe+hmrrHDk50rZT0iQH+aZChHFiXL7yJHpnKPt/Nwk
 IOMM2yPeackiURxmDR+aeLG0sYjrdIPY5/ylq3urd9DnVCIoYqS+cdVMpS/EJt6WKp
 lG5V77ZJQ6LpbV4rsmzdLRp8/Llj99n3G7lK6TmQ=
X-QQ-mid: esmtpsz11t1767926234tec53d6d9
X-QQ-Originating-IP: G6DeiDrv49mAVVqqRafGQfBkME2meq9SGkuz09YNcN0=
Received: from localhost.localdomain ( [58.38.42.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Jan 2026 10:37:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7724640879889572711
EX-QQ-RecipientCnt: 3
From: Vulnerability Report <vr@darknavy.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>, Vulnerability Report <vr@darknavy.com>
Subject: [PATCH] hw/i386/kvm: fix PIRQ bounds check in xen_physdev_map_pirq()
Date: Fri,  9 Jan 2026 10:35:48 +0800
Message-ID: <13FE03BE60EA78D6+20260109023548.4047-1-vr@darknavy.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:darknavy.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: OVFGYuALQ4aSzCXJvmq8BrCGKSw5DrrGTbEAU2SqGsYPnEo0jHO2c1Cj
 GkNGpMObkXcQeLmW9dq8NKtdjj/1mmq7lsph9M4JgDkWF63VWYldJiEdfsAhf2MhAzeePfO
 zEZ/DMARDrKhqk2Ttx/lRRi8sOxDn4+m7zSb1PdOH84iqIFdhxFF2pur2vNOtthSSiQJ/eF
 IFNabHZ6BgmcRuF7fAzZJoInqfGxj6eR++wxcVy5NpB8qiZq5PEidhazCeM//gyODuFzvDD
 OoImwOVctb6HNOhkYiX8V3XxKT7JdoDKXBfU89eVR4lTX76tjOBiDEgCfNQrMA2wrQ9iLHp
 xppNvqGH2E+s3fD0IAFNXlfGi4hJ0I5NIqq2duSr6PztRpY0J1JB8zqVpVWhppxIhzQF7pt
 fJ5ZBlbLcQGstnV7Hq4j5IKUQ92/g25yTGEfVaY9eR8jNgaZxb9CvV7MwEjZD3XNHI/uHfO
 7Bq/5ylRPpKJOrRyflscrJOTKE5QRQUBoKg06CEPt6itSyufmM3rHgUoBwSygECYG8kuKcL
 1g4EdPH4OG+BPtN2Opjy3VRNwuNho3sz9j3788+eLThcFVMcretTLoj7H7ijOj0EUml6NbS
 hJpvU3xa7wCbIKfpHNSbqEw3HvyZUcnOTU+u4RPBsWG3foHNVGwaYS706Tj95k7AIdQkgbr
 /kBEtMna9WKv+Mi15tJF+5aj6KZTXMoMJC3qb7NxjXShRLoklD0zTmR7dd8OquktEolqAe1
 xVl2OuPo0WU7UFx1ElJZj5LfmVmjUF6FowZD/4eAt0K8ItYuDRPyhZ7SvmIGQlXdfvlFaAs
 MaTd6RKMDE8mGEBfyz1fkDhcUuElmDnPyDn2lXTRy5EnXRfYvydISmXS8Ry/D7XCfg5AdE9
 5yi9zSilxrgMGKZtGkIc8aYpfe01q/gF0XXt66NcAFmwNV+WiKrhen6duZA98ljslfwCHR2
 CHQKcS4gsyc+zJmUUj7fl+1BUXOMAfpqtTaFRAYq5Y52kMcH+jVzPDflmwN/rLzahe+wuff
 rC1JNgAQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.204.34.129; envelope-from=vr@darknavy.com;
 helo=smtpbguseast1.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 Jan 2026 09:48:00 -0500
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

Reject pirq == s->nr_pirqs in xen_physdev_map_pirq().

Fixes: aa98ee38a5 ("hw/xen: Implement emulated PIRQ hypercall support")
Fixes: CVE-2026-0665
Reported-by: DARKNAVY (@DarkNavyOrg) <vr@darknavy.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Vulnerability Report <vr@darknavy.com>
---
 hw/i386/kvm/xen_evtchn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index dd566c4967..173e0818c7 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1877,7 +1877,7 @@ int xen_physdev_map_pirq(struct physdev_map_pirq *map)
             return pirq;
         }
         map->pirq = pirq;
-    } else if (pirq > s->nr_pirqs) {
+    } else if (pirq >= s->nr_pirqs) {
         return -EINVAL;
     } else {
         /*
-- 
2.39.5 (Apple Git-154)


