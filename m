Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34D6C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 19:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4QSl-000514-R4; Tue, 07 May 2024 15:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1s4QSi-00050U-0Y
 for qemu-devel@nongnu.org; Tue, 07 May 2024 15:26:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1s4QSc-00010G-F1
 for qemu-devel@nongnu.org; Tue, 07 May 2024 15:26:48 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 447JOJFD004965
 for <qemu-devel@nongnu.org>; Tue, 7 May 2024 19:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=V+EHed/+PBD1SO8RClHawGZvBw/frxXbYRzPmbuCkc0=;
 b=F3XNKinjn03i/AfFW9GkZaUN6f7imlBohyHdVhdn2cVlZ9r/lMdqNoZPxeYxYJFEjIwg
 QnHIaABYMhEmAkxm2FOHLwCxF6VAWuELpN96FAw5R96Z9embehwcG6TVQW3FsEK98mMB
 r57AiJGYMSYxQtNb2vZoRiZ2hxeJcK4fGmHuGgjv5+lWEc1iiEvRYeI9xMrFucJMBOaL
 upx04/mvo/vdCA8IEg+8HX86Ks42r+4l2t9+8fTpnRDwOuY396Cn3QD1uCHDUjKKE6d0
 h9D+PJhr9JQs5rd+JdXVDU9Id+EZtDh9DJXhQq8iJ8Rveidh1CdRpFnSm99Ob2rIuz5n hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyt6601g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 19:26:42 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 447JQgMG009374
 for <qemu-devel@nongnu.org>; Tue, 7 May 2024 19:26:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyt6601fx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 19:26:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 447INlXV009277; Tue, 7 May 2024 19:26:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xysht09dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 19:26:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 447JQZai51904874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 May 2024 19:26:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E0AA20043;
 Tue,  7 May 2024 19:26:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D695320040;
 Tue,  7 May 2024 19:26:33 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.14.99])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue,  7 May 2024 19:26:33 +0000 (GMT)
Date: Tue, 7 May 2024 21:26:30 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marc Hartmayer <mhartmay@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] vhost-vsock: add VIRTIO_F_RING_PACKED to feaure_bits
Message-ID: <20240507212630.42c00883.pasic@linux.ibm.com>
In-Reply-To: <20240429113334.2454197-1-pasic@linux.ibm.com>
References: <20240429113334.2454197-1-pasic@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kY4Jjg6ioRigRC1dQtDbS3t3Oz193iZX
X-Proofpoint-GUID: afwTuk48SgBCZDI-ivMxOwh1_d15gllZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_12,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=852
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405070135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 29 Apr 2024 13:33:34 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Not having VIRTIO_F_RING_PACKED in feature_bits[] is a problem when the
> vhost-vsock device does not offer the feature bit VIRTIO_F_RING_PACKED
> but the in QEMU device is configured to try to use the packed layout
> (the virtio property "packed" is on).

polite ping

