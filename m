Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0787FD2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknph-0005uJ-Ku; Tue, 27 Jan 2026 13:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknnn-0001ed-K5
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:39 -0500
Received: from p-west2-cluster5-host4-snip4-2.eps.apple.com ([57.103.71.95]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknni-0003QI-6p
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:34 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 3AED1180024A; Tue, 27 Jan 2026 18:28:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538509; x=1772130509;
 bh=ChIhwcPMGVA7/ZQSbYVEEiNk2wqKK9/9DHnWEjCY41s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DSNjKsMnBHvRt4TlcfkZW58ZnZjFPOHoVQYEh5BhBTEeVP8XBj0e8ye81o9alynAVNmLwWD1hmBh/vcnK/A1tHpGljF3kCGY96Gjw1FGoDTVlmPSmtKdIBUAPTfFssiwVGBdlEmypAzzIjsGWwyzbBJVrqHxxmOLYh6Hyzj2DQAkel+239b63NHjP/ckZxYH17aYywidEEjx3lYsXUXDqgbHGcm9lsOKHXaplCgP3pwkVbVTTFYDzcRaDnO56CBYKPKk60sxO7ZhXdiZadoyfsAPK4t7LOVh6MtjD4hP9goDtkyj8kMS3MTgFLlP3830WwwCaJ0OCi/I5McUEFvKHQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 8052218000A8; Tue, 27 Jan 2026 18:28:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v18 03/22] qtest: hw/arm: virt: skip ACPI test for IORT with
 GICv2
Date: Tue, 27 Jan 2026 19:27:43 +0100
Message-ID: <20260127182805.73212-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfX/nKayxB+y3zt
 M46RntRu2wo9mG/G+VOqMJmBYNXRtlzMjSjBm5fGLL9d9PIAVDgetR/kMzGbTzWRGUYrkepQPWR
 3WnskrbEvfcJxHCwjJjQmASVpDL1CfI6Xleuy0dj9+wGnhONvrWWIiAlKHCo7SEEGWi9W3/82oP
 sHYxYWMMJHGUhSajHCK77UyQVS69T3RyIiN82YbQ1s6z7VlVpT8lV+P0kDEs5U3EzFHOxpg6XMH
 dmAkduonngn+fyS61RqZz2z54MjU/lrhLU/h+WCLRu+22mlQ+YzyX4OjRjfzi8IxjyQcHfS24Sx
 jlj9nEzpvAntkcEzwFxVYgMSgzmg7tOTiIPWTQjT//My3YgYrku7WqoMguZpWA=
X-Proofpoint-ORIG-GUID: 6vtEGzJoN7ZtNxf1ug6e4bJMNCN5nxmK
X-Authority-Info-Out: v=2.4 cv=a+I9NESF c=1 sm=1 tr=0 ts=697903cc
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3bhNkNL8zgIfWImNCT0A:9
X-Proofpoint-GUID: 6vtEGzJoN7ZtNxf1ug6e4bJMNCN5nxmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1030 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270150
X-JNJ: AAAAAAABewu9/wLAAh8kuZTOGG7ecHFvbOH/1oStMCERbL3Qu9RfstlUXDemWwgPs0otiV93J3wBTqb9cJvz5yX8ObQq0kLX/ZQw7cLJaVfuT45ubw4lATmutkW6BAAu1PPnTdA9wls9W632u9zKXHw+DDVBulS76FxTIWhpDqXZL7EY+0r2Y01ShWKGOvE15AwCWRJ70B1Ar2FH8pxNJ2lYnHCP+mtEKR4gN5HKZQ0lXaY45traAmMN9Za01aDXDuV/p9kCSN26g2RaGbITSTtUeiFZ/iuP8LsUSN87tUDAAXcJBqFk4adG4R3qgNmPuJOuIYTAIGsZn0+pvc4uEvZaO/+hUQhnAw42G4vMA2SpyuOJkKWC6th+TFS4ozeezDAGEUBZipEFyeBe9zkvbBY2KfumIXNJZ5NsDLSZCn1iFUoOh592JrVmOvj51JLamQ0QvgXV5pULgENJRRt2FNw/99tPeROYU5JMx2HOfunHRhG7TPgzt5OZSz0wlV7+Dy6BgNC60RBfTEY/DlAqxZ9THUbL3n7R5ZB6F4A2ZI6gn237VRC1WA8S79kln5hOb8F6Jge/RP1qhbSXuxm6RRbwz/Of+9wAK4IFUiTe0yZnfjBk1mV0Dgdykq8hs/C9f8HNJp6nWDu4FYcIEDYMxlyb66WP4GM/CLETL/sf+rPxnP297PvP4VsZyryLNDjVUoEGFNyfibA5iufkjR0o1nVBJYcgMdwPpc3j51yesckkUGvtGH+VR+0RHOZCeQLVDnuYjrhjwZsNcgKjQz4jeGdNtYMmLGPUkuf+Y2aybBTJw78MKhDV1fJob7Va2ds1amhy080NZZMeUf1Hiic/c7wLccH0ZZf7dTYs+yhKtubjEyGj8akU8Lieac0dtLO8cDt2iR37yDEKRQoMx9yoEAQxxoPp7wHPSXu0Ra5XZH3mjTKGUKGoJOJ2KlyPiOhcUoS3YUUC
Received-SPF: pass client-ip=57.103.71.95;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..7acaf464dd 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/IORT",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-- 
2.50.1 (Apple Git-155)


