Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E7FCA9EC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSL-0006X5-Sh; Fri, 09 Oct 2026 18:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSH-0006Vu-D5
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSB-0002cY-EP
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhgPT3274833
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4178SUZe2df
 q6+nnO+AaN4uU8AznJx8/I6yZ3wWHAJM=; b=OxuRCpniAIMnPFkWMQrNTw3J594
 ZFrVit7HPaCc3KBJJ9zQsuqsbCWsKooiqX/uzaDo6ekRne/t2ocoK79sdgoV5sMe
 fs8iOtsnAQml+I+FF6DLaQZn29Ca1eMEovj1fVppmQgS4SmtQi+fdBrWc9UA5Syi
 nTpNGr57/SCTWRLxFCeVn9v+lshYeueXH7iGbZ5yb2ZlOEQ4D/XC67GmSebaEPwQ
 /ePac66361ip7uJf0b+qHqnB7j5frB4P6VRfUnlzl362hDRAszYunCb61/fUpBTk
 6Lwmfx98Q/G9zjZSzZwaXOtwQKa0HaY0KWo346h9L2ocDNbLyyz0JPKqnxw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7h0vb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so422059eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586357; x=1792191157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4178SUZe2dfq6+nnO+AaN4uU8AznJx8/I6yZ3wWHAJM=;
 b=JpEdl3cNOBUIjy6Tep/WlNM2uEbxFI2b9iRFdtXuIo/YCFmuHBiYUd/lZWp+VUb9v9
 zDJF2BYwk3XmWPlnhl8pbAebbUpKiKS+eoNSyk2Hlra6j4g/pincbjjchwytEKuCPaWc
 6v+cg902+6UXxgYcVN4M6geziq3MYFJxJ10G3XC8FGEaquTnrm7AmFLzgejerpbJZ3AV
 0KFl3+GMMO2tE8OT9XIoNPO59YB4oGU93cFMjidBgtiCqtAjAfg7U6PZ8yA0VsdRTFAC
 am0dkvZByHNYLk6+NVWRuetBBC3sFNqmjSiGW6KrpI7tXmL3pgoVJmax+nJ69iFtS73j
 R0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586357; x=1792191157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4178SUZe2dfq6+nnO+AaN4uU8AznJx8/I6yZ3wWHAJM=;
 b=aQ780QnYPNR98deuBpBaYVWLeTN9qLMvH/siMhzssSWnDuKZRVyIuS4tCLXfwuMmOw
 V/Gad/L+Qr/c84vzVPD1X1IaIp1TixE+98nPOJVMqC29T0+9k3nlJUbNbBdvD/NITQ8t
 jn3I6ODVNJEHNUc1lj1MiHYcbmHY/6eOlGCbnpGgzMjJJ+ddYX8vVeMCriAcTYrsi2eB
 QKIXqhjEF0O6T3+ae3MxDlrKf5DsXpOm/F9fUK6dkBymhnNbFUM5MKcN7fwFO4mp91bM
 ZE8UDwGTvbo5TQCwKd89ojN0jZ5vTs307u9oONxZ6oYLQIbkldJvi9nzoV5bU23bGEUX
 P/7w==
X-Gm-Message-State: AFq9FYL5YOExeVELk1r0MGaUN8ELaGIGQ9bwOJwRmPGoYxEBSbIAJcl+
 oNY+tL6GPPHUq++JlxUeU3w4TXKDfOkYOETOMz4B5UANaggO9Szs/wjb6rb8fkz8MDL0QT/obyd
 B81ZjmyhW0PER6nyKBw6uWE9dZYWb3VFiZJRys8nuJc6xPPku8qYhRlwayk5hV1EkvA==
X-Gm-Gg: AYBFou3lajL0EpShXtES1i8OJrivR1X1lxveVQS88c9rZK4xInWp7EDHHO+AACnT41Y
 P1dgnHxS3GD2x/MRMEv21upAJvUz3fM4vybe7G4qHgoh0+E7rXW6e/PfkBE+ZwB2ZRy7FQccdZc
 Rh0WUREsfVAucsY95j6cEYm8KKovS2NP6wORzIRGBt7Or4QxmXIfGk8jkDYx8pJpjTxUPnhOHcG
 p+CjRfqh9TM4NMpHMCZe9OIaZ0JAltUQbjYBud7EMWBf03U24ktfUfG41rl3PhRtw3pXK7OaBIK
 H1T3VGPkZdAbgab6WhiuRvDTomuvDwIB69HMuzzdk7yiX/Zv3/sZASEtn8ilBg2NowRnO7mv85X
 w3nyMqjC0bDKTjMWFhelq9rpZt3MwyVPLijsTP8HHkmO6yOqM9ddCZN30O84s
X-Received: by 2002:a05:7022:e888:b0:166:97d:4579 with SMTP id
 a92af1059eb24-16a5dbfdddamr4304556c88.8.1791586356618; 
 Fri, 09 Oct 2026 15:52:36 -0700 (PDT)
X-Received: by 2002:a05:7022:e888:b0:166:97d:4579 with SMTP id
 a92af1059eb24-16a5dbfdddamr4304538c88.8.1791586356072; 
 Fri, 09 Oct 2026 15:52:36 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 04/11] hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
Date: Fri,  9 Oct 2026 22:52:19 +0000
Message-ID: <20261009225226.10657-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W8atxhWk c=1 sm=1 tr=0 ts=6ac97035 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=m6vfh2jtweNnR3fUmdIA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: melmqwoE7nt_Y3iFjvgTtamBjTqqnG1-
X-Proofpoint-ORIG-GUID: melmqwoE7nt_Y3iFjvgTtamBjTqqnG1-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX/8Mr9KSNlMHq
 APqeLpF4Pj0mEgHlR+kg4kCQnk7CrUkB3KGGYmU1f7NMQYH5VBL2kGJ0Vo3Mdmchh0tI0QiV0HT
 6Q3yJxEkc+A3Mfyds3M7b5TAfnwOLCg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX+d+5m/75s3qB
 asPEqP5Mw8dAt0uKmiHx1yB6xXey+aPKwC27lL15D/gr+NaawVQlpYc78AFcYlXmYxX3gOsYXmv
 /iWh4Ljirtv+049Iue4ceOB4wsl2x+dYdPuC8aStiKTTwJKzeMGcUoz2ngr9Rf5s2+JQfBQN7mq
 mdJk3yHhKc54vLdW084aXh7mfvUgvwW9DQfg2mRjJXHjm1i9sxyh41eNbPZhYVS06o2rNU43H43
 RqT0R8yGK2Qpw5ibNgOxid/heSPCLeWn6K6601esLLekbQlJfqvFNGk5VTlboZPK0T0FQ25SFBH
 xx0WKoqFMFseHeCMOVObACSB9OYFFIGCpmWL3LTHiCHWVBiQC18DKJ3HBhbpi8Cx0uxkncszk4T
 mb+J5xjKdI6EVaVpggnStn14WzB7PCVkXCP9L7OheYnDJBanVq3+yhix1jguFfYLSHAlvopYYzk
 tu4b5imgoSUfxXl0dBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090091
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

We introduce this since upcoming semihosting ops will be in the same
ifdef.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 328e30045ce..8160a301978 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -183,8 +183,10 @@ struct CPUClass {
     /* when system emulation is not available, this pointer is NULL */
     const struct SysemuCPUOps *sysemu_ops;
 
+#ifdef CONFIG_TCG
     /* when TCG is not available, this pointer is NULL */
     const TCGCPUOps *tcg_ops;
+#endif
 
     /*
      * Keep non-pointer data at the end to minimize holes.
-- 
2.43.0


