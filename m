Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6996C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xm-0000BP-HT; Fri, 28 Aug 2026 18:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xk-0000As-EQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xj-0005kX-0L
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTLig4104959
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+fFw5NSa5Jr
 y1A3ONE01He2NOx9PK8QCb8F7sLo12sY=; b=ZovRW7S978CX/00w3dOhfTqQ7Wa
 B3s3B1ZF1ywugRk/1Nef3nkDYSeTzfn6FOSRFaeD+1xKUDUeHxRyss2DarE2cO9B
 B0Xw47+cwtP/da25MmvdL5IJhZh44wr1WTcDra80oceNik82ND4AjwsnAcKkR2U2
 hM0viQ89OE6wBVST7nk8hJMvzP3CLrIIuT+fLpa8vcvmuOgCdssBr6A0kyoCTj9j
 TTi44hL8pj2Pp/HLPua0+gjVMG9LJkB9kAo8269eBPj7lO4Cfryp0raVEcfrwWzD
 Kub+PLerPq/3EgOrJNV+Xqs253HPiFzJBt76PP15x1uGRz+kRQ6GSuO9RwA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3hs3xbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1b8088203so1905472a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957963; x=1788562763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+fFw5NSa5Jry1A3ONE01He2NOx9PK8QCb8F7sLo12sY=;
 b=WScN+0nI5KoG9ezZeJhbXgWQeHGel4FxCiF2CNexAKBGCslOyM/+rfkmqnZZaTBfFI
 jIkhIFfgFz4po+k2bxtv5IsXlwzZNe3YdKavtaE7a69nw7dyDOb5GOJGFAu2bmaEgkzs
 I4Gx/f5j2Nva1mh9IfCKAu4Tx1w2odyjPBqjgH34+u4+rWhQp+Fnzl0FAOVKNHHEY7WY
 s6q6ya9nEJe04ra49+ycnQ3z6j4xEE1KcEKad5w8EmvPPXk/COnE9F5Ba6mG81tI3VyD
 8voSbMudgCXj7DNfkyWp+NP8WWvzE3+H4eov3FA6jAb4HJh7U4N1La5awqQFCiJLZveg
 6G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957963; x=1788562763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+fFw5NSa5Jry1A3ONE01He2NOx9PK8QCb8F7sLo12sY=;
 b=Gc72SvcA/8CMS9j4bJak9g8EPwvYOzXHmsZWAPmD0UZPdbVEBvXEmn/OWPJ2Gju+M6
 741QiBum+U4euztBhD2E7npR3gH5PgfuorWmY6X1oddjh2rE8I3j8V9kKzzRnE8FKCnO
 vG5rIYn7XY8/5nT8KfIhu/IyDfRoSdluElkXhuFD6+lt5did5psAwrQsTe3EE9fttulK
 EB034dwd0DyBlyv6cmYDyqt0lhNhpudiv24dSOuXeIr7Enxx64tRg51Z9y+aBtNdAzrG
 lxFTdR1JNypI46whXNgCuQ3f3KD9GPlA8fB4xP4x0wIMF64SW5KtP+RryuyMj/ynE8Kv
 jyAg==
X-Gm-Message-State: AFuF++nLBP8z8Bz1o6Lr/9EnD21m5M0Io1k/aQ4GN9xukPj05Fm40Poa
 qDuSFSttmGe9CO6V0jf/pVqHmngvntQfLygyWH9taKoumuvOpyHDokSwJsPMNcl9ntRom/Jk8Yy
 CPMM/Bgvxa/EW4KdAdoQVPR7uiXr4UUjJA9i3ZytoT5YKq8c/XWmt9wKLTjLzxJm4Jg==
