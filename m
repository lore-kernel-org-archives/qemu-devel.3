Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3E6072677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=CLFJoeGa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQiO4-0006wa-Lh; Tue, 10 Nov 2026 04:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xQiO2-0006vO-Lw; Tue, 10 Nov 2026 04:43:31 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xQiO0-0003FA-HH; Tue, 10 Nov 2026 04:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794303803; bh=PsigdxoagA2gd/IarfS8ZqLG26MD1xjQVzsxT0dtCwo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CLFJoeGa+4F6AVyK0fZ3ZGEDgn96Hy7y4Q37CRsK4YetCIbOHVZSJLJtDxp0OSgOY
 5d8rEr08eJeoKg2Wn6mKSbU7aV3W7Xw4O9SA18xB23gPL+N2sU7+/cRALNnVP3Yq8g
 wlSWRYIa1P+64dMrws4BOtiveKF6Prxq+r5E8fhvlDIOEfmKIcnym/6Z+U8adgk+dg
 eI+MqRUpFU2uWdwtz2WoDq6P5RW9fkta3wzSx8VhWQyLciI3H97FQ8KFB9FrcFJ+Z2
 0WE1L61LumoKDBccvcTIxcvK65bi0oCXO+Sk9wlawAE50D9qjza+JBVaGUYbxmzVRN
 eC9NuoPAIf4AQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6B4B31E50F6;
 Tue, 10 Nov 2026 12:43:23 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 51BF4457E0C;
 Tue, 10 Nov 2026 12:43:23 +0300 (MSK)
Message-ID: <25ca13a6-0305-40a3-b0d9-4f468aaa682c@tls.msk.ru>
Date: Tue, 10 Nov 2026 12:43:23 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable-10.0] hw/cxl: free the CCI background timer on
 Type-3 reset and exit
To: Junjie Cao <junjie.cao@linux.dev>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, jic23@kernel.org, anisa.su@samsung.com,
 mst@redhat.com, philmd@oss.qualcomm.com, linux-cxl@vger.kernel.org
References: <20261030124417.1066423-1-junjie.cao@linux.dev>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261030124417.1066423-1-junjie.cao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 15:44, Junjie Cao wrote:
> ct3d_reset() re-runs cxl_init_cci() on all three CCIs, and each run
> allocates a fresh background timer without freeing the old one, so
> every reset leaks three QEMUTimers.  ct3_exit() doesn't free them
> either.
> 
> Upstream fixed this in 259b877eac36 ("hw/cxl: fix timer leak in
> cxl_destroy_cci()") and a004df0be51f ("hw/cxl: destroy primary CCI
> before re-initialization on reset"), but both rely on
> cxl_destroy_cci() and the .initialized flag from 98cbac128f1c, which
> only went in for 10.1.  Add a minimal cxl_destroy_cci() here and call
> it before each re-init and from ct3_exit().  timer_free() takes NULL,
> so the first reset needs no guard.
> 
> ASan on v10.0.15, 5x system_reset on a paused guest with one
> cxl-type3: 720 bytes in 15 allocations from cxl_init_cci ->
> timer_new_ms before, none after.  cxl-test passes.
> 
> Fixes: 221d2cfbdb53 ("hw/cxl/mbox: Add support for background operations")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>

Thank you for all yout work and for helping with back-porting this to 10.0.
I haven't get back to you at the time, correcting now :)

/mjt

