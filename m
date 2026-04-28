Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C6CFF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHkjo-0000sJ-R1; Tue, 28 Apr 2026 11:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1wHkjk-0000rC-54
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:52:37 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1wHkji-0001Wj-A6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:52:35 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-50d6b393d60so41651cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 08:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777391550; cv=none;
 d=google.com; s=arc-20240605;
 b=XEkzwh1MMD0ESxfooqagF5CP3bcMPUE8NoY0nupl6c//rNkUgOC/S/AtR15NpnI55e
 tIw/wpyR9PA3x56UHdwWYGO5PZr/09cgE9/DsVzaOO4LEgc/KJKhjZe84zBZGlZlcLdZ
 /BmodCn9mS3fiYbeS+lab8gtBhwg+E4uYXGTVuBIuVrBcSxBlaD6eVP0l2X5sjevzyG5
 NlHm98PMRMsF5FuRpQmRWxpxLOaKJECvu+FssrlP4Jga9R5S8Tx8Yz4YQrmRlzwQVjx0
 41wBcy/GCcTiY32gwq9kcK31g3AA9rxuSxlxPx+F/I8HL6Lz80QIZp88YyWGQsOdlAb/
 184A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+OQdArEUlrdVMqF+Z8aQFEWtgaVLRPIfRLf1Wp+a8Qc=;
 fh=FOJ6qMn2L/EvnOlJEih8z7/36cDFYb4ibGZiJhUSBHc=;
 b=JEABr8MX89LTpqvpcI6wmsXAAFLr06C3Bj5WY1+5oTvMB1pm2+fYWYpeT5bZyfdzUl
 m9zDDkpIokPnmFyfJyYi/8r+dSwOrkNe3ljlhx4IIehxG06ljtdMePUVPIiD355ciakH
 0Cb+mg8QvQcOgyYc2/o0RB9ZiiBKQtdI1sSw1z3/KzQE4cvI3iSiA7O6ysf7mYF8SVOk
 oCdQSiKN+AEDJ6URyN04Dwj8etcahL7Yx4rPvZ1nU4MfuJmqqoZHGBdqIQaa2XomWsQB
 AHWju/X3LXB/X++HXZweUAfqPc2EhxyNtgvQYch65Pr060f08L4TCxw+V+8kx1f8VnBE
 BBaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777391550; x=1777996350; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OQdArEUlrdVMqF+Z8aQFEWtgaVLRPIfRLf1Wp+a8Qc=;
 b=LRfK3n3ceA1cxqPLJVBERSK3ChroRA9k1rcMugZPdWu320nTbeVSKAhSQuBoK7/Ghn
 ZINNP6KnkR69+F43WSvYaoKAkkbJEcDUtBwxWrhWpXOJ47Ty4EdJkt90axu9bBE5Wwec
 aras66Udlc68DRvYRM/Paz0fHpvDzkUU2b+O4R/SXpNlPfn4M078WxeXUlg7621Rb66N
 95l4iQedGxS08coX2u4M0lL0EhuaDIKeJBGYNZL7YfDJgCtzxKGsJEhetcOpsEM/ZDST
 8S6lJYa1qJKfwQ0lpHpTOj5GlZ15st7Vo9V8POh7re8LeM5AJPaygG7jy57RxY67ySGC
 fEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777391550; x=1777996350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+OQdArEUlrdVMqF+Z8aQFEWtgaVLRPIfRLf1Wp+a8Qc=;
 b=lPyyea5aUjfr9woYIebpjXLPvTBKOvIFTS++JePP1Ip+Iwj6zsuM4+YtV6XDfG+hNE
 RNet58pDAijylOpuwusNjfwlB0qbPDa+rMeDy9rqG7KVx3eEdaSpaZzt63sZJvt9zhqc
 ESD95+l1tbWYq6hMuurwe05c5S8eS2Chj2ejF0Ly5wnZtdc+RnSSF+9t9mR3J3JCoAPT
 HSFyfmcNgaQhbDpYMwnTh6IUCTUhcLbwYo7rWf3YbNpWysVCZkTFP497LfZOjRGnFRyA
 L3VNf9appw/owwi9BIt0+l6V8lkxtQlRvn50CW6clEIWwXOC7NK0d52OAtopbmL3E2M+
 Zy4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/q533bbllZrpFJdKvYT3JJGniL9ErdSLCHfxevSW5mfv5D76EUDYUZxiAl5cLO/TR+dXx+519Azs/p@nongnu.org
X-Gm-Message-State: AOJu0YwYRskdLcPRHX1Zi8oR1H5PxkRwMygxV/dfqzYPMBsZE7ZndYfR
 hc3yMJSe+GYBHU1atr2fAb0Kp0aN5alFw4Dgqz6IIQnTEaWl7cs72F0jUlIHJQmfA1gHM6t5vaZ
 vtpRqtN/wC0Gfr4zvzxeGuymzCABkcXtEQXKpsjIs
X-Gm-Gg: AeBDieuPvmXI3FffYB2cUk280WzBNo7NjB8xgvJ3BztwK4JNpHoST5DpCGmLKsBsQs3
 5PHTef+YEuUY8gnyL5qs3Z//bQdhH9k1s1wKolOUXAZL93jXrCsHy8/FRjBWBlgpRR12hJOga/l
 GlgsAhl6QBaIo14EZEB11l4Xwh9ID0G1hHJDR5Qz0RShzVVbJpcf8TC9pyVlYOdz7m5SSReS7IJ
 6l1lWxa7tEy/bF3AFjUR+E7Dez2sqUKzzWwvrnQU5HtK77zJPSca05Uz+zFVCEi0U5A5vQxzA9X
 UcwJidnvAYWURdyqyzu6zvdxo+OimLjCvP84VvcCou3OOIR30/Smu1D8iw==
X-Received: by 2002:a05:622a:4894:b0:50f:d03e:6482 with SMTP id
 d75a77b69052e-5100cac2340mr18679791cf.4.1777391549442; Tue, 28 Apr 2026
 08:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260427154441.1918536-1-rkir@google.com>
 <20260427154441.1918536-2-rkir@google.com>
 <CAJ+F1CJqa26nXaUUYU0co8DZmnFJCr4Mq2RysDXjuLhiUh9Epg@mail.gmail.com>
In-Reply-To: <CAJ+F1CJqa26nXaUUYU0co8DZmnFJCr4Mq2RysDXjuLhiUh9Epg@mail.gmail.com>
From: Roman Kiryanov <rkir@google.com>
Date: Tue, 28 Apr 2026 08:52:17 -0700
X-Gm-Features: AVHnY4L2FdKD0hvXV3KYIHMMa_pmkRnfQbOmCjNGuSbIUglcOfwVo92_8y8A_o4
Message-ID: <CAOGAQeo8gCVPwya7dnkRX+dL55Mhv8gdHm45R3B6SkZbG_oTRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] qom: improve use-after-free debugging
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=rkir@google.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Marc, thank you for looking.

On Tue, Apr 28, 2026 at 6:29=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> This one I am not sure is placed right. If the goal is to revert the
> object_initialize_with_type() effect, perhaps it should do more, in
> object_deinit() ?

I agree, I will send an update.

