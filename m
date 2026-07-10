Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77489C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4m0-0006l3-C7; Fri, 10 Jul 2026 02:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lg-0006QZ-AF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4le-00075d-2E
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nEm03752799
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=daoGlI2ileC
 E5+NKrfWfvG6pzTbDBfXVzFqgSTYNXxg=; b=d29/eEB50WqLWAemaB2MSFJtJ9V
 FnujKu8qQU+o79TWatxgc3DcJDuQdRySo6six0eudZ9JJ/XEdXxqq5bfc3DSDqfL
 SG44dwxKRkp/nIbOBtmSinc4uwAkoV7kwf5NITlaeYe5Tuyr6eo/EUJsTYhsV06+
 3aNXBV2t5kbIp7BCnNl1Xg1XKw0hRmjfBB8WohIvEXUvwV0Hg1SmtkNNSmwQBYQe
 EHsDG+bHVJGDxjTogciY2MGiotxei+303aHJnsM2OmgV2f+uzZTo7T7eGj03YF9A
 +eP92PRiX8jaziEC8zB1WxsuvQ9YtNlaF4dvU/NVbqhXHhHaU7V9fUBhuYg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjbb2b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so647954a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665070; x=1784269870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=daoGlI2ileCE5+NKrfWfvG6pzTbDBfXVzFqgSTYNXxg=;
 b=Dg/QJoJ3FafjcUe73uZoCRQGRZn80tQ4TVMY1mh9qromsFnLAWV4tMiSSSHeUVix9T
 UiXgBmksIryHSyYb8uA4d7DGaL5pCoOkFLsJvOcuDYqOZMck6b4DlKAW8DQV+g4ev+rO
 RbIOLlLUeEgCQYklHa5JdLywHZv3Ey5gmRF8CC8aUEFVx0w/0P3Wj7dJI6w2AZ5aFvJ4
 WTgLTQNzpPgiOPhwgNyErTHkOeKXf6N7ZCRJUNGJ6weYKHEYw9dU61IHCEl1TpP//vYq
 ARYCefHku5fBdyA6m6P4pi4IG7YZruL8+IxVtXmmIt/22HYegANXMU7zT0eEYiNlQ+w0
 tHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665070; x=1784269870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=daoGlI2ileCE5+NKrfWfvG6pzTbDBfXVzFqgSTYNXxg=;
 b=FJsSOInsjY9ro6bl+p9EfhdRivncZ1QfqZGupmxhcxQa8BvPwSlNprBq+LtwKk00th
 izR24N08fyScwERKpogRYGjcHafKp19I+Nfe9MK+MqB+MWBUduKGfTNDJZsG5q7YhDn7
 4mTRAZ8STed32blZIGFqz4mnQrF1AeIFvPjKbAizm+Ino3Lqt34cHTAZiqRhoeXWFCnk
 Kv6dE1hsaOCI9rlKU0EyRCwrVWpqPhtQqwpXr14zYl4mn/cyPSmtMWmG8wRm0wfne4mG
 nPKUqKLiTwCf+95e9w6UdZuejba+WFQQaaPSZBlRE1VxFe/QgXFuEtW9FXbQPqa81ry3
 TxIQ==
X-Gm-Message-State: AOJu0Ywo8rmuOAElHgNGv+wWUP6F/sxdzMEA9fmy+JdNEiEIN0w0YpZd
 ERzMlU8KVpIzVvPqvicNHfObs56DBf6oizD9WVaooDvB9sziXsQn3Q1LtuCUB3P3e6jFpJ+bsBN
 CKTuZ6zyh3v4mxFwzHk25jIpyXKzgizqnFwAGfZKobXGvQyBd9KmD1i2bUcC88sAmaA==
