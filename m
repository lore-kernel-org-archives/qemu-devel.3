Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA2ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN8O-0001l0-Lh; Sat, 30 Aug 2025 11:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uru8g-0002e7-83
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uru8c-0001Vz-F6
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756454824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dDlKdHrChKNTu87N9kOxbM51RRf5R1hoyAkG4YmmBS/Fj443xhUgxo/rsz1v82QYxgf3Y6
 w9AoBOd8x+Dkd+yOJzCuCcKdygDzbqXN9RVH7V9vIIVeaR98tsPtj7kiaUCf4fl2MvBiBE
 fAkYWK4vf85mK1mtuxNUeoNsoryi7oI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-esiVzZJPPWuTlW4eKCku-w-1; Fri, 29 Aug 2025 04:07:02 -0400
X-MC-Unique: esiVzZJPPWuTlW4eKCku-w-1
X-Mimecast-MFC-AGG-ID: esiVzZJPPWuTlW4eKCku-w_1756454822
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3c6ae25997cso1063025f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 01:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756454822; x=1757059622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Bi9/G5Y1E3q3s8b+ZH2XPiewQeS5DnpvfLDD0YIT78+lJAzSyXl3FrH3Cwwhd0uWca
 Mm3qJbjIbpF+spWGXrg0oItjbmJGzT65TRQXwc0fku6Xqfm648V4Xe5tAMcKRyjE8Tto
 hhf/bZraw5cEwcfwpdZhT6TTAWrsPphXeD3XqnBCuHXUgXsSlhN/qw63S2X9PHyILRF+
 1h1Gd92UF34A4yPLFrPFEFScDQHC791BFIyLbPX8TWwtf2YmKIxu8Sk1dsZJwwHmc9LC
 eDAPbbXwEx86+x5/KBrcMOg0/t0qqaoh+iOxWJ872OrBIkdvIU23ooCZLXidFcmbeEeM
 4nIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwX9sgtkza+M8VYv1PuhnInJaZOQgXFYUYDcHj2NopFn04ywSAFcDp8hY+CepbiQ0kZEhorQdjBazB@nongnu.org
X-Gm-Message-State: AOJu0Yx44XRt59sEXIgX6QAte3siC3555b8AyJzwI3PNJZVuJPBBoS/c
 IhkqJdj/gZSh8fbyIucHq1v5rZr3boyc6pGboeDBeckAuYtySRKwl71gZsKo7qlV9nZF/C0OL2U
 yl6puPq4oBU49yd44dZZfxxh1Eb9IGZKTN5/95M/z5asE3YkdfesNvKwz
X-Gm-Gg: ASbGnctoqVjsN9wJOOxdrLw/W4TaGNoXEjlPCIHD0XBqYw1vfuozMKD6k3PJaYTCbzC
 Qvm1Qay+VrRstSjvRUXimd6wH/bL87bG6MnC5GXt7r2lipGOhVhbTinhG774PyWKUHWciT2ucch
 v1LLxsJr6Uy84nlzj77HV0FPJAXf07z4WyDeIH6e9pr0BloXOM4soVc8lprjvxY+SFB8f28N6gs
 TI6wQURYMjPA+zWW8NP6gYGs+XHYbO1Cftubafq2/l4RWqtJkYfbOQFFzuRuU2B8fI9lyZE6nGB
 gk9iuvOyhiptqsxVAGrJZtjiwY8fO++HOADX3gs+hvCyAhK5vrNpGes3vE8B6QgmVmug0n8UadY
 xFiGjKDMLZCq6n6nz3gW3ctt/Y5oKoNzUDnc5MjrAfuM=
X-Received: by 2002:a05:6000:2204:b0:3cd:6c09:1692 with SMTP id
 ffacd0b85a97d-3cd6c0920e9mr5717001f8f.63.1756454821569; 
 Fri, 29 Aug 2025 01:07:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg8wWtmDIVg+JsFDLKlSM4WJ46mzB9Nw7BkIDAoZDYGAdr2DRLkrLaLDTebKoAJ6FnRy5fNQ==
X-Received: by 2002:a05:6000:2204:b0:3cd:6c09:1692 with SMTP id
 ffacd0b85a97d-3cd6c0920e9mr5716967f8f.63.1756454821092; 
 Fri, 29 Aug 2025 01:07:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf1a2560c3sm2392057f8f.0.2025.08.29.01.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:07:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 00/19] hw/i386: separate isapc out from pc_piix
Date: Fri, 29 Aug 2025 10:06:59 +0200
Message-ID: <20250829080659.1422019-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


