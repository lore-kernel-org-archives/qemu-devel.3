Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0230EC98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9dNe-0001RD-Sn; Thu, 24 Sep 2026 02:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1x9dNc-0001OI-Ul
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 02:56:28 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1x9dNb-0003VT-3M
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 02:56:28 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b5e4f1b846so2048470e87.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 23:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790232983; cv=none;
 d=google.com; s=arc-20260327;
 b=Pk4MNSWyAzNTXVgQw+bDBd84bZCHa9IHtbReI0i5jF8eZyam5ONV9jugM9XUiOzojF
 x6tvRI+9GqUwUSI9N91MGSeuy6k+Pp4KXLEHHDI3zqvFwUHyxgxExGZZEiyeU/F017uo
 VCgr06wuozTzTxTdfXUWTpXIauJOk9I/1LKP4YDeuqsDDpjm3IYlFNJWgVqmwMTEez9V
 qOFU4jI95fumZo7Zo8XGs3nC7bdSyx9WVHSpgeDjUD5pUTfRAiDRs+jAiv5bhDxHwt33
 ujMCiyNXQ34if61pM1nnvqqcGFx15O9sc9S5dAtkgcU8NfoFQfAj4qficxN5+Nz+rk6Q
 glOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P4zZU/OZQ0F11NcdfHENhNAd7Ibpfqab7GYKeAE568Q=;
 fh=Gs0+7zaMh8a9SJFlKztesr9k2uez6uSrcF4K3+ppkak=;
 b=g/1ctRMdujsAC3/j/3g432cPCmLqEe2bKjjK+TT0vDxnVm+LOs7u0xB8ztD0bJgyU4
 GqM9YIVyAzTelLTVX/caQ15peXLirefRhcIQFTgwE0qTkksaws+ekpoqydjQVqH0mBDB
 86FcS00sYESuRdhFC9JmqwKzHO1h7SP8o9KIT1azt5R3MNDjwma2lgHx85QmxaSHupr0
 rMSPGhsBq9VMnq1K7LNu8B1M3sPMTWpdny1MBm8t+pcSIlhUUf2ogPLBNFcJJ3e6rYrw
 yY5PHyzvU2hGwhevHccddN0oEzrnEPLibiGsNFwfAlbf0T+useeGnJ7YhXnW90CWp/Rg
 PmXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790232983; x=1790837783; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P4zZU/OZQ0F11NcdfHENhNAd7Ibpfqab7GYKeAE568Q=;
 b=YuZ7DIfIVsF+h2gRRbawCEY8QzP2X95h3xYXed9c9/d+VUVj/Nur6HEP0LFGTTw3dk
 71hy0yCG/J+G8jwT+A+mvIDaqqgaZ2lGbIhrDrRYyp0uGR1pZZCvoINlSP0QoKQuTeQF
 SqvumfY8rEDU68SB6BUqCiBHIxDri+GZ0HVdE10Ie1mMhz+WYVXgo+uWda5Uxb5pT+gB
 MlBsA16Ko8Aek0F8FJ5fxdp7N0GcgdtrJ5IvMgF7B2qXPTIs83TK/kYhHgA2iZnyI+Oy
 eLvm1xHcxK//OjSICxFekp/mbsH8qk9SPyB6LknyGmrryFxMxxbr1pqZItMTJy9c2XBm
 H+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232983; x=1790837783;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P4zZU/OZQ0F11NcdfHENhNAd7Ibpfqab7GYKeAE568Q=;
 b=oPCv9ioIGrx7db0E3vDCVT4eSh3g+/dZTyE78jP/xv8/83yLQuV4Oi1cC9T5m+24XM
 YRNue4SOOfRCq1fBCvJOmod7L05QXAK/eTZtc7gwyGa2wOEGoDXgB/he3inDm4cfAKdX
 hM/pxBrg51dBm4V8khmu/gMniX4FwY6yYn+vFdcKKIEbGJUxw1UyF1EXgDY9J9xfSBqQ
 jejzG6i4W3ns70cpoKOlrjM+g7j3tPBHJzH+605WxchX3hKgN6/rEi5nnQZm6uPv06c/
 OCkYewkQQzRS/XvifscfqAILDDnvuAlRhJnzlzQTXpxFGhodyEZE94fXb22JWxt4soiD
 AMlQ==
X-Gm-Message-State: AFuF++nfLNqxE/ZkLbgrfM9znZMBzf3CZt3JgYTiT9rfeV43LrddIVXz
 Iz0N/8knHwV8rYZPAPNj5GV9OhZ53mJTOy8Z3qkmR8XzwWjNy7Lp1CpsI+IGyF5lgju5lSyr5B+
 MyYN2DIygitBmlAK9/qQ7kEID1zINt2o=
X-Gm-Gg: AYBFou0hxtgQbJcVem422HpdIk4lh1QAvJV8DAjPKZkyDLMiQ3qilV+OFdCqPqvlIj8
 GnsKyx795tEJZpcjnOdgo6JBWTN+XE4i4KWEQJzk6V7aGThtd1D0sSlvc5Kcm0GosZjobXl1eQ8
 E+unazUr78hTWdYrwhR2ZI5+x3TVliKa5++2C315yP5w+gro2sixVvAq/DILb1Odk5S4OZa0vgl
 s5wNgxIvF2OHKkG5QciyokVTssM2OKK9c9L1QuqgWABDbyvm7XqGh8cLnaiOZe+AlhdNQEhzvpb
 dCRAwhm6f9+xOJALMAkCZG3m75s8cVjfPn+UEzRGa6gwdQ0tECiALr1L0YnV4U6/Kg==
X-Received: by 2002:a05:6512:a8c:b0:5b8:d9bf:24e9 with SMTP id
 2adb3069b0e04-5b8df040b5fmr532133e87.10.1790232983173; Wed, 23 Sep 2026
 23:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
 <20260923-nvme-intx-fixes-v1-1-fbf0e4e567a5@gmail.com>
 <arPkoItGqH5MY7TQ@kbusch-mbp>
In-Reply-To: <arPkoItGqH5MY7TQ@kbusch-mbp>
From: =?UTF-8?Q?Markku_Ahvenj=C3=A4rvi?= <mankku@gmail.com>
Date: Thu, 24 Sep 2026 09:56:11 +0300
X-Gm-Features: AclHuK_S-Fm0b3ds28xjU4Ey-wlRVZdSFbqU-2-WkbF7EIlrJRxuct_OLSYw_eI
Message-ID: <CAO-Q3byewGo8azAhhkHSQKzU=T-h5gose1_=GXZXq3fdvvX2aA@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/nvme: prevent cq_pending underflow
To: Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=mankku@gmail.com; helo=mail-lf2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 23, 2026 at 5:39=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Sep 23, 2026 at 03:20:02PM +0300, Markku Ahvenj=C3=A4rvi wrote:
> > cq_pending counts interrupt-enabled completion queues with unconsumed
> > entries. nvme_cq_notifier() and nvme_process_db() decrement it whenever
> > a CQ becomes empty, but they may also process a notification or doorbel=
l
> > write for a CQ that was already empty.
>
> Is there a host actually doing this? If the host writes a doorbell
> register to an empty queue, that is a spec violation on the host and the
> controller should fail the queue. If it's not the admin queue, then the
> controller should to send the Invalid Doorbell Write Value AEN
> completion.

No, the host is (probably) doing the right thing.

nvme_post_cqes() also updates the CQ head, so it can run before QEMU
processes the corresponding doorbell. I observed this with ioeventfd=3Don,
where MMIO doorbell handling is asynchronous, which makes the already empty
CQ case more likely.

