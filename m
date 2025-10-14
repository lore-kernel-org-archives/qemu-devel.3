Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF45BCCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8anf-0005BM-1e; Tue, 14 Oct 2025 04:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8and-0005B6-Mt
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8anW-00075c-Hl
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760432059;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5YYtF64o783HrCakitmLOINx9UIJjd8QRhMV+3BNuOk=;
 b=KQqCadQyTuOCYNw5536YpC9FTT5jNpeRqzugFg1sEJXVx4x7fJtJb9ie7xU4wUBcmdq+O+
 FPyQLI3nvcGT8HEMP/jZAtYrXe6difxa1BtgVHQo3ETISjje9i2NXcCTPvT2Vlo6/2WMGx
 /vT2t+20FXLB9o8220gPfAE5dyaAXow=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-W1DGhiWPPq2ZFDySf75XUw-1; Tue,
 14 Oct 2025 04:54:15 -0400
X-MC-Unique: W1DGhiWPPq2ZFDySf75XUw-1
X-Mimecast-MFC-AGG-ID: W1DGhiWPPq2ZFDySf75XUw_1760432055
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA5B81954115; Tue, 14 Oct 2025 08:54:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.198])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 134241800446; Tue, 14 Oct 2025 08:54:12 +0000 (UTC)
Date: Tue, 14 Oct 2025 09:54:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Praveen K Paladugu <prapal@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/2] monitor: generalize query-mshv/"info mshv" to
 query-accelerators/"info accelerators"
Message-ID: <aO4PsET0Hh3ljXmi@redhat.com>
References: <20251013112650.935921-1-pbonzini@redhat.com>
 <20251013112650.935921-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013112650.935921-3-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 13, 2025 at 01:26:50PM +0200, Paolo Bonzini wrote:
> The recently-introduced query-mshv command is a duplicate of query-kvm,
> and neither provides a full view of which accelerators are supported
> by a particular binary of QEMU and which is in use.
> 
> KVM was the first accelerator added to QEMU, predating QOM and TYPE_ACCEL,
> so it got a pass.  But now, instead of adding a badly designed copy, solve
> the problem completely for all accelerators with a command that provides
> the whole picture:
> 
>     >> {"execute": "query-accelerators"}
>     << {"return": {"enabled": "tcg", "present": ["kvm", "mshv", "qtest", "tcg", "xen"]}}
> 
> Cc: Praveen K Paladugu <prapal@microsoft.com>
> Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
>  fixup a0df118f73f # fff
> ---
>  qapi/accelerator.json      | 47 +++++++++++++++++++++++++++++---------
>  include/monitor/hmp.h      |  2 +-
>  hw/core/machine-hmp-cmds.c | 21 +++++++++--------
>  hw/core/machine-qmp-cmds.c | 20 ++++++++++++----
>  hmp-commands-info.hx       | 15 ++++++++----
>  5 files changed, 74 insertions(+), 31 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


