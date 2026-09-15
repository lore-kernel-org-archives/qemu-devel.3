Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEA1C88E73
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6O46-0005n1-TR; Tue, 15 Sep 2026 03:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6O42-0005mP-Fs
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6O41-0000lO-1c
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789459127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDbs/Co/jlFQW+olPtfDvhciHYjFp+TUvOiI8cY5SlE=;
 b=U+JjuafMDeZnuEHoEtuSD74fV0E5LXIgNlGQqFwBJJhnvX+kABcaaoMHJJLMEhUdEXNj/j
 snVV7sBANeHVikejlhgOvJeuBMV7fbUlSapflCUVwHUYkppLn8JijQ/4VTgr1TIV5kCF/z
 2kGXq7zeadGSeD7IpqJI40T+YwaKZzo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-PW9aBRryMciBq493fCezFA-1; Tue,
 15 Sep 2026 03:58:44 -0400
X-MC-Unique: PW9aBRryMciBq493fCezFA-1
X-Mimecast-MFC-AGG-ID: PW9aBRryMciBq493fCezFA_1789459123
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C342F1955D69; Tue, 15 Sep 2026 07:58:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75C213003EF5; Tue, 15 Sep 2026 07:58:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D923421E6A04; Tue, 15 Sep 2026 09:58:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v8 1/3] parallels: report the stored dirty bitmaps in
 qemu-img info
In-Reply-To: <20260913195301.1514888-2-den@openvz.org> (Denis V. Lunev's
 message of "Sun, 13 Sep 2026 21:52:59 +0200")
References: <20260913195301.1514888-1-den@openvz.org>
 <20260913195301.1514888-2-den@openvz.org>
Date: Tue, 15 Sep 2026 09:58:39 +0200
Message-ID: <87ld93rln4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

"Denis V. Lunev" <den@openvz.org> writes:

> From: Denis V. Lunev <den@openvz.org>
>
> Nothing tells which persistent bitmaps an image carries. qemu-img info
> says nothing about them, and the only other way to see one is to export
> the image over NBD and ask for a bitmap by name, which needs the name
> beforehand.
>
> Add ImageInfoSpecificParallels with the bitmaps and their granularity,
> in the same way as qcow2 reports the contents of its bitmap directory:
>
>     Format specific information:
>         bitmaps:
>             [0]:
>                 name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
>                 granularity: 65536
>
> For running VM process the list is built on the fly from in-memory
> list. This is the best we can do. FormatExtension could be dead in
> the image while VMs are running as all bitmaps are cleared on
> non-clean VM stop.
>
> A bitmap of an image which was not closed correctly is inconsistent
> and can not be used. Report that as well, the way qcow2 reports its
> in-use flag, so such a bitmap is not listed as a valid one.
>
> The section is left empty for an image with no persistent dirty
> bitmaps, and an empty section is not printed, so the human readable
> output of "qemu-img info" and "info block" is unchanged.
>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


