Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E5606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=UwVIIXnu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLja1-0002F3-6V; Tue, 27 Oct 2026 11:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYx-0000zo-Ij
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:13 -0400
Received: from ci-2002g-snip6-11.eps.apple.com ([2a01:b747:3005:206::49]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYp-0005lW-3k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:06 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 7500918010BD; Tue, 27 Oct 2026 15:57:51 +0000 (UTC)
X-ICL-RepId: 01a17e15-0d95-7f92-a64b-d5505c6923e8
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQABGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116673; x=1824652673;
 bh=dSrwibXLl61KPeY0mbb9Kw6Bj1BM0S+HBdlSgsEMB5s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UwVIIXnuXhpjj78JtsA+RiX5ZiuUA5ZTWtVx3Jt2CVupd1I0kU5sLxqGcHwDCS8K1uV4NKxRJuBtPcbud1bWbrdqMWJtfBu4rjpByymvD0+EvJy3/Zhr0zg3U0blg3lsHeWCIGzPaIHJ01K+OTtaqgBfwNqTCSrG232o0NVEdSZlC49PACOlhEGYUCma2jmpBlfORgGFUI7F4ktNv6IN6spspIdeoRInOIZBFFtmJXKc8Z8A5b7cwbuasllbg04hkN5o8pd1XeDGJJ4omwv733Shi9dG8GmpqEti3Aw0tS22WO24Jvg9XTU0zXBqznqGyVXcFwRRVpco/gVPTZ2i0w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 9FBDA1800483; Tue, 27 Oct 2026 15:57:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 06/18] whpx: i386: make nested virtualisation init failure
 non-fatal
Date: Tue, 27 Oct 2026 16:57:25 +0100
Message-ID: <20261027155737.59271-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: A58dnvlgiOvqSbcQv6FaqxmbGuihykE_
X-Authority-Info-Out: v=2.4 cv=CLYnnBrD c=1 sm=1 tr=0 ts=6ae0ca00
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p5XUOwc6s_shZ6Vv324A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX4dQjRXGgJ0K3
 5F8H02tHW+pnQb5rxDp+ZwlLe09apmMzqS86W+uVwkpO0LH3MakX1ww34GnvLapA+F/kdOAbmUz
 ExbrT/QXXtkPMmWScsKtS1gz2mFgUvanWC+7AEzdNNY4kGkthCVYNYI/aiRLF4aUeX1jj6tV+7d
 arGOXh46UcRbABgT5iHqg1ydw+ex0O6ZAaYO8DhSmKrhZutgHicNIY57YxQpmAKh0tRPHxS1EG0
 Kx98WxGoxAd5SsdOsIv2LfDU9FTzJqFLBXPcpTCkUQ+9og6E7GYPLTv2cFJPquGdiqY3eiUdruc
 G73Np0HUr7kzajqXze++hpBR6uGv/g2Bd/ZD79PaOjqge4j5ERdl8/5roozpgs=
X-Proofpoint-ORIG-GUID: A58dnvlgiOvqSbcQv6FaqxmbGuihykE_
X-JNJ: AAAAAAABwOz6lmZeHFYxtIKt6cgMO+56d0raBpnXkbFLh1YE/zrNvf8fCN5MpvhLAvYGGmaIL0RTL8dpuCCEibFc61RUM04H6aRvUr8gaCF59a8T+WOKe5ra8DIGYLTSj9eUHMkvZkV/pOKVuSP//EfMsZcDFJ6oHisPLTDy/j2DLggvGIk3tIuC73JiY8zXnImD1MzEsBVzLAO6utqdlh4j1CvPJKpK6Lq2+CQRQgNeopnPrE2LJ55F1d3MbBv2sTRUaed9vJFhpEaCAob8qfwT04rVzTZhHRLVpxyB2yOdpx379lA77RQcG4l5gfJQpfqXwzCty4P94x8XRzRS2C9oIT5sNo2toX92U4VUP8jh81XN0syLmD9gx1lyYYSeY4RSshqJjeh3tzeASrlqZRvl7kgI40P6ftKs/Jt39M9obi1YPIgGD9YzMmfVwgRDp5cmbqJ9Y6gajXYEZpvGChzfN6x4JHFfQowFzuso9HBiRC+nJvTvUChTA4BuIWMZsjYUIU4hTSDQhzDm7awBuW48HY9nq3QdhenDKa8L9mE94iGb9F1TxfJuHXn6SvfjaOClRNo060BQAJuTZtf/t1BrcGGsh1WI8j42FaQEfm3B4Lq1C9sn0j3F+ynT61hppHq5WjOuWtjq3krd1H30Dz2sFxaCrRzhmTVRwhvFFWAm7VoHoPdCHkoefTWcYI1jmmkD4ITZSHBjX//b4wpfuxNgvR/7FnSTMGDh4Nw0y66UTXE3H9wEdi0xNbRKZv2dF6o8YVvhDcVLvBqiBeUJye0NcfLnOBTgsHv30utiiFCB9D1uNTyj9so=
Received-SPF: pass client-ip=2a01:b747:3005:206::49;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On some CPUs too old for Windows 11 (Skylake) support but running
it anyway, WHP advertises nested virt despite it
being unavailable.

As such, make failures to initialise nested virt even when advertised
non-fatal.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 408a1667e0..d13513985c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3302,9 +3302,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             &prop,
             sizeof(WHV_PARTITION_PROPERTY));
             if (FAILED(hr)) {
-                error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
-                ret = -EINVAL;
-                goto error;
+                warn_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
         }
     }
 
-- 
2.54.0 (Apple Git-157)


