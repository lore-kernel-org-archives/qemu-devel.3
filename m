Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAB7C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 13:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIS0l-0000Jf-3Z; Fri, 23 May 2025 09:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIS0U-0000H2-9x
 for qemu-devel@nongnu.org; Fri, 23 May 2025 09:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIS0Q-0005SR-2T
 for qemu-devel@nongnu.org; Fri, 23 May 2025 09:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748005207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=43hlyWayNedx9BpJGC4JDpS777QaOjdSHxxmBeSlKuY=;
 b=P8WzTxUkMSI+JGqruuHpHtg2Pz40kab46Y4Y8BOs0zDJrJDdubgca5mNqxrR4wqXKxwUNA
 tM5j3I9huZgxCv+9c5ZqqPGErxON2o98m4Vdx0+Jpf+OEuVeutBxvvFKf9pwB+sss507nf
 VW3U/pZmiPSPFkPLw8i3Iujv52nU1G0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-DRZ3MXp-NDew3SGh8Owfdg-1; Fri,
 23 May 2025 09:00:05 -0400
X-MC-Unique: DRZ3MXp-NDew3SGh8Owfdg-1
X-Mimecast-MFC-AGG-ID: DRZ3MXp-NDew3SGh8Owfdg_1748005204
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00A4819560A0; Fri, 23 May 2025 13:00:04 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99E3A1955E83; Fri, 23 May 2025 13:00:00 +0000 (UTC)
Date: Fri, 23 May 2025 07:59:57 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 "Richard W.M. Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/4] nbd: Add multi-conn option
Message-ID: <hru5ctzwvuv2zyld6u2eruqz5pnl5qrnsrzwb4e2ame6lteglw@cn4x2z3a37qq>
References: <20250428185246.492388-6-eblake@redhat.com>
 <20250428185246.492388-7-eblake@redhat.com>
 <3233ad9b-028f-4136-9391-2130ecd5d4fe@virtuozzo.com>
 <fqocrea23tvvi73ld7yvhhw4h7ojv7qzf3jygw5ggxdu3ksb2a@l5l2duiwuzox>
 <df4826d3-fdb1-4dc6-9e1f-f87cbd8e08f4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df4826d3-fdb1-4dc6-9e1f-f87cbd8e08f4@virtuozzo.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 23, 2025 at 02:03:14PM +0300, Andrey Drobyshev wrote:
> >> I agree with Markus that this setting value different from what's been
> >> directly requested by user shouldn't go silent.  Having some kind of
> >> warning at the very least would be nice.
> > 
> > Okay, I'll make sure to warn if it exceeds the compile-time max.

Rather, refuse the QMP command with an error.

> > 
> >>
> >>>      ret = 0;
> >>>
> >>> @@ -1949,6 +1964,15 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
> >>>
> >>>      nbd_client_connection_enable_retry(s->conn);
> >>>
> >>> +    /*
> >>> +     * We set s->multi_conn in nbd_process_options above, but now that
> >>> +     * we have connected if the server doesn't advertise that it is
> >>> +     * safe for multi-conn, force it to 1.
> >>> +     */
> >>> +    if (!(s->info.flags & NBD_FLAG_CAN_MULTI_CONN)) {
> >>> +        s->multi_conn = 1;
> >>> +    }
> >>
> >> Same here.
> > 
> > Here, I disagree.  But that's where better naming comes into play: if
> > there is 'max-' in the name, then the user should not be surprised if
> > they don't actually achieve the max (because the server lacked
> > support).  On the other hand, I could see how you might want to know
> > if you have a mismatched setup ("I think the server SHOULD be
> > supporting multi-conn, so I request multiple clients, and I want to be
> > informed if my expectations were not met because then I know to go
> > reconfigure the server").  Thoughts?
> > 
> 
> Doesn't the "max-" part suggest that there might be anything in between
> [1..N]?  When in reality it's either of {1, min(N, MAX_MULTI_CONN)}.
> But you're right, my initial argument was that this mismatch shouldn't
> go unnoticed as well.  Although I agree that it's part of the expected
> behavior and therefore might not deserve a warning.  Maybe smth like
> info_report() will do?  We might even print it unconditionally, so that
> there's always a way to tell the actual number of connections chosen.
> Somewhat similar to what Richard pointed out at in nbdcopy.

Warnings in QMP are difficult.  It's easy to fail a command, but hard
to print non-fatal messages.  However, I'm not opposed to having a way
to use a QMP query-* command as a followup for the user who is curious
on how many connections a given block export is using (either we can
already query all existing block exports, or that's something that I
should add independent of the new multi-conn setting).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


