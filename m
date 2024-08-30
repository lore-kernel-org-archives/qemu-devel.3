Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CCDCA0ED2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 03:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjs53-0001r3-DU; Thu, 29 Aug 2024 23:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sjs51-0001qS-6X
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 23:13:43 -0400
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sjs4x-0001z4-Bp
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 23:13:42 -0400
X-ASG-Debug-ID: 1724987596-1eb14e31a8dcda0001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id nraA4FDw3jRuuGkN (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 30 Aug 2024 11:13:16 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 11:13:15 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Fri, 30 Aug 2024 11:13:15 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from localhost.localdomain (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 Aug
 2024 10:58:27 +0800
From: EwanHai <ewanhai-oc@zhaoxin.com>
To: <ewanhai-oc@zhaoxin.com>
CC: <cobechen@zhaoxin.com>, <ewanhai@zhaoxin.com>, <kvm@vger.kernel.org>,
 <mtosatti@redhat.com>, <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
 <xiaoyao.li@intel.com>, <zhao1.liu@intel.com>
Subject: PING: [PATCH v3] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
Date: Thu, 29 Aug 2024 22:58:27 -0400
X-ASG-Orig-Subj: PING: [PATCH v3] target/i386/kvm: Refine VMX controls setting
 for backward compatibility
Message-ID: <20240830025827.2175695-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a8f89526-5226-4859-98ef-5342c360d7db@zhaoxin.com>
References: <a8f89526-5226-4859-98ef-5342c360d7db@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 8/30/2024 11:13:14 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1724987596
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 517
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.52
X-Barracuda-Spam-Status: No,
 SCORE=-1.52 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_SA_TO_FROM_ADDR_MATCH
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.129737
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.50 BSF_SC0_SA_TO_FROM_ADDR_MATCH Sender Address Matches Recipient
 Address
Received-SPF: pass client-ip=203.110.167.99;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Dear Maintainers and Paolo,

I hope this email finds you well. This is my second follow-up regarding the
patch I submitted for review. I previously sent a reminder on July 23rd, bu=
t
I have yet to receive any updates or further comments.

I understand that you have many responsibilities, but I would greatly
appreciate any feedback or status updates on this patch. Your guidance is
essential for moving this forward.

Thank you once again for your time and attention to this matter.

Best regards,
Ewan

