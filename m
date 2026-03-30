Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3B9FB3CEA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w795V-0000Dq-1c; Mon, 30 Mar 2026 05:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w795K-0000Ce-CY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w795J-0003SL-0V
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774863540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=XS77VSn6+Mxe86RmP6ZdBWOpCYXyVobVrOT/vS5WjYfkfvCZOF9OVMvjYoaa03C88BKeot
 L60FqDxAWAU2h/knIfb+cvDjPKfcYl+DBnZYF3J+SkkTCnrPHpQ+PCrJavoAf5OCFrmEBX
 q+6Tcq9Oo6wjeBI758TAExRnL7/MZbE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-X0lfJoKMPqCqIT6Ztl3-mA-1; Mon, 30 Mar 2026 05:38:58 -0400
X-MC-Unique: X0lfJoKMPqCqIT6Ztl3-mA-1
X-Mimecast-MFC-AGG-ID: X0lfJoKMPqCqIT6Ztl3-mA_1774863537
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486fa35b005so53085105e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 02:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774863537; x=1775468337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=qEBYOy/UKT0+3q1URaA9hhwmxQwuCFB0z4JYxgaugLqSxaTQdd6iPOsuaESuEpZoeq
 4mFepp7dEjSACWfOS+JAnJZgtq8gHj6A5rAf1HBAdi7SGG+c84bYjo5VxYtvCoSFYqwK
 EpArqHOaiJ+kOMpBbqmKIYHAPH2KQyTHyHn8aOMgN1aedeqSZoZFMLIGItshY2hz+Rpt
 e9wENklx7YLiCPu7VA9sBomn3SBaB+mHqNcvOUWhNq2FkJaea59NkNtSIJMQ1xKJ7xHN
 pJ58VvnvPDIJBXoS6xaelKlXiA07Evgw0DYR0dYIHwFZGNQOt8fmt/TR1RxMVelPHr+6
 zOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774863537; x=1775468337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=KhSM6MUTLUi6jal8w7Vp2oHuFHMGnsbCNkHKh2D9x0jblaY3WM2zNdtQQZLr+THcwU
 N9UO5ZZJKoX5KPzkClXYDvam5djAsc/XcLEPvvjeY1uDYZBxJADoGmXsxncie66K8cQD
 Cu3kuOZgIbrI/1Kp6zetNLefFLhcBtIDUQLJMf5GhYo/ujEyIpCmUzyrsdLNM84smCTt
 GTbMEPLRax4In73+lg/bdhNyiL5ht3QF/lffAsAAEEkiW7IhtGT2E61MrtWYEmPTX99J
 AgtqT+9qt4pTcm+8Ns+g50pYhvn/9RH6HmhUmlsaQTySNb38RkV5ie9tQ/mkKP2nCE+v
 xl/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyvbedkk2tJQMMkF5Hheg3cP7Tt8mWfdntMxIc2UKOPJOSiG2/gDsAp3DfIwabAHvswYkx/S+TBYQF@nongnu.org
X-Gm-Message-State: AOJu0Yw7+skaAsSDkoDlDGD3MjLHQs/ie1jCWWHh6GZPAGVfY8zKvIJw
 8O58yAlQ9VbDlHF83UopB14EMjWn0oLiay0IW+tVNokFbuBhqhCL5iZbPD2KSHpOe+WC6XIKjN5
 qVLx+U2c8KDkej2qfF4uCTIXeeTKlPJPLuGY7jxJjezhqwD4erDcMmDjH
X-Gm-Gg: ATEYQzxWRXCuEJ7EGhK277k/KEiqHTwmMzurQjeuVaqL2NGV/MIV4wi0BDesu/BCgJC
 8SOnpQ+S1+IgAiHVO0xSUYiA2ua8/exLSKt9/OawgnjTncVtWGo39sHMr0Y3s8k5rgvDB/8B6ss
 WcF6KMzsdBvnqvVyztz4ym6osBHU6K0rNFaixXH2OoxmtqERkIj2aOIMH3xCLy5IfdbnTYSLdDR
 g40wR9GlajDG4jyQ6fZbq0c42hVXHahf5g7JWBTFrZqGR4piEWCY6oYuHm3ixnyqaY0+oH8lywm
 mUg5VIjNmuSSDUlojP1hrV5H+0OZZ/BtLEU5Kqm4aHsLXoNnU0aPegKv4VkPG56J+EZj2Xlo7h4
 83L7Zt2pRXdKN7eWosJup88RZmSxcwDjwwpdMpgh0ESxGJuBqOX1xJz1l2rruVGBKnD0jpXoVC3
 5MTKwnjZuFcDAEFMNOm/U71ZFF
X-Received: by 2002:a05:600c:6309:b0:487:1fbf:e0c5 with SMTP id
 5b1f17b1804b1-48727ef678bmr230497535e9.19.1774863537228; 
 Mon, 30 Mar 2026 02:38:57 -0700 (PDT)
X-Received: by 2002:a05:600c:6309:b0:487:1fbf:e0c5 with SMTP id
 5b1f17b1804b1-48727ef678bmr230497115e9.19.1774863536776; 
 Mon, 30 Mar 2026 02:38:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48730629033sm160865765e9.6.2026.03.30.02.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 02:38:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH for v11.0] hw/acpi: Do not save/load cpuhp state
 unconditionally
Date: Mon, 30 Mar 2026 11:38:53 +0200
Message-ID: <20260330093853.179141-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330053008.2721532-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


