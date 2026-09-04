Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC90C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Lgb-0003kr-KF; Fri, 04 Sep 2026 00:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2LgZ-0003kC-S3
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:37:55 -0400
Received: from pv-2001b-snip6-11.eps.apple.com ([2a01:b747:3003:200::15]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2LgY-0003io-2C
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:37:55 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 7AF1D18000F0; Fri, 04 Sep 2026 04:37:47 +0000 (UTC)
X-ICL-RepId: 01a06ab5-625d-7487-bc74-b7f955e5e5ef
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdDlsGQA1LBFkFRQtGD0kAQAZGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788496670; x=1791088670;
 bh=39BpP6uTQ4wGRzJBPL7IK8+8Y98o/LILsXct3jFUiSo=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=AxMZ5snZzStC+sp5dyB4rhZOQatbVGYl8Zl+5D8FxPIHb6OiOjWIWKV8dPlYijAHjZsQyK5PnENNEmuw/YHtNGFAgUIvYLVTJYn5FrtIFJml769WqlhlYMHJisTNQIctoEBfM+GnZxKSh/rxgkw+bBtW4GM4k9HNLbtKv1oYDa3lJBLeyMnbf0HIH5KJf0G1YXNFSBqzkcqEFD66baO2fweM1UplbV9iHoyj5L/qJBGnMRsrXYhlmWELroFlPNiWH7xKobfFHvokPgCDINJVES5OycN9LZcN7Bax3pfUbTcxZHOKrpi8twvRSghKOSDFEeETAo7Q4sKVc4DqYcD30A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 031C518000C6; Fri, 04 Sep 2026 04:37:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 0/5] hvf: arm: add experimental VHE (x-vhe) toggle
Date: Fri,  4 Sep 2026 06:37:37 +0200
Message-ID: <20260904043742.96613-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=O/o0fR9W c=1 sm=1 tr=0 ts=6a9a4b1c
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1IkwwtD3tCKCoM6Zr9cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2h4OybaayhXuR-rAqC1kuck0nruRkh2q
X-Proofpoint-ORIG-GUID: 2h4OybaayhXuR-rAqC1kuck0nruRkh2q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfXz9Svseaor7s7
 UZRvxUlTVzlKUNMG0+r+jN9lMMfFv3UZIm9Nry6jxNcunqCqLhBwduz0FxCw7+aJzCV1zTBJs7W
 5S6Nv8QkvBpoOy1ZJzJPaYmZfQxxhx7y78+rzCnbPRUc5KNzQyCWv/giEaNzlBEf0D9RXDfyBFo
 G8oxjZ5kR6J2Pezkuor3Zv4wmpmgI86bxnfV9kny2rSjKajGY5OeCom1hTLUha/TCzCHldux85r
 WlYYfzkvr2U0cQ2nJqE97vU3D+Izl+Zy3ML9FCevdkpP4ElJNHL4PMMjOvJWsd7L0KjH4Jwkkp7
 9/cT9/uqgTojdKBd/TjSwd0u0sPW1NGyttpnnow3MJ2frYKuEWEl4cjYovwzmk=
X-JNJ: AAAAAAAB5IdNTBxKq1GO7WLH12bmmMSTLnwjcBmihVMKUv562APFrjKEeYoUh7/7b9THk59nt8ZO604MmhxYuuBTAbIoa2Bfau43U3lheDsKW4441ShTnEgvzryYjO8ngEhiXSdqKskraeq8VGVOxpifiYDvkkxbtBTMBsebOFMXaqfff8Uhl2WOcWWuiBnbsKX6fZA4WCkLEprA8kYTkeV5MNWKg0N9Yirrqu7mwOEFg+cbLV5lcSA7IbV/WNvol3ppzvuz/E6UaGJ0RDOaPJWeo9WTcQTxgaagR8p+gHwasB8em7hEIgfHhujIcfuwoAo8b0uBTwiuwHyO9OnImcP43x69lEhG5WC8eOo+3YYto+bWez9vUCBQhGTaXjpAu369gEtN7L8LdGXcfOCO1Pob+D+aCg0CRimVOmzAzh1+y5WSF+B7S30obUCqsNLz5bl6PFhBkWva0kJTwjFSLEiT7TVTaVwyrf8BBa3ME0doE63qt7q77T+modwxsjmwCv5UecLy104co8QQ/MXIrg67J4or+ZcTaPF4nxaxN8VYS16sQHdH6FwrNXpYwxDUacJ33+8tZeIAHegw6pS7Y2v/oPf/MzWijrVCMlmkWQl7PXdMFz/hg3Uaoj+MrvsvZhkc+vw632F5QW/gi1kweo4hlWY9K9yC+9sL2rCGI80N0J52gVVgFlthd+6nb9TZLHMfNPgkvg6sYWhhe3AOWM/IJ79h24Molj7XK16oQvXpebjeJREv/AH4oZ7/q+MkapKTHj6PTCdQYCqGtsQP6La04xbW5uhvS5R4TetDuyEShSMPB9mumRaJuiruLtdeKreZfA11n6De+cjTXuqakVa/D5DrzbIax3s9Lh2R45U1nrtHJBR2qTL1GPoggA58HQKM6kaCXZDvBnAyHBsm0ecgdW8SxMDRAKmyDCS4PghfnVkZZhFiB6iXBRosiwHfzbsZwzmTQeTp7KLkgmvsCFhMiGdiRAs
 YlEi1pEeebvQwnIRHccso8t1LeIxqdm8yHo6wPp0iWzPZusUWz+o6T7wum+j0R722N5ivqhVRMD4bhjURZfuRl/+FGNS0KJ3CJNjhQnPuLojPyBnGjSel0g9OLxqmmHA2c9O1cZDHow14r+gkmriPesv7zUxzyIjhDKYR/KNvQoa1DqEvDWRjgUSvjui0AmsLmHeBvqH1LVpH7FoYbzhDmoWYq2uZdv5Da88o2hWo4VlLqlloW3H++Efu8YSaJ40JlBdf+rc2X9KWvTURFQ==
Received-SPF: pass client-ip=2a01:b747:3003:200::15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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

macOS 27.0 has a pre-release VHE implementation. Add support for it in QEMU.

The first patch in the series is an independent bugfix that should be backported to QEMU 11.1 too.

v2:

Add:
hvf: arm: expose E2H0
hvf: arm: ignore accesses to CNTKCTL_EL12

This is to have working KVM under the VHE configuration.

Mohamed Mediouni (5):
  hvf: arm: advertise ID_AA64PFR0_EL1.GIC
  hvf: arm: add experimental VHE toggle
  hvf: arm: advertise EL3 support when VHE is on
  hvf: arm: expose E2H0
  hvf: arm: ignore accesses to CNTKCTL_EL12

 accel/hvf/hvf-all.c      |   2 +
 include/system/hvf_int.h |   1 +
 target/arm/hvf/hvf.c     | 114 +++++++++++++++++++++++++++++++++++++++
 target/i386/hvf/hvf.c    |   4 ++
 4 files changed, 121 insertions(+)

-- 
2.54.0 (Apple Git-156)


