Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95CFC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfZO-0000Yw-Ii; Mon, 09 Jun 2025 12:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfYh-0000Ni-OC
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfYd-0003Bj-RG
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749487270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJWx48rl+iFB4unyUn1eSDebiMFEFhc1TPIHeodkvPA=;
 b=gnx9adiFf5RRCfioU/2tNrBmc2EwUU8EWcXxs97JtsSiQpx1yPfQiqUI5qPI69FqVcETVW
 BJAKuGMTIxN1p+Vxt3AxOHBZnydf249O9086uFcaKafWtNniY319dWJcZnT0Kl6uvyeBda
 Yqq+HE3EjFhC/nidUa6Zy+PdaaZQdrE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-ZUSpzZcMNjCR_POiqS1Fow-1; Mon, 09 Jun 2025 12:41:08 -0400
X-MC-Unique: ZUSpzZcMNjCR_POiqS1Fow-1
X-Mimecast-MFC-AGG-ID: ZUSpzZcMNjCR_POiqS1Fow_1749487268
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a587a96f0aso125670831cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749487268; x=1750092068;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uJWx48rl+iFB4unyUn1eSDebiMFEFhc1TPIHeodkvPA=;
 b=M/58y+5CbiQ+rNVg8JjrPoWgnUd+iKBRoDI6DGrKmA5lPqBJ63gz5b8UdGnFKy+KmI
 tSJlruXIqD7whdgTEL2XZ1xRs0q4iuS0bhpK/1d8Ne2YRDppAs4Yrp5Xr6yGBazAxKdI
 F8zU5YPN7qHca2FT8YIfBtOUXNY0GQ4pKG886MSlzjo3K1892LH8X0BkAOe1fAKAitYJ
 uEENtBQ2NbzZ8BpbvVE1fcvPilvmgFvhpF3NHVhBoFu5oR5nGgEkfSkj17zH2p2lFlvJ
 dJ8v7SKCO/+FMxOZfRwqgWKmrPEvq0c8u/ZAnW2F4nh8LWbhz155cP4YwC4VjLa7w+lq
 vnZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMupc7F96F6Ua+nX9jUBNvii1/uWG8bVNHVel33UhddfgIGRciabzDs6t33mxNU+OHJQuqunKkt+TY@nongnu.org
X-Gm-Message-State: AOJu0YxcK6jHtZcWL6sDcjttSpBfiUsGo9SeifRpu6y4Y4ju6/oYEYTq
 LEiUpFgTrAZv1oV3SY/U7DQcavvobUCCt8qcisa7YxDA0X2fQKd7j0Tv9Hdc//u/X7wf10z31Sx
 iqpWkwujFVk/2NlujDgUptnXz7+3hKxbBzur5M0O1GM8ge1Xf4+RmT8r0btjA0wOa
X-Gm-Gg: ASbGncsChjIoeERNEPVwTsl1GWYWNfdDIIURYn/uQwYj8vO3bBsE9TpJIAH7UOkSYud
 26lIQn6S9ocx46erRY+QNUnxU0FHaNcMUo7ZDzib36wyQZ6WU3m7KeTwSKLOJ4cyNIfBZPduom9
 KED9VJ0C6TgcvVq0ins9OO/1Sf8eyTIX5tz/RMkbm4rv4sMjHBj7yGyayRA4dyCvmV4P5m2hHTR
 ukm/TvKWdJs2YxQF9h4u3WuwDiPP8Zxuj2O5sEVRZjTyI9DZSa+Fby66SWmfLhdfh3GijaqbLjY
 gso8b3taTKNaDQ==
X-Received: by 2002:a05:622a:544b:b0:47a:eade:95eb with SMTP id
 d75a77b69052e-4a5b9d8deacmr237086791cf.40.1749487268010; 
 Mon, 09 Jun 2025 09:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJpE4PHkT58TL36JNa1izx7yLBtKxJ8RP6+MsH/EdP7pSwFUv9FDGuT01BbcGXIpRS+Rkg2w==
X-Received: by 2002:a05:622a:544b:b0:47a:eade:95eb with SMTP id
 d75a77b69052e-4a5b9d8deacmr237086381cf.40.1749487267580; 
 Mon, 09 Jun 2025 09:41:07 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a61116b831sm59816761cf.22.2025.06.09.09.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:41:06 -0700 (PDT)
