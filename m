Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65787CA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDj7-0001MM-F1; Mon, 28 Sep 2026 11:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBDj1-0001KT-R9; Mon, 28 Sep 2026 11:57:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBDiz-0006Lo-Ey; Mon, 28 Sep 2026 11:57:07 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SF5T8E1451900; Mon, 28 Sep 2026 15:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=08TI/x
 GAosx1EIFoarOr0DRKCtuGhKzmks1N8fy6fRI=; b=aPRVbWdYfYwZ6LHGg/9qSY
 m1YC0lVFv5IVzYrnAkgWQqpMMqp+Q+abhJPXSzo3cJ2K5pM4JaqENpw4bm7/rO7R
 gmZJOHnUCUFExNzDA1nbUcu1wOa5rm6c6vjVXcSVkZCZ0xqrL6dwXP8ZfURvWc9u
 lJTUJm+J3ZS8FVsAeLb9yn9/MwXdxLG2e5Mps8R9sOdJrR3FzXjwJtIS1EUt8X/y
 it3FZjM/By0ZHTh9dHUszVb1LUFPw4W565D5CyS2df5XpPq5f9VAoBF/Y5aSplrm
 JXupg1TqBfQ7lIr/q8Q84vYLfDgUkNUxlVkgxBt8Z+/QapLli0NbjmUio/nk/L+g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt20f5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 15:56:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEla8E261365; Mon, 28 Sep 2026 15:56:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw62by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 15:56:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68SFutAM31589012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 15:56:55 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF3D45805D;
 Mon, 28 Sep 2026 15:56:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DC0358052;
 Mon, 28 Sep 2026 15:56:54 +0000 (GMT)
