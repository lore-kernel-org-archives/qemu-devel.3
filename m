Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244AEC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u267F-0007IE-SR; Tue, 08 Apr 2025 06:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1u267D-0007HE-M7; Tue, 08 Apr 2025 06:23:35 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1u267B-00060F-QZ; Tue, 08 Apr 2025 06:23:35 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 22C2A4A10D;
 Tue,  8 Apr 2025 10:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788B4C4CEE5;
 Tue,  8 Apr 2025 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744107804;
 bh=ai7ELqLYD54djyuUvLKKPGCn43/6epX/tT6jlJBGM+w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U8Taqj2FetJdjcF2p/00Qs2SB/EM1R+C3IYKJfIRq77rA3dY3ojSFCBXkRvezPbo5
 GcGHZBJSXXl4tOi1d4wrem9NTpwsOoaX2T2Ao1z0riuy80V9dVP8MP19fRCCPB/6OW
 7Pg5Xi8O75lFFOgADPUm/o79tT8BzswPgIQIqhSKm4yqiwcFtxY6emIgHDjcnE/kkn
 WZaH8T/MfhNjxLqZ0N3QBK2WgnxEQzO1HBLeDym50B6ujWP7eGrw9uUlZa5mIoK3z+
 V4AgjiqXhAb54ygkIbLWTxCrGjBMQppY3WbsYoqz7c+RTTZATOMWF84h0Zuy917ZWr
 0qUyul2Qm54xw==
Date: Tue, 8 Apr 2025 11:23:20 +0100
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH] hw/nvme: fix attachment of private namespaces
Message-ID: <Z_T5GLESR42edzTV@kbusch-mbp>
References: <20250408-fix-private-ns-v1-1-28e169b6b60b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-fix-private-ns-v1-1-28e169b6b60b@samsung.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=kbusch@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
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

On Tue, Apr 08, 2025 at 12:20:46PM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Fix regression when attaching private namespaces that gets attached to
> the wrong controller.
> 
> Keep track of the original controller "owner" of private namespaces, and
> only attach if this matches on controller enablement.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

