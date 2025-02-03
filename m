Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243D7C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 07:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfCur-00019e-DL; Tue, 04 Feb 2025 02:00:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s5.kumari@samsung.com>)
 id 1tfBWz-0001lc-Jr
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 00:31:30 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s5.kumari@samsung.com>)
 id 1tfBWv-00083s-WA
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 00:31:28 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250204053119epoutp01b536d9cbfcc19c1535595b25799ba5c3~g6k6pacuf0914609146epoutp01N
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2025 05:31:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250204053119epoutp01b536d9cbfcc19c1535595b25799ba5c3~g6k6pacuf0914609146epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1738647079;
 bh=+biVHaGMB5F+GKA60sB0OWj5DAFTwShqFHKuX7hiXTk=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Sy/ZRSpXpkKBaDA58WxaXyJyqVGBPMR+z3qP7Q2rjkTguvcVOVMGnbs8eE9yHg0y8
 QGAICku9VTSw7wnyNuBubLaURfhOkigOhbQO0wlJtxl7Td15nYqwcVMAok8TW1Mqru
 p2na+7FzKo9NUgXRtJWokcC8KaFR7hV6X7ymAUjQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20250204053119epcas5p226e689dfdde761e792dfede18f4fe982~g6k6FoFCs0611106111epcas5p2V;
 Tue,  4 Feb 2025 05:31:19 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4YnBmj66njz4x9QH; Tue,  4 Feb
 2025 05:31:17 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D7.F4.19956.526A1A76; Tue,  4 Feb 2025 14:31:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20250203114457epcas5p1569ad2154f5ca08145e74c44efee1e1e~gsB236msg2272322723epcas5p1F;
 Mon,  3 Feb 2025 11:44:57 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250203114457epsmtrp17b40f4f710c3ee1653bd90f3e12c9a53~gsB23ONb03189931899epsmtrp1R;
 Mon,  3 Feb 2025 11:44:57 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-28-67a1a6259ed6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 FE.C9.33707.93CA0A76; Mon,  3 Feb 2025 20:44:57 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250203114456epsmtip2229ff867f5871829eac42db13a18fef2~gsB1dE91b1414714147epsmtip2L;
 Mon,  3 Feb 2025 11:44:56 +0000 (GMT)
From: Sweta Kumari <s5.kumari@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Sweta Kumari
 <s5.kumari@samsung.com>
Subject: [PATCH 0/1] CXL CCI Health Information & Alerts Commands
 implementation