Date: Mon, 9 Jun 2025 12:41:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aEcOoJbPv-x-xDwh@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
 <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
 <aENUrociiqlFuPpz@x1.local> <aEb3pRkQK30JBf04@redhat.com>
 <aEb-umgh0VP2sKGW@x1.local> <aEcBLLwB9vZ33k8Q@redhat.com>
 <aEcDi6Z7pDeiRqDe@x1.local> <aEcIr2Xjv__M_J0O@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEcIr2Xjv__M_J0O@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 09, 2025 at 05:15:43PM +0100, Daniel P. Berrangé wrote:
> On Mon, Jun 09, 2025 at 11:53:47AM -0400, Peter Xu wrote:
> > On Mon, Jun 09, 2025 at 04:43:40PM +0100, Daniel P. Berrangé wrote:
> > > On Mon, Jun 09, 2025 at 11:33:14AM -0400, Peter Xu wrote:
> > > > 
> > > > Now I think I know part of what I've missed: I used to think the "config"
> > > > of per-QMP-migrate-command can be totally temporary for a specific
> > > > migration request, but then we need another MigrationState.parameters_2 to
> > > > cache the old or vice versa; that's probably not necessary.  Now I think it
> > > > makes sense to overwrite any settings directly, hence I think I changed my
> > > > mind on question (1), YES is fine here.
> > > > 
> > > > For (2), why it would introduce any uncertainty for mgmt?
> > > > 
> > > > If the mgmt app can both: (1) query from qapi schema knowing all the
> > > > parameters supported, then (2) specify all the parameters in QMP migrate's
> > > > "option" parameter.  Then it's literally overwritting all the parameters,
> > > > so it's predictable with or without completely removing global settings as
> > > > an idea?
> > > 
> > > That is relying on the mgmt app specifiying absolutely every config
> > > parameter that exists. If they miss anything, then the behaviour is
> > > not well defined, as external global state still affects things.
> > > 
> > > This is the same situation we already have with migrate-set-parameter,
> > > where mgmt apps have to know to call migrate-set-parameter over & over
> > > with every possible parameter to get back to a well known starting point.
> > > 
> > > The command needs to run with the parameters provided in 'config' and
> > > no external global state, whether from -global or any prior call of
> > > migrate-set-parameter
> > 
> > So libvirt does not probe the qapi schema for all possible parameters?  Why
> > not do that once on QEMU boot up, then when migration is needed use a
> > sequence of commands to make sure everything will be setup before
> > "migrate"?  It'll definitely take a few rounds of QMP commands, but the
> > core issue is whether there can be any real atomic issues of that.
> 
> Probing the QAPI schema tells you what parameters exist. It does not tell
> you what values you should set for parameters, if you don't already know

If Libvirt is looking for some suggested value to set a parameter, it
should just leave it empty, using the default provided by QEMU?  I was
expecting Libvirt to only specify anything it explicitly knows the answer.

> what the semantics of that parameter are. Such a requirement to probe
> all parameters & set them all manually is again making migration into a
> special case that is not following the normal QMP design, and there's
> no justification for that other than the historical design mistakes in
> migration QMP which were copied from HMP.

I agree migration is special cased.. I also agree if we design the
interface today it may not be like that.  I suppose it means it's only the
"API cleaness" issue.  That matches my understanding, even if I wished I
missed something else..

That'll be a hassle for all mgmt for sure whenever an old libvirt might
still have a chance to run on a newer QEMU.

That'll also be a hassle for any downstream if some Y+1 branch starts to
drop the global-set way completely then downstream might need to take care
of keeping that instead for the major release until the last Y, otherwise
if someone installs some X.Y+1 package on X.Y it might break similarly.
All that for "let's make the interface look better".

I sincerely could be wrong, but I keep my skeptical view of this whole
effort; it's only about after this series (while this series still makes
sense to me to have caps being able to set as params, and the "config" in
general).  I would say we could at least prioritize and invest other more
important things, for example on handshakes, which could provide functional
differences (removing src/dst param dependency, removing hackish channel
establishments all over the places, early failure of device state mismatch
rather than late failure on converge, etc.).

Thanks,

-- 
Peter Xu


