Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEDCC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgryQ-0005TF-2h; Mon, 06 Jul 2026 18:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryO-0005A3-2w
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryM-0007Fc-2Y
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEIqD1639870
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TKGK/S7SA/w
 2mbBIQ2/YAkKqm2FNLQSV8RwZ+9lY2dM=; b=jfuUNWXdqwRyNVjyD/mrfLC65uz
 Ix+SymNTNksS4hmdEkL9X3HLu1ES/l9x2QobKVorO3nqfLKNUk9FH0n2lYiAXbE5
 DWFHAxkZih/Y5pWpdcGG950CxnmEZtu8wNcVZUxWQJLQe/GSnamMMWatTPNUe6J2
 B2cTOpO4H3vLG0YimuMmqiZ+LV9yn5QTWBrOUAeSKq6S+YUSAwdqpfCEuZQbcJtb
 6xrnkfd8KBZcf17pCFO2aZ6KwRVkfkwwmcJovZuaBtzVL9q7tjsQjYpaTC155BcR
 +IvR9VrivaH6Um6wI4ATZRLRecZvR+UAIMJ2aqj2fheK71ky8R9IcFRg2wA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r35cb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:39:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85798977dcso5206248a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377558; x=1783982358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKGK/S7SA/w2mbBIQ2/YAkKqm2FNLQSV8RwZ+9lY2dM=;
 b=ZzlkkaUKM2ZJQJP28jNNaIGSj3OYzeCjOztEzi5vyLcmRV0pTXwAHAPY0oInhOZsaT
 J3BxftgtJFmN0v9C34Oy96T1twLHJp+rGbaz7VpKNUzbGXa6vNiWXbcADPuyNp9GJsXL
 Zujq5h3u5AA1WrWYQpBIaNERNkQzgYkKNdhC/dQS18ClRNthTuYI25crMKrGuigVCF45
 8N5CpMrxZuRnxZQ8aVydiGWJOLgFq+p/h0n6iMdPJ7bcMFza4McNod1OhviP/8fDTRQq
 4HD24DPH6XqzLi8LF9QbM0O6qunKHqGpkbHmvU3k3i5QKzRLUlgH7jo7dfSl7mIiMtrE
 snpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377558; x=1783982358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TKGK/S7SA/w2mbBIQ2/YAkKqm2FNLQSV8RwZ+9lY2dM=;
 b=qx8FdL9oA2T8yEwh4my2WOoAxAgOmSjcTJoK8PrWe41R8Y2/vatAKeNlpTavPS6M2+
 TNnL4iBWufmJxY/gxlbQ9Y4CVFZJk7UMQp7Vsotq5KRAKP52PUQNwxnXq9ZzYit9F+6J
 KX1xQYVnSzRVPwGdRRbMF/k4e3Uc8csQNxr6WAFX++qPniGJAvjOAOxOPedP9c60fKT/
 UfwHzmjIz/kOxfWUWL6Agy6jYsO0H7f3mMs/tBnRHaRxfY+o+94j/IP1EC9qUgDkZg1Q
 lmqPY64Ct8fzYpqz1KtakLye1fWJ2KVtjZM78F5ZFU5KBHM3oCG0f7ruK0ZoshRo03Tr
 Gx5A==
X-Gm-Message-State: AOJu0YyAO9JUVIiHoNrPUZSaAyoGPP7BsikBjszEDN/FBJnCz13rvAA6
 ItxJsT/p09lC0wlrW/TxIsv/f8weFa5D8WBCvYF07ov9t9LO8fx/Jlh3G1b1NrwqnEYcMjCt5f3
 TJ91Bbz7SK2KR6Y3CZ5oO74LN2N9WE5W1/KXUCGoanQ1+IadyYzU1qRA0jBisTHdisQ==
