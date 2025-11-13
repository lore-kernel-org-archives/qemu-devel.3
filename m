Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91CBCD8CA4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 17:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJasL-0005Ls-FC; Thu, 13 Nov 2025 12:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJasJ-0005Ky-KW
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJasH-0005zm-L3
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763053963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fhG10jMKHxHiljailZlFoplwXhj+AFzWFV15kJawqmw=;
 b=fZt1bWTQA//5ucR54IxQGPcwbuQeFl0Sn9KSKaIFrXkIC2dqJnh+ijJXee8Mc1n/IKgHPR
 JinK+t+LSKRizGz1w2sNOgMNjD3yklQWH+d6A9xcmN0+7M77Y+nSazTGg85Hsp5RGVsWeb
 4dWPtxNBhDrB4cieDtVUqDPJG7+fEys=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-jcOCrnYJO6GjD8M0ROti1g-1; Thu, 13 Nov 2025 12:12:42 -0500
X-MC-Unique: jcOCrnYJO6GjD8M0ROti1g-1
X-Mimecast-MFC-AGG-ID: jcOCrnYJO6GjD8M0ROti1g_1763053962
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88051c72070so24643236d6.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 09:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763053961; x=1763658761; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fhG10jMKHxHiljailZlFoplwXhj+AFzWFV15kJawqmw=;
 b=Xo7VIwsSKIstAmtypW/ZdYcsKthTo6o+kyS+cIK0pszZLCPbB9vC1KmvZ301IX5uB8
 5bCcd53gsG4GruKnHJeRve+soaU+IT9YQ1duGc9CuL/hxE4TRdhtCY3knhnrnpT1HLuy
 H/pFonSB51lUoYMhXPyd5igo1tONpi0vwTCSQR8FSJM9R5l5iaZnIkH3HKXaDaqU2OYZ
 Tz4NH/DhFTQF4WaLQYuKkDmOSq2jmJWXPTXbtzVaOb+cR0V7K+8Wv2F2a/LO5vANbHIz
 u1qDu1OBlhTrT5UEwPHEEJaiTZtBfb1SDyu8CvL1M9QQd56vT5KM1k5hL8ZONiN7RiI2
 2AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763053961; x=1763658761;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhG10jMKHxHiljailZlFoplwXhj+AFzWFV15kJawqmw=;
 b=lxLN6pNwpMc1USzezo4+Cz6iGNve6/V27sTevOH8siqiBP3AhtgADJWCrSxE0TlN9V
 hZiblQD2DHDfPKfC832WnstEcM4BxBq3c8zntmXrH3QpnUnuTxVFMiEEF4ktoawI3fRc
 e4LF6v7bnjjdjuujgBwG7BDBKD7nKLv+AFg2NmxRwrcRy2Y8jh94obZkjBhAH6SND3MR
 DZBB3s9vBDZ1vrDiH2mW3z50q2rHksjdjFPEDebzIUmRgHScHQRzcYuG4GovmC95kEBA
 nOCrmkHjjFlHjJuXZJp/JzFeNt4wMGJu3WHyPTATlpuwfogxjz2aKvjcPGD7KxXGYBkc
 pXBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAqG+Gk4KY033C7B14fZciy4Ziufw+Fbk/m6QlBaGZjcqJu6gE/upSz0bdNv8FYVbuQt0QzribVIBC@nongnu.org
X-Gm-Message-State: AOJu0Yzf5aWCza/ZiQXe4FfjuGpyFFNXDsmPIFx+o7yZGbsqJTLwXv01
 3VP2a861mJnEkcmdVg78Uz7vO8JQeEvDA3RvVhjPJSRYXU8kjO1QVIumKRVfd2f6oAGuXYiSLDt
 VWaT0zeBILOFm+dRYsc45JW9OuafBq7xfBkYzuo6pqWJo5b3AaFK2tNaP
