Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B2DC54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 14:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdAIA-0003VV-7S; Thu, 22 Feb 2024 09:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wj28.lee@samsung.com>)
 id 1rd5IM-00062D-4G
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:23:10 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wj28.lee@samsung.com>)
 id 1rd5IG-00028P-8R
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:23:09 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240222092253epoutp014c46c350c7e959d6ec96b290e43885d5~2JPwM73JV3222032220epoutp01k
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 09:22:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240222092253epoutp014c46c350c7e959d6ec96b290e43885d5~2JPwM73JV3222032220epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1708593773;
 bh=9Qn95HhIpP1AEQTS+0y7WcQCdI46naaZBS28xs4HSII=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=U4zhF0U59cotCi4WwQZIkNRcP6PeOvqcfRv3aS7f4jn51XyIaaBVu4J5NZh4Fa7Ci
 OTjr/paM2YR18sjTlmfwYCAC2LBEbYuZmuWELH1WJf1YsqOBrOGe9tOi/dKmhTpGRF
 K8XdcK/O0T9vrBdhaqUO0z/wRpf9wzkAk+MM7h0Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20240222092253epcas2p4a2127c39f6cc42c8b21242a34d9f29ae~2JPvztQll1752517525epcas2p4I;
 Thu, 22 Feb 2024 09:22:53 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.92]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4TgSNX4grQz4x9Pv; Thu, 22 Feb
 2024 09:22:52 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-8d-65d7126cf026
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 E3.70.09622.C6217D56; Thu, 22 Feb 2024 18:22:52 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v4 06/10] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
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
 <fan.ni@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240221182020.1086096-7-nifan.cxl@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240222092252epcms2p389f3b87b6ee63cf6a0e95aaf8968970d@epcms2p3>
Date: Thu, 22 Feb 2024 18:22:52 +0900
X-CMS-MailID: 20240222092252epcms2p389f3b87b6ee63cf6a0e95aaf8968970d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmhW6O0PVUgz0NChbTDytaTJ96gdFi
 9c01jBZNq++yWjQ0PWKx2P/0OYvF0gMaFqsWXmOzOD/rFIvF3217GS2WLnnEbHG8dweLA4/H
 zll32T1ajrxl9Vi85yWTx8aP/9k9nlzbzOTRt2UVo8fU2fUenzfJBXBEZdtkpCampBYppOYl
 56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2qpFCWmFMKFApILC5W0rez
 KcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjOWP7tJXtBP1tF9+vH
 rA2MG1i7GDk5JARMJBZ/uM3excjFISSwg1Fi+csbbF2MHBy8AoISf3cIg9QIC+RI9P1cwAhi
 CwnISdy9fYoJIq4p8WbaKhYQm01AXeJH50mwuIhAksSEKYuYQWYyC3xlljj6bgELxDJeiRnt
 T6FsaYnty7eCDeUUsJa42fOFGSKuIfFjWS+ULSpxc/Vbdhj7/bH5jBC2iETrvbNQNYISD37u
 hopLSXw98Zcd5H4JgXKJN+vNQW6QEGhglHiy8i/UHHOJCXsmgtm8Ar4SM660gQOCRUBVYuPt
 BmiguEg8PfMc7E5mAW2JZQtfM4PMZAZ6eP0ufYjxyhJHbkFV8El0HIaZziuxY94TJghbSWJK
 2xGoyyQkGhq3skHYHhJrZ+9mnMCoOAsR0LOQ7JqFsGsBI/MqRrHUguLc9NRiowIjeNwm5+du
 YgSnWi23HYxT3n7QO8TIxMF4iFGCg1lJhJel/EqqEG9KYmVValF+fFFpTmrxIUZToC8nMkuJ
 JucDk31eSbyhiaWBiZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9TBycUg1Mez8e/FIl
 OX+v/1+lknlhDLNtuAtln5nocWyZ23XF10P1TIXWzEOHdoj+a1tV/9V1+eseww+tX2bPZprw
 3ubmXa4KkUndF387fMk9qVO/fs+eHlV9vrvWm6Xrnabxq3Td2KRwtOkE8+Rna8uX3muOWmeY
 1LDLtOmWgo0Bm8sBRe+j5Y1a017puRQ+ufJ5w+eg5wui/s41+fHAyUHWWr/6mKbXx79/Zgvw
 GvbICel//b/J88J/p83+bTotC3M3PV36xfd8zAdhRS1N94eronOe2U5bLKe+UFdhtfB3wbCM
 qQV/M8/8TFy58c/XjIpfiwwFTThKX1+8n97Zz8lp/qfhH6uJZdOEFn6FZmf70MxMJZbijERD
 Leai4kQAk6k1FT4EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240221182137epcas2p276d22514caaa9412d0119ded6f9a63d4
References: <20240221182020.1086096-7-nifan.cxl@gmail.com>
 <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <CGME20240221182137epcas2p276d22514caaa9412d0119ded6f9a63d4@epcms2p3>
Received-SPF: pass client-ip=203.254.224.24; envelope-from=wj28.lee@samsung.com;
 helo=mailout1.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 Feb 2024 09:43:15 -0500
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

On Wed, Feb 21, 2024 at 10:15:59AM -0800, nifan.cxl=40gmail.com wrote:
> From: Fan Ni <fan.ni=40samsung.com>
>
> Add (file/memory backed) host backend, all the dynamic capacity regions
> will share a single, large enough host backend. Set up address space for
> DC regions to support read/write operations to dynamic capacity for DCD.
>
> With the change, following supports are added:
> 1. Add a new property to type3 device =22volatile-dc-memdev=22 to point t=
o host
>=C2=A0=20=C2=A0=20memory=20backend=20for=20dynamic=20capacity.=20Currently=
,=20all=20dc=20regions=20share=20one=0D=0A>=C2=A0=20=C2=A0=20one=20host=20b=
ackend.=0D=0A=0D=0AHello,=20I=20know=20that=20it's=20too=20minor=20comment,=
=20but=20'one'=20was=20used=20twice.=0D=0A=0D=0AThanks,=0D=0AWonjae

