Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C45BC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnb2C-0001Zb-D8; Thu, 27 Feb 2025 05:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnb25-0001Yy-CW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:22:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnb22-0000My-O4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740651737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMuTWyqSqLa/UwjoiexjicSoPCl5cwKsBC4HRzQ9He8=;
 b=LKm8yACwfcr2hj49y8OK61XtDju2rMdKMf7KGOWgR4Ebai3Cl9f9MxX9vRxYzsYJsh82LD
 8CfK5TTm5kuBoK+TY7GF2sdyNt8jK5V9jFtj41fxw2Dg0D85esdqdTgIISQCqusgd/35vQ
 BvuWsCZiyu8hTDGRbfamaXrnP27mBq8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-yc2l8f3eMEuNtH8UG-l5Lw-1; Thu,
 27 Feb 2025 05:22:11 -0500
X-MC-Unique: yc2l8f3eMEuNtH8UG-l5Lw-1
X-Mimecast-MFC-AGG-ID: yc2l8f3eMEuNtH8UG-l5Lw_1740651731
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 138821801A16; Thu, 27 Feb 2025 10:22:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A731E180036E; Thu, 27 Feb 2025 10:22:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1819521E66B9; Thu, 27 Feb 2025 11:22:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  eduardo@habkost.net
Subject: Re: [PATCH v2 4/6] qdev: Change values of PropertyInfo member @type
 to be QAPI types
In-Reply-To: <Z8Avjov46b3baoJr@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 27 Feb 2025 09:25:34 +0000")
References: <20250227085601.4140852-1-armbru@redhat.com>
 <20250227085601.4140852-5-armbru@redhat.com>
 <Z8Avjov46b3baoJr@redhat.com>
Date: Thu, 27 Feb 2025 11:22:07 +0100
Message-ID: <87eczjg01c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Feb 27, 2025 at 09:55:59AM +0100, Markus Armbruster wrote:
>> PropertyInfo member @type is externally visible via QMP
>> device-list-properties and qom-list-properies.
>>=20
>> Its meaning is not documented at its definition.
>>=20
>> It gets passed to as @type argument to object_property_add() and
>
>                  ^^^^^  "passed as the @type argument" ?

Yes.

>> object_class_property_add().  This argument's documentation isn't of
>> much help, either:

[...]

> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thank you!


