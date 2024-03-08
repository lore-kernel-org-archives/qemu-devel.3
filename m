Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621D6C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 06:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riTkp-0005Vm-Pd; Fri, 08 Mar 2024 01:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1riTke-0005TW-Jl
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 01:30:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1riTkd-0007aa-2l
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 01:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709879437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+W6sRASvXqwjdCK7bojn9iVOysmj9ZzJ5/v2/KGCAI=;
 b=VU3I1BXYtA7P3b8v+RD/x8/zU9dmRJ+KYXN4UdkWNv3NcGLSUPldl1qx/3274ApvZyZUJ8
 YdJMKWPTroAc60W7ATgnSghnZnGFJOP3PuKo0rxeTmVOZ+WSMRqY20tvlqgpZcxDmWFC3d
 w8i8ljR8gKTkCGiTE4Tl5Nf28va5O7c=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-AnhRxwCxPa29xDUQ2eOeWg-1; Fri, 08 Mar 2024 01:30:35 -0500
X-MC-Unique: AnhRxwCxPa29xDUQ2eOeWg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-299783294a6so1414049a91.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 22:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709879434; x=1710484234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+W6sRASvXqwjdCK7bojn9iVOysmj9ZzJ5/v2/KGCAI=;
 b=hhVR+5E/Jy3o+CuoSoe9SE64LlWc1WCG1Mnjxnro51t7oN8/M2OlySnNs96jdv9qdJ
 8xDMrtlGZxo8K/vO066J0VGwHA+5EocmW9epupip1q6AfHQhu2TBZ7YfgqoPj9p8sDXX
 N4F7ZpwWtSzS68UPv4ZuJulDMtTeLEc747PI7HirigkkytY3sD8KqV/Mlu0sUjggI15B
 MOmnHpPBBYqsl/wAdncRepRr4CVTuKE2OXzeHG+g5sRDYCArSSLZSlTq7r4jbEWEOUzk
 uEci9BkGF86EmTpUsDIMmjJ6Bbjh1aEFvNKEPBCS04S8/PF8JW1FrbQnd4Pt6E0yB2X4
 5InA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX47s923BZQrCQi4z3dlcS0q9mk1f/6ps6zqbv5JS8oVBUCyiI+Q0hX0CtmpVP14ne9MX0LwIS6LFDQvN07LmBG6A9aV4s=
X-Gm-Message-State: AOJu0YytAX7unu1almRFNfQTNqg46FmrzPHlzWhIsrwutroy0s9/pozT
 ymNY4LueuG3fNf1JD0cWnGoXJYe5IlAwsueWXTSBAPBSSVCCs48mM/ps9KFh+OjzzN4IpK275CB
 xu61VDYpBbq/QwT92LE3adNhotnms1ZFzCMe5OkD2vPBBYkzfTeO8ki/6diHbfaLs6c9nGAEvYo
 miqmZSCx7Xc610PPq72e2EQm1SURM=
X-Received: by 2002:a17:90b:e02:b0:29b:aeed:169d with SMTP id
 ge2-20020a17090b0e0200b0029baeed169dmr1121160pjb.28.1709879434748; 
 Thu, 07 Mar 2024 22:30:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvT/FManOp76nFcw1Cp2yZJGU43Hig0Gb87biZWYDgF46T7tuU4G6w+EgFzDKekWKnpRdeIGt27EedrdyrPHY=
X-Received: by 2002:a17:90b:e02:b0:29b:aeed:169d with SMTP id
 ge2-20020a17090b0e0200b0029baeed169dmr1121144pjb.28.1709879434439; Thu, 07
 Mar 2024 22:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20240205165437.1965981-1-andrew@daynix.com>
 <CABcq3pGy+Lp8YZnMZVC61wu6jDvE0BYj3kuuvuXCA+ewOtJVfg@mail.gmail.com>
In-Reply-To: <CABcq3pGy+Lp8YZnMZVC61wu6jDvE0BYj3kuuvuXCA+ewOtJVfg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Mar 2024 14:30:23 +0800
Message-ID: <CACGkMEs9B+7SEy1naQCQwXQDd7bzRZGjxv2h_QHx8g_az6E=Fg@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] eBPF RSS through QMP support.
To: Andrew Melnichenko <andrew@daynix.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com, 
 yan@daynix.com, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 26, 2024 at 6:23=E2=80=AFPM Andrew Melnichenko <andrew@daynix.c=
om> wrote:
>
> Hi all,
> Jason, can you please review the patch set, thank you.

Queued.

Thanks


