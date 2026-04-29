Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A57FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDrm-0007ht-NM; Wed, 29 Apr 2026 18:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDrl-0007hR-BF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:58:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDrj-0007fV-PE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:58:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TMF9On3884903
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pwkKlG1ZVec8EpN/wln//M952rrkZJEatzf2MGFehes=; b=V0TCYpyYrUcim63t
 uPy0ogVu5cgaqcFeZ99xM995CmWDnYPe8d0/8ho2I9r0F4GQCG4pGLjuqKAPeNAe
 4HhxEtKv+Sezo47tXbYQbzCxah2AzqIuVMrM5/61dGB3tjeHXxVJI5ttknsqv4nN
 lcYGW9J5VqIBySLTHzhAquxOPyWcouCRq6KbbgDYMCOcESsfnG9iIfOSUCIOML2l
 Xqzn9A5NrYUx0uz7L751Q8SEDeeWev4VG4YeBkkUQxAY+isGAqnOL2mWKSkyyHWZ
 s9e1xfa7GtJcbzRa/7D84QrXnQU5cY58xP07lkSPfLlZrDsXpz3aVitOpHhB4GZq
 0DVqDA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dutmag35q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:58:46 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1270dcd11c1so477485c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503526; x=1778108326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pwkKlG1ZVec8EpN/wln//M952rrkZJEatzf2MGFehes=;
 b=O+NgRupvLIZ3b281G7gVcZ3bZ5fe5CNm3y3pbsWg4TP56UZnAJBhiqFYFjq8lzEH2b
 jfDCKMjWt1yHkMOzvNDjmkCiCe6DaW9q0SDJe0LAsDtCtcXWg77x8Y+6oSHBbYjM1VN5
 o1F+uvLbKKYWPVmkDwJ61ZVNpAjlIYjUMhN92oUMYUiuTAvTwHiYeRBH+bXZGO/X41Oq
 ymU6CnCgsmZKBYiLZKcNm4FSUDZKofxXddHv5/Pc1rUaMOzrOnPQ6aeO5O4H8Hhz8bqJ
 oUKH4iegn+rcPFVjOpfn2XgR4uEcB7jrXNZuIlKzNgzZnVltH5rh6WRvYmgqeEwTwCV+
 BgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503526; x=1778108326;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pwkKlG1ZVec8EpN/wln//M952rrkZJEatzf2MGFehes=;
 b=mAMZ964lv/bdE5EwjiQ6SWrlGIDKhrim8FNOzS4WdqtXtau6W7qGV7oB+7iAzV/6aa
 iPd98J4soNP2YJeA9DOM/XRg8AEHwSPvrWWlfzzzt+vdgZx0KlAE55URH9WdYNggbI4R
 X+5ET6anlLWg20vgle0PszM3cYkemyU4pBpSn+DAfALQe4pwHBoYz/0iv98MGmCfguFc
 8vtFkSQD8DlHt3eRMgi3R95PBghV6WMGBZRYRyYGaG4m8KIHUqfBS520c0dFwGSiNJZr
 1XrQ0j+K59EwV4DqYb6HSpMeOGR1NnaKJyZ6PUo0PFbzGRvMqBZi2DTP3ciTIxtOY4Nn
 +apw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bEqPdhX1636MKMVic/vfQGbGVPs45+stL0kySO3WWp6KyqreF4Md5qHqqEjJqKVejLpnWOrXu4L3w@nongnu.org
X-Gm-Message-State: AOJu0Ywc4MXRNopNfQyt/VWe3kG0UjK8X0YU9xbBU8qMQ8JeNTyK6pXN
 EEDP4B+KBb+HQ+sYejSBpIr+jRmAzxy46WMlb9ZzWlqVKKoyhzb9toYPucgpLz18cTC2H2zFsoH
 DAz5QXDao8bxR38KXJh2sRDe6aunNdfhIPUIdwqFEYozpI8xVjYYcbe20oQ==
X-Gm-Gg: AeBDiesG2MwP6AT4JfZoPLiWMDaGsuQrFTgJdvnmlJD4d/iyxmZdKaYBmW2RKQitlO+
 9YAlgUPuT+0MgsHp296AvlsUoSJ3P0yJLR/S+eYsCENEHXzAH+LJI02vYpx/5SAL9GPGblZ/Prn
 j8fjpuSAo4Iwch9IMqPPgSPuNTrZoNnZMw66FqKSli5BQZJavF8n7LGgwhTycuGx/RAicFoOlEO
 Rovc7xBecb50tyoV9rMMXSbmUA1QNhoEs7XQJTReimPoAAclSd4HT45KrRq2KQt3wdYW0Jxs/OB
 mJSuoZaI9/BzGRj96Q1BlwFQkAmUDHHquFsQkq+gbp4t8jZ8SfChYhDW9rRfmzfACpFWyA/guWM
 jJ9tcV1wToHUgzjXv/rJVxvdyWsjiCYZFP0PVV0D2Nu2eKJ/ULUfi/zFNOWOX9Dy0f3bOgsuui4
 DGZKnPUcuxrGo3qchmOZA4JVcD
X-Received: by 2002:a05:7022:6727:b0:128:cf75:42a3 with SMTP id
 a92af1059eb24-12deace33fcmr214857c88.21.1777503525735; 
 Wed, 29 Apr 2026 15:58:45 -0700 (PDT)
X-Received: by 2002:a05:7022:6727:b0:128:cf75:42a3 with SMTP id
 a92af1059eb24-12deace33fcmr214840c88.21.1777503525217; 
 Wed, 29 Apr 2026 15:58:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm5989694c88.5.2026.04.29.15.58.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:58:44 -0700 (PDT)
Message-ID: <135ba557-e745-45d7-bd74-d2edc88e3293@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:58:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] bsd-user: Add FreeBSD socket ioctl definitions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-3-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-3-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 309HdQb3Ku01QzBf-QVOmxtMSeqq-FtX
X-Proofpoint-GUID: 309HdQb3Ku01QzBf-QVOmxtMSeqq-FtX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfXwfxsXBGdOxWH
 zj+Ntodvr3OKuOBidzrDjtkzlxJYDC/TAe+dIlyMsd94Mi1++mDUd4QlAWPfEo5DJ6NqkTyD93m
 E4O+e6XUcnr0waWqv10ogcALIeo5MfV/bNU6+STEcDSlXan9/SM2Bq2VC3zZgJdp1nanvr/yA36
 jJ0BuYZruc5y4EdSU64QLSgLoJZOEbKbNCLkxbSj6jSRi0xWu5Ypa1YanYaeBR245mokLkef7hS
 NzA8dE1z5wg34G5+L8XX5+Wx0pLsnnyIsbrTVTI8WPnCgDxKw/UVFnfldneyuDOTnpcB/GBYOqT
 dXuwWXSKnQD3gOsJYPBm9q1d4mrbHACrCX7HJociULqVvfBqS6VbzdcVhZa1OWEZrTZWCQeoJ3D
 Dlx+LQ8gBh1os67Gh4r6LpwfySZYji5e/lRYJn/07OXGw6CIWUHkNbKCjlMaXA7OiWxmpK6KIPn
 3OlygIaN+ETbLkzAkwg==
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69f28d26 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=igV55USxk0bV0TlUbZYA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290231
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> From: "Stacey D. Son" <sson@freebsd.org>
> 
> Add os-ioctl-sockio.h with network socket and interface control ioctl
> definitions including SIOCGIFADDR, SIOCSIFADDR, SIOCGIFCONF, and
> related network interface ioctls with target_ structure definitions.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-ioctl-sockio.h | 240 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 240 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

