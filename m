Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD728C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 08:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjv7W-0000Bk-N8; Wed, 15 Jul 2026 04:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wjv7S-0000BR-S0
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 04:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wjv7P-0001oc-S5
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 04:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784104646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Cnmza3A9aHkENaH2pj33Y8y5nLYrZtcmeLmRPH8+2VnD8aCGVyTSazmiLmzjn23gyQONuE
 kD4XiwK7NfKuG8j1TPbSphirR03n8VDNKjLEx/Dmnsuw2oM3dJtKZ/B1D2ZLlOVD8vqduI
 vQZgTnUxk1vKluNcp0zc0Sc1C5rqcyE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-KiHbmqNPONqDvme9idAgTw-1; Wed, 15 Jul 2026 04:37:24 -0400
X-MC-Unique: KiHbmqNPONqDvme9idAgTw-1
X-Mimecast-MFC-AGG-ID: KiHbmqNPONqDvme9idAgTw_1784104643
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493bb6a4336so46432505e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784104643; x=1784709443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Z6f53wNZSg4lgztIjKevVFPn/Q63kU9VFLc4CLrGEo0V0zdxO5N+o3GNlj0JZADAV1
 KIetjsm/4GqvmOUmwEVl8QKeJRzkBFLMTGQSU8YU2FQfcMmTVDMlmRQvT9EEYV18Mu3s
 VMPxGW3ELM1XMzbseqbx0eHtrJWh4JGDMKsHlh6JjNtf0RelN7lIoDvhZHFmW+9TCUpv
 4IJy/2RNAN09tmn2oEBDdMCGERZUs0UjtlrxAEke2hOh3v+RNKhVymU/+ft3C2xag7/U
 +9hcZoBxjnst2mk5umfscIrzArhi6eZzP7oQRNyJcpKxm+DwFFDPXXIDQWfoCTJn1rBB
 YzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784104643; x=1784709443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=MqyB78jJkyhpCxcBzHLwf3ZzMoAvTDN/c9VKAa/f9dep7n2Zl+QLUvwF7UssAQ/ASN
 ZaSJzPrSWAVh+W2Is1AhaaQhOrH0OvJLtfrt9E9RDtzqqvto68LPAR2L5m+yszi0BcGs
 gJo+THUkacsLNprtZ9gJ4xBE5MUdXv95m9zDklUhOs2LYMMa4EHJQlcVEYz9XGjhBEth
 6+n5lBdd/Yov6MDAS0xcjwMi30e1pW/6zAapTEJe0abZqd/2LWZHRMtj9mnflDj+CpXs
 Y+RVoLvD0WBDLLtanKozriNFleANPlNeWM4iIwVsAJbkA2oEK76XelCt76EEVXBhrvpN
 mtMA==
X-Gm-Message-State: AOJu0YzZ1lCX2Nd7tCuxGEieJa4hKYspwRqJWVPhQtgvno8n8gpPQa+r
 zpuxxkn7fniIc7gjTi6IT/Dq1dBuxY4cdHKZU52oLVh7iV/gIoC/RT72pV+mLZGr6u7pHg+qsgI
 UhWSGvgCFFB3IwZmq3lbcFqCsGNVprE67iikgRmx7JLDE+X69qb44Q9zr
X-Gm-Gg: AfdE7ckCtaqoryFeKoLVkkRvRlM1QTwORYW/c2thjrzSGTasjGKwFwZ6IMJ9OrrVG7d
 BzdGVD6ZxrR82xNkvmyVfkttqHHf25wb5mXEsTNgJe7buMGIn5MhJuag2lTVnBulibOE3LjvLK/
 QWCltufD1nRbCCeVnrNTRG4ypKou9eMdSvH/hyCud2IEjGmXQjxuaNNOi8c9jx+v6JIj4oqD8gJ
 GhJ2UGqfXYshmTrO10MLMNBlvR4RxsRboGBt3y9sUXzipK3BYVaBDmQJH2rV7z5VZu9x20DGVGu
 pHRZdjQ1PzrlCVOyM3WON4YU8a6pmcxfRW27zWYEwWcMmBBcN0wT4L7J2cyz94EfowHma5rY5/w
 NswAe3aicDlN3CTYyy2iEiRi9Osvnnx/L+H4IiCLmGpo44AIAsIgcC0qvTWflimI/bVl8FvYuOs
 euRnn5nfy9NSQmJA==
X-Received: by 2002:a05:600c:5306:b0:495:3e2f:5105 with SMTP id
 5b1f17b1804b1-4953e2f5176mr9622665e9.12.1784104643134; 
 Wed, 15 Jul 2026 01:37:23 -0700 (PDT)
X-Received: by 2002:a05:600c:5306:b0:495:3e2f:5105 with SMTP id
 5b1f17b1804b1-4953e2f5176mr9622245e9.12.1784104642695; 
 Wed, 15 Jul 2026 01:37:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495086ca93esm136314045e9.0.2026.07.15.01.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 01:37:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] target/i386: helper_sysret(): Check that RCX contains
 a canonical address when emulating an Intel CPU
Date: Wed, 15 Jul 2026 10:37:20 +0200
Message-ID: <20260715083720.208804-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608091815.31303-1-apolivodaa433@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=pbonzini@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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


