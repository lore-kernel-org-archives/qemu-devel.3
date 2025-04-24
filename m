Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35359C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 08:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7sBA-0000pG-4d; Thu, 24 Apr 2025 04:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u7sB7-0000oz-To
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:43:29 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u7sB5-0003rs-9Q
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:43:29 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 394314AF87;
 Thu, 24 Apr 2025 10:43:22 +0200 (CEST)
Date: Thu, 24 Apr 2025 10:43:21 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Message-ID: <743571755.4920.1745484201214@webmail.proxmox.com>
In-Reply-To: <767155443.4848.1745479933168@webmail.proxmox.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-3-dietmar@proxmox.com>
 <aAjcSnT_zYnuOG2W@redhat.com>
 <767155443.4848.1745479933168@webmail.proxmox.com>
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


> On 24.4.2025 09:32 CEST Dietmar Maurer <dietmar@proxmox.com> wrote:
> 
>  
> > > +    gst_object_ref(vs->h264->source);
> > > +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->source)) {
> > > +        gst_object_unref(vs->h264->source);
> > > +        VNC_DEBUG("Could not add source to gst pipeline\n");
> > > +        goto error;
> > > +    }
> > 
> > If you put the gst_object_ref call after sucessfully calling
> > gst_bin_add, then it wouldn't need the gst_object_unref call
> > on failure. Repeated many times below.
> 
> Gstreamer docs claims that gst_bin_add() takes ownership of the element. So I assumed that it unref the element in case of error.
> If I do not ref the object before, this would free the object too early.
> 
> But a look at the source code of gstbin.c reveals that it does
> not unref the element in case of errors, so your suggestion works.
> I will change that in the next version...

From the gstreamer docs about refcounting and gst_bin_add:

https://gstreamer.freedesktop.org/documentation/additional/design/MT-refcounting.html?gi-language=c#refcounting1

> As soon as this function is called in a Bin, the element passed as an argument is owned by the bin and you are not allowed to access it anymore without taking a _ref() before adding it to the bin. 

This clearly states we should taking a _ref() before adding it to the bin?


