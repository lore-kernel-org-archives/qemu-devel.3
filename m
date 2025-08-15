Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C64CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 05:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umnQ4-0007Ws-Pq; Fri, 15 Aug 2025 01:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1umnQ2-0007Wk-P8
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 01:56:03 -0400
Received: from p-east3-cluster5-host4-snip4-3.eps.apple.com ([57.103.86.164]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1umnQ0-0000Nl-R9
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 01:56:02 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 476DC18000AD; Fri, 15 Aug 2025 05:55:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=8qAx55w9rkJWF2cjGYToILhV2TZlh8v+oejrMtHt5gI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=EtGT06n+sRKRnezFHaniXJPaHW9MwztiTEWcUYIRpc0KlD+NlPBlGZXBZAjTl4r1Cm8bbwDF7b7hctPAEArKmju85FGmCA8rl0Sg2L0x0eXVWjrdT7o5Jx2LLZ1AUZNAMErPZt+YbQWZpQxyjZqWMMRHa5aPuGVPRuPoGyBLMpTOznOkTpGJAq+CBYUrASIFv+wvOFTjyI2HOoBw3F6GpydMHdUKRbm+FNSH2O7JgWiyzexS/utc66fZ+1hX1bWd9pZCgqTBd4zuF3RIA/ST9D1g3ixs9isiihi38suY/epHqlzq9EeB9lbbWN8TzAzf7C3LhqWKMZaAQMxKZR6pRA==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 0E67A1800137; Fri, 15 Aug 2025 05:55:50 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.2\))
Subject: Re: [PATCH v6 04/13] hw/intc: Add hvf vGIC interrupt controller
 support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <40259CA2-A38D-41C1-A726-5144FB9EA166@ynddal.dk>
Date: Fri, 15 Aug 2025 07:55:39 +0200
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <20832F49-1F5C-4023-9E0C-0D51A87A1770@unpredictable.fr>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
 <20250808070137.48716-5-mohamed@unpredictable.fr>
 <40259CA2-A38D-41C1-A726-5144FB9EA166@ynddal.dk>
To: Mads Ynddal <mads@ynddal.dk>
X-Mailer: Apple Mail (2.3864.100.1.1.2)
X-Proofpoint-GUID: QFtKZNJenlelA8Gxo1zABamlmcmt2BUg
X-Proofpoint-ORIG-GUID: QFtKZNJenlelA8Gxo1zABamlmcmt2BUg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDA0NCBTYWx0ZWRfX//P+OixQclbN
 QijXMxV6zVXBbF8kww8t6fUhc5QpMN9/VBICVnAX2IlgFNkH2drp4Q/MZyIAD5l+ZhnsUjy3xQH
 MOvyIlw21JTvhap5KvA7L6zaArjpq0tuAxW/5+wNrzOBhoo7FI9LjAqywtVbvhJBvvg/A2oeSS4
 TR0T3sCchpqUTVQjsok7zMaAnI77aTW2PEuIag0LIAnEMZ+068WYub4zepkTCb6PkeFegggd1Ne
 fzNKq3TUWNizz87goc/Ro5sRiPKrJ7DfhHOA9f7wmGI4HXNcRvOtLu/UYJaDjCObcH3cuFMfA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1030
 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508150044
Received-SPF: pass client-ip=57.103.86.164;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



> On 14. Aug 2025, at 14:57, Mads Ynddal <mads@ynddal.dk> wrote:
>=20
>=20
>> +static void hvf_gicv3_put(GICv3State *s)
>> +{
>> +    uint32_t reg;
>> +    uint64_t redist_typer;
>> +    int ncpu, i;
>> +
>> +    hvf_gicv3_check(s);
>> +
>> +    hv_vcpu_t vcpu0 =3D s->cpu[0].cpu->accel->fd;
>> +    hv_gic_get_redistributor_reg(vcpu0, =
HV_GIC_REDISTRIBUTOR_REG_GICR_TYPER
>> +        , &redist_typer);
>> +
>=20
> I think you should go through all your "hv_" calls and do error =
handling
> where it's possible, and if not, at least check it with assert_hvf_ok.
> This call to hv_gic_get_redistributor_reg is failing on my setup. I
> don't know if there could be others.
>=20
> I've configured my VM like this:
> -machine virt,kernel-irqchip=3Don,its=3Doff
> -boot menu=3Don,splash-time=3D0
Will do this for my next revision. On which chip/macOS release did you =
see this failure?

-m=

