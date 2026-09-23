Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A0BC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9JPe-0008IT-BQ; Wed, 23 Sep 2026 05:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9JPc-0008Hw-Bu
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 05:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9JPW-0006I0-PE
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 05:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790156224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ZjAkEeZAbhZxdljbETtqvpPguwxO3XhtgFUUOV5LIY=;
 b=Cb4QxwhpR6tWddRV/pYeJTQoGFNt7d9XOGVH5K1PMLTZWvVI8gOE5gLaRvRctrv6Kh/Hom
 DiUEZqk0WTo/PVQb7Km67S6g2hnAUR+Id0BL86fzEl+SWJJuCFCqRCKHOM7eJW+cldxj9E
 JX/eB8Fb0V152eK4DO2wISz1/Hfnn5U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-Af3FHIDtPQmLF-81uP9l3Q-1; Wed,
 23 Sep 2026 05:37:02 -0400
X-MC-Unique: Af3FHIDtPQmLF-81uP9l3Q-1
X-Mimecast-MFC-AGG-ID: Af3FHIDtPQmLF-81uP9l3Q_1790156221
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AE6C18E4C06
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 09:37:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.191])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE2B6300106E; Wed, 23 Sep 2026 09:36:59 +0000 (UTC)
Date: Wed, 23 Sep 2026 11:36:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 00/88] qemu-iotests: migrate away from HMP ("make HMP
 optional" follow-up)
Message-ID: <arOdsxWtfLiZ6Y80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 22.09.2026 um 22:17 hat Marc-André Lureau geschrieben:
> Hi,
> 
> This series migrates all qemu-iotests away from HMP, so that the test
> framework no longer depends on it and can execute with --disable-hmp.
> This can simplify the tests, as they don't need to check/grep on stdout,
> HMP & QMP but can rely increasingly on QMP alone.

Hm... Doesn't this mean that HMP loses all of its test coverage? I don't
feel that's a good idea.

Most tests are based on diffing stdout anyway, so I don't expect this
removal simplifies them much. I'll have to look at the individual
patches, but I'd rather expect that their output becomes harder to read
instead.

What are the general plans with HMP? Are we expecting most builds to
have HMP disabled in the future? (Why? It's useful for human users.)

I think most tests probably combine testing the HMP interface with
testing the backend functionality. If we really expect missing HMP to be
a relevant case in the future, these parts need to be separated so that
the backend test can run with QMP only while the HMP interface tests run
only when HMP is available.

Not sure how this is best done without effectively running all tests
twice. Maybe there is a middle ground of converting some tests to QMP
and making other tests explicitgly depend on HMP (i.e. they are skipped
if HMP isn't available).

Kevin


