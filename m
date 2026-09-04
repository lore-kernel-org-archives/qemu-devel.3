Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029E8C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2VJF-0006nz-Kz; Fri, 04 Sep 2026 10:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2VJD-0006nh-Ex
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2VJ3-0006IG-BX
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788533654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qeup7lIFeKt+qmNA/WxigICq4PQyCa6KaSJKHGuBz5s=;
 b=AJB9NyMtXZNkWmzWzsyNcdAMsiOMIc1uxy1oALDitXh7ppSR6Gwm7Xo5GsZfLF5aGOehF8
 QgC9SbP3A1YLZbHvE5KnMPdVJw+ZWAhv38bbsEXcTL3x3VOFrx9Frc0NQsiXmtfoRLVV1p
 VJzxkzWgoOiZqM+MPxjBlGMYR9N2xAg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-WhJ6r_dRP5WBBT8uAMVMDg-1; Fri, 04 Sep 2026 10:54:13 -0400
X-MC-Unique: WhJ6r_dRP5WBBT8uAMVMDg-1
X-Mimecast-MFC-AGG-ID: WhJ6r_dRP5WBBT8uAMVMDg_1788533652
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so182713585a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788533652; x=1789138452; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qeup7lIFeKt+qmNA/WxigICq4PQyCa6KaSJKHGuBz5s=;
 b=pACZVbNAAXQom5NzCxmJdvT+FpEcojgLuFjl8sfxWfbpVtohsiSppS6RFKyH5qDeWD
 pHqvOpz7fE8wekofIDUIWaRU8GJK2y4jykcgcohQ15Up3zgj5dgPzvdPjFZbxY0ai5U2
 Lr71vq/IHgvlnEuL+oNNXbvrmsMvMu7ZtxaCFkhBT7TGkA7sHInmPe5eTFae2Osdzi8w
 peBpcnwFQ6/9NQ3C+dL9GN6w6h7hWYX7e2BGbzss7GV8i2OggIoExnaFsbrMkD0vIUj+
 N4lACKPsfUotnQ82nlu4poflaboivO9wOzhj5Du4cwv58eRzfl1b9i9KpcXY8PlSB4eA
 mPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788533652; x=1789138452;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qeup7lIFeKt+qmNA/WxigICq4PQyCa6KaSJKHGuBz5s=;
 b=sIdOxjh8cL5dB0KpxHtd5PRZ1L8iE1/+jDKbLuAwy5lKaS7lFBg+PQuGZcCVYb1To+
 Eia6N3Htb2GpSfvtOFk4eZSjVtdFgkd+/+GnUTOrrT9VCEZAiyPeZsNGRobE8UmAGURx
 6PbEya1DTEdanr+rGLlqL2j6E0TKUKs183l1ulH2Q8ftinXD9gU0sUtiZRr2Qu3onDQA
 TPOswBYsEPzc9X+mhSM2M0Z8D4S8ZKsQLH8b0zg4bYnbpdYqUdVo6IzPTVhOBtMYntu6
 cUtUbcFPA+EB6mIoF/8J90eBd1BKLy994/oFAzjq634zQq0nAjZd3BZbxmwXjEDYBz1V
 xGhw==
X-Gm-Message-State: AFuF++lm77JT3+f7IoTrF0QZyuL3d41a/NbRxzyj8wcejr0mEeBSBQ49
 qZStTI/5Ov56pMNRxY1i86jEfrX70i5plNmnItdiYV7tNH/GVYI2LIyQuVLABP0v78EpEGhMF8r
 iCi9lqTNvvn4F8tYu18ikV0nQfzufH+dbX/0ZSCGe5uCyl4c+1LRhJ1v8
X-Gm-Gg: AYBFou398Kc7qrY/Pj2bhfed/Eu7j4p1HSkmpw8Jh8JzXDguLZVMWzOzYcH2DtfCDav
 9WHJSutMgtYdH7wEw9EV5KEcX6YZfP212++Ip6md84nNB+kBTbgdJOmxYDsYScH8TzAyHnXwfNe
 3xjuM27FUe0jr8D1Ezmabnq8dmYHT6uG/6BLhem+MI67dXapQJ7xCyINiq8OrF7OvD/THn8tCMU
 lR+QCU8s9pN6WkdNCc1nP9ZDzviTqZCC80xkQIJIIApeLzd7Sezjj/s2ELXGgm2dOmx+LZfvsVg
 cQM76jH5uNkF04y0Yb7vUii0l992HyY/l7OCrRJz21CHoFITmZTcTSmMDxw1Ogb7rGSg
X-Received: by 2002:ae9:ee06:0:b0:936:e938:b07a with SMTP id
 af79cd13be357-9398032898bmr490662185a.8.1788533652366; 
 Fri, 04 Sep 2026 07:54:12 -0700 (PDT)
X-Received: by 2002:ae9:ee06:0:b0:936:e938:b07a with SMTP id
 af79cd13be357-9398032898bmr490657185a.8.1788533651808; 
 Fri, 04 Sep 2026 07:54:11 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fba6955sm226213585a.38.2026.09.04.07.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:54:11 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:54:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 13/18] migration: Use output visitor in info command
Message-ID: <aprbiKXh1WyHCWpN@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-14-farosas@suse.de>
 <apqzsh7pIkmKTYYg@x1.local> <87zexx6sn2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zexx6sn2.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 04, 2026 at 10:41:21AM -0300, Fabiano Rosas wrote:
> >> +    case QTYPE_QBOOL: {
> >> +        QBool *b = qobject_to(QBool, obj);
> >> +        if (b) {
> >
> > Similarly, I'd drop "if" if it will always happen, making qbool_get_bool()
> > assert itself by deref.
> >
> 
> I'd rather not have such asserts in user-facing code. Even with testing,
> it's hard to ensure this 'obj' will reach here in integrity.

Not a big deal here, but just for sake of pure discussion..

IMHO it's not the "user triggerable path" that we are avoiding assert()s,
but user input that may affect the result of the assert().

Here if we just checked obj type is QTYPE_QBOOL, I can't see anything that
can make this if not true.

I still think assert() good guarding programming errors.  Say, if something
we wanted to print here but skipped, I want it to crash hard, rather than
silently ignored.

-- 
Peter Xu


