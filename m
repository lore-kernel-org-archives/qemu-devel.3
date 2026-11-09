Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4424606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FtRT2+iI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQcy-0004Pn-P8; Mon, 09 Nov 2026 09:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQQc5-0003n6-Tb
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:44:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQQc4-0005qu-DJ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794235485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmG9NC+oQHDh2znjt5atJLA5HTePlqgo84Gr9Pf48hg=;
 b=FtRT2+iIQ0Tzc3355uiFJjuChuC1w+MspKKU5+C72aOm8Eel/FpT9BpGbLCPhXKPbrwDAt
 Fa1oaw0nzZtV9wxZoRdJWor96HBOQccOyz+u5id9RcY28EtfHxtGNdjhluME3vJuKKLyYr
 2+hH0rwTvE/kdFgBhF3FvCEfD+Cqdk8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-YfiAKtkcMbyMchDGbbHpUg-1; Mon,
 09 Nov 2026 09:44:41 -0500
X-MC-Unique: YfiAKtkcMbyMchDGbbHpUg-1
X-Mimecast-MFC-AGG-ID: YfiAKtkcMbyMchDGbbHpUg_1794235480
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F1381955F0C; Mon,  9 Nov 2026 14:44:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B32330000E5; Mon,  9 Nov 2026 14:44:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A65721E6A04; Mon, 09 Nov 2026 15:44:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 milesg@linux.ibm.com,  qemu-ppc@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 4/8] hw/gpio/pca9554: New abstract base "pca9554-base"
In-Reply-To: <c686141b-4df3-4aab-9f02-17afabb0be1c@nutanix.com> (Mark
 Cave-Ayland's message of "Mon, 9 Nov 2026 14:20:42 +0000")
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-5-armbru@redhat.com>
 <463635be-2321-49e6-852d-080aa00ce40d@nutanix.com>
 <aaba798c-591b-4956-be34-e6c9653398c8@nutanix.com>
 <87qzgu43s8.fsf@pond.sub.org>
 <c686141b-4df3-4aab-9f02-17afabb0be1c@nutanix.com>
Date: Mon, 09 Nov 2026 15:44:37 +0100
Message-ID: <87h5hq2hey.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> Well just the one :) The point I was making above was really about PCA955=
xState already existing in hw/gpio/pca9552.c: it seems that the common pare=
nt PCA955xState (and also parent class PCA955xClass) already exists for thi=
s family of chips, and in fact the real problem is that hw/gpio/pca9554.c d=
oesn't make use of this.

Ah, I completely misunderstood your question!

PCA955xState is the instance struct of abstract type "pca955x" and its
concrete subtypes "pca9552", "pca9535", "pca9555".  These live in
pca9552.c.

We also have "pca9554" and "pca9536" in pca9554.c.  It's an entirely
separate implementation.  I have no idea whether this is approproate.
Do you think they should be subtypes of "pca955x", and share common
code?

If yes: I can't get us there, sorry.  All I'm trying to do in this
series is to bring back Marc-Andr=C3=A9's work I dropped.  I didn't feel li=
ke
leaving the properties non-class when I touch them anyway, so I
converted them to class properties first.  That may have been unwise :)