X-Gm-Gg: AfdE7ckiWml/G6lwBJM6tzUUDQG9C1L08wQrETpSPjcNUDyXZ9+A0+EMOtu0/sCMPVn
 tVOcjUuMxttcZX+7SDZp9K3zPTg/f3ltwMhm0nsmnz+49mCK9IFNcMW12cyoJVCtOCbwIy4GMHh
 mbALXKppcF1+YuOh0FRA4zkBJtyak+6yi0q7IvSAd5yMGypPZjPzYu/7eHyi/BGgZE7d3kRBqsi
 MMDlj60XCcnU0hBF4P2IogSu9a8XX4SFTfxL4ws94gW98m5KW3aESzcPwB8/MI1PwwamNAFNW9q
 DNrf5Bn9YiMXT99i2B3Ubh3tFezWt2x2HV0OBscJxyTB+tw+gWcwu5xCaJJauBGuCoPdYTeWf3a
 XYALiJ+PIYDoUFYav3in8S0SWqswzUORLopF4ZX+ulrjEqWrMmTvKUwUlFNF090E5Cq4CGjXp6i
 pRHjvouw==
X-Received: by 2002:a05:6a21:4d8b:b0:3bf:6c08:fb81 with SMTP id
 adf61e73a8af0-3c08ef5f0dfmr2909886637.49.1783377558000; 
 Mon, 06 Jul 2026 15:39:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d8b:b0:3bf:6c08:fb81 with SMTP id
 adf61e73a8af0-3c08ef5f0dfmr2909837637.49.1783377557331; 
 Mon, 06 Jul 2026 15:39:17 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:39:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 76/91] tests/tcg/s390x/head64.S: declare _exit symbol after
 main
Date: Mon,  6 Jul 2026 15:33:28 -0700
Message-ID: <20260706223343.988769-77-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX5lrNR0kaQank
 +yU06ansjuHx+/g2xAjD2Jri5na0KYueGmgTLmG19HTIS7GLa5QXOd1BkjrYpw5PUmnBtP8UFPi
 HI1kRwjrNwZwuoGFlK3YDBtUvZ/36rB/PAcRetnIQ7Ndedr+9jiFkrNFTA7P7sSMxmVwzI2rznV
 csNr110nDcYb0jXGahf72JDUP3ZaI2hYLH2IeY3qlCxeXWttoMFs+yswls+I4iG+Q0G/fc1tnFl
 sE0jCKaadyB9/tfVS1ro9wsXxpDIS8Np4y+kuEuU7SBz0khjUZEQ5+9m3VJZ8NAwgTzHxEDPBc7
 iVnyYz10K5/Lypku8vqG4T3IewNcPK6pTTZyKgimO1oOmagQ3rln2Q/YDvF8yMrzxiA/VROc/2I
 hucbJzCf/PhXrQCjRgAsy22tZrBxrZub9YQJaLJRlkbqa5qKlE+iOBoxWDemlkcgDf2+upl51fZ
 AF51FhmUCxxMJZw0+9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX7C/Nws0GMlyi
 SESS3f/QumagULcxFo7sjOZkYebCmKgnfDlnAd/B6+OnU59KJ1TZguYvxrYvktHjfVHY6TpA5JQ
 /7chaTANSqNWh8gt06YkC4pYeGlMda4=
X-Proofpoint-GUID: hox4PMmHQNNRKmIBjtvh2lztuQRfb7f2
X-Proofpoint-ORIG-GUID: hox4PMmHQNNRKmIBjtvh2lztuQRfb7f2
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2e96 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=8B6s6JjS6HUdPQ4oQ2UA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

tests/tcg/multiarch/gdbstub/registers.py expects to find this symbol to
compare state of registers before and after execution. Define it
explicitly.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/s390x/head64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/s390x/head64.S b/tests/tcg/s390x/head64.S
index 4fe288388ab..0523fcacb33 100644
--- a/tests/tcg/s390x/head64.S
+++ b/tests/tcg/s390x/head64.S
@@ -14,6 +14,8 @@ main_pre:
     aghi %r15,-160                     /* reserve stack for C code */
     brasl %r14,sclp_setup
     brasl %r14,main
+.global _exit
+_exit:
     larl %r1,success_psw               /* check main() return code */
     ltgr %r2,%r2
     je 0f
-- 
2.47.3


