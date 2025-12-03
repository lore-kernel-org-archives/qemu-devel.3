Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EA8D12D60
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnd1-0005xa-L2; Wed, 03 Dec 2025 09:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1vQgdV-0004p7-Lo
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:46:51 -0500
Received: from ci-2002k-snip4-2.eps.apple.com ([57.103.88.233]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1vQgdT-0000YG-EX
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:46:49 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPS id
 1E98B1800116; Wed,  3 Dec 2025 06:46:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 bh=2oSTwT6BrLzVT/Xa63N9kAZ3pdM3XV2BWBbUU5+Rwjk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=PW8m+aBkywxVKogN33vewhNiNM0Vls/wsfMTSlJBngwQLXO2pODXKFWKnzpaicoQ7gUzt8Ximn2Y3MKr9p76At54GolYZ/S16fOC39s1TP42SQWty8ZIL8NRcHkXiNN/IVjmmygHHi1sNF33iSf4axinCZOs29RO28uAkrJEPiF4qE9C0XayfLpi6DLT7iV5rcpPs62MadivQX0NmcKHRy2c7MvAg8Ig2ohR22fwnix+gu36Dyld983j45l/jGjQk9xoG0moI/8vzSODBwpDbq2+GMwuCplwvOaK+MKZYktG8fZ6zLQymTEhZ2Ghric0mGcJX+zCdRtfseegv0DqZA==
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPSA id
 0CDC7180009B; Wed,  3 Dec 2025 06:46:41 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH 0/1] hw/m68k: add working floppy controller for q800
Date: Wed,  3 Dec 2025 01:43:35 -0500
Message-Id: <20251203064336.79847-1-mhjacobson@me.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bvPk_XUMzBBHFvkeIvqe6ViiFJXQq5MG
X-Authority-Info: v=2.4 cv=SLBPlevH c=1 sm=1 tr=0 ts=692fdcd2 cx=c_apl:c_pps
 a=2G65uMN5HjSv0sBfM2Yj2w==:117 a=2G65uMN5HjSv0sBfM2Yj2w==:17
 a=wP3pNCr1ah4A:10 a=x7bEGLp0ZPQA:10 a=Z7GCepxVSdIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=a4NEJbfMAAAA:8 a=jTNvsa8-qGaS9nKWCzkA:9
X-Proofpoint-ORIG-GUID: bvPk_XUMzBBHFvkeIvqe6ViiFJXQq5MG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA1MiBTYWx0ZWRfXzFsfIIgS25uu
 p2FwYde3PXfFSoPXYnQaO/6OIFkTkaL8hy/ErlPDAMMMWKkiq4rCHlleSegjwBE+3Fne7ZQMWQP
 0XHHPYsOlay/HHuSfjsPZekHzPIGo1Qo3LM+30Y6uqvsWUUTwZ8wBB2M2M78LojOrnQiESeWU77
 c73oRVnFFQSK3F/H/31HCxahoWPmZFcJHuELxXTXXtN7+WsUrVLq2gr8/PtFfKZ/XO27rzchVIR
 qjHk1uDLyS7b2N88TzEo8vl0Rx5FXFtBjZfUFR46I3IH/4Cng8SjWMf57Rm+sIgm0ulU0AfWVxd
 lknMlz3nSMPpAhh32MZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=527 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030052
X-JNJ: AAAAAAAB9aLkSCAszqTa7zhmIZdckYxsuZOQeIgqQeNMcl2Lks4phVgCmsbf9MDwZkjCdrZ7uEEtyFY/9p+p5waR7wSsYVajZkAiS8KklUe53sSRfTabeb+0YvmvsOmbfE7UGjAzaWpc7DNkZgPEbc0xaxdtE00A7WFw7qk+Wn2VqxrLRELRSULBCmaC0i9e/CBvk0dKxaASq9HI8/i9B8DrogLCzaTrA8RsS9bdEfml4BtevDE8BrmIge6ltKvP5htp+mD6ItVP791KS3Sy6Qr8zYztwXh5mpiSCplxbdVYPueXYA2tjFcQbfOpkEFcIeB6jx2zl4q2uLl/wG07aqSNCllj6LNXuGFeGB65Xv0U+o0eVy4d1UYRIH0CisdIvbTDRW6tKYpFNGKMVI0KvN8FetgK3dPDYpzJk3WaJA2mGUHb8VpxAHezCqFVASuiVJ6VsnsoCh5yNn7GUiKXFArxbabWtd4kEJzCQzLjfGl3/0wlFrLd1mM/DsJuBkNv+YYhvrncL1t7/xfhCWQlGc5izgdDRcWDxFDzxslJAB1ZByrkay0g2KQZVWVLAmMLnqRMpErUz5YSd5f5/uDtg01T/d6m3Gyh/0wLwMOwk5SUUSFvGWyJJSf8JTKY6kUsDIfha+3e1Pf3OE4Pahaw0veb3b4Z+17mOsYq736/aQw/uNT4pBRmcD0gJZAhIw==
Received-SPF: pass client-ip=57.103.88.233; envelope-from=mhjacobson@me.com;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Dec 2025 09:14:31 -0500
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

[Please notify me of any process errors -- this is my first contribution to
QEMU.  Thanks.]

Implement the SWIM2 floppy controller for the q800 machine.
(For details, see: <https://archive.org/details/SWIMDesignDocs/SWIM2%20ERS/>.)

Reading and writing work, and booting from a system disk works.
Tested with the Quadra 800 ROM and System 7.

Future areas of work here could include:

* Allowing for disk formatting/duplication to work
* Fleshing out the SWIM1 and hooking it up to the emulated drive
* Implementing the IWM for earlier machines (this could share code with SWIM1)

Matt Jacobson (1):
  hw/m68k: add working floppy controller for q800

 hw/block/meson.build               |   2 +-
 hw/block/sony_superdrive.c         | 940 +++++++++++++++++++++++++++++
 hw/block/swim2.c                   | 657 ++++++++++++++++++++
 hw/block/trace-events              |  17 +
 hw/m68k/q800.c                     |   4 +-
 include/hw/block/sony_superdrive.h |  55 ++
 include/hw/block/swim2.h           |  66 ++
 include/hw/m68k/q800.h             |   4 +-
 8 files changed, 1740 insertions(+), 5 deletions(-)
 create mode 100644 hw/block/sony_superdrive.c
 create mode 100644 hw/block/swim2.c
 create mode 100644 include/hw/block/sony_superdrive.h
 create mode 100644 include/hw/block/swim2.h

-- 
2.37.1 (Apple Git-137.1)


