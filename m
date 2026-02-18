Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DD0E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsozN-0004lc-8P; Wed, 18 Feb 2026 16:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vsozK-0004lK-OI
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:21:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vsozJ-0008Ax-82
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771449693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EvIABBQzc99UkoxR8sSb66bNuVB01SZlF0l8d24BA2E=;
 b=b9AHn9O7WDanmr0Nz/3uOT8X38g+tinTcRnryUS0ZKjx6GQzCB2DT5xzi+xk+e61fOZ99E
 TwpdgecBhw0wnZ3GIFfi5LR9g3jX8W60kyqsER3frL1+l+RzQyCQehkCaU2sSUAdVuQ62B
 xvgBztGQxfF/vuAbub+h85xqSKnfvNg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-jUC3d-INMyu9b-M_xNxH-Q-1; Wed, 18 Feb 2026 16:21:31 -0500
X-MC-Unique: jUC3d-INMyu9b-M_xNxH-Q-1
X-Mimecast-MFC-AGG-ID: jUC3d-INMyu9b-M_xNxH-Q_1771449691
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-506bac14430so29754291cf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 13:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771449691; x=1772054491; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EvIABBQzc99UkoxR8sSb66bNuVB01SZlF0l8d24BA2E=;
 b=hmDJPnYU/zxjX+4JaaDmDGd8hFTB1sL3KzsG4B8C00xhrAnczD9qwUTGvtjsXCHNzs
 Xcxfu4fkdgEx2IluFvlNyBK0xfZ5oSo6GxP+yJjx9WHfK8boODjLCmWP0VfzTYOLM6LO
 dk8x0CcFLXn1gTZ4+Zg8jg8cZg5nbGIYAdzBVBVbjeSr7Q+9JuyLAYU+H5g8B6cxkOcK
 zVZAzw5X3NBhxD/Y5zJDsYJ6tvfOw1Kuxai5x8MbRUGYVzayiOgsO+kumhNulZcWwj+Q
 OPvSYt7wpI1OIDrtmrcklXiGp2QKPiBLiASJBwrL+ewO5XhOpK/gNw2vN9OzF3a1/GHP
 Pw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771449691; x=1772054491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvIABBQzc99UkoxR8sSb66bNuVB01SZlF0l8d24BA2E=;
 b=LkLc70I5r/vGtJsFkhvx7mNuaITAjrvpyBuS5705AvEd8Pc2D920/qosePD8XOx6ql
 N1SigDtan5lf52SfsdrLs8rL6PsfGyxmQ7O/9LS+X0Il5R1DmuLQ0GOpa0xnxNd7LfGU
 S6B7C6Z+n5+bEWChI4IfCyqcFpgWguZcrheltjbQqjzjqxTtObMNa30u9Qq7UFv/FJgo
 654FnHj8PVUhxWOIlcHmRxe3QXm8dYdeEdHBjz6F8nUJFs/0fE57LGPzmx773/9CFaTj
 3itxtpQF+QMOVnPfRVHgondh9NaD+KuuinI/5zNJ+VN8xuwy5RmRelRqFEz1WCkjA6/0
 6Lhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7CB1Jl4U0UtJPtgi8jxv54phpcsGG0o4Zdr1ClSKNbBNwfDnm5lhVIt/5BDY6+KfxVfeHzInFv4LV@nongnu.org
X-Gm-Message-State: AOJu0YwkUc6nbvJBhn2TNH15B8zLmLrSlZeA8KcPv9+XNJ4tzoRUQ8tj
 s1t8JG/ZtwXOJgrBBymsULTeFguV3nEibJbZMl0QWqlan/WuT9W1xPP6jbR7VFYM0mxmeVWMtgz
 avrQ8Nzre9pfBXchdildn7ULQ29Fs9hT9dHONHcOeJaw/31f+5dFdT5sg
X-Gm-Gg: AZuq6aJOlmWv2K1d/SeDtGKib8yjeL91ykjNG+5NBQBFf3KQkeSDlKcwzCX8OukgZcS
 Q4Oq+zbBNafW1rm70kEHBuuWUno26Lui3U9jXt9QUK1vIIoIpO1PtiihG5gru65XrCRLBjwIm5Y
 zsuIo2sBqVS+q2Rp35P8hgACi51VK65qRoWMc2QgrDaQuzS/BRKcfYPKI3ZCBfsGHZe4bbz4Wrb
 ppSVxVpw/HIe4h1EAQTPmO2s/EIoAYs+6dzA74OeKZ9NuzrmiYSLcKEwhO6qpnfM70wXnSjHRi/
 EiUxmZV9BHtxmRe58rgdX5KiB0FEOyVgNfVhQ47Y5iZscMNJQiWRUOkoRnIvzT5+/hlyGlbY74P
 mxSpATk5Zr6uYzA==
X-Received: by 2002:a05:622a:1884:b0:4f1:de1c:dfa8 with SMTP id
 d75a77b69052e-506b3f995dcmr215830701cf.19.1771449691028; 
 Wed, 18 Feb 2026 13:21:31 -0800 (PST)
X-Received: by 2002:a05:622a:1884:b0:4f1:de1c:dfa8 with SMTP id
 d75a77b69052e-506b3f995dcmr215830431cf.19.1771449690538; 
 Wed, 18 Feb 2026 13:21:30 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bd4b95sm190618311cf.33.2026.02.18.13.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 13:21:30 -0800 (PST)
Date: Wed, 18 Feb 2026 16:21:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	Peter Krempa <pkrempa@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 0/2] migration: feature removals for 11.0
Message-ID: <aZYtQLZfhRr61Dvh@x1.local>
References: <20260115225503.3083355-1-peterx@redhat.com>
 <aZQ0q2r6w3OkSP2f@angien.pipo.sk> <87ms17lihr.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ms17lihr.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 17, 2026 at 12:25:20PM +0100, Markus Armbruster wrote:
> Peter Krempa <pkrempa@redhat.com> writes:
> 
> > On Thu, Jan 15, 2026 at 17:55:01 -0500, Peter Xu wrote:
> >> v2:
> >> - Added R-bs
> >> - Updated description for removing zero-blocks [Markus]
> >> - Squashed the "fd: to file" test removal into the 2nd patch
> >> - I dropped the COLO patch, I have a local patch to remove colo migration
> >>   completely, but looks like we won't do it..  Let's leave it for later but
> >>   do the rest first
> >> 
> >> This series removes two deprecated features for 11.0.
> >> 
> >> Please review, thanks.
> >> 
> >> Peter Xu (2):
> >>   migration: Remove zero-blocks capability
> >>   migration: Remove fd: support on files
> >> 
> >>  docs/about/deprecated.rst             | 20 -------------
> >
> > Note that per the 'MAINTAINERS' file, changes to any deprecations ought
> > to be CC'd to the libvirt list for visibility.
> >
> > In this case we've forgotten about the deprecation and didn't fix it
> > before the qemu cahnge was pushed. I'll send out patches soon, but keep
> > in mind to *always* CC the libvirt list with deprecations.
> 
> Review fail (mine).

I confess I didn't notice this hard requirement when posting deprecation
patches.  I definitely kept in mind of libvirt all the time, it's just that
for this one since it used to be discussed well I didn't expect this to
cause any surprise.

> 
> Should we try to make checkpatch.pl catch it?  So far, it doesn't check
> cc: at all.

I don't know if that'll work because logically we can also copy anyone or
lists only when sending patches (e.g. with "git send-email --cc")..

For now, I'll just remember to always copy libvirt list on touching
deprecation file.  My apologize if it caused any unwanted surprise.

-- 
Peter Xu


