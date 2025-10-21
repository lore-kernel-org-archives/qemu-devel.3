Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24172CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBFV6-0004t7-IE; Tue, 21 Oct 2025 12:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBFV3-0004qy-IR
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBFUw-0006HA-2q
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761065166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AzRP4UE4x2i42tkYuAIFxAxVrgvsUNqfvgXWIwpGOwQ=;
 b=H0dnLl6N7ZUHjuAFQ4WvEON6S21CyBPVEzRGmmYspbuwZlQJFMDBqRwC5UdT4kJG3gjz8U
 q04wO6qzXJSRJpL2XP9c1rUFWd/N5iVyGkJDjGSBeS+Q/f6WdQBYj3EfTvfq7VMPszTa9U
 2G6eSxPPdQYyzpLSjuihkxaV3DjkJIE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-Co0atSguOhqJYfisuYrHfQ-1; Tue, 21 Oct 2025 12:46:05 -0400
X-MC-Unique: Co0atSguOhqJYfisuYrHfQ-1
X-Mimecast-MFC-AGG-ID: Co0atSguOhqJYfisuYrHfQ_1761065164
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e8b686eb3dso3101751cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761065164; x=1761669964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzRP4UE4x2i42tkYuAIFxAxVrgvsUNqfvgXWIwpGOwQ=;
 b=Co57ZilWyNkvYGKJSHaB47v3A6AOWHJYjrEbgWEDf+v4pzUUsE3/YG177NWzJ0G5+n
 cz2W1C5u9gdqNN79ez+u79P3E5s4WuBruvqoAehYnTBIWUZMOa4bvb096qIgNphtSYqa
 Oxhn/1NGuZu9zXu66wkVmy7juLN4+3ujeOt8u+xINhhNCw/+tUERe+wq+USuZXelQFRx
 bBaYfvbJA4U+zLyKul+AAooAg1NvxdNytHMfJTiQGzPHpMUmb0RlQRvOeUUX7tYEEsKp
 O1GGnfQXiyH+DJfbIGLewpZDBEGrCuKXgUnudhd+7Q0yWRJ4X74YegKqIejDcG14bMi8
 7mtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe36iTv+CK6XD9Rro2O95Nwetsp8bFc7N1zn9RSwG33l0m2FlhMyYRBCTpHuiChUN30jtPWxPAqWEC@nongnu.org
X-Gm-Message-State: AOJu0YyUcadIu8/2SNu98gOUQ6XX9ABz8pPlmppX/m08i3A6Pf6Sg/Q4
 XByrrhJ7JCQOSHLVSLrCojod+ehrbS4UFGwylqXF7W7ZC8mSXurfemei0tuRpw2nI2tG/5y2rrc
 0kZplO2UXrA10cwZ83pKFBMhIRcnAKCaiQ9sYmVrvbyXEFjq2rtpWt/Yk
X-Gm-Gg: ASbGncvYgHUMTJGNAzm4O4V9rTM+nPkhugWcN9SlJG8bATHnJoo2L3Sjx0dW2LhKnVa
 /hKlXKzKCvu4WtPvYuqGzsmdZl9lf7mfFPGLjJZgbzb5o0sMvJLmrztm3lWNO44PWJd7lVIDNBt
 DbOjPvyE+7yqVf15LNDuys90773Pb+vf7sis6z6uZhREeOmtUBQQThpx+JZiI3YfWOCBlG1G/NZ
 6VIDTBLVpdxAK7R0J5FpzgL4R4wOY/VfF3IOiZzv02EwTKT72OjN1rDcZpXVdXselOvzGGlL47W
 2TI0NocpqP44HbBlUK+838VtB12U+KV5oALMZYwGj2ni9N1PFFkT8FrWQLDuodV1TNE=
X-Received: by 2002:a05:620a:2589:b0:84e:3e97:fb0c with SMTP id
 af79cd13be357-8906e4ba3dbmr2253214285a.17.1761065164439; 
 Tue, 21 Oct 2025 09:46:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF40VvXhd1M1cPKUzctX3V4kC4Q5DOsW0LWk7bA6DJiE/mgHmQAla7z9OqrEbCZcP4L1NsUmw==
X-Received: by 2002:a05:620a:2589:b0:84e:3e97:fb0c with SMTP id
 af79cd13be357-8906e4ba3dbmr2253209685a.17.1761065163905; 
 Tue, 21 Oct 2025 09:46:03 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cc8d5da1sm801309585a.10.2025.10.21.09.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:46:03 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:46:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PULL 02/45] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aPe4yBqkPTiDiYXq@x1.local>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-3-peterx@redhat.com>
 <CAFEAcA_230hx7mFzo=jT07heROTvjO=q7B4B73+gO_KneC6EuA@mail.gmail.com>
 <aPex9SsQOup69DRI@x1.local>
 <CAFEAcA85DRf5918ea9N66+Z7M_vVGNy+-SdSx17E5MGOf_cbMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA85DRf5918ea9N66+Z7M_vVGNy+-SdSx17E5MGOf_cbMA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 21, 2025 at 05:21:44PM +0100, Peter Maydell wrote:
> On Tue, 21 Oct 2025 at 17:16, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Oct 21, 2025 at 04:43:52PM +0100, Peter Maydell wrote:
> > > Do you have plans for further cleanup/extension of the
> > > use of Error here that would let these functions pass
> > > the Error back up the chain ?
> >
> > It would be non-trivial though as we'll need to change VMStateInfo.get()
> > API and that'll be another lot of churns.
> 
> We could at least do it in stages, so we add new fields
> .get_err and .put_err that have the new API with Error*;
> the calling code in migration/ uses the new functions if
> they're non-NULL, otherwise falling back to the old ones.
> Then we only need to update the implementations which
> want to be able to return an Error. (This is the same sort
> of thing we have with MemoryRegionOps and its read/write
> vs read_with_attrs/write_with_attrs methods.)
> 
> The downside is we end up with another "there's two ways
> you can do this" API.

Right, the other thing is get()/put() logically should only be used for
primitives...  I wished they're never used in complicated ways.

IOW, in an ideal world, get()/put() should only fail because of qemufile
channel errors, rather than anything else.

Then, descriptive errors for get()/put() may not even be needed..  OTOH,
complicated structs (like virtio_gpu_load...) should really be done in
VMSDs already, and anything can fail outside -EIO should be done only in
pre_save() / post_load() / ...

-- 
Peter Xu


