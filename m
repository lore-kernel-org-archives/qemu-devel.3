Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2F6C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1yeU-0003dA-Dm; Thu, 03 Sep 2026 00:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x1yeS-0003bO-DK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:02:12 -0400
Received: from mr-2004d-snip6-11.eps.apple.com ([2a01:b747:3000:203::29]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x1yeP-0000Pi-72
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:02:12 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPS id
 8E46C18001F9; Thu, 03 Sep 2026 04:02:02 +0000 (UTC)
X-ICL-RepId: 01a0656e-4b97-73e7-9832-1e952f1905e3
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdDlsBQA1IAlgARQVED0oEQAZGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788408124; x=1791000124;
 bh=x+M2JgY+E0VBkicEpenK8wSivQlKbCR6rgOkzuw3Uvs=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=h/6J6tbqXB5RltRUA/X6zkqlBRvuijQ5KDZL5caIVwmWzGmoBUPmPtSDOkdIIdQSlO1oKKl5Mgs0xmTPeZzXq9v2armm2PVV0UpvI5/tVzlfGVDrCLvgMa4xTRXycFMHwu/ij/sWYB99zyoTa40q2oQtx8ZyFAICzHbR2LEWDtR7d1g4X5DyuSRyMYNr7V8OFJahH4awhdH4RI0eVJ90nhKmZjrAl8UEngdQHCe5UbA2nAt7NHay6cp18dLatAMV+iwP+eTSFMvUhwATIGcwYOjzDzgXOcW0+FGlJ/Dzc+P1lKFqnO+Ip5VxTHZx9/Ub3AFL+hg+Y9p4ZHLtG3AOSA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPSA id
 5A6F0180009E; Thu, 03 Sep 2026 04:02:00 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 0/3] hvf: arm: add experimental VHE (x-vhe) toggle
Date: Thu,  3 Sep 2026 06:01:54 +0200
Message-ID: <20260903040157.74627-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAzMyBTYWx0ZWRfXyq1hghdkt2U4
 Pp9RIS5HUzrAn44DDmbf8mJf0qkZ4NhRcG1Y7rvUdS8x5yJHylZAldXi6Upd7hvI30E2SoCMRw3
 8uZiNS1cWLbzDUfiz+YHaQjPSVWVPxFQzDQhdI1ppcNDZVPa556Kbg2KOE+G5tnrG6mVNe9coqg
 JD0ALdXVnkDBqY8J+rRSCO7THKL4tPW2AHmk+GTrlPRzmhji89POGSMxVbI0wZQHrVzSfx+l6xo
 bANM5sKP1TVhqbd9Ig1K94GkJ1eF4vXIcGfSzdYnyJbr97zCt6kC7K1Wm2Ga3ZGyBjaQ3+uyVop
 zNvl1fQylB5VapR2/7HOFSAdKqo367/SVSuwRKS1HQuWT9Qz0IikwrwqFbhrII=
X-Authority-Info-Out: v=2.4 cv=G7MR0tk5 c=1 sm=1 tr=0 ts=6a98f13b
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=5SVyW61FHS1u6yMifjoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: P39ck5cuE8uclz6hxREQCzKn6P31EEkQ
X-Proofpoint-ORIG-GUID: P39ck5cuE8uclz6hxREQCzKn6P31EEkQ
X-JNJ: AAAAAAABTI20XTqrueSm2e6n5zhzIQvuwSe0+PoQFF5voaOJay26Syiz1ttcYtMjg3qSxE4ND0lGUYQsR5Lpt+MgiZI+7iEAP96vMJBIi3H7T7w4qMmjMMCU44rBYy3S1O0ksjb62t9CXNfC1+jNdit0Q+9mk9BBlE3iLU72gbzAr51MCbUQjM7IssX3bIJXCu8jSNNZVthExiTjGFU/gsavfqs45HuvMNZk6bvM3j5TvxgllOGLZBnJaSiwFB0rxIp5TxwJaCsL9A5nsn/kIYczp2z1aQu1IPUgMrUVZQotEkFQnp5pNqFXdCobjreRE33UDWPzJ+mFt+jYgLzgK7hH9/lylFoEIOsZ5hlHPdJmPoIe3QPf4nIijvQCaLLlYkB0VuWkNWTkA/3J0MMY3uYLRAZePnkDCAtMTmndhIssgUocEjYJvmOqSQdM8TJg17Ne3lQFezPJID/lz9jLpEsDfwMN+RfU/vSHDStdPkh0EH3UU3qzjxmWh1ScMpmGCTvVbHfo0fFWbqH34LN6df911YIe5oWdknlIWHngIg/GRPUKHuk5wKpJNjga4XG0T2dj8nI+hLjns4fBAuhm9YC+b4G43kCNtaybwwy82KTZExTlpni1v9T06+GpGGtEg2pftF8uj8MVoANS0zF8wFildpCSEAVOqxOW/HVZYUMTHbK01n4/y5m1qneDHMRVPiKjHu73e7GEfQIVCjhPRMzo7OBoEIa7Ii7pOSwCOzcHVBD98XqX77lN11ZFJ8tJ7/8d4QbN5pi4kKINvjfvnDXtuxFpdr4mmAVsVZJCOLN8WlyH0rHm0Q0shZnkLp2JLVrwwuW05zzq3xPQK7GKGNhEiTLL0vyv+D4/zwl4DRUHax4f+MSyqhLeeJ5CuJtWBOyESTRtit75hYaXQKYx5iCq539evR75CylmX6R0HglVimR++72lWK2GxL3iGyNL12F0Bv8nTYXscmwqU+Tevuj/mQ2EfUj
 J2o83WCvnK6QNmnIe6VEatXBDmE+ihcSa2yBhi+9zBtlM92OlBHqqBn73DM67LQpoGp+e+/KLZLXQ5Th1UIbQfIixU02O5bKrEwSS/M+lpkcT3XNnlbnYVUBnDDfzYy79gK1U7qbIzt+O2Gu4/2FD3IhEfQaloQuelksHEDDkAyOI9pBN/dCswhGQE1zzxHOV4X1R4hwcmUAbWzIPSlaVZ/8Wc5D3p65pHxPRZD89Shx27j4HRdKGzZ0WJ3uO9vh6astgs/kSpgEJmCr1rDWo
Received-SPF: pass client-ip=2a01:b747:3000:203::29;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

macOS 27.0 has a pre-release VHE implementation. Add support for it in QEMU.

The first patch in the series is an independent bugfix that should be backported to QEMU 11.1 too.

Mohamed Mediouni (3):
  hvf: arm: advertise ID_AA64PFR0_EL1.GIC
  hvf: arm: add experimental VHE toggle
  hvf: arm: advertise EL3 support when VHE is on

 accel/hvf/hvf-all.c      |   2 +
 include/system/hvf_int.h |   1 +
 target/arm/hvf/hvf.c     | 103 +++++++++++++++++++++++++++++++++++++++
 target/i386/hvf/hvf.c    |   4 ++
 4 files changed, 110 insertions(+)

-- 
2.54.0 (Apple Git-156)


