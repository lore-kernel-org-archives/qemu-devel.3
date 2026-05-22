Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A13CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUzx-00005d-SX; Fri, 22 May 2026 14:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUzv-0008WP-Fn
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:53:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUzt-0006pr-Rx
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:53:27 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MG8dHl3005101
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /g+XOHs1xP203R8HwDVwF7NGE55rO4oal12cxzwG8eI=; b=dx5uVAcFZcYf3Sp3
 Q6QSUXxV840eMmTaaSHQddu46xRB2fLdnGBkhnixkkqDTwXCw0vylaJ2HXf3P5VZ
 /HYp7fIiwPcjVwwBit39MhEOztIJQOL7SKzAuHm7QQM42Hl5slq4OKDQ3rBn8adR
 hRYwUoIu2QCyspzfZ3QM8l0E6w8kUVS3JF2KcnR1c1RKr3+l+0qah0ACSpXnQFn0
 wZQwH07xdIhQtGZKlKym9YszUsTHDrVf/82sg5fJ1G8dK481BFprs5UCDer5Thes
 9EsJ+At1MZbKqSDapf+w27t0TIT5KulvMF4+t5j+6HvAGX0C+WA1a9WyJ8QNUw8Z
 1ZuM9w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrtbgun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:53:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30457ff05b8so743226eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779476004; x=1780080804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/g+XOHs1xP203R8HwDVwF7NGE55rO4oal12cxzwG8eI=;
 b=Mf/iEhC41l79Zh7neYzHfBuI3C+XvOBi39CqKVj24y5mcLQuHFeJrIpEU1JzGiuacD
 VTnopnZbBa2zeFC4jnnOHBSleswHIna2Pbp37uqozzikLuez4vgWb+mKdbpEm1OMbUvH
 vfNPVrSuyIwMbiJFfM6/dQwJF7mIK5m6uXJxiW69it1xDv8Sr2GUbx0NbfCX5YNyKBaK
 q2AMnoN1yK92+Q6b7ZEIlOt++Q+1AzmGO9R5gsOpVDr6IGrt/044I5IUbL08yabgRFG1
 hhE4YwXjxq/2wff7l0jqZ0nAk5oGmYn1b4e5mbrSrOvK3C2d/E51wnI2hn9ahYmSxkuU
 OyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779476004; x=1780080804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/g+XOHs1xP203R8HwDVwF7NGE55rO4oal12cxzwG8eI=;
 b=nTTeCLRHPrLiVnoQ+4JJklrnLP66S1JAywlbUteZsm6lmiu8WFjAuv/WuwXfcVLa6v
 qs4LZ007lOakd2EnD4YeWc1ZfoSEjXVqweAcMlC3AnypiErmxp3UmP1eiUte7c6kxWi/
 xzK+xWFK7fsTunN+mHOk+5yTnRd/L14OFxk6o57Y43cjXb8iJiHolH2o/Kx1QiIz7SZQ
 hoyKuHkdws6J+hjRzwUq+4CO6M0hNGFuJtEcWciXpA8yY3gkbVagPVNm335HktX56oWX
 1hLZl1/IdhnA8EyPadrS+zd2K33+mqk2/bprT75ewu3KTZlC5HcKhOwYRdceR84VLIZ2
 zrbg==
X-Gm-Message-State: AOJu0YxEviHKbfcMhjzx5ir4UbHHHE6440Lnl706OQQQltKwWzQf7aQA
 NkwI/bK4Yq18lcAEHqK+Ig/7rr7tLJl53BSHS4960KQmlMm0gKLCZWcyL11gecqgEEa/pDYaGAH
 p+cfq27NW5UVFR7kdsk9/TtPF0arQcOGojax8E+PT1vMeoZuE7/E4bpP4l6OaAShmZUh9
