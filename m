Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40E9CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHYU-00015D-JP; Wed, 27 May 2026 12:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHYS-00014Y-BN
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHYP-0003kk-Hr
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779900983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y15XOa0+PFgmzYqDLTmxXFUr1q9T5CGzEJ7f2iAhC90=;
 b=O7i0xNmvYCMjV8zXqULwz6PpnXhenPXaKzmXagFjTGL3qd9n4Bm9Oe7hdnJHNxbkL+ZI/T
 4JGN+hFFDBE1HmdCM5rb1Up72as4UphOGDD5KumHn/cUN1/LvyVS2Nl6UMoLZzhWiJz7TW
 wlx9btmAXALOF7ArZW9VIpB9GQqfp8s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-SGAv-vkLPpWP9hfLOWkPdQ-1; Wed, 27 May 2026 12:56:22 -0400
X-MC-Unique: SGAv-vkLPpWP9hfLOWkPdQ-1
X-Mimecast-MFC-AGG-ID: SGAv-vkLPpWP9hfLOWkPdQ_1779900981
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49043386b3fso53052775e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779900981; x=1780505781; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y15XOa0+PFgmzYqDLTmxXFUr1q9T5CGzEJ7f2iAhC90=;
 b=bfuK3uGwG3VDRqrN5XlX4Rh0O8o7yf+dy+R7plraaqpeRHl/BNvJtDDkfQSUTieYfR
 mGeps+qvn1ioTNQjMroKZrAAR9ymfCSo3ORww5123QZaAfx4HKqmzgkNzzenvIUKKR+G
 u09oe2BNr4lHQ510QvUMcTtB0qtL/4WHX65TrKECtsEdIAGCdCuF9bv/ScuLFzMpnpJe
 M8uY0U2kaAWsS7NQNyBZzxLVN4hD7VBS0cJ454N50O+DGyQ+BZDamjzrYMNduV7xPhPR
 V4kxjhihunvumJsMCXVo7EnmYh+bKVtXiNJbgsMLEnz/DyQFqH3CV0K/ovRrEV1Ccicu
 GI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779900981; x=1780505781;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y15XOa0+PFgmzYqDLTmxXFUr1q9T5CGzEJ7f2iAhC90=;
 b=dFJTD0OhNeEgx6P/WgJVxiz7aSlVfBk4mghUPZ/QLufmqowbHQLoO7ptApCfddY+wV
 1q2fdG/AXhiMECtfRnEm6epCReT3jGh4SciVicSoffLKCnIYe361ZG4NB4rUaSlWKqxI
 3JyNcXOkedNinV9Pn5bIG2Aj3aaFqRBPcFXRkUg7cNWDEGWz0alDk3uIqf5EtDiAhI1k
 1BVLuscOqjZ+c4iQVk2m/ZY/kwDRlq+7OOALI4dQHMwzWWMmb824jD1FO/JPLrq88BNv
 KXxEc9MI7baWFXx56NmDTjEP3gu5Pa6n5BPjXIZFBxuca1nMa5qg9/6uOY5qv1Uxhfbf
 FoCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gGmd8d+2OMHoCITVP7s9ykByiAQatRmK3zqWF5N1fgpNfuVi6DJ7xAAvKNr38TuG0GMCkImMpKVCv@nongnu.org
X-Gm-Message-State: AOJu0Yz2l2Cfy7i9dn2aViQYhKtRl3M76lFlo3Ou8/1Hc9tZ/dJrM0SK
 S2TuTh2/BZnPNEVsNhc+x3PryjrjIArK0zhY+sGi3pgo7Jp0YUq+8nL19b691M5oXVAva6EqQG6
 uQ1DbOakD+DTAI6576NtQtNUsv+6g5t/03DCgpq42EXTq7Z/nd0OFaRVF
