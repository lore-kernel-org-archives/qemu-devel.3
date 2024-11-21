Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C1ED6E2A7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3t6-0000oJ-Ge; Thu, 21 Nov 2024 04:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE3t4-0000o6-LK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:54:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE3t3-00058d-8W
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732182847;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjGs48AQNIpMcywFj4DJFht1pY130DJd4I9blZBk77A=;
 b=IfhWqxABEL1QRzLynrMLgBUHoAKd7UOHPUy9Bcus60PH+N3BTUDe7jBOnEVr5nrR0tAhj5
 MgQI+9nnH1nZ3x49oDYlg3QZl5nvOMhhGD6YAgHrpbCtL2fkaqm7SH8ToY5Yy5eRcOMWHr
 IZP2s9cchSxc8qwRd4uY4bQ0je0J6UA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-vo0Bz2QhMZG8RmTIfl_6RQ-1; Thu,
 21 Nov 2024 04:54:01 -0500
X-MC-Unique: vo0Bz2QhMZG8RmTIfl_6RQ-1
X-Mimecast-MFC-AGG-ID: vo0Bz2QhMZG8RmTIfl_6RQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80F9A1955F3D; Thu, 21 Nov 2024 09:54:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D6251956086; Thu, 21 Nov 2024 09:53:57 +0000 (UTC)
Date: Thu, 21 Nov 2024 09:53:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: New "rme-guest" QEMU object addition
Message-ID: <Zz8DMob1P-ip0qN8@redhat.com>
References: <9FF5EDFD-6026-4C3A-A6A1-A66521D837A5@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9FF5EDFD-6026-4C3A-A6A1-A66521D837A5@linux.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 21, 2024 at 02:34:24PM +0900, Itaru Kitayama wrote:
> Hi Jean, Mathieu,
> 
> I’ve been using you guys’ ccs/v3 QEMU for some time to bring
> up an Realm instance without a major issue, and as a one who
> is making changes libvirt to support CCA, I wonder if you
> could merge the v3 local changes under qap dir first so I
> can query the feature from libvirt?

Is the CCA host kernel support merged yet ?  As a general rule we would
not expect to merge QEMU support for a feature, until after the corresponding
kernel support is merged.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


