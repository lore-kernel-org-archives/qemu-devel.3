Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E28C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeiR-00080F-5D; Mon, 06 Jul 2026 04:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgeiL-0007ze-OA
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgeiJ-0000f9-Pp
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783326601;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BLB1rbgK+S3bV9jX87defvU9euAaV4nNBpX8KUXT0fs=;
 b=U26/l7qBhqN0Nm6BTvJB+PIDFGpkFqTtzfZ/7+RQUxsB7Ch/SdNO0N+QwjgMxJ6ptChZf+
 m2DesmOOg2+WKDwwiPgbEUXa/5Pvfwj/QEtVWQkCvBRQv7pXYHRRaKZAo5rkp6/ZQFZ/ju
 QWzI1nymsS0YBk6FFw/7tQsRojTSVcA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-jvA7KYRxMFOCitelhW8_jQ-1; Mon,
 06 Jul 2026 04:29:57 -0400
X-MC-Unique: jvA7KYRxMFOCitelhW8_jQ-1
X-Mimecast-MFC-AGG-ID: jvA7KYRxMFOCitelhW8_jQ_1783326597
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E78CF1955DC5; Mon,  6 Jul 2026 08:29:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.165])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D54471956047; Mon,  6 Jul 2026 08:29:55 +0000 (UTC)
Date: Mon, 6 Jul 2026 09:29:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anatol Belski <anbelski@linux.microsoft.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC] virtio-villain: Guest fault injection for VMM robustness
Message-ID: <aktl-ojkXVZ4Jira@redhat.com>
References: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Jul 04, 2026 at 03:37:21PM +0200, Anatol Belski wrote:
> Hi,
> 
> I would like to share virtio-villain, a guest side fault injection
> harness for virtio device models. The repository is at
> https://github.com/weltling/virtio-villain
> 
> Comments on the approach, the coverage so far, and test cases worth
> adding are all welcome. While the tool targets multiple hypervisors,
> QEMU support is active and has already surfaced a few initial bugs.

snip

> Impact. Many findings have led to substantial improvements in
> virtio spec compliance and stability in Cloud Hypervisor, from
> input validation gaps to a config read that could take down a VM
> on aarch64. In QEMU the harness has surfaced a few guest triggered
> hangs and a double completion. The repository README lists the
> details with PR links and the test ID for each.

The README only lists  cloud hypervisor bugs.  Did you file any for
QEMU yet ?


If this is finding bugs in QEMU this test harness sounds like the kind
of thing we ought to have integrated in QEMU's meson test suite such
that it runs in CI to prevent regressions.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


