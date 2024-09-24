Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0336CCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 05:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sth3r-0003rn-Un; Thu, 26 Sep 2024 01:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1sth3n-0003pT-2H
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 01:29:04 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arun.kka@samsung.com>)
 id 1sth3j-0006et-0T
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 01:29:01 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240926052307epoutp049790a9dd10a229b89c1b89259b6557ba~4s9WZv5oQ1660416604epoutp04X
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 05:23:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240926052307epoutp049790a9dd10a229b89c1b89259b6557ba~4s9WZv5oQ1660416604epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1727328187;
 bh=NwAXpFbZQ/UU+GUG2NszcuJRuUTioG4BJ5Y4IAR6feM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=vPsNv16tTBHTlxqW98w7I51TPHi1GQaVHPRcd2Ig24xx7sBZ0KRfsTsY48QX6mNvr
 GZ60aehwJfIKuYJtAeDeEgCuhiRXTue9LxzM93bBKApvEJgQKCrdjq1ROSI+Q4OHZy
 x7eeRIYe7xw8dPQPhGIqxrSSM5v/tWjz/l4mdDNs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20240926052306epcas5p32df6cb1097df2e7c3de802feb06e4174~4s9WAbe_43026130261epcas5p3e;
 Thu, 26 Sep 2024 05:23:06 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4XDhnj2dn9z4x9Pp; Thu, 26 Sep
 2024 05:23:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C9.01.19863.6BFE4F66; Thu, 26 Sep 2024 14:23:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20240924064831epcas5p197915617b154342dd1286fd35a40b72e~4G1WJA6lH2270722707epcas5p1M;
 Tue, 24 Sep 2024 06:48:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240924064831epsmtrp18dad354cbfe046a7f4c672a166ad7be3~4G1WIWk5F0827108271epsmtrp1c;
 Tue, 24 Sep 2024 06:48:31 +0000 (GMT)
