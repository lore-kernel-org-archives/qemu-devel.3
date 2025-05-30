Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1568AC5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 11:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKxlW-0008MV-FV; Fri, 30 May 2025 07:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKxlU-0008MC-5o
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKxlQ-0008Et-RC
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748603941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zZDVKDctgt0DQCPSntuxAyUo7sFfsqAKN1P+kQYxAxs=;
 b=NN5di6LtjsyqhGzjcR5g9/rdr2MItFKdu3OnloE6Z7WrVJqtAOIs66Kzs01pqTBvEM32a0
 9soHO2sMfEugnktmaSW+S5670zKw4TCbkYYe+ClSlvutbbz2mfah+7xkXc6H0u2Kkl//pX
 t0x3eBCjkWhX9iuJMB6uG3J3/CObL5Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-0VDBFWNpNhWz2oga4m5mxQ-1; Fri, 30 May 2025 07:18:59 -0400
X-MC-Unique: 0VDBFWNpNhWz2oga4m5mxQ-1
X-Mimecast-MFC-AGG-ID: 0VDBFWNpNhWz2oga4m5mxQ_1748603938
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43efa869b19so15818505e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 04:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748603938; x=1749208738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZDVKDctgt0DQCPSntuxAyUo7sFfsqAKN1P+kQYxAxs=;
 b=fTSv/Hhwa+Jy1PRRMon9m26v6U/RbNUNAbdSsN392gecoOiCLfWt0Bm6W0REr65prK
 Y2xRXIRLP6sxnjl50HHkal7+bmSZtH7gBJxnTSnZ1Ou3wmdDm2BNReDd1AP0XvSe+GoN
 diRpP+03GtmEWwhwHrIxIsReIkW0CUKLSG4SlG1BXgxVIj/teYYK0jGGYLRNwbsRm92d
 l27M897llt5Ifn5weZWlHguUIQgQfl9XYtC7xgiiFZmMOR/XSAe6JROsT43lAfqjCKxH
 zB3+dWmoWPp6wDKuLfCs5U9ouWIo69VX5t57V2TDEn1bQKn2mUmjoMDUudi96IHaRsc+
 edYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhG8Ih+ooSbB28tm1fL/menrrLukO2sX8x9N6H/Eo8K/FipgwAa4Mx/u1AnB+inNU+c+5BQkGhVFIY@nongnu.org
X-Gm-Message-State: AOJu0Yx0AI78XBvZI0dhNRonCFvZ38aKLIds4QbUXMuOZ0UMp34gzoZf
 gOMOHNBtz/SguG6tQOx3Fqx+V1SveJ3Q5jEOztEWdK5Dh8qe4zuqR9AEUwIlb+uvmNWplEss4yq
 S1w04owvq65ztPjV9kYf7ZBcQv3TUuTqJN2a6i53Ivt1XX83lP74Ez9by
X-Gm-Gg: ASbGncsbL/gVJr+eSIKzHihJWZ5Rre+bdmidydJ1utIaDDIhOiyAOuvE1GoJkIhXXhr
 fpBG+ppU/ysx9naHIEa3Kp4kdDvhc3fbkQ2WjhxhQRQYz/ASokNc9WI5pfvYSQyIOH3mtzBrunm
 eu8E5IJEh0z5xiPChX/XNHkNHaOBUeTY+bHHcBkXOGVFT20WGXFREIz5RZCbw67sLIf+BsmofJ1
 N4w9NskFUnKem9lQ01ibKBnpm4c7d3DTntRZG6DIZCvAiFGlbdjXgzYqETDlCtrVuVXOugWgKPX
 RJIwdA==
X-Received: by 2002:a05:600c:a51:b0:442:f485:6fa4 with SMTP id
 5b1f17b1804b1-450d8871448mr19620365e9.31.1748603938494; 
 Fri, 30 May 2025 04:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0Bl4l2ejN3OUDalZGdcat+FmRDVLpR344Iy1wURI9nyrAGouDhlBGRK1z7/fmcy3CaWKg1Q==
X-Received: by 2002:a05:600c:a51:b0:442:f485:6fa4 with SMTP id
 5b1f17b1804b1-450d8871448mr19620125e9.31.1748603938125; 
 Fri, 30 May 2025 04:18:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa2278sm15480225e9.12.2025.05.30.04.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 04:18:57 -0700 (PDT)
Date: Fri, 30 May 2025 07:18:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 yuanminghao <yuanmh12@chinatelecom.cn>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: do not reset used_memslots when destroying
 vhost dev
Message-ID: <20250530071844-mutt-send-email-mst@kernel.org>
References: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
 <20250513141341.5f3ffa57@imammedo.users.ipa.redhat.com>
 <36d6672a-6d06-4af2-bdc6-4349df570662@redhat.com>
 <20250514111224.7fb1263f@imammedo.users.ipa.redhat.com>
 <acc02028-89ac-49ad-9c5c-d6973738b113@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acc02028-89ac-49ad-9c5c-d6973738b113@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, May 14, 2025 at 11:26:05AM +0200, David Hildenbrand wrote:
> On 14.05.25 11:12, Igor Mammedov wrote:
> > On Tue, 13 May 2025 15:12:11 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> > 
> > > On 13.05.25 14:13, Igor Mammedov wrote:
> > > > On Mon,  3 Mar 2025 13:02:17 -0500
> > > > yuanminghao <yuanmh12@chinatelecom.cn> wrote:
> > > > > > > Global used_memslots or used_shared_memslots is updated to 0 unexpectly
> > > > > > 
> > > > > > it shouldn't be 0 in practice, as it comes from number of RAM regions VM has.
> > > > > > It's likely a bug somewhere else.
> > > > 
> > > > I haven't touched this code for a long time, but I'd say if we consider multiple
> > > > devices, we shouldn't do following:
> > > > 
> > > > static void vhost_commit(MemoryListener *listener)
> > > >       ...
> > > >       if (dev->vhost_ops->vhost_backend_no_private_memslots &&
> > > >           dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
> > > >           used_shared_memslots = dev->mem->nregions;
> > > >       } else {
> > > >           used_memslots = dev->mem->nregions;
> > > >       }
> > > > 
> > > > where value dev->mem->nregions gets is well hidden/obscured
> > > > and hard to trace where tail ends => fragile.
> > > > 
> > > > CCing David (accidental victim) who rewrote this part the last time,
> > > > perhaps he can suggest a better way to fix the issue.
> > > 
> > > I think the original idea is that all devices (of on type: private vs.
> > > non-private memslots) have the same number of memslots.
> > > 
> > > This avoids having to loop over all devices to figure out the number of
> > > memslots.
> > > 
> > > ... but in vhost_get_free_memslots() we already loop over all devices.
> > > 
> > > The check in vhost_dev_init() needs to be taken care of.
> > > 
> > > So maybe we can get rid of both variables completely?
> > 
> > looks reasonable to me,  (instead of current state which is
> > juggling with  dev->mem->nregions that can become 0 on unplug
> > as it was reported).
> > 
> > David,
> > do you have time to fix it?
> 
> I can try, but I was wondering/hoping whether Yuanminghao could take a look
> at that? I can provide guidance if necessary.


Guys?

> -- 
> Cheers,
> 
> David / dhildenb


