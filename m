Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BFBFCB63B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytmP-0000lU-SE; Sat, 07 Mar 2026 10:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmO-0000kH-DH
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:24 -0500
Received: from qs-2004f-snip4-11.eps.apple.com ([57.103.84.63]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmM-0001w2-Uk
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:24 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 6622E1800887; Sat,  7 Mar 2026 15:41:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772898082; x=1775490082;
 bh=JIMeijHBnhhl3REqIaANk8KG3S1sFo85lBGOJeo99Cc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=fBcUQgEkq9INH9YbVZqdreqpPtlc5QxEugW9n4M4rpUIIrpC+Li8JEts31JV1/+9wl6pD24583ZHVsZh+LH6jE4mNtSqtG7VLw7y4cYnXeD/U/LqW5PhSZ6FNmvIJeujqKFVfLr6oAUiTIA6i9YmYNH78lwUnfyIcQueUJ8e6WPQj5Sf9ooRvSFTa9uQvTmw2tttWYPP+79293RwtopEN4ZX94yY7TzFLHLB6arktMueQl5IV7kGTcklxfu9ykFt1XVVUyc0E1Alu/Ck2XihTLOCVZTmQAIGnOAiWs8PB2unnOoCZUj7tS3uRpKx8oN8SYXqiid0FwfLv8Dkn/02FQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 B97CF1800AAE; Sat,  7 Mar 2026 15:41:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 5/9] target/i386: emulate: LA57 fix
Date: Sat,  7 Mar 2026 16:41:00 +0100
Message-ID: <20260307154104.84567-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307154104.84567-1-mohamed@unpredictable.fr>
References: <20260307154104.84567-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=O8w0fR9W c=1 sm=1 tr=0 ts=69ac4720
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AJrqCOfVdMXzVqk_6-kA:9
X-Proofpoint-GUID: UVrVIKRX03nsacgydUMv8bnk13Im2Gqc
X-Proofpoint-ORIG-GUID: UVrVIKRX03nsacgydUMv8bnk13Im2Gqc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0OSBTYWx0ZWRfX5t3Awk3epZ+L
 MLQ/ov3jBwqUezpBE394eqhwwh5jm9dlmf5ko8u4+OWd82478mY78yOMjxbT8Yu42YWPYYG9q5q
 /bPri7eczNoBuLi6r6pThmbXVLsc6qtpJgX57JRjol/WNxiDiZvwxBj86xftrVkXZLb5XAd3t3p
 U8W1Xs+vgh3Ridjldxkw6wDadHGDaq19C3aX5fyoq0aSwHyE4FFXx5OtbGfmEmT0QSxz3aJxOAN
 Z6kNawoiGS85nF9lkuZu69WSd7Ls4I/bjdS1wwHrMzNWR04aTcvV/re81zl7WLAcl2uA15CCsVI
 JM2l/gSDeM0DfYy+d7m/VZZK6EVzQnLsjm+5T6j3IL5SC8xVbM7A/WUMMq3Iws=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=929
 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1030
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070149
X-JNJ: AAAAAAABnA5t6rk/FW+TS0RG+29Elw5Z5ZZhdtZegkyNFrlYr7pDSmm+ImM0Ysi1edaA7zm+5KU0A6hoAKlZASiO2D06+PaoGMo8amLXzP1EHZqUqSz/9Rmbso1425KKDlvg+7v48ugKlSAtSwhG4hdvkE+Gcgr3LdQWTfO/Re8KK4jfdEH/IS6oFoFaWBey9YhvKm96aiSxJjHJvg5hesxlE6Z1OzTWwzkK3G7NrtOhf5uI6BsvOgso/f2iND2bLUI7z7XAQw3iXH2Kfdwb9CGpgugCXA91XVUmXgreZfnEFI+dRoVK4InsqROpXR7vPSEcH9pPSFoUhalEtvzbecxUNYwc/4cCW0o2t9Lnp2DYLwyUO3vfBcNItzNkv/zvyMFYfRVKx3Ou1LqPVs5yynLkKCC45KORpxvjPGtoSWdO/6590sfBwoFpXjY5JLAsozn+sYbZGdnoyrX5o8f2bM2JcImOZrryltyaGzT8ppvbjHc1e6GK92Hm68SKKECPaOFovt9iRRGWoaFhWsBUTnBGhCZsJ3KrejAIzBCsPZMiyy8kgrtYYlArenOi7yqObx/V6A04bKgvMXJQaDkmbMUiHQYhhraDfiZsrLh6g4dEUk0U8bD2HhT3eUlelwUVrOG0Er71W8lk3IpDN80aXGFWg0QQM6uHVXoIpzM0VAv+W7Mlfj+eD1cYLYPKk8OL6sE6s2YIYqDvYboWXjx8BLU2SntELYYIuXfIi6TXyyYzgOSspAjLidvKy9JoZYHkGhuEXYf9zTaKjQlqKeKc
Received-SPF: pass client-ip=57.103.84.63;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Seen on a Sapphire Rapids box with LA57.

The top level of the pte array is taken for CR3, so there was
one entry too little for 5-level paging.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 8261ca1635..4e39bae025 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -56,7 +56,7 @@ static bool is_user(CPUState *cpu)
 struct gpt_translation {
     target_ulong  gva;
     uint64_t gpa;
-    uint64_t pte[5];
+    uint64_t pte[6];
 };
 
 static int gpt_top_level(CPUState *cpu, bool pae)
-- 
2.50.1 (Apple Git-155)


