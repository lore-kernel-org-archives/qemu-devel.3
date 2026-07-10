Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1603C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4fd-0007Dd-KU; Fri, 10 Jul 2026 02:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fZ-0007D3-M3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fY-0005Vq-5N
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n44k3898996
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IDRk31Zj0NT
 s5Wo7yrF9weQFuo9YFZjbPrrRm8ZTiXE=; b=kEwcpYoTwY5wKGsFLZXXKTD2+iW
 KRCgBaC9BBcQIGsM2kyUvfbJpT0dRM09WucXj9ZfQrjrb/obBsYds/LZ6o3kN+dQ
 jhGqH5heyHaa18b0pN06UH54OOjlqu/7M212DR97YEu7w2t6GWlZYkqhN5j5k0F2
 kDCWK12N9Jju7HEPuk2V6yY+9eUopwf+LxdLkZFuIwk2iH7hkq3TQPQIH5YgeiJ1
 jbmNmZ7LVWu4TABq9GBtpeiWxAeALGQU1jATqHq2vHjaIpta/YRg3IRqc5BpDa2s
 KDJdFPRWvQziBW0OckAlg8ef/E/6Cf91UFxArIETgm2P7anTupev8UgcedA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3k4d6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso1297981a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664701; x=1784269501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IDRk31Zj0NTs5Wo7yrF9weQFuo9YFZjbPrrRm8ZTiXE=;
 b=QXpn2+SPBGNsy8wTxYqmqEXp/IRj/NcVuZY6h+OEerrgClKW6VU8/Ph2z4narpeqXg
 wAiUu3LZYets2nc8YBmi5p34KqF1NY1SffswND1dA+B5Azm7qfH81/L+ouOYzQJeh7oK
 QfcvlFmPlqB8xIvA2HClYtuvOs335PUz6T7Ro1B7mG/e/2CWFJ47ULmZfpCouSyS8h64
 e5xFCdYBeFlo85qx/dR9BBjee6wvasR+Fqfu5kSnmgARIegtMEc6ZXVIk8bOZFpLE0oB
 DNWkybHgAGQXyGTxUPz4n1G1chYl8vVbq83Phw0jL5EfJIiflgKVx9lr3gBx90OVEF70
 9B3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664701; x=1784269501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IDRk31Zj0NTs5Wo7yrF9weQFuo9YFZjbPrrRm8ZTiXE=;
 b=Zbf/rdvJynt0Ud7yg68H/4EFpkocQDYgGQFybLNR2tF5OplHO57mSoorqMuwRLE3OQ
 9xxpCXSPBWYb6tVF3EaSsPHUNBEbCj7XEFpHtGCkHfQZlT59ugFDCdvR/tchxhlLtkaH
 M0ef8CgPxU+x0GMNbdeYKN2LgYUDt+SHfC7gpfilAQedWjLciyAV8Y8YM9Im4OjUhWjx
 7MtXiWF6Fyp6zEtbp/7zUxcoJ8l/ybAJED5uvsLQxpVliE6kP+uYz4fdAHQaTOqDzltd
 e4/rX5smbnyE0VPJFq3nA9+EkrX3m2+gVA/YnO1MR6Hksv3jZFLahnGagPTJhiBpi75u
 PDjQ==
X-Gm-Message-State: AOJu0Yw6zisae1d/Ef5T1wfn3H1X+St+hDp7lkIEYsjCQKN0OHI4xugq
 DbLRHSBkOpCtGs6Vkl4r4gccs8kePigAoR4lSSvS/WvooBL6pLiCCMduFrwXJaiQptRWS27+JDy
 toRElSHXzVKCyzdBD4WpHzWKlPoGzHYWqEO8oCvO++FMEAqcIdvB3AURys6gnJUWcTg==
