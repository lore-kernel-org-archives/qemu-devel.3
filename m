Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A603CC6B16
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGer4-0007Vk-9K; Tue, 13 Oct 2026 11:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGer2-0007VG-Ln
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:55:52 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGer1-0006zS-7o
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:55:52 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8871ada1a26so536607b3.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791906950; cv=none;
 d=google.com; s=arc-20260327;
 b=jIHgl/MryjTBMxd5BYq234UGAu0keyko+wn7edF9hv1k63Uc62xO31+HiKa8dT9r7G
 FGLcc9f5Jo8wypVpFmTh5spgqvZny8kZu5DhUeu+nbF8HXnV0wkX5PLr8tetXu3RmB8Y
 oZJYK5l6HL6WMEsYA8zVPBuF17H7FCQoHI1BxviVsp0DFt7HD7WB5gsilLx/XddFaEjl
 PckLavCGT3+koQBKLx41DXBaT4UDMSYgVAW6azmgaUOdoLqKbotSXDaZIQyUh4fMGuE3
 Q4aCu8TtIKCFWL+sMQqD+8m2dVpw9PTd1OMJebNsqoc+4liCxAzZNi/js2eejwTLUMyr
 89Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sTgxmuTcgGn5AYnFZDK43ztyH8Gx3aWrWj8nhRhWJTw=;
 fh=A3b+1a6oM7IqINCrne2UT6AHch+DWmrHmde4V/WHFWs=;
 b=FJ9i5DeQhVBPOZitNpBenpcxIpLv+JHd2zZxCzs6zfFQ70fmTNEWCwTZwb9wRslNoG
 PxQ2CY1pkXCJX30dMXJsbbgHFecDbRcW4jGKT0oGkTIC75GmPXXBYV5Mrf+LfWGJOdlL
 4V0lbRdmTSl3GE+2vH82lrwlam3jt2jV73t8wIkiUh+WOdQVoAo6BZJHUWDY0whe8irk
 3ObjTh98X+BhLYiTxJjnN2cmcm36MmTD/sONbge6XCAnEyapxPPg9Te3B6BKodwTG3zj
 jmhQziBVQHPzFjwERyBfsU/NIIAUJX+9HN+Hl957HB9zALSE85NS0b/SaoWl3FwuAhw6
 XmBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791906950; x=1792511750; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sTgxmuTcgGn5AYnFZDK43ztyH8Gx3aWrWj8nhRhWJTw=;
 b=fZYVNcsepUhn7gM7DG+QDGxuNOn5Va+POXibmPjJQJCTyp7lTrwfCkGzPNmjTDgscL
 3OBYZ43zsVzsCjRDxlZpN9Lsy9qZBii7c253Dz0lh6eyqDok0DvIO6Nv8Pg/FfR8e5SI
 uhnId1o0jbQSQ5r2zKwkkvTbsSPM0LIIH7IF2/Np7PooJp5be2V4OOzEpnl7I0S+WwqV
 bWvu9x082naOSwJyGV2XRFpgm6+EYPsX5uROSoSDAqcdjyXNeWW38vLCjhUthMtcuojj
 obNIXWpN2quQtCJC8pwZAVCbSarKFPcgfh2jOndaXoXCDT2BmFLE9/ftixYXXMJZqQU+
 I3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906950; x=1792511750;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sTgxmuTcgGn5AYnFZDK43ztyH8Gx3aWrWj8nhRhWJTw=;
 b=TplVOK3U9KwprEZMQ6ldsdNLXTG1zcMDACQbkXwfabZdQfiCQGIInUJzGac3rgR1kS
 iNM4iRKbeq4APivE/dmDJiPtmAmUIANEGQJUx/HoxtZjAWbymPzCih+GN0q2cVONtYOO
 CT/YJHn+SOI7g+NX4Axtxi5VIeADjTKUVS9DBbWxcIlcYvrjcnI1PaWb1iifnHhrEw3x
 Xhm4y8rj0NDfQOBQKNOhwKN0HFDZcDZPDAOhGeDjcwGjeOBzcfAnhEjq3ggEN0t+VRxT
 gUw2NjStp/KUnE+EROQ2cQQMceMMLCaFEleil03IqkD3l+LijkyX6CNYTjKMzrnpb0Xq
 XTQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByCwT38MciswZMDkAQyX056DH1yQoL09gabX4qRglh4z2PakbyjVgSPM2tvQLrQ1sZtkpBpnbncb4G+@nongnu.org
X-Gm-Message-State: AFq9FYKU6ZyvE8Fmb5Jm/jwgzpfa6DwRGQhF8GmqPorHk6xNGZQ7MKLC
 hpw+K2i51owZiApcBJLle0oENVij/P5cCe3wKHhQK4yP2PFmvd2s55BreTGhaJn7t5VDUKgJ9S/
 a0jG05wZG5ZdlCGCBEl0HTrVlIKGHZNvC2laWDAlCCg==
X-Gm-Gg: AYBFou15f7Xd/eSInAvrCq/xdZ53ZiiKmvCASQX0TdoMV6k4Emhw+dvr9OY3UbMyCnc
 ht6k6mjhxJyPibe+CwOC7ejE/X9IHxVt5Vn9XG0gCWLfPv2yhYfzFsfqqUPlzqpNU9QJnDMmboh
 vHPtQpEyv+0AJfWz+84HzpwHnGW/lyLTmiyspV4uDbuhLapkZxU/QSaUajVTIWKgpikeM7C+9K4
 3LUkfrSl0AuH1yxWxK5RLrTUTIYuLCEhSSOmI9Ro8DUbrc74NCed/BZ/blXPimRk0QEEoPki+aT
 RI34EqnU5pz+64NRBD5PUfj0+xFlbRRJBOWVwoXyw/KathDN0wNnTEahfrYCykKMNZWdmGt+EEY
 l+bPnkPcfGbsKwgdWJ4CriJduJ83wwDR6mTPrrgY=
X-Received: by 2002:a05:690c:6601:b0:854:819:64c9 with SMTP id
 00721157ae682-8b07edb5ea4mr42017507b3.30.1791906949876; Tue, 13 Oct 2026
 08:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-8-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-8-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 16:55:38 +0100
X-Gm-Features: AclHuK9Q8ujVK1Qm61IAieZOwWt08FK4q6LtqNYYH834z9PQmll0ML6FC0JdYeA
Message-ID: <CAFEAcA-JeCRDSrRLhsuV1CGC3TnM13KLr0rYg1fR4-GY-b507g@mail.gmail.com>
Subject: Re: [PATCH 07/22] i8259_common.c: use i8259/i8259_common prefix for
 functions
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 16 Sept 2026 at 11:51, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This ensures consistency with our normal QOM-based naming convention.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/hw/isa/i8259_internal.h |  4 +--
>  hw/i386/kvm/i8259.c             |  4 +--
>  hw/intc/i8259.c                 |  4 +--
>  hw/intc/i8259_common.c          | 49 +++++++++++++++++----------------
>  4 files changed, 31 insertions(+), 30 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

