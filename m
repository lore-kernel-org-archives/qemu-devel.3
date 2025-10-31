Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B03CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 12:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnpN-0004y5-7F; Fri, 31 Oct 2025 08:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEnnz-0004kE-LT
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEnna-0007Mf-QQ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761911995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ahZwiccA6dkiKwZtI9TgqQ9R6ea8HNNprNy5lLXat7yX7T+gYUmaGAbmnatzST5cu+dnHz
 ogEehtQPo/I1Gg3chSa6rw3hs5eKy6FPFJ3SCKbnnpcgmQmJLcPWW7PdHQm6+oJ6VnIqiL
 gKQmAKhSwY02VRnUi4YdJmimXFSO9SM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-3Wd_khcSPCeVoN7kLm-nRg-1; Fri, 31 Oct 2025 07:59:54 -0400
X-MC-Unique: 3Wd_khcSPCeVoN7kLm-nRg-1
X-Mimecast-MFC-AGG-ID: 3Wd_khcSPCeVoN7kLm-nRg_1761911993
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4771e696e76so25064595e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911993; x=1762516793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=chY2fpDHQ9Ju/4kxW8o5X8IqI6oceFWMSx7EBqkEhGlwRCx+c3eGyKcCWHjI5DJSNZ
 jpxl8DeEkXM/0e3jWHdU6vPfSjtFzPkemY0RyfVse0q05h6V5QqYLVzMaSlTV0D68KRb
 Qu91Jl+eVs/zXLR/IExc81AouvlJ+xMajsF4o/ufYzkfPS5vfF1P12/+Tc6UZNtbKUU7
 hk5Gksz0XMoJYhiEsbxmKhiNC2YWsWJAn6R2mYS9lA/hCqsJPxqcSqdNkF3m6hq56RxD
 BuKOzkEm7c/d6GCE0IqyTYcfUgwZFa35x790U0OFGrUdAx0xEZN3WTCw4MIm6EzOkjGK
 cX3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGn46uzxgEWKh79yGr82rrlB7+HvXJGngxekGK+sfOQAJrvbygzW1m9HuvzTLvcVHzQhH4BT+v0oBR@nongnu.org
X-Gm-Message-State: AOJu0Yy7PKzk6qHtVtvnF3ekayKKEgMKiA5EZiEANFIHKH7PWK4tWn78
 Vk97OBWk8vF8tjDcsQPOU3eDIv2l59ga3Rnr04mtEr0T3YDtD2aN9T0l3V9K+nsVaHh2U+XNyk9
 eA/LgnZdMf31OZCUTHmE7kRtxs3ECs7ISzuWPKTbR1tyMYXg76sDOCHDb
X-Gm-Gg: ASbGnctnYVmkwfBWWxgVgIuz9rAyG/CFtG6EmcdrKuLQQGDTwENP/aFY7RIWXoW7TFF
 bDGjJ3L3aWABZRioBiIN/Ed40ZWIGpOExP4HACReIwPVNWv0UzrXPRKZ1pRo6ZB52EL4opFp3uo
 uV46mzOLC++qHGFwfT3kxwwnCex+Ce8w4A9pcK0KEr1uyZvMXGAciJm0LxALw8kRtKqA1b5ByfA
 t2tsZK2U/mSd599txvxfJZ0dTnsQBOHh7TaeEGreE8WG6oex1wqRT2z3zn5oNkfdsJbimX8Exri
 Z6kUV/C9c92r46kCBAWdWAS4Cu0maqWNN1r4C8nJ/VRpFJ+pYN/BfGv77Sj5zrs4XXorbDlQCmt
 41LRdi9JvH8rEyXka0wtLH/VOY8wNDeJp9lZepUT9sAD0z7BaDk13tSCaNTm4IFyITRQlpzHfpd
 81LocD
X-Received: by 2002:a05:600c:1d23:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-477308a8419mr32915485e9.35.1761911993261; 
 Fri, 31 Oct 2025 04:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTf29YqxAEmH/olk/WJy+Oq4HrlFsavxkkdhAwIi8MPXeInePQsuHm49m7wG06+pzXlx6v1w==
X-Received: by 2002:a05:600c:1d23:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-477308a8419mr32915325e9.35.1761911992881; 
 Fri, 31 Oct 2025 04:59:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772fbc593bsm21464765e9.1.2025.10.31.04.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 04:59:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: peter.maydell@linaro.org,
	berrange@redhat.com,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] scripts/checkpatch.pl: remove bogus patch prefix warning
Date: Fri, 31 Oct 2025 12:59:50 +0100
Message-ID: <20251031115950.225179-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251030201319.858480-1-vsementsov@yandex-team.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


