Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5428CAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAN3-0005Pl-TN; Thu, 18 Sep 2025 04:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzAN2-0005Oz-6C
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzAMw-0003rC-Q1
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758185514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2rSWvD8UOSbYbZZXpnLSTIINitGpVBjfFdT5jFT5gqE=;
 b=Pdf2m3Nqp6Oeu2qXndoTuSEdNBODbsrAtT13J+/9eXtmSVbXS41FMprtFuwyhPv+wmoqPS
 4EgLLxsIiATddZQKSjkaCMJJ3JYifaUaon7Bxqp4HSVzOYPAOISXduX79/HbXnUfRGZ6mF
 Rh/R5CK7bWEs6uiDvjwzNa68uT3ghEk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-vlxC20j8M72aE8VeXpa4Bg-1; Thu,
 18 Sep 2025 04:51:49 -0400
X-MC-Unique: vlxC20j8M72aE8VeXpa4Bg-1
X-Mimecast-MFC-AGG-ID: vlxC20j8M72aE8VeXpa4Bg_1758185508
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC56C19560AE; Thu, 18 Sep 2025 08:51:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CA3F1955F21; Thu, 18 Sep 2025 08:51:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B97E21E6A27; Thu, 18 Sep 2025 10:51:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>,  thuth@redhat.com,
 richard.henderson@linaro.org,  david@redhat.com,  jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  walling@linux.ibm.com,
 jjherne@linux.ibm.com,  pasic@linux.ibm.com,  borntraeger@linux.ibm.com,
 farman@linux.ibm.com,  mjrosato@linux.ibm.com,  iii@linux.ibm.com,
 eblake@redhat.com,  alifm@linux.ibm.com
Subject: Re: [PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type
 option
In-Reply-To: <aMvE7Phd7sLvgj-J@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 18 Sep 2025 09:38:04 +0100")
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-2-zycai@linux.ibm.com>
 <87ldmcz1so.fsf@pond.sub.org> <aMvE7Phd7sLvgj-J@redhat.com>
Date: Thu, 18 Sep 2025 10:51:44 +0200
Message-ID: <87348kywgv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Sep 18, 2025 at 08:56:39AM +0200, Markus Armbruster wrote:
>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>>=20
>> > Introduce a new `boot-certs` machine type option for the s390-ccw-virt=
io
>> > machine. This allows users to specify one or more certificate file pat=
hs
>> > or directories to be used during secure boot.
>> >
>> > Each entry is specified using the syntax:
>> > 	boot-certs.<index>.path=3D/path/to/cert.pem
>> >
>> > Multiple paths can be specify using array properties:
>> > 	boot-certs.0.path=3D/path/to/cert.pem,
>> > 	boot-certs.1.path=3D/path/to/cert-dir,
>> > 	boot-certs.2.path=3D/path/to/another-dir...
>>=20
>> Given we can specifiy a directory containing any number of certificate
>> files, is the ability to specify multiple paths worth the additional
>> complexity?
>
> The typical scenario would be point to somewhere in /etc/pki
> for some globally provided certs, and then also point to
> somewhere local ($HOME) for custom extra certs. So IMHO it
> is reasonable to want multiple paths, to avoid copying around
> certs from different locations.

Thanks.

Preferably with BootCertificate renamed to BootCertificates
Acked-by: Markus Armbruster <armbru@redhat.com>


