Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965ADCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 12:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoLMk-0006Oq-KC; Tue, 19 Aug 2025 08:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uoLMi-0006OK-23
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:23:00 -0400
Received: from p-east1-cluster6-host5-snip4-3.eps.apple.com ([57.103.90.174]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uoLMg-0006P7-AE
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:22:59 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-5 (Postfix) with ESMTPS id
 1585918001BF; Tue, 19 Aug 2025 12:22:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=H25lEFx3jpZ5j67JzjHMBzcGjUcRK3xA3JhFxZLrGVA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=O5mqadboS97LEt6JNYeb9Dp5zTC5INAmrZ8Y6uRFCA++en38nECM5SJ1Sjx/e2n4C4z3S84eXwY7GeIaakAs2MAzBDl0QqXLE5HTlIMIDrYCVmTzezD7QJD807IleFOe2UDuwLlBvodpq2iBMSciuhYt5/oF9MWv0ABIsb6gjfHNCIhISFj39+AA5tFIkyqH3fP5myI15IFTsTV3Mx5nTZFomcufv4PXvyVB7Gi8xmz6wbE65wYd7R5PJ3V/urckCRku4JVhj9j4vSnk+fq6nI/Q16uKjTdvjJXXPt66zpgWLw63nDP4ylGwHfD2bf5ZkNjkMmdOoW3fyrTIq9cstQ==
X-Client-IP: 194.62.217.67
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-5 (Postfix) with ESMTPSA id
 7B1C618000AF; Tue, 19 Aug 2025 12:22:47 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 13/13] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250808070137.48716-14-mohamed@unpredictable.fr>
Date: Tue, 19 Aug 2025 14:22:35 +0200
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE220921-4154-4EC1-B675-C235585F841A@ynddal.dk>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
 <20250808070137.48716-14-mohamed@unpredictable.fr>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: _VFgiOvF7xkXNuj5RKtAqN-OgSfqV5ev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDExNyBTYWx0ZWRfX3DiRh5KcaM5I
 ONBGFETErmARvSrFd0dgTa0asgy6fqDpTv1EN6fjJ2Ruj6JAAENfHHIom36WLBsHqVid4x979gT
 kRI+etruse+1l6tAcIMQIpOp5mDEwPXYO/0dj0sEjE6aOwhSGER17csBM0b1KS2zLFdA63yrSok
 3TCFfuGABQwozZ8lnCr2GVYocY+0kvK1S/3wkcf0FR62ICwYSJd60kvn/LHLyjBPwf/PuVPAH8t
 2ibbsXmN6W9w5JX1tWIQUkEXnhu3x4RgW2Kh7Gy3+pnq5YeXKNOd4Xi+XDIivaMFeX3GYyR0E=
X-Proofpoint-ORIG-GUID: _VFgiOvF7xkXNuj5RKtAqN-OgSfqV5ev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 suspectscore=0 mlxlogscore=770 bulkscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508190117
X-JNJ: AAAAAAABrmImtAAabBlX83xbb900CyxIvwgbyi/I0EieV8Lw7NsL1dD8z/Lwg1HRsyNg9Md9NsDKY5YjdZ6F1lJo1QV23rrZuwbh51USzYeBWpwRsLPwnKrDF5c16D0l81iTEhWAYwZoqO4xQ6i3qj4X7ls+aLnQBtMduMJFr7hvcXNvngl+fiC/MbP9ontZfxTDge9RdgYRsI4iR9jnsTgxPeF5sjdAYCAgmxkRLF+LNMQRcEzH0TBkLaWWelX1SvXl+ye2q2lTkicc2GegcTsmmZTauUfR/B1BQkZlCnRDh3753c/ViGTMYe9kn+mk1lKv5Nk1eXWkH34wL4vCA5f7rQ49WEuDwZ9n9UtT/q7X8tKNPJD/wG3CzWEZv+w6Yg6kZWAeYZkpXKM+6U8pC4p4T5UL19AVZNbOnvhno2NAupM+D7i5dfgTIbTcyV9vYxcfOUo4sp7lj/zblOKYNw88k7JtOH/qpi9MEEqtLx1p2wEItxC0rWWlYWUvyayAF4ylic7y1Am4uVJnH2ehZeFlOWkg8fyt2EJePurP8tWw+KzOzkaC3WOrp1t5ndI6XlEmUSNwjlx9hvbkPsDe/FvLQlZIaa495g==
Received-SPF: pass client-ip=57.103.90.174; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 8 Aug 2025, at 09.01, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> When using the vGIC, timers are directly handled by the platform.
> No vmexits ought to happen in that case. Abort if reaching those code =
paths.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/arm/hvf/hvf.c | 3 +++
> 1 file changed, 3 insertions(+)

Makes good sense to verify this.

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

