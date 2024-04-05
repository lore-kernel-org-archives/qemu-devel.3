Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED915C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 14:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsl2I-0005q5-Pc; Fri, 05 Apr 2024 10:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rsl2G-0005pH-Gv
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rsl2E-0005Xe-Hs
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712329155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2lLYGtnthOT6vR9LH1kK6oBLvaJlN8/zxSdYgpYmfqY=;
 b=I8Dubq0hUtVzRhPh5EkpD7Xj5rV+0aAfRyrub2TDVYKx2bxHntdTrznTkVHwAWCv9D9o6V
 TUkE4XYEkMn1orBWpoFNrcDaeDdH6D9ogRvV58DAlrcdSXBtLl135L+Uu8gaIpdL4viG1U
 HS1MdhDk4BVcYrwBtjuom2YorRhtUSg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-QstYmu5lNbOTlIq0Dke8Qg-1; Fri,
 05 Apr 2024 10:59:13 -0400
X-MC-Unique: QstYmu5lNbOTlIq0Dke8Qg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C6C9385DF28;
 Fri,  5 Apr 2024 14:59:13 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C018492BCD;
 Fri,  5 Apr 2024 14:59:12 +0000 (UTC)
Date: Fri, 5 Apr 2024 09:59:06 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Zhu Yangyang <zhuyangyang14@huawei.com>
Subject: Re: [PATCH v3] nbd/server: do not poll within a coroutine context
Message-ID: <xrnfz5cumme2gfdn7fe7gfdekgyctnf6uc5bbg4rblaqeqthn6@swgoyg6ii7oy>
References: <20240404014418.620851-2-eblake@redhat.com>
 <5f189e2a-7972-46f4-a94b-040d3d0baf91@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f189e2a-7972-46f4-a94b-040d3d0baf91@yandex-team.ru>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Apr 05, 2024 at 05:10:16PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 04.04.24 04:42, Eric Blake wrote:
> > From: Zhu Yangyang <zhuyangyang14@huawei.com>
> > 
> > Coroutines are not supposed to block. Instead, they should yield.
> > 
> > The client performs TLS upgrade outside of an AIOContext, during
> > synchronous handshake; this still requires g_main_loop.  But the
> > server responds to TLS upgrade inside a coroutine, so a nested
> > g_main_loop is wrong.  Since the two callbacks no longer share more
> > than the setting of data.complete and data.error, it's just as easy to
> > use static helpers instead of trying to share a common code path.
> > 
> > Fixes: f95910f ("nbd: implement TLS support in the protocol negotiation")
> > Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
> > [eblake: move callbacks to their use point]
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> > 
> > After looking at this more, I'm less convinced that there is enough
> > common code here to even be worth trying to share in common.c.  This
> > takes the essence of the v2 patch, but refactors it a bit.
> 
> Maybe, do the complete split, and make separate structure definitions in client.c and server.c, and don't make shared NBDTLSHandshakeData with union? Finally, it's just a simple opaque-structure for static callback function, seems good to keep it in .c as well.

Sure, v4 coming up along those lines.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


