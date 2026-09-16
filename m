Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B91C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pj4-0004ZY-P4; Wed, 16 Sep 2026 09:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pj1-0004V1-M8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pj0-0004Uo-6x
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789565457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=fv7/t+Jr73ifJOV5x7ZukQc7Ct8tgrfcaPtr7C9k94csLnO7ZQC/aboFVxBs7ZjS9y9KYz
 BlsvzdXHwpnHeFQjPSr4lBLSg4wBoks6WK+wSNkKr6Db1wxrDPRMiYDPf2fu6dAmny7p2w
 jbVLkHz0Wi+Js2PVGM1zMgLo6yyjJkU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-OxEHp0u5M7-BXYH_BarpRQ-1; Wed, 16 Sep 2026 09:30:55 -0400
X-MC-Unique: OxEHp0u5M7-BXYH_BarpRQ-1
X-Mimecast-MFC-AGG-ID: OxEHp0u5M7-BXYH_BarpRQ_1789565455
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cd55ee2f7so50613825e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789565454; x=1790170254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=VIx36PCcWJ9+z3dWLdb4iarG/Ino9DqYBJ+fxMIQJZuTRrYf92B267AL68InWL+GVt
 IxM8GAlCFLumHnY/1UQlFJPiCod8UN2LY0Q9GzmC4y8VhaXrxO3WKfAsMZF2E7QsOym1
 HlyDbXW0HEI1chszG55Cr/IUguneg3GiC6Uip7kSM/lnlWViRNFp/YSVKTau2J6y1eOh
 5zv6aUv2E5pMGzHtNXRJoRWWtACwKGn2BuY0fupZckLq7bhR4qoqtyDZxmUowyUveGhS
 ddbmAFLyz3qk3l8obS4pOzV2eg4nhmKc44wo3+3TwMs0/QG5aPXflhCRV7ULg6vOvxXI
 JKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789565454; x=1790170254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Sz/6tVMKmbSB0cZNHtTJb9xkP+ZQgbaAPnE8lbF/+rlrPpD0llMUNxTL+QMu0geTAk
 jPXACtBgYievMxeDZtXhoIjqKeQMYF16CR2WXJvTX3kru6myYp6/pz5C9cBmL6efjb4S
 Xn87cVpvrPGa/Yjv1dpu7r4AsRduFBNuL3D1Pd6nUq3G0dJjzASojxl8xNFlt0ulZMTj
 AH+ChMqbtef7fA+BXO+TSLZO/u+XfzuE2sUeNXn4gH+84UxU9yMbQXP1qIJ2ZnQborlQ
 UEJf/CbgRV+mDiLwiRlHQNbwQSJHWI3LpaJ5vH2xJLX2AhC7OH2+eD/ifRjdyFwYJ+f7
 sYTw==
X-Gm-Message-State: AFuF++mM3onhvdTmPYAcKVZHi5OKQ4aI5dYoe1W8PghnYwK5kLJqj65M
 qEMASHl8ev258yxsmUc7RrvobAPD9qvaJr2NKrwJl8l5SBcYxH62FCQRWsqnq5EtOHQk+JKotQC
 1rFjcqajDqhabUZqB5SnCLkwON6XZ+k3tmC0kYoQ2/x/3UHnJoZfzprX8
X-Gm-Gg: AYBFou1zKD53R/BygYVRhSJfmqn3mtbjiNmwVSZUv+FWISIahWhE+gHM6FdV6+5elf9
 e81ZNooz2r5KOkYoIpWTE92a/OQEeDiPAIwyeaqZFXXDUohxoF8IeOOjWvoONEKi1BAQeKJhl97
 gevpQc4dj+fH6XmzjGShzRml+hR/kWW7O8PO02+UPZ4N2CV5LHqugTCKc+UCXnm5cgE9cqRbKX8
 dPwNDIIE+is+OAXLg6ivrM5fZPUyp4txllKjoFPVFncQPA+9oEJb0GW7FImqqqYMH9tD1wAQtut
 4ummbPUlZt/5jlCvHSYcEOXXiYssivpxOvHPPUx+H5ef9ljNxMBpaePeFnX8NlRY06r1kdRDfta
 lQoD8ZgUGuQO1kgQeoDGYSv4FS4aFyVE9YNTqwp8xieac6EwXWEEmbJF9w3uhMsEJrDzbREmSIw
 wdJcxF
X-Received: by 2002:a05:600c:1f8f:b0:49c:dada:30b7 with SMTP id
 5b1f17b1804b1-49eac45ba2cmr32037035e9.2.1789565454700; 
 Wed, 16 Sep 2026 06:30:54 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8f:b0:49c:dada:30b7 with SMTP id
 5b1f17b1804b1-49eac45ba2cmr32036555e9.2.1789565454301; 
 Wed, 16 Sep 2026 06:30:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ed292fc12sm59334295e9.15.2026.09.16.06.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:30:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, zhao1.liu@intel.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, mst@redhat.com, peterx@redhat.com,
 isyanfei.xu@gmail.com, liyuxuan.darfux@bytedance.com,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] target/i386: Migrate error code only with an exception
Date: Wed, 16 Sep 2026 15:30:50 +0200
Message-ID: <20260916133050.876256-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914113817.2212058-1-yanfei.xu@bytedance.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


