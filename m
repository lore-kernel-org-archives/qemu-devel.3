Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F33C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeAa-0007KA-9K; Fri, 03 Jul 2026 09:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfeAX-0007DZ-1p
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfeAT-0003ei-R0
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783086176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IeQeo6xDXHh3f330cKQqjcWPpGcsCSyhbhx+9Bj9qgs=;
 b=HEJdadTCK+pNn9zg8XinAsJ5f3PfW7+2rzGuBsR+4o1wIRIjFjTKv/hTivPp6/FQ3t3cTL
 7pMtDPyfgX8UaTP/51yZUX2uLjD51A4u98Loa5M8eV9eSY9841MbZCTTKcvfo7RTnUlD0R
 qseG9Zn3JJdpIVReSmBbx3KEGkUQyww=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-YUxoEdIVNO-XfRYA6HF3GA-1; Fri,
 03 Jul 2026 09:42:51 -0400
X-MC-Unique: YUxoEdIVNO-XfRYA6HF3GA-1
X-Mimecast-MFC-AGG-ID: YUxoEdIVNO-XfRYA6HF3GA_1783086170
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4521196F77B; Fri,  3 Jul 2026 13:42:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C451636F24; Fri,  3 Jul 2026 13:42:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F7FE21E6920; Fri, 03 Jul 2026 15:42:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David
 Alan Gilbert" <dave@treblig.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Christian
 Brauner <brauner@kernel.org>,  devel@lists.libvirt.org,  Peter Krempa
 <pkrempa@redhat.com>
Subject: Re: [PATCH v6 31/34] monitor: add support for auto-deleting
 monitors upon close
In-Reply-To: <20260702160337.1910921-32-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 2 Jul 2026 17:03:34
 +0100")
References: <20260702160337.1910921-1-berrange@redhat.com>
 <20260702160337.1910921-32-berrange@redhat.com>
Date: Fri, 03 Jul 2026 15:42:46 +0200
Message-ID: <87jyrcur3d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The default monitor is usually a long lived object that will exist for
> the entire lifetime of the VM. A monitor can only service a single
> client at a time though, and so it might be desirable to hotplug
> additional monitors at runtime for specific tasks. If doing that,
> however, there is a need to remove the monitor when it is no longer
> needed.

I challenged this in review of v5, and you replied with a convincing use
case: management application hands a monitor to its client.  Would be
nice to have in the commit message.  Up to you.

> Allowing a client to run "object-del" against its own monitor adds
> complex edge cases, as it would be desirable to send the QMP response
> despite the monitor sending it being deleted. Doing "object-del" alone
> will also result in orphaning a character device backend instance, as
> there is no opportunity to run the companion "chardev-del" command.
>
> A simpler way to ensure cleanup is to add the concept of auto-deleting
> monitor objects. Specifically when the "CHR_EVENT_CLOSED" event is
> emitted, the equivalent of "object-del" + "chardev-del" can be run
> internally. Since the transient client has already droppped its
> monitor connection, there is no synchronization to be concerned about
> with sending QMP replies. There is still some internal synchronization
> needed, however, between the character device event callback and the
> bottom-half that runs the delete. There is a chance that an incoming
> client connection may arise before the bottom-half runs, which has
> to be checked. Once the monitor object is deleted, the event callback
> is unregistered from the character device, eliminating any further
> races before the character device is fully deleted.
>
> This is implemented via a new "close-action=3Dnone|delete" property on
> the 'monitor-qmp' object. This concept could be extended with further
> actions in future, for example:
>
>  * close-action=3Dshutdown - graceful guest shutdown
>  * close-action=3Dterminate - immediate guest poweroff
>  * close-action=3Dstop - pause guest CPUs while the monitor is not
>                        connected to any client
>
> This is left as an exercise for future interested contributors.
>
> Tested-by: Peter Krempa <pkrempa@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


