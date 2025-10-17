Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855AECCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 08:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9fYJ-0005nK-E7; Fri, 17 Oct 2025 04:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9fYH-0005ms-Jm
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9fY9-0007rM-LM
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760688652;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DLIdAlkkRSWCrIudMAklkXomLW0+jIwOBHlWR+DTgw=;
 b=JVMK8KyS3e/yWgtp27ixfNOsEV8jXMnaXcB7HE2+qvwy6qcR+YIC7PBoFrfLtAWUoTpMzC
 MQJ+l4ec07sQlo2feK/xRLwxz5tc+V4g5sNP5QluwhLkHo8uQw42xC4v1rYyhTg89sIF8l
 QnLb7jEZzA78AK7X7d1sCNlYg9596sM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-6Ixk4LKHNn-BTt2GqRcy5Q-1; Fri,
 17 Oct 2025 04:10:49 -0400
X-MC-Unique: 6Ixk4LKHNn-BTt2GqRcy5Q-1
X-Mimecast-MFC-AGG-ID: 6Ixk4LKHNn-BTt2GqRcy5Q_1760688647
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2FEB18001E3; Fri, 17 Oct 2025 08:10:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4414B19560AD; Fri, 17 Oct 2025 08:10:40 +0000 (UTC)
Date: Fri, 17 Oct 2025 09:10:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 mst@redhat.com, jasowang@redhat.com, farosas@suse.de,
 sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aPH557l6YnXT-3r8@redhat.com>
References: <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <aPE8Oo5D3oesB7sV@x1.local> <aPE-vmyg1mLDO4pf@redhat.com>
 <aPFHl3VWV0pCmzd1@x1.local> <aPFOHjl5BoWEMqSL@redhat.com>
 <aPFVWi1pwxS8yGay@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPFVWi1pwxS8yGay@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 16, 2025 at 04:28:10PM -0400, Peter Xu wrote:
> On Thu, Oct 16, 2025 at 08:57:18PM +0100, Daniel P. Berrangé wrote:
> > Errm, machine types apply to devices, but this is about transferring
> > backends which are outside the scope of machine types. 
> 
> Ah.. I didn't notice that net backends are not inherited by default from
> qdev, hence not applicable to machine type properties.
> 
> Is it possible we enable it somehow, so that backends can have compat
> properties similarly to frontends?

That is a technical limitation, but the problem here is bigger than
just the lack of qdev. It is a conceptual one - where a device is
implemented, its behaviour is determined exclusively by the QEMU
code. There are some rare exceptions, like host PCI device assignment
where functionality is partly in the host hardware, or external
device backends where impl is offloaded to an external process, but
most pure QEMU impls are able to be made always migratable and compat
can be easily ensured long term via machine types props.

With backends, alot of behaviour is offloaded to either the host
OS, or to external libraries or services. Certain narrow configs
may be able to transfer state, but there will always be configs
were state transfer is impossible. There can be no coarse rule
that a backend is migratable or not - it will usually be highly
dependent on the particular configuration choices of the backend
in use.  Machine types props can't magically make all backend
config scenarios migratable. We need to be able to interrogate
backends at the time migration is required.

> If we go with a list of devices in the migration parameters, to me it'll
> only be a way to workaround the missing of such capability of net backends.
> Meanwhile, the admin will need to manage the list of devices even if the
> admin doesn't really needed to, IMHO.

We shouldn't need to list devices in every scenario. We need to focus on
the internal API design. We need to have suitable APIs exposed by backends
to allow us to query migratability and process vmstate a mere property
'backend-transfer' is insufficient, whether set by QEMU code, or set by
the mgmt app.

If we have proper APIs each device should be able to query whether its
backend can be transferred, and so "do the right thing" if backend
transfer is requested by migration. The ability to list devices in the
migrate command is only needed to be able to exclude some backends if
the purpose of migration is to change a backend

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


