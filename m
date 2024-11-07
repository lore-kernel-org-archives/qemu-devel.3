Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6714D43350
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91GV-00052L-Ty; Thu, 07 Nov 2024 07:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t91GT-00051H-Mg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:05:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t91GR-000494-Pj
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730981125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nYnxdNgigjsRADnkmGgSLY7n/5eVqnMmz9EE0WXVAYk=;
 b=ibVTy4BEd6eilOYKVmxRoasadfMYg/NPpMy8kJmB1UhotLlNFdNRUt0mHmg66J7t4FDXSu
 TGuyw7exZ85NNbEyZ3NzQ1D51+W3I155L2fmndmusJ6LDAQdQvpr2a84McFJEoiEKezGis
 Hy9ituakrHzJRkC91J2dwvDLA9GPz6Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-tjStsHNQO1iYOHNappccuQ-1; Thu, 07 Nov 2024 07:05:24 -0500
X-MC-Unique: tjStsHNQO1iYOHNappccuQ-1
X-Mimecast-MFC-AGG-ID: tjStsHNQO1iYOHNappccuQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315f48bd70so6032405e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 04:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730981123; x=1731585923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nYnxdNgigjsRADnkmGgSLY7n/5eVqnMmz9EE0WXVAYk=;
 b=AF5/01zk1jXTAfpM+70LIjHTDtOM21jgevhrQtDJK6ejFUIvPQN/4noCvXLqqvHoGP
 NtRBFLtleubRnMCVD/7kSn9Ow5Ge6sEF19X6tN6KFKl6knOk6B4mlSXFS5mb8XVbFrv2
 5EptwrS8aFS1iVFn7Fi9fmouK9toa9Ib4lcGiaJoCAqdOcBCEsoU6w35ngnl8v9r81mw
 gB9NUgYTfAGws/Wml/SC4kxwXCgs30Y4jMjFe4RtvuE20H8oYL/U1SDO9FQK8Db/evka
 +crZgXZ0ndr25+MfSq6qIQoP8ZSuugFKIa0r2jb/AZ5bsPCieMX5KuiJDn+HGNS507FO
 l1gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9KRuspoUeMws82L2eqbogd3xqf152dEjxcgsTF3L7AvQ01qVNq1mz/MEszzmq50Bb6jXko6W9y3rP@nongnu.org
X-Gm-Message-State: AOJu0Yw2akwbc5su4kA7GzyLnqlSbGDjkM9g+Kd/CuOUrgxBHLhvzVDR
 qlp/GKe1vZ6CQM+pHxENG9IPRo5aGTN+DrXCobYJdDUlYcKUAMU5AeBCare1ZPiT+h9Nl/7UvqZ
 AZZTMZjwZilF0BCbFrIP+nbdYETnuoVFobcItezU3liHNX2J/lGwGsLTLCQvI8MTkE/bQLk4ZOl
 /ADwsRDt22aroTLH19Rixv4KSIJNE=
X-Received: by 2002:a05:600c:1f17:b0:42c:bae0:f05b with SMTP id
 5b1f17b1804b1-432b2fd837bmr10038645e9.1.1730981123124; 
 Thu, 07 Nov 2024 04:05:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQpLBjj64fOI9/0nL4QyVdE3JvCTYwVgm7uobs3TXRy6drPd8meeljq+1Da0dATq/ptbdsdCKWFygRRkFkDjg=
X-Received: by 2002:a05:600c:1f17:b0:42c:bae0:f05b with SMTP id
 5b1f17b1804b1-432b2fd837bmr10038445e9.1.1730981122850; Thu, 07 Nov 2024
 04:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com>
 <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
 <87ldxw1p8k.fsf@suse.de>
In-Reply-To: <87ldxw1p8k.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 7 Nov 2024 17:35:06 +0530
Message-ID: <CAE8KmOwM2wjkyUZL5v=3gjkUNa8VhA6oick35KMX-FO2-BidaQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, 6 Nov 2024 at 18:41, Fabiano Rosas <farosas@suse.de> wrote:
> What we're thinking is having an initial exchange of information between
> src & dst as soon as migration starts and that would sync the
> capabilities and parameters between both sides. Which would then be
> followed by a channel establishment phase that would open each necessary
> channel (according to caps) in order, removing the current ambiguity.
>

* Isn't that how it works? IIUC, libvirtd(8) sends migration command
options to the destination and based on that the destination prepares
for the multifd and/or postcopy migration. In case of 'Postcopy' the
source sends 'postcopy advise' to the destination to indicate that
postcopy might follow at the end of precopy. Also, in the discussion
above Peter mentioned that libvirtd(8) may exchange list of features
between source and destination to facilitate QMP clients.

* What is the handshake doing differently? (just trying to understand)

Thank you.
---
  - Prasad


