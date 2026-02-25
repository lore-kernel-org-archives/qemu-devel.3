Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3394F55431
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 00:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv2eu-0001HJ-Ia; Tue, 24 Feb 2026 19:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vv2es-0001GJ-HQ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 19:21:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vv2eq-0006nP-JW
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 19:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771978899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/s/PaW4MYf5IzG0M0sXyXa6JNRZ5wSLMUMYvLvRnbs=;
 b=E+rChYtr2Cv8MmllNWKRKJnF83KnkQs3UQkRd24boDnUu5o6Bp1KEWRElINOySoeV4BvUi
 LAywOw/NNnCyjZu7RvUzDvbLUL0xV0uwbRFvDZfGr3acm4pUHvOIu5p/XwaeV1K3gbCeDA
 ByPKO9nuGLrUvTvhKMXmkZcUQI82SkQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-uTOzaTo9M_edkuAOH9cQbA-1; Tue, 24 Feb 2026 19:21:37 -0500
X-MC-Unique: uTOzaTo9M_edkuAOH9cQbA-1
X-Mimecast-MFC-AGG-ID: uTOzaTo9M_edkuAOH9cQbA_1771978897
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso15490365e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 16:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771978896; x=1772583696; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G/s/PaW4MYf5IzG0M0sXyXa6JNRZ5wSLMUMYvLvRnbs=;
 b=fnkDJ+7dpA0h9vZVGNrtS84wvUzkPjICj2ha9pST3W0o1N63UrsevnpKvPZDHO62M8
 NzfcCKue1DKYCmsYW7GUYAnmj32yw+EkHlZbWsSriseF263gM62D1GEcDB3ztepVFj5J
 68EB/WNXKdVfOih2xkgH2L7+7kTO/K3l6sSZ+h04jDnvnWsIo/EJ42TzuqcikDfcgDmU
 HDeqs75C9fBB8sCzyU9rIX95vp3dAGQVVyp7ZZJw4v9sdKNdrV5eMYQAgN9Xjbcp9O48
 gJNIMBCSoAJARE1l6TBG+xB7K03e8yQw+TXIaQ/pnvk0g1ffNzO4t2AhCpzllEnt6t02
 8Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771978896; x=1772583696;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G/s/PaW4MYf5IzG0M0sXyXa6JNRZ5wSLMUMYvLvRnbs=;
 b=NVRDtmnTQ8swYPoHviRc/8ztYOSgu0MVwJVwh5wgpgXiGPfnEo8wGZnJW9YusM4tbh
 eEvm9yUy5fluWzH78rkCICYKkf2euGoIzPX/a5IUY+GZ4svyOlw8Gvr/VadrYhfcHExO
 VoL/x7xv4o64ofdsAlBrFnz23NEhoRywrw6XYXPfqHh5TyHBZhjyTXoVCzXuGQyJNBwy
 jtyhQn34ciPmezfu5rjckNOTXqPjDPaV8Tpj7Tj0IyjODaYOEj0mAfmILIHG4d7hfT3b
 PwcG8NCxAaXcT++JOLOHrjdY6fkxbZ/N8xPRLvoHt/xHtRJOAbuhAQ3hoWEI50y1WBSp
 dueQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyx5PNvpbNYw1ZisUEHWCeSI9+zpQQ5/comjr3XDNhyZBN4gSWAsmqqV/JHYcjKOD9pv1FuB8xtLHN@nongnu.org
X-Gm-Message-State: AOJu0Yy6md6VN4NUlMiZ/ZzThsP+xlxmA/qLNKlxShc65iYVcUMNdiQi
 ioYB8sgPgrgJdwL3mMrqy3IX/QPvW/M8qcYL0CjmEInSBaltSv48TtaxpK/i0SfvR5SvimeLoot
 F5/A4bo8Yvixa6P5AEKiu5hEZG5aewbFs/JDgyr+VjlNU4/pvnYGp0RBn
