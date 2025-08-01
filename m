Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C119DC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhuRE-0001B9-Ef; Fri, 01 Aug 2025 14:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhszd-0003rG-Mw
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhszb-0005Zy-Lw
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754067145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8GOnZrqmzASn1HaZWtED4UPrdR2/GxK8gC+5SJEPHqc=;
 b=FoXY3RogdohJ1WjJW81dfOQuCzsAdSS046UygDmBB6ahid9zS7Q6EHpMGlAH/dPw29PJOo
 JM9CUTvcokE6rfcnRrDlQfQ3bmsRRbJYjMycwnKr+EGoLqadTkAzbgA1HFxZ6szGYIgH4K
 ks3z2HkxFpHzYe8T7KzmblumHh86EH0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-7o-ywcZQPo23dUA2427iUw-1; Fri, 01 Aug 2025 12:52:23 -0400
X-MC-Unique: 7o-ywcZQPo23dUA2427iUw-1
X-Mimecast-MFC-AGG-ID: 7o-ywcZQPo23dUA2427iUw_1754067143
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-455f7b86aeeso4447195e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754067142; x=1754671942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GOnZrqmzASn1HaZWtED4UPrdR2/GxK8gC+5SJEPHqc=;
 b=laaxpkO+CZ0/DX8CKkQibhAakfwihT1AGeuJtq8huHBBPGP7JgkId8LlMYTuBGF9uG
 2iySODI0/b3C6jZj0ORmTLOOs9I7diTK8c0MNLe6IBLZwHTzLlIPAdhHI697DWiQjVAK
 YyIEwMbQzYx1o33RqfUtXXb3W/we+SGZRO16PjXeq3Nit5bQWmPNlXSVY4XfmvYnZliz
 E0+z+Ik6IecvF+VLj1S887eh9BpWqMjE3FIUQzNnwTNXObgvzr3tSeg8VW51xIVmPPc0
 yYXoSnBt+fZ8N5yHzo5cYSmYHne18HWz/72FxOqMmiK33lDJoNi1WAIdfaVJ8CofXi+C
 l2ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGeRVGvruOpIL2kMZWVZrzQNIpCgy50Rj7KY0vo7KFqojsUTo6uvRROZm3a58XNgztZOpsC2J7Yfsp@nongnu.org
X-Gm-Message-State: AOJu0Yx1dxFPtq8dqhrWA/NrCMe3Cd26Gcwa9WfbHbhcDjhYeQB6FhDT
 OsDxaEfEAFmE/BttQ+QKvjLz5JxTq2Q/j2bkYn694bCY2NWzlGy692PYOPXftzHlXcZs547F3HK
 SgNxCynmtw7CO2AQbecY5ui9pDWRYEHGMoifPLXElvNLG/9UJUdJGqsMS
X-Gm-Gg: ASbGnctMeFujdBbD2/TLOjhqbOeOP6J2mWeekMDzeusmS4C50yOamx7kJof3kLm35aS
 SFTyxrl3bqlpN/LoRtlp99G8dxYg9gC8zd+vSkPH5OJRHbA4VciaCFzKIKz+9v+Lx7/bpgTSBCn
 eH97WEdJkEAN5JArpvJqbYbzzrvXvfPTwfbOnLyV6fpKLncO382DVPk1KZHKc/fNFWc6IPVWtd/
 57fR4ktH+ub9nkjuR2tWlKsw5kdbs2xBp9Kt8KzyVHRjUXL5PDLotERvNYt6K0pelTGfPp5bQTw
 VzpyAxaqKDitoQoAcJph7bGTfRTf2i+6
X-Received: by 2002:a05:600c:3103:b0:458:a965:d5f6 with SMTP id
 5b1f17b1804b1-458b6a0333emr13035e9.9.1754067142551; 
 Fri, 01 Aug 2025 09:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHptCKwiAclfAlBsbemO8zCcuFx4d9/HCMp2HwvJ8yQqDGU4WbVltKM3q2oVW6z4b4hfNDgQ==
X-Received: by 2002:a05:600c:3103:b0:458:a965:d5f6 with SMTP id
 5b1f17b1804b1-458b6a0333emr12845e9.9.1754067142104; 
 Fri, 01 Aug 2025 09:52:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458af8949e1sm15081725e9.2.2025.08.01.09.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 09:52:21 -0700 (PDT)
Date: Fri, 1 Aug 2025 12:52:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 eperezma@redhat.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, terrynini38514@gmail.com,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] virtio: fix off-by-one and invalid access in
 virtqueue_ordered_fill
Message-ID: <20250801125210-mutt-send-email-mst@kernel.org>
References: <20250721150208.2409779-1-jonah.palmer@oracle.com>
 <0f0e8785-cee4-4cab-b91a-fdcca51b73de@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f0e8785-cee4-4cab-b91a-fdcca51b73de@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Aug 01, 2025 at 06:46:09PM +0300, Michael Tokarev wrote:
> On 21.07.2025 18:02, Jonah Palmer wrote:
> > Commit b44135daa372 introduced virtqueue_ordered_fill for
> > VIRTIO_F_IN_ORDER support but had a few issues:
> > 
> > * Conditional while loop used 'steps <= max_steps' but should've been
> >    'steps < max_steps' since reaching steps == max_steps would indicate
> >    that we didn't find an element, which is an error. Without this
> >    change, the code would attempt to read invalid data at an index
> >    outside of our search range.
> > 
> > * Incremented 'steps' using the next chain's ndescs instead of the
> >    current one.
> > 
> > This patch corrects the loop bounds and synchronizes 'steps' and index
> > increments.
> > 
> > We also add a defensive sanity check against malicious or invalid
> > descriptor counts to avoid a potential infinite loop and DoS.
> > 
> > Fixes: b44135daa372 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER support")
> 
> This looks like a good candidate for qemu-stable, isn't it?
> 
> Thanks,
> 
> /mjt

indeed.


