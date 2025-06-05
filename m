Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13653C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 18:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNFH0-0004IN-FK; Thu, 05 Jun 2025 14:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNFGz-0004IE-7x
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNFGx-00025F-Uf
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749147903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eM3nOMHTk9YbrDgydhdfOfCdEbC02FB/FlHXz+HD8wKxFR7TVVJtDN4U/rS6yHh98WSTrR
 9/rDwuojQz57l8RDGVnLab4Ts9WkmBJj+RKmTDqK8NE4rEfKdUiTvgwO0JRG4dOIeW53CQ
 3g/gHHKw13+PnnYlGXZa62x//0mN89g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-2NyXQmozOYuKnc9PTkz5sg-1; Thu, 05 Jun 2025 14:25:02 -0400
X-MC-Unique: 2NyXQmozOYuKnc9PTkz5sg-1
X-Mimecast-MFC-AGG-ID: 2NyXQmozOYuKnc9PTkz5sg_1749147901
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a50816cc58so520849f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 11:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749147901; x=1749752701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ryjcaMq6HpouzJj9pahd0g49OgCE548RvS1d+oUcZJvVabcXqvtL4ci/PvV2456/EF
 nVQIj/dCtsLGzwMVlcyqiNILOUaYTWWEjMh4KgpSUZDp47s3/C41n6RDinQSEGkWBP5/
 6vCBy1MjMkV1dumWTKlmVilH5RxFCCe7vC0fSAytnwAN7r/dZQotoXnvFVEaGmf89uXM
 witCiRkXDBBFtv1dkc0p28EO7WP8EtaPJj7ZH9STSrHLgimuLl5TSaeHqvZrQaUVESmO
 9q4kgNkXq1MiY5DN3J7fdBQ+sG91JjEfhrEaFJLNhZyuRy4YLrdUwMu1knjxqJlChIvI
 BEVg==
X-Gm-Message-State: AOJu0Yyz8uQFw4H485/B3ZnHrdQmM6hyq1ud50xfOIZnbKqAfM7k+Vlk
 neqhxOjtWGsUkwmuLxsg2VDRAvUPyCVZSsoSwAL199NOF3w94pUUkY5X+q/TwXffPc2dyhWPchg
 1EGAM2Ihhm12I6I9LyoadX6yFMjukDYvCGLUn3H7hBQucIsUYiuzVK5A8
X-Gm-Gg: ASbGncuN4DEMqE8t4LEsVZOQCs0FUYwlsho+eaOnpxnh9uGLJhBLAe9gIg3GIth2vj7
 gdMq+POhxrsUFTA5OzoIw663UZEYKcuFE3yDxT3bkipUGwVG9KQ2qyTIVp8ro5mfZcIhc4bfPoz
 If9nKz2y2zpCJBWUhuma28t4LsxesV/P1j58x0cjgo8/J/VeuvqgfCYzsOuIFaqhPGMb7biCoux
 xEccpPYhWaSxcyGakpusujx6vBjsVzH11Ojfvgde234FeUtP/HvP8PvDVu1apTqwzkMwU3AMIN2
 1CUY+t/B4Z1kgw==
X-Received: by 2002:a05:6000:4212:b0:3a4:e844:745d with SMTP id
 ffacd0b85a97d-3a531cf5420mr111615f8f.56.1749147900828; 
 Thu, 05 Jun 2025 11:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5E3btI45fTIjiwP/NKAqebz5oOum5PoAfffBp7dp2nDkWuZMOJZr57RNpqO0XTRdFJxk+UA==
X-Received: by 2002:a05:6000:4212:b0:3a4:e844:745d with SMTP id
 ffacd0b85a97d-3a531cf5420mr111596f8f.56.1749147900453; 
 Thu, 05 Jun 2025 11:25:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6d50sm1022355e9.5.2025.06.05.11.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 11:24:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 0/4] target/i386: Emulate ftz and denormal flag bits
 correctly
Date: Thu,  5 Jun 2025 20:24:56 +0200
Message-ID: <20250605182456.464131-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519145114.2786534-1-peter.maydell@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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


