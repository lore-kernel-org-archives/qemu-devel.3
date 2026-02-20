Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34397C54FCC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 08:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtM8f-0008GM-Od; Fri, 20 Feb 2026 03:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vtM8X-0008Fy-EQ
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 03:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vtM8U-00033f-QZ
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 03:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771577118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=e5K/6cG69ibU4D3z+25o9+2wa9BN+40WYf3ernetWeAYpYuX2TYP3UH6TUvRhVf0hseR37
 wzNU37UmeDCXur+pf5YK5KlnOsPds8pIiSQA8M2R39qQ4eVj2oxFLFMZm5Oh8pqifXfj/W
 swd2Lr5zvCAIcWt0pQNUkjYAXf2qaJc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-xCUEo99TOkqSxU9mDmkZLw-1; Fri, 20 Feb 2026 03:45:16 -0500
X-MC-Unique: xCUEo99TOkqSxU9mDmkZLw-1
X-Mimecast-MFC-AGG-ID: xCUEo99TOkqSxU9mDmkZLw_1771577115
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836c819456so13067305e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 00:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771577114; x=1772181914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Jglw7CcwPnjepMpqosAmYoVadL9k1qJJX0aVoud0RuR1p35ta+nyrsgnH8Qm4vCCuX
 8JWxRf/tTW9Mr5/O7Y/oYNPzaVy/J1aInl2uMKPIPVlpYSU7psmTjoKE2EebyID2siTF
 r1DNG2pzJp3+6koREp75PeN7YgiJLCD6/fuD5bZ1/U7RDg1e7zgt1VDuE0bgTrMWC39r
 CdI0YJcRPco8atP5VBOEcJI8+/qerAKdVc8gIRu5eMB9AgTMVPq1M09qjzh2YgF8AtO/
 C6JH3ZhOp79RCmp6NSerFf/2GpmQF+Ks+Z6T69505jEpflru1S4fsMKfIjirZHBz2wTj
 lTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771577114; x=1772181914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eDlqnwbakGCGfV23fPBhLMtfQd+JtBnZRUaRGO0zJFwEUgFeHMW4gzpUwEob3O+XKY
 b1opXBNO0W734YmPYMh+mdm26+OIda0ZM+vrQyaqWvlPlqsqAT3lT/jKRDqYV3oxRkK3
 LjnEezsWKST+b7xsXyjs3WQiufLdhH6UmvacT4udbq8Xw1IE6YqlcYSZ0R0iTXvW3rPe
 zOd4aaYxjXk6LhRBW4YYbCTG2tcX8ZR847Ffb2RAOhPO/dWspcFyXG67Ec1+4HZnbULS
 hDo/YZH0EEwFzLBXIv4DKEgsnThwx85lK9XeG0oQ+MPnphmda/5xAc7Sh1dRtZl/07G/
 z9rA==
X-Gm-Message-State: AOJu0YyQVb9HDv27b2T7hUGdF/AP1n4g0rrnIWjNPYi1dwZYaBvJPLvR
 UfqbE1707L4GP56/g8LtgELNi0c5JxWLRkXnNgs62FPkNf3WnUbojk5jkhcEgV0E2sUvhhR8LS9
 1TFgtp1l9DyMnhBAeDK7m3b0XC5PX278Z0Xt/4TS6rC8J9Qe/NLe6qnp++aBS9ln1
X-Gm-Gg: AZuq6aLHwZ6EvfGTYijaXf2T+zN7wgsBWYsYXL+6GMD+0M/n7tKN+NlC0Ud3qdV7jVt
 0XnRa8mS5QSXSBZ/lu0mtXpL8RJq8VB+u+ol7NrQUYDHQMibfU4yEfjTiSG2GW8InNuDp1lLJ04
 gLzPwGCAeL4ruzmOhFvVZr/vEpbTgl5be+LwUMsYQ2CbyzWmy9kQbFNr0KjLeYOM/JteacICFMy
 WMvPA/06/pa3n4++pfJ6Kd60g5LPUyD2SjNJMMd0V6Yigu1Q1HGcEXswuwMh9qq+VdPLRw/QoEm
 keNgG3h9WZihlZv4j0byKzas/BJCWo9d93W3bKInf2xShFa1olPMIlznT5MPf4BZGZUidQnZ26G
 +LT1CTIoFVkoFmZ/ET1q8rHy8uMuqgzyycI1AB6QT7LoRHtsMeG9ahXcmJjDj1aLQoMGWLsnYD2
 3gxHvL3KeZWLMNIfH79n4PvQk3tEc=
X-Received: by 2002:a05:600c:548e:b0:483:456a:5146 with SMTP id
 5b1f17b1804b1-483a553babfmr16629325e9.25.1771577113677; 
 Fri, 20 Feb 2026 00:45:13 -0800 (PST)
X-Received: by 2002:a05:600c:548e:b0:483:456a:5146 with SMTP id
 5b1f17b1804b1-483a553babfmr16629025e9.25.1771577113295; 
 Fri, 20 Feb 2026 00:45:13 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6b563sm54245257f8f.12.2026.02.20.00.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 00:45:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 0/1] rust: use checked_div()
Date: Fri, 20 Feb 2026 09:45:02 +0100
Message-ID: <20260220084502.212993-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219185409.708130-1-jsnow@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


