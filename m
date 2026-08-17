Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1452EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJ3x-0003Yt-Fj; Tue, 18 Aug 2026 08:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wwJ3v-0003Vh-Tb; Tue, 18 Aug 2026 08:37:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wwJ3u-000717-2Y; Tue, 18 Aug 2026 08:37:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IAVWUM2355685; Tue, 18 Aug 2026 12:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UL9IFO
 BfaU/clKhXme8sOAazBEUtsscNml+GIhZ/mjc=; b=oMT8bJEReh0EmAFaP7G9HP
 e/pj+gHlxR7TUff7uWpiXYx3U+zLTQr2uKoCAAwLfYUP5qXZpXFZXv8X+VOm3MSv
 IjbE7NjT2UWR52QmJbviFARKyiB+G76mRaH9Kv6JlYOTVYZUKOArW4VolOjz//2P
 H8D6Xb6Gw7OBcF1N/579Dw0t+u1lkl0DMDr9KzEbnhQIb+UM0zQlgbGDScoRNQ6c
 c5KsKxoyv4OCZ+tEOmdgW1ynYWz67IUK7ogWIQ/S2j/IuC+zpj0amqTkLTKq03T7
 LbZchkE1MoH1hl788YRP4ZywydVPfEjpFVhDOIhTSqRB3VneJIT4R7XAunnUqJAg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqr3va-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 12:31:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ICQKHI005403;
 Tue, 18 Aug 2026 12:31:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek35sp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 12:31:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67ICVRIC20578988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 12:31:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B03A5805D;
 Tue, 18 Aug 2026 12:31:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 974735805B;
 Tue, 18 Aug 2026 12:31:21 +0000 (GMT)
Received: from [9.61.88.99] (unknown [9.61.88.99])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 12:31:21 +0000 (GMT)
Message-ID: <77e4a58e-269f-4c90-8a1d-bbf89a889c35@linux.ibm.com>
Date: Mon, 17 Aug 2026 14:09:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 37/49] monitor: tighten monitor_printf*()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, zhenwei pi
 <zhenwei.pi@linux.dev>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-37-e53fc35bc550@redhat.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-37-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5MiBTYWx0ZWRfXxeP10mi5nXk+
 42JuJ8FBRrSfAYCu/Q4o7d7+QjXR0y0YhLBXkgd3jS+DNmCgivbuDm/ZDSs3n8sSKCYwwSS9DVv
 NgWoNA0BwgCQpVOd0YlV1AgDl+Yi6+o2mDjLiNhVnCu3Iau7D1S8g+hCEDt2R0SHK58wtGi1/5s
 RsoSkQaqsfxgejgt67fHbonxC2nqio0fdE54/b3h309WKFkCPv8jczyyFYUmhEuBrox4FrFb7wC
 PggyxsIl4jVNptZqWdfEykgaHsd7pCNOyBiZc63Zi4tyERkBaOFbTYD+VvrDqVjy3rsEtC+ZxFV
 syR9AFCpfomtfiYbRemhA1VR8Zb4KVxISW6kyI+L2CNsRt3eFSzkaEXWyNO+sowDrmMC7kBgTR2
 5tD9HUyfomfLDqaSHLjYIq6swzt3Ep8j+EJa7WICWbXLEoglP6kNvklJYaBlu+zXSSDds8nl6md
 PTudAuUQifZz7GHw46A==
X-Proofpoint-ORIG-GUID: G5eJ90vsRCcNC-bXB9XjB1i4CkNoQiux
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5MiBTYWx0ZWRfX/l7XvQu5FXvY
 757EDCutzJiMhhtpUOg8veUoUv7xm8vDn4iZni2l2SWZhtMOzb10+wUB8ZZ4Fm+mPM+dyZPA8iu
 wv2noNska5/BZi3NZrq0a2WXPePTskc=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a8450a3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=mY-fmJR8b8s-Z9VvxFgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WJt7z1CXoN-0E-GSYEQWlRq5_XUQN17s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180092
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 8/16/26 3:13 PM, Marc-André Lureau wrote:
> Rename monitor_printf->monitor_hmp_printf, monitor_vprintf->
> monitor_hmp_vprintf, and monitor_printc->monitor_hmp_printc, changing
> the first parameter from Monitor * to MonitorHMP * to enforce type
> safety. The implementation is also simplified: monitor_hmp_vprintf now
> directly calls g_strdup_vprintf + monitor_puts, removing the virtual
> dispatch via moncls->vprintf.
> 
> The dev_print() callbacks are temporarily using the MONITOR_HMP(mon)
> cast, they are fixed in the following commits.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> ...
>   hw/pci/pci-stub.c                       |   3 +-
>   hw/s390x/s390-skeys.c                   |   9 +-
>   hw/s390x/s390-stattrib.c                |  20 +--
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

