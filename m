Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4B1C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKl4-0004y1-NI; Fri, 07 Aug 2026 09:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsKl0-0004xP-3I
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsKkx-0001sb-Em
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786109821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IKuQGdEJ4oDOOEwokmsJRW5tVtUXD/R10joS+DK8QYA=;
 b=SkFSDSEYAA68Tc46d/hdABg5IxZgbzCEMRglXfG2mIq9E+Awrsz/JWQm1OaMeymrxNZFRh
 u00iK1qQmjIC5gu0eMf7Q/18JzMKm0GwEW7rwJSyUoZ0kwob9ecgRCJ6ZsDJYQhLpG4YoS
 GvK7/d2W3MSpULZT3tbURLb/MN/LA+0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-MK-YqPbYMuSOjg0AJdE_Lw-1; Fri,
 07 Aug 2026 09:36:57 -0400
X-MC-Unique: MK-YqPbYMuSOjg0AJdE_Lw-1
X-Mimecast-MFC-AGG-ID: MK-YqPbYMuSOjg0AJdE_Lw_1786109817
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFA8819560A6; Fri,  7 Aug 2026 13:36:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 672E01800348; Fri,  7 Aug 2026 13:36:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9B2621E6920; Fri, 07 Aug 2026 15:36:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  'Daniel P .
 =?utf-8?Q?Berrang=C3=A9'?= <berrange@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH V11 02/15] iothread: introduce holder tracking
In-Reply-To: <20260806202531.243806-3-zhangckid@gmail.com> (Zhang Chen's
 message of "Fri, 7 Aug 2026 04:25:11 +0800")
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-3-zhangckid@gmail.com>
Date: Fri, 07 Aug 2026 15:36:53 +0200
Message-ID: <871pcaoxvu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhang Chen <zhangckid@gmail.com> writes:

> IOThreads do not record the QOM objects and block exports that use
> them, making runtime introspection and hotplug debugging difficult.
>
> Add:
>
> - holders: a list describing what is holding an iothread
> - iothread_ref(): add a holder to the list
> - iothread_unref(): remove a holder from the list
>
> A holder can identify either a QOM object or a block export. A later
> patch will expose this information through query-iothreads.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