X-Gm-Gg: AfdE7ckXeYm5GfhLaiiXR9el224UXHnD+XabJz+NsUrhHvlwuK9wISoWdfjQgV4V2zF
 N9fIg9pXOf4faLF/4tRtZYa31e6YV8tU6xQEDu9RTu42x7CTlMHXlRO7JX/rvLOtJ564FmXKXFO
 u2/iKzLM/Wr2Y/H64Db/VuZ7ejIiEvJ66XHDMG9Y+V9okVUe9R7cKs3jxrH5EqVIKYK9vQ8gAIE
 iK4AwvaKG6ncdXZBL/0l1PrlPJyvjE9g/CYHUV3CAUwM4dtSANQAuv1zOLEkFkkpS1PuLuBjCSE
 ULa28g2/05QNVWcknVOY1kYO/i58R3euWOdVSBhHH0BU+sSvrCxLl8q8UGOgsG4ri3CIxcSdgic
 71vvXY4uwCz9Fm0ncNxZrHrERevNsfjtH/luFQUfRGUQLwMr9McKNwet45f4cW78FZQbrHjxJ6n
 ZYEPnE7g==
X-Received: by 2002:a05:6a20:734e:b0:3c0:9c1b:d0b9 with SMTP id
 adf61e73a8af0-3c0bd31d47cmr12769889637.68.1783664700621; 
 Thu, 09 Jul 2026 23:25:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:734e:b0:3c0:9c1b:d0b9 with SMTP id
 adf61e73a8af0-3c0bd31d47cmr12769837637.68.1783664700101; 
 Thu, 09 Jul 2026 23:25:00 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:24:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 40/97] tests/tcg/aarch64_be: user tests
Date: Thu,  9 Jul 2026 23:19:18 -0700
Message-ID: <20260710062016.1818125-41-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX10V+hXG0t3zf
 C7ViPF+b4itSdvrzSCm0lqMy9YaPBHuSunlEELSPZf3DfXg3eg1/1srQ+/AzZQh4Ch8Vn3MNmuT
 8fIiyG/7jYCqzu2SvTbwrTsEtBwGrS1mTK+tA/Ct9LLG+/ozhsMlauMS/w1YrHKWa8kFygJ3xxe
 bbmdfv8PxiOz0yv9nErjbrdzx4IzhBWqiwoawnE9bLo+4xCt1ol/jnWoceDKRvbyRu37Tyl3i0k
 OtTtlD0ccrx+VqETbdc3ROjjNF0yw9vQISPPpvCajWt0Q5CjrZDWipJnuFz/DVGvi5JS8eo3dt8
 MCWOefQpe53aSSB76Q5CzGDeMO2VRkOT+TkajxVESc8Lirj/WFBIRbXCM1a9XqN0BO2/IUnwKkV
 fT50WH5xPvblv3IfV5tAtNPLlm0OnFkglLJgLryMIFjOySpsciSfypGq9UZ3K7lsnx8TFqu6s+N
 PBF9OMl3XVmGIKmM3ZA==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a50903d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=14urWzF9DTBOP6QPqJUA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXzh7Ocq+Kltcn
 Ep6+MLvTdR7NM8MslPc6g7BkAr0P4fCDoj7xVEVLv9/wAYKqTqFYyLfr/F+agtZ4EiDQgX9IRQI
 GhjsLPOeSV6epExU46HPUp7facY0itU=
X-Proofpoint-GUID: Vj0ikex8N3d9SbnzvwKjvPlY1UTwwgqa
X-Proofpoint-ORIG-GUID: Vj0ikex8N3d9SbnzvwKjvPlY1UTwwgqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64_be/meson.build | 22 ++++++++++++++++++++++
 tests/tcg/meson.build            |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 tests/tcg/aarch64_be/meson.build

diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
new file mode 100644
index 00000000000..9ea111f9885
--- /dev/null
+++ b/tests/tcg/aarch64_be/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+# As we don't have any big-endian libc available,
+# the best we can do is a basic Hello World.
+tests += {
+  'hello.c': {'cflags': ['-mbig-endian', '-ffreestanding', '-nostdlib']},
+}
+
+if 'qemu-aarch64_be' in emulators
+  tcg_tests += {
+    'aarch64_be-linux-user': {
+      'cc': 'aarch64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64_be',
+      'gdb_arch': 'aarch64_be',
+      'qemu': emulators['qemu-aarch64_be'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 05f2487428b..a17195c3b9b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -134,6 +134,7 @@ endforeach
 
 # Now let's go through all architectures
 subdir('aarch64')
+subdir('aarch64_be')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


