Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6151C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 12:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4f2d-0008MS-UC; Tue, 15 Apr 2025 08:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u4f2T-0008Fx-Az; Tue, 15 Apr 2025 08:05:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u4f2Q-0004XW-5T; Tue, 15 Apr 2025 08:05:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9si2j019549;
 Tue, 15 Apr 2025 12:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=bzkHBO1UJ0Fvj8dNpGC4CkgZy1KvLg
 ruB6s3V7AVc+o=; b=HuwMlQFs6T/CxfdthePdiZH8DpQNmYBxnlrVWXCdzK86dj
 QgADCD6cX3yZKGQeUz1MKXXVeALCb7CftjL8oI7PmkBq1Y7JkfHGtIdLn75I7iva
 4qpnSrWvzQD1fNtp3qVnsDVc/XCRbml9yEQMIjjnFHXjOs6/uH6WmHBXgsm8VpAb
 nR7k0+pBzfpkUPmwugwR724M8ThgsoLhR35Q879ggDu6pf82xsEjDkAtqUvQkIcx
 n8Q4UkF55+00Tf8AS3KT7uIBPxpRfJXZpJ2SnoBtImqdHfevAPbZkg6QqMjtGUsq
 iMsQqiKUkf77NWDSJyuYrI4bn3gGU4+wntM9oCgg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461af53bqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 12:05:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8heMg024888;
 Tue, 15 Apr 2025 12:05:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtbakt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 12:05:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53FC54p337290412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 12:05:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 763DF2004D;
 Tue, 15 Apr 2025 12:05:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F67C20043;
 Tue, 15 Apr 2025 12:05:04 +0000 (GMT)
Received: from osiris (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 15 Apr 2025 12:05:04 +0000 (GMT)
Date: Tue, 15 Apr 2025 14:04:59 +0200
From: Gautam Gala <ggala@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, seiden@linux.ibm.com
Subject: Re: [PATCH v2 2/3] target/s390x: introduce function when exiting PV
Message-ID: <20250415120459.592492-A-ggala@linux.ibm.com>
References: <20250414154838.556265-1-ggala@linux.ibm.com>
 <20250414154838.556265-3-ggala@linux.ibm.com>
 <f96a9e7b-2bb9-4f0e-bbb2-3aca8bbbab02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96a9e7b-2bb9-4f0e-bbb2-3aca8bbbab02@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3GWIMBLvcaYAWsWkRS2_YkD73wyW8NO4
X-Proofpoint-GUID: 3GWIMBLvcaYAWsWkRS2_YkD73wyW8NO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=601 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150085
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ggala@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

The change is not really necessary. The existing macro looked almost like a
function, and since I was making changes in the area, it felt like a good 
opportunity to change it to an actual function.

Thanks,
Gautam

On Tue, Apr 15, 2025 at 11:44:35AM +0200, Thomas Huth wrote:
> On 14/04/2025 17.48, Gautam Gala wrote:
> > introduce a static function when exiting PV. The function replaces an
> > existing macro (s390_pv_cmd_exit).
> 
> You describe here what you're doing, but not why ... so may I ask: Why is
> this change necessary?
> 
>  Thomas
> 
> 
> > Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> > ---
> >   target/s390x/kvm/pv.c | 14 ++++++--------
> >   1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
> > index 3a0a971f0b..66194caaae 100644
> > --- a/target/s390x/kvm/pv.c
> > +++ b/target/s390x/kvm/pv.c
> > @@ -59,14 +59,12 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
> >    */
> >   #define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
> >   #define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, pvrc)
> > -#define s390_pv_cmd_exit(cmd, data)    \
> > -{                                      \
> > -    int rc;                            \
> > -                                       \
> > -    rc = __s390_pv_cmd(cmd, #cmd, data, NULL); \
> > -    if (rc) {                          \
> > -        exit(1);                       \
> > -    }                                  \
> > +
> > +static void s390_pv_cmd_exit(uint32_t cmd, void *data)
> > +{
> > +    if (s390_pv_cmd(cmd, data)) {
> > +        exit(1);
> > +    }
> >   }
> >   int s390_pv_query_info(void)
> 
> 

