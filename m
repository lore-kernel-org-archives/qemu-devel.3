Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D13C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzfj-0000Yu-Tq; Tue, 07 Jul 2026 02:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgzfh-0000YO-Ie
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgzfg-0004jf-3L
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783407162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQk9iciKD6j6fb11hSfip8L5K9B475qWpCz8RMyAHEk=;
 b=c3nPDny+O9T71bEg06IU8IvTSgZerOUIq+q9F1GIlhDLU4nTg+DPDJfF1/oi3MJuAjlvAK
 ss6SXDGPe4TjhqP5ur5nkOAOpXX1/b54k1KO50DLk8Ym8BaYvornN0FXyivJWimI7AuquH
 GEbbIbJnSQy7RI2y7VwNYsIACBTKU9c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-PJcsVkR9P6mb-BUOKxv-4Q-1; Tue,
 07 Jul 2026 02:52:39 -0400
X-MC-Unique: PJcsVkR9P6mb-BUOKxv-4Q-1
X-Mimecast-MFC-AGG-ID: PJcsVkR9P6mb-BUOKxv-4Q_1783407156
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 737141805C35; Tue,  7 Jul 2026 06:52:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D381E36929; Tue,  7 Jul 2026 06:52:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C1CC21E6920; Tue, 07 Jul 2026 08:52:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Christian Brauner <brauner@kernel.org>,
 devel@lists.libvirt.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v7 32/35] monitor: add support for auto-deleting
 monitors upon close
In-Reply-To: <20260706135824.2623960-33-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 6 Jul 2026 14:58:20
 +0100")
References: <20260706135824.2623960-1-berrange@redhat.com>
 <20260706135824.2623960-33-berrange@redhat.com>
Date: Tue, 07 Jul 2026 08:52:33 +0200
Message-ID: <87se5vjnpq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The default monitor is usually a long lived object that will exist for
> the entire lifetime of the VM. A monitor can only service a single
> client at a time though, and so it might be desirable to hotplug
> additional monitors at runtime for specific tasks. If doing that,
> however, there is a need to remove the monitor when it is no longer
> needed.
>
> A use case for hotplugging a monitor can involved a user wishing to

Typo: involve

> spawn an adhoc script that uses a temporary monitor. The script can

ad hoc

> ask the management application to hotplug a monitor and pass back a
> pre-opened FD using SCM_RIGHTS. In this case the lifetime of the
> script is not tied to the management application and thus it is
> desirable to have automatic cleanup when the script exits.
>
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
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Happy to fix typos without a respin.


