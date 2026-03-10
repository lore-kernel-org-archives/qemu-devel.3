Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D26FCC9DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzt11-0007HJ-Pc; Tue, 10 Mar 2026 05:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzt0u-0007Gr-KL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzt0p-0008OB-3q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773133461;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ny9luQVSX+i34yZm4gF9ds4AYSGfNIsLIYl8Upc740I=;
 b=Z0+TjPeWulYlb+VDJWZ7fIc+uLqww5+c/S44OdAbAPY5Z0ZmA8Ode3d8zLmPRfk7n5gnGW
 SNb+zM66qTptDxScG73EnCfuFlvgQJuL6Hdkyuwby/bvC8NccYFFwewCu6aXLGfMEq9gDB
 zIeKf+POhUFA+ifcUMtTFZi+Bs95SDs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-LeeKbdcMPMa3N0qCFvvPwA-1; Tue,
 10 Mar 2026 05:04:19 -0400
X-MC-Unique: LeeKbdcMPMa3N0qCFvvPwA-1
X-Mimecast-MFC-AGG-ID: LeeKbdcMPMa3N0qCFvvPwA_1773133458
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B23418005BD; Tue, 10 Mar 2026 09:04:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.213])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAF611956095; Tue, 10 Mar 2026 09:04:15 +0000 (UTC)
Date: Tue, 10 Mar 2026 09:04:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mcascell@redhat.com, security@1seal.org
Subject: Re: [PATCH] hyperv/syndbg: check length returned by
 cpu_physical_memory_map() [Fixes: CVE-2026-3842]
Message-ID: <aa_ejKVroDIHj4ta@redhat.com>
References: <20260309190155.80619-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309190155.80619-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 09, 2026 at 08:01:44PM +0100, Paolo Bonzini wrote:
> If cpu_physical_memory_map() returns a length shorter than the one
> that was passed into the function, writing the full out_len bytes
> causes an access beyond the memory allocated to the guest; or in
> the case of the MMIO bounce buffer, an out-of-bounds access in a
> heap-allocated object.
> 
> Add a check similar to the one already in handle_send_msg(),
> and take the occasion to remove repeated computations of
> recv_byte_count + UDP_PKT_HEADER_SIZE and clarify that the
> code does not write past out_len bytes.
> 

Can you add

  Fixes: CVE-2026-3842

> Reported-by: Oleh Konko <https://github.com/1seal>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/hyperv/syndbg.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


