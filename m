Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4DBCA600B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWf1-0003uc-8e; Wed, 07 Oct 2026 14:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWez-0003u9-AK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:46:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWex-0002fV-Nc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:46:37 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697IB7MC472820
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 18:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OUPePrCPx+O
 /1Gx0FRgUu46/vUjSq7WAXFLhpED+8XA=; b=R3vpOjITcTeeESW/FEivVoZbigh
 j7k8Cj3AGRCBKlhYfarJFX93N/8HG+QzBexJE6h2Rg2HXkO5i7KndQLeVQrjxCrz
 CkpVmCySiuOAR2IImpovM3LDFv0H5HBbKv8H0ETWO9oTfwomdzGMJQlE6O+Ucn1K
 Yq8fRI4V7rS9XpZwTLJEEV2wZA7XswswtjUcDH/LcMzdbeohs4udMEwlJTZzOfkh
 mE529n/I99ppbpOfDSiSl1MGDWMEU7hGMAlOXV2D+nabcRXNoNo/K7U6cX3+InCH
 ShTwMmXWNwrD+D3mJXBSnMpxareL7Dl/nMTUdtuZNumH1Sbn9MQR0jR+LFQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5hdctprc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 18:46:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30f1b904861so5655842eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791398794; x=1792003594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OUPePrCPx+O/1Gx0FRgUu46/vUjSq7WAXFLhpED+8XA=;
 b=hzXGOn/ZG5/ZJY8Qf0NvC3k7PN9K3C1RYjZjZENZXUIoqNDy6K4Y7rq9CBFvzESjAF
 Mm8TSwyde+7fyYajdbNre+cVXpG1bNtSNeWWh2uSS8dQauFnWqIWVxoB4f9n5ZCW0q+h
 5OVUeZUp4e3jhuR84gXPvHLv8SftwvMG2UJUCVwnJy6gfPR9suZYHeJvKUAiVdlLQvHy
 cG6Nmi6AvXlCgAEp08naY5Tns1yolZVboFCe1esSFErybU5f1EK2Y8DqyufEjYRqsl41
 cfHF59/GkvfjVlxhCZujcircWYgWI0VkzG1iH50A6ZVN8LHPIqdgTGLw7UBcuAa5wK1X
 VFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791398794; x=1792003594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OUPePrCPx+O/1Gx0FRgUu46/vUjSq7WAXFLhpED+8XA=;
 b=ezRV2XrCTOR/xqwE4qtsvS9ujERWeMEj3qucQ0METAwuLHdelQLkdFI5UC47MPd1J2
 4E7xNHONRqzS2Bj8Y/Ypli5cHKtLiMznEXW/rCUgHehaXDyF/OnFm1e3To2WJq6gOi+j
 gfI8NqaHw7UFm9bca5/niX0YkZA67NHoVoIQcfvKDvqMuLDq8jLpB9CbNdnfwNM9ibTN
 qOMaciZ1hwlW1xB3+qegx+I9a4lZRjLcWv9UPssrFWcHR0yLdAO7zujMfF/tdzTuk0ed
 AHorcOXCXz8/YSsg1o8A9Fxy5hpkEhwqMjDFuiSUgJ8tg8GULUFRFQ89+yKNKAmqew7k
 O4yw==
X-Gm-Message-State: AFq9FYIPmJjIb/uLFT3iiXBKfZBoikQ/2IncXfrS4BoZ9NWJdPJ8lDJB
 BY/Y9Mjd0GrssRAyujybhjB5IFbk8LwFTiLi5n+GR5Nrxab+zLurdz6O1+J80+cSlUyPg79nr9Q
 QsaGbd+Xv3XB6ZfDRRoXXfOL6mPb74Ei0OJS6LFohUAnpk5d6WgkXigv+VbflxsJ4PQ==
