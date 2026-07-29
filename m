Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61426C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 04:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wow9j-0007Ty-Qc; Wed, 29 Jul 2026 00:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wow9g-0007Sb-5w; Wed, 29 Jul 2026 00:44:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wow9e-0005PC-KF; Wed, 29 Jul 2026 00:44:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T1JGaF2717083; Wed, 29 Jul 2026 04:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=0HvNb41BYWs4ARy7cF3NJ3OCdRMp5u
 m5w7FhRWyT3Cg=; b=gBdt2kHFXtgWi1s90hCDhP9Z1MP9R7h83sO71DGdFzvs3D
 1DP/ZpowhTikX9rPfU0IPz5106uDTtTLVHwMrkBVIyniVOycUQMzKMYGKAvyYRbr
 MBStkMlsSxxcBh2tI9H3WwB4litEudAGtS3/u0vZfqmn67wwundjFOYYGdXqtOM5
 hqByrpvo4nDwNJZ4eJH600VwQVPyEF1Jjle7NRNmlbycApFWaK7d+MPC+xY1ws6Z
 azrNHthLtwTWg6JtCpc4coGi6/8gfWKKy27pN6WekyDA5bMCvQP00nd5T/8rhZMN
 CfNE3ArZGtvSQ3ivdyHoHqzvihXtWYLKW1LOBF6Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nr3sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 04:44:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T4fc9W016959;
 Wed, 29 Jul 2026 04:44:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y4vwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 04:44:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66T4iMcB46530886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jul 2026 04:44:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C9992004B;
 Wed, 29 Jul 2026 04:44:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFCD220040;
 Wed, 29 Jul 2026 04:44:20 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 29 Jul 2026 04:44:20 +0000 (GMT)
Date: Wed, 29 Jul 2026 10:14:45 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 qemu-ppc@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] target/ppc/cpu_init: make cpu listing determnistic
Message-ID: <20260729101217.db953dfc-ee-amachhiw@linux.ibm.com>
Mail-Followup-To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>
References: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728150627.b0e3b230-14-amachhiw@linux.ibm.com>
 <54a09c6f-0ed4-49f8-abec-afd916faefcf@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54a09c6f-0ed4-49f8-abec-afd916faefcf@oss.qualcomm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAzMiBTYWx0ZWRfXyVwCTmgAhFW9
 wDpHhDH39g/fEFu2+NCj02imPgzkcxrVccfqcN7xjXbhXDXHM3JbBnhOx35oweb8crCtr7gjDZ6
 q/pSFKBlS1wAgdkYdQ6P9Q0xG08+nvY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAzMiBTYWx0ZWRfXwAOuCfWWPe72
 wF0nKo+82/zS2VoJ8asoddvPVqnrujJKavLuTvB/W/tGmvi2Xynsaw2Zttylkq5l/UYMsX+0vzv
 H816o6C1MU3MU7KZbfMCYw6eAl55Uqv4svtFqEnn348gVL0RmQ6BBPutM0nW0jSpi2ObKQ8dRqV
 0oJUZShz/u2++8ZbRPyEj+048TQG2FleE19RzAEwsEhAeerYirciLI5wt0bIV25TB3GnfTaD4VG
 jLArYTdxmWzdGeI15JsiwVKaXZ5MNCx319feOjW+6Rsua00xT+7tcdj8jzVjCe/G7itjIwO0lKf
 Kl6oKzHykDtUEglWJ4VKxKcVgxH5wMP8lgmJb5FzrKDg1rWNimV8tKzslUMpC3V90hppnn83mxv
 6AOETsmBxegXJrPzYJ+ex0Z7qchZ6Y3S7mAfTN73jVt3DDd7uL9+zA4sIRovT22s216xemhFsOa
 tu5JyUFd+JTW3whPzZg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69852b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=S2qm46derESQu8h7nLUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: PG5ezyfv8jxThQvX7TEaDqZMA07HoAfz
X-Proofpoint-ORIG-GUID: qnqXcXJEW6WCg51dC_fykWo0pmFkminD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_01,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290032
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2026/07/28 10:57 AM, Pierrick Bouvier wrote:
> On 7/28/2026 2:40 AM, Amit Machhiwal wrote:
> > On 2026/07/20 07:24 PM, Pierrick Bouvier wrote:
> >> The existing compare function only make sure that we list cpus with PVR
> >> order. However, we never compare cpu names.
> >> As a result, while cpus are grouped per PVR, the order within a group is
> >> non deterministic. Depending on QOM type initialization order, we get
> >> different results for -cpu help.
> >>
> >> For instance, previous output could be:
> >> Available CPUs:
> >>   755_v1.0         PVR 00083100
> >>   745_v1.0         PVR 00083100
> >>   755_v1.1         PVR 00083101
> >>   745_v1.1         PVR 00083101
> >>
> >> While a sorted output should be:
> >> Available CPUs:
> >>   745_v1.0         PVR 00083100
> >>   755_v1.0         PVR 00083100
> >>   745_v1.1         PVR 00083101
> >>   755_v1.1         PVR 00083101
> >>
> >> Fix it by comparing cpu names to have a stable result.
> > 
> > Verified the before/after output of `qemu-system-ppc64 -cpu help`. The
> > patch correctly stabilises ordering in all PVR-collision groups.
> > 
> > No regressions: identical CPU set, ordering only.
> > 
> > Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com> 
> > Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com> 
> > 
> > Minor nit: subject line has a typo ("determnistic" should be
> > "deterministic").
> > 
> > Thanks,
> > Amit
> >
> 
> Thanks Amit.
> 
> Do you need a v2 with a change, or feel like fixing the typo when
> pulling this patch?

I think its a minor one and a v2 is not required just for this.

@Harsh, could you please fix this while pulling it?

Thanks,
Amit

> 
> Regards,
> Pierrick
> 
> >> This allows us to record and compare various command line results across
> >> versions to make sure we didn't break anything while working on
> >> single-binary.
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >> ---
> >>  target/ppc/cpu_init.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> >> index f404c7e549d..3443dbeeb01 100644
> >> --- a/target/ppc/cpu_init.c
> >> +++ b/target/ppc/cpu_init.c
> >> @@ -7130,7 +7130,7 @@ static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
> >>          } else if (pcc_a->pvr > pcc_b->pvr) {
> >>              return 1;
> >>          } else {
> >> -            return 0;
> >> +            return strcmp(name_a, name_b);
> >>          }
> >>      }
> >>  }
> >> -- 
> >> 2.43.0
> >>
> >>
> 
> 

