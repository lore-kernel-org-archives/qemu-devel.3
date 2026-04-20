Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D79F36C58
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEnQt-0005Xn-Os; Mon, 20 Apr 2026 08:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wEnQm-0005VA-8i
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:08:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wEnQi-0003sl-8V
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:08:45 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K7Yrsr3455276
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 12:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9/sP8s7+4jS
 iGWdHSP6gcU4TmLa3KKxHO/aEr/ZM3lc=; b=g6Hu4oTniGVAplfZBagUvG5fLZU
 sS6MjidmRBgf3/FjSrFlv0aiVv21UrtW6F6TYc3DdZ+x2qB6KVTLcsSI/5ZG3ZZw
 jXdFVRwlaD0t/Gyp5U9L+oCwbrJ6lMME/HgNzrC2BIPEzFXkrefIv59/bv/VAYyJ
 rrUMNq91yx4OuMbalqz2Idc5TUU+q11fdGAsWXPxMs2LUxFfiZoir3sIQ0Q6olER
 6GqbN2gzfC4bESibEq8JsvzsyLsdvibIYcRtW0d3ksrYR/RMUmlozhiHAFSmR7rs
 +3FkexwnF3SHIzTMsxX5OOFQN3bfNcbWGDWCUFArI7jgbWCjggCKkMK1mzw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfvjs5e5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 12:08:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2e60238adb1so1078934eec.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 05:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776686919; x=1777291719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/sP8s7+4jSiGWdHSP6gcU4TmLa3KKxHO/aEr/ZM3lc=;
 b=aEzXzxSMrvOKAy8whI+iDZNyVChq/8OHVcNZN9364ZVm7DmBQ+dcPfK1o80Pp2/slk
 GIqzPeIbH9p3Be7QCGVFttXh9T1URDaHlg4VSecX3zd3ultOU2XUCWs+rls2q1CSCGp3
 5y7oXvJdNZJuXnq7OV1C17rxCnitO3z8cxWJlXKZBSs5y33skigWWv4E070L71LUj3Xb
 bWw8xOVN7hXCQMLGXdq1SE8JnEZ/aImBnrV6N+mFVPFZXkp+zYmSW1dBNm0IxydA06WW
 l5KFda0KfmwmTiTUKHh2R/HZkUmpD5FU2YtW75ZzybPBsEgO+Fo4yWeQgf8C+u07Ym3J
 jKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776686919; x=1777291719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9/sP8s7+4jSiGWdHSP6gcU4TmLa3KKxHO/aEr/ZM3lc=;
 b=hzAXQsKTqsWY6BWdDP5k2liZkgmsVJgg9hoYcjdeIgbR/cyEzvvLQs5W+7m1/QSx+p
 7XYalZDW4T06WwFUS2RVkv2n3fLniRdywquFIE4B1Q1VRaIqlkqhWBHJXOA4yO/kOO4o
 otLFPa2wwcXKIVVv4YAK0jtp7cO42/lnHsyib48MR8lzTq0M201CR5RnNQzCFW/m5Bln
 LLcG3GQm2Xm62ks/Du4XxcAWRMxsVesAMAye40dbb1La5+sY8RLw89lICiQLU6zGa7ub
 8fudAw76Lopv5oPSeRuEPZFJIcIz2PU8WJz5Mkr/VrdL3QbKqoIZpyKNUSgn7zr4xCuj
 jslw==
X-Gm-Message-State: AOJu0YySoBO+Zr3Es+iFl3eNYeTzYM4nqQ8i7/VCBF8tjbilcJqeWm8b
 VhTDdv/Aisu2wxTV3uQVfFARZZoRpa92Pc7iN3ETloo+ATpTCvVbmrlPnq/lVNZgfBQbPSV3hpy
 AKLj1qzxWoZ8nRfKM7gEEcA7EYehya4NdxYYHRmXLItJaHp184bUIposaRQ==
