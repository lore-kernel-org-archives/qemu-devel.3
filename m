Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219A1FCC9AA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 05:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0CQ7-0006k9-O1; Wed, 11 Mar 2026 01:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0CPu-0006dz-7b
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 01:47:34 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w0CPr-0002nF-Cq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 01:47:33 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62B5l9ep060710
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 11 Mar 2026 14:47:21 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=pX0yrlcGvdu/J9E0doM+7QK1inEOaQr8SGc/kppNN4A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1773208041; v=1;
 b=qZPZ2dqnUJ/20xvm5PP6WG3izLEP4pKGeNC0aT5/jET8UNcdlxCwXcLQO2e/sF0b
 EJ17Em3mvsF2Eil8GKy54l55WB2W4jlO22dg3mJiH+titD/lNpXiZ0j4T9lo8aHx
 BN/u175WgibLr0UUdEDu6JUhaO219FWtXhUT8ZtNhbLwkl/IbNOUH6CESvleEKmf
 BkfXm85L6k4+ivTGgbKiwpwcNiYSPElvWVSaDAU6VRyGxWN3iYXEZ0ti/UfnYGdQ
 p/cRC52B/Fz4LzK5tCXOGNOgRLLXmNTDbGXXLJRo1MLdQnir5R4Zxjzy5NujSe8O
 WFEgAaUXdojWNeYXvwYuwg==
Message-ID: <fd32c74f-5898-46df-a039-1729f0795101@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 11 Mar 2026 14:47:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio-gpu: fix overflow check when allocating 2d
 image
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zero Day Initiative <zdi-disclosures@trendmicro.com>
References: <20260311-cve-v1-0-f72b4c7c1ab2@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260311-cve-v1-0-f72b4c7c1ab2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/11 6:26, Marc-André Lureau wrote:
> The calc_image_hostmem() comment says pixman_image_create_bits() checks for
> overflow. However, this relied on the facts that "bits" was NULL and it
> performed it when it was introduced. Since commit 9462ff4695aa, the "bits"
> argument can be provided and the check is no longer applied. This can lead to
> OOB access.
> 
> Thanks Trend Micro's Zero Day Initiative for identifying the vulnerability.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

For the whole series,

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

