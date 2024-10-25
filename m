Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD12D149C0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mq5-0007Fx-1t; Fri, 25 Oct 2024 12:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1t4MpX-000748-RC; Fri, 25 Oct 2024 12:06:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1t4MpV-0005HJ-Ih; Fri, 25 Oct 2024 12:06:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFf57s020881;
 Fri, 25 Oct 2024 16:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ViGjngwJ2vndr8N3DnHoQ0
 mtiUMECGSAQOr1mQp3bFs=; b=DHfihPr8RHXHaWZIBcI4+kFHNI8WyqioOL2IRU
 0KrroWKRwvcVg48m0Xqu9rologtgB+UddtN60DtgqpEAFfsLVbOTGTGNxXbYWkeP
 U11BhMf6tCHR3G31oSKDb4Nc08s3ikQ7G13sbjPoVDQ/PguKN/5dvrI58hzg8YdA
 R/rjYmzuLTo6N8MG1uHsN7Ho8g/PbGsQm8mIx50QmPW90d7Qu+vjpmce4kwi2fuv
 xkCfR3Y6dVjepVXpjFcRrh1tRM0dYwhLeXRsHr5ResBSPVzAYVFjepKymBPsO+9T
 SJipoEXMSnaO9FK1kpH5ITP5BhTM2gdNDR2+cp4a88XhI0Mw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g6y91krd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 16:06:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PG6B6j024331
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 16:06:11 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 25 Oct 2024 09:06:11 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.zeise@seagate.com>, <clg@redhat.com>, <berrange@redhat.com>,
 <qemu-arm@nongnu.org>, <kris.conklin@seagate.com>,
 <jonathan.henze@seagate.com>, <evan.burgess@seagate.com>,
 <clg@kaod.org>, <peter.maydell@linaro.org>, <bcain@quicinc.com>,
 <sidneym@quicinc.com>
Subject: qcrypto_ivgen mem leak and possible issue?
Date: Fri, 25 Oct 2024 13:06:01 -0300
Message-ID: <60849a6166bba234230bc1761835cc188a9f765f.1729858348.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: UJPziTmd7pti8NmRm1NKeU4I5uTTSFCU
X-Proofpoint-ORIG-GUID: UJPziTmd7pti8NmRm1NKeU4I5uTTSFCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250124
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

Since e3c07527f3 (crypto/hash: Implement and use new hash API,
2024-10-08), we've been seeing a memory leak in two check-unit tests:
test-crypto-hash and test-crypto-ivgen. Looking a bit further to try and
plug the leak, I got a bit confused regarding how the result crypto
buffer is handled. Looks like we are allocating different sizes at two
different places, and I'm unsure if these places follow the same
convention or could be breaking expectations from one another...

So this is the report from LeakSanitizer:

qemu:unit / test-crypto-hash ERROR
Direct leak of 180 byte(s) in 5 object(s) allocated from:
    #0 0x7fdb016e0a06 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cc:153
    #1 0x555bdb5892f7 in g_malloc0 ../subprojects/glib/glib/gmem.c:155
    #2 0x555bdb5895d6 in g_malloc0_n ../subprojects/glib/glib/gmem.c:387
    #3 0x555bdb3fede2 in test_hash_prealloc ../tests/unit/test-crypto-hash.c:136
    #4 0x555bdb59fb96 in test_case_run ../subprojects/glib/glib/gtestutils.c:2930
    #5 0x555bdb59ff81 in g_test_run_suite_internal ../subprojects/glib/glib/gtestutils.c:3018
    #6 0x555bdb5a00a9 in g_test_run_suite_internal ../subprojects/glib/glib/gtestutils.c:3035
    #7 0x555bdb5a00a9 in g_test_run_suite_internal ../subprojects/glib/glib/gtestutils.c:3035
    #8 0x555bdb5a02c8 in g_test_run_suite ../subprojects/glib/glib/gtestutils.c:3112
    #9 0x555bdb59e9e2 in g_test_run ../subprojects/glib/glib/gtestutils.c:2231
    #10 0x555bdb401b27 in main ../tests/unit/test-crypto-hash.c:301
    #11 0x7fdb00a75082 in __libc_start_main ../csu/libc-start.c:308

qemu:unit / test-crypto-ivgen ERROR
Direct leak of 96 byte(s) in 3 object(s) allocated from:
    #0 0x7fd572092a06 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cc:153
    #1 0x565440094e7a in g_malloc0 ../subprojects/glib/glib/gmem.c:155
    #2 0x565440095159 in g_malloc0_n ../subprojects/glib/glib/gmem.c:387
    #3 0x56543fede89e in qcrypto_ivgen_essiv_init ../crypto/ivgen-essiv.c:44
    #4 0x56543fedfc8a in qcrypto_ivgen_new ../crypto/ivgen.c:58
    #5 0x56543feefdd3 in test_ivgen ../tests/unit/test-crypto-ivgen.c:147
    #6 0x5654400ab719 in test_case_run ../subprojects/glib/glib/gtestutils.c:2930
    #7 0x5654400abb04 in g_test_run_suite_internal ../subprojects/glib/glib/gtestutils.c:3018
    #8 0x5654400abc2c in g_test_run_suite_internal ../subprojects/glib/glib/gtestutils.c:3035
    #9 0x5654400abc2c in g_test_run_suite_internal ../subprojects/glib/glib/gtestutils.c:3035
    #10 0x5654400abc2c in g_test_run_suite_internal ../subprojects/glib/glib/gtestutils.c:3035
    #11 0x5654400abe4b in g_test_run_suite ../subprojects/glib/glib/gtestutils.c:3112
    #12 0x5654400aa565 in g_test_run ../subprojects/glib/glib/gtestutils.c:2231
    #13 0x56543fef0654 in main ../tests/unit/test-crypto-ivgen.c:177
    #14 0x7fd571427082 in __libc_start_main ../csu/libc-start.c:308

At qcrypto_ivgen_essiv_init(), we allocate 'salt' with:

    /* Salt must be larger of hash size or key size */
    salt = g_new0(uint8_t, MAX(nhash, nsalt));

The address of 'salt' is passed down the stack as 'result':

    qcrypto_ivgen_essiv_init()
     |> qcrypto_hash_bytes()
       |> qcrypto_hash_bytesv()
         |> qcrypto_hash_finalize_bytes()
            |> qcrypto_glib_hash_finalize()

Which is reassigned to a new memory (of potentially different size) at
qcrypto_glib_hash_finalize():

    *result_len = ret;
    *result = g_new(uint8_t, *result_len);

The reference to the original address gets lost and never free'd, so we
get the mem leak error. I'm confused as to why we start with one size
and then realloc later here. Also, how should this mem leak be fixed?
Would it be sufficient to avoid the g_checksum_type_get_length() and
rellocation here if 'result' is already set?

As mentioned before, the mem leak bisects down to e3c07527f3.

Thanks,
Matheus

