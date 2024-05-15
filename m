Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB493C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 23:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Npk-00021U-0V; Wed, 15 May 2024 19:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s7Npd-000216-Ve
 for qemu-devel@nongnu.org; Wed, 15 May 2024 19:14:46 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s7Npa-0007D0-Er
 for qemu-devel@nongnu.org; Wed, 15 May 2024 19:14:45 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A8F22CE17FD;
 Wed, 15 May 2024 23:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27A0C116B1;
 Wed, 15 May 2024 23:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715814877;
 bh=5nZURLaoNtXce9Y8qA5k4kGoOJSAV9Ep36Do2UBcKbk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=o+P9KyhIWTR7JvTiRtLy6cWFYqZBr6hZq9+C98cXoDmgBnyj3zZiaWjc7cmvPdhcy
 7qVcwv85o5J63IgCni/bLyevNJtCOC3OFiAkuZLpGVVF8wysShk0NqASA8Gf61bqhi
 uPxjsHZSZP4FqCxVEQNXWc1U/+Htv0/HEn5lOEtQfVA5ZcHbYw3n1tvb96Hg0Ql3IZ
 qxR01yxMHEFMXR5QMWUOv7hPbvhmX0MpMddqgC7YN9zrusTkumjlXnVH/Hb8Rk2/d/
 ZuVni1h8Rn252G8EULwVMP/WNgr6jffDaZ4scYw+OielC3ZKPD/lzYQEvYqmH3hNuz
 k1fzuEP8wmeTQ==
Date: Wed, 15 May 2024 16:14:35 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v5 7/8] xen: mapcache: Add support for grant mappings
In-Reply-To: <20240503014449.1046238-8-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405151614270.2544314@ubuntu-linux-20-04-desktop>
References: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
 <20240503014449.1046238-8-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 3 May 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Add a second mapcache for grant mappings. The mapcache for
> grants needs to work with XC_PAGE_SIZE granularity since
> we can't map larger ranges than what has been granted to us.
> 
> Like with foreign mappings (xen_memory), machines using grants
> are expected to initialize the xen_grants MR and map it
> into their address-map accordingly.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


