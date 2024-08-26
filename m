Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781D9C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 12:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siYWO-0001Qn-G1; Mon, 26 Aug 2024 08:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1siYWN-0001Pl-Es; Mon, 26 Aug 2024 08:08:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1siYWL-00025q-Gi; Mon, 26 Aug 2024 08:08:31 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PKZmbd024540;
 Mon, 26 Aug 2024 12:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:mime-version:content-transfer-encoding:in-reply-to
 :references:subject:from:cc:to:date:message-id; s=pp1; bh=hfMl3T
 7exh+7WFAVLgwYloAmZHwWBDIs1CdGYXTkY1M=; b=bsgTpsi8XnVGkg+K14q2V+
 6y6Ju0iMYCH7n7QSMOh29QxCyt5+B8Ez2gdYii67dDnZrJC1nCW7d2Brc64jdmKi
 uEQqK08Nkc1kpd15ulG35lp+hXS+wBn/QA6hS72RVIUZb+zXgIddmbG9o8phCeXz
 MhoAf8GVuzCkxPZvIMdVu7k1fCX5uWTazWC2gxB7j1+7IjmSlY96Er1M4pSDcVi5
 XuhFCNUG74/9c00xXzOlkI1BxebKQjCEQQU00bMsEx+opXGL3n0p5F3vAt2FEWqI
 UwxEibMXyH9nBLDdBdFgTyCyRmy1XSyKmtNB/uEPeK8hLKEYAbnAz8IzPcGv8hZw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417ged6ejs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Aug 2024 12:08:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47QC8PPD022711;
 Mon, 26 Aug 2024 12:08:25 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417ged6ejq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Aug 2024 12:08:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47QC0Ll8021741;
 Mon, 26 Aug 2024 12:08:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 417suu65fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Aug 2024 12:08:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47QC8L1r52953430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Aug 2024 12:08:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23A8520043;
 Mon, 26 Aug 2024 12:08:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 024A720040;
 Mon, 26 Aug 2024 12:08:21 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.73.145])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Aug 2024 12:08:20 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw,
 cpu to three-phase reset, and followup cleanup
From: Nico Boehr <nrb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Aug 2024 14:08:20 +0200
Message-ID: <172467410002.31767.12365606864399178508@t14-nrb.local>
User-Agent: alot/0.10
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R2-BdSQwMaSk8VJJRzmYWYstYeGrAxdi
X-Proofpoint-GUID: TM_R5baHdPL-aDwlujlszB3zBbIsrPst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_08,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=918
 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408260094
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nrb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Quoting Nina Schoetterl-Glausch (2024-08-22 12:34:14)
> I'll run it through our CI and see if anything pops up.

Nina is on holiday, she asked me to quickly report back.

There was a little hickup without the fixup to patch 2, but after Nina
pushed the fixup, we did not observe any failures related to your
changes in our CI. Thanks!

