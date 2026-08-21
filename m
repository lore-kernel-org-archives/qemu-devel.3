Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CB0C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 18:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxToZ-0000d0-S1; Fri, 21 Aug 2026 14:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wxToX-0000cc-Ie
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 14:18:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wxToV-000766-R2
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 14:18:01 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LIAbi02636562
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 18:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ErhVGnzHPxs
 FD0GMA3aleyhcn2Z+wBynIJGBJ41s5Tw=; b=YknsaohmnOT0jI4KoMERFU3xKEP
 VMDXldJISHkX81zOjkxq8Ml+dXLJAR8zGcJdlV8JQy6W9ctoysa36qgxhp7lc8LX
 0v1mvOn2RxxHATMNAl9QbZn+2C/XZkZpWSQtxO1o6STClou7Z0kPZUKPIxzCRA49
 7ojaiOrOuERKFtmNz6W8uuvJ69UXtnQZRBo8J3nqI51A37TCXuaLw94VPLJYwv1H
 8Cx0nnEzlObWuEuhbwd1xCQYZgtS2WAhKxtIuD8tJCBwVIS3I2DXQ39T4WVsU0KE
 Ej0j9UbUb8+hd3xA+odl6pbzdyivCDm4k96a3u+5Fc0zX4YsmmfVbioCv7g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fbwb54x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 18:17:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38fa7b09921so2438164a91.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 11:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787336275; x=1787941075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ErhVGnzHPxsFD0GMA3aleyhcn2Z+wBynIJGBJ41s5Tw=;
 b=gbKCjxrsrWXI59ngc54GwErxi5mUAMkTyk+6FuYv2e1tiXYvxEz3SpS4jlWpP5yt3x
 ldqi+uqPIBV99xac5VBOJo4EYlZoRAjWR8vm5YBbzjbIJS0VUj4FPolUzhnsRMHmDYGv
 2E5iB8KDv+5n+qPRHRru7phB/y18SxNDjzW35wpB7L/cWd8Ihecn5Fb7GbNse92/I0ao
 okGb9d5q4lsIzqRma6onerzVbaKmOvfxiyowfuzdHcMQh6eqiRlkwdYwIAYQ7tUEAH/i
 iREcwvtyVZAivUAJaQCRR62td6ZMX1cROqXw6xL8/ElVqRersATT0KeffiN3VQxnupLf
 vUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787336275; x=1787941075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ErhVGnzHPxsFD0GMA3aleyhcn2Z+wBynIJGBJ41s5Tw=;
 b=TT9WPSG0HLeh0dmiJScjOS6Xuxvz89VUzKQXKH5pTibiQ4qLfxoJ56seSJZuGvLsxu
 UFLNan2aSu6Wt6Jtf5k5a54pDz0FBZFFrcky8KLKaFVfvxntVUgPSMYFO71YKngOrAFM
 Vq2GlZuhwxx6R6jZrS4zdWal/t9GyJZDQqfKqKWsL43mb13Zu/V8EQVCd/0xKFLCrEBO
 3qA/pmu5/Rb14KCn3XyNXywQoSVddRJm3NJhAX3LDYUTozQM3Q63gxIuKSdMAj9c8yPJ
 6IDb5w4Cl0pFl/+Bhm4q4SRaIPlw0QAVWm14M9vt3q6ks48PObJbtzI/v2VoLV5gBorb
 XQcQ==
X-Gm-Message-State: AFuF++kt+NYE8UP5grv+lEZxRD3zUsIy1oQ4gv3kfTfzuF5gVokqasGL
 7pajz4zkMJ1yIitXo2abQYneRBV6rbCbCkDvgZKEvcKOFJI/k6Tikf14Cg70vwO6vSREMTr3cCh
 ba9NTDdif6vt7hH1Jc+wPYNJnCqzwyJmHwzMHZAAKqqvDBzg+m4eeBphGsQ==
