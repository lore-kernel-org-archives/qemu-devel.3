Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F63C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9JSX-0000b4-Dq; Wed, 23 Sep 2026 05:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9JSV-0000ab-TH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 05:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9JSU-00072n-E9
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 05:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790156409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/I/CjmEii6JbsbaeawTl3H5SP8kcmfqxA5XbW7i9kA=;
 b=Y7QpUJlIKgsU0gBs3ZE8S9nJBV5nQ+XxBjIn3JW65/8cKB+YAyTIRkJmOW2Joqu4a9ozHS
 y1HPIFYW+4GSCQ6tHHsU7AnprevD/IDD+bGLINcPOaBbeM2+ivgPpY1lrnRQrzXYko2p4+
 XktcPwfM/pv80u5OaQmT/Z4dKYxyoQU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-ydnQAWpzN-KMnMDFYYtFSg-1; Wed,
 23 Sep 2026 05:40:07 -0400
X-MC-Unique: ydnQAWpzN-KMnMDFYYtFSg-1
X-Mimecast-MFC-AGG-ID: ydnQAWpzN-KMnMDFYYtFSg_1790156407
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8FFB1944AAB; Wed, 23 Sep 2026 09:40:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.191])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BC5019539A7; Wed, 23 Sep 2026 09:40:04 +0000 (UTC)
Date: Wed, 23 Sep 2026 11:40:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com,
 hreitz@redhat.com
Subject: Re: [PATCH 00/88] qemu-iotests: migrate away from HMP ("make HMP
 optional" follow-up)
Message-ID: <arOecUpHWrEI5xI6@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> 
> The series is organized as follows: preparatory patches, monitor
> infrastructure, test infrastructure, test migrations, cleanup.
> 
> x-query-qtree (info qtree) is introduced to make test 172 migration
> easier, but arguably, qom-list could be extended instead.
> 
> All migrated tests have been verified to pass.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Argh, noticed only now that the Cc: list is a bit short. Everyone seeing
only this email, please check the series and my reply on qemu-devel (and
add the necessary CCs when replying).

Please don't forget to CC at least qemu-block for v2.

Kevin


