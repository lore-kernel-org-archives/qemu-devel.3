Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6699BC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXva-00010n-4W; Mon, 27 May 2024 06:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1sBXvY-00010T-VU
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:50:04 -0400
Received: from mr85p00im-zteg06011501.me.com ([17.58.23.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1sBXvW-0001EM-Ss
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1716806999; bh=X8ublvnPEy53sty51bGjdcCikwgrUPe9M8JfgcgqgNI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=JPE2PosnzqoVjygE+cMq02oJa6TdERv7OmjsPOp7OZJ8OjI7L2kHHkdAsOTF3T1fS
 xmK5/DxmNR9vixwKlyEKP/wCrpJfmTpy1FY7t9ThHhWMoZV8joHbYVRu2b6WRN3VrU
 YxwnRKIWHw0K0hu3fknTRkcBrVDtxk3Q/l7yuE8PIPLC1P6GUSMvYaKX1m+AOvmDT7
 b0l7DsLGdOjnnMEsSwSt4ZPnSsxp166c541DDmRgLlmigLsnrbwAT2er9rVlaCMme9
 xNuqz4Hx7GC+AnshHAfG1wxPYHIjOSLQNXdrq4LnN0o+u7LtqEv5t4tWHTGSMyS99d
 Gowv7kUG3o3JQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id 37DB94803E7;
 Mon, 27 May 2024 10:49:18 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20240527081421.2258624-1-zhao1.liu@intel.com>
Date: Mon, 27 May 2024 12:49:06 +0200
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <622493FA-7645-4425-9AE6-1C39A581149E@ynddal.dk>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-Proofpoint-ORIG-GUID: sqi1TjX33Doxq7FzPkPQFnsDtWgWp2Gy
X-Proofpoint-GUID: sqi1TjX33Doxq7FzPkPQFnsDtWgWp2Gy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1030 mlxlogscore=522
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2405270089
Received-SPF: pass client-ip=17.58.23.182; envelope-from=mads@ynddal.dk;
 helo=mr85p00im-zteg06011501.me.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Interesting work. I don't have any particular comments for the code, but =
I
wanted to address a few of the points here.

> 2. Rust delivers faster parsing.

For me, the point of simpletrace.py is not to be the fastest at parsing, =
but
rather to open the door for using Python libraries like numpy, =
matplotlib, etc.
for analysis.

There might be room for improvement in the Python version, especially in
minimizing memory usage, when parsing large traces.


> Security
> --------
>=20
> This is an example.
>=20
> Rust is very strict about type-checking, and it found timestamp =
reversal
> issue in simpletrace-rust [3] (sorry, haven't gotten around to digging
> deeper with more time)...in this RFC, I workingaround it by allowing
> negative values. And the python version, just silently covered this
> issue up.

I'm not particularly worried about the security of the Python version. =
We're not
doing anything obviously exploitable.

=E2=80=94
Mads Ynddal


