Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD641CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrGn-0002tu-1W; Fri, 16 Oct 2026 19:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGl-0002tJ-JC
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGj-0001SJ-U4
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:23 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNF2no2782007
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nyijL/9ngcY
 7EnOtGo/DpcmJb6MH4wS1CkXEsJz5pfM=; b=eqdlzf9EnLoGiuYKt5gt5T/l2Jo
 n1L5q4wi93QTBBUF1bKOpYpGp90/+hIQnVHeHiwMiH4+acnluS9XE8Jru+8zFiI4
 Jj9DIrB5tAAtr7XhMcNoLG3bjS2w1dQOnqpBbG1cEiNcpdanfk4tNvN0PWSqx/tM
 QaMyOcC6z37ujcTtu3h1e7dTQcMy0pqw+zuhCBTQAvrZKeEYGz+O0+BR3tVFvy+2
 sSmhvf4Qx87PZovSfWcuauzJejhP+Put5DHHlDJ0/ioArhqMRzpWE6vxt8wfOth/
 RberYEA2Fq8r88AGy4MISjMM1hnceFAlbSnZmHHw7vRvsjTm9/hJcLFtShA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbk3v2f57-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a4a0017549so830251a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792193000; x=1792797800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nyijL/9ngcY7EnOtGo/DpcmJb6MH4wS1CkXEsJz5pfM=;
 b=ct+ty2iZ7Hg25ma+oziizRCnq9Wo6LQhEw428LNAjfi2Z9YhKRwFvVebrC6b/eymjm
 aN4XTj8U4SizFfZYpwsCMfOsRpH42OFs0oH0TO6VxTC214alT+bs/k87fr/Cj2PmLxMB
 wluYPtMIx0zF7rowEcWpT7jyUUdVtKQlbT66TS+w/V9necLFWbjytfCDhl6jHYnvY3vZ
 XQgeELa8MwA+i2HUc9zg3RhrJrFgJJPQMYrhvwaUhX1e4TayTezFGksfKGN3fHRiobr0
 6AMMAaWyw5QqLB9qgDajLXjZaavPgUewGPGqKq4ZHPLes3XrF3Wff03hyWDqdp7/1Smm
 vT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792193000; x=1792797800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nyijL/9ngcY7EnOtGo/DpcmJb6MH4wS1CkXEsJz5pfM=;
 b=J7u+XuWjygJhPCNGTyZczla0XgRflAFKsoIU/n55QKd5a/WY1/mDq4KxWvd+Nme1yj
 aT8qvaMZOR3+04enkaeIXO1AuMAcR70hK0gXklPlZg5tO+61UFlIzJVKu1aNJgILSTXm
 FsZrtbI/5919LCdyggHQjtX2y7YeOR3tp37wLb7Zto8zW3IbK4N5dG6zmFiKhKNHuYHg
 XsvoZqWxfhrAPQNp16bvOYsRIJ41+2Jt0D0CyNsiCgpuU9XN77EtenyKLi3TyzLU6pL4
 Cyz2/38kYUQzE04Dm+DUTCk7CsZWo178NSVJWBGXOU1RY6RdBHT2ZUVsnuDrZAUYWqh1
 +lmQ==
X-Gm-Message-State: AFq9FYKNRDLll4ZOQbPPtBeO4txg2M6VJAsP5c9MMhw7ZXAWpuBUqAcO
 08wz01o7ZkbQPGRIwoyzyE9OdLm8H8m0YghsAidYVjRCS+ueMMtz3DxFjDQIma9YcAa/qEY6MU0
 asYToHugZ5U3Fv22jW2BUC7kf5+x3mh7UWd2UoZvdmUkzOoWUGZHyfwot72cP/aRloQ==
