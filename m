Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F3CCD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 01:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXTtH-0005Yi-Ph; Wed, 10 Jun 2026 21:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wXTtA-0005Wr-J7
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 21:07:21 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wXTt4-0003a5-G8
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 21:07:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c0c3543590so49980165ad.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781140031; x=1781744831; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5o1cuuY9nGSqFrglzq++CmaLm1actRWQeFt9D5TqC4=;
 b=Smh13zP3QHudathEvuT0I/DfndA1NasPhNOhGmpbnR5kTOxFDW9ee1BOWFNtzhoyXI
 27mn8i6r1t2kYRYhvdYie0veT/aeyNbbf+sA+Y94/8GbRyjPWN8S/iqRc+3k3i8+StAN
 jI5wBEK+Cl2Rjr9H6b2zWtCfupQSqdg6HzJOqc5Fd2aanz6cjKNE55prDxYfGbojGJHb
 IKmhuC0FhcmXgNjqEsQT86c48PBYhK7cMqRWz3EKzDmQV3ztfPDV6sgzz7rKTY91eiZT
 W5QQJHenRqXNGuhxbvYMpLWF0TMZJej2yrGyAvTOLgric3HBj0Idt0jf5fgjqyO19daZ
 lyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781140031; x=1781744831;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n5o1cuuY9nGSqFrglzq++CmaLm1actRWQeFt9D5TqC4=;
 b=e0dkUv50mvfxz9b6JVz2oTcDowKivUvD+hO/z/O2m7/vg33hUe8ZTSypexgAn5frLu
 heOaety9b+0+TEh0qfPo2cKhkESvIvETyo8hPu/z9wY0a0HuqMxkUFFbpiFk1/LsmbWn
 AGvNEIEjRJxg6JulyDvwjapuT3AhFZhiNuoYk4cNxkWLpxPjX+3xX6m1k63JSrWqIIo4
 NjtoRurH8L+2UFx4O0BKzaUN80idqwskAml6eMJ0KseUdr5c5ckB7kOT0GwIVG5z3QOt
 TehkrGWTDgxjGfa9j+jUfio1j8XR0fkNk/zrckuHDUBDLKs8uzMB7BdKAhkbTrDfO12a
 K5uw==
X-Gm-Message-State: AOJu0YzjuJkLihvi6Vow81DAMWsEkfrFxd87LF+KT58bg1C0i34Njs30
 a9KRM9lOVczU0EEUQP/B8V6rp02F8ZDSQLPZgB6yj2L/q+G5WqYE4ieZ
X-Gm-Gg: Acq92OF2yMJ9DKSW4HBT/g9NhHTHBxzPlaJsnnOyfVFtzVCevXXTFzc6azXstrmd6sO
 /nnMem00u/en0FLZVOTCIbiEEYMLQNCFWsEd/uPYwoUSqemspKjyjNiYxl+03FbJ3gfM+HjkgG/
 DyUeG8h/eGofW2qWx75gfdobcKxEsrRWp4bypJRQU6BHOLfQ44la0s7hHEuA8mxlIUJJVZR45Gp
 Jy4ZjRuW50IKNqBmU28W2lLPHY/B8WjQ1a3nl+o8z06Avv36vlndf6+P5Sw0MRLtTzvUKyBaEJX
 WTNldoNAYFRWFE8umO1n0L/VHavkWo6lCx4VefQ5rUy/RnR82DyTmIcRzZwyuDZ5z1AsUX2SxgQ
 EF+3Aegmik93C30DnSbkkibh0bpernDPawnUsqdrdXMnPq98E75Mz/E1ixvp81c87py4KQwWtmD
 AiyANgsuKnPY98NtHAAhOGxa9+qixU7/gYZHvOEA==
X-Received: by 2002:a17:903:1aed:b0:2bf:800:19f8 with SMTP id
 d9443c01a7336-2c2f21a1baamr4914905ad.17.1781140031468; 
 Wed, 10 Jun 2026 18:07:11 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f84335sm258633595ad.19.2026.06.10.18.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 18:07:10 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] hw/ufs: Add Host Initiated Defragmentation (HID)
 support
To: Jeuk Kim <jeuk20.kim@samsung.com>, kwolf@redhat.com, hreitz@redhat.com, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 keosung.park@samsung.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
In-Reply-To: <20260609023909epcms2p3f8856f12fed093168aff636f8dc8f994@epcms2p3>
References: <CGME20260609023909epcms2p3f8856f12fed093168aff636f8dc8f994@epcms2p3>
 <20260609023909epcms2p3f8856f12fed093168aff636f8dc8f994@epcms2p3>
Date: Thu, 11 Jun 2026 10:06:50 +0900
Message-Id: <178114001094.7450.10496801056596423325.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 09 Jun 2026 11:39:09 +0900, Keoseong Park <keosung.park@samsung.com> wrote:
> [...]
>  include/block/ufs.h    |  18 +++
>  tests/qtest/ufs-test.c | 290 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 480 insertions(+), 7 deletions(-)
> 
> --
> 2.25.1

Thank you for your contribution.

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