X-Gm-Gg: Acq92OHfRIx4CufuCCAJrLPzpEPgZDRLofZq9FOeEkn5o1kXPL7a/s9zQDsUo/JJ3Ok
 VxzpqmPnzzq8lnCkSnNNbUwutjp1cYL/1qqtukxgLY6q/UQaAB4O+dKEIf5sOwJFmnSYTvTOR/h
 6J3gSmFTgEhH5GbLum6rBVFk9AM3/KEKVaGeCELseID1HjKHgEH/1RsLsPoqZta3yqpRJohTqwi
 FjaYgHRx78CqLPwL+tTiKaAC+2yKoKGv6szyy+Z54xkUpdDmRnLDqr56eXFtCvZX9l1QaBWAr19
 1OoPH/USUaYEiIVc7K0Zst9mmaNGBxTMusxvrxLbHcND4YX4UDmNxwsjAgCm4dIGGcd0Ocitifw
 mzK/vvxSrjF6P+EycK/JgK4HHDzVpD7zhfKTSXJ/GokEGGf/wVfks61VKf8//d/Vz4qcOyfWBOI
 oxAQJ8cw==
X-Received: by 2002:a05:7301:10c2:b0:2e1:e3e6:2909 with SMTP id
 5a478bee46e88-30448f4aaaemr2551119eec.9.1779476003818; 
 Fri, 22 May 2026 11:53:23 -0700 (PDT)
X-Received: by 2002:a05:7301:10c2:b0:2e1:e3e6:2909 with SMTP id
 5a478bee46e88-30448f4aaaemr2551097eec.9.1779476003297; 
 Fri, 22 May 2026 11:53:23 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045225b7b6sm2470502eec.25.2026.05.22.11.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:53:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/3] docs/devel: Fix typo (s/exist paths/exit paths/)
Date: Fri, 22 May 2026 11:53:06 -0700
Message-ID: <20260522185306.4105344-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522185306.4105344-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260522185306.4105344-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a10a624 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=PzGKxP3WAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=s8HMjvC57-lUbIe1XKoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4OCBTYWx0ZWRfX3+8JNTQ9DLog
 8Ldp5WFkT3o9+mTFDfhyynNFWmGGXkJL1BhkKxhJrj/jDNvE6uXGBeY16cdH7lT6hgLdmbXLoh4
 PDNR4RKjtHqVs8z3vAzKY26u6g+lrjsBeO+dmp+0KpkU41riQAp6U/7ymm/8zIanO3NXa1M93/G
 ES4BgjKvo3JP06crgVmmTvrD0vkkWY7+mUkE4FQgKD1TaOr7nWFqTPPDCwlUV+GDK51gKEHmVI/
 kmWibTLgkeR1wldjnP7q3DcA13puRzH+CaPm75MOsYmvC0Po8l509uYMkfEU0STvh01w5bWdF4t
 QBSjs6BKwaKMOFfpAgoiXquR1KzSh4u72g9g7g79ZpmZx8OQFuk48uNrbs7w4sYkfLXgJ++n1dN
 m9jrqs2JWRqZerppljM4iQluD/wXfO0WjL9XOnAup2WoKGVqL96UZ8Kad8DTn+MeXKhGsC2OOg1
 WjNxa0Q/b3f4jsKlrFQ==
X-Proofpoint-GUID: iFgLDh6vlMenuTOuuXkUVpxS1qByrHOb
X-Proofpoint-ORIG-GUID: iFgLDh6vlMenuTOuuXkUVpxS1qByrHOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220188
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

From: J. Neuschäfer <j.neuschaefer@9elements.com>

In the discussion of control flow through a function, "exit paths" were meant.

Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260520-exist-v1-1-535f929a87ae@9elements.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/style.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index b8edcf9316f..f4da16a0e83 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -469,7 +469,7 @@ for a time/space trade-off like ``tlb_mmu_resize_locked`` in the
 SoftMMU TLB code.
 
 If the lifetime of the allocation is within the function and there are
-multiple exist paths you can also improve the readability of the code
+multiple exit paths you can also improve the readability of the code
 by using ``g_autofree`` and related annotations. See :ref:`autofree-ref`
 for more details.
 
-- 
2.43.0


