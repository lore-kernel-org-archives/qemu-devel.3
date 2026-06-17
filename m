Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D348CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZlsb-0007OR-K3; Wed, 17 Jun 2026 04:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZlsZ-0007O4-Qz
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZlsY-0002te-Hs
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 04:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781685849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=e5I1XkuJ8NrC9phAfEQjPufQ+KjMMJ5N/JFh2cSp4Y191NYIBtkI39CsRLE2cnhyVnQmDr
 S9bTAscoX93PXUEByRpL4A+yA0GNoGRcdDEPDSpGK4xKi74V3bdEsNDGeabjpCXkgfQ8TZ
 Pv///8xI586NHBlXfGKeP1RnAzu91Mo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-IXlKcv61OrCcne3ZpmzowA-1; Wed, 17 Jun 2026 04:44:08 -0400
X-MC-Unique: IXlKcv61OrCcne3ZpmzowA-1
X-Mimecast-MFC-AGG-ID: IXlKcv61OrCcne3ZpmzowA_1781685847
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490eca575d6so30745585e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781685847; x=1782290647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=rRVPEt8BkhQC/DaCU+arzqQxi3cG0GQyyIqg03JpfvLabRYZutTf151nRePudWEkc0
 a6oib8/4Xx5cjHzUjLg6JkwwVxjYC6g94KosekfV0/ivBpoTLxJZ8TMnA19MsgANymr6
 uIlI3vPUqCtfuQkkImQj/mMWCPayOFyKAHuqwh9wpzWP8LZ4YdieJvnbRaY2TKRl2p+9
 6dH4k8RwiC9YvNuZxgRNYJAxcqOs28ZyBtBDpLGYeDqAiOGPj0Qq4vnZt5QA6M8mzvdW
 4WL0DUzf4MoUXRlZ6seu3mlTw8oGD1HpEjr3S2yrT6lweSuWvnMkfjfOckycGAilXM6N
 QUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781685847; x=1782290647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=InIcL0bBzkFDKZ11DCRdUXsqk6cRu6iRdhU9FrLPe9XFwbausoHeT/V7+36a57mqSG
 8PL6LqCYLWVc2t7mVVnRO71FeKuw6HFUH9YeJHXTHAc7AbxSZD7Y8lDIO7G9S/Zbcjj4
 P6kEC8Ty2Q9TJUnsmaqIHdYpqDoc97J+vSzwJS/f1uV8RqVD6bNZJDadG8F8H/222aef
 2ycRznz6sXXH7Iuuc36vcOds07QRfqHGtlN0gICJchNQ0b/ImLnRvsBlPqyu4ZPcuSvd
 d9Png3pt7M2AkYj7D8rSi+iwec5CnNLhHLMOQwTXTjPmLrJyENY24KK5zLxwJTbe0cF/
 ijjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9W+jIO+qsMls02IxYE3aVZpCAy2svUzEZugpAuOAcn2bXWqRKMVWJI05w7NK96PspplBrWwzKvV4kg@nongnu.org
X-Gm-Message-State: AOJu0YxcUT3CGVxuxUQYLI0tCJgnyvSWwPzNbxo4hLDX+HofShpb5TPw
 1R/tUkQsNUcVqWmQjJCmUzl1ed1njRK2557W6S6b/5MiXBu6VrKMQjawSU3jXJKLcAZOJwNzowB
 sisRVhmqpOu8eVb3BETJZcdU9Caro2gl/ISD0oc6CnBMgfDo7+3BHJXAePfC6SqXG
X-Gm-Gg: Acq92OHScpjtlIXdMUiQcwQUA/YLkL7X9/gaC0bECXHA4Lpms/Y3C1NrofqUHHq8uuE
 POjuHH/irvwy0RlsS7bpD68T7VCOH10tIKTEwRWPzSzU8pUZU5xceq9vZOwvYbMJg5z6n36gLae
 hoBPXuePsxs4lN4wGl7mFbuGorr6FmJAsfbeWgVF8YE2ktjFYYPzTHZH9LfFUEsvbBzU+w4hT3P
 Nsw4aNGHNl+ogQxTMQTUzUkhunplluLUxd55HSYI+AXvd3Zo+L18bKVcjnL+ep/e00KAtWILqsP
 NOGLFSvOf9ANZJGXULXTDwwpa8IEtCqliTkJwZhDj0WDkL6ITfv1GqeHwjyFkWCdMC+jUw7STGo
 P/ljQ+mM3shjTZ8xDyRjijfWCObIWDgux8yB7tN34FqbWv+CZWDR8xSt8F2wORZg9Fs/5pkJlrT
 2pG0/pFeeFh6CTsbQZ
X-Received: by 2002:a05:600c:6b69:b0:490:a1dc:e542 with SMTP id
 5b1f17b1804b1-49234100c1fmr23295945e9.6.1781685846990; 
 Wed, 17 Jun 2026 01:44:06 -0700 (PDT)
X-Received: by 2002:a05:600c:6b69:b0:490:a1dc:e542 with SMTP id
 5b1f17b1804b1-49234100c1fmr23295755e9.6.1781685846689; 
 Wed, 17 Jun 2026 01:44:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a8ec56sm125628875e9.9.2026.06.17.01.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:44:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] gdbstub: Update x86 control register bits
Date: Wed, 17 Jun 2026 10:44:00 +0200
Message-ID: <20260617084400.315600-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260327143413.254227-1-minipli@grsecurity.net>
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


