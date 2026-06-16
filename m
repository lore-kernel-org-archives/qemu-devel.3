Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFDBCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZY1E-0007On-Up; Tue, 16 Jun 2026 13:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZY17-0007Lv-8p
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:56:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZY14-00031F-Ug
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:56:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GH8sOW164829
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DdNLeH8MkJt
 vBxKVu0HtXPg9PU8YROWy44qqMYL7swg=; b=cC/V7BSqMIdN6WamFcJ/8CyTMNc
 xRh167/hGOTXT4m7s6IvPmVFklM7s3tSIXLqsVQYxTHfJLcqy5xrCeMVzDzzvv1R
 Wohwqm4kGNtVlm90voYRFvtjUG/uwakkiHLg0nFnLkAJrD+JV6omAXuGuQOD7/dY
 4TIc31+a7MFXQ6RYcC/LNtZwu/vvNDXyMjUaRrGjWp3+Rw8fC7oITTnGBij/+Lkb
 OLbyxAAn6jcNu43r++tGIjWhMHaZl7ElxOVCpZ+aePGRHRgcRb97GF6FUJAmlF9l
 TxOfqrXKEq5ohE8EzIJazUZ/aF6guNq576++k6/DFQb2W/BTjvxGc+LOnvQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09gbc8r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:56:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2beff6b6e74so62393115ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781632561; x=1782237361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdNLeH8MkJtvBxKVu0HtXPg9PU8YROWy44qqMYL7swg=;
 b=bybVpdgm1U8WhMf4hLHwRbI8MwtDoZPKbWwMQR2QNw1REDmXuwcM5VA6MweA7SRdYc
 ZAmtl3G+x+6sKLeGsURk+gd0M4Psq9n3VVW7VUSznYWeiQs/pzK++5BvvRhFqEdYb7wp
 hVzUedycsC8MCOibn6ynR09AivW2/bfnUY484alO4ri8Y/n81d6o07uNDW+8MadMpPOM
 B7lr3KYetqYmMxgo9Y7yH08OXjoi0n5tAI8bBnOycXP1+RfPOAgqV8pqu4MjPSocgOp7
 YbdhF+5yHy66q+c5YhY20R4i2ISYhOYivQ/SCEo6ecbitjeYgFGbdutE7K3NG5NnzIw1
 b+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781632561; x=1782237361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DdNLeH8MkJtvBxKVu0HtXPg9PU8YROWy44qqMYL7swg=;
 b=VhVM0S1OuVhqzPnlO8gl1ye6v54DB5KjrdUrVT1JGEQ/mVhIFAaobK9azPCmpXjltW
 nkDVDgnYIcXpU/c5U4lwS4BwM96ubGbBb9+XGDlb3zveUc7bXDr+uMlA84jAj7yttexA
 3FAa+/v6MmaZKNXm06IoHNNqKuvwNtIrI31vbfBvkXSnWKmy9dqoXXUZTaYilnNtDgHB
 vExBOsq3clmFKv+O2TbiAO69v0sM08O4MuSXp12Q54FtQmZwOmfi2/T3qh/Zvjmuhq6r
 J4aQ0BHp3BXgR8AHZS+Izqs84eRdrvjUczLhutS5duqeOGQvQAnvozTBCJe7hRLdhoN2
 RkNA==
X-Gm-Message-State: AOJu0YwucAkDpT7eRfyCO5J2389X9+kS8iAQTzt5z1Gz9+G9edEiQnXl
 ixdf1gjX2vwrVqLWCzJyDs9AFfMsiBtQDxQqepHF48QApXdBi8hXxSuDSvA5DmKg2k9a70RX0KI
 f887VjSo8YOX7Yt7ec/A4uaQvqTLs/7atwOQcK2VLOnOYPXCZG5OdvsHNFRozObCzDT+q
X-Gm-Gg: AfdE7cn4Px75MpklrzM2j5J8zMgqq64XV+5pN3uZ2NjcNmnJ0Syf2oBDkrM8vlQic+P
 U/lwo1BV0NQrigilFuC+9Nx7GHE7zD5WeFx9s8ocUEXHxFU905/pobqKAQWQ70jAXqRtRJOpI6w
 OEOi5LaGj4ZnzrKT3091c7R3TfzkqB/T2ZAzNTLXIfsugyWT/Ez9bPb4ecLd4Iv28d6zNNz5vV2
 d/KTYKvaxhA2sCyAlHpd7gDXOS5KbmLapSrqxYXcRMMWLc6yXLvgkA1FKdV4fT/dH/WdDJvXJKB
 T+GvIHiHS55ShFOtw7p2wqR2Pc9N6YpUBPzTqpc/hErRpBWJ5SV/u7ulau0DSnt0cXji5DcQ0+3
 BMsgHXer8qCWG68XF7VdL2wa158YYRxU0Ec6X/fwCuLXxO9UxCbhrIumeE6c08DBkZdHZYvQDH6
 JKI8LFC7g=
