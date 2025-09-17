Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ADACA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 09:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyoeB-00063L-JU; Wed, 17 Sep 2025 05:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uyoe8-0005zs-Fd
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:40:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uyoe6-0006MD-BV
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:40:16 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLmVmS023783;
 Wed, 17 Sep 2025 09:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mrAes2
 W0HUububBniJikgstQMoKyOmjoM7OLbrAJY+8=; b=KxXvHLP9qU7q6ValGCFYI4
 6FqBvA3P5pRqXHDlARgWTp/+9DPK+ZIWGcqMR5CBOo+yZVVDjvqi4I+3v8QMXtP7
 FwPUZa7kcQO1x8J75SReOmrOg8DZIB1TC9aGlVmFwc0t4r71QiJfX4fSOtd4v9lj
 8U7k5nHhZ/8++LfaTR4J7jYynzVtHU0RUhPqsgadgATHmdzgnpCz4nJhfVpa1Epi
 sGPYRNYGP1Mcgk/Z44poiEpwaTnkYzKQ7OcA6THrbMr9NelraPlGnMN6pDH4PT0P
 Q6zZpXlHZiKK8bNbmS8nsl/kmqo6aLE3ohboud7t4vLd59Hv4GsAEY0/Wee4Cpdg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qjksw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 09:40:03 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58H9WkBb002476;
 Wed, 17 Sep 2025 09:40:02 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qjksg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 09:40:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58H7n2Wf018620;
 Wed, 17 Sep 2025 09:40:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mgbmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 09:40:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58H9dwCL49021268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 09:39:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CE7E20043;
 Wed, 17 Sep 2025 09:39:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48C4F20040;
 Wed, 17 Sep 2025 09:39:57 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.111.5.195]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 09:39:57 +0000 (GMT)
Message-ID: <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, nsg@linux.ibm.com
Date: Wed, 17 Sep 2025 11:39:55 +0200
In-Reply-To: <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6hsHuiATo5Pc_LGW5WyHvxzFynS4zuPx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX0MYIvNDHrN/e
 7nl82MHGfVbsHDgYEAKRaIvbgQ6VGZmEgGBGcd5fRrPP9MwdgUGzWIQmbiqaLgzMf3qrAcBswgK
 YOi4YlEa1FuMvV23SdsOl59O/1xylxtruBfmw9g6CHWivv6QliRts/Z/BXYlekgrmf41WUJUB8T
 9qXYp9tPimvo7ZNi9sJ7mm9MBoglnKmOUXpiVGDmb7muOoF6FdAtpZkZDbjWpV82ZQSQD0xCgSK
 4FXDOfNjEfDLCGEhw7niIFE3gHFL/OOMWRZVu/evISfY2Ur562h5rrAWVyNCrM94AYQCVMmR/xY
 ocuK/7jYpMhRLylPY0J0Y0vRWn5Kw9uos686C1mGsLIextLDibPtUe4FYJni+mZxUnyS4HgMpBD
 5Qros1wN
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68ca81f3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=SAufGHXYw6QyTyq76rcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WKAvVvkKdxKAOchh1HWc4YErm4hu7f5K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=maxbr@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2025-09-16 at 00:02 +0200, Filip Hejsek wrote:
> On Mon, 2025-09-15 at 18:34 +0200, Maximilian Immanuel Brandtner
> wrote:
> > Update the terminal size upon SIGWINCH delivery.
> >=20
> > Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
>=20
> I don't think this will work, because SIGWINCH is only delivered for
> the process' controling terminal. Unfortunately I don't think there
> is
> any way to get size notifications for arbitrary terminal.

In that case there are two solutions:
1. make qemu the controlling process of the pty (this has the
disadvantage of QEMU being quit when the pty is closed)
2. create a timer polling every eg 100ms to check if the winsize has
changed

I would go with the second approach then and implement the timer as a
g_source. Or are there other timer mechanisms I should use instead?

