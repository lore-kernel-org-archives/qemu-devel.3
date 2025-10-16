Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614C7CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9SHD-0002oE-2l; Thu, 16 Oct 2025 14:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9SHA-0002mr-Me; Thu, 16 Oct 2025 14:00:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9SH3-0002xx-TY; Thu, 16 Oct 2025 14:00:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GCEgBb021081;
 Thu, 16 Oct 2025 18:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fPo1tw
 nwUsSW3Ix18wJ37acDLS1absDp45MKVxzaBWw=; b=jsibvCUC13V0HUCDDh4Qfx
 E5MlJgDW5UhOb22MFwEGDK0tf3FL3jzobyO/LkaNX5V4kn7mWsG0vMdMHSA40V80
 hF1J7Msfpx1vMGq264EliHVfz3XDnXnmk1DOlNAjwbDsCLOc5I6AvXdLytv5UGK2
 Dh0o+F1qQhD2gK5C+yi+rmeabXSnRwU5HxmTImJWb4pFhskXuCTKJQg4vnX3WxR0
 /IerxGRLre4/iOfAbN70m7KH2HmxhKr2/iM5GqaSuG3pNo+jiu7bGTVf+acUx9dW
 LFNTLZkfHG2O6kuYdC1FPtsZhNFrOgNT6AwcYiSz4GgYZxTBLlCQ2nHh3KvuooCg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0b5ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 18:00:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GHdgVr016759;
 Thu, 16 Oct 2025 18:00:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32k737r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 18:00:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GI08tl55705888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 18:00:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3465520086;
 Thu, 16 Oct 2025 18:00:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AADF420082;
 Thu, 16 Oct 2025 18:00:07 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 18:00:07 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Heiko Carstens <hca@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v4 3/4] target/s390x: Use address generation for register
 branch targets
Date: Thu, 16 Oct 2025 19:58:32 +0200
Message-ID: <20251016175954.41153-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016175954.41153-1-iii@linux.ibm.com>
References: <20251016175954.41153-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i10FYjh3NCuigyLXKLyluTVuaeVwNSwT
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f132ad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VTue-mJiAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=ZF8_gEG0qyWobQ4ivSYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=S9YjYK_EKPFYWS37g-LV:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX7SCgXV8+TrIf
 OWY91geIYyuYPDSvaegT4bi90+e1ISANHNJKETRKCQXp3NQT9Oox8L2wMjSpKQ5Jw888rKBwJiJ
 eGH2DEssmTLXMBlpYiYAfviBrhKFYSMYBKgDDDXEKWBlzy30emWZUmL7PkyG5hO92GiBPPOd6DP
 9+x2q4/+Kdjrfw1vPYk8jl7Yje3u04F0k2Ru4AsFN0O9l6TnZFupTzWDG5uBlWLH0xejjDE+ppr
 L5LXK/9McIitJ4qpapwl51UNYyreJ0j7XmA4y37/0++bp/D7aZSH4ZwXoHoFBdt9y0EHmRp/zOT
 Y75ZjsemN3rX3In1xuAJY+rtxMumZR5Vhhk0b8h4SJNHpKfn8pV6yFr2rNf76KBxPIC1lcCwp55
 njsBA1fNi6CTvvwZQi6QSpEqQxtanA==
X-Proofpoint-GUID: i10FYjh3NCuigyLXKLyluTVuaeVwNSwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Indirect branches to addresses taken from registers go through address
generation, e.g., for BRANCH ON CONDITION Principles of Operation says:

    In the RR format, the contents of general register R2 are used to
    generate the branch address

QEMU uses r2_nz handler for the respective register operands. Currently
it does not zero out extra bits in 24- and 31-bit addressing modes as
required by address generation. The very frequently used
s390x_tr_init_disas_context() function has a workaround for this,
but the code for saving an old PSW during an interrupt does not.

Add the missing masking to r2_nz. Enforce PSW validity by replacing the
workaround with an assersion.

Reported-by: Thomas Weißschuh <linux@weissschuh.net>
Reported-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/lkml/ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de/
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/translate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index c7e8574438c..f9487f4044d 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -5613,6 +5613,7 @@ static void in2_r2_nz(DisasContext *s, DisasOps *o)
     int r2 = get_field(s, r2);
     if (r2 != 0) {
         o->in2 = load_reg(r2);
+        gen_addi_and_wrap_i64(s, o->in2, o->in2, 0);
     }
 }
 #define SPEC_in2_r2_nz 0
@@ -6379,10 +6380,12 @@ static void s390x_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    /* 31-bit mode */
-    if (!(dc->base.tb->flags & FLAG_MASK_64)) {
-        dc->base.pc_first &= 0x7fffffff;
-        dc->base.pc_next = dc->base.pc_first;
+    if (dc->base.tb->flags & FLAG_MASK_32) {
+        if (!(dc->base.tb->flags & FLAG_MASK_64)) {
+            assert(!(dc->base.pc_first & ~((1ULL << 31) - 1)));
+        }
+    } else {
+        assert(!(dc->base.pc_first & ~((1ULL << 24) - 1)));
     }
 
     dc->cc_op = CC_OP_DYNAMIC;
-- 
2.51.0