X-Gm-Gg: AYBFou1lkdTV+xsE8JCquQVE6LbMb8Sz85Ue/16ckPROAQqpVZaL6RnwsOjUOReP1oE
 JzUq466gAIiABD8ff6nM8unJsj4BtZEmfNZh+jkm8CzLx6VyWgDw4WDR1g9PgIx4DU9OcUM9AOk
 JwzjpN/tUFuOTF1emnM1GGzWZ20Igr3g7A10HVp5UYID4j6ta3XqNbJkE8bHkOa0o7LVrKBnofq
 sRg5Is1eOCdXgwlQWNIhZRF4Re/dtYpJE5K8BcQaLIuFpHUZXRAFsLcr4wd7u3Qljpt34uJPeeg
 hJtK1DZCgr7VjQJWl3lvb90t8elqaIFvgRO8IfKOPpfc22NLVwZ5PkuLD1UOkrIFObful2FiAou
 H0vvYaFeM8MisQl/5YcV6Rh1xvagp0FalENtFxx6RGUwPkyXsEq3hUfVZcEG+
X-Received: by 2002:a05:7301:714:b0:351:4fcb:c5ca with SMTP id
 5a478bee46e88-3515de44515mr3776978eec.35.1791398793566; 
 Wed, 07 Oct 2026 11:46:33 -0700 (PDT)
X-Received: by 2002:a05:7301:714:b0:351:4fcb:c5ca with SMTP id
 5a478bee46e88-3515de44515mr3776909eec.35.1791398792618; 
 Wed, 07 Oct 2026 11:46:32 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515af3ad13sm8295910eec.14.2026.10.07.11.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:46:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 3/3] tests/qtest: check query-target architecture
Date: Wed,  7 Oct 2026 18:46:12 +0000
Message-ID: <20261007184612.24073-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007184612.24073-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261007184612.24073-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: g-b9HIbSDWJpjt0ViJy5qpoLIbvSa9Cy
X-Authority-Analysis: v=2.4 cv=aKFlOr9m c=1 sm=1 tr=0 ts=6ac6938a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=3ko5fs_7CqgIhspINmIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX8h065hjO+eS3
 8+Ay1RIP5onUkCJ+x5oYHte7YErakh4QfcepwNuO/nU86Rfee2c+Mb5em7ron6na/VEwSbJsppZ
 /w0q32VId0Kj60VaJPaqodjYUWDOgpw=
X-Proofpoint-ORIG-GUID: g-b9HIbSDWJpjt0ViJy5qpoLIbvSa9Cy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX7Zvlze4ll5l2
 Jr009K3sWky5CZgGgAGlS1+ByNPaeViNySQNWsaGt+3DYy8bV8hIoAtf8+jSa7+NumC8pZvxllt
 OoHIeIBvSlBhdMz1mdxQdALysSYpccX5jZatF38K6VkTbqcjPHuHktOIN729Fs9p6X3CRodv/x8
 3/CmX0aeuSWfWtpn+ZZqpyne/aOPNY/nHXO0cUo1yXx210D9RGkDHF9BpspS3X7M9UOH/VW3BgD
 jICFCDUjKY3UYHseexMGUupe6Zenlo3RKRt/sfyMo1/t8sYPO98xjI0nTrtyZk8u40awxgin49A
 2smwFUNaeCwC/w46ZcgwrQrBhe4kT3767lBKDBiHAE7aDl3yYvOV+lSpittOev1xTFcBz2uCGkb
 4QtOnTRG0ovPYq0zdIi9+cQ5eDwx5dfeiLcDExSK4dkWlokbL6LS2CNl4xK0JG8Lxg4EZD2C8Gx
 tHH+4a1ytsXghN5jQYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070074
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

From: Yonggang Luo <luoyonggang@gmail.com>

Check that query-target reports the target identity selected by the qtest
binary, including softmmu variants.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/qtest/qmp-test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index 927ab053f8a..c70f6a681c1 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -164,6 +164,18 @@ static void test_qmp_protocol(void)
     qtest_quit(qts);
 }
 
+static void test_query_target(void)
+{
+    QTestState *qts = qtest_init(common_args);
+    QDict *target;
+
+    target = qtest_qmp_assert_success_ref(qts,
+                                          "{ 'execute': 'query-target' }");
+    g_assert_cmpstr(qdict_get_try_str(target, "arch"), ==, qtest_get_arch());
+    qobject_unref(target);
+    qtest_quit(qts);
+}
+
 #ifndef _WIN32
 
 /* Out-of-band tests */
@@ -517,6 +529,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("qmp/protocol", test_qmp_protocol);
+    qtest_add_func("qmp/query-target", test_query_target);
 #ifndef _WIN32
     /* This case calls mkfifo() which does not exist on win32 */
     qtest_add_func("qmp/oob", test_qmp_oob);
-- 
2.43.0


