Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D2ACCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 18:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0EX-0000ou-KX; Thu, 23 Oct 2025 14:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vC0EI-0000lC-Fp
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vC0EG-00013e-D3
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761244802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OE2GzXr5qQSTSbnqZC2rcKAienb90UFD+evIex2ItSk=;
 b=HCLSSWKJ919gVAJvtii6e0r40ZDA3haPvMo2Towalw5Kn3vcow3PcrXo70JG8OzVGwelKK
 yAEVuF1YsbSJUiyC7h1FHeGVkpw5W7qwATlBvsP0HvGI/xF5QBcJ0jnL6MFZmYb/o+XSxB
 SzMpGM5HVSYyiWUkefW36pPDJizuLQc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-0PiDcKQbMHyyjFPIdntZXg-1; Thu,
 23 Oct 2025 14:39:59 -0400
X-MC-Unique: 0PiDcKQbMHyyjFPIdntZXg-1
X-Mimecast-MFC-AGG-ID: 0PiDcKQbMHyyjFPIdntZXg_1761244798
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28C0318002F7; Thu, 23 Oct 2025 18:39:58 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.90])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24BA819540EB; Thu, 23 Oct 2025 18:39:55 +0000 (UTC)
Date: Thu, 23 Oct 2025 20:39:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 2/5] vvfat: move fat_type check prior to size setup
Message-ID: <aPp2eRW7gQfv4hT7@redhat.com>
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-3-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903075721.77623-3-chigot@adacore.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 03.09.2025 um 09:57 hat Clément Chigot geschrieben:
> This allows to handle the default FAT size in a single place and make the
> following part taking care only about size parameters. It will be later
> moved away in a specific function.
> 
> Setting a floppy disk of 1MB is no longer possible as it was a side
> effect of passing "fat-type=12". To be precise there were three cases:
>  - fat-type undefined (aka default): a fat12 2MB disk
>  - fat-type=16: a fat16 2Mb disk
>  - fat-type=12: a fat12 1Mb disk

That's quite a strange interface!

If we're touching it anyway, I would change it to make the more common
format (1.44 MB) the default for FAT12 and make the 2.88 MB FAT12 floppy
temporarily unavailable and later require an explicit size. This way
both sizes would still be available using the fat-type.

Please say 1.44 MB and 2.88 MB in the commit message rather than 1MB (or
even 1Mb, which might mean megabit). There were other sizes like 1.2 MB
that are closer to 1 MB, so it's better to avoid that confusion.

> Now, that fat-type undefined means fat-type=2, it's no longer possible

s/2/12/

> to make that size distinction. It will be added back a bit later,
> through the size parameter.
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>

The code looks good, apart from the change I suggested above (making
1.44 MB the default for FAT12).

Kevin