X-Gm-Gg: AR+sD100KFu0ci0ZKI/rjUVCtSUtboeROgPUhlNvMLvhX2s1tuTRC0gTVD8vGOakjs2
 z3iMzZJN5MP98HUGhtaQu4YYR+vojLGQmEMRVC7fLZLGiWRFa2EbfD8BvcuyaWnt4CItz5Gk7eT
 83BGYUcLUNGueOh6sCmxOd3cbko5BhLQ+5XV0KHtPabBqa/7/7oLaR6m4cZTPUSLAwPF8vzOuwb
 8/tOVdWB1FK0pjN3HfCZvvRaW5O5K2mh3Y4dLrYwdYP/cSP/8EXGhFr8TJrQle9jgOcZifIjwXy
 Y2iJwkQqLD86Wf21J0j0mIc6XtvSj0ReS14pnC8ndx7ZSuFeJlZ83vOTW3YCQ643Lh2IdkmVq/Q
 zPB24TAAYYTOa4HsVQqTEJbo7JEonAaWtLVVsZHcIihnqM4YibifYDbVrJnI=
X-Received: by 2002:a05:6a21:a8a:b0:3d3:ad3c:49a5 with SMTP id
 adf61e73a8af0-3d3ad3c6457mr5129109637.19.1787957963027; 
 Fri, 28 Aug 2026 15:59:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:a8a:b0:3d3:ad3c:49a5 with SMTP id
 adf61e73a8af0-3d3ad3c6457mr5129077637.19.1787957962628; 
 Fri, 28 Aug 2026 15:59:22 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 14/47] target-info: rename target-info-stub.c in
 target-info-def.c
Date: Fri, 28 Aug 2026 22:58:28 +0000
Message-ID: <20260828225901.367438-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XKYAjwhE c=1 sm=1 tr=0 ts=6a9212cb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=-IadAdOB_zlydFfnqDsA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX3JnAejrDap/M
 tSR3s+b0+/e0qz2NlbxbXfRTBK5ygvJh0nNA35B/E4GQdJIcKWM7+/8pp64ESt6cR2qBRUraGLD
 zMhVQGfsJkXguOXlVss+88SPceEAL5fq2nDtDJHlS32kh36jTMiUHOJJxiwX6wLOa46S71hsbdt
 QCVhfWtXpcFyZiEfYmGO0zTY6L5IdANvlL5UTri/Hi54Fk0ViKcrY6GQTnN6e8eLcXOG8eiINBj
 jZKWi1UWPYOIgze1vK1CTivNYA5vEnJJAisdUDk7r/E0BIejyBxM5/gRR/hhhhMS9ltMslzTBtn
 V3cfHCwGZhxfHS4l4gxacAWCo29Kh1IugtHm1A73ALFMW97lCEBhUJ8tnPGHDC9GCE6R4z4nLkZ
 32HOBsjdC0OJ0dlhBH3XhmA6OL0FdGnZwP+IkxU2cFuT6wQeKp5H2Jaki1kXsdVHTzEKbwySjYw
 iUyaEeQdTKc9Ye0wStw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX8F8cOtOoAinI
 QTQirb63H4f7PiIW8U4xnRzqm+PG+xTqOogoC2WsBhN8KdDEYGvMOwtKs9DFMusnjnsSEIqobrU
 vHIeYnxw0ts75SrsFo2nq8TIrXNUFIA=
X-Proofpoint-GUID: gZtmzwKeZbgCzr94fobAPq9xkc51J70u
X-Proofpoint-ORIG-GUID: gZtmzwKeZbgCzr94fobAPq9xkc51J70u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
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

Now it's the only file left to define target info, we call it def to
make the intent more clear.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build                             | 2 +-
 target-info-stub.c => target-info-def.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename target-info-stub.c => target-info-def.c (100%)

diff --git a/meson.build b/meson.build
index 93d495f09a0..5da6c15551e 100644
--- a/meson.build
+++ b/meson.build
@@ -4322,7 +4322,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-stub.c')
+  arch_srcs += files('target-info-def.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
diff --git a/target-info-stub.c b/target-info-def.c
similarity index 100%
rename from target-info-stub.c
rename to target-info-def.c
-- 
2.43.0


