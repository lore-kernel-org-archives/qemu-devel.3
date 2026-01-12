Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8B1D2505E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEQF-0004ZG-FH; Mon, 12 Jan 2026 04:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vfEQB-0004Xw-4c
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:41:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vfEQ8-0001eu-2G
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768210867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fVWNqVBXTPvbk1CqC9J9VGD6+9BKoq2AGZJ4Xi5ObAQ=;
 b=EKY/Ruuxb6eO0yB5rTANUb3h7cQwDEHaHW7G1Tj6XCZEVD5ORk+hK5jiz9itt88tH/TSpq
 ymikLrMIIwJ9halv6LwMLudT/LU3XTT0DQOcCgSHa0I9MWr0qEFcg1JjJWNNqTC1Qu3aKT
 mbT72+i7qraHJGv7Xdnzk6An4Y91peo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-F1haZB_xNk-OO7E8ipy1tw-1; Mon,
 12 Jan 2026 04:41:06 -0500
X-MC-Unique: F1haZB_xNk-OO7E8ipy1tw-1
X-Mimecast-MFC-AGG-ID: F1haZB_xNk-OO7E8ipy1tw_1768210864
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A810F1800378; Mon, 12 Jan 2026 09:41:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD84E180066A; Mon, 12 Jan 2026 09:41:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8623E1800081; Mon, 12 Jan 2026 10:41:01 +0100 (CET)
Date: Mon, 12 Jan 2026 10:41:01 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Oliver Steffen <osteffen@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Joerg Roedel <joerg.roedel@amd.com>,
 kvm@vger.kernel.org, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 3/6] igvm: Add missing NULL check
Message-ID: <aWTBdSDO9KKpXLt4@sirius.home.kraxel.org>
References: <20260109143413.293593-1-osteffen@redhat.com>
 <20260109143413.293593-4-osteffen@redhat.com>
 <CANo9s6muvcOrDH286o1zA06tRUvZBnOBqn03e0RiOEDC60W4sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANo9s6muvcOrDH286o1zA06tRUvZBnOBqn03e0RiOEDC60W4sg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 09, 2026 at 06:37:04PM +0100, Luigi Leonardi wrote:
> On Fri, Jan 09, 2026 at 03:34:10PM +0100, Oliver Steffen wrote:
> >Check for NULL pointer returned from igvm_get_buffer().
> >Documentation for that function calls for that unconditionally.
> >
> >Signed-off-by: Oliver Steffen <osteffen@redhat.com>
> >---
> > backends/igvm.c | 13 ++++++++++---
> > 1 file changed, 10 insertions(+), 3 deletions(-)
> >
> >diff --git a/backends/igvm.c b/backends/igvm.c
> >index a350c890cc..dc1fd026cb 100644
> >--- a/backends/igvm.c
> >+++ b/backends/igvm.c
> >@@ -170,9 +170,16 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
> >                 (int)header_handle);
> >             return -1;
> >         }
> >-        header_data = igvm_get_buffer(ctx->file, header_handle) +
> >-                      sizeof(IGVM_VHS_VARIABLE_HEADER);
> >-        result = handlers[handler].handler(ctx, header_data, errp);
> >+        header_data = igvm_get_buffer(ctx->file, header_handle);
> >+        if (header_data == NULL) {
> >+            error_setg(
> >+                errp,
> >+                "IGVM: Failed to get directive header data (code: %d)",
> >+                (int)header_handle);
> >+            result = -1;
> >+        } else {
> >+            result = handlers[handler].handler(ctx, header_data + sizeof(IGVM_VHS_VARIABLE_HEADER), errp);
> >+        }
> >         igvm_free_buffer(ctx->file, header_handle);
> >         return result;
> >     }
> >-- 2.52.0
> >
> 
> IMHO this should be sent a separate patch

Huh?  It /is/ a separate patch ...

> with the Fixes tag as you are
> fixing a bug.

That makes sense indeed.

take care,
  Gerd


