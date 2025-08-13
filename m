Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449D3CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 14:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umC8E-0004md-08; Wed, 13 Aug 2025 10:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umC8B-0004mH-4b
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 10:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umC7x-0002tI-7M
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 10:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755094010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QvwL+w9McJxSQWjFczCDpZv2chRH3XYcq/HP9T4vWQU=;
 b=BhV0O/UassisUf7B7qEetxyDdodFCbigmqsn0MXuh6f4sbHS156ubMDbdcIhMJIKQ2YbLJ
 GWZQK/CGcxu6QBKCBZeG2xe2wAwgHLQNot1HLph/dkGr/NnQ5jsSIL9Z9hNBXFOqv2TbJ6
 DFwXSlqEdFfTLUYDeBVUPG7J1RsShno=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-wFn0g-j-OXa2wGMWhF5MFg-1; Wed, 13 Aug 2025 10:06:49 -0400
X-MC-Unique: wFn0g-j-OXa2wGMWhF5MFg-1
X-Mimecast-MFC-AGG-ID: wFn0g-j-OXa2wGMWhF5MFg_1755094009
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-70738c24c4fso61121906d6.1
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 07:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755094008; x=1755698808;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QvwL+w9McJxSQWjFczCDpZv2chRH3XYcq/HP9T4vWQU=;
 b=A8tCgdITIsN2kHYCYTu4PrBmSRTlRAT0FLxLQxZWvcAPQbgpJUmAP0qHuxyjmNRVcE
 hqIJ2HySaZl1/a9hZw+pxqVEgv6PQntIT7yh+Az6AsiCGN7lJAsTIvRonnBItqDlqsx+
 VdzPhjlNSBr5kl6nvdHorfx9OPR1vJDuE4chkEb/I6kAAHb8Jaolf9RP+gj+pxforGyS
 YkRGZyOQqbTqF/RZui9SoipLBiBsp6oL3NJFpwnGh7WTIoNF+KBJmKut4Spb2Avrldlt
 yXiWxMqouVWBLtov/7r3sGklG0WN6FHHOnTlwoqDZlVTb2yUd9o0/LlnuFQrTA3jyOEn
 /2eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBEKwbpfZXddWAVw5eIX6l1G7Hl4lUDAUhW2MtAfgN87XiUKBA7KozXwmytsqLE59NBQDZIiBGvkdN@nongnu.org
X-Gm-Message-State: AOJu0YyEyhNmIVjAwlGR48NAS1td0nAVeS7cNbUHU7x8PFvXPm0R55zn
 7Qr1v81CQMk2oOXjxBY/DGqZrUKwGtCcFCcwR0TyRn0wQ2qvNlonQhdjK8ULjEWAdIr4s+h05A6
 2aewghiCdFrP8/20FHxw4XjYdjQ7gL/0J7+mHe5Mmd5ycu9J3HBIt1YN8+rH52XX3
X-Gm-Gg: ASbGnctppuzWb4JXuQgF6uGt3vdnYM/TR7cxri4XnedtAQVKDS9CUpfo78GBw6xva4B
 aslrvZuNAyM0IpSaWhgXCdihI0PmQZomVgC+cpJjc88qy/S/Argn1IM0WN43J+X9Ua0FQbciCGs
 SytQUytMAb0rCvFXxdxXab9+ifVU/PBvMjSNe2J651sjqLMRaEYfavosjH5e14kwM6x6a1l2dRS
 6seAtCQkvRF3l5M+s2a1Y+lV+hXpgAZ6g0Z/+QnMD/cP529zUhv8jouHZiUq6Cv+AviaDTYbizE
 SI7VC7dRdloGq/KyI/OZEC4DonjQBQnP
X-Received: by 2002:a05:6214:500d:b0:709:e60f:6618 with SMTP id
 6a1803df08f44-709e89a59a3mr31429236d6.33.1755094008021; 
 Wed, 13 Aug 2025 07:06:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI2f2aZ0SaA8UG9bM0wpIrmM85YbNryPIvTOfiJ3T4ueZXTzB7eBzhIax0hfeav4/eyFK/EQ==
X-Received: by 2002:a05:6214:500d:b0:709:e60f:6618 with SMTP id
 6a1803df08f44-709e89a59a3mr31428666d6.33.1755094007444; 
 Wed, 13 Aug 2025 07:06:47 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077e263efcsm195229386d6.85.2025.08.13.07.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:06:46 -0700 (PDT)
Date: Wed, 13 Aug 2025 10:06:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 jasowang@redhat.com, mst@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
Message-ID: <aJyb6n9Vf4BhHqpb@x1.local>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local>
 <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local>
 <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local>
 <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
> On Mon, Aug 11, 2025 at 11:56 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
> > > This effort was started to reduce the guest visible downtime by
> > > virtio-net/vhost-net/vhost-vDPA during live migration, especially
> > > vhost-vDPA.
> > >
> > > The downtime contributed by vhost-vDPA, for example, is not from having to
> > > migrate a lot of state but rather expensive backend control-plane latency
> > > like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, offload
> > > settings, MTU, etc.). Doing this requires kernel/HW NIC operations which
> > > dominates its downtime.
> > >
> > > In other words, by migrating the state of virtio-net early (before the
> > > stop-and-copy phase), we can also start staging backend configurations,
> > > which is the main contributor of downtime when migrating a vhost-vDPA
> > > device.
> > >
> > > I apologize if this series gives the impression that we're migrating a lot
> > > of data here. It's more along the lines of moving control-plane latency out
> > > of the stop-and-copy phase.
> >
> > I see, thanks.
> >
> > Please add these into the cover letter of the next post.  IMHO it's
> > extremely important information to explain the real goal of this work.  I
> > bet it is not expected for most people when reading the current cover
> > letter.
> >
> > Then it could have nothing to do with iterative phase, am I right?
> >
> > What are the data needed for the dest QEMU to start staging backend
> > configurations to the HWs underneath?  Does dest QEMU already have them in
> > the cmdlines?
> >
> > Asking this because I want to know whether it can be done completely
> > without src QEMU at all, e.g. when dest QEMU starts.
> >
> > If src QEMU's data is still needed, please also first consider providing
> > such facility using an "early VMSD" if it is ever possible: feel free to
> > refer to commit 3b95a71b22827d26178.
> >
> 
> While it works for this series, it does not allow to resend the state
> when the src device changes. For example, if the number of virtqueues
> is modified.

Some explanation on "how sync number of vqueues helps downtime" would help.
Not "it might preheat things", but exactly why, and how that differs when
it's pure software, and when hardware will be involved.

If it's only about pre-heat, could dest qemu preheat with max num of
vqueues?  Is it the same cost of downtime when growing num of queues,
v.s. shrinking num of queues?

For softwares, is it about memory transaction updates due to the vqueues?
If so, have we investigated a more generic approach on memory side, likely
some form of continuation from Chuang's work I previously mentioned?

-- 
Peter Xu


