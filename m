Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A933AC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp1Uz-0008OX-JN; Wed, 29 Jul 2026 06:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp1Uw-0008MA-36
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp1Uu-0007md-8n
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785320806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7k2f2zBKWnbyxyfc7cAmDII3tVVWCZtlZcemYT4q6y4=;
 b=YAeONty6i/SKyZ9E6BJZiHzbNrDdw1mieJfFBsftzh8SfnhjN5pKrMS2yrIhT2jQ8YQ0YA
 s0tN3B7wjNo+2C2dYpQytf46sZD8eTIRWlE5LN8DiA5jZFHYbcz0LEzityS0h/Rn0oF3HM
 YkWV/v+HIzs7esoHlQyU8QuIKkdXUIk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Y4MUvfp9ODavJo4kOz8qoQ-1; Wed, 29 Jul 2026 06:26:44 -0400
X-MC-Unique: Y4MUvfp9ODavJo4kOz8qoQ-1
X-Mimecast-MFC-AGG-ID: Y4MUvfp9ODavJo4kOz8qoQ_1785320804
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49564d4b849so3280945e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785320803; x=1785925603; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7k2f2zBKWnbyxyfc7cAmDII3tVVWCZtlZcemYT4q6y4=;
 b=nOZY0szIpAOrYZ/+HR75vgXwA3Juo7i4/TmB4CriX0ldlnCXpPNhZ0eFMkDQEdIPC/
 AA7bK8EryhLsVcPaacePCLfjgV5Q7hKvbj+SmnOcSSAr1GNThaRFTtV/GCD8IlyrV0kF
 VsaBnsbRSnx2pWZhjbPATL5O4qUARUV2hluHSst3K5XFmeivIuzO/rWbcagYqjr4cIXv
 GrCvdcWMGSC8rQMnruGO2TUV2BjYTcWM0M2qclrsCeyA8M8UoYiY8Zf/cZW35j8VqtWa
 gsKbYiIT6VAj26KoDC4LsUSiQWEQ3877HASBGbREwJpccIKSAsaEeZtXr2H3QjynbSwX
 16CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785320803; x=1785925603;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7k2f2zBKWnbyxyfc7cAmDII3tVVWCZtlZcemYT4q6y4=;
 b=i8TxOeztKeL6jNnWoP6Jx9NNL02MlCIJTZvg8pk+gs0cfqCtwVPKwPgfUQoba+zGb3
 aX2MXroMPuD4pQq/GcDZEp/P6AUAjnjqzs/awtZ/0HhfK1zruJ84YcHPRwodabIEUeHK
 5Xfo4+ic9AvnknDin+ABHke0FL9Sw248vR4ROLFdi08QmcNSy41k2K8kCVJRsg7nBE0l
 w0fZAvRGYZkFcfZUcitVX1XcAy8GAx+Fx7oAwEt9Oq28MbvoQXGINYdCVZNRMmpGsGxn
 xALLmjTHPwNPBPQjhQhOLQ65ba2FlJmvG6Slsd8ImTvKAoprNhaVXfa+KEfZHzA8cyrP
 qPWA==
X-Gm-Message-State: AOJu0Yx50uY099LcBd8QRyOvE0GkQa94d6MVGp8uPs8NE3q78PoKEw8T
 wu38Z9Yf9iXO7ZYVpgmgrYOSBT6rObGV9Jq4bJDvWXL7BDsfDyKBzMAiqamm8Ehaf/NB0LGcl0g
 4uIMTIUb3OuIURCY8eSBR5PrCK75S2xjMog5kxXuRWhE14it6YL86xt4U
X-Gm-Gg: AR+sD11STGBQV5jlrae5ObecmNYfjTahPmPSqKnHZ5dGGi9YC+c5eJGdo/9gKcx8VUM
 VWBPA2w6KuzkZA8hySJCjmqNIn9whRvrJt/A2fexI+ZxiRBEvLvhinbfm8oZJqNsw+aazZVUCPb
 KkZc9/MoZyH9kcXRr07ptR/oQFrdZgaOmjQ/0jPaIJsHn8SsxDnARQVpoJr9fPhcw8RKWsmwKS5
 6pZ6QyiIp5En1SkWqofIXWkWyEdJUPb2GvARIFG3+hHexU5nkaCLOMs9zI78rUCqwyI6501Auhh
 bh/Wf8u1/eB9tnaBKNleEXXUb5KLCouidDTbbw13af5Fmui42wJY6QQRqFBr1TH+FZAr8X5VhW1
 CWQk0CJetbjbwYZGvq+UJX8k=
X-Received: by 2002:a05:600c:3b13:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-496c653d3dcmr79964675e9.7.1785320803428; 
 Wed, 29 Jul 2026 03:26:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3b13:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-496c653d3dcmr79964165e9.7.1785320802891; 
 Wed, 29 Jul 2026 03:26:42 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm7999626f8f.27.2026.07.29.03.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 03:26:42 -0700 (PDT)
