Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D6DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 00:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saPZq-0004GA-VD; Sat, 03 Aug 2024 20:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1saPZo-0004Fa-Am
 for qemu-devel@nongnu.org; Sat, 03 Aug 2024 20:58:24 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1saPZf-0006mP-7W
 for qemu-devel@nongnu.org; Sat, 03 Aug 2024 20:58:24 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240804005804epoutp04ababfff1beb51d31266a43d0a9ae3cc7~oYJzaitv42913529135epoutp04p
 for <qemu-devel@nongnu.org>; Sun,  4 Aug 2024 00:58:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240804005804epoutp04ababfff1beb51d31266a43d0a9ae3cc7~oYJzaitv42913529135epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1722733084;
 bh=Oebrx7y9Zv6nsBZiGNxZ4W/myK8vxfC+xwZvaS2x+RI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=a3yd1RSLwe4gsAnYZ8CLmeTjvqAxN3NplC/5gUZKcHWaB2M5qezghtU2jPPj7o0FN
 r9fzwKBcgNl81s883QRCMDrvj+iHZVLpQ7vDtsEZjbev+aoDJardu0OtnznUnhN9dY
 vz8wc3SGXhcH7N6DKT58ZRrJ0eIy97clu8sYElyA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20240804005802epcas2p1f39093a689a79a41d62afd5d9694da71~oYJyNRoCi2229322293epcas2p1A;
 Sun,  4 Aug 2024 00:58:02 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Wc1QL30Ylz4x9Pv; Sun,  4 Aug
 2024 00:58:02 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 62.3E.10012.A12DEA66; Sun,  4 Aug 2024 09:58:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20240804005801epcas2p13291007d8e0af8600b2f5d9dcda84c7d~oYJwm2K362229322293epcas2p19;
 Sun,  4 Aug 2024 00:58:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240804005801epsmtrp1854e4f802b1d1ddb34101d2aa43f36e0~oYJwmM7Wl0786907869epsmtrp1b;
 Sun,  4 Aug 2024 00:58:01 +0000 (GMT)
