Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9DDCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 12:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZxI-0002LF-7h; Fri, 19 Sep 2025 08:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1uzZxE-0002KN-IC
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1uzZx7-00009R-BW
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758283853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWXPXCatnOeGtIDVAYIXLZO6xd+LhHRO1JCYs2sEt8U=;
 b=bxgnFJcJ3ytFlujk8eQ03Q5JIJ60nT+EmUJiRp50WICPfFc1gnV4BXbT2p67WxmT/xc7mF
 cSt5pn7NfoBJJ2h/9/ojgGsQ+o5sa+BedlHxzQqT0XXR7yfrtgTHzW4mFcJ6HHarXUjOfT
 KJt4v8LInWnZT5ZR+pXmXs8905fmxmU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-fdCYtzqINc63qycnzomurQ-1; Fri,
 19 Sep 2025 08:10:44 -0400
X-MC-Unique: fdCYtzqINc63qycnzomurQ-1
X-Mimecast-MFC-AGG-ID: fdCYtzqINc63qycnzomurQ_1758283843
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F6231800359; Fri, 19 Sep 2025 12:10:43 +0000 (UTC)
Received: from orkuz (unknown [10.44.34.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CC7830002C5; Fri, 19 Sep 2025 12:10:42 +0000 (UTC)
Date: Fri, 19 Sep 2025 14:10:40 +0200
From: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aM1IQDFNnXe89NaI@orkuz.int.mamuti.net>
References: <aMEkY3N9ITwH_Y8Z@redhat.com> <aMGpHBGth05JY2hl@x1.local>
 <aMPz0WFmstNmKBQc@redhat.com> <aMQ19NmgFkLs8jkA@x1.local>
 <aMhZn-fbq67WQX8u@redhat.com>
 <r2tnbymosv7kxj7h4x6mnrczy7jdn66voiodlakivovu7lhwv4@eudkicvqwefc>
 <aMwbAdKQLzLaf4Hd@redhat.com> <aMwg-ROjbDL_z_EM@x1.local>
 <aM1Fj6tpynIz9XHL@orkuz.int.mamuti.net>
 <aM1F4vGh86vq0MW3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aM1F4vGh86vq0MW3@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
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

On Fri, Sep 19, 2025 at 13:00:34 +0100, Daniel P. Berrangé wrote:
> On Fri, Sep 19, 2025 at 01:59:11PM +0200, Jiří Denemark wrote:
> > On Thu, Sep 18, 2025 at 11:10:49 -0400, Peter Xu wrote:
> > > On Thu, Sep 18, 2025 at 03:45:21PM +0100, Daniel P. Berrangé wrote:
> > > > There needs to be a way to initiate post-copy recovery regardless
> > > > of whether we've hit a keepalive timeout. Especially if we can
> > > > see one QEMU in postcopy-paused, but not the other side, it
> > > > doesn't appear to make sense to block the recovery process.
> > > > 
> > > > The virDomainJobCancel command can do a migrate-cancel on the
> > > > src, but it didn't look like we could do the same on the dst.
> > > > Unless I've overlooked something, Libvirt needs to gain a way
> > > > to explicitly force both sides into the postcopy-paused state,
> > > > and thus be able to immediately initiate recovery.
> > > 
> > > Right, if libvirt can do that then problem should have been solved too.
> > 
> > I think we should be able to use the yank command to tell QEMU to close
> > migration connections. I haven't tried it on the destination, but I
> > guess it should work similarly to the source where it causes the
> > migration to switch to postcopy-paused. It seems to be an equivalent of
> > migrate-pause. So can we safely use yank in such situations?
> 
> Can't we use migrate-pause on the target too ?  IIUC that was what Peter
> was suggesting earlier in the thread, unless I mis-interpreted ?

Ah ok, I missed that. Somehow I interpreted "Libvirt needs to gain a way
to explicitly force both sides into the postcopy-paused" as "QEMU needs
to allow us to do that" :-)

Jirka