Date: Mon,  3 Feb 2025 17:14:44 +0530
Message-Id: <20250203114445.64088-1-s5.kumari@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmuq7qsoXpBr/36llMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBZrzn1mAYrNYXfg8tg56y67x5Nrm5k8
 +rasYvSYOrve4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
 VFslF58AXbfMHKCblBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
 6Xp5qSVWhgYGRqZAhQnZGZv3z2Uv+MFacWT9MvYGxn8sXYycHBICJhLnZu1j62Lk4hAS2M0o
 0da9mQnC+cQosePoVlY4Z+/853AtC1quMEMkdjJKHLg1gwXCaWCS6D/5kRGkik1AS+LH5wfM
 ILaIgKTE767TYB3MAq8YJTZuaAXayMEhLBAk8eJ3PUgNi4CqxNsbL9hBbF4BK4nL+xexQWyT
 l9h/8CwzRFxQ4uTMJ2BXMAPFm7fOBpspIXCNXeLMkeeMEA0uEi1rtzND2MISr45vYYewpSRe
 9rdB2dkSd7d2Qi0okfhwezcThG0v0XqqnxnkNmYBTYn1u/QhwrISU0+tY4LYyyfR+/sJVDmv
 xI55MLayxJZ/y1khbEmJFZ+XQNkeEnOfHABbJSQQKzHt8gu2CYzys5C8MwvJO7MQNi9gZF7F
 KJlaUJybnlpsWmCcl1oOj9nk/NxNjOC0qeW9g/HRgw96hxiZOBgPMUpwMCuJ8J7eviBdiDcl
 sbIqtSg/vqg0J7X4EKMpMIwnMkuJJucDE3deSbyhiaWBiZmZmYmlsZmhkjhv886WdCGB9MSS
 1OzU1ILUIpg+Jg5OqQamlSuWFKxiuurycvWks5rJz0JUrMpundv9cuXBO8rhUzsWrPkguLtD
 co2koJVak+LHjeseNrS55lwpt3E5OP3JVoPMVX1HDXXn/Tk0adOBGasnVtjdCG04b8/5tTnD
 0yb679q6zaemFYQv/C++7twJkRdXp8+fu9j3fJbc7/uFzU9OeJWaHgxQWRlfGZKxK7RZq8t+
 q07DodSeRKtrUu9sPO310v2PW7RV6Bl0M7F+LNz/YmPq+QQFtmVTZUR+GC+Z01R4Y2rbimJ+
 sXVHfz/N1f1x16PrsmRjR8G7bn4mlw9Ohydv19B01WFcHMCjHP70ztGbF9azVgu9iZENWlkz
 Y+eqlOMRFWa7kzh+XfTdrsRSnJFoqMVcVJwIAKry/S8kBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSvK7lmgXpBocWGlhMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBZrzn1mAYrNYXfg8tg56y67x5Nrm5k8
 +rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6Mzfvnshf8YK04sn4ZewPjP5YuRk4OCQET
 iQUtV5i7GLk4hAS2M0o0f17DDpGQlHh75hIjhC0ssfLfc3aIon+MEn+2HQYrYhPQkvjx+QEz
 iC0C1PC76zTYJGaBL4wSUxq+MoEkhAUCJK5v+g22jkVAVeLtjRdgzbwCVhKX9y9ig9ggL7H/
 4FlmiLigxMmZT8DqmYHizVtnM09g5JuFJDULSWoBI9MqRtHUguLc9NzkAkO94sTc4tK8dL3k
 /NxNjODQ1Qrawbhs/V+9Q4xMHIyHGCU4mJVEeDkOz0kX4k1JrKxKLcqPLyrNSS0+xCjNwaIk
 zquc05kiJJCeWJKanZpakFoEk2Xi4JRqYJI+d32JxMw19Ycj5xje0/2cypAVOl2g3L/Q2COp
 /PD1bWdlPx758f7DzpkTRXqUlxYculnIsbaub8v3bQfyTwdVSCxNuuj+9zjDk/0Vl6rTk7l6
 VxR9ddw1N5LhR1JYj3DsWc7Wi7uMZDhmedfHp+nZrODvqWNt6mc3TmmV/HhPZ8qLAIZPcV2v
 Pjr3LLl8Vt41Xrp+sarUBNGJ8TOL50Z5cs69KVDqk5Wwgcl+x3r3mWbPTuQHTyl2+C1xLTqz
 Q7h8isXG4AtCb/y/RT5M1/a336q0JH3hJJZIzt7WH3veS7dan7t7a6Pw9z/LWZaWKcT2/1p4
 89Pum0tlujvjNOYEdcgs+qC6zlpxelPRfyWW4oxEQy3mouJEAONLO6bMAgAA
X-CMS-MailID: 20250203114457epcas5p1569ad2154f5ca08145e74c44efee1e1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203114457epcas5p1569ad2154f5ca08145e74c44efee1e1e
References: <CGME20250203114457epcas5p1569ad2154f5ca08145e74c44efee1e1e@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=s5.kumari@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Feb 2025 02:00:03 -0500
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

CXL CCI get/set alert config commands implmented as per CXL Specification 3.1  8.2.9.9.3
1)get alert configuration(Opcode 4201h)
2)set alert configuration(Opcode 4202h) 

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.

Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>

Sweta Kumari (1):
  Added support for get/set alert configuration commands

 hw/cxl/cxl-mailbox-utils.c  | 91 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 20 ++++++++
 include/hw/cxl/cxl_device.h | 24 ++++++++++
 3 files changed, 135 insertions(+)

-- 
2.34.1


