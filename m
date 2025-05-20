Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629C6C54756
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 08:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHIYo-0000KW-OY; Tue, 20 May 2025 04:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHIYm-0000KK-9r
 for qemu-devel@nongnu.org; Tue, 20 May 2025 04:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHIYk-0004w2-L0
 for qemu-devel@nongnu.org; Tue, 20 May 2025 04:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747730569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6zZZzfWaZiJL/DPHFrAaKTsWoJygIu4QDgVGBXRR/nM=;
 b=LdH77e+vfVoYsGfqKSgg4ablLHWzlH5gPTGPR1LkrTzSC4hXsAeT88KKhA01uqKDEic+sv
 k6CFc0StE4KXOwXC9oUPDDdvFRXhX9CT94pGDapFGwztbTQymLsLUq0nTYQZND8QOqINJ0
 Sy0TUJp924s8Vx+yhuExBcauPvkVjE8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-zBY4ssQqOkeM46ExPpBx_Q-1; Tue,
 20 May 2025 04:42:44 -0400
X-MC-Unique: zBY4ssQqOkeM46ExPpBx_Q-1
X-Mimecast-MFC-AGG-ID: zBY4ssQqOkeM46ExPpBx_Q_1747730563
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0F8D1955DB5; Tue, 20 May 2025 08:42:42 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.86])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 289AC19560AE; Tue, 20 May 2025 08:42:38 +0000 (UTC)
Date: Tue, 20 May 2025 10:42:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 10/11] block/graph-lock: add drain flag to
 bdrv_graph_wr{,un}lock
Message-ID: <aCxAfGKzCYs_Y9TH@redhat.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-11-f.ebner@proxmox.com>
 <aCT04V_-LtCXryqv@redhat.com>
 <3a777fbd-bd1f-4deb-8d03-e66a58784474@proxmox.com>
 <028d0caf-7925-4adc-9791-d5557b71896f@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028d0caf-7925-4adc-9791-d5557b71896f@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 20.05.2025 um 08:09 hat Fiona Ebner geschrieben:
> On 19.05.25 2:10 PM, Fiona Ebner wrote:
> > Am 14.05.25 um 21:54 schrieb Kevin Wolf:
> >> Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
> >>> In bdrv_graph_wrlock() there is a comment that it uses
> >>> bdrv_drain_all_begin_nopoll() to make sure that constantly arriving
> >>> new I/O doesn't cause starvation. The changes from this series are at
> >>> odds with that, but there doesn't seem to be any (new) test failures.
> >>
> >> I don't see why they are at odds with it? Draining an already drained
> >> node isn't a problem, it just increases the counter without doing
> >> anything else.
> > 
> > What I mean is: the introduction of calls to bdrv_drain_all_begin()
> > before bdrv_drain_all_begin_nopoll() could introduce potential for
> > starvation when there is constantly arriving new I/O. Or is this not true?
> 
> Oh, I guess I know why I was confused now: I thought the comment is the
> rationale for why the _nopoll variant is used, but the comment is the
> rationale for the draining itself :)

Ah, yes, it is! Or for both together, but in the sense why nopoll is
good enough, not why it does something that the normal drain wouldn't
do. The nopoll variant is used simply because we don't really need to
have all requests drained, it's good enough if no new request are coming
in.

Kevin


