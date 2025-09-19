Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2519DCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 12:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZnR-0005HY-JJ; Fri, 19 Sep 2025 08:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1uzZnK-0005G6-8T
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1uzZn8-0003iV-1d
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758283234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjPVlOX0JGIDw7TxiEhwTNmEnrIRF7fc2on10ERE2uE=;
 b=RT+dz6bCixI8TwnWifhP+VROfi09yDETJRvQtkKUo6vaZfstwlMGgIhZgWhGZdhCiNBodJ
 CICiG5zbbz785qM2H4pLHBdXWylhL0Q5aBxLX9+pOHurDgcgeBoznS7lRt1MnsG047d8JM
 lLoq59ih+45eoA3XAGAKxYMjSNJBpCw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-SYBRWJR3OnS9u_w-4zPiZA-1; Fri,
 19 Sep 2025 07:59:15 -0400
X-MC-Unique: SYBRWJR3OnS9u_w-4zPiZA-1
X-Mimecast-MFC-AGG-ID: SYBRWJR3OnS9u_w-4zPiZA_1758283154
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2CC419560A7; Fri, 19 Sep 2025 11:59:13 +0000 (UTC)
Received: from orkuz (unknown [10.44.34.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EE301955F21; Fri, 19 Sep 2025 11:59:12 +0000 (UTC)
Date: Fri, 19 Sep 2025 13:59:11 +0200
From: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aM1Fj6tpynIz9XHL@orkuz.int.mamuti.net>
References: <aMBDIwKDxTVrBJBQ@redhat.com> <aMCjGVUiM3MY-RM3@x1.local>
 <aMEkY3N9ITwH_Y8Z@redhat.com> <aMGpHBGth05JY2hl@x1.local>
 <aMPz0WFmstNmKBQc@redhat.com> <aMQ19NmgFkLs8jkA@x1.local>
 <aMhZn-fbq67WQX8u@redhat.com>
 <r2tnbymosv7kxj7h4x6mnrczy7jdn66voiodlakivovu7lhwv4@eudkicvqwefc>
 <aMwbAdKQLzLaf4Hd@redhat.com> <aMwg-ROjbDL_z_EM@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMwg-ROjbDL_z_EM@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 18, 2025 at 11:10:49 -0400, Peter Xu wrote:
> On Thu, Sep 18, 2025 at 03:45:21PM +0100, Daniel P. Berrangé wrote:
> > There needs to be a way to initiate post-copy recovery regardless
> > of whether we've hit a keepalive timeout. Especially if we can
> > see one QEMU in postcopy-paused, but not the other side, it
> > doesn't appear to make sense to block the recovery process.
> > 
> > The virDomainJobCancel command can do a migrate-cancel on the
> > src, but it didn't look like we could do the same on the dst.
> > Unless I've overlooked something, Libvirt needs to gain a way
> > to explicitly force both sides into the postcopy-paused state,
> > and thus be able to immediately initiate recovery.
> 
> Right, if libvirt can do that then problem should have been solved too.

I think we should be able to use the yank command to tell QEMU to close
migration connections. I haven't tried it on the destination, but I
guess it should work similarly to the source where it causes the
migration to switch to postcopy-paused. It seems to be an equivalent of
migrate-pause. So can we safely use yank in such situations?

Jirka


