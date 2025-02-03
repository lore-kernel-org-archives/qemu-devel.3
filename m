Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15FFC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf13O-0007mZ-2p; Mon, 03 Feb 2025 13:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf13M-0007mC-17
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:20:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf13K-0002Ie-CL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738606808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UvKRnSe8XRBzBwwfmpUj5zvFAIJeX1fzz1UJz7d4JpY=;
 b=hGDe71g8woTKzlmtCEu3FTwtT29K+ITMET4Ergr8s/TJTcnvM0ep0S4kScnOn/wFv8Wt40
 G8Uwak310M8yFnfP2mRAkR6RNL2V7YwcGH95fOVYIX07BSA3Mf08ZpbOXR62hAXV5TWViE
 obdTRqpyyFJHaal531S8BMT3SOzJrCQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-3LXuHgGZPJeA28ROSmgpCQ-1; Mon, 03 Feb 2025 13:20:03 -0500
X-MC-Unique: 3LXuHgGZPJeA28ROSmgpCQ-1
X-Mimecast-MFC-AGG-ID: 3LXuHgGZPJeA28ROSmgpCQ
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467b645935fso88680871cf.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 10:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738606803; x=1739211603;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvKRnSe8XRBzBwwfmpUj5zvFAIJeX1fzz1UJz7d4JpY=;
 b=nzM+PMI2EY8TUhF25W8D0FOAHqBR/fa5rjOcFtBItCZJLq/LiXm69CTK6MNwJ0XAhp
 B19SaXN8XiFNiPx9+tK4T84uz2k/a+faCDZrp/ZJklw2mj5eol3I0+/xwMWUtlhiuuro
 I652cUs/YzeByux1jtOGykqqiHHpHw6qOBNAjH/SrJWmi7VCfQdaCVnIiXgIJsWmmEew
 z4HTPJERTWCDgm+//GFxFBuWvw98r6Rm6yaalE4Ct6BQciC15NpigkfF46qGCbrOPH1j
 jwmqx0fql2jEWoxL/xlFS2q6no15m7a0Xl8fYH7dAA3Ih02XML1XryJ9KBjkaOqafIi4
 4V/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBe+N1UW9UBC1ek2+SqPbZKrJ99lfdzrYmCQwhDQg5UPL5j0+2phuwVvqngZJ288F8jEWPZyxB1IEV@nongnu.org
X-Gm-Message-State: AOJu0Yxd7Id6m4px5T/DItnZhBjF8T+Cd+2aEO80Dbfo0K4owrZ8WGC+
 1zX7aMVKnH2numIz8SXuKG13HDv58I3FGj4OP+yyASnsUQjKy6ZbKMiez9RJwpk2INGsnoowg/Q
 bAZJUzbGaIf+r57BpWq6pnl1F2vQV9WiZRkgk60qYKV+si8T18fl1
X-Gm-Gg: ASbGncu+7+auqv+BVJAb4hbf9+qTxd6jlvdTraG/zkHUAK7AfhxpRhBkMO8t7yST3PA
 2tHrbB9AX4gl4tGwAVXCvAyJ1Xiu6/JvEECkBYqb3ggSUgYkjVOeS8f6eR/Wed5iVep7kpWvMGD
 uRf+byCQ6KB7OYPNcjVpLuavpZMg4uF17bi0XQHp+fofHuQ4df21teE/7IR21N9376yaq+qEOw0
 SK2v3duBVJURIg+3Y0oG2dJulvqEHSPP/2vrjxeXaMsR7JvUj5BmMFypWx1PmIGGi1gT4xCetoy
 anYyFFiwjX1OgxojL8faJ8/HGC5rJnAQ4jIREiY78Ti57lJe
X-Received: by 2002:a05:622a:1306:b0:467:6941:4ecc with SMTP id
 d75a77b69052e-46fd0b6af4bmr336863741cf.39.1738606803475; 
 Mon, 03 Feb 2025 10:20:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERy6QCiEsRm38ChN9AV3P9ptSrmboZdwOxf0xaP2G3VWklV3ZWJpBdHRqbHs3SfszG6IkTwQ==
X-Received: by 2002:a05:622a:1306:b0:467:6941:4ecc with SMTP id
 d75a77b69052e-46fd0b6af4bmr336863351cf.39.1738606803159; 
 Mon, 03 Feb 2025 10:20:03 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0a7475sm51096421cf.5.2025.02.03.10.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 10:20:02 -0800 (PST)
Date: Mon, 3 Feb 2025 13:20:01 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
Message-ID: <Z6EI0V6Cg7aCbzQU@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
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

On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Multifd send channels are terminated by calling
> qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
> multifd_send_terminate_threads(), which in the TLS case essentially
> calls shutdown(SHUT_RDWR) on the underlying raw socket.
> 
> Unfortunately, this does not terminate the TLS session properly and
> the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
> 
> The only reason why this wasn't causing migration failures is because
> the current migration code apparently does not check for migration
> error being set after the end of the multifd receive process.
> 
> However, this will change soon so the multifd receive code has to be
> prepared to not return an error on such premature TLS session EOF.
> Use the newly introduced QIOChannelTLS method for that.
> 
> It's worth noting that even if the sender were to be changed to terminate
> the TLS connection properly the receive side still needs to remain
> compatible with older QEMU bit stream which does not do this.

If this is an existing bug, we could add a Fixes.

Two pure questions..

  - What is the correct way to terminate the TLS session without this flag?

  - Why this is only needed by multifd sessions?

Thanks,

-- 
Peter Xu


