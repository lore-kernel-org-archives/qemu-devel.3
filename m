Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A4DCA0EEB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 02:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoYPS-0000yS-6V; Tue, 19 Aug 2025 22:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxinxin.wang@huawei.com>)
 id 1uoYPQ-0000y5-F0
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 22:18:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxinxin.wang@huawei.com>)
 id 1uoYPM-0000Hr-Ny
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 22:18:40 -0400
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c695x3K67z2TTLR;
 Wed, 20 Aug 2025 10:15:33 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
 by mail.maildlp.com (Postfix) with ESMTPS id 3161A140277;
 Wed, 20 Aug 2025 10:18:22 +0800 (CST)
Received: from dggpemf200011.china.huawei.com (7.185.36.152) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Aug 2025 10:18:21 +0800
Received: from dggpemf200011.china.huawei.com ([7.185.36.152]) by
 dggpemf200011.china.huawei.com ([7.185.36.152]) with mapi id 15.02.1544.011;
 Wed, 20 Aug 2025 10:18:21 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Wang Xin via <qemu-devel@nongnu.org>
CC: "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "Huangweidong (C)"
 <weidong.huang@huawei.com>, xietuo <xietuo@huawei.com>
Subject: RE: [PATCH] target/i386: Add support save/load exception error_code
Thread-Topic: [PATCH] target/i386: Add support save/load exception error_code
Thread-Index: AQHcERnAAEd2DVcRs0ioMyqOSyVj9bRpk3YAgAE2+GA=
Date: Wed, 20 Aug 2025 02:18:21 +0000
Message-ID: <e4018c7b70ef4d81bafcc7395551e735@huawei.com>
References: <20250819145834.3998-1-wangxinxin.wang@huawei.com>
 <20250819152817.789959-2-pbonzini@redhat.com>
In-Reply-To: <20250819152817.789959-2-pbonzini@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.124.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=wangxinxin.wang@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  "Wangxin (Alexander)" <wangxinxin.wang@huawei.com>
From:  "Wangxin (Alexander)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>=20
> Queued, thanks.  But please let me know what's the correct signed off by =
chain;
> either Tuo created the patch, and then you should have "--author" for him=
 and
> his SoB first; or you did, and then Tuo's SoB is unnecessary.
>=20
> Paolo
>=20

The author is me, should I resend this patch?

Thanks,
Xin

