Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED5BC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 02:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBlB7-00033I-9l; Sun, 04 May 2025 22:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBlAv-0002e7-SC
 for qemu-devel@nongnu.org; Sun, 04 May 2025 22:03:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBlAt-0003mw-5W
 for qemu-devel@nongnu.org; Sun, 04 May 2025 22:03:21 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2241053582dso57855745ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 19:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746410597; x=1747015397; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKUx5WCsG3nFKMO+b3g3M2Vk4neY4Ej5g/yKDRKsb58=;
 b=nP5ojPjGNJxGvdSmr9qyAeZ2WG0TWUT7u8wMnLAo1EHlh8rJ1DesYehourWvnc77lC
 CNfWXSDdoMgQN26QCUfyjKSCLSVrubwajEjgt7JuQ62jf0HlHip/IL7zCBZ+rHl6nTjX
 vERUCy0UGY6bgVvmGseFWA9pD/ULNwbPPmg71WWslekYW9WZkI3GXEzlqLLa6cCSijkW
 wPfCw53oXb1BKVG77iBVA2oaL4APOgOLoquEjeNr60oGNpNtJWXxCYqIOpWtoL4u8Ok0
 FBdH6PAq2PD8JMUPGduPnR/3eTaRSkckuNWx3ayxCTLRGgz+NGZ/LawT5qjw2/hdiYdR
 eS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746410597; x=1747015397;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aKUx5WCsG3nFKMO+b3g3M2Vk4neY4Ej5g/yKDRKsb58=;
 b=Dk1SsXHwHEJDViJ4k4z3Mdq/Ck4KWVdPPoj3oAdCKKS2ySCKfUJRbzm1SPVEjCO5kH
 9dV/Ipri7xA2/vRdKjkABV19SjMWNpLj3tepEVFdnAO+XMIRsqWEsIRFVet7wy18hZR6
 rPI5DT8rvGdUNPQpStRBpelZVAqgbiz+ZcRcHKZLUw6TtMEtb6ZWB++ZeogQNGgV8o4k
 ovFnn7LFSWpE0mWhJAhrnuG6Ai+eSPfj8JEjGJ+q7OJKHKq28CgABsKyyCGwISGH8jG6
 CqKR2ycFNn8TE1a5R8wh2Sxe1S8XB/1GuLJBt6ySbQO9MDsEgg++7ILvoIM+Xj9wgxyG
 7tug==
X-Gm-Message-State: AOJu0YxjCRwaxCJ5Q09il0so5n1dh8eepZNhTLAFjmOxXPd1+asfQjA+
 s7I11+ZSrJyjxgywnpaLnMPyBtS/Qx2NyMMh9VW+UTFEzq9yNPwwba6jfVfd
X-Gm-Gg: ASbGnct4TD1h1v3QyGYWijxJtE65xzBt1pW8iTQz9DxDYWgp5ueYteu5ABhq3l9Zd5A
 YvjDLdQ0ecwhdgzb7czNDm3JaMdG7rBG/g4Tz+nxEDNFYb9FVcFtjkk2lWgSsL5uq3zGQHEGJGD
 EcW0Bch/4v/k2uzutYWtDiHKUyshRygrEJV8lhxDUuFGVdRiUxN/G8BGa4EyBT0WNG5ltZA8n5t
 Dw4SMGpQKNfbD3Bt2vzIngL8CLWhpQZ8apaQ3oyEEMBKzE9cC8vau8UWMn/PY1n2VUjyr6z+Ys2
 D3y32rqUXma+BVxSav4k+bCa47CdBLQ=
X-Google-Smtp-Source: AGHT+IGbhy64nt2kVEdBWYmbF/5gARCFThgbmEuItcph0Y3ufStUwsZYZwFuGv5dh+/BJbQsYISFBQ==
X-Received: by 2002:a17:903:3c48:b0:223:5c33:56a8 with SMTP id
 d9443c01a7336-22e1ea7fe03mr94297845ad.35.1746410597441; 
 Sun, 04 May 2025 19:03:17 -0700 (PDT)
Received: from localhost ([1.146.94.19]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dbbcd0sm5701732b3a.63.2025.05.04.19.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 19:03:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 May 2025 12:03:08 +1000
Message-Id: <D9NUVWSVJKHN.3T7M6OPALIGYC@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Kevin Wolf" <kwolf@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>, "Fabiano Rosas"
 <farosas@suse.de>, "Laurent Vivier" <lvivier@redhat.com>, "Phil
 Dennis-Jordan" <phil@philjordan.eu>, "Bernhard Beschow"
 <shentey@gmail.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v4 00/22] usb/xhci and usb/msd improvements and tests
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, "Gerd Hoffmann" <kraxel@redhat.com>
X-Mailer: aerc 0.19.0
References: <20250502033047.102465-1-npiggin@gmail.com>
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

On Fri May 2, 2025 at 1:30 PM AEST, Nicholas Piggin wrote:
> This is merged from two series now because code especially the test
> cases have started to depend on one another.

Question for the list, hw/usb/* is marked orphan. I don't have the
bandwidth to take it on. There's one or two other little things that
need to be taken, e.g.,

https://lore.kernel.org/qemu-devel/20250405140002.3537411-1-linux@roeck-us.=
net/

Bernhard and Phil Dennis-Jordan have been doing some good work and
reviews on host controllers and Kevin on usb-storage. Any interest
to maintain it or do odd fixes? I suppose most are in the same boat
as me.

I would like to get this series merged, but I realize the mass storage
change to relax packet ordering of a command particularly is quite
complicated and under-reviewed.

Would there be objection if I made a pull request for Guenter's
patches, the hcd stuff, the qtests, and some of the easier / reviewed
bits of msd?

Thanks,
Nick


