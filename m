Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8879BF513F8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMe4-00064x-ET; Thu, 05 Mar 2026 23:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMe2-000648-WD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:35 -0500
Received: from p-west2-cluster5-host6-snip4-4.eps.apple.com ([57.103.71.57]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMe1-0002Xv-Jw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:34 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 7673C180014D; Fri,  6 Mar 2026 04:18:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772770712; x=1775362712;
 bh=VoOG9FA1z7urYd/qf6zJ9sya7yqTjb4T4jKJo4KiCrs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=OC0GkKgcJiy90Dv9uOlHvQmeGAZpXBYnN1cyIaEvL6i2U1f5tP4Ce715n+uouI7h6xBNr65wRBFP39D7j3uYH4hU2iSFAuHfjLRO9jA3hQvJd74ywBA8F5+uvzEmk5z52qoreh2jb6RW3ltNjXzMvrWG7jHYOYrs99FaATM1VedpVWYTNlBrQjNdT7pd4/H6Bxx/M15ywAiGYTtDnSuYKrjRlJoqFGAyQfMAHKXqRHciUH+ut/BSmKyCoQ3kbFvnHGIAWN7tZHNSk+fQ4yKb6tLIxNjoitdUyBfgQkTixJC7asOmBlpe2NjdhNjkFbpd6nA4hU0+HJXWdbMs2Jg50w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 195511800558; Fri,  6 Mar 2026 04:18:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v12 15/15] hvf: enable nested virtualisation support
Date: Fri,  6 Mar 2026 05:17:46 +0100
Message-ID: <20260306041747.54554-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306041747.54554-1-mohamed@unpredictable.fr>
References: <20260306041747.54554-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Uo5u9uwB c=1 sm=1 tr=0 ts=69aa5597
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=5Chse3eIq3h0lgOaJ4gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzOCBTYWx0ZWRfX3+90UqfQz4/b
 uEuNnmaa8CQrQea46zRskZ76lIdyUKxJFkmwrOgTycErIQ8cckDYVrTRlGYxZphqqdEskkwlcCp
 M4lExFr1EhH9FWrCu0y2uq6y5M3yH9Mvr4/5e1mnbpmCCtN6MgVX9YG6Mfokxxdj7dKnzXSs8tO
 yplM/Yay+WO5mJ6UMZylteQUdfJ8kNAJch1qupMRvh+pqPdQdDYz/ToarPXymxbjT9X2Oaz7zMK
 ChNgRgPHPA6/9Rcu4pdwLW6gG/7djerdoOdyvNkEIUZGO0uU+vil2J+vSwfWBOw6jo2aJL8HQTQ
 bozVnAWVQbir1QQBJlXlYDilMvYG+sOpy7KXtbK0ZyGF1xZJ44NHPGcRo84bj8=
X-Proofpoint-ORIG-GUID: xxfgDUWuq2Y2B_1skQ-WhymsuIXnlWUP
X-Proofpoint-GUID: xxfgDUWuq2Y2B_1skQ-WhymsuIXnlWUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0 clxscore=1030 lowpriorityscore=0 spamscore=0
 malwarescore=0 mlxlogscore=995 bulkscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060038
X-JNJ: AAAAAAAB2+S56/sAFfber+b7EM/hFQNYbksutWu7r6oqwI5k2SSGmLQjfFU29Qxk0ivaJRnGezjdQAQwsQaofhrpuVBvTfIEnm8hAji4qO7WVPViNJWtAlQmt7DPpiktvE9Nxp+g2bMaELAQ/PYxRICBJRkIIziUhf64+qwoT3z9M5Z/fM5mji359vxQhfXzdkoezBvpcNYL9nEo00EzlzFC/YpAR2OgBqL70V7JZY6Qn2poDE9il864LX+O4HTICE6UdyoVnkfka/dwKhscZxeKNIAeVu3XoEYk/LnUz84JgE8gA9fU03KeHhVJ8ze9c7hk5RkCtR5uUa904o8RvMsSYD9q+3Veqqo0yvxe73+OOOSlrvRiOUcF8wmNzXbEdhNq+XSaEbI19SlORONunk6FkQiJANWOksoE0UljtbNodjFy3G9r6neyYLD45jmcgcMdMYbxKJIJg0zRJOwBAj2XBrCqODThdV4ePvGUgDnnW9MJ3Uqw/23PjAwV6kaqljDkly/raZjY0KCLyKMsJmZuYXHBu3ahKuD3fTqzVPuU6uC21tk9NV8U5qsG0D3Uwo1BPRz2nI+q2VP0586BCxbAK7HxzijOGEtfZ+zoZhq9zztl6s5y5zjM21BjYlCvzNSA2Ayw04vEJHCoCfICtFNZNXmFnTLbWEJaLXkPNY17injwogvStXZMXpn1LVJsJnsPaOZc1L38Jz5lFiTPGU0QzhP3c+bTWoa98ZjgZs3J4Ogqd2S1Kzs=
Received-SPF: pass client-ip=57.103.71.57;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3fa4f41821..731ada5d28 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2394,13 +2394,20 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !hvf_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
         exit(1);
     }
 
+    if (vms->virt && hvf_enabled() && !hvf_irqchip_in_kernel()) {
+        error_report("mach-virt: For HVF and Virtualization extensions "
+                     "only kernel-irqchip=on is currently supported");
+        exit(1);
+    }
+
     if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
-- 
2.50.1 (Apple Git-155)


