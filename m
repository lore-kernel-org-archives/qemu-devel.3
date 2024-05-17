Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C6BC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 00:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7lDM-0004nR-82; Thu, 16 May 2024 20:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s7lDK-0004nE-5L
 for qemu-devel@nongnu.org; Thu, 16 May 2024 20:12:46 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s7lDE-0007aG-MG
 for qemu-devel@nongnu.org; Thu, 16 May 2024 20:12:45 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D4E16CE1993;
 Fri, 17 May 2024 00:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BF8C113CC;
 Fri, 17 May 2024 00:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715904747;
 bh=p6pl74FbIfmFlxT8dPPcHg1hmaZ68bkLMFjCfCRTNWA=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=R1x2qYiFCITWjUuNvFhGiZmVwK179ukISANCJksJ6wbQ+/G/u/KmockHBJPVy+Fom
 pBX5yFWxieQVdcz1/x/v0xK1dFzWi9wTkamJLB98Prrj9StO0zHS6f9xfwsjpWlViM
 tChCGBaGdHJMAWtqM4/KiS3Xbum4DDD3eSiiyTga+aP6xzV3qF5hKlKOXgfpUMBZ2C
 IsTS7ybYME94DPodma/kjj77/V57oRN3pBI1vrhawx8YM0neWgFU9fqye6K1jtX4SW
 SRJB+GVl5QWDJCtw/Qo1fiDXA7pt2m+wh7OvdzoociA27ytwOMSzWD3awwC000q7eL
 ySjpM1R8Gag7g==
Date: Thu, 16 May 2024 17:12:23 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 6/8] xen: mapcache: Pass the ram_addr offset to
 xen_map_cache()
In-Reply-To: <20240516154804.1114245-7-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405161712150.2544314@ubuntu-linux-20-04-desktop>
References: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
 <20240516154804.1114245-7-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 16 May 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Pass the ram_addr offset to xen_map_cache.
> This is in preparation for adding grant mappings that need
> to compute the address within the RAMBlock.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