X-Received: by 2002:a17:903:41c1:b0:2bd:5026:ca11 with SMTP id
 d9443c01a7336-2c6bc0b0d42mr811675ad.2.1781632560697; 
 Tue, 16 Jun 2026 10:56:00 -0700 (PDT)
X-Received: by 2002:a17:903:41c1:b0:2bd:5026:ca11 with SMTP id
 d9443c01a7336-2c6bc0b0d42mr811495ad.2.1781632560220; 
 Tue, 16 Jun 2026 10:56:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327ac80asm125643945ad.39.2026.06.16.10.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 10:55:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] add a note on -shim to direct kernel boot docs
Date: Tue, 16 Jun 2026 10:55:35 -0700
Message-ID: <20260616175535.268519-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616175535.268519-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616175535.268519-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4MyBTYWx0ZWRfX82kmQDwAsBnw
 nrVi+2d4DDzMRdcUY8p4CgBxsN/rKc/kvUVp9v6P6YOyLdOqdAGeuAs8uJqtSkd+wwXWSg7XppU
 C/0L0qhcKfc0XHY6Qw2SRXjeDg6CvDhzIlnLO5Zgd5uo+H9OV/kys3x8M7vYdTRUZye9Ov0CK8E
 1x9jIfQy7UrVFbqqUaQZNvyYGsHvQnYx7vgo1To/7nTeTwhIH/8SyLzGasa4QMAf1q0N75MZcgy
 jhlJRpdKQ3E3z+QkDKdtSY0JNe0WunpwmRDml7YVzE3AKuINb6ar30fJsQ2i2/H/NLz9c+RD0ha
 jqkfjHUWZPhNHYPlLd/lkqSgmNotQFUCsIfLL2lgCDs3Moob04EWa4LLSuYDw06ZUgWTWPQNGb/
 j98gdrB9Hi8KRjL4q1/Vm3HaXGALVRv69f9iCdxmdzRRZ7tAFFpiVkGnuzRePRieXEG6BWZOC0I
 N+01wvNxDBzjXfjyDcg==
X-Proofpoint-ORIG-GUID: oKh11i1EP8-jkwssUTYj-_Pp2d69ncQH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4MyBTYWx0ZWRfX3fjUP84NIo8Z
 fBQdp0nURTu9ny73Xrgwsvi1/VW/BbvDj6ai6h0q0r51PT9DOLI01rxgxch/KNTAimYKtP6/1b1
 MlDR2V3Ystkm8qFhrsxdaIqzdMaSbgc=
X-Authority-Analysis: v=2.4 cv=DLa/JSNb c=1 sm=1 tr=0 ts=6a318e31 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=wLZQiVpf1cABdgcX:21 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wWOJ6q-e-0Q17L0BkQIA:9 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: oKh11i1EP8-jkwssUTYj-_Pp2d69ncQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160183
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

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260612161707.158029-1-kraxel@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/system/linuxboot.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
index f7573ab80aa..c9db5db19b5 100644
--- a/docs/system/linuxboot.rst
+++ b/docs/system/linuxboot.rst
@@ -17,6 +17,23 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
 give the kernel command line arguments. The ``-initrd`` option can be
 used to provide an INITRD image.
 
+The ``-shim`` option specifies the ``shim.efi`` binary.  This is needed
+when you are booting UEFI firmware and using the ``-kernel`` option to
+tell UEFI to boot a specific kernel image, and the UEFI firmware you
+are booting has UEFI secure boot enabled.
+
+When this option is specified, the guest UEFI firmware will first
+load, verify and run the shim binary, which is typically signed by
+Microsoft so the firmware accepts it.  The shim binary in turn will
+load and verify the Linux kernel.  The kernel is typically signed by
+the distro and the certificates needed to verify them are compiled
+into the shim binary, so shim and kernel must come from the same Linux
+distribution.
+
+Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
+distro install media.  You might find a second shim copy in the
+``EFI/$distro/`` directory.
+
 If you do not need graphical output, you can disable it and redirect the
 virtual serial port and the QEMU monitor to the console with the
 ``-nographic`` option. The typical command line is:
-- 
2.47.3