Date: Wed, 29 Jul 2026 06:26:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Miku Hatsune <anznu1l@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, QEMU Stable <qemu-stable@nongnu.org>
Subject: Re: [PULL v2 09/30] virtio-mmio: fix QUEUE_NUM_MAX
Message-ID: <20260729055600-mutt-send-email-mst@kernel.org>
References: <cover.1785179875.git.mst@redhat.com>
 <a5cff318f06cd06b37224e15ee74d64d1df8b12b.1785179875.git.mst@redhat.com>
 <65990a19-6a7e-4c1c-9354-0fffa13cbba9@tls.msk.ru>
 <20260728154328-mutt-send-email-mst@kernel.org>
 <75f2277a-8508-4e6e-adfe-92bed9fc1bf6@tls.msk.ru>
 <20260728192047-mutt-send-email-mst@kernel.org>
 <af6d5296-9860-4c5d-a72e-f2eacac3e2e9@tls.msk.ru>
 <23cbb4e8-1467-4a0f-9af7-67e3c64cba7e@tls.msk.ru>
 <20260729053423-mutt-send-email-mst@kernel.org>
 <90d15fe9-9250-486c-9349-441d0c11c655@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90d15fe9-9250-486c-9349-441d0c11c655@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 29, 2026 at 12:49:59PM +0300, Michael Tokarev wrote:
> On 7/29/26 12:38, Michael S. Tsirkin wrote:
> > On Wed, Jul 29, 2026 at 12:25:30PM +0300, Michael Tokarev wrote:
> 
> > > What would break if we switch to the new behavior unconditionally,
> > > regardless of the machine types?
> > 
> > It's guest visible. You will get two reads from same register
> > suddenly returning different values.
> 
> The old value basically makes no sense.  We returned a wrong value
> here, now we return the correct one.


So now, guest read the big value, and it is writing that value back.
But since we changed the value to smaller one now guest is
writing a value bigger than the max and out of spec and it will fail.
Not nice at all.


>  It's like, I don't know, a lot
> of fixes in various other areas - when it was a bug in qemu impl. of
> some register read which was subsequently corrected - it doesn't need
> a compat property to continue returning a wrong/bogus value for old
> machines?

Yes you will find we do that a lot.
See for example x-pci-express-writeable-slt-bug there were many more
we just dropped support for the affected machine types.


>  I think here, there's no real difference - because the
> guest can't access the "extra" space anyway without causing some
> unexpected results (usually a crash).

Of course if it was like this we would have noticed much earlier.
FYI most guests configure exactly the size we specify as max.
The state is in guest memory, so it just works.


For the typical scenario (no in-order), and no attempts to
fill all of the queue with a single request, things simply
work with a slightly bigger queue. Maybe a bit higher memory
requirement, that is all.

I'm not strongly objecting to changing the original patch.
This needs a bunch of thought though, as we are breaking a
fundamental promise of live migration.
And given we are in freeze and it's a CVE, there's some urgency
to get the fix merged.



> > > I don't understand why do you suggest to implement the same logic for
> > > older/stable qemu versions if it will always evaluate to allocating
> > > the max size for the queue regardless of the requested size.
> > > 
> > > Thanks,
> > > 
> > > /mjt
> > 
> > My preference, normally, is to just stick to upstream as much as
> > possibly. I just do not want slightly different code bases when we can
> > trivially have one.  If nothing else, less of a chance a follow up patch
> > will cause conflicts, and then it snowballs from there.
> 
> Yes, this is exactly my preference as well.  It is more, I often
> pick up some other changes to stable - changes which aren't fixing
> anything, - say, some renames or code shuffling around - just to
> make the resulting code closer to the master branch, so that
> subsequent changes has much more chances to apply cleanly.
> 
> In this case I can drop the addition to hw_compat_11_0[] (because
> it doesn't exist in 11.0 and before) and keep everything else.
> There will be quite some code which boils down to a single line
> (queue_size = QUEUE_SIZE_MAX).  Twisted code which does not contain
> the main trigger (the property) at all.  This change and the
> subsequent change which it fixes - in reality, all these ifs
> and conditions would be just useless, but will give someone a
> puzzle to solve, wtf is going on here?

They just need to look at the upstream commit and it's clear.

My suggestion would be to propose a cleanup upstream, including
an analysis of the risks, and we'll discuss.

Or you can do original development in the stable branch if you
prefer, be my guest, but don't expect it to get same level of
scrutiny as upstream code gets. If anything breaks, it's on you.

> Ofc it would be ideal - from the back-porting PoV only - to just
> drop this all entirely and unconditionally report the correct
> queue size to begin with, as per above.
> 
> Hwell.. :)
> 
> /mjt

A discussion for upstream, imho.


-- 
MST


