Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A293D3F29F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 21:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1uVo-00016B-PK; Fri, 18 Oct 2024 17:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t1uVm-00015n-Dl
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 17:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t1uVj-0007Qg-NP
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 17:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729286869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tQQVG8olR8qR1ds6PCNqi2FkPA40dTIFSoOdKUw/lc8=;
 b=HW5kiIycpzQCVyBT5lqfgXnf33i3vd3CrkGSPuD1P+hPFhOf8odqqeijE4r5LUVA8gVSYD
 1O1jROHHRNSAlVvybHYIWf+uYa0VaeEH/tV8avBCdyyLNmD7DxbKDntFeqSXRPOws/NXnb
 mB/qdpk2EadzUNeBpE0v5kkVPxqiYY4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-fKZmkIwqPJGbp42XpZphRQ-1; Fri, 18 Oct 2024 17:27:48 -0400
X-MC-Unique: fKZmkIwqPJGbp42XpZphRQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbe50b415eso33196696d6.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 14:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729286867; x=1729891667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQQVG8olR8qR1ds6PCNqi2FkPA40dTIFSoOdKUw/lc8=;
 b=a06V1taTZIzw19qkEuQiNhMMqI5fU85LCsI8WvYdHZqAiUTkRn6p5kX6gQeVHnzV9d
 LuJBmw/tijM3LI9+v0qSUeqClGpHKIKstHdXwi5cMPlFjEuN1rrQrAVLkgjChdXboH+q
 SwiSFMAvkrlLJOZrJa+0v8Da9yFY3wujWTVgjvEkh5jJL2E/GmD2fcIh/sL9ywzsqvxh
 BxpR8Q3ReZ3YjthF34JgJUzlM1IBU7sim40NHJMqVLBXDwiC9Xq4pc5Hxrf2CbTMS5WK
 xeFgDIl/uFvcXs83USijZaeNiRxd8RqMfT49ovF1kkOhxM4pkU8hU43ic2nn2GbQigyo
 vZyQ==
X-Gm-Message-State: AOJu0YyM/ZsHgIdyjTYuRt+REhvqPOSknOhJ1mFSujhSA8CCq30cbNc3
 5WnVoYJU1VQRW5mJtBXO+SmandKpKQPCUU/WETV3c8w+bniTcHfjF1XHce3kqXRieo9EiFIr5Up
 wP/1zYm29AOF4GqEdWBFIwDqR20TiyBoRnzf8KL5oZ2CE9irfDvnxNsOpnZZ9yngjTiyDPPdJ/j
 2EBjOn4UHSP79/+DCoGDYEZhrbUEmSlE9Hag==
X-Received: by 2002:a05:6214:328e:b0:6c5:5f04:3665 with SMTP id
 6a1803df08f44-6cde1631ff3mr40761976d6.48.1729286866937; 
 Fri, 18 Oct 2024 14:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFlkmDrS0ffFOBvE5aOEinwJcJPv68HH+r15G8OOMEaBBsNXMuCthoZPz3IOjkkn1dAjJMsg==
X-Received: by 2002:a05:6214:328e:b0:6c5:5f04:3665 with SMTP id
 6a1803df08f44-6cde1631ff3mr40761756d6.48.1729286866499; 
 Fri, 18 Oct 2024 14:27:46 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde117882bsm10555536d6.62.2024.10.18.14.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 14:27:46 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:27:44 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] Migration: Add trace points for vmstate handler
 insertion/removal
Message-ID: <ZxLS0MbAgEHNwupM@x1n>
References: <20241018144426.826802-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018144426.826802-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.249,
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

On Fri, Oct 18, 2024 at 10:44:26AM -0400, Peter Xu wrote:
> SaveStateEntry has lots of magics internally, on alias_id, get_id() being
> able to overwrite the original idstr, compat fields, ID_ANY, and so on.  It
> may not be always clear that what all these fields are being registered for
> some device we care.
> 
> Add trace points for SaveStateEntry insertions/removals, so that we know
> what was being registered.  For insertions, we dump everything that might
> be useful.  For removal, only section_id is needed because that's the
> unique identifier for an SeveStateEntry.
> 
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

queued.

-- 
Peter Xu