Received: from [9.61.5.156] (unknown [9.61.5.156])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 15:56:54 +0000 (GMT)
Message-ID: <d6a406de-0d98-4d26-a5c1-2b795dbfd3e3@linux.ibm.com>
Date: Mon, 28 Sep 2026 11:56:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] s390x: Add support for virtio-net-pci boot device
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260924222949.147720-1-zycai@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 xsFNBF7EiEwBEADGG0EtNKnjp+kQfEVqlqxXoBHjnaQptFpMgxNlz2GtqOujY6nzEWnybIXY
 63XUTmMS/tWUf2DTbNCNoWwumGM/I2Gj1uGyMnc4Q477BQlL/e2/9MRaut11rwHsi4zmWylc
 jO0eFTSLFA8yFBj9osT3uZzk5TwWkD8sf+rD916fFVk0G39uYEd5sjEzjeOf9/dwXyZpjJY6
 api1pUHEw7weRvOnllJAfIKFz+KoR6d7ezvMF9zOYHF73FGeSVIYoIEUhA5Cdg60rSlTtHb2
 cftex3/cEapvY5bK3CKJ33BVVK10Bht9XfVaA/AOcg/3o5ZbhSIwz4xScGsEVf/Yr368YMdr
 3VkCZrmN2ppmVRz/RvAmCyItnmzoVDlSREA6Faw6S0x8Oi7lN0cKh2hy9VPcVupraXJZrdAh
 GtdU+jrJvSbpdsrX8F7K3RwynbiqGrqC0izGla04hhtei/uwthatglukuxep4PknDGbzijg8
 Ef7A8t3qEVklUDrsnNPN5HbR9QQdeF0HuWsDTfILbZv1MICfOK3BCDeT5mJWaJCoQ2rbuljM
 e1hFSt+mr7GV4h6NcBE+uGIqDSzQORtyTo0uBV4et3cSE84JxOfXBMrj0TlL1855JaIoPWEN
 uhDRB/dHW8+Fumq2du5hLcaXPka+MO26cNVKVLF0/JjwMTZ9bQARAQABzSJFcmljIEZhcm1h
 biA8ZmFybWFuQGxpbnV4LmlibS5jb20+wsGuBBMBCABYAhsDBwsJCAcDAgEGFQgCCQoLBBYC
 AwECHgECF4AdGGh0dHBzOi8va2V5c2VydmVyLnVidW50dS5jb20WIQTSxgUEyej1aM/lh7U4
 J7IScb+VYgUCYel8TgAKCRA4J7IScb+VYsHAD/9BSQj7HeJf90PttOmVh35Bb4QyHLZ4g+9x
 waM59JCKGbiURuNRIGnoRarYXHk6vfy19v8v56Dy1IOlKWaRnizp5Mw9zXBBTCs4fgNbOzY/
 SggFY2UzcziXDG29X9zznq5LgY1Jf/cwm1O+rn89GKCZWZhLEB2wKzBj7hum7NBdW+lxfVwp
 2qONGDerttWDwAHxJ995k9aDJahq9kIKEMEZbrTQ8JI8KZGoox6+HA04EhoNzxvbV0J+/gLJ
 2DkvxN5/xmcD3z+s8B5ev3NarOF17AIA9oCdfu8CPAupcNqJW86m19P5q6AyRB2ZLyAIAAhr
 HCXrnlh/8HJW1yCOVXxprFdpg1SX1fuArjbFAh53vVVDfkZlwHeTeE7+3y1rtDLfy830pqdD
 ymv94yey2y1+iZBdbaW0fSC/JkjkOCy8oZawkH3geM4MXV4ze4gbBH6BhxW/0gbEYjnLm3FA
 53JcXwhHQFPWIYEYYPvATJi0JUiMY1Znkm3QBWDOCXSrG0tHpAclBa9L40zLRwA1h9YOMFEs
 qvKijUdvcDf4sTdJ+A6YL66grzul5vNt06NlqsI8HUDHE6vghqyWxupCav2+9b1BuLie++er
 b8OCo5n3TUHsVMjYJEePU1EkcCa84dCm+CXqPthgRv0sbe4UQEd/qUoVMdWj7Q7FL96mBn0G
 zM7BTQRexIhMARAAp+k1sC4y7Wtwjqtfu9wIihvY/Vot0v/sKg8CRGRIIRGLiCeA9o+2ZlxC
 jYztT3Leri5Vo5z09OmRMvoFLJjcHMCG5sYeZwOWNAbeuAxGkIMDSB4pLl3t2c+1PQuMBCd7
 +mRZFaMEJfT3nhdUKxy2rp1+YucnA67xGXUJCiD5l9UmhPqa7SAYlpMAqDz7cmBo25c/UNm1
 Tpwjrh70jq/4guV5gnprawH8nkRjdKH1JvKWvkuaB7FNZ9IuSHlWclcQX4IQMsaxsU2emAbP
 VYv7l4YNlKfdlJd8tuEodjuMLOBnr7e9H0hVNUWGFN9bkBNRu3zi/jvhyu15Iu4euR/WdVNu
 2K2iYxIfiGMnv0F/a6R1bm10lCJrjyf23J8DYIeH4YmHvOOqYFkq3DWOctlXbb3+aABqjYt3
 mkiOLXeplqbo/m3rWcGNd8Q/d1aVA0wm5+Nt3RdSuXG2FHOFdVUQKPLpf1NUH/LInBhS/9Ys
 ajm6tWXKv7hxwWmyz0u/th6gUra3KpARB1ypebWHULLNzKGwVS81XNs76QhXwX04cyiwLqKb
 WqLqJKThz+rLa09Ap+eO/UzPfFXvWYWfTeFRIQ/tKF332ZzRR8Xrh/fk//YXyRfpoE/7i5uz
 ve0HZWp5jXg9Yb+S6g0+XUKznnN9B8WLLCcuRIuSa722070v7KsAEQEAAcLBdgQYAQgAIAIb
 DBYhBNLGBQTJ6PVoz+WHtTgnshJxv5ViBQJh6XwwAAoJEDgnshJxv5Vib28P/1BYT5gvjuEB
 A80AXo/IqycicXxDJtrfmyw4COP7bi7AuiDcKyA1wRzC51paKwPFB8Unk2GvG4DV6aDmGTJY
 +GeCYgthQ+znW461S8B6GqDCAQt2VDNNFVU+gTuh7vYQOgt/OjtiiAvMIJBVRbXoNSRokKOF
 tpTiXf3ZOsAkot5ZmxE0TV94v18sp/bC84YvFyaxpw5bilT7bmpcq8B8/3yb0kmy6gXLcQAp
 OnomV3sQBmm050amiO3tvxMNv8J71AvNdTG/rojTDKUl2Nw4f+aw4nVw874m2XpEe9JGRw54
 5d2dN8k3GpzcTBe9fCQPOFHOGkQ1CgptDkQuQVD3DIeNzQjXf6xehEymIKnLOkukT2smV0zh
 fj08z7eiv+dsmnBsbhdM6DKU8qIgkTu77TfHUKjjOY/Mj0YHPuH/J4b1AZFxBhGP0BTKiB2W
 CR6/49XVKvY1jHxgadSSNCD+f7tEqUNBlVl+P0emMJaYpK1+gy88ma4g3nvyOVe/VzDPjGDC
 4HX/6RAR4Dbzry6/epWTTji+7ApzePzmJzPcuzD31ICsgT2dJ6ydxyxxXikBFJqx6BPOF+u+
 1BtKcTz1ek3I2sWvBM1V5CKaFw7iNXxS6HgS2scuAT2awKq+BQlt778/GfBWpXonfqixMvit
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260924222949.147720-1-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r6o63WvaqKlLz2OQbQr2Pybtn0sP_CSa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfX+H0zmIWEUgd9
 rT76iEP64SGnpci1Fa/8j3Vccj3hZqS55hl7HWjaOXDtCeULi5RKGVdNesrXN5rKatN6sA2iyNC
 IJoc6eiOaNAVypSVx13DgL8ShwpVHrZhsXAwv7z33yz9EYAvNpr5G0EeyAxTBoB5N75LJBbcJaC
 KefhELPgf/kyiZlZaiurI0dBN13oKESkAAqHJLTkAdb+F125gGWJR8V1U7WJaGQEopO7+H/bENk
 kcyUQ3oFVHlZR0LRbnXW7bpcQkWlOKeiSe6avzhISky2HxPs8tz+Dcu2A0s17i8RbiIA510HPTO
 Fu+mMcgDqAlCn9il66B2gx8JKHUYF4eZZftKjN4bMaiV0o8RJN/a6DnQtNhFJeiU2lz4uqbl5bt
 EhTXsJbwJp6BH2JMHvjMvbega34CB8wJSzyJrX9M/P30MA2Lz77qz+W5oUtB8oNTyCVSccE8x4l
 febtBqvEve2NK7+gftw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfXxTQ0zUTX9+nT
 +no/kO4dmOVNtRbue/s5n5La0Mt8LYhhde3uM/DWmk0eUvoYBRAdkiyyvX3p/UgpV5bDSWFr7uY
 +/0QbDc2diwALBmuIGQHcikgIn6q+OU=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6aba8e49 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=FvShNh-knPtzGHUzxmUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r6o63WvaqKlLz2OQbQr2Pybtn0sP_CSa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/24/26 6:29 PM, Zhuoying Cai wrote:
