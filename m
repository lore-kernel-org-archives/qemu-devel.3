Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B77CC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 07:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCw2u-00029b-9h; Thu, 08 May 2025 03:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCw2s-000291-Nn
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCw2r-0003IJ-BS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746690712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEpTBc9pB4EQVczgEm7Mqcx72wH9WWq1vKK9qhKe6SE=;
 b=RnCFBLQr/HYifOQrp3hDmdZN6Ielbv49GRviL7AC6LmB1ZnrbWfGe/VxrDd2ALwy0BABZB
 kVUkgsV7j0Dtomo4JJFlzqclC4VraCE/MR4idVSjAeho8YdnWkwJHFkLBXjZVgDHOme3mE
 pXDp3FNKzfHmOwFTLCLlRFEk2X1UB+U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-bvoqJKUiMaufuA8QcbVdVA-1; Thu,
 08 May 2025 03:51:49 -0400
X-MC-Unique: bvoqJKUiMaufuA8QcbVdVA-1
X-Mimecast-MFC-AGG-ID: bvoqJKUiMaufuA8QcbVdVA_1746690707
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 240911955DCC; Thu,  8 May 2025 07:51:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F5331956055; Thu,  8 May 2025 07:51:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8974221E6768; Thu, 08 May 2025 09:51:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jonah Palmer <jonah.palmer@oracle.com>,  qemu-devel@nongnu.org,
 mst@redhat.com,  qemu_oss@crudebyte.com,  kraxel@redhat.com,
 si-wei.liu@oracle.com,  joao.m.martins@oracle.com,  eblake@redhat.com,
 qemu-block@nongnu.org,  david@redhat.com,  arei.gonglei@huawei.com,
 marcandre.lureau@redhat.com,  lvivier@redhat.com,  thuth@redhat.com,
 michael.roth@amd.com,  groug@kaod.org,  dgilbert@redhat.com,
 eric.auger@redhat.com,  stefanha@redhat.com,  boris.ostrovsky@oracle.com,
 kwolf@redhat.com,  mathieu.poirier@linaro.org,
 raphael.norwitz@nutanix.com,  pbonzini@redhat.com,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v15 2/6] qmp: add QMP command x-query-virtio-status
In-Reply-To: <7de79c4d-57f2-4103-a22e-748cfbe08974@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 2 May 2025 00:09:12
 +0200")
References: <1660220684-24909-1-git-send-email-jonah.palmer@oracle.com>
 <1660220684-24909-3-git-send-email-jonah.palmer@oracle.com>
 <7de79c4d-57f2-4103-a22e-748cfbe08974@linaro.org>
Date: Thu, 08 May 2025 09:51:43 +0200
Message-ID: <87tt5vh75c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

[...]

> When a structure is only used by an unstable command, is it considered
> unstable too? IOW is it OK to modify it?

Yes.

docs/devel/qapi-code-gen.rst:

    Special features
    ~~~~~~~~~~~~~~~~

    [...]

    Feature "unstable" marks a command, event, enum value, or struct
    member as unstable.  It is not supported elsewhere so far.  Interfaces
    so marked may be withdrawn or changed incompatibly in future releases.

We support "unstable" exactly where we need it to mark parts of the
external interface unstable:

* Commands and events, because these *are* the external interface.

* Struct members, because they can be arguments / results of commands /
  events.

* Enum values, because these can be values of arguments / results.

* Not types.  Not needed, and would enable inconsistencies, like stable
  member with an unstable type.

Questions?

[...]


