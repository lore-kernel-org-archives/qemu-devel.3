Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B9DC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 14:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdAIA-0003VW-Av; Thu, 22 Feb 2024 09:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wj28.lee@samsung.com>)
 id 1rd3m6-0004kr-6v
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:45:47 -0500
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wj28.lee@samsung.com>)
 id 1rd3lx-00042g-Sz
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:45:45 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240222074526epoutp03451c027007487a068337d8127d2fa7c3~2H6q15emV3035230352epoutp03t
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 07:45:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240222074526epoutp03451c027007487a068337d8127d2fa7c3~2H6q15emV3035230352epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1708587926;
 bh=WO5vv8iXnfXWEVyIv/JdS6NWHIGqgzMh1bKqgfERsw8=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=L9U4vdB3EeJVKM3qPgptB8iboTxca9r4tOhiJU9//cfw17NnRtuhoKD9gqTL+gcZ1
 RE5VeTydQEkBnvrf9+fNK3gg25CDcdTXpcQtQ3v/YXE5VvuVqbYK1ZFadaB4NTZFHf
 m/8KOO11M5sck3I+JguSAYTKv0bki6L4VqTVoK18=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20240222074526epcas2p174c274773d75015c457c7f1738a67aa1~2H6qQ-6QR2971329713epcas2p1F;
 Thu, 22 Feb 2024 07:45:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4TgQD53sl2z4x9QM; Thu, 22 Feb
 2024 07:45:25 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-62-65d6fb95a1f2
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 01.77.10006.59BF6D56; Thu, 22 Feb 2024 16:45:25 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
From: Wonjae Lee <wj28.lee@samsung.com>
To: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, Adam Manzanares <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>, "nmtadam.samsung@gmail.com"
 <nmtadam.samsung@gmail.com>, Jim Harris <jim.harris@samsung.com>, Fan Ni
 <fan.ni@samsung.com>, KyungSan Kim <ks0204.kim@samsung.com>, Hojin Nam
 <hj96.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240221182020.1086096-3-nifan.cxl@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240222074525epcms2p1099bf72b0683889b36a5c5c06bdc2dff@epcms2p1>
Date: Thu, 22 Feb 2024 16:45:25 +0900
X-CMS-MailID: 20240222074525epcms2p1099bf72b0683889b36a5c5c06bdc2dff
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmme7U39dSDV7OkrWYfljRYvrUC4wW
 q2+uYbRoWn2X1aKh6RGLxYc3/1gs9j99zmKx9ICGxaqF19gsju7hsDg/6xSLxd9texktli55
 xGxxvHcHiwOfx85Zd9k9Wo68ZfVYvOclk8fGj//ZPZ5c28zk0bdlFaPH1Nn1Hp83yQVwRGXb
 ZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdraRQlphT
 ChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzjh9
 5gFLQRt3Rff8b8wNjD2cXYycHBICJhIn+54zdzFycQgJ7GCUaGmexNbFyMHBKyAo8XeHMEiN
 sEADo8ShnzkgtpCAnMTd26eYIOKaEm+mrWIBsdkE1CV+dJ4Ei4sIJElMmLIIbCazwAEWiY7H
 PxghlvFKzGh/ygJhS0tsX74VLM4pYC1xdOoCqLiGxI9lvcwQtqjEzdVv2WHs98fmQ80RkWi9
 dxaqRlDiwc/dUHEpia8n/rKD3C8hUC7xZr05yA0SIPc/WfkXao65xIQ9E8FsXgFficsXf4Ad
 zSKgKnHmzQk2iBoXiWmTT4HdwywgL7H97RxmkJnMQA+v36UPMV5Z4sgtqAo+iY7DMNN5JXbM
 e8IEYStJTGk7AnWZhERD41ao6R4Sp7c8ZJ3AqDgLEdCzkOyahbBrASPzKkax1ILi3PTUYqMC
 Q3jcJufnbmIEJ18t1x2Mk99+0DvEyMTBeIhRgoNZSYSXpfxKqhBvSmJlVWpRfnxRaU5q8SFG
 U6AvJzJLiSbnA9N/Xkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFIN
 TLPcRdXnL9Nyrfe/nX705ouzLW7HA+YtePNBOO6g54e5NzUcOlemn+4K/e1u9LP+3L1ZHoW6
 W47sXdH/bb9HTEWcjdBkqSOz+BvU5c8EaYiUTdp0bL/8Qavvb9NFBRrXn16ZneNT5Hw3edOf
 nRrXJz974ZPO81869A77npv+82Xsrzz4fP6ChEr+768lK9xLUw+x+Ozr6frJ37JULeJp0R7u
 veZT654f/322k4dhM8vldRMeRwVtnPO05WmTylFLj9akDQf9Iqe7G2RsOP6jjaEh93NGRWfS
 rCufGPjX/7dUufuB9aFarXTGyvCJe0wWqD9ZfGpemG7aU6kZHc+PN0v/Dc396u7/Lm32j9xn
 uauVWIozEg21mIuKEwEBQIGhRwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240221182126epcas2p1b684f9239e4262f17ff484939658a382
References: <20240221182020.1086096-3-nifan.cxl@gmail.com>
 <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <CGME20240221182126epcas2p1b684f9239e4262f17ff484939658a382@epcms2p1>
Received-SPF: pass client-ip=203.254.224.33; envelope-from=wj28.lee@samsung.com;
 helo=mailout3.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 Feb 2024 09:43:13 -0500
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
Reply-To: wj28.lee@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 21, 2024 at 10:15:55AM -0800, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
>
> Per cxl spec r3.1, add dynamic capacity region representative based on
> Table 8-165 and extend the cxl type3 device definition to include dc region
> information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> Configuration' mailbox support.
>
> Note: decode_len of a dc region is aligned to 256*MiB, divided by
> 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> mailbox command.
>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  16 ++++++
>  2 files changed, 126 insertions(+)
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ba1d9901df..88e3b733e3 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -22,6 +22,7 @@
>

[snip]

> +#ifdef CXL_SPEC_AFTER_R30
> +    /*FIXME: need to set valid values in the future*/
> +    stq_le_p(&extra_out->num_extents_supported, 0);
> +    stq_le_p(&extra_out->num_extents_available, 0);
> +    stq_le_p(&extra_out->num_tags_supported, 0);
> +    stq_le_p(&extra_out->num_tags_available, 0);

Hello,

It's a trivial comment and doesn't have any impact yet, but shouldn't it
be stl_le_p()?

Thanks,
Wonjae

