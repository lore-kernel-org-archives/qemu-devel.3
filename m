Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A60E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKEh-0003bT-Ke; Thu, 05 Dec 2024 17:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJKEf-0003bH-KX
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:22:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJKEd-0007x4-Tu
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733437330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=35JQC/CYF9flo6oPnYjLzzXZlAZWFTIm8C7Coo1+w90=;
 b=SRl5Fr/n0UbdolwSWruP3TmvP2uM4v30FO131NNUqRHgsGQeKvxCo8zejexTjWZYSgyq94
 dHr9wZmbAldBu8H9XlIIm8qkSJNdHG9VZyp9Sx54K06LSrfsxLHijHsb3ZFQAhcK9VA9gH
 AvQZ1e1ihmMmb7MswkFLrhHZBKogFo8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-1MNXhaAmNBq6PoK6SzIJsg-1; Thu, 05 Dec 2024 17:20:59 -0500
X-MC-Unique: 1MNXhaAmNBq6PoK6SzIJsg-1
X-Mimecast-MFC-AGG-ID: 1MNXhaAmNBq6PoK6SzIJsg
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8e69305e7so4673286d6.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733437258; x=1734042058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35JQC/CYF9flo6oPnYjLzzXZlAZWFTIm8C7Coo1+w90=;
 b=aBqsEmGDYUQ+g63hTjGVThfjpi9rU7xmk4/reT21DhmHAZqT+jTPy3mYrp5akNBVG6
 zEdDcW1TO58qBEkCBNAJKBsS49IFus2hq666tet1Ajn9SglLptloVXUOnlwakB5P1O/z
 Bfk6NZFxCUrgtsw7J1E2wJ5uX3QUJqAlflWijkCc0HWU/KwmEODzQE1UGmYTtRZ3wCC+
 mkzfKIrkrTFQeJvP5gUf67NIKSR6OSwkJ7B/6vRB6qTJ44Fe7yAV5sHd2Hn8dipuRpSP
 EHocLEaay0Cb6XRptabo+cB4E2vko+A45Vdk1WNmjhC/3YdTkRxdUCotzceFdK6nr7mb
 HDHA==
X-Gm-Message-State: AOJu0YwVXLkdx0ysx1wDMcxb4syj6uiKUNUzK+lA4WgSDbZejHfb7hoO
 R8GtHpZ2uSWisyiM3bQIs6Hcmhwqp7PcL31T20fBd4o9v9EiTS8pTU3GAOmdRTIW8y3TopEXQDL
 aN9g8zWFLuH6R3OHyVdlbIvRSHlsEi913HYYI4Oq+FnjqjVfqHxAK
X-Gm-Gg: ASbGnctrQWL2kbtc9d7EDtfBGxXAZjW7mHQws3OYKeoZUqrddO1vQq+fp5KNFjWy2yy
 fNIe9Wk6+2K/eItcLFY3sgE8MWPaYS5szyUkOjZPbN2RKEKcPrN3vqMCxXIEtBUuQ5KH9fTBCrQ
 U4U4aEbkxiz9OW4ijsTTIvP1jZOC72Cz2QfxCCDwGz01Qrs+uAqO6HfTTP3bOldDZYtLDeS6Ipz
 mD+uEYG/dAPHh8+WpE7b8lITpu6JriSIVdSIq4J1SKSL7EZdjjySgdDJnRJdWtenPTdlgtcHd4B
 n5G49TdJg7+sqmk=
X-Received: by 2002:a05:6214:b6b:b0:6d8:8a01:64e2 with SMTP id
 6a1803df08f44-6d8e720d9ebmr8087946d6.43.1733437258599; 
 Thu, 05 Dec 2024 14:20:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHTEtOjzLOzGwYNeNNDoM1yjuj7GVj6RN4IN/PEgPMuHSuUW2WTRjzTBHAHeMSwWjd2aQQow==
X-Received: by 2002:a05:6214:b6b:b0:6d8:8a01:64e2 with SMTP id
 6a1803df08f44-6d8e720d9ebmr8087706d6.43.1733437258192; 
 Thu, 05 Dec 2024 14:20:58 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da699544sm10991116d6.50.2024.12.05.14.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 14:20:57 -0800 (PST)
Date: Thu, 5 Dec 2024 17:20:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 2/2] migration/multifd: Allow to sync with sender threads
 only
Message-ID: <Z1InR552_UFBCdiZ@x1n>
References: <20241205185303.897010-1-peterx@redhat.com>
 <20241205185303.897010-3-peterx@redhat.com>
 <875xnxj37e.fsf@suse.de> <Z1IOlJemNxrhOg3z@x1n>
 <87h67hdckg.fsf@suse.de> <Z1IlX3Vp1hWmQjbT@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1IlX3Vp1hWmQjbT@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 05, 2024 at 05:12:47PM -0500, Peter Xu wrote:
> In case if I missed it, a runnable patch would work to clarify.

Ohhh no need now, I see what you meant.

But then you'll really need to comment p->sem, with something like:

-    /* sem where to wait for more work */
+    /* sem where to wait for more work.  If there's no any work, it means
+     * a local sync. */
     QemuSemaphore sem;

Do you like it?  I definitely don't.. because it's confusing why p->sem can
imply a sync request if we already have pending_sync.  IMHO it's cleaner
when we have pending_sync, use it for all kinds of syncs.

-- 
Peter Xu


