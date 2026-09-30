Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36F9CA5FA5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdr-0007Vu-OL; Tue, 29 Sep 2026 22:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdq-0007VP-OL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdp-000365-7e
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:54 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNQKJt2010202
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IivcYLXSjQC
 JjlTUSpZa7MA1jVfvibsrVhjNPROqgr8=; b=MM6PgONg17hRtCdcElCZc/FjbqZ
 riwha0Lw+sG7Lkvxc+3OP+o9bklZxJHG7fUnsLoGNKL3LYDtsw2628uC6LHBC+Xc
 unpYsm+KnCooiEol2zND1/AtEKC7gIGQRGZEhlY/exf+FAhPh3bUl4Cw1ERjbdlQ
 QmRgy6txHK02Rb1CRnxElJYtXa3LvhTdhSF4JtOzvqGaGcyqVXavBA0SEUfKfR8I
 o0bK/gw9wfu19JxQwgaWDSDEP1ht6rmGynX626yqkM777JWan2XE4a7XPEtdwHqD
 ZfZ6xO73yNKkbtisxUVTxn2T4kV+MyRnQG7iWxJVdksVd0qx9ZPlhoZ870g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0ftujdnq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:51 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b62317d0so1744300c88.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733711; x=1791338511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IivcYLXSjQCJjlTUSpZa7MA1jVfvibsrVhjNPROqgr8=;
 b=AHXOVot5nEQHt6bLrx/BMuo+m6L6jDWhtIPLGXmTJPzTXnTM4Aod79069EIzK7z+wE
 3ehqmfZ2l6NIfXsH5kU0rqyYYPa+L+hrwIZHuIhlOZMB4ooRZGbMyYXSG/uC/wKvUIqN
 4rhPyIle69/vc/rG6VLb6YPCKheYuKKibCN6Ihi1c8T1WC2jMJAG/HIj4VaeZ6Tz4yoC
 arQzocfzGTsw/vaIvEh/RKinZNRWZapALAEVhCUKP9Dzzl4lfOEmGEMgPlEHWMOtyWVx
 Aa3Pa7EFbMps9VTFHSCpTW/qhA+FWG5LpoLWuz84BOECWMRo6u0UnclsuU7BVMTbrHN2
 Xd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733711; x=1791338511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IivcYLXSjQCJjlTUSpZa7MA1jVfvibsrVhjNPROqgr8=;
 b=WyBBqhDbHdY6kaKHqEBZYbODVyuA/O5NrexfSOWdVPffS09WtIDylmHqSFfr0NwP2X
 VHFtqyB0gRHNMMNTv/wAqhCYq5XYY/OQcHX3qCvEhaCQX28NPr3MPB+jlQSksye/U8Hv
 JbL3KN86tSSLqgap8qByssteOYzq7i2CznpsGbhW+v13haFi9uRsxjMijdXS+dsszWBb
 rSTP9sUGtYaQUT+5tKSeH+uvLnW6xZU0m53iArglgpx3t/oN1hM7IL6UlfwUwi5VI2Xv
 JORcl03fJQkCoiVntPky3lMpmSk6WlbQnvPs4zHQLAG2ij26Sh25WO2uEexwy8876+qe
 67wQ==
X-Gm-Message-State: AFuF++kq4O1mTPLdQe4PKI7tyuqZwDtjDrSfu0vGRBy+EpEeyyRPcwoc
 WtvktheWXytG039rbSZV55Q0wiVZ4W0tqj9PY2tRgKPvtT2AzKFtMvujeO19uqZL0IpHPWwP05N
 6LCz1LAo+KK0NlxZ0agGeyDJ7cmbTtT+CvMhUVKvkw6IDntbxCtPwAPVU+VAuXVi1xA==
