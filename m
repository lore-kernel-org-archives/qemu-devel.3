Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4BCC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 21:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXRwg-0006eF-E4; Thu, 03 Jul 2025 17:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXRwf-0006e2-3b
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 17:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXRwc-0005lA-Ca
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 17:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751579891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeW4+BIe4UTWt729JolGzIrCNRLPb8GQpJMen3EwQAE=;
 b=VvKOo9WkBHktsjv4wXUsPzyBs21lY1gnKbYesbjVh8ou6OkNghZI5tso1IOEtDAVr3nKX/
 kVZIzUQae9SipNuA2sJPsd12Q2H0jW4iVixq6mDk+5Pw+5wF4ftSzHRig3TWDCRQRbzvgW
 3G7TXs1Pbxr8hfSt5gUv05EPar5P258=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Efh_75Q5PQuXxvGjpHBm6Q-1; Thu, 03 Jul 2025 17:58:10 -0400
X-MC-Unique: Efh_75Q5PQuXxvGjpHBm6Q-1
X-Mimecast-MFC-AGG-ID: Efh_75Q5PQuXxvGjpHBm6Q_1751579889
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6face45b58dso3094656d6.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 14:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751579889; x=1752184689;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FeW4+BIe4UTWt729JolGzIrCNRLPb8GQpJMen3EwQAE=;
 b=uoR1Q22TxYViDvMHeNvgmgEba1C2/vTXFccXyr/f5vnsXBCGoSpWkVqrcyx59XYqTo
 be36aTPU1B8OqbR6Y6z7nUmGDMzbYFKODJufcCcchM1pxobs1XzSN2KqnBRpgHGaBMGR
 AAreEWX+fFvTgDem94Ng5aHyh+fdOXCDAX1ECjnkgQHdUpBLwOX1Gz0ficr3m+T+xeBM
 lLCaE7lZYP6aO8Y+kyHkLHd2sFS+lvaGBnVu6PQxhBg08ejK0Hr/uhCMOeG/PfWyzAP1
 anfJg42j6xxDQaWFqoKQadV0tnsU/RQYyJ9ml2470s9/7oNvfwkiUFBBzfQnoUr+BBYp
 RcOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX48ojrII96E5pZIzJ/oVA0q7tiZPkoKeOPgo2qmvuJrfl2nXYNPH2vncHbVxydcqJKEwN+ypdvLODH@nongnu.org
X-Gm-Message-State: AOJu0YxqsHycsObdVMN9pJTN6g4tZBhTQWB1kvhKeIXI4pZu1Aea0EbT
 Sw87Jod+H4Tlf9l/mNpnrh2oL1g0hFd93ltrTv2rsw3cc8hv1GXhqLFY3nx1IK6SyiO+zGj7OyA
 L0HhLPE25ASCLxKks+k3aBBiyCLfb3nwAGTmYEiUVjtzOR6YSHRBdNKR/
X-Gm-Gg: ASbGncvLZnIX2cS0vitzeGLxY+I8px+gnrDDnQzhT58Q/ZsnmdcTJEfMzASt5/pRyJI
 8RUrS5597gaJbDJeRAq9C/bk73Fp5W2V3MeJwReyvCROIkiGyHvpjnfA/eRuaWwNL1xV1hQxqYa
 UTi3h+vsJ4QOamjY8O2Z1W95o0dCb1pOp3USy4xG8kr/1fo+h0DljCRtOwtadK41J3+kNlHpSfT
 xSboKCPc7kzdnHgCBCmemUwi3NkYYdYRq99scE0Ek273knvv17IfGSrwFEhFRnow8k1ME+KPm0R
 liC6rNJTN5rYvQ==
X-Received: by 2002:a05:6214:3118:b0:6fd:d91:ba28 with SMTP id
 6a1803df08f44-702b1c0e91emr101734026d6.41.1751579889588; 
 Thu, 03 Jul 2025 14:58:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkBDwRO2FevithTs4OtFzU+mYN4UzWuuX0zlNTPJ5RKb2pZgsuqROq9xpVvnhwEHRBhpbXwg==
X-Received: by 2002:a05:6214:3118:b0:6fd:d91:ba28 with SMTP id
 6a1803df08f44-702b1c0e91emr101733746d6.41.1751579889234; 
 Thu, 03 Jul 2025 14:58:09 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d60853sm3684376d6.116.2025.07.03.14.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 14:58:08 -0700 (PDT)
Date: Thu, 3 Jul 2025 17:58:05 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH V5 20/38] migration: close kvm after cpr
Message-ID: <aGb87SVQE6OzQMoT@x1.local>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-21-git-send-email-steven.sistare@oracle.com>
 <9dfc0dae-f048-4d41-9b6e-02b6e7dbc215@oracle.com>
 <aGVYD1GkOC-LuI1T@x1.local>
 <a0487a01-41de-4997-860c-bc555a295643@oracle.com>
 <aGbd0IgvtiR4EkoH@x1.local>
 <d588c137-423a-4609-b5b5-66f6f135b12a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d588c137-423a-4609-b5b5-66f6f135b12a@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jul 03, 2025 at 11:21:38PM +0200, Cédric Le Goater wrote:
> On 7/3/25 21:45, Peter Xu wrote:
> > On Wed, Jul 02, 2025 at 03:41:08PM -0400, Steven Sistare wrote:
> > > The irq producer is not closed, but it is detached from the kvm consumer.
> > > It's eventfd is preserved in new QEMU, and interrupts that arrive during
> > > transition are pended there.
> > 
> > Ah I see, looks reasonable.
> > 
> > So can I understand the core issue here is about the irq consumer /
> > provider updates are atomic, meanwhile there's always the fallback paths
> > ready, so before / after the update the irq won't get lost?
> > 
> > E.g. in Post-Interrupt context of Intel's, the irte will be updated
> > atomically for these VFIO irqs, so that either it'll keep using the fast
> > path (provided by the irqbypass mechanism), or slow path (eventfd_signal),
> > so it's free of any kind of race that irq could trigger?
> > 
> > I saw that there's already a new version and Cedric queued it.  If possible
> > add some explanation into commit message, either when repost, or when
> > merge, would be nice, on explaning irq won't get lost.
> yes.
> 
> Steve, just resend the patch. I will update the vfio queue.
> Or we can address that with a follow up patch before QEMU 10.1
> is released.

I've just noticed maybe I was wrong that slow path was always present.
We've closed the kvm so likely the slow path is gone..

So I think I misunderstood, and Steve likely meant the irq will be
persisted in eventfd, which is still true if the irq eventfds are persisted
and passed over (I didn't check the patchset, but I'm assuming this is the
case).

Then I found, yes, indeed when irqfd is re-established on dest qemu, we
have such tricky code:

kvm_irqfd_assign():

	/*
	 * Check if there was an event already pending on the eventfd
	 * before we registered, and trigger it as if we didn't miss it.
	 */
	events = vfs_poll(fd_file(f), &irqfd->pt);

	if (events & EPOLLIN)
		schedule_work(&irqfd->inject);

I've no idea whether it was intended to do this as the code was there since
2009, maybe this chunk of code is the core of why irq won't get lost for
CPR.  But in all cases, it can be a pretty tricky spot to prove that cpr
works and looks important piece of info.

Personally I'm ok doing it on top of what's queued.  Maybe such explanation
on how it works should be put directly into docs/../cpr.rst?

Thanks,

-- 
Peter Xu


