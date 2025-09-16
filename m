Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AF1CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 06:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyOjc-0004Gh-Fs; Tue, 16 Sep 2025 02:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyOja-0004GT-Hq
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 02:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyOjX-0004v4-1X
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 02:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758002404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=McYDUNcFuzkgSWKg9Px3K0oVbKURFFotKpQXU6ZEsKs=;
 b=BtpQeX1CwS8nQNDtt/Gn6jFTOz6IR8pkNO6pV42ovbnjw+4i4GbEsQ3u4hXVt4DTyfb4KD
 2J1gATk9ugKBtLr9i0M7yiwGWDT4NS2lcvSYjMMicixMLar+ZJctcNCXWPAyKtKbBj8EaK
 09VIKE46CkGy2c68x7G6DzH0bYfxupk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-s-YXjQMeMqKxOa4geABH9Q-1; Tue,
 16 Sep 2025 02:00:00 -0400
X-MC-Unique: s-YXjQMeMqKxOa4geABH9Q-1
X-Mimecast-MFC-AGG-ID: s-YXjQMeMqKxOa4geABH9Q_1758002398
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2EA41955E9E; Tue, 16 Sep 2025 05:59:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C03E300021A; Tue, 16 Sep 2025 05:59:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9E6EB21E6A27; Tue, 16 Sep 2025 07:59:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>,  thuth@redhat.com,
 richard.henderson@linaro.org,  david@redhat.com,  jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  walling@linux.ibm.com,
 jjherne@linux.ibm.com,  pasic@linux.ibm.com,  borntraeger@linux.ibm.com,
 farman@linux.ibm.com,  mjrosato@linux.ibm.com,  iii@linux.ibm.com,
 eblake@redhat.com,  alifm@linux.ibm.com
Subject: Re: [PATCH v5 01/29] Add boot-certs to s390-ccw-virtio machine type
 option
In-Reply-To: <aMhKWu7i-9MgO30H@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 15 Sep 2025 18:18:18 +0100")
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-2-zycai@linux.ibm.com>
 <87v7lpjvsw.fsf@pond.sub.org>
 <ffb4d32b-d2bc-45f0-91ce-6472d64c02bb@linux.ibm.com>
 <87wm64b29p.fsf@pond.sub.org>
 <3d930413-d809-4650-b1d8-446eb4ee7daa@linux.ibm.com>
 <87tt14z03x.fsf@pond.sub.org>
 <14c613b1-d595-4cf1-b26e-5d87965a2c98@linux.ibm.com>
 <aMhKWu7i-9MgO30H@redhat.com>
Date: Tue, 16 Sep 2025 07:59:54 +0200
Message-ID: <87wm5zos2t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

[...]

> IMHO we should be a bit more strict than this
>
>  * If pointing to a file - loading must succeed; errors must be fatal
>  * If pointing to a dir - the dir must exist, any file NOT ending in
>    .pem should be ignored, any file ending in .pem must succeed, errors
>    must be fatal
>  * If pointing to neither a file, nor dir - must be fatal
>
> ie we should be assuming that the configuration is expected to work, and
> thus errors when loading are liable to be admin config mistakes that shou=
ld
> be fatal.

Seconded.  Thanks!


