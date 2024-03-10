Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FD3C54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 21:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjQOl-0004QY-0W; Sun, 10 Mar 2024 17:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rjQOj-0004Q2-Ol
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 17:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rjQOi-0003Px-6f
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 17:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710104873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5KNtg2ETgvivPOVUzLPwYiwtr0bLxnHEKHq7C69R8+A=;
 b=DXd+oOjl60f/gMhASDvZ2W1k3FMbmxe3k3aWsbCJnCp0T67LXFdXQndsMXFyP3eBxtl+b/
 3UEz5n0eIEmboG0gt5RSG+CmmyCxoRtwemJ9VjNeKWMxRTv2skeNNE8T3nLrWacdpSYSJJ
 zfzzaeTyyroDjjsd/JKI0vpkvGdJ9b8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-bbRRWY1HMZOp03A2TG948g-1; Sun, 10 Mar 2024 17:07:51 -0400
X-MC-Unique: bbRRWY1HMZOp03A2TG948g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 587CB81CF30;
 Sun, 10 Mar 2024 21:07:51 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DA42492BD0;
 Sun, 10 Mar 2024 21:07:47 +0000 (UTC)
Date: Sun, 10 Mar 2024 22:07:45 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
Message-ID: <Ze4hIfIwXPUPPMFK@angien.pipo.sk>
References: <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
 <87o7gbyy8w.fsf@pond.sub.org> <ZUTffE0wfjLH2u+e@redhat.com>
 <87cywqn84g.fsf@pond.sub.org>
 <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
 <ZeWnFhLKCamlP97y@redhat.com> <ZeWr3ZGrRUrciHH4@angien.pipo.sk>
 <65f517cd-3a1b-41bd-b326-e509cb208b92@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f517cd-3a1b-41bd-b326-e509cb208b92@yandex-team.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Mar 07, 2024 at 22:42:56 +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 04.03.24 14:09, Peter Krempa wrote:
> > On Mon, Mar 04, 2024 at 11:48:54 +0100, Kevin Wolf wrote:
> > > Am 28.02.2024 um 19:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > > On 03.11.23 18:56, Markus Armbruster wrote:
> > > > > Kevin Wolf<kwolf@redhat.com>  writes:

[...]

> 
> I only see the following differencies:
> 
> 1. block-job-complete documents that it completes the job synchronously.. But looking at mirror code I see it just set s->should_complete = true, which will be then handled asynchronously.. So I doubt that documentation is correct.
> 
> 2. block-job-complete will trigger final graph changes. block-job-cancel will not.
> 
> Is [2] really useful? Seems yes: in case of some failure before starting migration target, we'd like to continue executing source. So, no reason to break block-graph in source, better keep it unchanged.
> 
> But I think, such behavior better be setup by mirror-job start parameter, rather then by special option for cancel (or even compelete) command, useful only for mirror.

Libvirt's API design was based on the qemu quirk and thus we allow users
to do the decision after starting the job, thus anything you pick needs
to allow us to do this at "completion" time.

Libvirt can adapt to any option that will give us the above semantics
(extra parameter at completion time, different completion command or
extra command to switch job properties right before completion), but to
be honest all of these feel like they would be more hassle than keeping
'block-job-cancel' around from qemu's side.