X-Gm-Gg: AeBDiesthfYG1MuJqOOU9euDywviJmq5X2S7YBOkIcInu1U72hm3nseTgSvA8mQZFxQ
 osoj7wWMqGc+EzhrhY0dZheDT1YQEUGtFwzAIHpphB1/Pl8QGnLtdmRlI+wabSK50PscrFUXvgI
 9d+xvbEIx39ZJDfikJxqJkOyHbgyCRYRw+hEDrh7L7oDVB0RD5gOmSQa6376+exmZ5s+QMos5Hm
 83LAoGX2RjXEmCPK7NdvsenCfMSVxxiCeloHXCBOI7vj/5gx1ygO06pI60AmIoqFwErxmDaESoQ
 gYYYr8VUAne/BOuMkHb/dD+nAA8+xBR365qVnh9TRxUfJ8OSIpB0UdDvoBmFelaSitEqoy3/S/5
 no3y7BDjL8hwhWLwhXdZA9dA5U5IgIpdSlFu1ujheH2He/gMk7W3Nn7g/DaihFQbYDe6LryEX6Y
 HlZrVt15Xvw83rJHg2pmI=
X-Received: by 2002:a05:7301:4185:b0:2c5:60d0:701e with SMTP id
 5a478bee46e88-2e464ea8930mr6671605eec.3.1776686918859; 
 Mon, 20 Apr 2026 05:08:38 -0700 (PDT)
X-Received: by 2002:a05:7301:4185:b0:2c5:60d0:701e with SMTP id
 5a478bee46e88-2e464ea8930mr6671590eec.3.1776686918287; 
 Mon, 20 Apr 2026 05:08:38 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53a4a8bd2sm13733004eec.11.2026.04.20.05.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:08:37 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: pierrick.bouvier@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com
Subject: Re: [PATCH 1/2] target/hexagon/meson.build: simplify decodetree file
 generation
Date: Mon, 20 Apr 2026 05:08:35 -0700
Message-Id: <20260420120835.981182-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260417194606.39997-2-pierrick.bouvier@oss.qualcomm.com>
References: <20260417194606.39997-2-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iX2gnssI3mFsiexZWWkBJo1v-ld98oAX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExOCBTYWx0ZWRfX/Xqo+TIQvDs7
 joDoXoqIasLQnrEj07qUqcJ4zD3PTsZCk0rYIqoR5NQjV5wYr6EUkPunaxRvtZcD1cN40RgryeK
 qIhIh1pQmefx62mim1mW9Z935lbZ9zuNj8snhlPrj9ApF4BpFr3y7KnIes5HyNU0G9H5+0Cbucw
 9alk8JvRQrRiczhEp1CY0RouGbSgxNS4wcCCvf1cxL6nQbCkqsyFAgg+q0OB+s5w8k+SxUdHmsM
 nWJ4oOEqEEclocf1/wsRWe9goDC+huq0/kvWux2TXZ3QtY4/QQah1mhqU4Rg5tDTxr3rGjZmI+H
 sRsToIhdyd8DKBFL0QfkeVjMWleG8PP9kBGNJVOb9ga5BiJOqpdb4ky557uK/NdCfXjs/6aDlxf
 Zn5uWpgscNmC8P/+KB3UON/8n35cmZaDUmiuK/S6JRoXLH57a07jviW4vVtv1UajEgGB3t2lbpn
 cCngq3knY1is4m71zug==
X-Authority-Analysis: v=2.4 cv=XNMAjwhE c=1 sm=1 tr=0 ts=69e61747 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=dT-lyFnSOVzXPWP6MsoA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: iX2gnssI3mFsiexZWWkBJo1v-ld98oAX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200118
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Fri, 17 Apr 2026 12:46:05 -0700 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Use a loop over instructions sets and decodetree generator instead of
> manual custom targets repeated.
> Modify included files accordingly in target/hexagon/decode.c.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com> 

