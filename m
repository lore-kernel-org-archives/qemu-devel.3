Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B274DCAC599
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 14:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uysqB-0003od-Is; Wed, 17 Sep 2025 10:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uysps-0003kM-Qk
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 10:08:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyspq-0007YX-Lq
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 10:08:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45dd7b15a64so9258565e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758118117; x=1758722917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YgiTGJTY0LxOgGn6UDt92LF6ESVNmp4KtoAcEsuWhjM=;
 b=Kka7FkG/3HyKuCbGEQsTemgZakoO7sECB/WTk2U1KEMl1gQ0xSDzogMF+o0yKEgYFC
 r54KQEdGns7kN4cbdfegWQRzPV4lIZqj4dE9dNxUpEESBJi0lKa7cYNlypRQOZmYv3CQ
 XpyX6I5QUWJAJ9EmtA+NLVpkrnm0QkLMhNEGVHgjTQBLPct2FLF+8H/m70fp9dDpthai
 jnZjPHtgcbqYeEE8uW2I8jv4cbvaNSekYpeMOoqdyix4Z7rRIpYJLVZ7FIXstKOho8eo
 wilgaUCzxmuz8qXDX+d30qxU74C7aII6kn0+R+tn/Pc9Fk+gnUBrVacz86fnYr7BKxQC
 0GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758118117; x=1758722917;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YgiTGJTY0LxOgGn6UDt92LF6ESVNmp4KtoAcEsuWhjM=;
 b=bTX9iBc1GbL4RyQFfNDUOntGph8rzw44uLjz42VqxNASPFjyGMloL4Xrlc3gvpCPhz
 GXitocQWvciV/WuiBVUr4YePVjWpv22VrzdGqbcYlxnRKymqHNne9mYm9gTgvemtN6fq
 KXs2aOPXOclcDBuMc2qpUhpMN4wgOKoBBx5+MMeUOEAyDwbYns567POP1JK3d9ec57aM
 scxKLVxA/spA/E7QG4Fq9HwWy8SGQVWz58W5/I/XHVOr6PuZwRq0u5HGQyGwC0uYeNnq
 YhOtrSKDgOq0CmYqftpbIJRozeT0hAy6I3wkjcgsPUM+rc8IUZQYtINzgHBsKE/XVWwe
 ZYwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8jpfJO6IzFCsMzSTYpAixsAZgACWzgIRSy9WvwTByZs3j/YrcrzMlkQ3HGqzxvEQY/xoDb55b/wgZ@nongnu.org
X-Gm-Message-State: AOJu0YyUAOvUm2KP3PvbvQEAbLTkiQnH+xqiLR9s1SBlwU9T1s310Ym6
 BQrNcX4Cypm1PAyiKsdDkrSpqNsiKNHcmS4zO4Gs5WsVwzJBiIKD10it
X-Gm-Gg: ASbGncsyF3V6kVLJzKIERjw+A0iqBMSntwM+B4fho4NO5h/Jcu+tNpD3PaoWTRhn8c2
 WTw6brtjdlAI9jj6E4JUvCi9tE4t9HiIZowCbQOipaPetduPxR7U/bavHNHicmpd3/hKfdevajt
 Nn6ba8ID2+hv0TyMu5eBQBM6lolX5GGjp8OfXsHKgL2MJvXAipmQObzVmCdKsDir0+3a0V8KcJn
 6cr0u4jD8z06V6X/7HhyLV+B9jsWwais3iTyc4tvbF2Pe8uD3tDA23RLG6DT7Un4xVj70uQ628r
 hP+6pjrrJUNMOBvkphX3XO+1Nv104ieWcHCURKFSp5603F8qbDHas/FFt034lsoowJiFtFF7Fzi
 B7P07vHtrVOia/48uHTvJD7cKq4eGHmG3tzLP7LV77nUHoEHHxSrw+Or9XSaOCg==
X-Google-Smtp-Source: AGHT+IFmEY9+X+Ji3CU8tK9avf5zhPEeSaFSriVnbzMUETlgxdf7YgmT0M/0cTeMjc9elmrze25G3w==
X-Received: by 2002:a05:600c:a30f:b0:45d:d86b:b386 with SMTP id
 5b1f17b1804b1-45f32d54496mr59818255e9.14.1758118116876; 
 Wed, 17 Sep 2025 07:08:36 -0700 (PDT)
Received: from ehlo.thunderbird.net (37-48-56-34.nat.epc.tmcz.cz.
 [37.48.56.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f32141ae9sm39291665e9.5.2025.09.17.07.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 07:08:35 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:08:01 +0200
From: Filip Hejsek <filip.hejsek@gmail.com>
To: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, amit@kernel.org,
 armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, noh4hss@gmail.com, pbonzini@redhat.com, philmd@linaro.org,
 qemu-devel@nongnu.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 nsg@linux.ibm.com
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
User-Agent: Thunderbird for Android
In-Reply-To: <aMq4Ta4aPwRgDrxR@redhat.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
 <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
 <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
 <aMq4Ta4aPwRgDrxR@redhat.com>
Message-ID: <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x330.google.com
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



On September 17, 2025 3:31:57 PM GMT+02:00, "Daniel P=2E Berrang=C3=A9" <b=
errange@redhat=2Ecom> wrote:
> [=2E=2E=2E]
> > > 2=2E create a timer polling every eg 100ms to check if the winsize h=
as
> > > changed
> [=2E=2E=2E]
>=20
> I don't think we want a timer polling for an situation that will very
> rarely arise=2E  We already add the 'chardev_resize' QMP command, which =
is
> a good enough way to kick QEMU to re-read the size=2E

So the size provided in the command would be ignored, and QEMU would inste=
ad query the pty fd?

Note that this would mean there is no size info if the command is not used=
, because the size will be 0x0 when the pty is created by QEMU (though we c=
ould add device parameters for the initial size)=2E

Best regards,
Filip

