Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E15E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 15:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOf8Q-0006RQ-G9; Fri, 20 Dec 2024 10:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOf8O-0006O5-7c
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 10:41:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOf8M-0003Ju-74
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 10:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734709303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dwAgECUJPJAQmZ3WVB7w+EEBiwOhpKavFEcDZxzkMdU=;
 b=cT+u8C5PuUvWUJ5yF6xsafWHkNvd9p8ZU518qI4GGDdbWVWtdipvukjlAtnWsIC8BvGi13
 Q2WqS0qstMmO3OAV2E6iwDFxybbtdGQsIm6qXV1v2XpBEM3k0wId2n3tmodUydXeuhgaLu
 R9fWjq+y8mueUz9BiwTQQ7zr7eZhgrM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-8ppaaBdeNq6R1n5_L_3aDw-1; Fri, 20 Dec 2024 10:41:42 -0500
X-MC-Unique: 8ppaaBdeNq6R1n5_L_3aDw-1
X-Mimecast-MFC-AGG-ID: 8ppaaBdeNq6R1n5_L_3aDw
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d895f91a7dso34043886d6.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 07:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734709302; x=1735314102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwAgECUJPJAQmZ3WVB7w+EEBiwOhpKavFEcDZxzkMdU=;
 b=UI7bMvRBhHDYGSll3Sv6zI8nG9gkTSnuh97N/6y+s1cEMD4V1xltJwR1iEhCQGiDgk
 UTUW/MnYwZPjdss+SSWsCSPQ/TfW5QCYYJuPaBaQMi0IsdTuuRJ8z7hySW7w2QI8jybC
 akwtpXbxpwV3Cx5ZblvSuhxGJd4TkdUAaSqICBdZK+LX+SRohrbvqqDlfnwmxzim1wNn
 0s9+nOKwW1EAD7zVEFhrJQzlr8GmtL5oeo3UuJdqaBddVHRrjgHVH0nZAp/8tFc27TtD
 84vimUNz7tXDZhDA39H+G/sZfj6nkSA638fWtFqTKVziy4TorVc+dsmjsEjjnirh/xH2
 0Jkg==
X-Gm-Message-State: AOJu0YyulAmcZVWv0HfY/9DA7tUkzj8FLwGiEAH77UrjT6+KeXURuFO9
 Lu9BrNQ7yUGsbDoC7HDad6j3PqhT2UwhMPhoSN/QLCWioVrNByk6P9O1yBY5C35NSBeUY40yQTr
 VUppD0Q/kyS6bMYihm4/ydGgHMxwC5KYaSSnYhNx+ai8+3KjvDmSL
X-Gm-Gg: ASbGnct+q+O6lgs0apGMisttGKutX/rMr12wWSkHgpJcWrVsctzYV8uaR10OdKGKsMR
 ELXTONHcw9vJ05mN6r8QYmmJStPrna1mRJiPt7YQtuuXoYKzOz89trZ58c44OnLk5T3eiOTHhjq
 ZqwP44rPxjrOqKrLHEEER/pfnfzRhoU6UZ23E6v053rL3Y0N3sP11y/mlKpk+PBJNsk/RSd5dIm
 9wsH1eJwHHCwob0J1a4m5elmtp9HrVWbRW4ifQBhco7AS5SjAin27l2zmYKvTl/wxOKu3rCUoBE
 S9QWNc3A3snktkIV2w==
X-Received: by 2002:ad4:5ce9:0:b0:6d8:9c92:654a with SMTP id
 6a1803df08f44-6dd2331e946mr57169236d6.10.1734709301801; 
 Fri, 20 Dec 2024 07:41:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHd4ADl1Xj6LCeXVLYNyRklYhXosXrTLI6q0L9msXulQvl8lwBH/ddUMGj8BvwNUdSVQRjFig==
X-Received: by 2002:ad4:5ce9:0:b0:6d8:9c92:654a with SMTP id
 6a1803df08f44-6dd2331e946mr57168916d6.10.1734709301522; 
 Fri, 20 Dec 2024 07:41:41 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea762sm18019536d6.15.2024.12.20.07.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 07:41:40 -0800 (PST)
Date: Fri, 20 Dec 2024 10:41:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 18/19] migration-test: cpr-transfer
Message-ID: <Z2WQMjtztYH9WxiC@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-19-git-send-email-steven.sistare@oracle.com>
 <Z2RQQwWuj1v1aarN@x1n>
 <b4bc3c30-45f2-4224-92a8-33a1b06bc34c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4bc3c30-45f2-4224-92a8-33a1b06bc34c@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

On Thu, Dec 19, 2024 at 05:34:59PM -0500, Steven Sistare wrote:
> > > @@ -1766,11 +1767,16 @@ static void test_precopy_common(MigrateCommon *args)
> > >           goto finish;
> > >       }
> > > -    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
> > > +    /* If has channels, then connect_uri is only used for listen defer */
> > > +    connect_uri = args->connect_channels ? NULL : args->connect_uri;
> > > +    migrate_qmp(from, to, connect_uri, args->connect_channels, "{}");
> > 
> > This smells like abuse.
> > 
> > If the test case sets connect_uri only because of below...
> > 
> > >       if (args->start.defer_target_connect) {
> > >           qtest_connect_deferred(to);
> > >           qtest_qmp_handshake(to);
> > > +        if (!strcmp(args->listen_uri, "defer")) {
> > > +            migrate_incoming_qmp(to, args->connect_uri, "{}");
> > 
> > ... here, then IMHO it's abusing connect_uri to start service incoming
> > ports.
> > 
> > We do have solution for "delay" incoming, right?   Shouldn't we use
> > migrate_get_connect_uri() instead, then never set connect_uri in
> > cpr-transfer tests?
> 
> We cannot use migrate_get_connect_uri() to get the URI to pass to
> migrate_incoming_qmp, because the migrate_incoming_qmp sets the URI
> returned by query-migrate.  chicken-and-egg problem.

Oh yes, stupid me.

> 
> I'll add channels support to migrate_incoming_qmp, like migrate_qmp.
> The cpr-transfer test will set listen_uri and connect_channels but
> will not set connect_uri.

That's still a lightweight abuse, but better than connect_uri indeed.

Hopefully cpr is the only one that uses defer_target_connect, so yeah we
can go with it at least for now..

-- 
Peter Xu


