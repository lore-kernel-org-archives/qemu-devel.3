Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4995EC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YM-0000pP-R8; Fri, 28 Aug 2026 19:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y8-0000Yp-Rd
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y7-0005lp-31
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:52 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTJNf3665796
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=P8c9tVc/tsC
 0VKHJsAmXlBKD5jQLNNKQzVAo3npQ/JM=; b=RulfTeIEmtSr9FDCts6f6FSkV2L
 Hrga5SiEkNRfJiQTKGUypfRYzwqeNqQ2JUnzSdxumlQIq2XIw/NVZsUwQVYaif87
 Ojlg0SKuy8aTrzMHKm5MbKKQejDqvErt5TWkmNeGGPOU3nLXXFONeGT2BC1Xrs4K
 OQFO5KEa+4y2lJvocPUVha1juL+H5CE96+LbEaU0OH1k4dHtW/qwmezrWKyI2j0Y
 3twZ/lRd1oKRzrGDe7dVayZTHMJSpmO+AISYTj9/TOND3ot83M/eigwOmkbYgePr
 F7OM3s/ipOAH0D7PXmJyQe7iHa27okAiWOu9VdK6BhseGZss5enEun8kigw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mubswq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so2724934a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957979; x=1788562779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P8c9tVc/tsC0VKHJsAmXlBKD5jQLNNKQzVAo3npQ/JM=;
 b=Y730ONVoKF7+wnQ74h4/n/aZTWhdxDX//R3FepliHs7ix1ip/nnPsNIN+fW7JlWQYf
 JMf2RbrM4+FWF+oAhOZrulze9Wh5sZB60Pi9mp33ppWKypJS+f9tD5kDNDXnxjlqJyCN
 ioXyMnc8bwnjQggLnH24oI5T87IiPaAdO57A73DCDV282W1q71oyqS04Gk2bUDEhX8su
 HxPdyRciUJiJCfc7z4nNdWO+rkteGdLQZczwBGR46Hs0dN5VdwGIrQTCGZxALtIpuMa2
 EgeMeINQ/gwKGvosISwjvl3cPxe0sNUzfZ162LOpyF3ufH7Xo8Qs4NKc/ZEZevxWF2K3
 jFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957979; x=1788562779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P8c9tVc/tsC0VKHJsAmXlBKD5jQLNNKQzVAo3npQ/JM=;
 b=JYjbdLsZD/EEAtzRHvTXUbtk9ZQmb7qY2i5PaAHxal/FpN2gjzHS0LNCF7U4ypWxZU
 h+S3jgZy6jI31OlUgYkeZxcqUSvRWbSqWrMnZ+zAW3tN+zqE1oumytzktFrNHaOIdNCQ
 xEcMPnxjkfmPu99T01W16MRBvYE4b/7CZzT6kEFSI/5Qkn6i1prBzvrooD4NCPzpxXin
 /jERdR3SlApDX+pjxvO60y+dwSLyp1qkVWqv+6W6F1Wipj7JYpnqgNxq+oSMEaKJWEQk
 +EMykIVfTKP6ipW4oCN3KfDUMzqYcRt0peMaTqCXrVOyZYUIF/8Q4iTs+ODFHBS2tSei
 kQ+g==
X-Gm-Message-State: AFuF++mvIaNrKw3gbd1oxSwbauJdiW17qpQVeC4AsirQNy2zDXmLTkd8
 qBylLA+7CKrxzCR7iZlTJQOMVQGXpdo0NVgxp848TIpQjhacKQKQWADf3ZW0gzCcL+WoJypT4Ia
 ZaAXXj9TWQ1/lC/7/qL8W9Xm49NR/fRdy1OmwXClA60nBlox6yjyIgh81JFtXbULP9Q==
X-Gm-Gg: AYBFou0x/4KfOAP78TQBwik+DQZsld+7zzJHSVsXeokyHnqacXT4jwgVeyZYgkY6tua
 jaLk9d924ZMK/MmI+gxxeESCV+4KWLydq7zC89nzEgGn2AJnSaF/FWZXyKCVxmowmt0VfEN4d9z
 TJ+6uOvu8jDy7In33LWSlykJeqTvrDfeuix0jL3ExWVWX9ltm25kb5XFqSxBh4ccKMvEC8xdlRI
 9/KlONuUWY/e7HyLVbIISemYIWdh2G7/cWAFZRJr9QZq25p0MXOI/0NxfcsGl7fT8ibGTNTqAKz
 vbgCpIJQqspUJvQk8fueQaHaI0gNNh1OkPxdD1ktySTDBZIwrGiRIbP2W+oYaQo/s+2i6c3xkIN
 Eq1CmplrfbQThuLJ5wIas0oSKfcapBwq5F+2F/eQM+sLhCbc2/uPHOLvKajU=
X-Received: by 2002:a17:90b:1e05:b0:398:9bd5:490c with SMTP id
 98e67ed59e1d1-3989bd54c4emr3718537a91.19.1787957978841; 
 Fri, 28 Aug 2026 15:59:38 -0700 (PDT)
X-Received: by 2002:a17:90b:1e05:b0:398:9bd5:490c with SMTP id
 98e67ed59e1d1-3989bd54c4emr3718499a91.19.1787957978468; 
 Fri, 28 Aug 2026 15:59:38 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 24/47] hw/remote/machine: filter from CONFIG_MULTIPROCESS
Date: Fri, 28 Aug 2026 22:58:38 +0000
Message-ID: <20260828225901.367438-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a9212db cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=oZKOxlyl4ScGPvpX6VEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: QdNvBPPc241rMuqSLsXKtdIp6_yY1uwo
X-Proofpoint-GUID: QdNvBPPc241rMuqSLsXKtdIp6_yY1uwo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXzvRPUG967Sc3
 /huArT3p95vYJcr+0d9aYuKt5HNG4UO4UyOQQcPpmqQh/cz+DKXCJmoT4WOkhiQacDKIIvAQroN
 n9v/gOwtIQ4EHAwACDJVNYhSss+0cYk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX3ebQxMgc7gqn
 yMPu7LOQEcb9x5F25Nga2Og5ikgkj34FOBZq2rimv1h+mkev0o5lo+hBngwfkJzClbWusXyxJmN
 39Muugj+Grd+Ur9n0JXyTnCmE/RhOOlXi7Z5VaO/SSVH7UAnGRwHnHsMOhzGb17Zg+PfQJDLt8D
 MSPt8eCJj71QBlVHSB/ssgKtmzbDeL34TVQMwk2VDbffr9DMHwhsNfqtiJ0eBmmu5OerBI5AuDw
 DtFu1XIVkiCDkTuKLZ240xg7wCjbl31C+4HP2jv107n30cjWwpTHGwZC15f4/CAaOFRFCjipxrK
 bXOE25JxIwYltvbCHfxl/k7MLU1Ir2fU6RUSQa9TPHoQtCwtcN9tCm232tHayok6sxkE5dWaPpa
 dNvX6UtQh7dHPTtz/no1wEDT30h8ng4843XvdhE4UXUoNQC/aFoxBjRRTzDO9Z72aqkiyxmFijD
 MHw+BPCYhmldLwWtYZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
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
 hw/remote/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index ced782f6a9c..2068da9d5be 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -146,6 +146,7 @@ static const TypeInfo remote_machine = {
     .instance_size = sizeof(RemoteMachineState),
     .instance_init = remote_machine_instance_init,
     .class_init = remote_machine_class_init,
+    .is_available = target_config_multiprocess,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
-- 
2.43.0


