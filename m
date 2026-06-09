Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE39BCD8CBE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrQN-0007UO-Jw; Tue, 09 Jun 2026 04:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1wWrQJ-0007Tt-VG
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:03:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1wWrQH-00068U-Py
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:02:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658HF08f1423793; Tue, 9 Jun 2026 08:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PAYdUD
 iO5bNLV5DWPP2LtvKadJD1VcM81xHQh8lf/tw=; b=NP00Yrh0GtTAuadk8Pk1sU
 GQpY60RExeNkBy8Y6A03s4KFIsxLZroUEqUo+AIU9e5M+7A3sOW/Psromy2YcXt9
 1zfZBkwoNSZY7o3zaraqTBfXEofmKqfaVpfzLyLlJ9NUgiW+kWq259PSLRcCqAUJ
 OUkZNLgK4lL5mQYuUQRAk5fzQqUSLGGMpAk5QXNFau3xXtpLE+Fzy3ys4UaYqxER
 OkJL1u6eP0fAY5SEOVUYKGAFmaMjC2ah+XRJPVB41hRFdz9ZaDqBHwqLXczp78QR
 cb6y8VxkjIoNSR2k0DgzOtznQydZtKAUQaEK0Go0Gn+TjuvU/P4mgMgkDavUIdkQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye2yt4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 08:02:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6597ndc2006193;
 Tue, 9 Jun 2026 08:02:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych0y22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 08:02:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65982ejR23658978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 08:02:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A47812004B;
 Tue,  9 Jun 2026 08:02:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71BBF20040;
 Tue,  9 Jun 2026 08:02:40 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.224.77.197]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2026 08:02:40 +0000 (GMT)
Message-ID: <cc0b8cce5bf5763ace058270e9d80fb84873dbd7.camel@linux.ibm.com>
Subject: Re: [PATCH v6 00/12] virtio-console: notify about the terminal size
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, Markus
 Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu	
 <zhao1.liu@intel.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=	
 <berrange@redhat.com>, Szymon Lukasz <noh4hss@gmail.com>
Date: Tue, 09 Jun 2026 10:02:40 +0200
In-Reply-To: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MSBTYWx0ZWRfX90R0EgnsByuu
 EdWGL188V44VzrG7/0EkyC9X3olacy0YoAjo/w2mvi4HLp95EzZKpFgQfzdndPCycnKcKzdQRdx
 PoUHofmJAK2wQe+t5CpnPMUsslYYZJx6V9FK36Q34V7MkEaRRfZEncsLs35zitLOlSfeZd5VKl0
 gyDqj0WvAGaq4ucNiP+eOig09c3zi2R6LK4R7UAnxuKpFGt9qtEelyKLML2Lnl7W+2RzJDcKNn7
 EpsjHTyNI0G7JX9KVsVfOhOyZbKPFo1TPQU+wB7jv800IebmsGXzOv2M2jPxL3fJACEzqh/JvHn
 boIiUh9Nv1smPe9PvJry6VXx0vmbQLxcLZms1dw3P/pFUU2BNOHeVsBF4JyjzF1OrkkNIFSk52V
 cFKSG3HVTUJxG+1sZgmaFcYMro+eJMzOUU8Uet7+1vcIoXb1cGUtAyjbt8klegbPn7+hZqoh9ZH
 j99L42xtC9DIUkfGhLw==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a27c8a3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ohnBKmd6VOgfx0W9Dn4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zM3w9YiNu8lA8GvCVf3LCL8YfdiHVuef
X-Proofpoint-ORIG-GUID: ZEbDBRc4NqA-GLCM-OVeToWqy1kQffWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090071
Received-SPF: pass client-ip=148.163.158.5; envelope-from=maxbr@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

What's the status of this series? It seems to me to have somewhat
stalled, because of the virtio resize event discrepancy that has been
adressed by backporting the relevant patch. At this point it's been
almost 6 months since any changes have been made to this patch-set,
even though at this point it would have to be refactored to address
changes that have been made to QEMU since. Has progress on this patch-
set just stalled or are there any remaining concerns about the
implementation of this patch-set I'm unaware of?

Kind regards,
Max Brandtner

