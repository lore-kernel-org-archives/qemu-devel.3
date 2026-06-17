Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB873CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZndV-0001df-Jx; Wed, 17 Jun 2026 06:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZnbq-00011a-Qp
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZnbp-0003ET-Gk
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781692499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BW23yfGvxL86liMBTBf1BF7hVdyhfJYzXlb/4WdLHIE6alOE6aabrttSsfiqwpVuRzQLOi
 8IlrrnadxS9u4HOuvYgI4eW7usF8MrrGI4Eo4xXiW8ndF214zSJTzza15UDXQQ8gM3aXws
 s1EiDEA99O40CAiC3+41Ki+qH683RNQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-YHagpLqDMaCs88OaKCSbxQ-1; Wed, 17 Jun 2026 06:34:58 -0400
X-MC-Unique: YHagpLqDMaCs88OaKCSbxQ-1
X-Mimecast-MFC-AGG-ID: YHagpLqDMaCs88OaKCSbxQ_1781692497
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b79e6b94so53172765e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 03:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781692497; x=1782297297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=nOF5gqOKe7Xhx81Ey4trN6kLrqYkWHi7bY+qUqzfB5LBQBY0Z1rFbhKFSX/Q6WR2uy
 dk+kMHQecDYpz0SgxTAbq10lZVrWw96p8xGPFENQ7dPcoXKT3Spjg2YK7VLx5Y2T618Q
 iEMdTjSNqaz9lnuQUSsHPNwG34heqWBsGXL4LMaWGSYFhT+x1Sm5oG0NyMQDwgqayPVQ
 riqY/bPVZy71TMocaNDZqZMZxNTWKhj5w9TROAdmKgrM2f3tyjH/praHEkjSSWUNArcC
 r3JuP8bvksdyqlHeuxyhNPZovpeVVoQq3RKd8KF203JlToGOLNX+RR8xpmMvXvkIHDnq
 d2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781692497; x=1782297297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=cAfwUQ4RcMldWQG2CBOvQqIdc972Xx+2su2bX5Lp1Ac0h9u+aqi9YWBgjhOcEz3Rdi
 GhlBtPNB59ZsdzCE6V7QO1V8pSMKMQrlfLzQ4n17pMjoPx9T0b2W72udRrGsj6zVJs6Q
 Ws8/IpREm1D/A3tqPaqnJJurDVcaalVOh5xCk/lAZyEkLhhhhE4AaJkyT2CJVix/IL4O
 8D8/XZ1nQV0k6B03tb0iXqX0Vq3lcxPyOGPXpNVcRF3G9jolngcUeuj0q+hP/sD/qfj9
 qFzU6DcmqVHySMXsmD+zhaHC4tDUeQk1otKC6KKfjjO1jB91bqpxLrXZai9OGBsjmRK5
 OAIg==
X-Gm-Message-State: AOJu0YzA9VKVmfGmr2Jh7jdVh0VNKbXlqjRlpbTjy4C5pQiKlsi4MXaa
 5Sp4WyIrVPbYbg8OoSsd0zbAjb7ENJKHSoTD+qr5jm7ZlVSfFXCyZfQWUyoV5MEeXNShTDo+CVn
 kQ+qUdCI2/XVTE5G5hqXv2WXiJVpWbI8ke5+BLbr2X3f4fF17YODZZyjd
X-Gm-Gg: Acq92OGTRHwqtaDcnQq0Pg62vCmJq0vL+KAQ4DrWJD0tHjWMlmNROU0M5r1WxClw/pi
 l+na/gl0nE0T8SO3GRWOZy/B67A0/xNeRmhvvV5QTSHBzwEb4xPeq4RioD9GHNqJBq4yYNg4sUf
 yt8Qn0m6bZvnnvYR2j+Vedrsit7ZT7Wpu8ghhho6tO5v/eFAGRSwywHEljXOAot/qR1W70tYlIu
 oTOuKrSOkBwJGaX50SayvMmV7BrwNMhRv1E5KMbBCormqC+/Ect+Pind8cr6VUJHJmJoviiCDwG
 ZN0JzduroC0wJSMEI0sKY6EDq9ukKsjeEh+IIq2T0rNYIjS0mE+YQAAo4pAhWdyzRKh+u9F/sAL
 mRPRqXGYe6yq/k2b4mWDtIbWX9O8I2u683YgcamtEO+D6a7LAvfCwDF6rNHBv3X73ElxskPcs70
 VlLFZQ9asuSlLmQfds
X-Received: by 2002:a05:600c:6096:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-492333571f3mr57157575e9.0.1781692497265; 
 Wed, 17 Jun 2026 03:34:57 -0700 (PDT)
X-Received: by 2002:a05:600c:6096:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-492333571f3mr57157195e9.0.1781692496880; 
 Wed, 17 Jun 2026 03:34:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa5120esm161743785e9.8.2026.06.17.03.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:34:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yvugenfi@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/7] Misc QGA changes to allow building with Windows Clang
Date: Wed, 17 Jun 2026 12:34:52 +0200
Message-ID: <20260617103452.369433-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260330113906.168002-1-kkostiuk@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Paolo


