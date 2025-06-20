Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBACDC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 08:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSWoN-0007xI-PR; Fri, 20 Jun 2025 04:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uSWoL-0007wc-UC
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uSWoJ-0005OD-HA
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750406956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=s3ij38oHEfT8AZgZmvZJvuiKv2xiNrYskF4NEFBZ65g=;
 b=ek+z4HClPLAOeu/oTfjF3bNI/HhLOs2ul/qmzqRhcCBNAv+4ajKmvMcu72XxWwr6I/nlsI
 pp+NpIOQv765R3beCJQBbC+WTxPNhlTpf+qGWt6moAntSPPueTzmLpgWVNLTiCLXDUQGht
 WA9g+tWuaxoZwiMeK4tc3zW824xFpCw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-ug1iSQ3aMd6smAsGr58ZFQ-1; Fri,
 20 Jun 2025 04:09:14 -0400
X-MC-Unique: ug1iSQ3aMd6smAsGr58ZFQ-1
X-Mimecast-MFC-AGG-ID: ug1iSQ3aMd6smAsGr58ZFQ_1750406953
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A82EA18089B4; Fri, 20 Jun 2025 08:09:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25D3219560B2; Fri, 20 Jun 2025 08:09:10 +0000 (UTC)
Date: Fri, 20 Jun 2025 09:09:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [PATCH 3/3] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
Message-ID: <aFUXI5noscw_DfP5@redhat.com>
References: <20250619203351.393786-1-pbonzini@redhat.com>
 <20250619203351.393786-4-pbonzini@redhat.com>
 <c60001b3-12d2-4261-8b6b-a7bfaf4e71ff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c60001b3-12d2-4261-8b6b-a7bfaf4e71ff@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 20, 2025 at 02:47:46PM +0800, Xiaoyao Li wrote:
> On 6/20/2025 4:33 AM, Paolo Bonzini wrote:

> > +static gboolean tdx_get_quote_read(QIOChannel *ioc, GIOCondition condition,
> > +                                   gpointer opaque)
> > +{
> ...> +    if (task->receive_buf_received >= (sizeof(qgs_msg_header_t) +
> HEADER_SIZE)) {
> > +        qgs_msg_header_t *hdr = (qgs_msg_header_t *)(task->receive_buf + HEADER_SIZE);
> > +        if (hdr->major_version != QGS_MSG_LIB_MAJOR_VER ||
> > +            hdr->minor_version != QGS_MSG_LIB_MINOR_VER) {
> 
> This check makes it fail with old QGS, which defines
> 
> QGS_MSG_LIB_MINOR_VER as 0,
> 
> so what QEMU gets is 1.0 instead of 1.1.
> 
> It is really a QGS bug that when it changes QGS_MSG_LIB_MINOR_VER from 0 to
> 1, it didn't consider the compatible issue.
> 
> However, the old QGS is there. Should we relax the check here for it? or
> just let it fail with old QGS?

AFAICT, MINOR_VER==1 was introduced in DCAP 1.21 from Apr 2024

Given that this is new functionality in QEMU, I don't think we
have to worry about versions of DCAP so far behind the latest
version.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


