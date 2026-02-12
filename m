Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB85EE369D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZK8-0003jG-ON; Thu, 12 Feb 2026 11:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vqZK7-0003iV-21
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:13:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vqZK4-0004Oa-Qw
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770912824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qxRDiqOp8sEc82mKqb+v+alscojNLkbpICLjXo+Qe8=;
 b=Eta6QzVXSYBAQXYWTrTHBHcVlLuPC9kDAmsjgn/yMXrQEONYYd7Bpo7HO40QDDmSW/pgG0
 c4PyvdS/z67LeYcbFFSHpEeE/ADw5Ax410B2BvkBit5rbSCWlvYA17hK7U3bWMZ799crY0
 de1zsHkaP+TjLyS4wT156IJhOFmsM10=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-zvDd4tyxMrOnAevFvvr7tA-1; Thu,
 12 Feb 2026 11:13:42 -0500
X-MC-Unique: zvDd4tyxMrOnAevFvvr7tA-1
X-Mimecast-MFC-AGG-ID: zvDd4tyxMrOnAevFvvr7tA_1770912821
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BB10180025C; Thu, 12 Feb 2026 16:13:41 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B34D18004AD; Thu, 12 Feb 2026 16:13:40 +0000 (UTC)
Date: Thu, 12 Feb 2026 17:13:36 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/3] scripts: render_block_graph: Fix with new python
 and improve argument parsing
Message-ID: <aY38MKbJjn7il_hc@angien.pipo.sk>
References: <cover.1770108741.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770108741.git.pkrempa@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 03, 2026 at 12:46:04 +0100, Peter Krempa wrote:
> New python doesn't like '\l' escapes from the 'dot' language.
> 
> While at it improve usability of the script by employing proper argument
> parsing.
> 
> v3:
>  - rebase + resend
> 
> v2:
>  - use mutually exclusive group instead of hardcoding it (Pavel)
> 
> Peter Krempa (3):
>   scripts: render_block_graph: Fix invalid escape sequence warning with
>     python 3.12
>   scripts: render_block_graph: Implement proper argument parser
>   scripts: render_block_graph: Avoid backtrace on error from virsh
> 
>  scripts/render_block_graph.py | 80 +++++++++++++++++++++++++----------
>  1 file changed, 57 insertions(+), 23 deletions(-)

Ping?


