Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F124C35FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 20:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv0OR-0002HU-1D; Wed, 19 Mar 2025 16:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tv0OM-0002H6-JJ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 16:51:58 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tv0OK-0001nE-D9
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 16:51:58 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3feaedb4085so43062b6e.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1742417505; x=1743022305;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=669sNlNp+wDm2xz+j0J7+YCSzmWOVdKIhZ2Wk/qgWz0=;
 b=zQjuIL0spOtYa43l7kzV2N8VPkmEdc8QauFvIU0Z5Flrej7AyGd7EuEZCLUlPcpKaa
 9QCgBUNTOYE5duyGO2co8s/kJ/lHREQJvkYaJpsRxvb6QuNNl1H+c91n7ktw6qt4hgh+
 /CIFcBSfw3JUWKCaWpkMUgCXNnCIY4p74JPit/Z7YZdxabGlaM751CC2GRu4NvLVveRl
 2FZqgtCtJZMH+R8Ao38LsBZHmR3bIJH7UIMeSveXpY3gfybWB2SCiZ0BcNlK0f6XnZyt
 k20zyo/0TD5OD5XP3iGBdypSPRGtq5M12lN0tLQvN/6x2skWcRQ5THy9T9qxJE0cuQnz
 KkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742417505; x=1743022305;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=669sNlNp+wDm2xz+j0J7+YCSzmWOVdKIhZ2Wk/qgWz0=;
 b=m3ViLo4jeNMVIFWKBH2eZ+E620eOknhQEXgjZDDuq9karPxEUEqMq2JftuVFT5nqs+
 dTOpZhPV2d5iEQs7rjxvSdTxTM/5AgNGFON7LUFKHrdmUo75/yVW7ywXeFAajt1SR0am
 50VCHjgKuXL3bWFABk2Gte3oGYZozos2Ksr+XIBBzFSD5Vv/dBcTVToLohppFxxSDeWI
 lVGuE6LBrHAlr1MyxrSMf7z9stRZK9JM63I8He+iB8qvEMHIc1qTFTwti9c/yZKRqMjO
 Np53fSlJkPanhEbSPAnm2bLP33h7tsQnT1l3O12Apy0lQ9ZCHAdP9VGl80pJB9zkjTwL
 O7EQ==
X-Gm-Message-State: AOJu0YzlyLyn1a+9qW1nrJ+M5sXeZJc0S0fk3nb5EdIfykkUOfQZPPxW
 LFtLa5VcsKw/UmLmGG11pMuqIbIYkZ30ZDX7UYarc5Tn5iwCoEKLHH2nOYo6LKc=
X-Gm-Gg: ASbGnctZ2TGFGQOQGjSiFInDv7v+ZuzEBayb5wOVQNJNSy9tmUFFRc682eNS4zCFOCs
 FbB3Pes2RITQ2kWk/iqk26+egiu0r6SyW5dEqj0yZqiBFzkIf3efYnwuF0vjKAJp52IqPG8nATs
 pMkJh9SCibpGvW5dwVLchlbB7jCVR3QM3WRGAludqKRTYdtyyhvUlbY7LeenQUx4HC8oTTDMMim
 q/eiH9Huj+Y3ROIT1dYZhoPIYhyzufNthLTnTmXeat8hNSzzsRs2q6ZUQIS/3Ao9FheM6DKf1IF
 nvsHPGj9nplP/zlvPS4K3dyT0PPWbHL/jnMeVPr0sONqV6RA
X-Google-Smtp-Source: AGHT+IFzmDoRuoo6svQSHL112sQMeaTVaaBcgyiLrxyH9HrGx8v5qhsSMEmxIpjYX+1u+EzC76zXJw==
X-Received: by 2002:a05:6808:23c2:b0:3fa:53b5:6f87 with SMTP id
 5614622812f47-3fead610777mr3340582b6e.34.1742417505157; 
 Wed, 19 Mar 2025 13:51:45 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:1864:2d48:765f:cbbc])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3fcd403b065sm2768150b6e.4.2025.03.19.13.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 13:51:44 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:51:39 -0500
From: Corey Minyard <corey@minyard.net>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] cleanup: Drop pointless label at end of function
Message-ID: <Z9suW6Ipnaa3Gj3H@mail.minyard.net>
References: <20250319152126.3472290-1-armbru@redhat.com>
 <20250319152126.3472290-4-armbru@redhat.com>
 <CAB9gMfrxe7NWk_1GkudEeWby-ZHaH1xTWD5n7WfK7iz4qKsL6g@mail.gmail.com>
 <87o6xwkerz.fsf@pond.sub.org> <Z9seHbw1IepwkppI@mail.minyard.net>
 <871puskdhu.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871puskdhu.fsf@pond.sub.org>
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=corey@minyard.net; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 19, 2025 at 08:49:01PM +0100, Markus Armbruster wrote:
> Corey Minyard <corey@minyard.net> writes:
> 
> > On Wed, Mar 19, 2025 at 08:21:20PM +0100, Markus Armbruster wrote:
> >> Corey Minyard <corey@minyard.net> writes:
> >> 
> >> > Is this official coding style?  I'm not a big fan of having return
> >> > statements in the middle of functions, I generally only put them at
> >> > the beginning or the end.
> >> 
> >> There's nothing in docs/devel/style.rst.
> >> 
> >> I count more than 42,000 return statements with indentation > 4.  These
> >> are either within some block, or incorrectly indented.  I'd bet my own
> >> money that it's the former for pretty much all of them.
> >> 
> >> I count less than 130 labels right before a return statement at end of a
> >> function.
> >> 
> >> Based on that, I'd say return in the middle of function is
> >> overwhelmingly common in our code.
> >> 
> >
> > Ok.  It's not a huge deal to me.  I think it's more dangerous to
> > have returns in the middle; they are easy to miss and an "out:" at the
> > end make it more clear there are returns in the middle.  But that's
> > just my opinion.  To make wholesale changes like this I would prefer
> > it be in the style guide.  But, I don't want to start a holy war,
> > either.  Sigh.
> >
> > I mean, just a "return;" at the end of a function, yes, that's a
> > no-brainer, get rid of it.  But that's not what the ones in the IPMI
> > device are.
> 
> Well, you're the maintainer there.  If you'd like me to drop the five
> cases where return is directly after a label (all in hw/ipmi), I can do
> that for the low, low price of a "yes, please!"
> 

No, I'm fine, I woudl just like it in the style guide.

Signed-off-by: Corey Minyard <cminyard@mvista.com>

