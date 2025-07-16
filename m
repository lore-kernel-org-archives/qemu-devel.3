Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA730C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 08:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubx5d-0006Nl-K0; Wed, 16 Jul 2025 04:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1ubx5G-0005ms-LW; Wed, 16 Jul 2025 04:01:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1ubx5B-0006v4-73; Wed, 16 Jul 2025 04:01:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FKYpWM016564;
 Wed, 16 Jul 2025 08:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=56sGgF
 WHJvMwcvHyke0RqrUPhZ0POB14rvLCip72W8g=; b=JSvAYvkqhKJ2LjyxKt6PV0
 n8yNG9HamGlbQdopVk5KjMNbAVDefya8FB+OFeK8w+FpIB087Vn0jjMRPKVM2sny
 QHklJU2rfUJzxxEDyhLP7pLI6/6BweP6nciEIsjbNfhKiTy6lw4cgUH2xCdo4KfM
 iGMsxB/BmlVkFiUMBv5rdI6yl4NQd4QXma215cMdYyak+6J+eB/XIiztKsSnEjdK
 F//EPdru2M6+1St44nyZmDw8THzGa3HA9iIj7msudB5br+XWQt0+Qjjbhtxw3tbP
 n0GwTIy8t0LCAGbl8ujIQpdXImMVGA35qvg0yKGF4KyzqZzV+kyUE/+cLaot/kBw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4u3n98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 08:01:38 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56G7xIpH019451;
 Wed, 16 Jul 2025 08:01:37 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4u3n8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 08:01:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56G5U2Er031904;
 Wed, 16 Jul 2025 08:01:36 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v21u6jeu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 08:01:36 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56G81Zds28836378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 08:01:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94315580D1;
 Wed, 16 Jul 2025 08:01:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DFBB580CF;
 Wed, 16 Jul 2025 08:01:25 +0000 (GMT)
Received: from [9.39.30.73] (unknown [9.39.30.73])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Jul 2025 08:01:24 +0000 (GMT)
Message-ID: <96da7431-0c99-4f9e-b7eb-9fe759ba3dfb@linux.ibm.com>
Date: Wed, 16 Jul 2025 13:31:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] vfio/spapr.c: use QOM casts where appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-7-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250715093110.107317-7-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68775c62 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=64Cc0HZtAAAA:8
 a=VnNF1IyMAAAA:8 a=AaRrkq5CDUwCYl7pSLkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TYmNIJPmYpCrkYteTJsIt0Cvanynskve
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA2OSBTYWx0ZWRfXyc/gYvT/aJ4j
 jIOfqyaGJgpg7GQk7nruhtB5Uno6o8m9/oMmdnF/N9gum4+EkoClQO/ZwDG1y9ZXCIsciz6KscI
 RQK5EQFO2p/4Ey7+8nruBowahXzKH7nWH6wuzyFbmKBLvE/vq3WjJPfDyqbTyl4Cf+I3v4Ln/HE
 mGrlBmrfxCD95IM9MxwI83PIT1GSw+LQ/CEVN3HuqR99BkAxYNbK0v4d7bKmjOsad+zAWnuliGI
 jMJJBj6leaBtg0sFA3rV1Q5xdsWKFpKffm0G3+VZCk5fezOGZX7aqu2gnB2R8lsrEWJeK2juAsr
 ahXvA5XbJpLvwpRU6e/xEeHMIq0Z2mnG6/lBx+bi2VMUkUDftA6ebY4yFTKCQcv5TQFtCPcDaHt
 PgB6+ZkqNa6ZFnzcwNF1MuuDCgyx8gTdl1UTMUb70IH6n94HIXnediFuDLcxv86Lio/sPAFX
X-Proofpoint-ORIG-GUID: VxvDy98nkhpK5jLekVbqaLmv-BeS6ASA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160069
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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



On 7/15/25 14:55, Mark Cave-Ayland wrote:
> Use QOM casts to convert between VFIOContainer and VFIOContainerBase instead
> of accessing bcontainer directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/vfio/spapr.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 564b70ef97..c41e4588d6 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -62,7 +62,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
>       VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
>                                                     prereg_listener);
>       VFIOContainer *container = &scontainer->container;
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>       const hwaddr gpa = section->offset_within_address_space;
>       hwaddr end;
>       int ret;
> @@ -244,7 +244,7 @@ static bool vfio_spapr_create_window(VFIOContainer *container,
>                                       hwaddr *pgsize, Error **errp)
>   {
>       int ret = 0;
> -    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
>       VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
>                                                     container);
>       IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> @@ -352,8 +352,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>                                           MemoryRegionSection *section,
>                                           Error **errp)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
>                                                     container);
>       VFIOHostDMAWindow *hostwin;
> @@ -443,8 +442,7 @@ static void
>   vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
>                                           MemoryRegionSection *section)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
>                                                     container);
>   
> @@ -465,8 +463,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
>   
>   static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
>                                                     container);
>       VFIOHostDMAWindow *hostwin, *next;
> @@ -484,8 +481,7 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
>   static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
>                                          Error **errp)
>   {
> -    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
> -                                            bcontainer);
> +    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
>                                                     container);
>       struct vfio_iommu_spapr_tce_info info;

