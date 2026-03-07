Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B72BFC9EDE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 09:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyncZ-00073D-GF; Sat, 07 Mar 2026 04:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncR-0006ow-FE
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:43 -0500
Received: from qs-2001d-snip4-1.eps.apple.com ([57.103.87.34]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncM-00016n-UE
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:42 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 502EA180013C; Sat,  7 Mar 2026 09:06:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772874394; x=1775466394;
 bh=ijV/TFHDkMx/sDtjnbI4Tcf5/3qsWHHZ7tvtB+wJk+k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=GEo8ndkg3WVssGC5Jo7tbBctYgWZjOJ3Vz2hyUEAV1EeXXkiJUQ1TDOxzw9dz8ndSs5BEmjtR7IaMfPbopzOefXL5KYNnwKIwrXVmCKbGqGeWd5nsOOzZnDEYjfKtiJgi8XWDDSdjOC4xszxU1Ta58+FayiNjz4bUJT7V3OKZIQyp/qm37eEtVcBnIseVAmce9olirwFFwBwLH6CRLmvE7zzeFQjIBa+DXprJ8F2IEiW19FpXqDUrpVukbaFRc0neUdrb87Bkp1h74OvA+D2Jjxx7tAYY+PYRgtgjghg682/+A5Rdv/FIOAJ+vIqmiQN9c45rA7g//GCTH3BNHVpfw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 574181800402; Sat,  7 Mar 2026 09:06:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v17 13/14] hvf: enable nested virtualisation support
Date: Sat,  7 Mar 2026 10:06:05 +0100
Message-ID: <20260307090606.95300-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307090606.95300-1-mohamed@unpredictable.fr>
References: <20260307090606.95300-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UYmpPHKUVrPIofjuwGuC0lEmC9VpQxJU
X-Proofpoint-GUID: UYmpPHKUVrPIofjuwGuC0lEmC9VpQxJU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA4MyBTYWx0ZWRfX8eYPu7YVmCdB
 1QWXGRZ1/NR8Di4rrMvQS9O+pLQdg/ztIPeowVoLbthwzX4gsbJkgJWLGPeD4RxIVRq4NKPIcMN
 glIgmf1bMBcQNppQfB9WIaEjQTDGHCXe6v6TF3fgvGuTkMOkU8I6OOA46JUA524HxJ6gwU534Lh
 7GkGBAIQCmfR/dzSsU7354ASLyr13kE2kp0jzXsC/IhoWjeDLq3mKtWsZKxU7aDOaA/fE/C/0nP
 JYJf2FWMZdmTzQ9yXhWqJWUUM6nMsbyVBIQmVLB7HUMTSHydTuwa3DQqTtxy2I7OguFwyImAJjx
 +OEHQp1V9aEbGZ9zaQkr+e/8VKHbZaQbOl+4y0pMuqWKd8oD4CwugwsqzUqmpM=
X-Authority-Info-Out: v=2.4 cv=DMeCIiNb c=1 sm=1 tr=0 ts=69abea98
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=5Chse3eIq3h0lgOaJ4gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=981 phishscore=0 bulkscore=0 clxscore=1030
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603070083
X-JNJ: AAAAAAABFeFRUEZYCpEE9TpLA/6SKuqfY7XyVHX/PMbtCzpxCpPY46ctIFWm0AK1iNucOu08EJLATTQLejY1R8VGzG4/Z5HbgjVxRuCtV/1K+6YevyTUG0uoWqkQyCkXg3Q7PxA4AKyXTsm8sboiDOGT0Z2IjHz+7yTXa+KeJqln/95NGy9ZYqepSvf8r5QYYYstKfZQsWFhFFuEzlv3o3Cl+zCzrnGnzRouGFw1YUJ9qMemK2WOI1iRPmI7ltCaUx54G/BNodrgLmGDLVUfgWLgqwbDynmxcKwjtR3NFSHJB0lMXd90PeHXPIHcODS4XqQG6WeNXu2Yy56eXOFFLv/krbbkaZcqXZFSAm0QzJjNsnYE4fLMO5gtCGvNY5y4EC9HyK59zVfrCNQmgHy1nEvl+WpgItvDAhsUzl1boxDZVJGvL9jg63FANfw0MJE8pBi9DzNyPwEbst39ajNi7LYmkDAzf1FUm2l6DrgFgkj0V2yZ+tb5r5304vqVdBrgmgvve8eIvDizmxhsyi0dgLA1OFSa66h3x0q2qNhsLQxZvz9H3yyAxJZi50EL57DaPFHxUNFnRHXC6ZCOV8m1x5aTLds4WpZRrNo1GHQwm3blv6YmKDB0ETNErmttQFSigXxnTppB5sktzo7xakQToHlkzR0RrT9Pdd2doRw3q/kse7ga74OCqj5i9Nya+jwIHMhRQQT1lsxAFBwRVuWfvbwJin+3rT5SNKE0pH1+JWjr0sQMZRIz6z+kVLE=
Received-SPF: pass client-ip=57.103.87.34;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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
index 90769936d0..bced9f67f4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2393,13 +2393,20 @@ static void machvirt_init(MachineState *machine)
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