X-Gm-Gg: Acq92OG25+THWz5zn0xDqvpiSOftOZYyPjonu4n5XoKeV7mHWLlxth0cD2K24bPEyjs
 GEx9/rWxzwzdLGwyfHQ0HOnGs4iAtpei0QbmhNOVsPxd8anRSS1HVagG+hKZwWrddH1rJ80E6+q
 At7jTW0E6fRze7dsM9jX8r9033S2Q1WBNL0SFooabvAZFtojkNOUgMVgf/drfdQi+6D2od3cXgC
 8o3/u+8GiIQu1+7jqONe9qAnb08y4BGovYVejD0oH3TZmsKAdZsYif78GBq5ApHrADiSNXMmPIK
 wD6ZYUpN6mNBlXf2Rp1fSJCDp1PrayJuXQWiuTbSSy6n7CyL+Kg7VNtS+to4Ih4T+sNz+gkj5Om
 DgHnELCXfIUk0
X-Received: by 2002:a05:600c:45c9:b0:490:5cb3:e94a with SMTP id
 5b1f17b1804b1-4905cb3eb81mr264233485e9.2.1779900980855; 
 Wed, 27 May 2026 09:56:20 -0700 (PDT)
X-Received: by 2002:a05:600c:45c9:b0:490:5cb3:e94a with SMTP id
 5b1f17b1804b1-4905cb3eb81mr264232885e9.2.1779900980225; 
 Wed, 27 May 2026 09:56:20 -0700 (PDT)
Received: from redhat.com ([31.187.78.155]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb548dfasm6840450f8f.4.2026.05.27.09.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:56:19 -0700 (PDT)
Date: Wed, 27 May 2026 12:56:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260527125411-mutt-send-email-mst@kernel.org>
References: <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
 <ahcE-pDc_7tTrsz3@redhat.com>
 <20260527123942-mutt-send-email-mst@kernel.org>
 <ahcgxpvXFoPE0C-X@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahcgxpvXFoPE0C-X@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 27, 2026 at 06:50:14PM +0200, Kevin Wolf wrote:
> Am 27.05.2026 um 18:41 hat Michael S. Tsirkin geschrieben:
> > On Wed, May 27, 2026 at 04:51:38PM +0200, Kevin Wolf wrote:
> > > Am 27.05.2026 um 16:14 hat Warner Losh geschrieben:
> > > > On Wed, May 27, 2026 at 4:01 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > > Commit messages for AI-assisted changes
> > > > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > >
> > > > > When AI/LLM tools produce or substantively shape your patch, add an
> > > > > ``AI-used-for:`` trailer.  The text of the trailer could be one or more
> > > > > of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> > > > > explanation in parentheses::
> > > > >
> > > > >      AI-used-for: tests, docs
> > > > >      AI-used-for: code
> > > > >      AI-used-for: code (refactoring)
> > > > >      AI-used-for: code (prototype)
> > > > >      AI-used-for: research
> > > > >
> > > > > The trailer is intended as a clarification of your DCO obligations as
> > > > > well as to guide reviewers.  It is not intended for minimal presence
> > > > > such as autocomplete or asking for a pre-review of the patch, and it
> > > > > does not remove your responsibility to understand the changes that you
> > > > > are submitting.
> > > > 
> > > > Why invent something new here when Assisted-by: is used elsewhere
> > > > and is likely more familiar to other users.
> > > 
> > > Because Assisted-by: gives different information, which at least to me
> > > isn't really interesting at all. It's much more interesting to me if the
> > > code I'm looking at is generated, or if you only generated the tests.
> > 
> > I personally am interested to know which models work better than others.
> > Contributions are about reputation not just code.  I'll learn which
> > models produce better output, just like I learn to trust specific
> > contributors better.
> 
> You don't see how well the model worked. What you see is filtered by the
> submitter, and the policy we're discussing is specifically made to make
> sure that bad results never reach the list.
> 
> Even for things that do reach the list, Assisted-by: doesn't tell you
> how much of the submission is AI-generated and it also doesn't tell you
> if it's "I used model X and a simple prompt gave me the perfect result
> in the first attempt" or "I used model X and it took me two days of back
> and forth and eventually I just rewrote most of it, but there are a few
> AI-generated lines left".
> 
> So what you should trust is the contributor, not an Assisted-by: tag.
> 
> Kevin

Well, AI-used-for research isn't really useful to me at all then.
Why do I care about research?

-- 
MST


