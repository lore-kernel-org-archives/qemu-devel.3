Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444A5D78788
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEA25-0002lI-3Q; Thu, 21 Nov 2024 11:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEA1y-0002jc-ON
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEA1u-00026D-5i
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732206457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WVQINypMtL78z6TShU/lnEOb5MFSD74MHKFRTNgiFbQ=;
 b=gJQhUiJ9Iw9ub2w23UHWFl6FIKcXjBvCahjtMDW59MIM8vVWMCkC9QReg+b+fLJcM6JiFl
 vP36f9brvcvWWNoUvtE5H/iPRAzKuKSzZMpnBQukS7hAoXI97UltMxBvX+/wZz4gXUQYyJ
 8LVELF0q5mRGnuHZ52ECaIBPQcX6CuY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-sDXjfjvgN065-EjGKx3meg-1; Thu, 21 Nov 2024 11:27:34 -0500
X-MC-Unique: sDXjfjvgN065-EjGKx3meg-1
X-Mimecast-MFC-AGG-ID: sDXjfjvgN065-EjGKx3meg
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6ee57ae0f61so18141117b3.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732206454; x=1732811254;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WVQINypMtL78z6TShU/lnEOb5MFSD74MHKFRTNgiFbQ=;
 b=kVxF4E0q7Yle/G5fFPldGSkuVUNX/iJTqphQ6SMncDj7JNDJ9mV4g3Oerw1iGe5Ujx
 ortN5BMv9z+JcMyMJuV6DTQbFAFTefWxDIk57zI/4e7yZ5fKQ0PDLD5cRObP/Fwlbw8O
 ysRpTGd449p2FpaJrC7HimoDYSf6FCXPPYZ9aVZYuUdTzlvTidYaGPJlU+OCIZXb6VXz
 4Gl7HT583CiGTn0Q8FpLKeiICX3zRIFVSA1jNx0HfMjG7jlxg91gpt29fb6g3Kr43xKN
 xkFxl2sfRfgPK7XFMec5nEUm9tNSg4YzhziUyf1Djy9QRy8G772TrIwoFO3xUCr7aezd
 ywrg==
X-Gm-Message-State: AOJu0YyFQym2MeBzlHwD4cvm71gHKQrQ4UqdPQiAwF/h19+c5ZfAa8v2
 U8rNZBcT5IoYv8S+O3/AxdJ2vkge0lfMS9wjuDp48+e48C4xHXo+YckeevoF9KOaPqRDBxV4iWn
 O5vrEzhmDhe+PKG/bLmg2E5FSkf/ldTQJfjCg3aZ4svm1dvwA0Qhf
X-Gm-Gg: ASbGncuuz2Wr7wzvHOtE1rNjQLMFgqR2J0PbZLxnYa85PJq9G/1ubN4aZnQiZjFOaTo
 APRzs+EnwpmmSQTt+e8LlhYTzE9Xo7UNC9qzM/bicNfBmi1bOBu3HBvpJC5Zpp5wiDbN7oAjU9Y
 e22QlOtXktg5ajZVxEqlB2Y2hvWaF6OnHY5hNRd1V9yQEEkthulfRVnRdyhFnS6Cwn6kecDxYTJ
 JfJR6L3Bs78paZTkIkFiqS1tQf8xPfnEPvLzysrjwtwG5f2i4t/5SAqag4LzJ2ysx9gvaaZwuqe
 st3UGWAYxaA=
X-Received: by 2002:a05:6902:2608:b0:e30:84ef:351d with SMTP id
 3f1490d57ef6-e38cb56d731mr6559626276.16.1732206454223; 
 Thu, 21 Nov 2024 08:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJw5uq64ltFcyIIFZVuuX1PYd/jW4dVqbuAwSqisWHiQLDrbGrEwO1sZoLOmLQcl4LRMW9aA==
X-Received: by 2002:a05:6902:2608:b0:e30:84ef:351d with SMTP id
 3f1490d57ef6-e38cb56d731mr6559599276.16.1732206453948; 
 Thu, 21 Nov 2024 08:27:33 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b485247155sm228119985a.114.2024.11.21.08.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:27:33 -0800 (PST)
Date: Thu, 21 Nov 2024 11:27:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 05/12] ui/console: Explicitly create "/backend" container
Message-ID: <Zz9fc2Yuj9T4mojP@x1n>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-6-peterx@redhat.com>
 <Zz8K2kLi81lE8nQf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zz8K2kLi81lE8nQf@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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

On Thu, Nov 21, 2024 at 10:26:34AM +0000, Daniel P. Berrangé wrote:
> On Wed, Nov 20, 2024 at 04:56:56PM -0500, Peter Xu wrote:
> > Follow the trend to explicitly create containers, do that for console.c on
> > "/backend" container.
> > 
> > Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  ui/console.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/ui/console.c b/ui/console.c
> > index 5165f17125..36f8c6debb 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -1154,14 +1154,14 @@ DisplayState *init_displaystate(void)
> >  {
> >      gchar *name;
> >      QemuConsole *con;
> > +    Object *backend = container_create(object_get_root(), "backend");
> 
> What's the rationale for keeping this in the console code ?
> 
> I'd consider this to be a similar situation to '/chardevs' and
> '/objects', and be a common container rather than UI specific.
> IOW, be created by your later patch.

I was trying to be careful on always create then on demand like
before. E.g. I was thinking maybe this container shouldn't exist when
there's no display at all.

But looks like init_displaystate() is indeed always invoked for system
code.. so yeah, perhaps I can move it over too, and drop this patch (below
will be part of last patch to use objects_get_container() instead, or part
of its splits).

> 
> >  
> >      QTAILQ_FOREACH(con, &consoles, next) {
> >          /* Hook up into the qom tree here (not in object_new()), once
> >           * all QemuConsoles are created and the order / numbering
> >           * doesn't change any more */
> >          name = g_strdup_printf("console[%d]", con->index);
> > -        object_property_add_child(container_get(object_get_root(), "/backend"),
> > -                                  name, OBJECT(con));
> > +        object_property_add_child(backend, name, OBJECT(con));
> >          g_free(name);
> >      }
> 
> 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

-- 
Peter Xu


