Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DE2D41156
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 10:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgKEc-0005NX-PD; Thu, 15 Jan 2026 05:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vgKEb-0005MW-9z; Thu, 15 Jan 2026 05:05:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vgKEZ-0002d0-Mu; Thu, 15 Jan 2026 05:05:44 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60F9JpU6023573;
 Thu, 15 Jan 2026 10:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ekg4mY
 08BPRLGEzngw0AEOB8lQz9VcFRiPodHJnRMao=; b=fAA9dOrBZjsCB1tKrfuyGx
 dIWKCBd2ORYLz2ZF3/EpZDLC76zInMH9TtMozFfkfplTEyH6nZ0I2LaH/ud3VBDx
 HQFRhZ9I/qrIzGIBEVOYeH5gVLGxmDB0QkwVNcPBK32ZNeIDRQfM/CSVTDb3GG14
 Bdu3CzfyJuztKf6YYLSAIYHEeQd+49KBK+na8LHfiXYM4KwhWc3bmzeyYZt9W+0g
 k1wAFYtGCRh51+hGc9+TW82u7gFKLLgiL6FCBCJW5nJE219kpIYqss8jLjXKaxXx
 fUCvty0Jyx+EfL0vytm8K+fBCTXXgwAlsAhssqnF723qs9Pjo72BK89w42XNQ3tw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedt5f8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 10:05:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60F83iBC025566;
 Thu, 15 Jan 2026 10:05:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm23nfa2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jan 2026 10:05:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60FA5YKh56164844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jan 2026 10:05:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20E2A20065;
 Thu, 15 Jan 2026 10:05:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E48F82005A;
 Thu, 15 Jan 2026 10:05:33 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.52.198.210])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 Jan 2026 10:05:33 +0000 (GMT)
Date: Thu, 15 Jan 2026 11:05:32 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: JAEHOON KIM <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com,
 fam@euphon.net, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 devel@lists.libvirt.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH RFC v1 3/3] qapi/iothread: introduce poll-weight
 parameter for aio-poll
Message-ID: <20260115110532.27cb1516.pasic@linux.ibm.com>
In-Reply-To: <87ikd3xrkc.fsf@pond.sub.org>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260113174824.464720-4-jhkim@linux.ibm.com>
 <87qzrs4oud.fsf@pond.sub.org>
 <eb891295-5ffd-4613-bc37-56d8a07d1fff@linux.ibm.com>
 <87ikd3xrkc.fsf@pond.sub.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDA2OSBTYWx0ZWRfXw4rAxSxvHZ2J
 o8r6s0NWwl4OaB4pCPRzYqsoBx8lIx2GlEkF82CQypfMVf3BAHCtxB2MTHos/42zXUBLOEdlNfc
 7o3VBEiUJMmidm9IDMenRIq1Ll2vR7ioXHxRE1vOiH2gHbEWQllSUPXUEg+lOxqb6AYMYGn28Ts
 PoaG1O01xMdYhOt2HF5gy/bbkE7HlPFpBoxv9rYpKRZxZI0+oFHkYmEMlBha5phm0yNewnr8QJY
 J68bzUil7vXHRnJX80Hw5lnin7cOT5S5tpioAUK6dzTr1XaPCkDkbShpWG/9uVVtpj/XGqwqx+o
 C7E0edC95RHSncEWIX8tNhcrNZZxJjkoniYzeSx8/s9S6zdVkIqqfkQ5+OxpDOPFQ2UtmiQ/pyg
 74fp1f384elXkCBh2nrK4+jugpN0PdjTcMAdXFoRkbTttMtrOsWmjCHvoOVFhgAK4ZeisbNjWCC
 lLqzyoNgNq49929xgVQ==
X-Proofpoint-GUID: nXYUkDTdPYjddVwqSwn7BJdG9Sc8zW-_
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6968bbf2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=cv7ZjbEX4tCoQRNZzaUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: nXYUkDTdPYjddVwqSwn7BJdG9Sc8zW-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_03,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601150069
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
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

On Thu, 15 Jan 2026 08:28:51 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> I understand that you're mirroring how @poll-grow and @poll-shrink work,
> but let's ignore that for a minute.
> 
> Compare four possible interfaces:
> 
> 1. Optional @poll-weight defaults to 2.  Values <= 0 are rejected.
> 
> 2. Optional @poll-weight defaults to 2.  Value 0 is replaced by the
>    default value 2.  Values < 0 are rejected.
> 
> 3. Optional @poll-weight defaults to 0.  Values < 0 are rejected.  Value
>    0 makes the system pick a value, namely 2.
> 
> 4. Optional @poll-weight defaults to 0.  Values < 0 are rejected.  Value
>    0 makes the system pick a value.  It currently picks 2.
> 
> The difference between 3. and 4. is that 3. makes "system picks 2" part
> of the contract, while 4. doesn't.
> 
> 1. is the simplest.  Is 2.'s additional complexity worthwhile?  3.'s?
> 4.'s?

Isn't there more options? Like

5. Optional @poll-weight defaults to system-default.  Value 0 is replaced
by the system pick the system default value. Currently the system default
value is 2. Values < 0 are rejected.

That would mean:
* current value inspectable
* system default not part of the interface contract
* interface offers a "please go back to value not user specified:
  operation

BTW I like your approach with explicitly listing and evaluating the
options a lot!

Regards,
Halil

