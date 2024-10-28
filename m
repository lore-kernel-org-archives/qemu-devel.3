Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BB5D3E2A0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 18:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Uhk-0006Fd-Tj; Mon, 28 Oct 2024 14:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Uhh-0006FK-QR
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Uhg-0005pE-Cg
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730140979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BMkDuvuHWemU2IoY680xyLxY442UIbvPm3cKHv3PpOQvdoWABq/yWpxTss/U6gqNZzxBX3
 /7kiWsZz9PnG5aNgzk1nMT2YGmDZzvZzV+8mX1A48Jiit9tFYvSMG+iIY6qd5M5fxybNPF
 S0xLn4wEHN3YaBD1FsI46NE+L26ct5s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-hR6luV6XP9CVox4bzVVsKQ-1; Mon, 28 Oct 2024 14:42:55 -0400
X-MC-Unique: hR6luV6XP9CVox4bzVVsKQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315b7b0c16so35551205e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 11:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730140974; x=1730745774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=MYMx9H4As5hJV08gYDPdRxWJMWd9uVziqKYhWeX9/X/aTxkE4y+ysHimP+T+uovOyK
 KIhtUP+4ketQ7vxAI5qoZ4PAvhzwUfMoEhiJ8WMonxb/ZFf3ZBHQfk0Goe9utf6JhXgQ
 wFVpJya8GFmhwjCJwKKlATCF3XkozXQLCdG/mFiO1aWRsbYqvMZ1r+eZIJcvxyXH04Xl
 F/d0gDNuRKAzr8GchYccVg3XtxMpsiAlE1VAKPHBlXYN97tPdIzoLsH4h0KBavj00QKj
 fiiIPx2UDNy99oftrCeiayLVqubok7EQ0gtveuyVN+KND30mnTQWfmYTFyjsKpIupPN0
 fP6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrKbQsoWJPaHMyYN+POdtI/NMP0XN+1fWXfJ7+2aLgUp5ZyoqwG8Gy1ZL04JU09/4ISW4yLvaID0iS@nongnu.org
X-Gm-Message-State: AOJu0YzttCXSTGezIHRQPSnTcvCLKFUS0y45iT/03Jm/GmWaWiDXTIhH
 PQNMFi7oh37MQaRNg36E0zXFo/+zSHsJJl87A+PVDmMHjUJtajTyWtca/Lr8YosrLHbKrcq2wIk
 WBjBN0fjPyiF5X0DTkz7b7A7RiKKKMJMXm7mX7Nb+nMWg8G3Yi+h3
X-Received: by 2002:a05:600c:1614:b0:431:44aa:ee2e with SMTP id
 5b1f17b1804b1-431aa7ff3acmr30596165e9.4.1730140974135; 
 Mon, 28 Oct 2024 11:42:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrO7cVxZ0/z7yz4vnlPr4flBFzT5G6va4+VHVjvBblqDSbuOR2op8qyuM4Kh9dAtEKdWcwqA==
X-Received: by 2002:a05:600c:1614:b0:431:44aa:ee2e with SMTP id
 5b1f17b1804b1-431aa7ff3acmr30596115e9.4.1730140973756; 
 Mon, 28 Oct 2024 11:42:53 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360c0besm118147845e9.41.2024.10.28.11.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 11:42:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] i386/cpu: Drop the check of phys_bits in
 host_cpu_realizefn()
Date: Mon, 28 Oct 2024 19:42:51 +0100
Message-ID: <20241028184251.429100-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240929085747.2023198-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


