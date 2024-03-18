Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B36C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmBZF-00081H-CO; Mon, 18 Mar 2024 07:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmBZE-000818-M3
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmBZA-0002Fj-Mz
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710762845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RK6/ZpyUIpklykF27CrP8/IcJR4+w72uv+cR4qPjBNg=;
 b=dxAwSFO70NU7y0QZSVXn13H3v5/bvER6SxsyvfxSAamgXbSyUa6fM1iAWip8zxaLG3hsnM
 cwdriZJfW6bl0JM97gg9zIFdiP96ck08EEfyDT1r0CmKrJh62rVpQ5S30tcxRVhmcntK+y
 neWN/2yoK4NFhQ4On8eHof6ai6g2B9E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-CPUrz0m5MTye2jm7mJ9JUQ-1; Mon, 18 Mar 2024 07:54:04 -0400
X-MC-Unique: CPUrz0m5MTye2jm7mJ9JUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02E4D101A552;
 Mon, 18 Mar 2024 11:54:04 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A42B1C060A6;
 Mon, 18 Mar 2024 11:54:03 +0000 (UTC)
Date: Mon, 18 Mar 2024 12:53:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Abhiram Tilak <atp.exp@gmail.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com
Subject: Re: [PATCH v4] qemu-img: Fix Column Width and Improve Formatting in
 snapshot list
Message-ID: <ZfgrVsVSnHVUARcp@redhat.com>
References: <20240123050354.22152-2-atp.exp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123050354.22152-2-atp.exp@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 23.01.2024 um 06:03 hat Abhiram Tilak geschrieben:
> When running the command `qemu-img snapshot -l SNAPSHOT` the output of
> VM_CLOCK (measures the offset between host and VM clock) cannot to
> accommodate values in the order of thousands (4-digit).
> 
> This line [1] hints on the problem. Additionally, the column width for
> the VM_CLOCK field was reduced from 15 to 13 spaces in commit b39847a5
> in line [2], resulting in a shortage of space.
> 
> [1]:
> https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L753
> [2]:
> https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L763
> 
> This patch restores the column width to 15 spaces and makes adjustments
> to the affected iotests accordingly. Furthermore, addresses a potential
> source
> of confusion by removing whitespace in column headers. Example, VM CLOCK
> is modified to VM_CLOCK. Additionally a '--' symbol is introduced when
> ICOUNT returns no output for clarity.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2062
> Fixes: b39847a50553 (migration: introduce icount field for snapshots )
> Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>

Thanks, applied to the block branch.

Kevin


