Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962E5C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOeou-0006um-Qx; Mon, 09 Jun 2025 11:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOeos-0006ua-DG
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOeoq-0000P7-O8
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749484431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXTcQypovMch+zIKe/sKVPZRjUgi72Zn8X5MaKcag2I=;
 b=P7UTeF2WvvYNmdxhFD7Ain/NCUUJsw42JlNkF+9GMXUgJJ4v+B/WclO+xyj1LXwkAKCIy5
 qdi3C4SenifUVG1jqgJwLANzCto5mWZ+lmezOKBNRpv8XAvSeWtfsx2ULUQ+YXR3022sUr
 RNYukw9PGnNNnYdR8XIKneNHGp3qN9A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-yTZnxJoXN_62CpUEU2hVFQ-1; Mon, 09 Jun 2025 11:53:50 -0400
X-MC-Unique: yTZnxJoXN_62CpUEU2hVFQ-1
X-Mimecast-MFC-AGG-ID: yTZnxJoXN_62CpUEU2hVFQ_1749484430
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5cd0f8961so827299885a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 08:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749484430; x=1750089230;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uXTcQypovMch+zIKe/sKVPZRjUgi72Zn8X5MaKcag2I=;
 b=HfZ0Bz969YTUPguEEEhZiwKkflIzF4zKOaEj2vPOTrB+OPnxgVpIYgd+vMmZOHkVAY
 bv7JM1aMeSkUGecHzczzmAYIVbZILE95vENEtlRBXQScJrNX+egEnFv9ekstmmfs6bad
 j0JruD8FoH8zuoF2UiMRGvZzTc7GmeMr3o51QRtkhiNWG2nYQ9Srk2oFpEcRQkEG87cc
 rWqBirb6bI3IaPXQf+8FOWwdipAsM58vgfC6ryS8TWd+eO5SmXaBvgelCThhdeqr/yRG
 fSSHo8H1LYP5Z9jzXbB8OypGbgn6d8W4JUG6Y/pmheUc4SKz+O8qJTwBt1BSTK9giHkR
 KCbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHLQ/lHGje692A0/08avwLOMj4uIvxt9CGuD3N9f6hbJTbOnJbR47pAinYbKBy6Jl0TbJ7T0G7j6rO@nongnu.org
X-Gm-Message-State: AOJu0YwWJ2eXIul7GumW8AW46dzXKVrXSSfcCU0dhL++BiycYDX0Ez4p
 /+Bx7bCbe5+orTKIF4UWyh4QBW9VT+5q3QD4sTe6Ro26i2xgpZrgIy8ye2wWnn6buLNB1v0Kyir
 QxR0ZtHMtcCV1x+4fLQQDyBj07vWBHErPwQOB541fEF0u3CfjxvZuwn1e
X-Gm-Gg: ASbGnculbLd5+sONCL++D6UD2Wuy4sCsXxD19/FqfWwP9LmeBGU4gu0bjozMiLVr9+i
 MRW8JCTjW5HfmYl7EPSdCTWOr6hgFA9ysJfbx+BPQEwyIg/FGM9WBKhvHDrAPpbcl4tkYCu3y1X
 FzDTnpGAGQzSup7VrYCPlUFl3Dgyu079rcS1bPABF3uLPt4Y706vgPYsSn6iGqcyts5vM8Bypsy
 7n+pTPhFiOyxMqbKgpfROod3eICm/DAGyxVRmcinFGJHTPeIDPIVAknw8KjneUwd7VdzIxVwJgV
 1LU=
X-Received: by 2002:a05:620a:2619:b0:7d2:27ff:2133 with SMTP id
 af79cd13be357-7d229848366mr2116789985a.1.1749484429978; 
 Mon, 09 Jun 2025 08:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErAr8Yb2j3ohUnGh4JrQJnobt5Q9M+7TMyFr5+9mIuiRjmoCFAyRcCiIyij00jjylS1h/Zig==
X-Received: by 2002:a05:620a:2619:b0:7d2:27ff:2133 with SMTP id
 af79cd13be357-7d229848366mr2116786585a.1.1749484429620; 
 Mon, 09 Jun 2025 08:53:49 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ac8415sm53942836d6.27.2025.06.09.08.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:53:48 -0700 (PDT)
Date: Mon, 9 Jun 2025 11:53:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aEcDi6Z7pDeiRqDe@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
 <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
 <aENUrociiqlFuPpz@x1.local> <aEb3pRkQK30JBf04@redhat.com>
 <aEb-umgh0VP2sKGW@x1.local> <aEcBLLwB9vZ33k8Q@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEcBLLwB9vZ33k8Q@redhat.com>
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

On Mon, Jun 09, 2025 at 04:43:40PM +0100, Daniel P. Berrangé wrote:
> On Mon, Jun 09, 2025 at 11:33:14AM -0400, Peter Xu wrote:
> > 
> > Now I think I know part of what I've missed: I used to think the "config"
> > of per-QMP-migrate-command can be totally temporary for a specific
> > migration request, but then we need another MigrationState.parameters_2 to
> > cache the old or vice versa; that's probably not necessary.  Now I think it
> > makes sense to overwrite any settings directly, hence I think I changed my
> > mind on question (1), YES is fine here.
> > 
> > For (2), why it would introduce any uncertainty for mgmt?
> > 
> > If the mgmt app can both: (1) query from qapi schema knowing all the
> > parameters supported, then (2) specify all the parameters in QMP migrate's
> > "option" parameter.  Then it's literally overwritting all the parameters,
> > so it's predictable with or without completely removing global settings as
> > an idea?
> 
> That is relying on the mgmt app specifiying absolutely every config
> parameter that exists. If they miss anything, then the behaviour is
> not well defined, as external global state still affects things.
> 
> This is the same situation we already have with migrate-set-parameter,
> where mgmt apps have to know to call migrate-set-parameter over & over
> with every possible parameter to get back to a well known starting point.
> 
> The command needs to run with the parameters provided in 'config' and
> no external global state, whether from -global or any prior call of
> migrate-set-parameter

So libvirt does not probe the qapi schema for all possible parameters?  Why
not do that once on QEMU boot up, then when migration is needed use a
sequence of commands to make sure everything will be setup before
"migrate"?  It'll definitely take a few rounds of QMP commands, but the
core issue is whether there can be any real atomic issues of that.

Just to say, I still think having "option" is a fine idea at least, but I'm
really curious on whether there's any real issue even without it.

Thanks,

-- 
Peter Xu


