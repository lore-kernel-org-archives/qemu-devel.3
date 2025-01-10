Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40F0E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEfu-0005Ix-PH; Fri, 10 Jan 2025 08:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tWEfi-0005BV-Mc
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:03:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tWEfg-0002E1-3N
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:03:29 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3sCRs030166;
 Fri, 10 Jan 2025 13:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jqFUKc
 YfXlr2vM7Nv2whBNXMYva5Qart/Xd/Q48kEHA=; b=oWGH7e9Y9jEKejhvMCowO9
 uC0PcwZ1JgkjNIzcdufTWKDkeibr/IHlye1jtUni3mMksgwACCvwDu39wlsJed1c
 QXASQi1TIPwnM6SuDHGAJDgEmrHu8YXA74KksZsbQ4QlSGqdWUDHRX0DaOf/6q1m
 3njjYP2mdAE94iJKhzIbLHXGQidc3LClpefezEXjoIh2lzegMDWJjYD/QBB5CiQs
 6HsznfG8B8ZrmcJm2Xj8/EkpVX568LDkvRfWUJZHvuEOGdBbcBLIiYFmP4MWqub6
 byg/Q4xhSc1WIT4nwOiNVp82bM4NsVgngThkHh5bSmPabpiNQY5Vfe3pOngqhvzw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442v1q21p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 13:03:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9t9gF013576;
 Fri, 10 Jan 2025 13:03:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygapa9b5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 13:03:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50AD3Ar840370658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 13:03:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B76AA2004D;
 Fri, 10 Jan 2025 13:03:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED5CE2004B;
 Fri, 10 Jan 2025 13:03:09 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jan 2025 13:03:09 +0000 (GMT)
Message-ID: <cf8a0915434ec6c48cf88fffc27a53239cffe34a.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/9] qapi: Make qapi_bool_parse() gracefully handle
 NULL value
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent
 Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Kyle Evans <kevans@freebsd.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, qemu-devel@nongnu.org
Date: Fri, 10 Jan 2025 14:03:09 +0100
In-Reply-To: <Z4EFnOMRUDsH6cpd@redhat.com>
References: <20250108202625.149869-1-iii@linux.ibm.com>
 <20250108202625.149869-2-iii@linux.ibm.com> <Z4EFnOMRUDsH6cpd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bYWUOOzabgFA5_GKfYTHHPeiYix3euxT
X-Proofpoint-ORIG-GUID: bYWUOOzabgFA5_GKfYTHHPeiYix3euxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=435
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501100102
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 2025-01-10 at 11:33 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 08, 2025 at 09:04:56PM +0100, Ilya Leoshkevich wrote:
> > Use g_strcmp0(), so that NULL is considered an invalid parameter
> > value.
>=20
> Why are we calling qapi_bool_parse with a NULL value in the first
> place ? IMHO this is a sign of a bug higher up the call chain
> that ought to be fixed, as in general all our input parsing code
> would expect non-NULL input values.

The intended use case is the following (patch 7/9):

    g_auto(GStrv) tokens =3D g_strsplit(*arg, "=3D", 2);
    Error *err =3D NULL;

    if (g_strcmp0(tokens[0], "suspend") =3D=3D 0) {
        if (!qapi_bool_parse(tokens[0], tokens[1], &suspend, &err)) {
            warn_report_err(err);
            [...]

The idea is to uniformly handle "suspend=3Dy", "suspend=3Dinvalid" and
"suspend"; the latter requires checking whether token[1] is NULL.
Of course, this can be special-cased in the caller, but this would be
less elegant.

[...]
>=20


