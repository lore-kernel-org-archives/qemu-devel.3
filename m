Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313FEC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ssz-0000CK-PB; Thu, 24 Apr 2025 05:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u7sss-0000Ag-FW
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:28:42 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u7ssq-0000Yh-1b
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:28:41 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C21EC4B017;
 Thu, 24 Apr 2025 11:28:34 +0200 (CEST)
Date: Thu, 24 Apr 2025 11:28:34 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Message-ID: <770217162.5044.1745486914133@webmail.proxmox.com>
In-Reply-To: <CAJ+F1C+n-yVHA-u7=MvChwn17bHLY8_XVBiQJOtFAX5pxdbj-w@mail.gmail.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-3-dietmar@proxmox.com>
 <CAJ+F1CLHF0VQHg0JYmaooVRJSZbDkQa01D__iX-5umUcQjJd1Q@mail.gmail.com>
 <1186263082.4663.1745408772058@webmail.proxmox.com>
 <CAJ+F1C+n-yVHA-u7=MvChwn17bHLY8_XVBiQJOtFAX5pxdbj-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] add vnc h264 encoder
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev75
X-Originating-Client: open-xchange-appsuite
Received-SPF: pass client-ip=94.136.29.106; envelope-from=dietmar@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> > > > +void vnc_h264_clear(VncState *vs)
> > > > +{
> > > > +    if (!vs->h264) {
> > > > +        return;
> > > > +    }
> > >
> > > unnecessary
> >
> > This is required. For example if you disable h264, vs->h264 is
> > always NULL, and we unconditionally call vnc_h264_clear().
> >
> > Why do you think this is unnecessary?
> 
> and there are already checks for NULL, no need to do it twice, do it
> where it is actually necessary.

There is no check in destroy_encoder_context(), so this will generate a core dump.

So what do you mean by "where it is actually necessary"?

The final code looks like:

void vnc_h264_clear(VncState *vs)
{
    // Assume we remove this check ...
    // if (!vs->h264) {
    //    return;
    //}

    // will trigger a core dump
    notifier_remove(&vs->h264->shutdown_notifier);

    // will trigger a core dump
    destroy_encoder_context(vs->h264);
    // will trigger a core dump
    g_free(vs->h264->encoder_name);

    g_clear_pointer(&vs->h264, g_free);
}

Where do you want the check for NULL exactly? At the call site?

- Dietmar


