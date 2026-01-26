Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDAED1951F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUdn-0000dz-C8; Mon, 26 Jan 2026 17:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vkUdY-0000aD-JD; Mon, 26 Jan 2026 17:00:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vkUdV-0000Rh-Rq; Mon, 26 Jan 2026 17:00:43 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QAQrJV026370;
 Mon, 26 Jan 2026 22:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YcjPKo
 Iyha4oGY6z9yjZIyNKomcEQ449bfxdgeXAskc=; b=XOYySv+8Rj17pX0AgT5aU1
 DQPz0+SA8RwztINh70YcWsJx1VelP86QWdQEXBF+9dxQLnMlYYmPWzrJI6MRpM4X
 R7tcY00Rvl8OasBpIuOPd2k+iKhJVUP50TYT5jj5AiBSfv1qJg08DqMi4OkUQkRg
 BxzT0pvi8WJQ6j+/X9KRjrdiXAX6nHJUiXJWkTo4ogmT8YRUhnr2q6RM7dN9v5NU
 YktIL0GdbVQakTgSdaWnF/epk+t+ySEpcEgAuVUsOdmweT+WN1edzP9juPhRJbrS
 Dg0Xd5EWw19ULZ+ratnZUBMz94eTUlNpAyg+9Q/J0LqMmBLeVdIfRdmnFYL8mfpg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmh4kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 22:00:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QKbs8P006707;
 Mon, 26 Jan 2026 22:00:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy6c6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 22:00:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60QM0Tsk60817870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jan 2026 22:00:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D84C20043;
 Mon, 26 Jan 2026 22:00:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8543920040;
 Mon, 26 Jan 2026 22:00:28 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.22.119])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 26 Jan 2026 22:00:28 +0000 (GMT)
Date: Mon, 26 Jan 2026 23:00:26 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Thomas Huth
 <thuth@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "open list:virtio-ccw"
 <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v4 08/23] virtio: move common part of
 _set_guest_notifier to generic code
Message-ID: <20260126230026.2664d565.pasic@linux.ibm.com>
In-Reply-To: <26198787-a1da-4858-8656-f5006d153d6e@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-9-vsementsov@yandex-team.ru>
 <20260124000624.1bd7c9c1.pasic@linux.ibm.com>
 <26198787-a1da-4858-8656-f5006d153d6e@yandex-team.ru>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6977e402 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mkMtH7XpAAAA:8 a=6R7veym_AAAA:8 a=eAaatNw17JgYhb5s72wA:9 a=CjuIK1q_8ugA:10
 a=WtO8poqlptoA:10 a=I9Slk6e--tAXHahELIuT:22 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: Tyzt7He5sYxiQrQYW7lg_Orqq0EbdREj
X-Proofpoint-ORIG-GUID: Tyzt7He5sYxiQrQYW7lg_Orqq0EbdREj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE4NiBTYWx0ZWRfX0/z7lwJKCSgO
 KDCx597bmfyaSLCK0N6WC6Q9Js0kqkw0vMhCcNZm0vlcPt3OuoHXN8b81YR+v2RlIkQJeP4yT7W
 3oRji/0LdQedOOrvSDVe8pHKpUiBaUnux6bH8kWkROPwg8IsN4UiWpJ3IWGLxEqFYaNvXB+8soy
 ZvHEP3CNXbXQJgkDnHBKH/L1K62NLavwBRwmmEInnS2gNyCAnTzjYITj2scVocCZAos7jUI/fxj
 rf3fOIaDXJ6DlAqi80xBLe/QAAUl8CMWeQdaqce1zfzASuYv7UQqKsJ6iFJFTHyhbgow4d0AMAD
 HyKDNyjKfCKGsdwA6l8XiSRKFJBMYoNat8JshD3ImQHLlWrnwPtfF6Tq0XWMUutnx+o1zUhikws
 kQzCtl3vUtO2Pl4QcuhnWPkIfrB44aL6fFjtLqwbEc83JttAPxxV1fqUIGbVhXO0U2S8KtthiXr
 Tv9YJZPWohOdIuSIIUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601260186
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 26 Jan 2026 19:40:09 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:

> >> +/**
> >> + * virtio_queue_set_guest_notifier - set/unset queue or config guest
> >> + *     notifier
> >> + *
> >> + * @vdev: the VirtIO device
> >> + * @n: queue number, or VIRTIO_CONFIG_IRQ_IDX to set config notifer  
> > 
> > Semantically are mixing queue numbers and interrupt indexes here.  
> 
> That's preexisting logic in virtio_pci_set_guest_notifier_fd_handler().
> 
> But, you are right, that's doesn't answer the question, is it good to share
> the logic with mmio and ccw.
> 
> Is config notifier only pci specific, or similar feature may appear in future
> for mmio and/or ccw?

AFAIR there is no  notifier for ccw. A possible explanation for
that is, that AFAIK that config space notifications (device -> driver)
are always classic I/O interrupts while queue indicators can be so called
adapter I/O interrupts and irqfd is only available for adapter I/O
interrupts. 

If you like you can have a look at 
"4.3.2.6 Setting Up Indicators" in
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-1940003

I see no reason why virtio_config_guest_notifier_read() based, i.e
!irqfd virtio config notifier should not exist or would not work. And I
guess it is needed for certain vhost things. But nevertheless, I can't
find the place where a virtio-ccw config notifier is set up.

Eric, what is your opinion on this? My current thinking is that
virtio-ccw not having a config notifier is basically a bug.

Regards,
Halil

