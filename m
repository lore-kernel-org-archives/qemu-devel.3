Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E47C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcok-0008Lq-Vr; Fri, 04 Jul 2025 05:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcoj-0008Lg-Oe
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:34:49 -0400
Received: from p-east3-cluster4-host9-snip4-10.eps.apple.com ([57.103.84.93]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcoi-00076k-8z
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=jC7wpVSfptGSKQNhfifAQf88TarhTWI3lXHmAPkaLIE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fv4d+/ssMjjZRvl+bi2zpn1ICNfnzzmG2pf+BB3syOrG+HLD2UnuHw9UJqfMpn0Cz
 oCNxQG3iNNDAfVvMLWDOo0J8axx8pDeZA9iwsDphTABCjkHHOTiR60DePOKkzMhA1r
 w6sqv/KEq4g6KRcEdpV5Fm25TcUL4dAtFDzMqdw2ATaqUqLAyBq0rWfOrV8m5hvkj8
 8hfnr/Qd63XZYhOzP7VZwRN9noq/FbDkmYggLZP8BsG/4PNxOM0YCSSOfIwAEoDYUy
 o/ejRzOVXWuwGp1nPBPwa48hsxjf76seYOyPTuerm61lx6CrricdKlBvnpmz3BAztG
 UjS/kP4MWi5mQ==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 4B3EE1800146;
 Fri,  4 Jul 2025 09:34:42 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id 80C6D1800166;
 Fri,  4 Jul 2025 09:34:39 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 58/65] accel: Always register
 AccelOpsClass::get_elapsed_ticks() handler
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250702185332.43650-59-philmd@linaro.org>
Date: Fri, 4 Jul 2025 11:34:28 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E85BEC9-8431-4078-AE7D-B39575A0A155@ynddal.dk>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-59-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA3MyBTYWx0ZWRfX4RhBOv1FtGUi
 paYD8h7EWn4Xf8MRKYylkrEyXc7vsT7b8A8y8ICl5BJ44GCBKuwIMwd8OID7Lt1AmN6Xkbpkhxo
 evhMRfcU7UWhMWy3GNDmwmyoZiLPr6wGzGw2vkkRlXhJ64tqKG5+VrP8KolE79P+YubgkeKiqdy
 tbBKrZiEF/Wf3FDcv/Sk8qOgqjLaGWQvYvcNk2O5OxoM5dZDfsucgJRG9/dVgd1DvfbUy4ULiJO
 P6I5JALT74fCxmhI0WoAHBdkUjQpWs7e3kCzNKhfkcvVb6yQTSkeYbC/0i8HoZ9vCMH6tvFgY=
X-Proofpoint-GUID: koFkGGtkRgsisw6n9qz2oN3WDN2lMeNE
X-Proofpoint-ORIG-GUID: koFkGGtkRgsisw6n9qz2oN3WDN2lMeNE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 adultscore=0 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507040073
Received-SPF: pass client-ip=57.103.84.93; envelope-from=mads@ynddal.dk;
 helo=outbound.qs.icloud.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 2 Jul 2025, at 20.53, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> In order to dispatch over AccelOpsClass::get_elapsed_ticks(),
> we need it always defined, not calling a hidden handler under
> the hood. Make AccelOpsClass::get_elapsed_ticks() mandatory.
> Register the default cpus_kick_thread() for each accelerator.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> include/system/accel-ops.h        | 1 +
> accel/hvf/hvf-accel-ops.c         | 2 ++
> accel/kvm/kvm-accel-ops.c         | 3 +++
> accel/qtest/qtest.c               | 2 ++
> accel/tcg/tcg-accel-ops.c         | 3 +++
> accel/xen/xen-all.c               | 2 ++
> system/cpus.c                     | 6 ++----
> target/i386/nvmm/nvmm-accel-ops.c | 3 +++
> target/i386/whpx/whpx-accel-ops.c | 3 +++
> 9 files changed, 21 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Mads Ynddal <mads@ynddal.dk>


