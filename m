Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E96BC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 10:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulPSR-0004o5-KX; Mon, 11 Aug 2025 06:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ulPSN-0004nk-Kc
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:08:43 -0400
Received: from p-east1-cluster6-host2-snip4-10.eps.apple.com ([57.103.90.151]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ulPSF-0006MY-Qz
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:08:43 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPS id
 7A2E718000B2; Mon, 11 Aug 2025 10:08:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=yE2Zz5SdXnft02cp3Dzc9pGHcq8QxtyDjTzLPwFNT1c=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=F2fDDGzFurr0iGrFdeVkPTIYPC74IPNZC7ZhxD4ZDTiNC1P5tj/VI0GDE1X1sQXmwwLBKJ9P2qD4uWWMtflUI+HV09bSZzkJwcq0SUEa3my1UdkXnaNQA7Bft1mrbK6mGum683B6+8R4/FY7HfsjG0uTygabdPSNUI4KK0yzzlYnllVEr5RF7V3/pRlA/AhpglbcM0/0oMNlYEITldqYUpKiAlrgoYPHR1tOHMH+6oamTC5HKFjSZlIXdF7lL6iivtZ2zWi1HEjhVtUR68FUq6HNVHqCazcq5/z6bJWDRgpObuLZpqvJpnMkZcdF7Cp/QCW2hpMHl+j+azc9LiwoRw==
X-Client-IP: 194.62.217.67
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPSA id
 F0B4718002A2; Mon, 11 Aug 2025 10:08:24 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5 06/13] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <d2e93df6-bbb4-427b-828e-b6f5466ae2be@linaro.org>
Date: Mon, 11 Aug 2025 12:08:13 +0200
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CB6CE7B-B122-4BE1-B031-EF44D0A79B63@ynddal.dk>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
 <20250728134114.77545-7-mohamed@unpredictable.fr>
 <d2e93df6-bbb4-427b-828e-b6f5466ae2be@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: hbrtOuySDH8ABkVvJzAr0NRB4ctnHbRA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2NyBTYWx0ZWRfX8ME59dx4laS0
 tcQNVsXNLjmmcXcmk2RT6UIeqoRjOWxoHyQHTARtWUaid8hFGm/TO6IuUCcf8T1ASwKmH0aT0We
 CfYCSDro/LkQ1HNlPiCrEWGADeSMUyuVjIlUfSrLHGmo5hUntFF5gedMej2d1h21QbfFx1c2jO3
 feLhV06zX2kY0gPTQSsXjAqqzA45uiNgDZAJagDfFAzlsrZwvIgx14IrGvFvqHYpgYBa20cM522
 aJBdM2YyI/3f6vkYVEpKR2MfvLxQpYmkqscEGAkoKOl5RcX/wOnXqctjZLr182A9+zmh/iYFc=
X-Proofpoint-ORIG-GUID: hbrtOuySDH8ABkVvJzAr0NRB4ctnHbRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=540 clxscore=1030 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508110067
Received-SPF: pass client-ip=57.103.90.151; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> We'd like to remove the assert_hvf_ok() calls, so adding more isn't
> really helping. Anyhow,
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

What is the preferred method going forward?

Apple designed the HV API to be able to fail at every function, and it's
rarely something that can be recovered from.

In [PATCH v4 04/15] of this series, we saw an issue that was hidden
because the return code was not properly checked (not calling from the
owning thread). Previously, I submitted a patch (d5bd8d8267) for the
same issue, because Apple had changed a function's behavior. This was
caught by an assert_hvf_ok.

I agree with you, that generally adding asserts is a bad design, but at
the same time, HV is designed in a way, that the code would be littered
with checks otherwise.=