X-Gm-Gg: AYBFou3IWLEcWrpuJ3uPryi9A08kHyeHtPm2mCXRIQl8n2s2mcpMGeeUKmfp/a4EYrS
 DkZzdnmuBD0xG0kFnFtMMJvY59HUsVSyI0yPegjZDhp26D70pDYPVeVyKLWMEbGlpM0jYxzxv48
 eDR0lI22d/6QjGMfDBROsRALPfqBnyN3ijGjPEZH6LwePFbWebV9vyc2P0k2anBPSc6/CvU73CN
 IK3o4boJLMv3GKE8qg7rvMT3uek8ImV7IpB3mH4mckpVXPf6aZAu1OUaiLWV6fjnTk1XJ5DkdoL
 RlgiddZE9J89TDXsZtJv5SxDdGcsD5tRHYGplYno5OaY+7t9mWYoV0A4nfBGbivV/czGR3riYmz
 5am/EEGweiXy/RCJeimFrC2FDiZO0H9NWiXI+jswIvdzZCNcJNtNgHNfm8zOP8qQ=
X-Received: by 2002:a17:90b:2646:b0:3ac:9d14:fe9f with SMTP id
 98e67ed59e1d1-3acef29e804mr1030783a91.31.1792192999604; 
 Fri, 16 Oct 2026 16:23:19 -0700 (PDT)
X-Received: by 2002:a17:90b:2646:b0:3ac:9d14:fe9f with SMTP id
 98e67ed59e1d1-3acef29e804mr1030771a91.31.1792192999087; 
 Fri, 16 Oct 2026 16:23:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd0cde4fdsm2829304a91.4.2026.10.16.16.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:23:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 7/9] target/riscv/tcg: restrict tcg-accel-riscv-cpu to
 riscv targets
Date: Fri, 16 Oct 2026 16:23:02 -0700
Message-ID: <20261016232304.1215119-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5J0eTU24Mqu-JjPNuX8owbU8v3D3uO44
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX05mbpmcl+K3U
 I7Fnimu9bSVRMZUBoPZ532mw2pQ5j4dCxeNDflr0q3sHZ6rXVQiMyKWl8fHA10YPsTriL66/3ul
 vI1PEpEkmzOR+egCQfUgjgQx5tiu6Uk=
X-Authority-Analysis: v=2.4 cv=BZdNQbt2 c=1 sm=1 tr=0 ts=6ad2b1e8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=DwCSbAth9W79kPmtiZMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfXx1LFgoe1KmWY
 lVDdPBEfJQeXn5ge4vTVcADWCkwrBnoRGILABCU4D8OIHd4XtFHR8PiTECY6Kx1oEuq7nSqJFS+
 GzDR4g2TnkfEoF7ZOYEKLz29NeyliC8l81OL1PRxJBeLjIQM2aY7GCeybfA7fiTappx5bPVhgEU
 mfuvj0BzPM1gnW1Q2MzMDcXXxA1rU/iYRqLVu8gSh6NXe2F7Ky7o+5Y5/O4skIXLvlCo60Orl42
 ZDGJsf6A16EtC/PiDRYn7OUVs2LqGLE/4kckAgTe8BqV9BMAAp5LgcYuq3sJaqjEHaLdwM81Pcs
 U+uuM7g1qfSj/42RpNWgyH6AD9ROeZmawknH+fhwWC4Ep1NfZKC4UUvjEamaIKisregtLBfCaIE
 9BRwxZi5G54iOcbpnXzf5YcN1gCXp6rYG9UEyxbRQihUtbGShD/gL1C2XYItzNUpwEwnn2JreAU
 tukfAEntgAvmoA4xMBg==
X-Proofpoint-ORIG-GUID: 5J0eTU24Mqu-JjPNuX8owbU8v3D3uO44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160093
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

$ ./build/tests/unit/test-multi-target
Type 'tcg-accel-riscv-cpu' is missing its parent 'accel-riscv-cpu'
Aborted

Parent type is conditionally registered from current target:
register_accel_target_type uses '"accel-" + target_cpu_type()' as type
name. Multi-target test takes the first target available, which is not
riscv in current state.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e07ca95e49b..be913602489 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1749,6 +1749,7 @@ static const TypeInfo riscv_tcg_cpu_accel_type_info = {
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = riscv_tcg_cpu_accel_class_init,
+    .is_available = target_base_riscv,
     .abstract = true,
 };
 
-- 
2.47.3


