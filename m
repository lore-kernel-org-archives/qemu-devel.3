Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0107FFDEE2B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxWU-00089V-DM; Thu, 23 Apr 2026 13:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFxWR-00088k-AQ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:07:27 -0400
Received: from qs-2005i-snip4-8.eps.apple.com ([57.103.86.219]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFxWP-0007aQ-Gi
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:07:27 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 795543001520; Thu, 23 Apr 2026 17:07:21 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAk1fDl4fBBdGGVUERx5dVkIeGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQU6di4AUgZEeFVxWg8qH0R9PXBAdlkLSBQ+AytyKnFIf0kBXgMrRx5JClYJXghGEVsUVkNRGQxQTQFDCAoIRwNNF14yUwRfEVAW
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776964044; x=1779556044;
 bh=S08Un2xA+itCNP7vCYVQ0sfBYmjC8fvQ1G2P6f8f0r0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fTwyBzC7xEcuOxfbJh0yZLo6c6HzF1Z45LcY9nGGxkYOxVtDMWpRKjLOP3KlUL5QkG83eHIzczQU459CaX+Q4smA9HCmX976iL9dJ6YgiWWIqx3YAC95mJJx5/5gg0GVwwaajJAFCm2JifDezweCtqfsjKn6VD0ys1iHJklOE4+MuUMhDdx84rdZwbbZTNG3wkhlZZxORQTq1lryIh3VTFQi8GSFVhS6vvWKtKbRfxxD4a/n4gT0MPrO6fGc0/3gOmY3JhWdglWiyhNa3TE1OJ0F+42zDsepQoSr86To3FXLaUCjxN47tnoDpR3H+5Z+fRUWhGChIB3711/82Qn7oA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 43E4730013A3; Thu, 23 Apr 2026 17:05:40 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 08/16] accel/hvf: Enforce host alignment when calling
 hv_vm_protect()
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260423170229.64655-9-philmd@linaro.org>
Date: Thu, 23 Apr 2026 19:05:27 +0200
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BEC7944A-B78A-4DEC-A298-F0FEAC8F1234@unpredictable.fr>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-9-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-ORIG-GUID: DaUHq3QovYBVZaE-EkqrzOCPdyohTogM
X-Proofpoint-GUID: DaUHq3QovYBVZaE-EkqrzOCPdyohTogM
X-Authority-Info-Out: v=2.4 cv=OvNCCi/t c=1 sm=1 tr=0 ts=69ea51ca
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=9vKZ5dOS0OzRSC8b9IcA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE2OSBTYWx0ZWRfXzXYYZpv52cCZ
 kLRMMHfHwVDhWJ4ln0qi3js353IRcYyw8tyY+pqCrF7OfR1DcumO7c44KcgzFIvlyXgpTrXpg2X
 Bq2EPoHQL3b2vGgP1jiokEXBqbStlYh78DUX+Z63YlklxipM5UkD2LfwJEjWiH3gdZ8nprRB5LQ
 9Hv0AHLLJLcCJhpTmPm6lMIsa1XpCr2e1PxHPftP09bTkf+CvMByXXgh5eBKxxXeFAzHOJnCsf6
 gR1HDz3UbihuvZIuBuKu8oBgF2XTe22d9/1G3a34iG3s7pew4f2K3k6o6qcNmls7XegVFy/qkIh
 VNi2XqzytTjlIDq3wh4cWYLAOu8Kvy0d0Mx9iefyLakS0Rf6/rOCLxNALmwwsg=
Received-SPF: pass client-ip=57.103.86.219;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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



> On 23. Apr 2026, at 19:02, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> accel/hvf/hvf-all.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 5f357c6d198..82cb3717750 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -56,6 +56,8 @@ static void do_hv_vm_protect(hwaddr start, size_t =
size,
>     intptr_t page_mask =3D qemu_real_host_page_mask();
>     hv_return_t ret;
>=20
> +    start &=3D qemu_real_host_page_mask();
> +    size =3D REAL_HOST_PAGE_ALIGN(size);

Hi,

I think the patches to support 4K IPAs (which are already
out there) should go first and then an adaptation of this
with that in mind afterwards.

With HVF 4KB page size IPAs are supported so the check in
this form would have to be altered anyways when that gets
merged so...=

