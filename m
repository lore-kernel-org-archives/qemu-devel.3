Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C27FC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wok9H-0005Jg-OG; Tue, 28 Jul 2026 11:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wok9G-0005JH-Bs
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wok9E-00060X-Hm
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785254115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t+Wr8o26eKVo3iuDutsiE6EDvAwl5wgH61wZ6LkIVzw=;
 b=RXoP38fpDc99pHfvaBLphjMzMit68rVPZEQ4ETOKHeFpXXAZPBB6CVz825AGRtfC3QTxhO
 ax8nGmlyulOpDayY0rewhCdsZVuRyK1gU6AhCvFIc/vF0GeqZwAGzCKrNqd+5Sc7ks1Rtr
 LW2DxB8ilZUzD/Xm7/LZX1U7eIbPPF4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-ATdZ_BSZN9eTBpyJzvJbNQ-1; Tue,
 28 Jul 2026 11:55:12 -0400
X-MC-Unique: ATdZ_BSZN9eTBpyJzvJbNQ-1
X-Mimecast-MFC-AGG-ID: ATdZ_BSZN9eTBpyJzvJbNQ_1785254110
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7875519560A2; Tue, 28 Jul 2026 15:55:10 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.201])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A10D5300019F; Tue, 28 Jul 2026 15:55:07 +0000 (UTC)
Date: Tue, 28 Jul 2026 17:55:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Christian Quante <christian@quante.one>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 PC-DOS repro <chrischaan66@googlemail.com>
Subject: Re: [PATCH v2 0/2] hw/block/fdc: do not claim a diskette that is not
 there
Message-ID: <amjQ2TmHqDPFUm2r@redhat.com>
References: <20260710113134.43012-1-christian@quante.one>
 <20260714164031.60551-1-christian@quante.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714164031.60551-1-christian@quante.one>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Am 14.07.2026 um 18:40 hat Christian Quante geschrieben:
> From: PC-DOS repro <chrischaan66@googlemail.com>
> 
> Kevin, thank you -- that was a far closer read than I expected for a floppy
> patch, and all three points were right.
> 
>   1/2  The SET_CUR_DRV() omission you spotted.  It is real: every other
>        handler latches the drive from fifo[1], READ ID does not, so it
>        answers about whichever drive was selected last.  A DOR write
>        normally selects the drive as a side effect, which is why nobody
>        has tripped over it.  It goes first because 2/2 checks the medium
>        of exactly that drive.
> 
>   2/2  The main change, now with the fd_seek() return code you suggested
>        instead of a second blk_is_inserted() in the caller.  Nothing made
>        it harder than it looked -- but it does drag fdctrl_format_sector()
>        along, because a new return value would otherwise fall through its
>        "default" and let FORMAT TRACK carry on as if nothing happened.  So
>        FORMAT on an empty drive now answers ST1.MA as well.  I could not
>        get a guest to reach that path: DOS gives up during media sensing
>        and never issues the command, and a hand-written FORMAT TRACK needs
>        the per-sector data phase to get there at all.  It is the right
>        answer semantically, but it is untested on a guest, and I would
>        rather say so than bury it.
> 
>        The test comment is fixed too -- it claimed the preceding tests
>        leave the drive empty, which is exactly the dependency you object
>        to.  The two tests now stand on their own; the wider ordering
>        problem in fdc-test I left alone, as you asked.

If you feel like addressing the wider ordering problem in the tests,
too, you're welcome to do so. I just didn't feel it was fair to require
you to clean up unrelated existing code before I would merge your fix.

> Measured, empty 1.44M drive, INT 13h AH=02h on A: (SeaBIOS 1.17.0):
> 
>   before      0.11 s, AH = 0x20 (controller failure)
>   after       0.21 s, AH = 0xC0 (no media)
> 
> The extra 0.1 s is SeaBIOS working through the data rates now that READ ID
> no longer succeeds on the first try.  Booting from a hard disk is unchanged
> -- the drive is not touched at all -- and no guest changes what it shows:
> DOS shows the same message for 0x20 as for 0xC0, and Windows 3.11 and
> OS/2 2.11 show exactly what they showed before.
> 
> A SeaBIOS series is on its list [1] that probes the disk change line before
> media sensing; with it, the same read takes 0.11 s and answers 0x80 ("not
> ready"), which DOS and Windows both render correctly.  The two are
> independent -- neither waits for the other.
> 
> [1] https://mail.coreboot.org/archives/list/seabios@seabios.org/thread/K2QGADPOTAEEZRQS5T6PKZLDQUBO62HY/
> 
> Christian Quante (2):
>   hw/block/fdc: select the drive named by the READ ID command
>   hw/block/fdc: report a missing address mark on an empty drive

Thanks, applied to the block branch (though I took the liberty to add
the new return value 5 to the fd_seek() comment while applying it).

Just in case it might be useful to know for you another time, I'd like
to mention that the convention for QEMU mailing lists is that new patch
versions are posted as new top-level threads because they won't be
missed as easily then. But not a problem for this one.

Kevin