X-Gm-Gg: AYBFou1hM01ejR2H0w5xi7M8Z8DolGHBf3gBZ4z5/yN5d1ebipAYNAqLZyNVUBewNkh
 ob9vhJ64NsnWY2aNWMUSlQOuW33IchnbvOqERl/qq3RBXS5SCWkik96YQ+SXkLQusz+ynEc3li+
 PeHzIAVf7iGP9LPxMZoQm/RXjjaRHZjxkIoUhrh7YcW4zvcB7+Smoijy6jhR0D3t6Me7vRwj2MD
 LCgsko+wS9SquFgWDZsYWkD5saijBctPgS23FJN9GxBr0/FMIeRkUtJ4bXTad/obG3YAB4iF6Au
 p8uIWELYLg3ym/BGbgvp4dPKAQSs/bLaTqmu/yO2vAR2wAjJ82H2B0pf5eTgWWYNeXu9/NmraR/
 A++lJgQPx+wZXVmSph9DpmoGncxHHRYdXuh3YG8fY9m3MUJ4pRw/7f6oxNvX+
X-Received: by 2002:a05:7022:ff49:b0:144:fa75:923e with SMTP id
 a92af1059eb24-14c9f8e7337mr1726803c88.39.1790733711107; 
 Tue, 29 Sep 2026 19:01:51 -0700 (PDT)
X-Received: by 2002:a05:7022:ff49:b0:144:fa75:923e with SMTP id
 a92af1059eb24-14c9f8e7337mr1726722c88.39.1790733709990; 
 Tue, 29 Sep 2026 19:01:49 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 10/21] meson.build: add alpha-softmmu to multi-target
Date: Wed, 30 Sep 2026 02:00:57 +0000
Message-ID: <20260930020108.217892-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX9+zs063BhPYd
 Mni4D4AOps3ZhblPzHYYH9HsxR9lvXVJNCrDmM08gmlykIwWRf5whASNXGQ06V5cVVPz56rPVJ5
 QQ/cqLJj06Z6YUYK8A8uKb+mXS2wh7Y1CNaF0Bu1qyH09qtG1AxY5EvdgKxHhWD43/UUSCbzrdm
 E2kQX7h2P3CFZI+VB6XdIYr05Rm6n/6fmreeRgqyCk+aiiLxUGibyGTfIQNcVwhlrVyG1iBerlH
 2ILuZ88htl8qgOxgQGiJ9++cR1OtrYMMbfJA4XNvClvR/bjkX+Nv5BA+J/YbrJrekTOo/7MW9Fy
 d0gmT75Zfi4kc+Bmxj/cDSnWLiTJlHI+uYuFemeGznyBMog3o3iZmfaoige2HHcqRxGF2fx2YAo
 O5QaiYLUbB9aFsGCN8mDglgQtCyfTbl+Ef4bbgIW2G4LR0w+1tonbarHSp8sINYln09Dk7trUCr
 CQJ/Qu17w5gB2x8gzkg==
X-Authority-Analysis: v=2.4 cv=AoB7T+9P c=1 sm=1 tr=0 ts=6abc6d8f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=QDFFToLqPBCoCbWQ0rwA:9 a=SMtUHvCfqO8A:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXxOAI2V6Giqx4
 zaCOZvRAYgZhE5hF/9tpq1sJ+SAcAqAp8j2gks3OgdveMijqYw8Letd02aGbaXWf1I6KYY0GB7i
 pjhsPHVQGCErddgfSNJEThKRQ3A/Xg8=
X-Proofpoint-GUID: 8rxwJ69_n1Es60JHOTOihqmt1tBDKNFN
X-Proofpoint-ORIG-GUID: 8rxwJ69_n1Es60JHOTOihqmt1tBDKNFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index bfff019c884..5515f731295 100644
--- a/meson.build
+++ b/meson.build
@@ -4263,6 +4263,7 @@ multi_target_deps = []
 multi_target_crates = []
 multi_target_supported_targets = [
   'aarch64-softmmu',
+  'alpha-softmmu',
   'arm-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
-- 
2.43.0