X-Gm-Gg: ATEYQzzUmhS+uLiz4dU+rRKXzE10yDupMnqNsM7WJCESNRXvqcAUHzhHxGybaAqsQ2c
 85ztuB11PxDEd8Xk400vgDcJvVDDkbFcTbXcBJg52WxouYzZzc6F/0O9twSg5qwg+Q4bFXYmwB4
 spIhGuuA38i+T8EKrC7Rv9TsFV0fWSukszo49sNZpdRnrA/qP0cfuf+rwDralQrHV3Nd9CAOJ0m
 H5UIYKUWC4UxSmNCmLiVbcKmwc5KzyBztlBBY7dcp7RsQeJ/lopmzsfTPsXRZvnq9mhUzLh7iVQ
 byMZdMaDyz6o1WmK14xjpLvTpeACImuOlPZZemxfm4iitJBWV5NZrRBKCVbDd4S7mppkOjCggGo
 KKd7UZJgZjc230gcY4XOEp6WAxVtDT9xyHN89zfRDDcFXSg==
X-Received: by 2002:a05:600c:8b71:b0:483:7980:4687 with SMTP id
 5b1f17b1804b1-483a95dd932mr214387545e9.17.1771978896545; 
 Tue, 24 Feb 2026 16:21:36 -0800 (PST)
X-Received: by 2002:a05:600c:8b71:b0:483:7980:4687 with SMTP id
 5b1f17b1804b1-483a95dd932mr214387175e9.17.1771978896023; 
 Tue, 24 Feb 2026 16:21:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750607sm36454845e9.10.2026.02.24.16.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 16:21:35 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 0/3] hw/virtio/virtio-access.h: remove target specific code
Message-ID: <20260224191845-mutt-send-email-mst@kernel.org>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <967c35ff-0630-4ca7-847e-04a918c93e7d@linaro.org>
 <20260224134436-mutt-send-email-mst@kernel.org>
 <c8e97ad8-e54c-4134-a7d8-cbc91f7f4bae@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8e97ad8-e54c-4134-a7d8-cbc91f7f4bae@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

On Tue, Feb 24, 2026 at 11:21:09AM -0800, Pierrick Bouvier wrote:
> On 2/24/26 11:07 AM, Michael S. Tsirkin wrote:
> > On Tue, Feb 24, 2026 at 07:33:14PM +0100, Philippe Mathieu-Daudé wrote:
> > > Hi Pierrick,
> > > 
> > > On 13/2/26 00:45, Pierrick Bouvier wrote:
> > > > This series eliminates some target specifics in hw/virtio and replace them with
> > > > runtime functions where needed, to be able to link virtio code in single-binary.
> > > > After a first try on a series [0] doing this change and making all virtio files
> > > > common, Richard asked to refactor this part, thus this independent series.
> > > 
> > > > Pierrick Bouvier (3):
> > > >     hw/virtio: add virtio_vdev_is_{modern, legacy}
> > > >     hw/virtio: rename virtio_is_big_endian to virtio_vdev_is_big_endian
> > > >     hw/virtio: remove virtio_access_is_big_endian
> > > 
> > > Patch #2 has been merged as commit 6325407f67d.
> > > 
> > > Since we don't have feedback from the maintainers Cc'ed, I took
> > > the liberty to rebase your series, trying to address Zoltan's
> > > concerns on patch #1.
> > 
> > 
> > So as I said, main use-case where we would worry about perf is
> > virtio storage. So it's mostly for storage guys to ack.
> > Did not get Stefan's feedback yet on whether he is happy.
> > 
> > I don't understand if we always want to build a single binary though.
> > If not we could address all perf worries by having both  generic
> > and target specific implementations by using linker tricks (weak symbols or
> > whatnot).
> > 
> 
> This is not possible unfortunately, since concerned function is declared
> static inline.

I refer to all of affected device here. Not just the single function.

> If we want to follow the linker approach, we would still have
> to pay for an indirect function call. That's why we insist so much to change
> the current definition, as it's the only way to move forward.
> 
> The other solution is to exclude virtio completely from single-binary,

Not exclude - have a separate slower version of virtio for that.

> but
> we don't want to have specific config for this, and we worked hard to keep
> our promise over all other subsystems we touched with satisfying compromises
> for concerned maintainers.

ok

> Virtio and vfio are the last two left. After that, there is nothing really
> blocking the path towards the goal.
> 
> I invite you to watch the presentation we did with Philippe in latest KVM
> Forum, it will probably answers on some of your questions.
> 
> Especially, you'll see we insist on single binary being a recollection of
> existing compilation units, and not yet another configuration to build (and
> potentially fail).
> 
> Regards,
> Pierrick

Merely pointing out a fallback approach.
-- 
MST


