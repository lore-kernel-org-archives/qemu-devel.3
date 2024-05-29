Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399C1C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 09:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCFh7-0001fH-Il; Wed, 29 May 2024 05:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1sCFh6-0001f8-IF
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:34:04 -0400
Received: from ms11p00im-qufo17281401.me.com ([17.58.38.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1sCFh4-00075f-U9
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1716975238; bh=8VpQmH/s3EBoRNXWkl7Ge1LnlAlwCXFNr+EozW32Ct4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=E8ggcUfx8VxJyfynJW7X56cUW1Q3xKktukvzlrGHHpKpbVgHvpxE8obgpbNI+wC9M
 F01K26Co2kOVJ9/Z3x0EXV/nBJNQUFktuYbh6bgyCUDpLIydzXL3AKrVfbmzczGzAP
 cqthOiGME3/sNUF9Ka/S10qJM4b0GEzunkLuT+NU7RZPjA5nNa8Abe+l3pPVqDFVTP
 tOFMK+qGwHEJtZVfDeHaI7mLA5h6uqUatgnM3zCqFRDzwUBPWfRbNkioaK+NqBVFDY
 Xeo2CNaHUjMuhU2X5q89a0a25+/Zqi1YqnNb1icA/b9ZE6/m3obylL80xNV6Itpakq
 XVxSjYQT2xOlw==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com
 [17.57.154.19])
 by ms11p00im-qufo17281401.me.com (Postfix) with ESMTPSA id 0277DBA016B;
 Wed, 29 May 2024 09:33:55 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20240528130518.GA993828@fedora.redhat.com>
Date: Wed, 29 May 2024 11:33:42 +0200
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=EF=BF=BD?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Alex_Benn=EF=BF=BDe?= <alex.bennee@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQIC4gQmVycmFuZ++/vSI=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9370410-E32D-4235-8CF0-87E620398246@ynddal.dk>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527195944.GA913874@fedora.redhat.com> <ZlV+Su4hziCFymVt@intel.com>
 <20240528130518.GA993828@fedora.redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-Proofpoint-GUID: 72bKJQtij2Ssu0mKSlY0nCK7nTlXbbg6
X-Proofpoint-ORIG-GUID: 72bKJQtij2Ssu0mKSlY0nCK7nTlXbbg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1030 phishscore=0 mlxscore=0 mlxlogscore=714
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2405290064
Received-SPF: pass client-ip=17.58.38.51; envelope-from=mads@ynddal.dk;
 helo=ms11p00im-qufo17281401.me.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


>> Maybe later, Rust-simpletrace and python-simpletrace can differ, e.g.
>> the former goes for performance and the latter for scalability.
>=20
> Rewriting an existing, maintained component without buy-in from the
> maintainers is risky. Mads is the maintainer of simpletrace.py and I =
am
> the overall tracing maintainer. While the performance improvement is
> nice, I'm a skeptical about the need for this and wonder whether =
thought
> was put into how simpletrace should evolve.
>=20
> There are disadvantages to maintaining multiple implementations:
> - File format changes need to be coordinated across implementations to
>  prevent compatibility issues. In other words, changing the
>  trace-events format becomes harder and discourages future work.
> - Multiple implementations makes life harder for users because they =
need
>  to decide between implementations and understand the trade-offs.
> - There is more maintenance overall.
>=20
> I think we should have a single simpletrace implementation to avoid
> these issues. The Python implementation is more convenient for
> user-written trace analysis scripts. The Rust implementation has =
better
> performance (although I'm not aware of efforts to improve the Python
> implementation's performance, so who knows).
>=20
> I'm ambivalent about why a reimplementation is necessary. What I would
> like to see first is the TCG binary tracing functionality. Find the
> limits of the Python simpletrace implementation and then it will be
> clear whether a Rust reimplementation makes sense.
>=20
> If Mads agrees, I am happy with a Rust reimplementation, but please
> demonstrate why a reimplementation is necessary first.
>=20
> Stefan

I didn't want to shoot down the idea, since it seemed like somebody had =
a plan
with GSoC. But I actually agree, that I'm not quite convinced.

I think I'd need to see some data that showed the Python version is =
inadequate.
I know Python is not the fastest, but is it so prohibitively slow, that =
we
cannot make the TCG analysis? I'm not saying it can't be true, but it'd =
be nice
to see it demonstrated before making decisions.

Because, as you point out, there's a lot of downsides to having two =
versions. So
the benefits have to clearly outweigh the additional work.

I have a lot of other questions, but let's maybe start with the core =
idea first.

=E2=80=94
Mads Ynddal


