Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343B5D46BE4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 17:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl9VL-0003Ab-Uu; Wed, 28 Jan 2026 12:38:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vl9VJ-00038s-2X
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:38:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vl9VE-0008Du-SK
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769621931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QYkW7m5i0K1b67gDvBInQeElSUGMosuQrzE+xcqkE/k=;
 b=UjYg1gGSaGfI2isKRA3stxqSdEWp4xm+ktIrpBRgAz4TD8oT2ROdv6YSoaDUu+vse8Mn9q
 QlNYrWs8n3rsaAisHEyx+SfmfBB+Zs0lcVrXZK4z6u65u8lfB8trRzZSi/0g347oUvXPbv
 6dKmjmC0Gphj4En2MXbY/yHmUzG1nq4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-A_2qILaoPi-QbfNXwVLwiA-1; Wed, 28 Jan 2026 12:38:49 -0500
X-MC-Unique: A_2qILaoPi-QbfNXwVLwiA-1
X-Mimecast-MFC-AGG-ID: A_2qILaoPi-QbfNXwVLwiA_1769621929
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c6a289856eso331007885a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 09:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769621929; x=1770226729; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QYkW7m5i0K1b67gDvBInQeElSUGMosuQrzE+xcqkE/k=;
 b=DpSdiMnUptq521umFTpIXCGYj9R4UoHHa5+Cq8TxxRXy+YpYkDn2n2hlgrC7Dy+Cxi
 DyMlKqTyWrjNL24Binkj//Cq15TloHqnxKsq3+weg3vMsbMm6BIgjs9fqRohqru+ifDI
 PkERLmEmqiHJejUMwSKiKjyb0YaR45HpWRnF/fwAcEQoPo3pGBKVwHmEiPUAzLK9tFcS
 HMc9NzLx7HDeMle+55gOAh41CIfeKg2BRz5u8UsIEBUU5TFtZZyprl/8hRGTiV2MQJIh
 iZEireW4ztLG0TENHYNqegLRiAGaGA424lQhZIlw7BdOVeeg+aPngCxIx2gdL8FY0TBr
 OmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769621929; x=1770226729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYkW7m5i0K1b67gDvBInQeElSUGMosuQrzE+xcqkE/k=;
 b=P1Wv7N5K19lzMnEdDZjlazrjzmpB2gc1Gyo81avEFAhZlHORx1m3FFOqNZK2NS2gUk
 2G15fwIFXkBRKzNIuIIRyjjNucOI49TAetJcK9jwuztixBZN/ATI3HSbGrS9umTv91h6
 9l+2NsAjPQo2RZu6DeaHYkSFbSS8ftC25Bw3R64kZ2yviiTTReipLoxZaUf5vSUemT1j
 KVwSb1YdvBzV69+ZNslR97wlHiOt+XiRjy8CKrT3IGtUhaiBOqN/5zUYjLvaJ/FX7IcE
 bbkMBinUJWo9AjSpejhu2Ib46Sa+7M6YUN+lOrRCmEvKbgoF37+d1bNfU1H34Qivl8US
 6CcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs/NrowF8okYMLVhwkg363ZlqSOW7wAA5qDeyXENCEI1phRvgQU7hSwtPYnLw0UJKFx7e2GRSp/6l4@nongnu.org
X-Gm-Message-State: AOJu0YxiswftiHcEdCrgTRn11g7eSEDtz/kYdSpyG6MNkAaJmUKEp34w
 AAZ/Hbjqjrpo9LBDd7Pj9fWl8PtK29kPH3/1j45IXQ+QP9Zjh9NRyo0AQ2zUmiu2sD0qIsia2O+
 EG2x47cvYHjnK6vFY7+ImdcgUo3EY8mS8sUPFR5NchQbNXj5qs9/HOHvQ
X-Gm-Gg: AZuq6aIxWKTIvBD+vjms7HTJgkhtwvARvxT1Jld3rVx/Ay9ePrmrwkq4wiTbHeGsReR
 COajsHKT76emoLVEvJE1LIrR3Tu7MHln0RE58MyfJcLmgvLZORnG/3ELtazosdunucrWkbit1Qk
 7jQfcvtFU27wjZOk7Wal7Y3zBNYUdUjVE+23VVJBzK9TkmWjuQvxXVwh6OeXkmLP/CFbe8/IGOp
 RMAWTMVhAS5PbhDcK5bjssoRjE/gGz4AVTcltvTpQBTANPRHhIQgAWnp9pXHkotHa+zhWlHx1j/
 ZlD4M92tqnAF7s5FVNIfrvRVX8tP/yyto5/wTwj1RvqmZRbRkp/0f6NO7Nz3Fk0hnB/KUm1BOM1
 S2Q8=
X-Received: by 2002:a05:620a:1902:b0:8c7:1b49:bd5c with SMTP id
 af79cd13be357-8c728b5d81bmr27335385a.37.1769621929184; 
 Wed, 28 Jan 2026 09:38:49 -0800 (PST)
X-Received: by 2002:a05:620a:1902:b0:8c7:1b49:bd5c with SMTP id
 af79cd13be357-8c728b5d81bmr27330285a.37.1769621928568; 
 Wed, 28 Jan 2026 09:38:48 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c711d452eesm225758985a.38.2026.01.28.09.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:38:48 -0800 (PST)
Date: Wed, 28 Jan 2026 12:38:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] vfio/migration: Send migration event before device state
 transition
Message-ID: <aXpJpwLvHTAXfpon@x1.local>
References: <20260128105159.10282-1-avihaih@nvidia.com>
 <36062a37-0af5-49fc-ac06-212096fb2c30@redhat.com>
 <aXoiAsGCWRv1nwW-@x1.local>
 <cb677add-ef2b-4ec6-9ba5-13aa2a50ec90@nvidia.com>
 <aXo3mcseNxP9bJ15@x1.local>
 <591f4e36-11a8-4310-a74a-6166698d7b23@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <591f4e36-11a8-4310-a74a-6166698d7b23@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 28, 2026 at 07:13:43PM +0200, Avihai Horon wrote:
> In our case we only use the PRE_COPY_P2P prepare event. The prepare events
> for the other states are ignored.
> For re-enabling the timeout mechanism we indeed use the "regular" (not
> prepare) events.
> 
> However, this new event can be used by anyone for any purpose, so I didn't
> want to limit it only for my use case.

I see your point.

Said that, in this specific case, my worry is nobody will consume the rest
events, and then after a few years nobody can even tell why it ever
existed. Then QEMU needs to emits some never-used events forever, worrying
about breaking anyone, even if in reality they're always ignored.

Personally I think it makes more sense to add one explicit message as you
explicitly need.  Then, that message can be as generic as possible on its
own.  But I'll leave that to you and VFIO maintainers to decide.

> 
> > 
> > I do not know VFIO state machine well, also not familiar with this specific
> > problem.  So please treat them as pure questions. Anyway, it'll be always
> > nice to attach some more information into the commit log IMHO.
> 
> Sure.
> As I said earlier, I didn't want to tie this new event to my specific use
> case, but rather wanted to describe the general problem it can solve.
> But if that helps, I can add some more details in the commit message in next
> version.

That'll always be very helpful, thank you!

-- 
Peter Xu


