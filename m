Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CE4E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0c3-0004QV-L1; Sun, 28 Dec 2025 18:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0c2-0004Pt-DF
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:55:50 -0500
Received: from p-west1-cluster3-host6-snip4-2.eps.apple.com ([57.103.66.15]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0c0-0006U9-OP
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:55:50 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 307A5180015B; Sun, 28 Dec 2025 23:55:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lE935EhSo6eiiRGBTf1TCzdO8HBh375WWDyS664DB/c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NUTq8IiENXuXg33x+OZ06YbUXbdW8TqrjQDhtVa64u4BQW1SK+lLNlOOIQrC0dfZU39Vup09miq9vghrXwn50ZAE2xJNGgHHSC9hGQTbofthSNo3ZA9Ya7DmYVLVyRmomPSACV/ucK8AW4g5P95esl2m/7S+/r0OBj3+a3LoSFnCg4ZiPYwgnk97N2WxySOzG3dbbvq5R/QiCUM8EJcpVz9HZAL5/Bj+7s3HBj3jdgZ11L4JS0cuc9THJym2KCx+1LJRrwohl/8oOJm8fbWtn1aTcuX3Zk95B81I8gPmxl6fO/hb79y5vqMt3MNR3WKrogJLY/AvEgK+DSj9hdnLWA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 3ADB11800755; Sun, 28 Dec 2025 23:55:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v12 03/28] qtest: hw/arm: virt: skip ACPI test for ITS off
Date: Mon, 29 Dec 2025 00:53:57 +0100
Message-ID: <20251228235422.30383-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=aNf9aL9m c=1 sm=1 tr=0 ts=6951c380 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=1t8nasy7xzbR8br5Zw8A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfX4veoBlSlau7S
 X/EK76yLhK9HBf9Rltiu8l49mP8jzx1OjGWwxG5FO0o2iknbZhrt3dD/8RBRGdRSizwczAmwI6i
 PWF52JeT6ppSFjdyFAdqSG9mNE9ikxi8PHyE5yXVfDkVOL/B4yaZfLB+ifbjMa8e38gL/G1LwPq
 oTcmeLcMeLj9dTFlnrCr5VbT9kTDgQajjeQM8IGcD5FD+LkQrc1+1fu00Nds7Ce4H9vN3jkj6X2
 3qLd++nvXiobX4Wb2vAJnVqNERUrDqAH+eLaWWv2yVMt6/fpwxwj17ltVVhpcSkE0lxbKKFSrw/
 AdEq+fCMYOAHv2vh8ml
X-Proofpoint-ORIG-GUID: BO4dTnxI7MPXiEQel8doq6bcBsigBof9
X-Proofpoint-GUID: BO4dTnxI7MPXiEQel8doq6bcBsigBof9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=910 clxscore=1030
 malwarescore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAAB6ujN0HzKfP1mxylqRawFQH98olFt1w7OZSP5birJjbpfjDMzDJX9c8+6VZRZm7Q0iufF0wA2N70PBKEmqY8kS+XNdN2NQww8xElh6fk7Na6WwcJQjQYtoWlnA9JVha2/sNWgj+VseLLKHwfhsZqMWuTNq5aGuXDd6uQRLUAor+dpFpZn2L2GTBC19IZF2nNDokdzIfkFB+xtnZFIkIve3lVYS2fTuRPXnglxdFZuvjnMknvr2tlazFDpanfDNce9PHchUyLr4k1EKbKEMh3OlNUz1m4BmebaE8AHSmRvH1rQjW/E3MpACISCaFu1i7r9WKsNGqnJKQir9SHDGw5JmcBnQx11cs+4tfHE1O0Os+szahKHhuoYn9h/aWNGWwre9jOfWh5Ygxa67G7AhqU7Sln2/1D7ELajlFOxjPmjzk0Zf3Z31WsA+MCmvnTd/qcq5gjj2vVsClOPcsmDnb7LN0dj1eeHc48e6nj8kqetOYW5dEvs1jN/ocPB4JEEEYCt78QNQ/cO+4Z+wXQzgsrGkNaYrODzNuQq5rQtqu7o6cV4cV/5WPLiFTmM21eTfjSkxD6+HARwTmVmsDmgKX9uOHG8NMRTFekgedwF9UFdBhrfexg+fYZzEWP0LU9cacmfp6ViAYoCPSsrg7dVh6cmbU4sc2o76ejVB0DTH0hNrvMJj0TbP7r9q7IFcAt9i6FAjOmMOUgGYaCrOlxrWabLgf6yk4o3jNg3l4n5eazCdLckcpI7o/tBbMHe3iV0w50aWOdUmbHNgJLzFZmQ1EyozaJXdcHuqbP+T5ybNg/r9F7zifrEhZDRVe7MyJxkvWZ6/+LAYpnVf6XiYchgyuMp2u+xDqUnbfNOZhIXsAp4VHDzXaTPdwAeiojo/ztwjNhJQfCm181h7w20+IJR8SEYYGGzOyWrZqtJch5P3OHF+mXp87fuc94zIF+l6/bZPfmIn2lLpsZ82vM=
Received-SPF: pass client-ip=57.103.66.15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..bfc4d60124 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
-- 
2.50.1 (Apple Git-155)


