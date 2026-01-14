Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23319D37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg18W-0007n7-Ad; Wed, 14 Jan 2026 08:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18V-0007mW-EL
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:11 -0500
Received: from p-east2-cluster5-host11-snip4-3.eps.apple.com ([57.103.79.66]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18S-0006Ku-OF
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:09 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 51CA5180049E; Wed, 14 Jan 2026 13:42:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lE935EhSo6eiiRGBTf1TCzdO8HBh375WWDyS664DB/c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=W5torUDY46IOjmAr7mculsQhHDbi6IqdmvY4lZL8PNB+YwdAKGCG/17of/E5afsV72qx5dwrLIrf6hfGevBL2zelsqXQ32b2jpIN7Dkyma3GobzO/hgjQKOFktj12sUk4v2XQXQLy5YiCqToqyQe1UBwQ0TmDj4xePRVqBEOrdor5eY1sK56Uu/4oxSITmL4w48iVKYXn4fxB9F/HFv9r7GyF3xPGxwNrKYqZJuHh1RGARV9KFbT93sqWxWIcvi3ploTFMOnNp4VgkR6w9lg3rz4p9HSSu6vVxXPLZXq05PVaQCb+DG4uT4icIv5t670QKIhyPP7Q2oMaDoYvJ6X0Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 875C11800312; Wed, 14 Jan 2026 13:41:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 03/26] qtest: hw/arm: virt: skip ACPI test for ITS off
Date: Wed, 14 Jan 2026 14:41:20 +0100
Message-ID: <20260114134143.26198-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: F1Cce3sCjzsSeOvyAIqqmnkJhAK5Nx7Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX0NqzGkKis7gY
 k9vS3uJAPm/UAHES01W46X2BfZimcO1kW/42aflb8EAUke/2cedxtdSRwbRBCuUmQgqcVAuXilK
 yTv4vjO+S+pSjCQcSbMo6V9j/I1R0DyRGJ6V8Kifj8x0yHPYuYkWN+EPe15HXGC8Pbr3T48+Gwe
 B5C6cocLlzVnzfw8dsVR07dN8dBc7ZvbYX+chMCRlyZ2CMXR6RPsgGw824McKNVjSILoNvX9a8p
 RHIwc9rG71qvdZq145EtO93J+wPtA4+ZUHHjzZwb+zRX6+MbRtuFuQrU3HXuIJihbDaKkeJFd4A
 jT2Huyy/h+rkl7NqfIN
X-Proofpoint-GUID: F1Cce3sCjzsSeOvyAIqqmnkJhAK5Nx7Z
X-Authority-Info: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69679d2d
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=1t8nasy7xzbR8br5Zw8A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1030
 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABac2XAVVVyw2brq2g6FPe2u8wasuzAXrJ9w+R94+gNK9LTr4bpm2L2e7bGIJdWqTZlG4DfoNMR7gWAhYEgTt0/sfiI99L44BhtgMLByKZclPPvlR0Ch56OZXlI4y7xRCg4I1KtwhvObhvgb3VbQx9LvN/l0aTAcws2oEsUOeozmy3+/pRQ/r6CGBsXq7bKc4PL54HUVxQ9/qCIW9/WuBxPXdQtTslZ9riY8zKq7UstrhlVDe7RMn3PdCmHfN8T6W/e31llUlTft3T+hF1NLoW2AjE99I1BGPVIHQzvoe97wDaWJGAHQlv6T4hUvTgg1q4Bkm5vNGXh2mwU5dHdSrRWEUIqHJQattMAEoHphNqlceBXgfVOJsndAOPeQijdpksBEHS2dFcuu0r8s084GVztZXEfCf/bjfhnUg/wT0w66BhkLiMBqumOgZ3RtKgLYcBB45Uioi5m0jTL+YqbphahVQnwR4UjKT3CWlohlPFB+wutzHIjhFSluobKR/7orFNldDe1t6ptokAg9Hxw8dxIb4r+M6CLraPrgogaYq/ZLgCVFYycPhV3EZ7jLgXCLznWsCxEUheP3hw8AGDkEeC8WTx9lKja9B2M6S+8VYGGuX5F9E7tFNjkNNE8calQ6X8Tz2XE5tqyYWZhpDkXymOIjAPULwTtex8Ow+80eyrxEbjOk9vTuuC/gN0jfEjaQxCnrrUy/uijVtWS7CXIWhLZ4ZvvCBB+gdP1sMydH1trzNFXLl6ojk1uFkoseW8TE1g3Se89kUmDiLaF9l74yXi/qdZp2u2emFXu1G55fPVjMfA8FekanhojMtB+0QMzuOcgzl3qsg6RhTUF9bmNCfnzy/TqSyrrffHK8aPbmErX0kZOpl2jiFxc1/Jk7jdxPUB9844EmrdBmfBCCj3INZpz+hGbv8vJDkSZw==
Received-SPF: pass client-ip=57.103.79.66;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


