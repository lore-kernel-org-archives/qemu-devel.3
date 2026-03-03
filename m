Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82306EDEBF0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWio-0000wL-Kz; Tue, 03 Mar 2026 15:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWif-0008Nn-4L
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:53 -0500
Received: from p-east2-cluster3-host3-snip4-10.eps.apple.com ([57.103.77.161]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWid-0001Wk-JO
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:52 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 44C781800145; Tue,  3 Mar 2026 20:51:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571110; x=1775163110;
 bh=3JX8beg0C2Np1egU4bEnkRFyLgIrgwrt1tvpx/K3/Vk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JGMWq1PNUtMY///gmSNqu/0NzeUr88R+vrUSDQjZcOHy3CUZRbQsvorhFPeJTkPv5txUo/aI1NtWV58E0ZGD4pLX9N3iZWPUcIOlGIGGHquecbFjKHVgzmeT5Nw1xe1JLFIxaVSUF2I32g0Omjp1q9qC+V4y9+6RXHOUHPj7A9cxx62DLJm2O7ZcjrEMuOex9N/dPL71ofXiuQxovRdIf/T0RzqvAuMkN+GE5E5DJ0hMBp8Wh1CjKJg3KsjIf7hbhu+KFPWFu0yNLF8IxyyMutr647N2nAuFx+neP4sBHcILmMPsDAgk53mD+mEqSFVkcxN90ojgEP3DzWKH76bu2w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 7CB7E180067D; Tue,  3 Mar 2026 20:51:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v4 4/7] whpx: i386: enable some more enlightenments
Date: Tue,  3 Mar 2026 21:51:35 +0100
Message-ID: <20260303205138.32450-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303205138.32450-1-mohamed@unpredictable.fr>
References: <20260303205138.32450-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Qlz8N8iC5rKWOI3_PXFhXhIIFhvtyi7i
X-Authority-Info-Out: v=2.4 cv=G70R0tk5 c=1 sm=1 tr=0 ts=69a749e6
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lWQTlSF5RC17BzGQrLAA:9
X-Proofpoint-ORIG-GUID: Qlz8N8iC5rKWOI3_PXFhXhIIFhvtyi7i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfX5/rl+jpO54Jx
 71ZIo5ds863r0wxxW6j6F3Quej1qym2vbX22fl9yYMRbWgTGEd2z/zJMZviJy3XcvGp/SKpSA6q
 HPyzUlPL71oT2TfhzKEK61XlD0Fa/XX3wcBq2MoUeyX+uS0+wiI8o9E5SIolFBMFc2cKnpmYTGn
 4D5+KHYt7my0u+8Vl7YqbpnpD/SHgOsCHkPg3dmBUhC3S003extXYmXqbKenEEyLiWEE2sXYZSf
 pIvy6CGlVfa7XtoVrj209dyT1KOxSKUoQ+q2D6s8k4oSFfAV56uTD9OfNVEiP4vGkr1lFNSgom2
 9p/iO4fbWMZ4xOPk4EOkRxcry2+VzKMNT169kZesOCUCcap7myI71/ip32OSGY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=875 clxscore=1030 adultscore=0
 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABaWGhRZcNSStfLgU2Ga0SV5fSMr807oYa0bAw011QgiYP+09DU+YjIIDnFjGGIiw5JIRZJbRTsKVfTkQ+M/ruDKKawLIOy9KyKkbFclktEQ/kXE2Na5Pic5BVv7Hz2S61TPH28x9inpUkkPWESaFkCK2UNwh8gvgnklHKqIJ1SnYLPrKjUbdQIDsWiViwMXkJH8hUZFQCQ+SbNCwkrYiag+LnQw2Ftcbetyfc7QOYXq7TQhy9EV6W49rg7vZkceCPIeEznGM5VOC5Ik5xtEU8B/DfU8I8xGN1B5blxKnGwInAs3vREjVOK56kiqko2350P3/pqbwFdKUvmdYYKzSuCDyvQ6z1mvQ5tT7ogsE1ggl+ZQjFyQWS0PxQWuOtUa/uFhjmWAX7Ggx3HphyJnI6QWO2GUQ0uAIX0WJM4adsxLvRdQyAt4i19YeIenkgG7POq3b+9COBUTG/UCaU+j9ZdKAugzEIQaE7sD6a10CH8tIw0+cttjZCmlB5bf5WeAjreMenWbc1fjA8EbG2rjMZVgTxGwvF7qVYGcqqOVvVzowbk0+AbJ5mtjSd5ndhtRYrjsHIqRYQYX1Zm3ajtV6o4BwN0TE6VPZHSyJnQlw8XcRlEnw/95FG9IjQqeT17K0Ft8E1l6xFbY8Hjx57nvBNyOsU6El5rVwYLuhtxAQpaHwpgclnPfKsMF2VFn/znwgE6Wjdwsm/rqDE313gmrvJch/6WNDTMP8Z5OMWWrB8ZxSiICOWoSZTEg==
Received-SPF: pass client-ip=57.103.77.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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
---
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4afcbbae25..915d79152e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2201,9 +2201,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     synthetic_features.Bank0.HypervisorPresent = 1;
     synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessVpRunTimeReg = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
+    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.TbFlushHypercalls = 1;
-- 
2.50.1 (Apple Git-155)


