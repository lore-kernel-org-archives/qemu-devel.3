Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983B2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ51G-0003I4-6r; Wed, 31 Jul 2024 04:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sZ51F-0003Gc-0M; Wed, 31 Jul 2024 04:49:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sZ51B-0004e6-QS; Wed, 31 Jul 2024 04:49:12 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WYm1G53Xwz6K8C8;
 Wed, 31 Jul 2024 16:46:58 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
 by mail.maildlp.com (Postfix) with ESMTPS id 61257140CF4;
 Wed, 31 Jul 2024 16:48:56 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 09:48:56 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 31 Jul 2024 09:48:56 +0100
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin"
 <mtsirkin@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH] accel/kvm/kvm-all: Fixes the missing break in vCPU unpark
 logic
Thread-Topic: [PATCH] accel/kvm/kvm-all: Fixes the missing break in vCPU
 unpark logic
Thread-Index: AQHa3qJBk0Exld31N0eXTFVI7pTjNrIIr9WAgAffXcA=
Date: Wed, 31 Jul 2024 08:48:55 +0000
Message-ID: <ae5fa879bb7d416b92face2dcf9045fd@huawei.com>
References: <20240725145132.99355-1-salil.mehta@huawei.com>
 <20240726113355.731e61fe@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240726113355.731e61fe@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.153.133]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

A quick check and a gentle reminder, has this patch been accepted?

Best regards
Salil.

>  From: Igor Mammedov <imammedo@redhat.com>
>  Sent: Friday, July 26, 2024 10:34 AM
>  To: Salil Mehta <salil.mehta@huawei.com>
> =20
>  On Thu, 25 Jul 2024 15:51:32 +0100
>  Salil Mehta <salil.mehta@huawei.com> wrote:
> =20
>  > Loop should exit prematurely on successfully finding out the parked
>  > vCPU (struct
>  > KVMParkedVcpu) in the 'struct KVMState' maintained
>  'kvm_parked_vcpus'
>  > list of parked vCPUs.
>  >
>  > Fixes: Coverity CID 1558552
>  > Fixes: 08c3286822 ("accel/kvm: Extract common KVM vCPU
>  > {creation,parking} code")
>  > Reported-by: Peter Maydell <peter.maydell@linaro.org>
>  > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>  > Message-ID:
>  > <CAFEAcA-3_d1c7XSXWkFubD-
>  LsW5c5i95e6xxV09r2C9yGtzcdA@mail.gmail.com>
>  > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> =20
>  Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> =20
>  > ---
>  >  accel/kvm/kvm-all.c | 1 +
>  >  1 file changed, 1 insertion(+)
>  >
>  > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
>  > 0aa4b4624a..c181297f00 100644
>  > --- a/accel/kvm/kvm-all.c
>  > +++ b/accel/kvm/kvm-all.c
>  > @@ -362,6 +362,7 @@ int kvm_unpark_vcpu(KVMState *s, unsigned long
>  vcpu_id)
>  >              QLIST_REMOVE(cpu, node);
>  >              kvm_fd =3D cpu->kvm_fd;
>  >              g_free(cpu);
>  > +            break;
>  >          }
>  >      }
>  >
> =20


