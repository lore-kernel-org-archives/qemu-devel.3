Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6D8C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 11:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh6DO-0003Nh-5Y; Mon, 04 Mar 2024 06:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rh6DM-0003NA-2i
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 06:10:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rh6DH-0000xu-N9
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 06:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709550630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OQPl6C8iXwaBFfk5FyTvjJtxLksU9K5Tr8tUKkrk7jA=;
 b=i4xyCdUNcMCQeKM9wATC7jQyY976Eon62wFdmm40SdQ1ndg6+VTgKW44dyL7zevYCDR+EU
 ulji7ah6bjKnXLjStHUCM384ybNMLb+IQ/tfZ6GzoJtkBjYzbtlejcqBBnBLtwrHKmwbug
 SaeEXW7Yo3cN8J0+I+/mbzj4bkaeeq0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-p15qyvWaOEiOBls1cRtD1Q-1; Mon,
 04 Mar 2024 06:09:22 -0500
X-MC-Unique: p15qyvWaOEiOBls1cRtD1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BC321C068C4;
 Mon,  4 Mar 2024 11:09:21 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.3.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D126E40C94A7;
 Mon,  4 Mar 2024 11:09:19 +0000 (UTC)
Date: Mon, 4 Mar 2024 12:09:17 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
Message-ID: <ZeWr3ZGrRUrciHH4@angien.pipo.sk>
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
 <87o7gbyy8w.fsf@pond.sub.org> <ZUTffE0wfjLH2u+e@redhat.com>
 <87cywqn84g.fsf@pond.sub.org>
 <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
 <ZeWnFhLKCamlP97y@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeWnFhLKCamlP97y@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 04, 2024 at 11:48:54 +0100, Kevin Wolf wrote:
> Am 28.02.2024 um 19:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > On 03.11.23 18:56, Markus Armbruster wrote:
> > > Kevin Wolf<kwolf@redhat.com>  writes:

[...]

> > > Is the job abstraction a failure?
> > > 
> > > We have
> > > 
> > >      block-job- command      since   job- command    since
> > >      -----------------------------------------------------
> > >      block-job-set-speed     1.1
> > >      block-job-cancel        1.1     job-cancel      3.0
> > >      block-job-pause         1.3     job-pause       3.0
> > >      block-job-resume        1.3     job-resume      3.0
> > >      block-job-complete      1.3     job-complete    3.0
> > >      block-job-dismiss       2.12    job-dismiss     3.0
> > >      block-job-finalize      2.12    job-finalize    3.0
> > >      block-job-change        8.2
> > >      query-block-jobs        1.1     query-jobs

[...]

> I consider these strictly optional. We don't really have strong reasons
> to deprecate these commands (they are just thin wrappers), and I think
> libvirt still uses block-job-* in some places.

Libvirt uses 'block-job-cancel' because it has different semantics from
'job-cancel' which libvirt documented as the behaviour of the API that
uses it. (Semantics regarding the expectation of what is written to the
destination node at the point when the job is cancelled).

Libvirt also uses 'block-job-set-speed' and 'query-block-jobs' but those
can be replaced easily and looking at the above table even without any
feature checks.

Thus the plan to deprecate at least 'block-job-cancel' will not work
unless the semantics are ported into 'job-cancel'.


