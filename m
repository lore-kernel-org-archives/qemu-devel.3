Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E83C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 12:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGe1o-0006QC-FP; Mon, 10 Jun 2024 08:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sGe1m-0006OY-QU
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 08:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sGe1l-0005uk-68
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 08:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718022092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTSVzBm+Wp3x/Oovz18OvsEn024m4Po5w4K0laXhIMM=;
 b=LmAgf/SAdv7M5jaNlxN1wT5Bh01wy8MCchdk5XabtEqJgg+tco0iajKkXSVZ+NgCM9LPMY
 HtSgnPzgsdOCzV+WDm0Za4vwUdVRCMTwRsqqdlf7K0cWYn82s5tgdiov8aHnxNI8PHhgQF
 Cryd+BvqNH4zZJnKuyz/aS07VJd5bLg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-doP2WjSVNUi20M3C675ieA-1; Mon,
 10 Jun 2024 08:21:28 -0400
X-MC-Unique: doP2WjSVNUi20M3C675ieA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02109195608B; Mon, 10 Jun 2024 12:21:26 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.45])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67B8F1956087; Mon, 10 Jun 2024 12:21:23 +0000 (UTC)
Date: Mon, 10 Jun 2024 07:21:20 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [Stable-7.2.12 00/29] Patch Round-up for stable 7.2.12, frozen
 at 2024-06-07
Message-ID: <536dngabqf2dul6gdv6eqlj7w2duofxjtj5bql7x3pmv3okbsu@hdn4duc2tych>
References: <qemu-stable-7.2.12-20240607221018@cover.tls.msk.ru>
 <l6jbovskcivkkog7lkvazwn4f4vqflbilgo63lfgwecunsb4al@iak6kurhbl57>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l6jbovskcivkkog7lkvazwn4f4vqflbilgo63lfgwecunsb4al@iak6kurhbl57>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 10, 2024 at 07:17:53AM GMT, Eric Blake wrote:
> On Fri, Jun 07, 2024 at 10:12:02PM GMT, Michael Tokarev wrote:
> > The following patches are queued for QEMU stable v7.2.12:
> > 
> >   https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2
> > 
> > Patch freeze is 2024-06-07 (frozen), and the release is planned for 2024-06-09:
> > 
> >   https://wiki.qemu.org/Planning/7.2
> > 
> > Please respond here or CC qemu-stable@nongnu.org on any additional notes
> > about the planning release.
> > 
> > The changes which are staging for inclusion, with the original commit hash
> > from master branch, are given below the bottom line.
> > 
> > Thanks!
> > 
> > /mjt
> > 
> > --------------------------------------
> > 01* 690ceb71936f Philippe Mathieu-Daudé:
> >    gitlab-ci: Remove job building EDK2 firmware binaries
> > 02* 7bc1286b81d4 Palmer Dabbelt:
> >    gitlab/opensbi: Move to docker:stable
> > 03* 04f6fb897a5a Michael Tokarev:
> >    linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
> > 04* ae6d91a7e9b7 Zhu Yangyang:
> >    nbd/server: do not poll within a coroutine context
> > 05* 4fa333e08dd9 Eric Blake:
> >    nbd/server: Mark negotiation functions as coroutine_fn
> 
> In addition to these two, we also need the following for NBD:
> 
>  14ddea7e3c81 Eric Blake:
>   qio: Inherit follow_coroutine_ctx across TLS
> 
> and optionally:
>  5905c09466f4 Eric Blake:
>   iotests: test NBD+TLS+iothread

Hmm; I see you did include them for the 8.2.x branch; and the
regression they fix was only introduced in 8.2.  Unless we backported
the work of removing AioContext to 7.2.x, then not backporting these
two that far should not be an issue, after all.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


