Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF1BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgry8-0002dh-F0; Mon, 06 Jul 2026 18:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgry5-0002RI-Ey
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgry0-00075g-Jg
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:13 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE6fs1626343
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7VdRpS5kvYc
 KVSAP81iPZfhWmCHyIhRlX8PN5/nKmjA=; b=VCXzPhn6fiBPsqc5rS8ONwMqeVb
 cccbq91G7dmgL7DqRcfiHF6nHNcouDdeKbbdfNHe2qOTeFO9HCPPpCQacynEjSww
 ikS8Z/TYU9H7WlAsPGEuy4ggQVTsgfWK95YZeigbdQy7OOH/tlfaAzq6Bpm8sBIt
 rt8vRS1t3lnlgFDr8lATjKngZU71t61TMc3V3R+TS8j//3N8N+yNZ1stGRsqD9B/
 W5YoEuOksRcFRsIlc+rPBhIIduu5Z/9NEfGWHqmp1fTZU5JPfoRzUKbxSPbbOgyZ
 QUwXTrojopfbxnRSxHUcAtpcHFvyxPO2B0oQw2eeyX4DwjdJdtqsg2lHoLQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bnpx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so3025571a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377536; x=1783982336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VdRpS5kvYcKVSAP81iPZfhWmCHyIhRlX8PN5/nKmjA=;
 b=Ascdv4whYkQHPNziw+iT9u3wFFaB7tt+4IAoPkClTx2/1rVjQNzb2FWdy5597K4BLh
 reSpx1u+je4kjB2VZcKpZZUknmAMKxgBya+Og9n6WAsiyPlC8Rf31ZuEdZeesaGKT5dk
 1hfIiKOyVaYPoOp/DAqTWHcSSV8ZZd5CoRM3I4QSw9zFiDBJYgm1a1JIx1lDSZoJ6JgL
 Fu5MG6LSYStyMmSB1J3RO/cvIjDniZ0dA5nl5JdgNI9riJeeZswLY+wNoDDai0WkIBES
 9+QucrG3BcqvOyAoEYk+34RklbxYtTxGkTfYKxomz6Je/Ix+Wl78+bg9JXFCsIPVDbBR
 k90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377536; x=1783982336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7VdRpS5kvYcKVSAP81iPZfhWmCHyIhRlX8PN5/nKmjA=;
 b=ShYi0xk+IVbE8NZ6mEwY45Wi7eOYgN7xKsj0PWOjQZnj6AGWwClMHckH83TcrKTETF
 TMfZjtlrl3XUsPSodPE9X0HvWRzSN1peTWCTW/znQtEH1F7amNzhU1OzDG6g1hbenvnT
 +nNUsuDyqCmvQhLpEfwh/QM82wsl1HYQXGoT6vInIPWGOE20161AN/DWwSHSd36Im8cM
 +kPYb5sbvVpx1GhaayTXN1GL9rPNChQbtOUmxd4vzwL39ZPDK13If2NHQo0w0ucuU4/j
 QQMqFmYTuqN+26vNx4GHdMybYXZWj4PrtAGyHbAinemDTg2S+svUQGXry1Y68x+JoOZF
 lR/Q==
X-Gm-Message-State: AOJu0YyqWWs0KLQ63sJGxawz57d9gvAR7HevgCp2UmXQAmkNkZDVWCMr
 nhzmtYW1N7N3OXRFgjI5raygJEgRjeoSISpkN3cCK6rM7qpx/4suLYp6Tjl01caiBwh8SHwZm9p
 l30kOUMAEsObMEN1JcQFAU6jZN/ELmfWd50/gXNVUumkAdw6VTeMLCsGlhxRxjDHIrw==
X-Gm-Gg: AfdE7cmmJHYP7mcjSgSrl0T1ZnNKwGrEIrsats4tZ8dJ+mH3oPTYm/TjbE1cjSfSz3R
 FTjW8Ez1YpHFFMjht6GmNmqenCd/bD5Vzn9nxTkaxH0aLOxAUGEplR0YMfiLN7WkIGJQvQZiodX
 +M3tWTE2W25txrsQ+XkJcP+V6IaSuYoH8pDowsnPX6/e4UfwF8McW+1EXEgcDaLZGBvS/ARKpDx
 fUl5GYlVIdv/6QbJLc4SajeIWfl2yKm6r2QUk3svdRKv8x5asCxK+cGAE6JhDixlM5nKhEQ6Y6B
 WHpyYTrGrmVL+FLBNE415LtdMgBQnuu+0YSiPgU0IqG8+1TRXjHg4uh+CHwVMt5FvIctTaicFE1
 tcwcCSk4ZakNEAtQU/RicJV8wPbAqPCWsIo1FhEXd85KKDkHpLQohk6hm+PRJTtQXW8pAnKmS1l
 lCN2nUrw==
X-Received: by 2002:a05:6a20:d809:b0:3c0:9c19:65a0 with SMTP id
 adf61e73a8af0-3c09c196775mr95376637.72.1783377535721; 
 Mon, 06 Jul 2026 15:38:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:d809:b0:3c0:9c19:65a0 with SMTP id
 adf61e73a8af0-3c09c196775mr95330637.72.1783377535001; 
 Mon, 06 Jul 2026 15:38:55 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:54 -0700 (PDT)
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
Subject: [PATCH v3 65/91] tests/tcg/or1k: add float reference files
Date: Mon,  6 Jul 2026 15:33:17 -0700
Message-ID: <20260706223343.988769-66-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mdAL7-Qo9aqJkQH-bCaYvYUEDhRNjrhD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX7yBKZwVKl+oE
 CL431jWCUD6EQwV9q/d2ir0Dd29gxnQH9cugdm8ZA72a4hMZaBGlBguiRRpUCDWOJPFHyr2UIZf
 cnfUfBXWqppAEkxbDVcdy7fgv2U51Us=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX2i69Q09da1iJ
 OOf0ui22qNWyokZ+GyD5hTcyeJkRW6aQuxp3iFMJSjq/cnAWiHpvA6uHvFM0WPqa8CdRN6X6iq/
 lzkx4tq/92wR7VT9iy5xvKexY13bTtZ93fMyYAV9v1yeK7Qt/M7BQJyNucDnmMMKMTOUKdHLkW6
 O94TCqjTrwW7FxNjDZwtLiQoQUC3kEJk8XyEbT77kZ+9eG9D3oEgRgwUwfCxAk0RS5NCtH5Wxpf
 if34Ijt9GDiQ28/mBvSRBzLgVRhdFxvqykxA4MIaYIBXXP8axTVLMSjnsRjggmYUKjUIOlacxD4
 XXjT3H4D21VV0tCzDqvlewpLrwQqfyh/VewX8sj9si1A6bzT6QWAVXzGrclteFDyIMdGvgd7aTR
 zXg/UPvDjIL1jvx1P0B4BovxDmNhqgtVUHz/Jn5wb0m+wpXw7B9zHWp+n9wKJCMMxEjZoELAPtN
 Adk2UTy3cDBYVeQupQA==
