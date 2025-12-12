Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98645D43362
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 01:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTrvN-0006E7-1J; Thu, 11 Dec 2025 20:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTrvL-0006Ds-AW
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 20:26:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTrvJ-0000YT-EM
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 20:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765502780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzsXIO/sjyeIcrkqjW70pwRoYZWn3rnLASPrzfCA2qk=;
 b=KEdhDo+U5NjpFxiNYGL3BraJhruv3scCcfvTvqRMn8jVG69pEaomnJ5aGp4hcSV32T9R8p
 ZpYbRhpn+yVJMRDUAJsAIcVjueBDc0RudiYv414Cyd7rX/M6X3GJXSKRgKJ9fWnSQYkORh
 o5c3egDz9BCEKXbylpFHnKQJrvrh/oY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-sFHldryNN9W1mDIXvSknsQ-1; Thu, 11 Dec 2025 20:26:18 -0500
X-MC-Unique: sFHldryNN9W1mDIXvSknsQ-1
X-Mimecast-MFC-AGG-ID: sFHldryNN9W1mDIXvSknsQ_1765502777
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47904cdb9bbso5708895e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 17:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765502777; x=1766107577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzsXIO/sjyeIcrkqjW70pwRoYZWn3rnLASPrzfCA2qk=;
 b=CkOLTw7I7Dcj5ovd+ZJpYr9xb9zaKi5W/0i9tVIxZmyqIwSn4Lco7HoVDJbNPHsYqA
 YWzB/YJDmEh5Cs7dg1BLeBXFUKm84iGOhyjacY3m94J6yW9VlYoxTtUHdM+0ksDMRiLV
 VxLWMmqYvxLyGtxNZo9PQSBD9xaKf2Lty8JW+NnlelsOa88qCdiSSzQsG0ppt8ch2cW0
 DmfEjGDGaizjRIE1AFJVhaKFdMnNUeMNPO6xPQNyQZ+n4gfUZ5K/ZBO9lJZTh9Miurgc
 2mhMyKRaD2bsHKHZJf/o80YXx0xTQeppq2qzmRZFnau4OpwJySop3ZAsCZoMFkOGbTx9
 Xq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765502777; x=1766107577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lzsXIO/sjyeIcrkqjW70pwRoYZWn3rnLASPrzfCA2qk=;
 b=N5POn7gqkcJYzqgQpORZaq1dH1CqMp3O9MMc3/ANtoctFcMC+a+U7GL4GG/Pa01AW4
 JpkGGe6NytrEy9V0f1PnNhXs0a16e4aYeSRYAoOAx6WcvO8pmjkakSwswDYjfNgfBqO1
 49Wj8qUwkh2K8C/0Qv9eKHsgyyv0+Ag6zMyQFpP+/Ok+FpeMfkZcfxFgZgRfKEIwOYYE
 gLTteXrjGpCaZYCm8o+qaTPwgzJMjHrWzQpYpJyJInGZ7o1xej7sNrqH3vA8yMdl9LvN
 1VpdJ36icIUPJCPwz/XkK8hAQy1oUEhNCaD/SXB/01hbxvbW67TlD2Z87OLC7h0R4WSn
 WQ5w==
X-Gm-Message-State: AOJu0Yw+cbEah7uV5rdnj1HrjfpgXGRG4mrmD0hfq3pma+0gVWAxonXo
 sXDCGfuCJW8jYbgkL4A9G9aB/au4LRbkAD33ZdB9/GYp91NoTWISLZojjOILN0PqX8ZxhsEynbG
 zBXmaRtD0YSus50PMQC+6Hc8AGdI4uoSDn6CsxzuTBPSpK4k779UYqRfx
X-Gm-Gg: AY/fxX4N+R8gToutCIYdXaaGuzxyyLkN9jC8cWZayRbPZ8PqM4uwxd7PeyfMKxYP68e
 yD9Oc06lXY8M73RlzaTi7qyO6VWs7/pqu0mzHFvLlcx8OjLZofRsRb9NLB2rlQxWNTaNZsM938v
 eF46xMB3xglS9ZW4E0IApGJLNK4edof9Lihpx1gp0HPB3I60ERJakD3HGEf4L8jGMjDIpUiI2Xr
 gaRaUiKSDf8Xt4I526DLIy0fcO9av4C/2U3A8dN4GhczOQm9APJuVB8BXIfdEI12A1bEXB2gdam
 JoJ9Oxacfk14WQH8ibX/p0qDK58Dg9qah6k/KYJFgmO2wQ1kN8q7XUxd8wCT/pYlLM8RXmCjrIV
 f6Yi5k5Ug02qKIeXI4+i0wt8GKQS5qjjW1oQYI2650GyZUHUQ0XhoGE+QZm3+tjAn8DzAFKLrcD
 NRVaCJmUmncpNQTJ8=
X-Received: by 2002:a05:600c:8284:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-47a8f0a42f7mr3559955e9.5.1765502777416; 
 Thu, 11 Dec 2025 17:26:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8KH/rMNfPxQup+F1U69cqQD60dHszwkGLMfmce9EStD/Ur2V29sBLnI3qQ5ueKhNJRvfmnw==
X-Received: by 2002:a05:600c:8284:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-47a8f0a42f7mr3559855e9.5.1765502777031; 
 Thu, 11 Dec 2025 17:26:17 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f74b188sm4869335e9.1.2025.12.11.17.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 17:26:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] target/i386: Fix #GP error code for INT instructions
Date: Fri, 12 Dec 2025 02:25:53 +0100
Message-ID: <20251212012552.1275269-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20250312000603.3666083-1-andrew.cooper3@citrix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> While the (intno << shift) expression is correct for indexing the IDT based on
> whether Long Mode is active, the error code itself was unchanged with AMD64,
> and is still the index with 3 bits of metadata in the bottom.

Queued, thanks.  I'm really sorry about the delay.

Paolo