X-AuditID: b6c32a47-c43ff7000000271c-e6-66aed21a48a6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 98.66.08456.912DEA66; Sun,  4 Aug 2024 09:58:01 +0900 (KST)
Received: from localhost (unknown [12.36.63.198]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240804005800epsmtip115391d53e405d4c424ed3d4401b47303~oYJwXkFYb0034300343epsmtip1W;
 Sun,  4 Aug 2024 00:58:00 +0000 (GMT)
Date: Sun, 4 Aug 2024 09:44:59 +0900
From: Minwoo Im <minwoo.im@samsung.com>
To: Kyoungrul Kim <k831.kim@samsung.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, SSDR Gost Dev <gost.dev@samsung.com>,
 minwoo.im@samsung.com
Subject: Re: [PATCH] hw/ufs: add basic info of query response upiu
Message-ID: <Zq7PC4rOstnYhzwf@localhost>
MIME-Version: 1.0
In-Reply-To: <20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmma7UpXVpBo8uC1rcPLCTyeL+1muM
 FlM2fWW0eHb6ALPF8d4dLA6sHk+ubWby6NuyijGAKSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzje
 Od7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdonZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
 Vim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2PZbK+CvywVG1fMYG1gXMfSxcjBISFg
 IvH3tE4XIxeHkMAORonJZzezQTifGCX6Nr9nhHC+MUqc/tMK1MEJ1nHs73cWiMReRolJ11ez
 QzjPGCXuve1hA6liEVCR+HDmIlgHm4C6RMPUV2C2iICGxP6Nn8AamAWmM0qc+/WVGSQhLOAk
 MWv9JEYQmxeo6Nvy40wQtqDEyZlPwI7lFPCTWLTEGaRXQuAUu8Tzj6cYIU5ykVjyYRE7hC0s
 8er4FihbSuJlfxuUXS3xf8klJojmFkaJrqUr2SAS9hLTOk6AXccskCFxYc4NJkjIKEscuQUV
 5pPoOPyXHSLMK9HRJgTRqSzx8dAhZghbUmL5pddsECUeEodfRUDCZCqjxKs919gnMMrNQvLN
 LCTLZgG1MAtoSqzfpQ9hSkss/8eBJLqAkXUVo1hqQXFuemqxUYExPHqT83M3MYLTnpb7DsYZ
 bz/oHWJk4mA8xCjBwawkwvts79o0Id6UxMqq1KL8+KLSnNTiQ4ymwKiZyCwlmpwPTLx5JfGG
 JpYGJmZmhuZGpgbmSuK891rnpggJpCeWpGanphakFsH0MXFwSjUwua6K7juQt+xCxe4+16z5
 Gxv7W7peshdzNR0ovKTKkLVSWkTEzqeJn/ty/btwrw1NK3fsWR3E0bikNCLMd1blz1RJGfvz
 JW/+ffF+aJB6jFV9Ta7UdxY2X6uYB/fcl1V7rWf8oRlsEm3+jHPbROHfM2c8nRgUpWl9/I70
 hcIHN+pvLX/Cwq/9JTLcS0zj0fu7M2Z96GZgMnr/Wrl57oWfEzOuyZ6d9aD++Of4U9wfH51o
 yvAJPPGqJeJ/4KoTYn5Jx3Rsdi3cmGL/48by3EUvDh1lVbTkYJG78IylzrpuT0Fteu0zX82i
 eVULNB5c+K+utuQIz0wnm7ytKxyN13kdO7U1LiJFk21F8P+qN0/KlFiKMxINtZiLihMBFfv7
 VgQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnK7kpXVpBpdPsVvcPLCTyeL+1muM
 FlM2fWW0eHb6ALPF8d4dLA6sHk+ubWby6NuyijGAKYrLJiU1J7MstUjfLoEr4/f3HpaCA0wV
 N1pvsDQwdjF1MXJySAiYSBz7+50FxBYS2M0osWO/MkRcUmLf6ZusELawxP2WI0A2F1DNE0aJ
 NedOsoMkWARUJD6cuQjWzCagLtEw9RWYLSKgIbF/4yd2kAZmgemMEnMbL4BNEhZwkpi1fhIj
 iM0LVPRt+XEmiKlTGSXmbZ3HDJEQlDg58wnYJGagqX/mXQKKcwDZ0hLL/3GAmJwCfhKLljhP
 YBSYhaRhFpKGWQgNCxiZVzFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBIeultYOxj2r
 PugdYmTiYDzEKMHBrCTC+2zv2jQh3pTEyqrUovz4otKc1OJDjNIcLErivN9e96YICaQnlqRm
 p6YWpBbBZJk4OKUamCb9f1XIdHWVjGeUojvPEhXX+Ed7gkWul79qFw+y0g2aYXOm0eyZc+HW
 9ZPKbs70ipuyUGzi3JIvc5MDr9/X3u/yvoed557Pkgf3IqZu6a/qnXey3zuFVfl58LmuNJW8
 urAla0zKmbYIvfj+RObjctMcJtEXa98u2blSKW8Kl/+E2k6Luj8WbxPupcucY9+yZF61/rSD
 Vyfeaf/POOXSl9mhsbZ33hxVC+UteVbCXn1ZY8n18pqDdmIae+25yvbbuc4Lfu32KGYm7665
 804rC5yXcr+08uHlnzcX/VvUzW+ldpzHiem71eLfpqkBxXd+L9jrqx1q3Ljk+rn35clhbEsl
 Ym5qhpdp/37V7Prnc5MSS3FGoqEWc1FxIgA4W71+zAIAAA==
X-CMS-MailID: 20240804005801epcas2p13291007d8e0af8600b2f5d9dcda84c7d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----M.dWNCrTGqLRKgtfUT493DNbHRmHBxnkwAegaH8Q4WHO9703=_65ef2_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d
References: <CGME20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3>
 <20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=minwoo.im@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

------M.dWNCrTGqLRKgtfUT493DNbHRmHBxnkwAegaH8Q4WHO9703=_65ef2_
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline

On 08/02, Kyoungrul Kim wrote:
> Modify to fill the opcode, idn, index, selector information of
> all Query Response UPIU. because attr and flag operation of query
> response upiu need these information too.
> 
> Signed-off-by: KyoungrulKim <k831.kim@samsung.com>

Reviewed-by: Minwoo Im <minwoo.im@samsung.com>

------M.dWNCrTGqLRKgtfUT493DNbHRmHBxnkwAegaH8Q4WHO9703=_65ef2_
Content-Type: text/plain; charset="utf-8"


------M.dWNCrTGqLRKgtfUT493DNbHRmHBxnkwAegaH8Q4WHO9703=_65ef2_--

