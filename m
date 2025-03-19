Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32818C35FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 20:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv0Ox-0002kB-Ey; Wed, 19 Mar 2025 16:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tv0Oo-0002VG-1v
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 16:52:31 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tv0Om-0002bU-Ca
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 16:52:25 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3f9a7cbc8f1so23980b6e.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1742417542; x=1743022342;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=0iakn4zbmqfTj/Tt1YhsXRIcY2gB0MrAgQuHOsmaSII=;
 b=GQm3duSQvv5lkBIXb64ezQ3IL7gvzc1iX0q/P1u4mIyv1VItFAleJjZAsDrxD14ZCy
 XnGb4KbCYYb/sjR+4MASLF8uXZ/dhvqsqp3AbbVzJSFCGLRrZQlQi+w+JkLUJ+rZct8f
 TZ0aQNDzCwvA5oOzkzncmAQK0T+s58vS2C3dAqBjnDWdoBsXCkmaVJdCJHvQcgcaNIEF
 RO8KmAm8+xjQrNqd0iPk9dE5e0JHTzN4pCrYMrvuqq1KN8ehuFTKTARZ12kq7fxHqt7G
 5EW4A5tpaS7SNokOGEbzB7QH9fDwRb3G9EWvC9uTxKk0bS7KIy1HF/LlA2HpWlKtgKuf
 63gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742417542; x=1743022342;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0iakn4zbmqfTj/Tt1YhsXRIcY2gB0MrAgQuHOsmaSII=;
 b=OHk+myv8NZM3cGyD9bJg8PH45+4eb/8U5QXGJZt9MSZ/Lna9R3NPPWCqDf3nJTSw9m
 lzCxOlCdOMFCcv4WhHIGPgtxg3D3Ua+dBm7DwQHUeycsg8/TQx3nTh6wm5SV6mBAWGna
 Fzz7weZ+H5fAuf4dHSOg+rZULzzK5lZ1904PMQHw/g7wYzZBpmWjtWl3NfZ+3LuXFimO
 VSDlD7O1xAJV2jmT8oWb+WvoWO9f/d55Z4H2wyarbFvjkeuY2YEdz2hHAo0fiG5Jpzs6
 YL43RxYl9ZwH1ExVfjEW/WhItd0FveFMqHdx/uvL9WAx+SgjkcHB48AIOuL+7fZdKTF9
 RtRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIAWkQslzhhdektyN2t50gh0xOZdOVMRs6FFPOtDXK/c52ZwSRnkDUP11U+HrC5BLHgK4Ainh9OOGV@nongnu.org
X-Gm-Message-State: AOJu0YzuRn2vQgOMWsLL74ln29snHIAWIVx3HWVvcqSc2mwDOXbEr+hi
 W2G1EnL5EE8jI6karzn3DQKXzYumUT22Uk6m9H1Tvwjlz7g5j5+TFd++jmJe+jX+8ERok0sGq/Q
 j
X-Gm-Gg: ASbGncuizli7c2Vfm3bNF03fRxONBLFa9Kja3I4TzonodxyuKmLerJNyOBVCjNXBQP9
 0/yaGHa6MaziMwSRBpPTV3nxCUExv5LaLOmA7bYTjuYSky62nEQh5Jk1/1XNN2hNgBTIzKxy3Aa
 hcsHcmpEwaPlG9Lt1UIxhLiTrtO+rrqhsHlDIcq6AU2YeHYIQpx4heT7C2atsYsvbAFcdw065eA
 QqwURKw+UuWf6/2K5wczZ5hdpTamJHUe2Ej+9hOtVl+41DUONfV55tdGUH9RYUtHjWeAOxEroaw
 atJytb1HXw135acOFWQ4BKq8pqabmeJDTQQ3XTrZr/ZBW/gz
X-Google-Smtp-Source: AGHT+IEioMnRdhCSM178BJ7IbTm4yhPf37heNYZJpm7dUj3pyuQfy591jBHJ7OAOxSSgIkdG8Gsupw==
X-Received: by 2002:a05:6808:10c7:b0:3f4:91d:2022 with SMTP id
 5614622812f47-3fead5865bcmr3027819b6e.13.1742417542613; 
 Wed, 19 Mar 2025 13:52:22 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:1864:2d48:765f:cbbc])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3fcd482281bsm2766761b6e.28.2025.03.19.13.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 13:52:21 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:52:14 -0500
From: Corey Minyard <corey@minyard.net>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] cleanup: Drop pointless label at end of function
Message-ID: <Z9sufvzNRyDKi60v@mail.minyard.net>
References: <20250319152126.3472290-1-armbru@redhat.com>
 <20250319152126.3472290-4-armbru@redhat.com>
 <CAB9gMfrxe7NWk_1GkudEeWby-ZHaH1xTWD5n7WfK7iz4qKsL6g@mail.gmail.com>
 <87o6xwkerz.fsf@pond.sub.org> <Z9seHbw1IepwkppI@mail.minyard.net>
 <871puskdhu.fsf@pond.sub.org> <Z9suW6Ipnaa3Gj3H@mail.minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9suW6Ipnaa3Gj3H@mail.minyard.net>
Received-SPF: none client-ip=2607:f8b0:4864:20::232;
 envelope-from=corey@minyard.net; helo=mail-oi1-x232.google.com
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

On Wed, Mar 19, 2025 at 03:51:45PM -0500, Corey Minyard wrote:
> On Wed, Mar 19, 2025 at 08:49:01PM +0100, Markus Armbruster wrote:
> > Corey Minyard <corey@minyard.net> writes:
> > 
> > > On Wed, Mar 19, 2025 at 08:21:20PM +0100, Markus Armbruster wrote:
> > >> Corey Minyard <corey@minyard.net> writes:
> > >> 
> > >> > Is this official coding style?  I'm not a big fan of having return
> > >> > statements in the middle of functions, I generally only put them at
> > >> > the beginning or the end.
> > >> 
> > >> There's nothing in docs/devel/style.rst.
> > >> 
> > >> I count more than 42,000 return statements with indentation > 4.  These
> > >> are either within some block, or incorrectly indented.  I'd bet my own
> > >> money that it's the former for pretty much all of them.
> > >> 
> > >> I count less than 130 labels right before a return statement at end of a
> > >> function.
> > >> 
> > >> Based on that, I'd say return in the middle of function is
> > >> overwhelmingly common in our code.
> > >> 
> > >
> > > Ok.  It's not a huge deal to me.  I think it's more dangerous to
> > > have returns in the middle; they are easy to miss and an "out:" at the
> > > end make it more clear there are returns in the middle.  But that's
> > > just my opinion.  To make wholesale changes like this I would prefer
> > > it be in the style guide.  But, I don't want to start a holy war,
> > > either.  Sigh.
> > >
> > > I mean, just a "return;" at the end of a function, yes, that's a
> > > no-brainer, get rid of it.  But that's not what the ones in the IPMI
> > > device are.
> > 
> > Well, you're the maintainer there.  If you'd like me to drop the five
> > cases where return is directly after a label (all in hw/ipmi), I can do
> > that for the low, low price of a "yes, please!"
> > 
> 
> No, I'm fine, I woudl just like it in the style guide.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

I mean:

Acked-by: Corey Minyard <cminyard@mvista.com>

