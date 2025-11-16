Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672C6CD4F3E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 06:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKWWB-0007Ug-Nb; Sun, 16 Nov 2025 01:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKWW3-0007QZ-Gt
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 01:45:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKWW0-0001Su-6M
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 01:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763275531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9mKVEdd9mkeH4LX/Wlw5fH2FnV/iWGrlqVGOcyf22KQ=;
 b=ZN1oEQnPDdKgFbVdlY2fiInvjSZJF44eLinTjbZ/EItoCghB7/cXTsNQBP/9v+rQdKjFfZ
 EXwXpJKMQG9p/4/IG0M6iisXKoQKiWGdWJI9IS/bmMTxEQxEwx+o8WAnMn7wZ7jdyJCjPM
 lFyLqNaGi8kPfzlAewYNn7gOcZaHcfI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-sbuOgWH4OFWo69GVcsPnzw-1; Sun, 16 Nov 2025 01:45:30 -0500
X-MC-Unique: sbuOgWH4OFWo69GVcsPnzw-1
X-Mimecast-MFC-AGG-ID: sbuOgWH4OFWo69GVcsPnzw_1763275529
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2c8fb84fso1750806f8f.2
 for <qemu-devel@nongnu.org>; Sat, 15 Nov 2025 22:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763275529; x=1763880329; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9mKVEdd9mkeH4LX/Wlw5fH2FnV/iWGrlqVGOcyf22KQ=;
 b=b8cz0YsDaLCfWIN6G0a3s45p1eGfxyQnnqk2379BVvQdJfqgmMpRs3e0hFi9qzGwaH
 JWuVH4jloNTXidwVRSzyz/QzP2Zy32SvcwcCY/sWGF7Q9yLbTBILm8LwGzuXv9Ck0/qO
 5uON/eThx6PQY6GjXZfD1RBzyQUljRnePnsxcEBFeqoHx2RmZ1B/FOXd5piEPg5kG7hM
 V1EjclEdu75SohkDiPNxJGNKjS1B3CfHJZZOmmXAtUwZXPjfCUcdaPWV+rCG2N5GqsTm
 mxWuHqT+QuHuYHynQeQYRbRH4g2BlrYdMe4j1RMg+9WAfrIvyok1vkzrWCW3+Ec7dAFo
 wEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763275529; x=1763880329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9mKVEdd9mkeH4LX/Wlw5fH2FnV/iWGrlqVGOcyf22KQ=;
 b=MyIb5lLQIfc252vD9whOLglr3uSFUNKlQtVo4mczbzULvSsA16EhPYZ9QpatSzjGL+
 7GirID+UC7R4ul1gA3Q7fI+vDBEMSXDWWUN8879wtzWrbz3rCCipbQqjN4UsJVETbfCA
 gpxeqvICk6oZWYIq9NY2n8yYAMCvN/EnJIP7DCaxXr4blAN+/SyBAxFV0kFYAZoGRP6y
 Hw3RCYAngKeSgBAfvDjDYe05nCXultd/5TzKrGzW+Ibwkh5uyDbtEC1wnAWe3EPy4cYH
 +kjImCNArLXWe2FTG9W7e1XW1LsMFh4z6cCK2nvBTF2OySRcF2MsiYQ6nEvcdhokQASG
 j4EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVw905ei7HIh1dba03G5qVcudlBaag7urfn6St+tjVGRYs5Xban8ctCYJje2A4gdZgY7VGbOyjjXuq@nongnu.org
X-Gm-Message-State: AOJu0Yzpc3OxfHyiQOGWFlUru253TyXMj3CYiHh8b1bWowBv7sjjyVuB
 jeZYIcaYaD4S4mxOy+3BP5kXl6j3laJoFP2bgayYxtb7O5fR/lfkDmDvs0dI2LkeSpecqz4Xe4i
 f0mZka8bYN6k6SBGuWs+1sJqPE/Dm1XzAszKGCTTzXOB/bl6Wqi5wprw4
X-Gm-Gg: ASbGncvh4KSA0iFNlu2Tbr81NNOBIt5FdK+hv/EmYRkMtoN21YDr6YTtXQXRHAQ9aq2
 hwENxLHxwfS3qDw49b7KJSlLbvA+xs/0B/mWLXf2paEmrFq3+7tlWoNxFOZKlRaYIoMtjYr5z5m
 SWHr0oLPhpcoI8PzNdTgRxtgiyXGB5N0Uk5Ek2TQLxhv9gwZHKCStuIFeikYBa6gOhGgz133f1w
 1jiJubT5z8CwyzI1e/70qZCP/5E852Kx2idRlJ/3XOnqAgYpTe6T8A0uwtq1alJbPvTJ4qrMVHp
 c4404m/j9dqU4Z9/FxI9UQU8+bJuF1r5UPCTT64m15uAA8wRJrFBn5unYv1zkZbV+dObUvqNmp8
 uAnU5YP7QNGoXIiWrKqU=
X-Received: by 2002:a5d:5d0b:0:b0:429:d350:8012 with SMTP id
 ffacd0b85a97d-42b593456e6mr6894457f8f.8.1763275528913; 
 Sat, 15 Nov 2025 22:45:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUG6uv5Co8TKNJWomddTrYw5B8XixJtAYFg3zIhs6SkpRfuVdfb4TU4qtdDFtRv25HuIoxvQ==
X-Received: by 2002:a5d:5d0b:0:b0:429:d350:8012 with SMTP id
 ffacd0b85a97d-42b593456e6mr6894433f8f.8.1763275528440; 
 Sat, 15 Nov 2025 22:45:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e84b12sm20360708f8f.15.2025.11.15.22.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 22:45:27 -0800 (PST)
Date: Sun, 16 Nov 2025 01:45:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 farosas@suse.de, jinpu.wang@ionos.com, thuth@redhat.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <20251116014436-mutt-send-email-mst@kernel.org>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local>
 <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local>
 <20251113124207-mutt-send-email-mst@kernel.org>
 <aRYyTeNNIPW_WIJW@x1.local>
 <CACGkMEsZtgmreUbd8BJQb9V7V2Pw-dafjLao1aVxPowuM3LHng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsZtgmreUbd8BJQb9V7V2Pw-dafjLao1aVxPowuM3LHng@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 14, 2025 at 09:51:00AM +0800, Jason Wang wrote:
> > So IIUC there will be a cluster, it may contain different groups of hosts,
> > each group should have similar setups so that VMs can freely migrate
> > between each other within the same group (but may not easily migratable
> > across groups?).  But I don't think I know well on that part in practise.
> 
> Towards this, we may need to develop tools somewhere to report TAP
> capability. Or as replied in another thread, developing software
> fallback for new features, but it seems a burden.

Or more generally, host capability from QEMU POV.

-- 
MST


