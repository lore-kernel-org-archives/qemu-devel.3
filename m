Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613CFCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMO0-0002s3-Bu; Fri, 08 May 2026 10:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLMNu-0002hr-Ht
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLMNq-00087i-Af
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778251253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=T7b/2XPJ02WX6/0vl3IxnkfrHNSsm6mfgXxV8ILV42yrZMDZhutQ8PWiBwbjcBKdU1h84e
 pZnloclNl57bsF/OMF9vp/wY7i6P5AxU2vKcOVg3ek2tnYS6xWzgnW+30+Z+UvxwnxssS0
 6Pqg28DPZKl+zmPI+91YV41DxYY17io=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-SgazU-u8PL-88P4cg_9a3Q-1; Fri, 08 May 2026 10:40:52 -0400
X-MC-Unique: SgazU-u8PL-88P4cg_9a3Q-1
X-Mimecast-MFC-AGG-ID: SgazU-u8PL-88P4cg_9a3Q_1778251251
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48e6260968fso12918935e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778251251; x=1778856051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=sjOHQ6emhqrNySbkOIa9OFknVevK8QVVBLCiati4G0YzN663KNlBgIYcFajAtOlyOS
 NpqRbGOljt9tLN5a30LoSu8u7kPEbgLWNoSbzT4B1WhBn+U9lAVE16dtKjSZX3fPMG6O
 k6gXbeTwIkOrWhaPLBnjX7rtsx1zUMOB4+sskl8W4jaOKumCkuK5o6Sfpw0fuW02z9iL
 Lck0Iq/PKqf2TYTuYE+JLtaqEwAZxn7iLoW7rK2m0nCb1V4tMoOGCmnediJvpd2urfFR
 TaMAVdWw4O94NUaJ6w+qCFGgxR6OP99f80lpEdEv8jzpFtevuZZ7hzmmJtkaEpCNZb7S
 437w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778251251; x=1778856051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=br5A+207NofT7ogKOdm9Gh6+ocALFRDyEzcd7n/RP50uOMky9/DfUxWsS97wOPLyJE
 wlfPDaATR5jerVhiTp2/bUTZn6c7LajFRVFVi6OPOKIO1w2K/aAYcG03VZdvi10nCtJE
 c70u9IQDulVcfWnzi6KviAy0dJOf6wKj+tnTBm78fTtrxmu3Ysn2tBUFJhTVTBzLN7uw
 eMKUJlTJlfv+/9Yf01EYOgPGcpqBDFcVpNIo+bzmq182Zvc71AzdKfdWhyJbKM1/QsaD
 sj9UL9WsOuz8oAAZC3u1hG/AkAb2hAQnaoXW9a2zAStU8AaPSTOLSQconTVDlzzE+4SY
 pb7w==
X-Gm-Message-State: AOJu0Yz6fxvk2NTbINZIvx/Vrc37ATzQ2LQT6Te0mxrH6Abd8omaYSk8
 GbEmMly+RnSwxIBiPsmqOx7/lMgsj6y1lyhiW8iYWAxs2tNQbeZvr/c6WLW7sLhSrKm37l9OsNx
 RuAvV92epoL9hYfhyXQyAFEXryow6Z8Fyd1yLDeHaV8d5NG0W5muM4apo
X-Gm-Gg: AeBDieuIF+kLMpSav4D2IzaYD6LEmvFS6vNs8pzQHrvCu7VkboG+Z/O7Qi4+VYQd4Jt
 p70aUBwsK8Cv+VFP1W0IhGqYz3UdwbXe0MZ7ZR1CmV4SOntcCNw0cSCSwsxPUX8cIJUo1yV5Hjk
 jE9kIkUh0dm9RqLFz55DflnKM6ahbesCeTvlU8B4rsZAqn9NKtBnR/5+wZ3kPWbyIX/B+sIhshN
 eS/SQdKeb8FAJtObfGPqhOZRVlRlrFgwjLLLkz2l8aXF2DLMRwJ4l0CEDsW3M2LDi0Qc6bYolqb
 rCCQz7wJktgbssmb9VXv7aqmIo/j1rkz1q1Uy2aKIgee5pMLCHUdVIbXHjqYzN+hGUZkYzYDt5U
 q7CaMNArKK4vIKmN+FDSG0fiRT5PRS4SJaWHaEGe617Iw4SUWQcJvDubxFSmmjT0Tq1FuGOnCDn
 tg+daC2M1K284sdHbM3EbIOYym
X-Received: by 2002:a05:600c:1d18:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-48e51dd689fmr195909605e9.0.1778251250873; 
 Fri, 08 May 2026 07:40:50 -0700 (PDT)
X-Received: by 2002:a05:600c:1d18:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-48e51dd689fmr195908975e9.0.1778251250414; 
 Fri, 08 May 2026 07:40:50 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm4721220f8f.13.2026.05.08.07.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 07:40:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 0/3] scsi: PR live migration PREEMPT fixes
Date: Fri,  8 May 2026 16:40:45 +0200
Message-ID: <20260508144045.1958786-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260401171927.396672-1-stefanha@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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


