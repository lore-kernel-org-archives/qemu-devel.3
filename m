Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8692E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 20:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO0eX-0007fW-OT; Wed, 18 Dec 2024 15:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO0eW-0007f8-4Q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:28:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO0eU-0004nr-Lr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734553693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ke9DbKj9JFLZPjUxqhCio264mgEqiMYJlMrUDTs1hNM=;
 b=TGLGoy5mkHbbGIAFKKWHA8me8pirdyhk353P+te6wk5uroZqYGjF9CUvc9HNVRRIU7Rs6E
 XYAO70cXZ/B3oqA9pBTyFEsiL0IH7ZBHxoGcs/1YClwAzqNA560KFiy59Ev3Ng25iQZ8wL
 fkRw//oPK2jcQWvn4KrmbsuHvvcUcFw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-Tss6fbq-N4a9VxwQRAsZkQ-1; Wed, 18 Dec 2024 15:28:05 -0500
X-MC-Unique: Tss6fbq-N4a9VxwQRAsZkQ-1
X-Mimecast-MFC-AGG-ID: Tss6fbq-N4a9VxwQRAsZkQ
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e1b037d5so2349785a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 12:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734553682; x=1735158482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ke9DbKj9JFLZPjUxqhCio264mgEqiMYJlMrUDTs1hNM=;
 b=hZC1lSLhhXg404EpKmUeM3+yLEdwjNmwzwKd+Wtp/g0GVskF/x1OelGv1z12SAz8Xf
 dnIBZGSUUrmEwIz2SVrrbvpT3j6K8j05CTLfZOUuYluck6hhoN9cDEx82Sl5J8tm3fiF
 rZgOBT7C+Or0uK8KqKRabLfdPg+whN4FXBnELr7prXzPifE/FFJiZARc3XtT9Wp9oEpX
 ur6vd+SW9GW63dAqqXjvPATyeJtX68x+cSlYCqI3/2Vz0nNpbjPliMe7FjgLMu4AJc9r
 P2dvivbdDq7RNEfatfg3oyidDyu6hiocbUnCYNgseTBWoqqsKCX6Tg9N7FbiVjPQwcyL
 oAfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr4srQnLaXnC301/Xd6rdhW8npLY+gsyDmiYTH2OigEI7yDb17nZitwqAwiSXLWioLewiwXruSjkH4@nongnu.org
X-Gm-Message-State: AOJu0YzyOs7UK1njgUzN7WfOP+Tw7DwU1egHfWy0IBaJKHAya5hk3Ej9
 YWUlzw4mAa6UxXH4EsUi1/woX4sTLywWcXfWItydUsbqRO8XZVs/oWG5Je1iaMRDHpyHnLQWeHM
 uWhoeOCcD0B/TzgmMy32HM+XhMNH0TNOV8rLfZ68AePEHL+ypHDT00J8/PhMa
X-Gm-Gg: ASbGnctZP9ndAUGRZj/CkYMliUtxxSzJ6IMZZTgQzUnm8jTB8dtRFcSBSrWdYFxkQxT
 ZnsagTq4B40W6bSx/M0ldYLFYrbEFCo6zc+O7O+ajhJxDotvKi1+U0zDiDKQ/k2zAgy9aaUxcR2
 uFtUReVan8J1qivo/ChARC3PTxdbiEUFGPB71yHv5GkP5AVVwLhgBW1jWNmjrougjqSd6R1eDzm
 laWemH+I6tlzd8f1ECZAV7Jy4bKpPgqCRFCiPeCCX+1FWAmg8NrMZP6EUEXoq6nZHtqeHlqBT/W
 g7HoeLky329+/m1dGA==
X-Received: by 2002:a05:620a:4515:b0:7b6:edc1:3d9c with SMTP id
 af79cd13be357-7b9aaa011e1mr106100685a.58.1734553681521; 
 Wed, 18 Dec 2024 12:28:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzcjxuoHtM4VEql8mhm+K1tumVWOqsTNDxS+k60ueTePx++ZvBeF1OZmBOqm8bPVv8PaXhkQ==
X-Received: by 2002:a05:620a:4515:b0:7b6:edc1:3d9c with SMTP id
 af79cd13be357-7b9aaa011e1mr106097885a.58.1734553681223; 
 Wed, 18 Dec 2024 12:28:01 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bd619sm464267385a.78.2024.12.18.12.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 12:28:00 -0800 (PST)
Date: Wed, 18 Dec 2024 15:27:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V4 10/19] migration: cpr channel
Message-ID: <Z2MwTcIurjwGoHuA@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-11-git-send-email-steven.sistare@oracle.com>
 <87cyi6cf9k.fsf@pond.sub.org>
 <2ac9265b-0092-4636-8238-91331834ea77@oracle.com>
 <877c8d6ttp.fsf@pond.sub.org>
 <eef4a569-2f1e-4e5d-b2e1-31aed7b807fe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eef4a569-2f1e-4e5d-b2e1-31aed7b807fe@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Dec 18, 2024 at 02:53:16PM -0500, Steven Sistare wrote:
> On 12/6/2024 4:31 AM, Markus Armbruster wrote:
> > Steven Sistare <steven.sistare@oracle.com> writes:
> > 
> > > On 12/5/2024 10:37 AM, Markus Armbruster wrote:
> > > > Steve Sistare <steven.sistare@oracle.com> writes:
> > > > 
> > > > > Add the 'cpr' channel type, and stash the incoming cpr channel for use
> > > > > in a subsequent patch.
> > > > > 
> > > > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > > [...]
> > > > 
> > > > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > > > index a605dc2..a26960b 100644
> > > > > --- a/qapi/migration.json
> > > > > +++ b/qapi/migration.json
> > > > > @@ -1578,11 +1578,12 @@
> > > > >   # The migration channel-type request options.
> > > > >   #
> > > > >   # @main: Main outbound migration channel.
> > > > > +# @cpr: cpr state channel.
> > > > > 
> > > > What does "cpr" stand for?
> > > 
> > > docs/devel/migration/CPR.rst:  CheckPoint and Restart (CPR)
> > 
> > Suggest something like
> > 
> >       # The migration channel-type request options.
> >       #
> >       # @main: Main outbound migration channel.
> >       #
> >       # @cpr: Checkpoint and restart state channel
> > 
> > A quick glance at docs/devel/migration/CPR.rst makes me wonder: is that
> > really *developer* documentation?
> > 
> > Should we have something meant for *users*, too?  QAPI docs could then
> > link to it.
> 
> I agree, CPR.rst is user documentation.
> 
> Peter, are you OK with me moving it to the "System Emulation" section of
> the documention?

Considering CPR is very closely attached to migration, while we do have the
migration doc in one place right now in devel/... it may make it harder for
people to find relevant info.

It might indeed be an issue, and it can be a more generic that migration
doc (no matter whether it's user or devel oriented..) always stays in
devel/ so far..

As of now.. How about we still keep it in devel/migration/ so migration
stuff is together, but then we move user-relevant migration docs out
instead?  That may contain more than CPR.

-- 
Peter Xu