X-Proofpoint-GUID: mdAL7-Qo9aqJkQH-bCaYvYUEDhRNjrhD
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2e81 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=V9lxR2G5ZHzp51wIZ6MA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/float_convd.ref | 247 +++++++++++++++++++++++++++++++++
 tests/tcg/or1k/float_convs.ref | 187 +++++++++++++++++++++++++
 tests/tcg/or1k/float_madds.ref | 192 +++++++++++++++++++++++++
 3 files changed, 626 insertions(+)
 create mode 100644 tests/tcg/or1k/float_convd.ref
 create mode 100644 tests/tcg/or1k/float_convs.ref
 create mode 100644 tests/tcg/or1k/float_madds.ref

diff --git a/tests/tcg/or1k/float_convd.ref b/tests/tcg/or1k/float_convd.ref
new file mode 100644
index 00000000000..dbd5379c4d3
--- /dev/null
+++ b/tests/tcg/or1k/float_convd.ref
@@ -0,0 +1,247 @@
+### Rounding to nearest
+from double: f64(nan:0x007ff4000000000000)
+  to single: f32(nan:0x7fe00000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(-nan:0x00fff8000000000000)
+  to single: f32(-nan:0xffc00000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-inf:0x00fff0000000000000)
+  to single: f32(-inf:0xff800000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.fffffffffffff0000000p+1023:0x00ffefffffffffffff)
+  to single: f32(-inf:0xff800000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
+  to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
+  to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.1874b135ff6540000000p+103:0x00c661874b135ff654)
+  to single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.c0bab523323b90000000p+99:0x00c62c0bab523323b9)
+  to single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.00000000000000000000p+1:0x00c000000000000000)
+  to single: f32(-0x1.00000000000000000000p+1:0xc0000000) (OK)
+   to int32: -2 (OK)
+   to int64: -2 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.00000000000000000000p+0:0x00bff0000000000000)
+  to single: f32(-0x1.00000000000000000000p+0:0xbf800000) (OK)
+   to int32: -1 (OK)
+   to int64: -1 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.00000000000000000000p-1022:0x008010000000000000)
+  to single: f32(-0x0.00000000000000000000p+0:0x80000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(-0x1.00000000000000000000p-126:0x00b810000000000000)
+  to single: f32(-0x1.00000000000000000000p-126:0x80800000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x0.00000000000000000000p+0:00000000000000000000)
+  to single: f32(0x0.00000000000000000000p+0:0000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.00000000000000000000p-126:0x003810000000000000)
+  to single: f32(0x1.00000000000000000000p-126:0x00800000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.00000001c5f680000000p-25:0x003e600000001c5f68)
+  to single: f32(0x1.00000000000000000000p-25:0x33000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.ffffe6cb2fa820000000p-25:0x003e6ffffe6cb2fa82)
+  to single: f32(0x1.ffffe600000000000000p-25:0x337ffff3) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.ff801a9af58a10000000p-15:0x003f0ff801a9af58a1)
+  to single: f32(0x1.ff801a00000000000000p-15:0x387fc00d) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.00000c06a1ef50000000p-14:0x003f100000c06a1ef5)
+  to single: f32(0x1.00000c00000000000000p-14:0x38800006) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.00000000000000000000p+0:0x003ff0000000000000)
+  to single: f32(0x1.00000000000000000000p+0:0x3f800000) (OK)
+   to int32: 1 (OK)
+   to int64: 1 (OK)
+  to uint32: 1 (OK)
+  to uint64: 1 (OK)
+from double: f64(0x1.00400000000000000000p+0:0x003ff0040000000000)
+  to single: f32(0x1.00400000000000000000p+0:0x3f802000) (OK)
+   to int32: 1 (OK)
+   to int64: 1 (OK)
+  to uint32: 1 (OK)
+  to uint64: 1 (OK)
+from double: f64(0x1.00000000000000000000p-1022:0x000010000000000000)
+  to single: f32(0x0.00000000000000000000p+0:0000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.3d5054450ed000000000p-1023:0x000009ea82a2287680)
+  to single: f32(0x0.00000000000000000000p+0:0000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.5731f750864200000000p-1023:0x00000ab98fba843210)
+  to single: f32(0x0.00000000000000000000p+0:0000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from double: f64(0x1.00000000000000000000p+0:0x003ff0000000000000)
+  to single: f32(0x1.00000000000000000000p+0:0x3f800000) (OK)
+   to int32: 1 (OK)
+   to int64: 1 (OK)
+  to uint32: 1 (OK)
+  to uint64: 1 (OK)
+from double: f64(0x1.00000000000000000000p+1:0x004000000000000000)
+  to single: f32(0x1.00000000000000000000p+1:0x40000000) (OK)
+   to int32: 2 (OK)
+   to int64: 2 (OK)
+  to uint32: 2 (OK)
+  to uint64: 2 (OK)
+from double: f64(0x1.5bf0a8b1457690000000p+1:0x004005bf0a8b145769)
+  to single: f32(0x1.5bf0a800000000000000p+1:0x402df854) (OK)
+   to int32: 2 (OK)
+   to int64: 2 (OK)
+  to uint32: 2 (OK)
+  to uint64: 2 (OK)
+from double: f64(0x1.921fb54442d180000000p+1:0x00400921fb54442d18)
+  to single: f32(0x1.921fb600000000000000p+1:0x40490fdb) (OK)
+   to int32: 3 (OK)
+   to int64: 3 (OK)
+  to uint32: 3 (OK)
+  to uint64: 3 (OK)
+from double: f64(0x1.ffbe0000000000000000p+15:0x0040effbe000000000)
+  to single: f32(0x1.ffbe0000000000000000p+15:0x477fdf00) (OK)
+   to int32: 65503 (OK)
+   to int64: 65503 (OK)
+  to uint32: 65503 (OK)
+  to uint64: 65503 (OK)
+from double: f64(0x1.ffc00000000000000000p+15:0x0040effc0000000000)
+  to single: f32(0x1.ffc00000000000000000p+15:0x477fe000) (OK)
+   to int32: 65504 (OK)
+   to int64: 65504 (OK)
+  to uint32: 65504 (OK)
+  to uint64: 65504 (OK)
+from double: f64(0x1.ffc20000000000000000p+15:0x0040effc2000000000)
+  to single: f32(0x1.ffc20000000000000000p+15:0x477fe100) (OK)
+   to int32: 65505 (OK)
+   to int64: 65505 (OK)
+  to uint32: 65505 (OK)
+  to uint64: 65505 (OK)
+from double: f64(0x1.ffbf0000000000000000p+16:0x0040fffbf000000000)
+  to single: f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) (OK)
+   to int32: 131007 (OK)
+   to int64: 131007 (OK)
+  to uint32: 131007 (OK)
+  to uint64: 131007 (OK)
+from double: f64(0x1.ffc00000000000000000p+16:0x0040fffc0000000000)
+  to single: f32(0x1.ffc00000000000000000p+16:0x47ffe000) (OK)
+   to int32: 131008 (OK)
+   to int64: 131008 (OK)
+  to uint32: 131008 (OK)
+  to uint64: 131008 (OK)
+from double: f64(0x1.ffc10000000000000000p+16:0x0040fffc1000000000)
+  to single: f32(0x1.ffc10000000000000000p+16:0x47ffe080) (OK)
+   to int32: 131009 (OK)
+   to int64: 131009 (OK)
+  to uint32: 131009 (OK)
+  to uint64: 131009 (OK)
+from double: f64(0x1.fffffffc000000000000p+30:0x0041dfffffffc00000)
+  to single: f32(0x1.00000000000000000000p+31:0x4f000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 2147483647 (OK)
+  to uint32: 2147483647 (OK)
+  to uint64: 2147483647 (OK)
+from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
+  to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
+  to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(0x1.fffffffffffff0000000p+1023:0x007fefffffffffffff)
+  to single: f32(inf:0x7f800000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(inf:0x007ff0000000000000)
+  to single: f32(inf:0x7f800000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(nan:0x007ff8000000000000)
+  to single: f32(nan:0x7fc00000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(nan:0x007ff0000000000001)
+  to single: f32(nan:0x7fc00000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from double: f64(nan:0x007ff4000000000000)
+  to single: f32(nan:0x7fe00000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
diff --git a/tests/tcg/or1k/float_convs.ref b/tests/tcg/or1k/float_convs.ref
new file mode 100644
index 00000000000..ec7fdf975b1
--- /dev/null
+++ b/tests/tcg/or1k/float_convs.ref
@@ -0,0 +1,187 @@
+### Rounding to nearest
+from single: f32(-nan:0xffa00000)
+  to double: f64(-nan:0x00fffc000000000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-nan:0xffc00000)
+  to double: f64(-nan:0x00fff8000000000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-inf:0xff800000)
+  to double: f64(-inf:0x00fff0000000000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
+  to double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
+  to double: f64(-0x1.1874b200000000000000p+103:0x00c661874b20000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
+  to double: f64(-0x1.c0bab600000000000000p+99:0x00c62c0bab60000000) (OK)
+   to int32: -2147483648 (OK)
+   to int64: -9223372036854775808 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.31f75000000000000000p-40:0xab98fba8)
+  to double: f64(-0x1.31f75000000000000000p-40:0x00bd731f7500000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.50544400000000000000p-66:0x9ea82a22)
+  to double: f64(-0x1.50544400000000000000p-66:0x00bbd5054440000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(-0x1.00000000000000000000p-126:0x80800000)
+  to double: f64(-0x1.00000000000000000000p-126:0x00b810000000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x0.00000000000000000000p+0:0000000000)
+  to double: f64(0x0.00000000000000000000p+0:00000000000000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.00000000000000000000p-126:0x00800000)
+  to double: f64(0x1.00000000000000000000p-126:0x003810000000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.00000000000000000000p-25:0x33000000)
+  to double: f64(0x1.00000000000000000000p-25:0x003e60000000000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.ffffe600000000000000p-25:0x337ffff3)
+  to double: f64(0x1.ffffe600000000000000p-25:0x003e6ffffe60000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.ff801a00000000000000p-15:0x387fc00d)
+  to double: f64(0x1.ff801a00000000000000p-15:0x003f0ff801a0000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.00000c00000000000000p-14:0x38800006)
+  to double: f64(0x1.00000c00000000000000p-14:0x003f100000c0000000) (OK)
+   to int32: 0 (OK)
+   to int64: 0 (OK)
+  to uint32: 0 (OK)
+  to uint64: 0 (OK)
+from single: f32(0x1.00000000000000000000p+0:0x3f800000)
+  to double: f64(0x1.00000000000000000000p+0:0x003ff0000000000000) (OK)
+   to int32: 1 (OK)
+   to int64: 1 (OK)
+  to uint32: 1 (OK)
+  to uint64: 1 (OK)
+from single: f32(0x1.00400000000000000000p+0:0x3f802000)
+  to double: f64(0x1.00400000000000000000p+0:0x003ff0040000000000) (OK)
+   to int32: 1 (OK)
+   to int64: 1 (OK)
+  to uint32: 1 (OK)
+  to uint64: 1 (OK)
+from single: f32(0x1.00000000000000000000p+1:0x40000000)
+  to double: f64(0x1.00000000000000000000p+1:0x004000000000000000) (OK)
+   to int32: 2 (OK)
+   to int64: 2 (OK)
+  to uint32: 2 (OK)
+  to uint64: 2 (OK)
+from single: f32(0x1.5bf0a800000000000000p+1:0x402df854)
+  to double: f64(0x1.5bf0a800000000000000p+1:0x004005bf0a80000000) (OK)
+   to int32: 2 (OK)
+   to int64: 2 (OK)
+  to uint32: 2 (OK)
+  to uint64: 2 (OK)
+from single: f32(0x1.921fb600000000000000p+1:0x40490fdb)
+  to double: f64(0x1.921fb600000000000000p+1:0x00400921fb60000000) (OK)
+   to int32: 3 (OK)
+   to int64: 3 (OK)
+  to uint32: 3 (OK)
+  to uint64: 3 (OK)
+from single: f32(0x1.ffbe0000000000000000p+15:0x477fdf00)
+  to double: f64(0x1.ffbe0000000000000000p+15:0x0040effbe000000000) (OK)
+   to int32: 65503 (OK)
+   to int64: 65503 (OK)
+  to uint32: 65503 (OK)
+  to uint64: 65503 (OK)
+from single: f32(0x1.ffc00000000000000000p+15:0x477fe000)
+  to double: f64(0x1.ffc00000000000000000p+15:0x0040effc0000000000) (OK)
+   to int32: 65504 (OK)
+   to int64: 65504 (OK)
+  to uint32: 65504 (OK)
+  to uint64: 65504 (OK)
+from single: f32(0x1.ffc20000000000000000p+15:0x477fe100)
+  to double: f64(0x1.ffc20000000000000000p+15:0x0040effc2000000000) (OK)
+   to int32: 65505 (OK)
+   to int64: 65505 (OK)
+  to uint32: 65505 (OK)
+  to uint64: 65505 (OK)
+from single: f32(0x1.ffbf0000000000000000p+16:0x47ffdf80)
+  to double: f64(0x1.ffbf0000000000000000p+16:0x0040fffbf000000000) (OK)
+   to int32: 131007 (OK)
+   to int64: 131007 (OK)
+  to uint32: 131007 (OK)
+  to uint64: 131007 (OK)
+from single: f32(0x1.ffc00000000000000000p+16:0x47ffe000)
+  to double: f64(0x1.ffc00000000000000000p+16:0x0040fffc0000000000) (OK)
+   to int32: 131008 (OK)
+   to int64: 131008 (OK)
+  to uint32: 131008 (OK)
+  to uint64: 131008 (OK)
+from single: f32(0x1.ffc10000000000000000p+16:0x47ffe080)
+  to double: f64(0x1.ffc10000000000000000p+16:0x0040fffc1000000000) (OK)
+   to int32: 131009 (OK)
+   to int64: 131009 (OK)
+  to uint32: 131009 (OK)
+  to uint64: 131009 (OK)
+from single: f32(0x1.c0bab600000000000000p+99:0x71605d5b)
+  to double: f64(0x1.c0bab600000000000000p+99:0x00462c0bab60000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
+  to double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from single: f32(inf:0x7f800000)
+  to double: f64(inf:0x007ff0000000000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from single: f32(nan:0x7fc00000)
+  to double: f64(nan:0x007ff8000000000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
+from single: f32(nan:0x7fa00000)
+  to double: f64(nan:0x007ffc000000000000) (OK)
+   to int32: 2147483647 (OK)
+   to int64: 9223372036854775807 (OK)
+  to uint32: -1 (OK)
+  to uint64: -1 (OK)
diff --git a/tests/tcg/or1k/float_madds.ref b/tests/tcg/or1k/float_madds.ref
new file mode 100644
index 00000000000..2c7c35c8b47
--- /dev/null
+++ b/tests/tcg/or1k/float_madds.ref
@@ -0,0 +1,192 @@
+### Rounding to nearest
+op : f32(-nan:0xffa00000) * f32(-nan:0xffc00000) + f32(-inf:0xff800000)
+res: f32(-nan:0xffe00000) flags=OK (0/0)
+op : f32(-nan:0xffc00000) * f32(-inf:0xff800000) + f32(-nan:0xffa00000)
+res: f32(-nan:0xffe00000) flags=OK (0/1)
+op : f32(-inf:0xff800000) * f32(-nan:0xffa00000) + f32(-nan:0xffc00000)
+res: f32(-nan:0xffc00000) flags=OK (0/2)
+op : f32(-nan:0xffc00000) * f32(-inf:0xff800000) + f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
+res: f32(-nan:0xffc00000) flags=OK (1/0)
+op : f32(-inf:0xff800000) * f32(-0x1.fffffe00000000000000p+127:0xff7fffff) + f32(-nan:0xffc00000)
+res: f32(-nan:0xffc00000) flags=OK (1/1)
+op : f32(-0x1.fffffe00000000000000p+127:0xff7fffff) * f32(-nan:0xffc00000) + f32(-inf:0xff800000)
+res: f32(-nan:0xffc00000) flags=OK (1/2)
+op : f32(-inf:0xff800000) * f32(-0x1.fffffe00000000000000p+127:0xff7fffff) + f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
+res: f32(inf:0x7f800000) flags=OK (2/0)
+op : f32(-0x1.fffffe00000000000000p+127:0xff7fffff) * f32(-0x1.1874b200000000000000p+103:0xf30c3a59) + f32(-inf:0xff800000)
+res: f32(-inf:0xff800000) flags=OK (2/1)
+op : f32(-0x1.1874b200000000000000p+103:0xf30c3a59) * f32(-inf:0xff800000) + f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
+res: f32(inf:0x7f800000) flags=OK (2/2)
+op : f32(-0x1.fffffe00000000000000p+127:0xff7fffff) * f32(-0x1.1874b200000000000000p+103:0xf30c3a59) + f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
+res: f32(inf:0x7f800000) flags=OK (3/0)
+op : f32(-0x1.1874b200000000000000p+103:0xf30c3a59) * f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) + f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
+res: f32(inf:0x7f800000) flags=OK (3/1)
+op : f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) * f32(-0x1.fffffe00000000000000p+127:0xff7fffff) + f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
+res: f32(inf:0x7f800000) flags=OK (3/2)
+op : f32(-0x1.1874b200000000000000p+103:0xf30c3a59) * f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) + f32(-0x1.31f75000000000000000p-40:0xab98fba8)
+res: f32(inf:0x7f800000) flags=OK (4/0)
+op : f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) * f32(-0x1.31f75000000000000000p-40:0xab98fba8) + f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
+res: f32(-0x1.1874b200000000000000p+103:0xf30c3a59) flags=OK (4/1)
+op : f32(-0x1.31f75000000000000000p-40:0xab98fba8) * f32(-0x1.1874b200000000000000p+103:0xf30c3a59) + f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
+res: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) flags=OK (4/2)
+op : f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) * f32(-0x1.31f75000000000000000p-40:0xab98fba8) + f32(-0x1.50544400000000000000p-66:0x9ea82a22)
+res: f32(0x1.0c27fa00000000000000p+60:0x5d8613fd) flags=OK (5/0)
+op : f32(-0x1.31f75000000000000000p-40:0xab98fba8) * f32(-0x1.50544400000000000000p-66:0x9ea82a22) + f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
+res: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) flags=OK (5/1)
+op : f32(-0x1.50544400000000000000p-66:0x9ea82a22) * f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) + f32(-0x1.31f75000000000000000p-40:0xab98fba8)
+res: f32(0x1.26c46200000000000000p+34:0x50936231) flags=OK (5/2)
+op : f32(-0x1.31f75000000000000000p-40:0xab98fba8) * f32(-0x1.50544400000000000000p-66:0x9ea82a22) + f32(-0x1.00000000000000000000p-126:0x80800000)
+res: f32(0x1.91f94000000000000000p-106:0x0ac8fca0) flags=OK (6/0)
+op : f32(-0x1.50544400000000000000p-66:0x9ea82a22) * f32(-0x1.00000000000000000000p-126:0x80800000) + f32(-0x1.31f75000000000000000p-40:0xab98fba8)
+res: f32(-0x1.31f75000000000000000p-40:0xab98fba8) flags=OK (6/1)
+op : f32(-0x1.00000000000000000000p-126:0x80800000) * f32(-0x1.31f75000000000000000p-40:0xab98fba8) + f32(-0x1.50544400000000000000p-66:0x9ea82a22)
+res: f32(-0x1.50544400000000000000p-66:0x9ea82a22) flags=OK (6/2)
+op : f32(-0x1.50544400000000000000p-66:0x9ea82a22) * f32(-0x1.00000000000000000000p-126:0x80800000) + f32(0x0.00000000000000000000p+0:0000000000)
+res: f32(0x0.00000000000000000000p+0:0000000000) flags=OK (7/0)
+op : f32(-0x1.00000000000000000000p-126:0x80800000) * f32(0x0.00000000000000000000p+0:0000000000) + f32(-0x1.50544400000000000000p-66:0x9ea82a22)
+res: f32(-0x1.50544400000000000000p-66:0x9ea82a22) flags=OK (7/1)
+op : f32(0x0.00000000000000000000p+0:0000000000) * f32(-0x1.50544400000000000000p-66:0x9ea82a22) + f32(-0x1.00000000000000000000p-126:0x80800000)
+res: f32(-0x1.00000000000000000000p-126:0x80800000) flags=OK (7/2)
+op : f32(-0x1.00000000000000000000p-126:0x80800000) * f32(0x0.00000000000000000000p+0:0000000000) + f32(0x1.00000000000000000000p-126:0x00800000)
+res: f32(0x1.00000000000000000000p-126:0x00800000) flags=OK (8/0)
+op : f32(0x0.00000000000000000000p+0:0000000000) * f32(0x1.00000000000000000000p-126:0x00800000) + f32(-0x1.00000000000000000000p-126:0x80800000)
+res: f32(-0x1.00000000000000000000p-126:0x80800000) flags=OK (8/1)
+op : f32(0x1.00000000000000000000p-126:0x00800000) * f32(-0x1.00000000000000000000p-126:0x80800000) + f32(0x0.00000000000000000000p+0:0000000000)
+res: f32(-0x0.00000000000000000000p+0:0x80000000) flags=OK (8/2)
+op : f32(0x0.00000000000000000000p+0:0000000000) * f32(0x1.00000000000000000000p-126:0x00800000) + f32(0x1.00000000000000000000p-25:0x33000000)
+res: f32(0x1.00000000000000000000p-25:0x33000000) flags=OK (9/0)
+op : f32(0x1.00000000000000000000p-126:0x00800000) * f32(0x1.00000000000000000000p-25:0x33000000) + f32(0x0.00000000000000000000p+0:0000000000)
+res: f32(0x0.00000000000000000000p+0:0000000000) flags=OK (9/1)
+op : f32(0x1.00000000000000000000p-25:0x33000000) * f32(0x0.00000000000000000000p+0:0000000000) + f32(0x1.00000000000000000000p-126:0x00800000)
+res: f32(0x1.00000000000000000000p-126:0x00800000) flags=OK (9/2)
+op : f32(0x1.00000000000000000000p-126:0x00800000) * f32(0x1.00000000000000000000p-25:0x33000000) + f32(0x1.ffffe600000000000000p-25:0x337ffff3)
+res: f32(0x1.ffffe600000000000000p-25:0x337ffff3) flags=OK (10/0)
+op : f32(0x1.00000000000000000000p-25:0x33000000) * f32(0x1.ffffe600000000000000p-25:0x337ffff3) + f32(0x1.00000000000000000000p-126:0x00800000)
+res: f32(0x1.ffffe600000000000000p-50:0x26fffff3) flags=OK (10/1)
+op : f32(0x1.ffffe600000000000000p-25:0x337ffff3) * f32(0x1.00000000000000000000p-126:0x00800000) + f32(0x1.00000000000000000000p-25:0x33000000)
+res: f32(0x1.00000000000000000000p-25:0x33000000) flags=OK (10/2)
+op : f32(0x1.00000000000000000000p-25:0x33000000) * f32(0x1.ffffe600000000000000p-25:0x337ffff3) + f32(0x1.ff801a00000000000000p-15:0x387fc00d)
+res: f32(0x1.ff801a00000000000000p-15:0x387fc00d) flags=OK (11/0)
+op : f32(0x1.ffffe600000000000000p-25:0x337ffff3) * f32(0x1.ff801a00000000000000p-15:0x387fc00d) + f32(0x1.00000000000000000000p-25:0x33000000)
+res: f32(0x1.0007fe00000000000000p-25:0x330003ff) flags=OK (11/1)
+op : f32(0x1.ff801a00000000000000p-15:0x387fc00d) * f32(0x1.00000000000000000000p-25:0x33000000) + f32(0x1.ffffe600000000000000p-25:0x337ffff3)
+res: f32(0x1.0001f200000000000000p-24:0x338000f9) flags=OK (11/2)
+op : f32(0x1.ffffe600000000000000p-25:0x337ffff3) * f32(0x1.ff801a00000000000000p-15:0x387fc00d) + f32(0x1.00000c00000000000000p-14:0x38800006)
+res: f32(0x1.00000c00000000000000p-14:0x38800006) flags=OK (12/0)
+op : f32(0x1.ff801a00000000000000p-15:0x387fc00d) * f32(0x1.00000c00000000000000p-14:0x38800006) + f32(0x1.ffffe600000000000000p-25:0x337ffff3)
+res: f32(0x1.0ffbf400000000000000p-24:0x3387fdfa) flags=OK (12/1)
+op : f32(0x1.00000c00000000000000p-14:0x38800006) * f32(0x1.ffffe600000000000000p-25:0x337ffff3) + f32(0x1.ff801a00000000000000p-15:0x387fc00d)
+res: f32(0x1.ff801c00000000000000p-15:0x387fc00e) flags=OK (12/2)
+op : f32(0x1.ff801a00000000000000p-15:0x387fc00d) * f32(0x1.00000c00000000000000p-14:0x38800006) + f32(0x1.00000000000000000000p+0:0x3f800000)
+res: f32(0x1.00000000000000000000p+0:0x3f800000) flags=OK (13/0)
+op : f32(0x1.00000c00000000000000p-14:0x38800006) * f32(0x1.00000000000000000000p+0:0x3f800000) + f32(0x1.ff801a00000000000000p-15:0x387fc00d)
+res: f32(0x1.ffc01800000000000000p-14:0x38ffe00c) flags=OK (13/1)
+op : f32(0x1.00000000000000000000p+0:0x3f800000) * f32(0x1.ff801a00000000000000p-15:0x387fc00d) + f32(0x1.00000c00000000000000p-14:0x38800006)
+res: f32(0x1.ffc01800000000000000p-14:0x38ffe00c) flags=OK (13/2)
+op : f32(0x1.00000c00000000000000p-14:0x38800006) * f32(0x1.00000000000000000000p+0:0x3f800000) + f32(0x1.00400000000000000000p+0:0x3f802000)
+res: f32(0x1.00440000000000000000p+0:0x3f802200) flags=OK (14/0)
+op : f32(0x1.00000000000000000000p+0:0x3f800000) * f32(0x1.00400000000000000000p+0:0x3f802000) + f32(0x1.00000c00000000000000p-14:0x38800006)
+res: f32(0x1.00440000000000000000p+0:0x3f802200) flags=OK (14/1)
+op : f32(0x1.00400000000000000000p+0:0x3f802000) * f32(0x1.00000c00000000000000p-14:0x38800006) + f32(0x1.00000000000000000000p+0:0x3f800000)
+res: f32(0x1.00040200000000000000p+0:0x3f800201) flags=OK (14/2)
+op : f32(0x1.00000000000000000000p+0:0x3f800000) * f32(0x1.00400000000000000000p+0:0x3f802000) + f32(0x1.00000000000000000000p+1:0x40000000)
+res: f32(0x1.80200000000000000000p+1:0x40401000) flags=OK (15/0)
+op : f32(0x1.00400000000000000000p+0:0x3f802000) * f32(0x1.00000000000000000000p+1:0x40000000) + f32(0x1.00000000000000000000p+0:0x3f800000)
+res: f32(0x1.80400000000000000000p+1:0x40402000) flags=OK (15/1)
+op : f32(0x1.00000000000000000000p+1:0x40000000) * f32(0x1.00000000000000000000p+0:0x3f800000) + f32(0x1.00400000000000000000p+0:0x3f802000)
+res: f32(0x1.80200000000000000000p+1:0x40401000) flags=OK (15/2)
+op : f32(0x1.00400000000000000000p+0:0x3f802000) * f32(0x1.00000000000000000000p+1:0x40000000) + f32(0x1.5bf0a800000000000000p+1:0x402df854)
+res: f32(0x1.2e185400000000000000p+2:0x40970c2a) flags=OK (16/0)
+op : f32(0x1.00000000000000000000p+1:0x40000000) * f32(0x1.5bf0a800000000000000p+1:0x402df854) + f32(0x1.00400000000000000000p+0:0x3f802000)
+res: f32(0x1.9c00a800000000000000p+2:0x40ce0054) flags=OK (16/1)
+op : f32(0x1.5bf0a800000000000000p+1:0x402df854) * f32(0x1.00400000000000000000p+0:0x3f802000) + f32(0x1.00000000000000000000p+1:0x40000000)
+res: f32(0x1.2e23d200000000000000p+2:0x409711e9) flags=OK (16/2)
+op : f32(0x1.00000000000000000000p+1:0x40000000) * f32(0x1.5bf0a800000000000000p+1:0x402df854) + f32(0x1.921fb600000000000000p+1:0x40490fdb)
+res: f32(0x1.12804200000000000000p+3:0x41094021) flags=OK (17/0)
+op : f32(0x1.5bf0a800000000000000p+1:0x402df854) * f32(0x1.921fb600000000000000p+1:0x40490fdb) + f32(0x1.00000000000000000000p+1:0x40000000)
+res: f32(0x1.51458000000000000000p+3:0x4128a2c0) flags=OK (17/1)
+op : f32(0x1.921fb600000000000000p+1:0x40490fdb) * f32(0x1.00000000000000000000p+1:0x40000000) + f32(0x1.5bf0a800000000000000p+1:0x402df854)
+res: f32(0x1.200c0400000000000000p+3:0x41100602) flags=OK (17/2)
+op : f32(0x1.5bf0a800000000000000p+1:0x402df854) * f32(0x1.921fb600000000000000p+1:0x40490fdb) + f32(0x1.ffbe0000000000000000p+15:0x477fdf00)
+res: f32(0x1.ffcf1400000000000000p+15:0x477fe78a) flags=OK (18/0)
+op : f32(0x1.921fb600000000000000p+1:0x40490fdb) * f32(0x1.ffbe0000000000000000p+15:0x477fdf00) + f32(0x1.5bf0a800000000000000p+1:0x402df854)
+res: f32(0x1.91ed3c00000000000000p+17:0x4848f69e) flags=OK (18/1)
+op : f32(0x1.ffbe0000000000000000p+15:0x477fdf00) * f32(0x1.5bf0a800000000000000p+1:0x402df854) + f32(0x1.921fb600000000000000p+1:0x40490fdb)
+res: f32(0x1.5bc56000000000000000p+17:0x482de2b0) flags=OK (18/2)
+op : f32(0x1.921fb600000000000000p+1:0x40490fdb) * f32(0x1.ffbe0000000000000000p+15:0x477fdf00) + f32(0x1.ffc00000000000000000p+15:0x477fe000)
+res: f32(0x1.08edf000000000000000p+18:0x488476f8) flags=OK (19/0)
+op : f32(0x1.ffbe0000000000000000p+15:0x477fdf00) * f32(0x1.ffc00000000000000000p+15:0x477fe000) + f32(0x1.921fb600000000000000p+1:0x40490fdb)
+res: f32(0x1.ff7e0800000000000000p+31:0x4f7fbf04) flags=OK (19/1)
+op : f32(0x1.ffc00000000000000000p+15:0x477fe000) * f32(0x1.921fb600000000000000p+1:0x40490fdb) + f32(0x1.ffbe0000000000000000p+15:0x477fdf00)
+res: f32(0x1.08ee7a00000000000000p+18:0x4884773d) flags=OK (19/2)
+op : f32(0x1.ffbe0000000000000000p+15:0x477fdf00) * f32(0x1.ffc00000000000000000p+15:0x477fe000) + f32(0x1.ffc20000000000000000p+15:0x477fe100)
+res: f32(0x1.ff800800000000000000p+31:0x4f7fc004) flags=OK (20/0)
+op : f32(0x1.ffc00000000000000000p+15:0x477fe000) * f32(0x1.ffc20000000000000000p+15:0x477fe100) + f32(0x1.ffbe0000000000000000p+15:0x477fdf00)
+res: f32(0x1.ff840800000000000000p+31:0x4f7fc204) flags=OK (20/1)
+op : f32(0x1.ffc20000000000000000p+15:0x477fe100) * f32(0x1.ffbe0000000000000000p+15:0x477fdf00) + f32(0x1.ffc00000000000000000p+15:0x477fe000)
+res: f32(0x1.ff820800000000000000p+31:0x4f7fc104) flags=OK (20/2)
+op : f32(0x1.ffc00000000000000000p+15:0x477fe000) * f32(0x1.ffc20000000000000000p+15:0x477fe100) + f32(0x1.ffbf0000000000000000p+16:0x47ffdf80)
+res: f32(0x1.ff860800000000000000p+31:0x4f7fc304) flags=OK (21/0)
+op : f32(0x1.ffc20000000000000000p+15:0x477fe100) * f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) + f32(0x1.ffc00000000000000000p+15:0x477fe000)
+res: f32(0x1.ff820800000000000000p+32:0x4fffc104) flags=OK (21/1)
+op : f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) * f32(0x1.ffc00000000000000000p+15:0x477fe000) + f32(0x1.ffc20000000000000000p+15:0x477fe100)
+res: f32(0x1.ff800800000000000000p+32:0x4fffc004) flags=OK (21/2)
+op : f32(0x1.ffc20000000000000000p+15:0x477fe100) * f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) + f32(0x1.ffc00000000000000000p+16:0x47ffe000)
+res: f32(0x1.ff830800000000000000p+32:0x4fffc184) flags=OK (22/0)
+op : f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) * f32(0x1.ffc00000000000000000p+16:0x47ffe000) + f32(0x1.ffc20000000000000000p+15:0x477fe100)
+res: f32(0x1.ff7f8800000000000000p+33:0x507fbfc4) flags=OK (22/1)
+op : f32(0x1.ffc00000000000000000p+16:0x47ffe000) * f32(0x1.ffc20000000000000000p+15:0x477fe100) + f32(0x1.ffbf0000000000000000p+16:0x47ffdf80)
+res: f32(0x1.ff840800000000000000p+32:0x4fffc204) flags=OK (22/2)
+op : f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) * f32(0x1.ffc00000000000000000p+16:0x47ffe000) + f32(0x1.ffc10000000000000000p+16:0x47ffe080)
+res: f32(0x1.ff800800000000000000p+33:0x507fc004) flags=OK (23/0)
+op : f32(0x1.ffc00000000000000000p+16:0x47ffe000) * f32(0x1.ffc10000000000000000p+16:0x47ffe080) + f32(0x1.ffbf0000000000000000p+16:0x47ffdf80)
+res: f32(0x1.ff820800000000000000p+33:0x507fc104) flags=OK (23/1)
+op : f32(0x1.ffc10000000000000000p+16:0x47ffe080) * f32(0x1.ffbf0000000000000000p+16:0x47ffdf80) + f32(0x1.ffc00000000000000000p+16:0x47ffe000)
+res: f32(0x1.ff810800000000000000p+33:0x507fc084) flags=OK (23/2)
+op : f32(0x1.ffc00000000000000000p+16:0x47ffe000) * f32(0x1.ffc10000000000000000p+16:0x47ffe080) + f32(0x1.c0bab600000000000000p+99:0x71605d5b)
+res: f32(0x1.c0bab600000000000000p+99:0x71605d5b) flags=OK (24/0)
+op : f32(0x1.ffc10000000000000000p+16:0x47ffe080) * f32(0x1.c0bab600000000000000p+99:0x71605d5b) + f32(0x1.ffc00000000000000000p+16:0x47ffe000)
+res: f32(0x1.c0838000000000000000p+116:0x79e041c0) flags=OK (24/1)
+op : f32(0x1.c0bab600000000000000p+99:0x71605d5b) * f32(0x1.ffc00000000000000000p+16:0x47ffe000) + f32(0x1.ffc10000000000000000p+16:0x47ffe080)
+res: f32(0x1.c0829e00000000000000p+116:0x79e0414f) flags=OK (24/2)
+op : f32(0x1.ffc10000000000000000p+16:0x47ffe080) * f32(0x1.c0bab600000000000000p+99:0x71605d5b) + f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
+res: f32(inf:0x7f800000) flags=OK (25/0)
+op : f32(0x1.c0bab600000000000000p+99:0x71605d5b) * f32(0x1.fffffe00000000000000p+127:0x7f7fffff) + f32(0x1.ffc10000000000000000p+16:0x47ffe080)
+res: f32(inf:0x7f800000) flags=OK (25/1)
+op : f32(0x1.fffffe00000000000000p+127:0x7f7fffff) * f32(0x1.ffc10000000000000000p+16:0x47ffe080) + f32(0x1.c0bab600000000000000p+99:0x71605d5b)
+res: f32(inf:0x7f800000) flags=OK (25/2)
+op : f32(0x1.c0bab600000000000000p+99:0x71605d5b) * f32(0x1.fffffe00000000000000p+127:0x7f7fffff) + f32(inf:0x7f800000)
+res: f32(inf:0x7f800000) flags=OK (26/0)
+op : f32(0x1.fffffe00000000000000p+127:0x7f7fffff) * f32(inf:0x7f800000) + f32(0x1.c0bab600000000000000p+99:0x71605d5b)
+res: f32(inf:0x7f800000) flags=OK (26/1)
+op : f32(inf:0x7f800000) * f32(0x1.c0bab600000000000000p+99:0x71605d5b) + f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
+res: f32(inf:0x7f800000) flags=OK (26/2)
+op : f32(0x1.fffffe00000000000000p+127:0x7f7fffff) * f32(inf:0x7f800000) + f32(nan:0x7fc00000)
+res: f32(nan:0x7fc00000) flags=OK (27/0)
+op : f32(inf:0x7f800000) * f32(nan:0x7fc00000) + f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
+res: f32(nan:0x7fc00000) flags=OK (27/1)
+op : f32(nan:0x7fc00000) * f32(0x1.fffffe00000000000000p+127:0x7f7fffff) + f32(inf:0x7f800000)
+res: f32(nan:0x7fc00000) flags=OK (27/2)
+op : f32(inf:0x7f800000) * f32(nan:0x7fc00000) + f32(nan:0x7fa00000)
+res: f32(nan:0x7fe00000) flags=OK (28/0)
+op : f32(nan:0x7fc00000) * f32(nan:0x7fa00000) + f32(inf:0x7f800000)
+res: f32(nan:0x7fc00000) flags=OK (28/1)
+op : f32(nan:0x7fa00000) * f32(inf:0x7f800000) + f32(nan:0x7fc00000)
+res: f32(nan:0x7fc00000) flags=OK (28/2)
+op : f32(nan:0x7fc00000) * f32(nan:0x7fa00000) + f32(-nan:0xffa00000)
+res: f32(-nan:0xffe00000) flags=OK (29/0)
+op : f32(nan:0x7fa00000) * f32(-nan:0xffa00000) + f32(nan:0x7fc00000)
+res: f32(nan:0x7fc00000) flags=OK (29/1)
+op : f32(-nan:0xffa00000) * f32(nan:0x7fc00000) + f32(nan:0x7fa00000)
+res: f32(nan:0x7fe00000) flags=OK (29/2)
+op : f32(nan:0x7fa00000) * f32(-nan:0xffa00000) + f32(-nan:0xffc00000)
+res: f32(-nan:0xffc00000) flags=OK (30/0)
+op : f32(-nan:0xffa00000) * f32(-nan:0xffc00000) + f32(nan:0x7fa00000)
+res: f32(nan:0x7fe00000) flags=OK (30/1)
+op : f32(-nan:0xffc00000) * f32(nan:0x7fa00000) + f32(-nan:0xffa00000)
+res: f32(-nan:0xffe00000) flags=OK (30/2)
+# LP184149
+op : f32(0x0.00000000000000000000p+0:0000000000) * f32(0x1.00000000000000000000p-1:0x3f000000) + f32(0x0.00000000000000000000p+0:0000000000)
+res: f32(0x0.00000000000000000000p+0:0000000000) flags=OK (31/0)
+op : f32(0x1.00000000000000000000p-149:0x00000001) * f32(0x1.00000000000000000000p-149:0x00000001) + f32(0x1.00000000000000000000p-149:0x00000001)
+res: f32(0x1.00000000000000000000p-149:0x00000001) flags=OK (32/0)
-- 
2.47.3


