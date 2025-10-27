Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F860CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOMf-000534-O3; Mon, 27 Oct 2025 10:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vDOMd-00052Y-4Z
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:38:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vDOMX-0007am-SI
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:38:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDON25012185;
 Mon, 27 Oct 2025 14:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PIMwZR
 rn99y0wjN7TZfyGY2mfiFN+pnIrA2wnkv29sQ=; b=glCYvkGiMB5iiMN4CNI8Es
 BTtzvR7kWmzpfbY1EOdCwTNWxaeLSWRr5uMGmR6BEMlYRXSzCK5fOVKNG5rXPpix
 B6sthGYjEYGchSnkdkqQChsZbpRrLxovDNWdOEhYCZNLKMUQrh2SxVh1VBb0mgDp
 0X9sD2+trjvHJa8pzbA6wPkR1UXoTuu+P1HA8D4xonjw7PH9Gd42byicoA3fLBFL
 e0gRXg5SSoK2nLQqDn8Yga/xmBJW8cwlWUDLL/TYzqt8Pa9FnKtCZjCc0jipMzSx
 +h98qlhQ/D50L8X796iwriVcJYur/KP+F1rCiOOubQBK0pKiReSy+H4Wp00+QjXA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0myryaj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 14:38:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RB1g3w021587;
 Mon, 27 Oct 2025 14:38:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a18vrx5kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 14:38:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59REcGBu9896528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Oct 2025 14:38:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB58D58063;
 Mon, 27 Oct 2025 14:38:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BB0358058;
 Mon, 27 Oct 2025 14:38:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Oct 2025 14:38:16 +0000 (GMT)
Message-ID: <d2e887cb-5752-4ccb-a0ab-d66a655e6585@linux.ibm.com>
Date: Mon, 27 Oct 2025 10:38:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] migration/vmstate: stop reporting error number for
 new _errp APIs
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-4-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20251025202649.1122420-4-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tHCT5XVvd7bDbKUDaEfE6YScunuGFC91
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=68ff83da cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=__HPPSkZDRoaCIWA8v4A:9 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfX7loJy1KeRv6Q
 gUUuy4ASDeYAbHtuUegFLVkVKmzJNNCN2sqh2+xua+TB9N5pGgykVSORRVsLl4dKKcl1dWVpbFb
 9F96rDc1yEBxaT8vc07HuQfvSZOUNPF+3fy2CGFlUOFtod17/AuX/39JZvqW5he6XxcWmp9VGBQ
 dj+PsbRs1wk8Xp85Q65VRktWHT17J+NWxcYK5VqAV61e6bpIuc0jmVJrv9BH2mTdKuI8YxiuHd+
 nmKhS7hn5YGKPnt+lUDVCVLF3Egs/rT6tHlHXP6hXfsiqo0bBouL+M2jz9u/F/nHCs98/cxtq+K
 v9GtL6s6U9dRY+jx1Yq8UeZCJBAw/QqDwQ8p3HcF8RceB3dg+Ym63bhe3bUtjmqomKC82wIfmtd
 Z0I6icMZKQbEIaX2btNjYo5oLK3IVQ==
X-Proofpoint-GUID: tHCT5XVvd7bDbKUDaEfE6YScunuGFC91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 10/25/25 4:26 PM, Vladimir Sementsov-Ogievskiy wrote:
> First, the handlers should put all needed information into errp,
> we should not append error number here.
> 
> Second, the only realization of new _errp API is
> tpm_emulator_post_load(), which on some failure paths returns
> -errno, but on the others simply -1. So printing this additional
> number may be misleading. tpm_emulator.c needs a lot more work
> to report good error message on all error paths.

You mean in all paths or just the .post_load_errp path? In the 
.post_load_errp cases -EIO is currently always returned if called 
functions failed and return a -1. So their -1 does not propagate.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   migration/vmstate.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index fd066f910e..677e56c84a 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -157,9 +157,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>           ret = vmsd->pre_load_errp(opaque, errp);
>           if (ret < 0) {
>               error_prepend(errp, "pre load hook failed for: '%s', "
> -                          "version_id: %d, minimum version_id: %d, "
> -                          "ret: %d: ", vmsd->name, vmsd->version_id,
> -                          vmsd->minimum_version_id, ret);
> +                          "version_id: %d, minimum version_id: %d: ",
> +                          vmsd->name, vmsd->version_id,
> +                          vmsd->minimum_version_id);
>               return ret;
>           }
>       } else if (vmsd->pre_load) {
> @@ -259,8 +259,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>           ret = vmsd->post_load_errp(opaque, version_id, errp);
>           if (ret < 0) {
>               error_prepend(errp, "post load hook failed for: %s, version_id: "
> -                          "%d, minimum_version: %d, ret: %d: ", vmsd->name,
> -                          vmsd->version_id, vmsd->minimum_version_id, ret);
> +                          "%d, minimum_version: %d: ", vmsd->name,
> +                          vmsd->version_id, vmsd->minimum_version_id);
>           }
>       } else if (vmsd->post_load) {
>           ret = vmsd->post_load(opaque, version_id);
> @@ -441,8 +441,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>           ret = vmsd->pre_save_errp(opaque, errp);
>           trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>           if (ret < 0) {
> -            error_prepend(errp, "pre-save for %s failed, ret: %d: ",
> -                          vmsd->name, ret);
> +            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
>               return ret;
>           }
>       } else if (vmsd->pre_save) {


