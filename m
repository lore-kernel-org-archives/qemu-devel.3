Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A8E10A1E60
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5iAd-000695-KJ; Thu, 26 Mar 2026 06:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5iAX-00068T-Nb
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 06:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5iAW-0006ww-7E
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 06:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774521747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uRiVM/hQz0BvpG69+7beiImyjSsPHNvKncV4RQM/tmk=;
 b=Tb5YYGVwjnw7C1bAjM/3GcYIGrXD5f9l8VZWRjOY+sjNVHSrCUW9UzDUTkKeB9vei13Msn
 ycn7xEhLPRgYjIZZYTbRJq8z/4Jhn/tHTuuTh6OImLAQ8aZ1ONjk3Bba/J/TITgDCNGAz7
 VV67pTZcNy5E1rcw8iJOpQmukJFzBDg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-7NkrLcZKNYCwbta6h5sLGQ-1; Thu,
 26 Mar 2026 06:42:23 -0400
X-MC-Unique: 7NkrLcZKNYCwbta6h5sLGQ-1
X-Mimecast-MFC-AGG-ID: 7NkrLcZKNYCwbta6h5sLGQ_1774521742
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20E5619560B1; Thu, 26 Mar 2026 10:42:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB6221955D84; Thu, 26 Mar 2026 10:42:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 622E321E6937; Thu, 26 Mar 2026 11:42:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <anisa.su@samsung.com>,
 <berrange@redhat.com>,  <eblake@redhat.com>,
 <jonathan.cameron@huawei.com>,  <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>,  <lizhijian@fujitsu.com>,  <mst@redhat.com>,
 <pbonzini@redhat.com>,  <gourry@gourry.net>,  <nifan.cxl@gmail.com>,
 <me@linux.beauty>
Subject: Re: [PATCH 1/9] hw/mem: Add tag support to generic host memory
 backends
In-Reply-To: <20260325184259.366-2-alireza.sanaee@huawei.com> (Alireza
 Sanaee's message of "Wed, 25 Mar 2026 18:42:49 +0000")
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-2-alireza.sanaee@huawei.com>
Date: Thu, 26 Mar 2026 11:42:17 +0100
Message-ID: <87a4vuhnxy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Alireza Sanaee <alireza.sanaee@huawei.com> writes:

> Add a string tag property to HostMemoryBackend so that backends can be
> identified by a user-assigned name at runtime. Expose the property through
> QOM and add a host_memory_backend_find_by_tag() helper that walks the
> object tree to locate a backend by its tag.

Why can't you use the QOM ID?

$ qemu-system-x86_64 -S -display none -monitor stdio -object memory-backend-ram,id=fred,size=1M
QEMU 10.2.90 monitor - type 'help' for more information
(qemu) info qom-tree /objects/fred
/fred (memory-backend-ram)
  /fred[0] (memory-region)


