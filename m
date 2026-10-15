Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BA0CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHFV-00081K-Mw; Thu, 15 Oct 2026 04:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHHFO-0007vo-PH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHHFN-00022A-1S
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792054532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=TLfw6MdqvI3A9s9RXiN5PRZCBTm1vn3s1UX2lv252y5WOWvQrO/aj9Ln5YB6O50UUxb+ZA
 dn9Uxa3j0CYhyTqxM6diXhKp/YUwB8b06s5YdMoqL8vwVJLrTbGIvIppTESnoSDWSziq0X
 k1aqjWR8KjOZP2BvbSeIFCRZTIbJJwo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-wNIIEE-cO96NSmL0RBz9iw-1; Thu, 15 Oct 2026 08:55:30 +0000
X-MC-Unique: wNIIEE-cO96NSmL0RBz9iw-1
X-Mimecast-MFC-AGG-ID: wNIIEE-cO96NSmL0RBz9iw_1792054529
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48c46582442so857187f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792054529; x=1792659329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=TlkjyRYwZ4se0TqT1MFKVJBuuB/IbCinZ8HJdP8l125qME/QDbH9LAf0OzJ0AS/v4H
 CI+kO4EQHwt5WjvllzpMjI2z2RNgzECCLcNfK/2rWAvKQIiejNnZMFb8GHJMf/s+Lv1q
 wDgTaL5f4RU3svcEMZoVq0r7el3HUGi0NHgsZJ6fyGnPZX1UU9A/w6mOd5I4dlMmipqS
 dH5AKRpLRRX6fNTtGzviw2ocj2D8aP/uiZ+gOFIxJqfEP0ZMmUhzup5ZAUKdlPHbG7XF
 pk2jv+vNsyTIRNNIl6vi9pe3YMfvVxkhsw/ncqj8ttZGyDWdSZf3XrtALfA9mKqPzfzW
 4W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054529; x=1792659329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=JvA5EfNaBGwEu/0EgRhaWSUVAKO9jEXg1mDEHBlrBGDrFOBIPasACUmFABoYHFItBX
 rvgh1QPnOPENeQpNjs3CNMfT/IFbtm7l9X5QMAHkg7Bil9tTE6PN1XwMcwtXWFwoQLDl
 0pTHnSXcp39AIyb8Ft8W7HuL7yY06/jT1i7gp0QivtP5TKBSRfpNvbX6JcPu1pUVQ1fz
 OLETtCTfViv3DmGF3qaG/bQtSYepOec7W5adOGF7yXBtHDjDsEzhVlqmZupy8Keezri+
 uflGIgybaAUyRutjcMlqFmN0+8d3BubkQPknJ+0UQAY2EphCN6BYPAnfRYWRHjXcApO8
 X7Uw==
X-Gm-Message-State: AFq9FYKuQDktsLBreB5/hFcpg9Qk5FVlkZsgxifbC9tZ1v5hAdPe1iEC
 FJgxluXgSvMlhkBGsp91PZo1h4KPs+Qg4V+4wc6ZeTB3gV3wdvMj48GefPU665K815Pbt9rMRoK
 H252ATBBVtRijEwk26SSqpoP3SAWwFNliI0GpA+K19sCm1eJexceI8HDk
X-Gm-Gg: AYBFou0vpSZh/fR9/m3/ySM6GU8luZ6xaG03d2l7P0I66R4fQyRoTBOy1ab9z8j68gF
 b3NLO3yFxCxhN+1FFzQCWx+q0EpQkJ3S72Dy4MHYaqLC/3FX2lVOVd/SwZZ/o9ZYN5X3C0yYBlL
 ffUmeFch4RWampX6Uad5lt9iPWAhCHundtLU16T5Y1J2ElXGndWjoaMD6/hibln000pGugU0+jA
 fqGbl5z27tFsUHssbz8orwGw3n8gI0aYLsR+RVlgySg5Uqbk/pQ/a/MT5GoZsUT08GV52MX0g9X
 MQGz+EalREc1SPOBt8vMJcifTZgT02OgAgFLb0+TkeAIhf4Thw7mUV+cA5Q3DX+4b1ZHJJzCWy0
 pFpqggg5YNnuKWAqNgoGCv9FT8JhNwY7Aeg6BoWU+sTdwh8TM7YgwczzDcrRWu0Qb5PxFBfl19n
 4I0nEw
X-Received: by 2002:a05:6000:46ca:b0:48d:f14a:9188 with SMTP id
 ffacd0b85a97d-48df14a92b1mr4289897f8f.17.1792054529546; 
 Thu, 15 Oct 2026 01:55:29 -0700 (PDT)
X-Received: by 2002:a05:6000:46ca:b0:48d:f14a:9188 with SMTP id
 ffacd0b85a97d-48df14a92b1mr4289788f8f.17.1792054528193; 
 Thu, 15 Oct 2026 01:55:28 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaa5dbsm18134477f8f.12.2026.10.15.01.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:55:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 akalenyu@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v2 0/8] scsi: clean up persistent reservation state after
 migration
Date: Thu, 15 Oct 2026 10:55:23 +0200
Message-ID: <20261015085523.804377-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013181752.1299456-1-stefanha@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Queued, thanks.

Paolo


