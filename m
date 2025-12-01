Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EAAD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 12:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ2qi-0001oK-Nv; Mon, 01 Dec 2025 07:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vQ2qg-0001m1-9u; Mon, 01 Dec 2025 07:17:46 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vQ2qe-0006kH-Of; Mon, 01 Dec 2025 07:17:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 89CF46016B;
 Mon,  1 Dec 2025 12:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58DEC4CEF1;
 Mon,  1 Dec 2025 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764591455;
 bh=vu+ZO7sPX8LN8r+o9MwatX/RxqPGkOG3RurZZNPIidQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pj+a/e17MfODqNM0bebcjdFxVZf/dpBuWOkcbTiq0xKEgmHM4qHLYVpGIkJGkKu87
 ZuXCYjsiCoJWiWnF7/cG2rBf8WbTAUgZGomJfDvq5tpLNwgyHnM4JHdwiYo6QIfNdK
 H23Ketr1Y5bhYCgivkjTJMEf2s7GKKdlCE7ePCzWW47aycrOtGyADZOttM+48c+FVO
 a4iDzSyC9N6QbHb9kRYjBQxjKqMKp0zTmmHe3G9hB+hdRXSlZm97O1SGhWMnPVUCCL
 rt1HCElNTRa7XRNBWh058vNEFg9DvVpLG9KzQgcIekxExFZuZjNDx3NQ95VtOP9wpQ
 J2iEWRLT3HBOQ==
Date: Mon, 1 Dec 2025 13:17:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 armbru@redhat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/5] acpi/ghes: Error object handling improvement
Message-ID: <20251201131729.615abe68@foz.lan>
In-Reply-To: <20251127004435.2098335-1-gshan@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 27 Nov 2025 10:44:30 +1000
Gavin Shan <gshan@redhat.com> wrote:

> This series is curved from that for memory error handling improvement
> [1] based on the received comments, to improve the error object handling
> in various aspects.
> 
> [1] https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00534.html
> 
> Gavin Shan (5):
>   acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
>   acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
>   target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
>   acpi/ghes: Bail early on error from get_ghes_source_offsets()
>   acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()

Patch series look ok on my eyes.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

-

Btw, what setup are you using to test memory errors? It would be
nice to have it documented somewhere, maybe at
docs/specs/acpi_hest_ghes.rst.

Thanks,
Mauro

