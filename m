Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15532EB1044
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzuHi-000460-Na; Tue, 10 Mar 2026 06:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vzuHW-00045V-SU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:25:47 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vzuHM-0002RJ-W6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:25:41 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-662abedbeb7so2028136a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773138329; cv=none;
 d=google.com; s=arc-20240605;
 b=SfsGUqXvtTRyX8plAOnOTqGFsLqdUmBK/RIhlIfkyMnCAkOhZVRv2YZM0nUaM58i45
 hxXHU3wS8DJWciD43eMGLc/J5SMeZavRMFi46WVJkcJfMkZvrZhfz3PRlRkQIamQqNex
 nRiWWSta1JG+lU+EPuc6ZC4RPL4FKpDGRpkA78+WC4ZhZslmKGmGOBZziB4g5pf9GU4Q
 Ewobg3CtutAfsx3t1Jjap9QaOXRa4HKwwc1v+r06Y2mZEWfDaRrZ1vmOBqGFIGIO2DWg
 iWBgknfrclj6Wg1lLdylrzNfyrU23DhE2p9o2anpJXslSwM1mVnYqxq+zHMUozxNVzvl
 vFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GcmA6d8dMpzQk58Sp1WO+2vqLWHHe2eFo/u76M/AXuM=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=hp/cux/GmIXmuwmoHf+GJ+iK2CA39otj+f3h+wVtUmjT4s9HSQuTgnX3o506IW8BJ+
 /jDowQ1sVkupgyVsNkd3YZe93BAgmKwbAqFp6T07FWyjsGj2AEL7URua6zirXPDxdLgR
 PgXNTx5QtwZb69IvejVyZqsgzaUeUW9TWB0/zRGGgJJN62G70VvpRBV33EI/PxSxiRC4
 vPvjHCpVelidRJne0dAaGc9vbDilgskDUaWMB77iqTQ/Uub57WBRxjcNaRm8bFtymz8l
 IJV1ROupAfCGNjV/fxIW5FoGRvvcxzHfAKPN7sOqUVsdEvDjhIUVY2bLQ7ZhkPDNH+fR
 vwLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773138329; x=1773743129; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GcmA6d8dMpzQk58Sp1WO+2vqLWHHe2eFo/u76M/AXuM=;
 b=EY+PdT0VRHiEAblBIwaUzVLaGU4duD9g9Y+4e0v+OsIvnBjcbe5XwjlrZYwBkZcrvz
 QJ/vxFKh7Bvkln91sj+FJWgGMqUURQX6Y9K4S9LWmuM4WM1t3vYBmigd5hFMvZQhUnwD
 Lf3MK+t7G3X98dFZZj7N21pgsdp1SHRgcNLNltSa8HlAS2OC1nGZcpixx+K4vYg+cuhc
 aggcrqLJgCIy6LeH0IFt4+9TZ0pXEdT+yuOx+iLqoDtlG7JuqdUEo65vpxmpFc+rUH+L
 EriUtpEkDc44/BYWLKlk6uXDQa5NFUuEkOX8cn1AVKgsVij15eXioJ/QeR/8Gm4FA4wG
 4AEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773138329; x=1773743129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GcmA6d8dMpzQk58Sp1WO+2vqLWHHe2eFo/u76M/AXuM=;
 b=Au+dOXPMBX/p64CtEVvMDtqRzSJnhe1QyvRXPgV6VcitqVDzBwlcqu0i1sA1DrcqJC
 nG8gLcmVCjMNzGChvdO1WE73cwdoPhMY6kf7AGCKSl9pQzKaQ6G1kWXjXKppWCoX1T18
 fZtXpwvQHqF00K9/p9ZZOav11u5GZ1MBqge68jSbrpNo9js07Pj475jOAonKQz/SKUfY
 iv9gAzZNRFsWJuDCysYbsJpASpZvhEmWQ4xcu6eW97zkOvsGzz9qZhjmCZiT6Il/QSoW
 6zi2DXnqCfnAtyYP+bTRatFaNDqHdPnH7bm5RmA6MafRL27Gym2IkIadmddLyhML5bes
 RrNA==
X-Gm-Message-State: AOJu0YzuEt/l+SIvg1G0Nm144JqJPDEO71w8F8qQEzJ47Zrr9oT/neWw
 9r957XFIBYzWtZgcxiMK5JWER7gJ1949cVBKoI6nyE9X9fu4SqgmQsEcejaAbVt85tMPWGbxuc7
 K2Ay0jXoTrrLCNVS1e79Gv/10bHeacD17CZ40GfsKyA==
X-Gm-Gg: ATEYQzyix2MKBq6M3PUdh7Xxa2ZzgGhIEYo5AXIPg3qhOn7uynu4IlbANXseibp5zha
 edyH6/2EKmLzkLRrp+nqLj3PH0LYD0mHmJMC91umkDXKiea3Hr2G/xqqrFKYnK+vAKG3fMofbau
 4Pk/CyW37VzxHcAIsAxq7eXFeiucOpQIPsAM3cy7qOlAev10GOaJ1ZpA9tvapeG5bHwRgdMUXs2
 RWTQtHA6BxI01Yi8e0BZTcCZDoxrCn5InEAzcOY7yv+hLbSU8yJhyyIPk9flAlA9fx/zV9Qa5eZ
 ilPRqOo=
X-Received: by 2002:a05:6402:4409:b0:660:f609:2eca with SMTP id
 4fb4d7f45d1cf-6619d527516mr8018859a12.18.1773138329177; Tue, 10 Mar 2026
 03:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-10-zhangckid@gmail.com>
 <20260309085653.GI39949@fedora>
In-Reply-To: <20260309085653.GI39949@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 10 Mar 2026 18:24:52 +0800
X-Gm-Features: AaiRm52WfwDRKDdvaSAMQ1mj26QBZOGeQsXyC-4RMLv6cNMtf5R3OVki4SnSZrc
Message-ID: <CAK3tnvKJacwYccjvZWthMtkCL8UKS=Vsg64XHT_RNiy9yyuJgQ@mail.gmail.com>
Subject: Re: [PATCH V5 09/13] monitor: Update tracking iothread users with
 holder name
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 9, 2026 at 4:57=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Mar 05, 2026 at 10:24:55PM +0800, Zhang Chen wrote:
> > Because of monitor create own iothread, and use the
> > iothread suspend/resume with bh handler and chardev handler.
> > The QOM lifecycle is hard to track. Update the legacy usage
> > of "iothread_get_aio_context()" and "iothread_put_aio_context()".
>
> As mentioned in the prevoius patch, this feature needs to be implemented
> fully in order to merged. If only half of it works, then it's not a
> feature that users can rely on.

Sure, I will try to implement it as the original iothread get/put design.

Hi Markus and Dave,  do you have any suggestion for how to track the
monitor iothread QOM lifecycle?
Need to do iothread_get/put each time when monitor_suspend/resume ?

Thanks
Chen

>
> Stefan

