Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED4CD3CC8B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB1b-0005zd-AV; Wed, 14 Jan 2026 19:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1Y-0005zH-03
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:40 -0500
Received: from p-west3-cluster4-host3-snip4-2.eps.apple.com ([57.103.74.153]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1W-0001qN-7j
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:39 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 89BDD1800430; Thu, 15 Jan 2026 00:15:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lE935EhSo6eiiRGBTf1TCzdO8HBh375WWDyS664DB/c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PKsqTqF93OhmLUVl6Llt0wG9juNzJ+dGlemqPQbRDBvGXtDBmrylfIzWskhQ74F3HeYGsWJNM4G0DVUqv3bdaLYMSQ+bZuiL7eUYTD+5baiZT8yo2BK+lCS0VWtfVIzwjhTGao7+LhBQUfIA8k2hRE6jgfgPlR4enxC6zF0Tq7zrXK/1h7vdPC6IGluIlMjNEuh3QaJQt2DX+9465U+ZeUIqMrkT/f4z8nrQLtBBy19YPp5BLHpU6y1+wpGidNa2/ycfJIYadvM+nYwmvdFDSWWV0yuMk5Xut/O1UOguMtLWmqZhxqP+N+ELp/Kran4vTKbGqYz9EB8c7min1OfnxQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 D11BB180043F; Thu, 15 Jan 2026 00:15:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 03/26] qtest: hw/arm: virt: skip ACPI test for ITS off
Date: Thu, 15 Jan 2026 01:14:42 +0100
Message-ID: <20260115001505.57237-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4PGoAUdL6o-M8ESRKjClYnSUM_lO1_Qq
X-Proofpoint-GUID: 4PGoAUdL6o-M8ESRKjClYnSUM_lO1_Qq
X-Authority-Info: v=2.4 cv=Pb3yRyhd c=1 sm=1 tr=0 ts=696831a8
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=1t8nasy7xzbR8br5Zw8A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfX9OFGU9z3bbKy
 /NisbjKwIBoNamGDWcJel6FepV/Rc3ubPi99FLczKs2oR8iP9zYf7cJTqXOAV2GL/VRlabe52rp
 V+f/+1pAOgWSN1HdViCI3nhhevE1+rMSyOSPkacStdPZ9c4N7CqVjte0AtTZG5mVbM34vE7+1MO
 dQWiu3ZmeJK92/ADKL4dkSlgU4UVZgDA9gBGtUV4MttpYDM7fY8yA5yTRFxE53/i1MLYZ+nOU/5
 aVCw4s4xyxvRUvOyKvBpqXzlAYvCNTCIyGDUN5iFGPdyxy70SlZjfJetLFsWgcQgz0g2Ksm6y9A
 mfQHSdBDtTQTpdFaFBb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 spamscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABZuPawWeAa4pcqMXzKr5KnJA9lghI7UPT3h70nxoot3flUz4Dpd62JmPH2l2d2Y4/q01T3F2AwYJuOfUl+P93956lCcETZ+nkl4/QW2NgRRtn7l8W+Mn2aBhEUt6KIQw0/im3QsE1ZsRz4lvQ7iX7/ei2bLp2fbudUfEPGTHm3W8CBKlbCdstMsXiDBOBF+XteFs1eB83ZsrSQNYNEjkLIq45PRGZPfmO7606O6wVA0RM7yqpo2fno4UYYxaTReUHuDS/vKztvVnLeWSMMy6hYy9K2mlgVa8AIr7ltljFSCtcqF4Af7wV2JgolYW2fyjK6/FU2QXZ5kSW2Sts6ADZXuK55QC0rm3bVAJHfmD9LX/pm7CtnuFUzVtnIB3J6tQplXa0nQ8TmJqdvwYyFmFcTM5jMV2vzPMDwJqsE2gEykXr19mBYVkpu1IX03yxiDXHDz5DTG7GqSW6D5qGoZDYiNLAnbIDdviX0+KHOU99hX/aVLM433rc2ZHlBp2ivkAo4m2TKLA44z/dHmCm3coEQwEYF2s2SdoMGnug1bVgo43Shzax6900F24H61PEoqQATBdG8nejy5F1mpJJvlb1AXVc3kW3SDPX+iKZjenOSv0pniWjoGy4ef/L4Jei2nfBn63wUOhRTtP9xPCS3WTqowtuQ32P7Z19KyP+uO3FFedS/16k483Yvujj4MSXgD8SvekCmnW7+OaSZdZ50MkgZouzkDiyzSjh+aUSQ0onMdlcsoay5/MFkXoXjGkb18vHo3Q2+iT08iSh+PPiCnYOcnB+fdjmFYGk8tvdS/DFKsH7NH8j2bes+3TMYjjxpU0ekEVcKeK8gU1yf4UQ/Mlqyyek45+hDuyQJ9M9WXpy2iTqLqA06dJgHwvDfjw/x84/fwug3PbMT4cyqC6t1WcfO9ZtoJ3yZ/V3tvRhgvBsImKaVDW7A7HcnhP5Om3/bzRU
Received-SPF: pass client-ip=57.103.74.153;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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


