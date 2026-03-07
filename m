Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC411F55103
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vywF6-0005GC-CY; Sat, 07 Mar 2026 13:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF3-0005FK-As
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:09 -0500
Received: from qs-2004a-snip4-10.eps.apple.com ([57.103.84.12]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF1-0005OC-0H
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:09 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 6FF0818000AF; Sat,  7 Mar 2026 18:19:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772907546; x=1775499546;
 bh=XrC+A2cdwnTtrklru5J6gKiuM0nyKsFULUgUC4G4lrc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PZB7UDqwTHWVY3HLpJwMhfgCGVGgIt1/8X7xZHmdMpq8tpF/Uf3vQwlGP6w9XQ8cdQNnkI1kv+fX9yW8Fj/A3m1rudnHdgFo5W6dxyZX+juITU8kFw/p2zqMMlaZfxPRpEQw6s4InDM2koYfKZipiAGnc7Aso+FDTwrPY8LvwxPNmrZOwHXfRwK3fwEwfC++HTaLRdRlUHAElY9yFa7dpqDHxodXvb20m95ubD/2y6A5EEBswNBUsNS++GySJ6knHd/ljeY+IPe2jSoAhJSE28x9wuH/qGtwIU4SV/z1h5Y5L4OvH8EEXKDxi+ZlTG8XB+5/vmMdbsINb+cUyS+rkA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 338511800105; Sat,  7 Mar 2026 18:19:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v6 2/9] meson.build: older macOS targeting compatibility with
 macOS 15.4 SDK
Date: Sat,  7 Mar 2026 19:18:49 +0100
Message-ID: <20260307181856.2209-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307181856.2209-1-mohamed@unpredictable.fr>
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=fuLRpV4f c=1 sm=1 tr=0 ts=69ac6c19
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=11mQs7XRU_pcqQXa4wYA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3NCBTYWx0ZWRfX4/dnuXCcdo6i
 yWT34tljecYY57XbZTlZ6jeldA2FS16iOALOPgNz8NQEi3sRdkA1T5lIkNo0yYFIzUZMr9wxdIf
 jyvbui7bNNocLB4PfdG+aNKDqX5yLEMw1/HMaL3bRWieA7BNk9JuhE0ROPZCGrnNhWFbIMXLcyk
 Nlxv6FEUrgTTi0wOalTsyrF12WsUCGHcT5E+n1xxb0rl6d3BagfF0waGBJTtn2hZQU2zaTAOyT9
 FjYTcPQLysam26LQLkV+g8I0lf8lCWzzQbm5B4azpX6n6JzdI117wvdiiYNa+HM5ofQGDxiicJe
 klPOMV7pr60V1ekYHxkbQyzLyxE9fF6l7jgOSDyC6LtIepkkUlBIs3i2wnVXj0=
X-Proofpoint-GUID: tIV4TH9Wx5i8Bz-gSADTOMrxtaOWF1m5
X-Proofpoint-ORIG-GUID: tIV4TH9Wx5i8Bz-gSADTOMrxtaOWF1m5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070174
X-JNJ: AAAAAAABL23LNDs88RKg8skxkbv+4B666xhuKrmu9yFz9CY53/YfypcCdE8RuaMH9sl9JY4jitcbqyY8i7d1K+TyLpUibnjI+rqRpb4znj2835djT0OOzMoCp6mGjFAik1KzIi58PNT1roSNjcY4yhZU7ANQmC0DaWAJyJa8Fti8Gvs0qgtYvaozPn1pKbS3kH59QAjX4u5ZJMfYsMlVMbcLkcrrEi7PXViP8BOVrGURosP8aJj0Xv/gmQKunqOhZx/Ih/16ucjHpR0ds07P8W8D/EXRlqIryYbnUK4Y1RLWGx87/B5p8D7qouuhbRssy/Z5cO1dGngCkVSb4qXfSQeVBgd9EwrYo6V1Ji/WI7gHkhfLpYHOmmPlHVFwl7tSJlPHWWUNRbrRn/LVFuHl9FL3hUaNpAfPns+tepDsNeBm1T1l7chaL+5t61RIsVV7DwnP5joFR40JJCoOfFk5e+dxSAoKJiBNdR8/nVfaTdTtvEzs/b+AQbBDw7TkJ6yV0gS0kb5V612kJnCAyEMRTgf6chw4IhkvT/oyVUQBiUS7syKw7inuk3IXXJSt/PAqPxDQFEBJZj09gIXB64I4t8tUigLh+SRauECcgWgwHNu878wX80hTD8r/QwfLGjBEXmlOlbD4bLNTWGkBMXhint+l/wICg50oANjXRuTowcecRqU5eSnz2tXCpwrduRp3nK35p9gZV14N+f7yM2bhuIxNGFFnmRVfn6FZgUI9CXrUF0PJI3nvBfBX3fg2pRDFbO58zvHR+KQ8ro1rTWNR6RWBERW7UA==
Received-SPF: pass client-ip=57.103.84.12;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Using strchrnul eagerly results in a failure to compile when using the newest SDKs, with:

error: 'strchrnul' is only available on macOS 15.4 or newer [-Werror,-Wunguarded-availability-new]

Working around that by not using strchrnul when targeting macOS.

This didn't show up on the CI because it used the macOS 15.1 SDK instead of a macOS 15.4 SDK or later.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 7b4e5bc72b..78bde0611b 100644
--- a/meson.build
+++ b/meson.build
@@ -2646,7 +2646,12 @@ config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
 config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
-config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
+
+# strchrnul was introduced in macOS 15.4.
+# Keep this condition for compatibility of new macOS SDKs with older releases.
+if host_os != 'darwin'
+  config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
+endif
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
 if rbd.found()
   config_host_data.set('HAVE_RBD_NAMESPACE_EXISTS',
-- 
2.50.1 (Apple Git-155)