X-Gm-Gg: AR+sD12N45aGCtBj9IzvBQ6FmKXD5GDzaC6kvusKHn3fXQUarYlqAevMhCq01Cai256
 9rve3vOA1KgtfSSKUxtqHrzuk23dyiLyyrkinYh9Al7crujIbaeH7fwIfzjqrBh96KTqnLY2k0H
 6W6qydMvUnR6YaQuwj/4MXwXh850RNEPpSg8Uwmg2CeyEG//poVRZHpDAVbYbIHHdp7En1fy59/
 FJ1nSU7GJ9XBgVkCEKY1GPPKZYB69ShW2rLKZSUIVvku/WfDwqnj0z6vy4lFvmtdfe0Gwuv1rL7
 tETXCn+vwp1/xlyyzET+onJBaApmaxGsYUmK6QBzcqgzeCX/ESJz63/UU0ay+L1TkaxOYR+U/KQ
 bz3TVCD067NZP+sazd5wWN+MQO2cXxJvn9hSverbYTol5U3MP4fx3vfM+z1DtJ88=
X-Received: by 2002:a17:90b:3d87:b0:38f:837e:fc5d with SMTP id
 98e67ed59e1d1-395c334050emr15811939a91.3.1787336275211; 
 Fri, 21 Aug 2026 11:17:55 -0700 (PDT)
X-Received: by 2002:a17:90b:3d87:b0:38f:837e:fc5d with SMTP id
 98e67ed59e1d1-395c334050emr15811847a91.3.1787336274759; 
 Fri, 21 Aug 2026 11:17:54 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb46sm26170297eec.3.2026.08.21.11.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 11:17:54 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v2 2/5] target/hexagon: fix HVX scatter/gather
 region-length check
Date: Fri, 21 Aug 2026 11:17:52 -0700
Message-Id: <20260821181752.401536-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260820215117.1788954-3-brian.cain@oss.qualcomm.com>
References: <20260820215117.1788954-3-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE0NSBTYWx0ZWRfX98cY43Hjki/5
 Ib45sf2VbwBE7yI+2JarNsYwbeDEigXjluj8YZ7EMk6N1mtdVNrwybE97ix5HY0htL+DI7Du83W
 Ag3RWXrgu0r7mR41JQGGE2GomcG0KrQ=
X-Proofpoint-ORIG-GUID: Tafsj0EZwuVQBkS70SYjH4OMEtMmoGEh
X-Authority-Analysis: v=2.4 cv=L9AtheT8 c=1 sm=1 tr=0 ts=6a889653 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=kzh6aVqUD4sD3FDyM6EA:9 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE0NSBTYWx0ZWRfX+dVQYQOncDdz
 uUrdC3czHW26wHNbtiSp6AgJ7XOIyJa5NJaYgs3TUAVx1J+kOZXpWfggWwzUbLb/lAutUdNoN6S
 eApX4yI7YqPws97sQJOcep+2FbjbN1N8d97weakN6HsIb2YGHdjT8twZjwVzaN+A9RpE2ezkyL5
 2FgIc2Z6U1+rwQZNDydOIjhkkcSavBvdWljNHZ+7NR7ExJCMMVbWs7MkZ7do6hblO9qZ4/nTzEo
 vd1eiZrjSjCBz/fXsU8pKaUb1jN144UHnM662KupQzySgehdal7HXIOiY7fNhFb9QIBJG7uG0v8
 6ZXA3QAZMUk8JC7PW6J7VpvwNnliTmd5ffvcvD3chSyfdU9SVNfZ2811l0DQIdHMiZ1zaGC2dTr
 Ks2bKYDEg3C+dzexRLj+inuzp6kYVqqgIhaEPIPgcTk/ARGy5/zfCHCPa86b7tHlEMKLCVuSeL+
 B96UdA5M7HUGnC0/VVQ==
X-Proofpoint-GUID: Tafsj0EZwuVQBkS70SYjH4OMEtMmoGEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210145
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Thu, 20 Aug 2026 14:51:14 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> The region-length bounds check compared (EA + i0) <= (EA + LEN),
> which reduces to i0 <= LEN and never actually depends on the region
> base. This let vgather/vscatter keep elements whose offset was
> beyond the declared region instead of dropping them. Compare the
> offset to the region length directly instead.
> 
> Only load bytes for gather lanes that are kept. A dropped or
> predicate-false lane must not access memory and raise an exception.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/macros.h | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

