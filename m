Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBECCAC588
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 12:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvaY5-0006mz-50; Mon, 08 Sep 2025 08:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvaXt-0006kT-02
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:00:29 -0400
Received: from p-east1-cluster2-host8-snip4-1.eps.apple.com ([57.103.88.202]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvaXh-0008H9-ME
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:00:26 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-6 (Postfix) with ESMTPS id
 A5A73180748D; Mon,  8 Sep 2025 12:00:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=WXf79ypOKTYWRH9WLy7yabo3VVKu+0fwize6wQjDl+s=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=kgMAWvg9TSwTjmaxGGN6lZnQWjmf+IGVz6m/I4zIVvS6Xuc81n9p+xGA92HoyjBymiz0rE7nivnq3Wr+QrGa1KBP6hqkFrsOS2YJN/HxZ0cRqpqiJVhMyxOBt5u7IoBLFTASBfeD+i4Q6mx+o+zNLOhPSYi6otboyGptyGI9hPzwHRi0QGK5KPwjkgjnWcKP0qAY2AG1iFRvMa5nSytbodBnaO8zHexG1rXhIz/bwNKb1YVxmWDoDrfNUwDZKoR7df2ZU59ZrduEqhEsAsEJ2CerRgqC5iI7DpqcWKyZUFHKX6ikex7qng11XncK7MtRMuipq3TzewTXWPd9uTqShA==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-6 (Postfix) with ESMTPSA id
 AF5A318074A5; Mon,  8 Sep 2025 12:00:05 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 17/24] target/arm/hvf: Factor hvf_handle_vmexit() out
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-18-philmd@linaro.org>
Date: Mon, 8 Sep 2025 14:00:02 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E3FABC53-7612-4488-BB9E-E9882A057BA6@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-18-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: Di3e4x0KR6IBA-8CjmRG4G-od6yKA4Bo
X-Proofpoint-ORIG-GUID: Di3e4x0KR6IBA-8CjmRG4G-od6yKA4Bo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEyMCBTYWx0ZWRfXzC4/L3YMSDGK
 YLCEwlJG3cJgXS11VL1jDEgDgamQDx+ySccSLsN/QcxiR5mkug0cWiIBcWaA+oShlDjojob6k05
 yK3djMkNiUhb2M1ryVm4uo3gjSeJGRjRy/MXUA5NahPVdmbydhhYnHcRRG1sOHtlsVneiF4rAs7
 wqn26IyDkOZEcU9ry12KAwk8xChgRe6i5uIzGo6OUY87rPBUwBXveF91IbxD+xUTS9g7LPA55uo
 p13xaAjCuXMvMa2Kjl9un7W7AcYqJycM/rArl+xCl1VwbT3QEZEKX+BHaMeePUErMnX7wvyvA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=795 clxscore=1030 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080120
X-JNJ: AAAAAAABtYUcmkR8VCxXjVeZZ/gmcFpH7E264IUqY8SIYTKWdNJ8IkU0IEvKuSDKQLI9a6mwUFN/K1dHluQOZy9/wTaIh2GQVO5mKGB4TayCkRlVXEqhYNCUSFVZMnYBBAoZ6vvSEJdJDVpv2w8Dil5o5bDf/58fy5ze8gYlUzxWjGuums3oohQTIqtaHBLrPr7w7y+inlEVBH+5XR3X3u9lrD8Tvl8VIHqR1mdU52SXf92QUYY8LV8Uxu9IFyDOLqmTIvxrWVZbvw5UXS4ApqDu64wxLORDi9PGC9OtMy5wAadkshEJgjH/gDQsu6AnuMOzem/utw70zpxWvPpDJHHNSxSRvWw2itZKPBml6hwrq2zCWwkAuD0VxxMgw06wWJJN5+ZV+0LlJVWBb/dx/1wEKHhPj4XBagKMPBM4sucXFk10+rUS1vW8TWFWzWKm7sbRrL8QYYNr9gdkkl0yzwAJBKafNc1av/nhOGr3iyWFTwT8E2iQd23lPS1A5kZs9LaEVNhFwVSxQCnm6haiKN8KIfu73U+5qA1oClGJyjGNg0BCLHe0oJuaYuqs+9JmEyTwiW4nBA1tKzdjcfXH+fZTXMH6cGH17yy94ROYIPnBvS6cxRTvxP2ocSvTkU3hnPvUjmtMNX5l0PDyYNStJAFy6aOd2m0w4tz/MN29jG5cOizHN44dvbkVZ+NBjMGouLWtFhsaVq+vEtuMCHeY2Q==
Received-SPF: pass client-ip=57.103.88.202; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


> On 3 Sep 2025, at 12.06, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Factor hvf_handle_vmexit() out of hvf_vcpu_exec().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 51 ++++++++++++++++++++++++--------------------
> 1 file changed, 28 insertions(+), 23 deletions(-)

With Richard's change to not cast twice:
Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

