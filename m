Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EAAC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVkA-0008UD-CL; Tue, 04 Jun 2024 11:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEVk5-0008TF-6H
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:06:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEVk2-0000QD-Di
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:06:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4213485697fso32080575e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717513583; x=1718118383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wB82co2xOwVLSzzV/J4AtZZiVrrSEONyjriGyTHej3w=;
 b=StvyLFyO5ztXuePTFFh0QiIZi+NXWL3mQpazw3Cpc+2f91DIirAQTE/trS6eTEPu2n
 1walbC3uumUdWOmMTywNVhkgaoPP4rvCnFt4ujIloEoBqrKi/q2S/PJ+SRwfqqWKJa91
 R8v/jh0o7dRQ9gYLgXjlu0x8QsTpO1FpB58bPhYKegB2yawqAebtBXSkKdaUuj2o+lVh
 3hw/O4nwTV6VVmaskeAXh04B28UhReI2vzVcTQol4CBL1Q9hrXb5pafkbWwX5q6qt6gF
 tHiZ2TgusEpsp3iYFuDl0AXOe2isPjP7KgOIbc1tZraNuvlDGuAfxpgd8TLaH1RL7LRj
 uXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717513583; x=1718118383;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wB82co2xOwVLSzzV/J4AtZZiVrrSEONyjriGyTHej3w=;
 b=faIFt3haJPy/6d1rjM/fXe5EA7BmrvN/Gn6zkMKehI8PltBqUzUDcAjWf/t2m5Y9xC
 4N/4SJzRS6keb/5EaUbYLiwpMaNOXWcv6HNBbQGZLlc9VDoDhN1RhHjzH2/2MorbEX4O
 0DShOCpGyzbOAZOBst9WTUtyNBjZiUGL2usCkr8Unukj/hTvD6Rd0MejOlYemNwlM3Y9
 fS9XIHAt0nHXwJ4+BAFUyDbUn+5le71zuWtbpBST30lQdoRGgnTIvHiSPnMEX4vGqfQl
 Dpmm9KVU4Jbna0YmuB2cKdYNX5+nREudGIqXHOwLhRfpSoqzVXEz59a/46CrfuH0ZgOb
 W83g==
X-Gm-Message-State: AOJu0YzaJ0FLJ2Ew+l9KhyxOd/KWa8AG1tURKhdLoWwu7p+GougUY969
 vgylcShBmy1msPgHx+zumWW/MH7sLmf24MC6MJa3x7aRksn3uadUDNyldrGnezaze0fbT1B9F0C
 B
X-Google-Smtp-Source: AGHT+IGl1ZZLJzQ7+dAnuievyjikP9JLa5n1fistDxUaCtxR8GBJix7b/V0p8BBvPzSBSvgfIosSlg==
X-Received: by 2002:a05:6000:2a4:b0:35e:8099:67f with SMTP id
 ffacd0b85a97d-35e809907d6mr1530213f8f.16.1717513583385; 
 Tue, 04 Jun 2024 08:06:23 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04da182sm11792724f8f.54.2024.06.04.08.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 08:06:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 89F9F5F839;
 Tue,  4 Jun 2024 16:06:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] docs, tests: do not specify scsi=off for virtio-blk-pci
In-Reply-To: <20240604144320.1044464-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 4 Jun 2024 16:43:20 +0200")
References: <20240604144320.1044464-1-pbonzini@redhat.com>
Date: Tue, 04 Jun 2024 16:06:19 +0100
Message-ID: <87cyowg32s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> This has been the default forever.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