X-AuditID: b6c32a50-c73ff70000004d97-bc-66f4efb6262e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 52.6E.08456.FB062F66; Tue, 24 Sep 2024 15:48:31 +0900 (KST)
Received: from open-sourcing (unknown [107.99.41.223]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240924064830epsmtip23f77231d2327d629c33f480e11899928~4G1VEp9W12752327523epsmtip2K;
 Tue, 24 Sep 2024 06:48:30 +0000 (GMT)
Date: Tue, 24 Sep 2024 06:48:32 +0530
From: Arun Kumar <arun.kka@samsung.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Klaus Jensen
 <k.jensen@samsung.com>
Subject: Re: [PATCH] hw/nvme: add knob for CTRATT.MEM
Message-ID: <jth4qww2u6jvpto5kwhr73s3nvfugop2xrn45ossptczjye4id@ow3tjrsfsgyz>
MIME-Version: 1.0
In-Reply-To: <20240924-add-ctratt-mem-knob-v1-1-0674de9b88b4@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTXXfb+y9pBk82cVucmBJmsf/gN1aL
 k417WC0mHbrGaDHrXTubxfHeHSwObB5Tpl1j9zi34zy7x6ZVnWweT65tZvLo27KKMYA1Ktsm
 IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gCJYWyxJxS
 oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xpM5
 bcwF8wQrlsy7zdbA2MXXxcjJISFgIvH+wCmmLkYuDiGBPYwSq2/sYYNwPjFKbL/3HCrzjVGi
 58IVNpiWAwd7oBJ7GSXaGvqZQBJCAq8ZJXa95gGxWQRUJa7Pe88IYrMJqEusnbkDrEZEQEXi
 6b+9LCDNzALzGSX27L0ANlVYwFRi5sK7QEUcHLwCvhJttyRBwrwCghInZz5hAbE5BTwlpk+Z
 xgrSKyHwkV3iRs8DVpB6CQEXiXcf1CGOE5Z4dXwLO4QtJfGyvw3Krpc4M3MPE4TdwSjx9DtU
 3F7i4p6/YGuZBTIkJuzzhQjLSkw9tQ6snFmAT6L39xOoVl6JHfNgbCWJe1t/Qo2RkJhz5Tsj
 hO0hcenOZFZI+MxhlPjR/JdtAqPcLCTvzEJYNwtshZVE54cmVoiwtMTyfxwQpqbE+l36CxhZ
 VzFKpRYU56anJpsWGOrmpZbD4zg5P3cTIzhNagXsYFy94a/eIUYmDsZDjBIczEoivJNufkwT
 4k1JrKxKLcqPLyrNSS0+xGgKjJ6JzFKiyfnARJ1XEm9oYmlgYmZmZmJpbGaoJM77unVuipBA
 emJJanZqakFqEUwfEwenVANT34G56z+96PidtWHK4588nxo0X+m0yDLv1eh/Inz0jG+PXGC4
 joXTqnuXohbX57F2XrrK5nHkjDVjTqtwksylHzXtimubdi3LbVD/mz53ssFBSZPfGqlXAzZt
 qz/27cg/s16d0w8K1qWus5mktnn+fK/9izwZi7leLDjjvOvJ9dRv0mceqWdP4mhXabUrNpri
 s7GRP8V/VqVChOqjyDtddUtrkvOE8p8xyuq+MrqmeZCHP+Beu4BTaWF99rKXj5Z+2CssIXxK
 +NpSX9aEjoztN2/xVGZejFbcXP5qy/Mvs/3yrrZsm7vORTTpo9q/10VRfm+SWY7c5lgxe7t4
 DkPYk4XuC7drbawqXiTRJJKsxFKckWioxVxUnAgAV2UsqRwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSvO7+hE9pBpN+cFucmBJmsf/gN1aL
 k417WC0mHbrGaDHrXTubxfHeHSwObB5Tpl1j9zi34zy7x6ZVnWweT65tZvLo27KKMYA1issm
 JTUnsyy1SN8ugSujYd8KloILfBVnnr9gbmC8xt3FyMkhIWAiceBgD1MXIxeHkMBuRomTV8+z
 QCQkJH58+cYIYQtLrPz3nB2i6CWjxKRjH9lBEiwCqhLX570HK2ITUJdYO3MHE4gtIqAi8fTf
 XhaQBmaBeYwSHev3gBUJC5hKzFx4F6iIg4NXwFei7ZYkxNA5jBL/OxaDDeUVEJQ4OfMJ2BXM
 AmYS8zY/ZAapZxaQllj+jwMkzCngKTF9yjTWCYwCs5B0zELSMQuhYwEj8ypGydSC4tz03GLD
 AqO81HK94sTc4tK8dL3k/NxNjOAQ19Lawbhn1Qe9Q4xMHIyHGCU4mJVEeCfd/JgmxJuSWFmV
 WpQfX1Sak1p8iFGag0VJnPfb694UIYH0xJLU7NTUgtQimCwTB6dUA1MXl+Apbq0jB75x/hS9
 ecZjef/Ry5VpnxVuVxYe9g1hFsy+IxXDYO+ga/GltnLlt608Yec0k9cs8J9245PU3s6IPWs2
 vv7w2VPffeEfd6nciaLrZ/j82fA4msFC4vX72uydAt5JibrPMrSmz6uWz581ba7UV9/VrFMs
 fpxPvPG5e512X87eq5mzNt90uXxjzoOSdc3yjy3vmvhev973L7f3Z+nzS5y1v3ynBf7eKtfB
 +aX/29N4z28ZoVWPLRf3Hbpx301Ldsf264u+sbZZJlz9tM0k7b35UlvJlM3ds/Rq614o2hfz
 6uud/qv1XtVG16zu0EX9NeyskVXvm/g/K+5dJV6ziC2necqX55s8SsuVWIozEg21mIuKEwFr
 yYdG4AIAAA==
X-CMS-MailID: 20240924064831epcas5p197915617b154342dd1286fd35a40b72e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_4f1fc_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240924063550epcas5p46118c878bebe3289884819017cb0b11b
References: <CGME20240924063550epcas5p46118c878bebe3289884819017cb0b11b@epcas5p4.samsung.com>
 <20240924-add-ctratt-mem-knob-v1-1-0674de9b88b4@samsung.com>
Received-SPF: pass client-ip=203.254.224.34; envelope-from=arun.kka@samsung.com;
 helo=mailout4.samsung.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.108, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

------lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_4f1fc_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

Hi Klaus,

LGTM.

On 24/09/24 08:35AM, Klaus Jensen wrote:
>From: Klaus Jensen <k.jensen@samsung.com>
>
>Add a boolean prop (ctratt.mem) for setting CTRATT.MEM and default it to
>unset (false) to keep existing behavior of the device intact.
>
>Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>---
> hw/nvme/ctrl.c | 7 ++++++-
> hw/nvme/nvme.h | 4 ++++
> 2 files changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>index f36c45931821..8556f3e61fa0 100644
>--- a/hw/nvme/ctrl.c
>+++ b/hw/nvme/ctrl.c
>@@ -8492,7 +8492,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>     id->cntlid = cpu_to_le16(n->cntlid);
>
>     id->oaes = cpu_to_le32(NVME_OAES_NS_ATTR);
>-    ctratt = NVME_CTRATT_ELBAS | NVME_CTRATT_MEM;
>+
>+    ctratt = NVME_CTRATT_ELBAS;
>+    if (n->params.ctratt.mem) {
>+        ctratt |= NVME_CTRATT_MEM;
>+    }
>
>     id->rab = 6;
>
>@@ -8751,6 +8755,7 @@ static Property nvme_props[] = {
>                      false),
>     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
>     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
>+    DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
>     DEFINE_PROP_END_OF_LIST(),
> };
>
>diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
>index 781985754d0d..bd3c6ba33a67 100644
>--- a/hw/nvme/nvme.h
>+++ b/hw/nvme/nvme.h
>@@ -538,6 +538,10 @@ typedef struct NvmeParams {
>     uint32_t  sriov_max_vq_per_vf;
>     uint32_t  sriov_max_vi_per_vf;
>     bool     msix_exclusive_bar;
>+
>+    struct {
>+        bool mem;
>+    } ctratt;
> } NvmeParams;
>
> typedef struct NvmeCtrl {
>
>---
>base-commit: 3245de3f3d002bc9ce2ecae61e8d86cb9e375808
>change-id: 20240924-add-ctratt-mem-knob-ae4431251cb1
>
>Best regards,
>-- 
>Klaus Jensen <k.jensen@samsung.com>
>
>

------lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_4f1fc_
Content-Type: text/plain; charset="utf-8"


------lj09sVyn-tOB2AKWHI53LLLuzUygR0h9jjkNdS9akYNnxuib=_4f1fc_--