> changelog v4->v5
> 
> [PATCH v4 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci IPL
> - Fixed rebase errors
> 
> [PATCH v4 6/8] tests/qtest: Check s390x boot device support in pxe-test.c
> - Reworded the log message for strings found in the BIOS
> - Added a comment explaining the assumption that netboot support always
>    includes virtio-net-ccw support
> 
> [PATCH v4 7/8] tests/qtest: Add s390x virtio net PCI test to pxe-test.c
> - Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> ----------------------------------------------------------------------
> 
> This series enables network booting via virtio-net-pci on s390x.
> 
> Refactor virtio-net to separate virtio-ccw specific logic and add
> support for booting from virtio-net-pci devices with proper endianness
> handling. Add support for the loadparm property during network boot.
> 
> Add corresponding test coverage to verify correct network boot
> functionality with virtio-net-pci devices.

Applied for 11.2; thank you!

> 
> ----------------------------------------------------------------------
> 
> changelog v3->v4
> 
> [PATCH v3 2/8] pc-bios/s390-ccw: Add dynamic net header size handling
> - Fixed the UAPI path in the commit message
> - Removed the commented-out num_buffers field from VirtioNetHdr
> - Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> - Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> - Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> [PATCH v3 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci IPL
> - Resolved merge conflicts
> - Added a comment in ipl_pci_device() clarifying that all PCI devices
>    use the same shared setup
> - Updated the comment in netmain() to clarify that PCI devices do not
>    need specific network setup
> - Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> [PATCH v3 5/8] hw/virtio: Add "loadparm" property to virtio net PCI
> devices booting on s390x
> - Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> [PATCH v3 6/8] tests/qtest: Check s390x boot device support in pxe-test.c
> - Reworded the log message for strings found in the BIOS
> - Removed the comment from s390_bios_has_net_ccw() that assumes
>    virtio-net-ccw is present
> - Tested-by: Joshua Daley <jdaley@linux.ibm.com>
> 
> [PATCH v3 7/8] tests/qtest: Add s390x virtio net PCI test to pxe-test.c
> - Added a comment clarifying that the presence of the string indicates
>    virtio-net-pci support
> - Tested-by: Joshua Daley <jdaley@linux.ibm.com>
> 
> [PATCH v3 8/8] tests/functional/s390x: Add tests for virtio net PCI in
> test_pxelinux.py
> - Added "_ccw" to the existing virtio-net-ccw test names
> - Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> changelog v2->v3
> 
> Added a new patch, "tests/qtest: Check s390x boot device support in
> pxe-test.c", which gracefully skips the test when the network boot
> device is not supported by the bios.
> 
> [PATCH v2 1/7] pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
> - Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> - Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> - Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> [PATCH v2 2/7] pc-bios/s390-ccw: Add dynamic net header size handling
> - Removed VIRTIO_NET_F_MRG_RXBUF_BIT, as it is never negotiated.
> - Updated the commit message to note that the same structure mappings
>    are replicated as defined in the UAPI.
> 
> Re: [PATCH v2 3/7] pc-bios/s390-ccw: Introduce virtio_tswap helpers
> - Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> 
> [PATCH v2 4/7] pc-bios/s390-ccw: Add support for virtio-net-pci IPL
> - Simplified virtio_pci_get_net_config().
> - Removed cmd_vr_idx initialization for net devices.
> - Added a comment indicating that byte swapping is required when other
>    fields are used in the net config.
> - Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> 
> [PATCH v2 5/7] hw/virtio: Add "loadparm" property to virtio net PCI
> devices booting on s390x
> - Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> - Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> 
> changlog v1->v2
> 
> pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
> - Removed the virtio_net_setup() dispatcher; netmain.c now calls
>    virtio_ccw_net_setup() directly
> - Improved the error message to be CCW-specific
> 
> pc-bios/s390-ccw: Add dynamic net header size handling
> - Defined VirtioNetHdrMrgRxbuf, which includes VirtioNetHdr and a
>    num_buffers field
> - Defined header size constants using the sizeof() each struct
> 
> pc-bios/s390-ccw: Introduce virtio_tswap helpers
> - Edited the commit message to mention that only 16-bit helper function
>    is used in this commit
> - Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> - Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> pc-bios/s390-ccw: Add support for virtio-net-pci IPL
> - Updated the commit message to change "adds" to "extends" when
>    describing endianness handling
> - Removed net specific setup/find for PCI device
> - Checked for virtio initialization failures during network device
>    initialization
> 
> hw/virtio: Add "loadparm" property to virtio net PCI devices booting on s390x
> - Edited the commit message to avoid implying that PCI netboot will fail
>    if a valid loadparm is not provided.
> 
> tests/qtest: Add s390x virtio net PCI test to pxe-test.c
> tests/functional/s390x: Add tests for virtio net PCI in test_pxelinux.py
> - Tested-by: Joshua Daley <jdaley@linux.ibm.com>
> 
> Zhuoying Cai (8):
>    pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
>    pc-bios/s390-ccw: Add dynamic net header size handling
>    pc-bios/s390-ccw: Introduce virtio_tswap helpers
>    pc-bios/s390-ccw: Add support for virtio-net-pci IPL
>    hw/virtio: Add "loadparm" property to virtio net PCI devices booting
>      on s390x
>    tests/qtest: Check s390x boot device support in pxe-test.c
>    tests/qtest: Add s390x virtio net PCI test to pxe-test.c
>    tests/functional/s390x: Add tests for virtio net PCI in
>      test_pxelinux.py
> 
>   hw/virtio/virtio-net-pci.c              |  1 +
>   pc-bios/s390-ccw/main.c                 |  2 +
>   pc-bios/s390-ccw/netmain.c              | 73 +++----------------
>   pc-bios/s390-ccw/virtio-ccw.c           | 62 ++++++++++++++++
>   pc-bios/s390-ccw/virtio-ccw.h           |  1 +
>   pc-bios/s390-ccw/virtio-net.c           | 66 +++++++++++++----
>   pc-bios/s390-ccw/virtio-pci.c           | 20 ++++++
>   pc-bios/s390-ccw/virtio.c               | 27 +++++--
>   pc-bios/s390-ccw/virtio.h               |  4 ++
>   tests/functional/s390x/test_pxelinux.py | 71 ++++++++++++++----
>   tests/qtest/meson.build                 |  1 +
>   tests/qtest/pxe-test.c                  | 96 ++++++++++++++++++++++++-
>   12 files changed, 328 insertions(+), 96 deletions(-)
> 


