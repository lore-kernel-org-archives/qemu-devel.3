Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131A4C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMT0a-0004wP-Jc; Tue, 03 Jun 2025 10:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMT0W-0004v2-D7
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMT0U-0003UL-1R
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748962367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=TQ699kXT2Sjdn5H89JmQkzQFpMEZW7+i+94wF84vxIW9dFq8jgt6oVTPkvXEJs2FtUH1Ke
 8yND3q0Lc2CVj57FpGWlOLGrUACafNUpL5xkwwj8OcYk6ftuUqCEKNjtPklArl+7XP6Fby
 Hea2Ev1085PctEhDKyFZesS1kxx5ouM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-VlT_3D2cOCO1YjWetiTSCQ-1; Tue, 03 Jun 2025 10:52:46 -0400
X-MC-Unique: VlT_3D2cOCO1YjWetiTSCQ-1
X-Mimecast-MFC-AGG-ID: VlT_3D2cOCO1YjWetiTSCQ_1748962365
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so1702178f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 07:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962365; x=1749567165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=n7Ad2RTTVupsz6hLkf5cwvgonVGhE8jOgQWXeeeum3d/kP0b/wGc6Rp0hRS5TmI7Uj
 fA9yXIXpG8/aB44DkO+qTik2cx0+GjVjLGB0NKDgVjk4jBphSUk771nz/7GxoWfq2gHa
 jewHIS2t598fETMRQfXbZoni0CYiXYPbRzmS1wdwT6aVRJQWfQi9GF0nS1JYFTQTZxIC
 I7/lLAz3u2Sc32wqgKiNljM6VYkRk26NfjnnZ7XOhGA3tPjzQXFfU1HIEaBRYjQANt3i
 WWqwyDuTauclLBNDITZD7B/pDZ1dAk8me1wYOC2UOG9/Zz8XDdmVT3D1VGwPb95Wu28j
 voeg==
X-Gm-Message-State: AOJu0YyJCKJXk3RPOy/NiHFe0z0xPdQW73FXEbWq/Nxm8NlSnC/EosF+
 HvX7/4jfd0Cj/7IffvtmD2+sgiGDFWkm6/ejqjOsT5YLCIA72DA88Kz/bHCV/G21t7EjUIUf5h9
 eFqgUfsC6cDYX0T/acJDiVcLDjmSWzL/GyLv/7HTkHyUHSUX5yApMT2PK
X-Gm-Gg: ASbGncu5wbM0D8rd0GNqYXsnxe44ndBs/5qzXvHiJI+WtqXzP8ZtNeFNDMAM7CSksIC
 IVfr5T50G6aIrJSXwvBQnsaxM/XGsW7U3Aa3n6sGAnSBLHj/jbAFw84wvGqKM52pIHTa2KQc1FK
 1M7tB9LEGzbNTgpvBMQV0Ei8EOx4kopxEIEoH9zBNOfUDIX5R90/AM5FLgAok5cSInSmWjAAV/Y
 sZQsT+ql+ekU2W6KqE0RD9oMav0cEXgziSc/tRpvACf91mECt8v3Ja7v4PntoEJKaSb7F7auboj
 ad7GqzmfjoH39A==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:e5ea:1ac0 with SMTP id
 ffacd0b85a97d-3a4f89a7f0bmr14088374f8f.5.1748962365218; 
 Tue, 03 Jun 2025 07:52:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDjyfDegl6q46rM2Ph3fI5w+iA5FAWdgbddweEajAzMScoWuN7H9msn/GNOv32921+tZnjqw==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:e5ea:1ac0 with SMTP id
 ffacd0b85a97d-3a4f89a7f0bmr14088353f8f.5.1748962364818; 
 Tue, 03 Jun 2025 07:52:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b7f8sm18173228f8f.3.2025.06.03.07.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:52:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/2] i386/tdx: Fix build on 32-bit host
Date: Tue,  3 Jun 2025 16:52:39 +0200
Message-ID: <20250603145239.72409-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602173101.1052983-1-clg@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Paolo