X-Gm-Gg: AfdE7claTj04yha+74TbJteTs+yIAP77R3sCPY+tjLYSg3xRTUuYIjK5LV8ZXg8U2zI
 +avz2ca6KZ5JHnuzMAjvnPluKSN75Kk2cFGA7cl8f+DaCOCukx4BBjF8C077R1UlHAm7k2vn1Ae
 KpjDcxZWvYE9didNYVwGtIhWzaRpATwyMWG8z0qGZEZHvezz2aHQkeP6FYJum1kO6atouRwNAz3
 1gx4BMRcQCeySxiWmmNTm9tIO+RqSHibOzUd4+Qfyamd9Mw7MlKPyJnt32q04sy/VSvTLA9p8oa
 efi7tJmXnLMlskEH7rrzJgO1DVI4hExu+BLvyQfdaN5DD6YdlLldjxAwr4VeAv9YaXQ9hxrxHdo
 4hWbakXt6Ut0UEImABd/k4G2JcLByUv4afAKOh6Si6jUDH57X5fR5iKpDUrfPMODjsBKN3jBfx7
 vDxOD3rQ==
X-Received: by 2002:a05:6a21:7014:b0:3bf:7c36:127c with SMTP id
 adf61e73a8af0-3c0f0ae398dmr2749854637.23.1783665070103; 
 Thu, 09 Jul 2026 23:31:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:7014:b0:3bf:7c36:127c with SMTP id
 adf61e73a8af0-3c0f0ae398dmr2749799637.23.1783665069610; 
 Thu, 09 Jul 2026 23:31:09 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:31:07 -0700 (PDT)
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
Subject: [PATCH v4 91/97] tests/docker/dockerfiles/debian-xtensa-cross.docker:
 add test_kc705_be toolchain for xtensaeb
Date: Thu,  9 Jul 2026 23:20:09 -0700
Message-ID: <20260710062016.1818125-92-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX/xi4TadySSMK
 AtHICUr04R6IAit6AfCf/aJX2K2fyI4WdRN0X8TG3u4Tm3W5sBfdycDdl9Q+p38ZdFjq3c/nFZf
 i7VEFr3OYZ5u7RAMrXoO2EmFN+psTo1aDimzpH0RTRy66WZos18Jc6ySds/uamIskAFOQcCsEwp
 YR2KmvY0870XDzbD9dZJ3lg7eIkKol5OtTcGjGWVb13gNv9eoI3vdaU+AMG+AG4HmGTp0Pa/dTK
 owow+unrsqZw/UV4/Be109U+aA42XLaqzkqC5RbCYztrVph7XtZeP0xqfnDB0gnVR5KTCy6h64B
 tfJEM+7nG2a5IzWNcCXi8TqvP+Lo2xOKIf8cEgBaqi/V+VP2TTSwDdbsUFq9eVe663CcYOv4AbI
 y6ML9Ln+4h33EuLaJ50DQbyM/oJU3VoXqzjMeYv6IDwrYzPQFqhkuz47IT0cGqQ/RmUzlR9vG+F
 +9KOGDzFKWMvsz/h3RA==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a5091af cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=wlx_lthn7XJiM5nFl28A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: rSR5hUubL2YZBQZlex31AxiLQy4mTYXG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX7jaOdaelXLls
 otv30w5+4/F/Zykzqk3Tj4qDPYpAY62RjqFFJwYpCOLZYqUTDHnvAzfE6bJJ/Q5unqmp2bEssF+
 xDdiwpg0uF6FttBUA5sdzV63Qe+9Q18=
X-Proofpoint-ORIG-GUID: rSR5hUubL2YZBQZlex31AxiLQy4mTYXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100060
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index d9130fc3378..0eb6d98cc75 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -19,7 +19,7 @@ RUN apt-get update && \
         python3-minimal && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400"
+ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400 test_kc705_be"
 ENV TOOLCHAIN_RELEASE=2020.07
 
 RUN for cpu in $CPU_LIST; do \
@@ -27,7 +27,7 @@ RUN for cpu in $CPU_LIST; do \
         | tar -xzC /opt; \
     done
 
-ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
+ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-test_kc705_be-elf/bin
 ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
-- 
2.47.3


