Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AEB606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W80vGmFx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5Cd-0005Gc-S8; Mon, 02 Nov 2026 22:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO5Bv-00058y-Ob; Mon, 02 Nov 2026 22:28:07 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO5Bu-00063r-7B; Mon, 02 Nov 2026 22:28:07 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3781760008;
 Tue,  3 Nov 2026 03:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B26E1F000C1;
 Tue,  3 Nov 2026 03:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793676484;
 bh=O1gMFqCHsBGTOTgbWaQxZudW4KmwHNY5Hpdj3l4uwY4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=W80vGmFxEnAU0RVTozqSKwoG7kK10CPgfk0y5t/NfCbJ70hY90QpwemIiRh4Bpbwc
 tAK0oNSXobhsF8RUSEdNEf27bBOGAwWtwbPmVxI0gTlpMT4SaL6DNBZvYAZc9V8RzD
 uUu0tjEt3WtL/s7ja2HvhfI7fgQ2RIjjKs255f/XKZhpTZFJSlhBD+T0mbIYQmQLxc
 t6z4fVvn0JNPik+/rFviNDjfit6olKJCTgks71e5W7jmKj50CxowKXDQxnbxgSlLSA
 Kbk9ngewEVwb5x0zlIrNdddfVDo6YWtIZQHsZ0X4MulLciKewVS0QbTeYqZdwYE3Z8
 JUKahBNW/fJ7Q==
Date: Tue, 3 Nov 2026 03:27:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 33/37] hw/arm/mpam: Record errors and reject invalid
 configuration writes
Message-ID: <20261103032758.777c5dc0@jic23-hlaptop>
In-Reply-To: <tencent_C971CBCA581AEB8403E2D1ED9854FE0CD406@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_C971CBCA581AEB8403E2D1ED9854FE0CD406@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 18:10:53 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add MPAMF_ESR error recording with the IHI 0099 Table 7-1
> encodings this model can raise, injected on the check-and-reject
> write paths: Undefined_RIS_PART_SEL / Undefined_RIS_MON_SEL on
> out-of-range selector RIS (the range check also subsumes nonzero
> RIS on an MSC without RIS support), intPARTID_Range on INTERNAL=0
> or out-of-range intPARTID, Monitor_Range on MON_SEL beyond every
> monitor type, and MSMONCFG_ID_RANGE on out-of-range filter PARTID.
> All are paths the kernel driver never hits; normal boot raises
> nothing (verified).  A recorded error overwrites PARTID_MON/PMG/RIS
> and sets OVRWR if a previous error was still latched.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


