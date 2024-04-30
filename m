Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97332C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jYe-0002Ae-Fj; Tue, 30 Apr 2024 05:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1s1jYc-00028C-NE
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1s1jYa-0007tz-NR
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714468427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=POBJWcFZBTiQqx+jA/0fIqenMVMn5xC8yIafHKWLzTM=;
 b=B5N1USnE2LpyOYEXgLVIr6co0eCYb8HZ9A5F5f+ddbgWdYB7Ip1hRPnGJ/GgR1/Su7y2g2
 d3k5wtTyoC8vMmlPoVmRNR7BXTG+vNACzsDj5qSvOksrQGQ7fzEK692lZie8R7zlmjYebd
 47WpcVCly7vUtRPNNQtA92E6sZR/BsE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-3hV-GbbJNaWMYl4Z_826rw-1; Tue, 30 Apr 2024 05:13:45 -0400
X-MC-Unique: 3hV-GbbJNaWMYl4Z_826rw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B0EC80591B;
 Tue, 30 Apr 2024 09:13:44 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5403F1121312;
 Tue, 30 Apr 2024 09:13:43 +0000 (UTC)
Date: Tue, 30 Apr 2024 11:13:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PULL 6/6] iotests: add backup-discard-source
Message-ID: <ZjC2RvxoyYc0KW0p@redhat.com>
References: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
 <20240429115157.2260885-7-vsementsov@yandex-team.ru>
 <11fd6cbf-cd8b-4469-aefa-2bfddf5a3ca9@linaro.org>
 <4c7cb398-7fb8-4c78-a9e2-aae46920a8b1@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c7cb398-7fb8-4c78-a9e2-aae46920a8b1@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 29.04.2024 um 20:39 hat Vladimir Sementsov-Ogievskiy geschrieben:
> [Add John]
> 
> On 29.04.24 17:18, Richard Henderson wrote:
> > On 4/29/24 04:51, Vladimir Sementsov-Ogievskiy wrote:
> > > Add test for a new backup option: discard-source.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> > > Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> > > Message-Id: <20240313152822.626493-6-vsementsov@yandex-team.ru>
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > ---
> > >   .../qemu-iotests/tests/backup-discard-source  | 152 ++++++++++++++++++
> > >   .../tests/backup-discard-source.out           |   5 +
> > >   2 files changed, 157 insertions(+)
> > >   create mode 100755 tests/qemu-iotests/tests/backup-discard-source
> > >   create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out
> > 
> > This fails check-python-minreqs
> > 
> >    https://gitlab.com/qemu-project/qemu/-/jobs/6739551782
> > 
> > It appears to be a pylint issue.
> > 
> > 
> 
> tests/export-incoming-iothread:1:0: R0801: Similar lines in 2 files
> ==tests.backup-discard-source:[52:61]
> ==tests.copy-before-write:[54:63]
>             'file': {
>                 'driver': iotests.imgfmt,
>                 'file': {
>                     'driver': 'file',
>                     'filename': source_img,
>                 }
>             },
>             'target': {
>                 'driver': iotests.imgfmt, (duplicate-code)
> 
> 
> 
> Hmm. I don't think, that something should be changed in code.
> splitting out part of this json object to a function? That's a test
> for QMP command, and it's good that we see the command as is in one
> place. I can swap some lines or rename variables to hack the linter,
> but I'd prefer not doing so:)
> 
> 
> For me that looks like a false-positive: yes it's a duplication, but
> it should better be duplication, than complicating raw json objects by
> reusing common parts.
> 
> 
> What to do? As described in 22305c2a081b8b6 "python: Reduce strictness
> of pylint's duplicate-code check", this check could be either be
> disabled completely, or we can increase min-similarity-lines config
> value.
> 
> I'd just disable it completely. Any thoughts?

I think it would make sense to treat tests differently from real
production code. In tests/, some duplication is bound to happen and
trying to unify things across test cases (which would mean moving to
iotests.py) often doesn't make sense. On the other hand, in python/ we
would probably want to unify duplicated code.

Kevin


