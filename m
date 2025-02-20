Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D85C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlBBG-0001qD-E3; Thu, 20 Feb 2025 13:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlBBE-0001pm-Ss
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:21:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlBBD-0003Kx-19
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740075704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Huxw6bW0x0abpYzIySonk1JTpyCaoQyOHfqDAe7m7BQ=;
 b=PxltCND7tEJtihX1pOUHA//C88GSiRdKxN1AV5wA85ZeVKxTPuXAtSaktsMz6Z4xPon096
 szx80tAauXyIGcvXyvHSuI9Gt+el9lnaJbeEuMYey0l8hCIRaIn7mIYdS8d9wfFjLSDJOi
 bl2zR7cRJW2v8yhWRMaPgN58nY7GWs4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-WhUslyvQOdmT5eMzuRrnXw-1; Thu, 20 Feb 2025 13:21:38 -0500
X-MC-Unique: WhUslyvQOdmT5eMzuRrnXw-1
X-Mimecast-MFC-AGG-ID: WhUslyvQOdmT5eMzuRrnXw_1740075697
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab341e14e27so145357666b.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 10:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740075697; x=1740680497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Huxw6bW0x0abpYzIySonk1JTpyCaoQyOHfqDAe7m7BQ=;
 b=Oo/xAv8Pmh2aXLzCgK5dYUeHhiZmCxVx/Zi22Qt6M/g96qxgNeMTWLJCk3KidnuMdO
 k1znXL+sWW++QOA9YXgFEBUut7JYWWGyYO/uOWxbpB6Uz8ZVpmOggwZKNB/euFiMALpi
 YJe2XxgB7R98+XcaEK20s2n7ujCGYW5kvoo87tIW0hJnCsLkOFP4vrylLLNVfRkWLTNi
 aoidwIKdqLrLcpj200j0R6CYUHhVYC5D7AfAky3l/aL/F9t72zVtLxgF06219/U5/zsw
 4Km2OGGppDdjIA4/SF8nFwA3lNczI1iumxDDvCGrBQuWWSZ+oPEq7hk0hZssSB/yb29j
 4O9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8a59g92ysIYvwkwbb0AwcfUXQfrg41NFpG03BJ8fPiYKoIVAX5wq8FKJD+iyVbS4jxZe3uOfn21UB@nongnu.org
X-Gm-Message-State: AOJu0YyI7PjMFyDkjk7Q4oGpfsdv1PWVALO2yhZFWG611zH5YT7aahiT
 k5Y/UVqn+cfg65g7ycm7LL6RWyXGqTaCj7FJgE3hPAQYpHLOytK3oUUE/R/r9RYOMxblk1sFi6m
 Xek7c4NutntwqFnmDyQTmiiQ6AIAiXMx55ZDyj1WJdiN5R7BwPr4U
X-Gm-Gg: ASbGnctWIQHiayYkR3HunId1S8pAkxZZWi9AjtpvndI5YXTO10LUcPZ+0zBkpnCZmbr
 xWiIEuFvc9aXwC/AUkvjHKsB2MW/hRq5b18/rGOtCTJNmn98CICeEpElRLj4MVACSTOLOdy4BHI
 0sBLQXQaaCiuJ7ME/Iq+/14AnegyYuTRwuQW1A2hv0cNu+BgAOfqD7fByzElgfs9gduCOI0OBHE
 +mYfwMtZG6/a59LceeozmfKI67VChb1rsj9NiYsSVppO/g8IL2Wa5HCrID+0lRLun8Qug==
X-Received: by 2002:a17:907:2d8d:b0:abb:b12b:e103 with SMTP id
 a640c23a62f3a-abc09af269emr38137066b.34.1740075697478; 
 Thu, 20 Feb 2025 10:21:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoS//rkf3KoexaDNDi5xOpbl9UMqje43p7Jw5f2WollYPlb4TP9uMClFBwPwBvvA7EFEanVA==
X-Received: by 2002:a17:907:2d8d:b0:abb:b12b:e103 with SMTP id
 a640c23a62f3a-abc09af269emr38134966b.34.1740075697121; 
 Thu, 20 Feb 2025 10:21:37 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532322e6sm1498349266b.1.2025.02.20.10.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 10:21:36 -0800 (PST)
Date: Thu, 20 Feb 2025 13:21:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Thibaut Collet <thibaut.collet@6wind.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <20250220131932-mutt-send-email-mst@kernel.org>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
 <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
 <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
 <20250124170327.448805ad@elisabeth>
 <20250220102724-mutt-send-email-mst@kernel.org>
 <20250220175910.25688823@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220175910.25688823@elisabeth>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 20, 2025 at 05:59:10PM +0100, Stefano Brivio wrote:
> On Thu, 20 Feb 2025 10:28:20 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Jan 24, 2025 at 05:03:27PM +0100, Stefano Brivio wrote:
> > > But I don't understand why we're leaving this as it is.  
> > 
> > So that people notice if there's some backend problem and
> > announcements are not going out. should help debug migration
> > issues. which we had, so we added this :)
> 
> The message mentions that the back-end fails to do something it didn't
> and can't even do, that's (one reason) why it's wrong (and confusing)
> and this patch is obviously correct.
> 
> Perhaps the commit title isn't entirely accurate (it should say "when
> unsupported", I guess) but it's somewhat expected to sacrifice detail
> in the name of brevity, there. A glimpse at the message is enough.
> 
> Laurent now added a workaround in passt to pretend that we support
> VHOST_USER_PROTOCOL_F_RARP by doing nothing in the callback, report
> success, and silence the warning:
> 
>   https://passt.top/passt/commit/?id=dd6a6854c73a09c4091c1776ee7f349d1e1f966c
> 
> but having to do this kind of stuff is a bit unexpected while
> interacting with another opensource project.
> 
> -- 
> Stefano


let me explain. historically backends did not support migration.
then migration was added. as it was assumed RARP is required,
we did not add a feature flag for "supports migration" and
instead just assumed that VHOST_USER_PROTOCOL_F_RARP is that.

If you silence the warning you silence it for old backends
with no migration support.
If you want a new flag "migration with no RARP", be my
guest and add it.
Or if you want to add documentation explaining the meaning
better and clarifying the message.

-- 
MST


