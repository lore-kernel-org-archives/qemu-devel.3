Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99A2C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 20:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9rv6-0000me-4i; Tue, 29 Apr 2025 16:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1u9rv2-0000mN-Ro
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:51:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1u9rv1-0000u0-65
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:51:08 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TJZM0J032518;
 Tue, 29 Apr 2025 20:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YaX+wX
 QChQ8Jjd/DruBiAlxxUS/fyOCfhCYXozsn2vk=; b=mEY5qFJdi3CMn1n/jZGPSk
 LQp5koDCsmcWY0rRe3dFcczPIfEwm461p6yW2/9tMvxDA1CACtoUaIj0SlU6J3lr
 s7fgD78rdLq8q2kxzfg+8RF/7tJpebosMsO0wrGnoyaX5yM//Fj/3FKBhxCaSBZr
 6ilavHPiFYlFI3IYF74ljK2WHu0xAxs9tlwBBPlaYWmsfNvAwYlRafpw+JYlLuUz
 CgqydNgW3iSTTis3VowCo2dVgfGfhUut9XhuuXGY+cGra3ewJLwpA6sSdab9zp5z
 TQZcB7YvIimTXrv9N4rAQhD89B+WAtCilFY3VVRPxT4RN5RblQwbXGYAqYUL7qYg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46avpkayut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 20:51:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TKn821016174;
 Tue, 29 Apr 2025 20:51:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70d5hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 20:51:00 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53TKoxiM1245778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 20:50:59 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90FAE58054;
 Tue, 29 Apr 2025 20:50:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3E435805A;
 Tue, 29 Apr 2025 20:50:58 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Apr 2025 20:50:58 +0000 (GMT)
Message-ID: <e3d5d5ca-f0d8-4f42-a4a4-a6e2cdfddcf3@linux.ibm.com>
Date: Tue, 29 Apr 2025 16:50:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] qdev: make release_string() idempotent
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250429140306.190384-1-marcandre.lureau@redhat.com>
 <20250429140306.190384-2-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250429140306.190384-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=68113bb5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=m7fl6o8Nl9rBM92gsO0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: K1kPavJeg1sm4xP1OkuHfKRKbwpLSsyw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1MiBTYWx0ZWRfX2gZiPkeQP8Bx
 1tIArUd/AGrjPmi3k4WbNZ+XrffNurtRL3fbIzMoGAdsWbwP9BZh871fCNhdmc+ABYMhAIjP+Hi
 MjAGADgRMdl1OKVdI+7ooyjZi72kEGTcYZohoOnu1Dx4VRVNLyoPTre7I8+sE6vxtz6zp/0CJzY
 V+njHJ+/93O8mrcpD21uQVJNHflSq7G1mBobuNE07KiTi1J0SkjOh5jYonzsS66lW5Qz4hX81gu
 VTSs8VP2NHPDMWXwakKArV1BTrGNXoe1zbFPNqohKZKOA4OgnXkFjX+maffo9vXxlsjnCWwLcpM
 8I6RfvMzBt2Tzxrn3a+WgZ9ix8pr6jxSiLwN6f5lmzfIf2LXb0+Bk/VMMT+8spr1F2hkRcZXfXW
 vsFuAOaRw/aZ0AB3Sg4L5d3Jf4MW9FSw7xTaj9p59lZ4zHjAk50JuxmE4ZI8+T44VFa3pcAg
X-Proofpoint-GUID: K1kPavJeg1sm4xP1OkuHfKRKbwpLSsyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=924 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290152
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/29/25 10:03 AM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> So it can eventually be called multiple times safely.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/core/qdev-properties.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 147b3ffd16..bad111833c 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -484,7 +484,8 @@ const PropertyInfo qdev_prop_usize = {
>   static void release_string(Object *obj, const char *name, void *opaque)
>   {
>       const Property *prop = opaque;
> -    g_free(*(char **)object_field_prop_ptr(obj, prop));
> +
> +    g_clear_pointer((char **)object_field_prop_ptr(obj, prop), g_free);
>   }
>   
>   static void get_string(Object *obj, Visitor *v, const char *name,

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


