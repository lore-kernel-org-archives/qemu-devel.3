Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE44DEF5871
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGf-0005QB-T7; Sun, 15 Feb 2026 06:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGb-0005Mz-W7
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:22 -0500
Received: from p-west2-cluster1-host4-snip4-10.eps.apple.com ([57.103.68.83]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGZ-00081a-H9
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:21 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 24B0018002A9; Sun, 15 Feb 2026 11:26:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154778; x=1773746778;
 bh=/azSuFgxZtyPhovo63n8+YZWHs84+y+5HTGGEjQkROk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JIOZI0snpfzqoelgwqFp6+901ZBgpfuzFd5jKi1VLdr6fDmH11p/mUbHCNG9NL15G6KGIky5wKjssI+8t3Xk/DptiYsSwyH9sz37t44l/CZrhXf7Ra8atAfIAbjFudBu0s97/+NRQ92Ou+qfznKCtvHeGNH8LtUaCCtlelOFDGoJ8jfPc39xJjTqX1p5vLOg77jLAmMOQzwlCw6hHahITko0cIN9YCNs5SPRA8SiPgWxfBVkZwY+6QWH9KLSyxTuWlDvR5GOpo8YAaUofxQiO9FeCuy9UDRCCyt4w7c+HkUFZ7e0OPPTJDWA/+80BkE3JCUrR7fqRACAB//xADKWpw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 0802718002AA; Sun, 15 Feb 2026 11:26:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v10 13/14] hvf: enable nested virtualisation support
Date: Sun, 15 Feb 2026 12:25:42 +0100
Message-ID: <20260215112543.4817-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dQbyVxVvr3imzNBlgDXVRIw2qrGEBeMX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfX6Z5LB+R3M97F
 5OY2X2joIN4FL8XhZ3NSxmpnBdqiPk77A1RizbnicyfBpjE5ScEDEOz4A1Lw8bsBm/AeD0xL6XA
 NE9OkOeST3zi9208wFUbolG8WRPjLy7+TJ+6korB05SVuNZ6M2V/IqWwEH+QEhfP1Qe9DmQtfVd
 Y6LfHZW/cagOJDukpmfBZEPw25qRgBXjsYqA6rRP+U46oSq9D8nfl5Jpfnad5w/FVkcCEeeqbpg
 8oYyrgEVxgYUs35pFARvYC3H4onuDLcrTdXoIWp6SbS15kTvUxHcQHcEh2SorrsHtTObfpTigZ8
 rTF/z4QB1pd36M9A57gprMnWl0RrKZpEtvAjeH1AsMUlJm0BiBf6sWJoiuW28g=
X-Proofpoint-ORIG-GUID: dQbyVxVvr3imzNBlgDXVRIw2qrGEBeMX
X-Authority-Info-Out: v=2.4 cv=JLY2csKb c=1 sm=1 tr=0 ts=6991ad5a
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=cdDYXil7g4BivNFjHqQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=934
 mlxscore=0 phishscore=0 clxscore=1030 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150092
X-JNJ: AAAAAAABLlWq4IZ1m3J+MEv7Dcj8c9b99UmeguNnttm68WFAqjXUu3fBewXewKFXGreXI2lMs5BY5LIw4D+W1eBiWboKgwZP2uJ+yENB2257pGYIn7JrczPMwnl+GLohAUaodeaXw4f++Ljc5shH0Tr6pKEsJgj49GDrR/Z10BEmyUynYb+g7/9j9IqSOwhtc8Ha/LUhocSVOeAOR3D1JibLwHQgDvlasMNm16giZzvWC3v7YjvIad3zxCclHPBWnQlzhEF/poQCg5A32pM+3b/BqYeoPY2SxifF9xW3eN2jBt7/QavzZT7Gs+AHsKoBW8wQWn7X6o7/iyEllGPVSyq0QVzuTMILNU2bFZ49m9gwU7oUpmnxP/zs3O5LRSa78bh3IMrW7mM04rHH9Dj+/P7p2u9y+Z68UJP38SYqehhtIBE30hCRucnipWOhiCotQpU2FKV3KQ07irDgfipObC1/I/AuFikLUyP4MDQYhvLWi7iYEhYjPiw2TVuwIiTr22tKdmwrFA4lLZbqVotD3WyP3Weewnh4p2mDysThsWEmkMa5QmfhgiAmaaJG29gb/l3F8uNrGNI8v8QY5dSS27QezYrCt9dLjAok2XjtXcyDVdFK+1YPyrROVSH/aYrRJ2Uu3ICZx89rQVAq6peP12PPzIUEfjqnxhWu6YGwOqm20YT7QNMwkObHWlxaQzLUo8VZwSBW30sJ6RFUEg0R
Received-SPF: pass client-ip=57.103.68.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/arm/virt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 071b082786..a7cb6237f7 100644
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