X-Gm-Gg: ASbGnctd5pl8qt5OKzxyalX1VX9/fMwsE0zbGqTUMWNndorSvhTnwEG1j6EdhVRFE8G
 ohYfSYwQPaeHy+90/lBV6/VOX7EorDfuKrpj9Otfp4wJy5q/NEjfaQ0mkQqcTwWSVeuwhKI8ZBE
 FgKT+EiFTfPuKsBiGYGoqMnT2HYCT7ovR7fKPc8NEQaJGwCFqBTJ8zR49q8SmLpG8y7Zfwhrjzn
 nOwA/j1lQyAfTqNHt/ByxmbKeuiPyx3uLLBvPmQi8d6R35rq8/z4bmHpWtvb1sLWUWMSBjVcTVB
 oWRDCjaKD9iQhT5IJOn8NLBKAn8QpOwaAyk+xjZZ2nN7YwC1tAErh9RPudai2murqHGsHgAIu9+
 SQA==
X-Received: by 2002:ad4:5ce1:0:b0:882:4f53:ed3d with SMTP id
 6a1803df08f44-882719e67admr111184096d6.36.1763053961525; 
 Thu, 13 Nov 2025 09:12:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCXgJd35FkB9AGbPfvF20+An1xrWrw8YIofSwS1wl7/s/27K7xGG1oZ1c3Mc8BWSEdA08bmQ==
X-Received: by 2002:ad4:5ce1:0:b0:882:4f53:ed3d with SMTP id
 6a1803df08f44-882719e67admr111183416d6.36.1763053960982; 
 Thu, 13 Nov 2025 09:12:40 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-882862ce03fsm15583146d6.1.2025.11.13.09.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:12:40 -0800 (PST)
Date: Thu, 13 Nov 2025 12:12:38 -0500
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 farosas@suse.de, jinpu.wang@ionos.com, thuth@redhat.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <aRYRhg7lKDCBUIrf@x1.local>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local>
 <20251113114710-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113114710-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Nov 13, 2025 at 11:47:51AM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 13, 2025 at 11:37:25AM -0500, Peter Xu wrote:
> > On Thu, Nov 13, 2025 at 11:09:32AM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > > > We used to clear features silently in virtio_net_get_features() even
> > > > if it is required. This complicates the live migration compatibility
> > > > as the management layer may think the feature is enabled but in fact
> > > > not.
> > > > 
> > > > Let's add a strict feature check to make sure if there's a mismatch
> > > > between the required feature and peer, fail the get_features()
> > > > immediately instead of waiting until the migration to fail. This
> > > > offload the migration compatibility completely to the management
> > > > layer.
> > > > 
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > 
> > > This is not really useful - how do users know how to tweak their
> > > command lines?
> > > We discussed this many times.
> > > To try and solve this you need a tool that will tell you how to start
> > > VM on X to make it migrateable to Y or Z.
> > > 
> > > 
> > > More importantly,
> > > migration is a niche thing and breaking booting perfectly good VMs 
> > > just for that seems wrong.
> > 
> > IMHO Jason's proposal is useful in that it now provides a way to provide
> > ABI stablility but allows auto-ON to exist.
> > 
> > If we think migration is optional, we could add a migration blocker where
> > strict check flag is set to OFF, as I mentioned in the email reply to Dan.
> > As that implies the VM ABI is not guaranteed.
> > 
> > Thanks,
> 
> 
> All you have to do is avoid changing the kernel and ABI is stable.
> Downstreams already do this.

But the whole point of migration is allowing VMs to move between hosts..
hence AFAIU kernel can change.

Downstream will still have problem if some network features will be
optionally supported in some of the RHEL-N branches, because machine types
are defined the same in any RHEL-N, so IIUC it's also possible a VM booting
on a latest RHEL-X.Y qemu/kernel hit issues migrating back to an older
RHEL-X.(Y-1) qemu/kernel if RHEL-X.(Y-1) kernel doesn't have the network
feature available..

It's also not good IMHO to only fix downstream but having upstream face
such problems, even if there's a downstream fix...

This thread was revived only because Jinpu hit similar issues.  IMHO we
should still try to provide a generic solution upstream for everyone.

Thanks,

-- 
Peter Xu


