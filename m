Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B254BCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbfrC-0006Zi-02; Mon, 22 Jun 2026 10:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbfrA-0006ZY-HW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:42:36 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbfr9-0002Uj-3l
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:42:36 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66058b880e9so4221012d50.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782139354; cv=none;
 d=google.com; s=arc-20240605;
 b=ekMuyv1gSPn8DPtKECU+puu6it7HNYeEmelopzzFfrGqbKC2Ki5qfNBM2gIAZmhCOS
 a/EKOrl4mt7ONuxjNEVBx6XP+lW8ogMpa3sNCkwiWdfyAyM60pOrNJoUQvxdsOS2YAU3
 iE8IGJaibj5UNTnbTXBtu7U5j7yE6sse2KjHORdxLjbdY+9BeAvhORhXG6TvCQ4mpgc0
 D6Hv8ojxtYtUZQm3xHFjqEajPP7lp3tQRLxmjXrGGJjWwrkMw5QJz0CdHOTNSvG4IdIy
 YzWq3dDBlxZps1wCq4bbNetNesIpxRpPuY3bXP21cKStdMxxHY6YNWdI4Wt+lLq+8EbY
 OP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wbnknPVhxgUjoLyJUpNTJWsP5bi0yvlXS8MQN3+BiW8=;
 fh=NNdj4Jd0i7dLTkpKqg3jFEgLyI+ekas3AhEHzMkYx30=;
 b=GaNKhsActtSTc7nY1BrvsU/UwvtJy1N66o3LreLs4dlz7B2PmpZKGf16/pGWZxG33z
 RXWVnu+CP0fJM9hkRF85q7+IT7A4YGa+7hYlkGn5Qi3XkQWvxIYqgeUIDk2Nhhbgwwer
 K3j35O8SGeki/OjCNmShTxZlw9YAJeUl8NgKO3GKLOwB4g331uskstMC6YIohJQBF+if
 sSn4a4XHKNUjH7OSjEbPe+V6fDCKbXv8E/rZknHwvFay3g1Ex4is8RVS8jlKIg1tGeDB
 n2FBSbxJFAb27RRqhBUP7Nm58CFwvA0iKr1qrMm647NiFIRC1KOUdJv+14HvU4RcmjON
 ptYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782139354; x=1782744154; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wbnknPVhxgUjoLyJUpNTJWsP5bi0yvlXS8MQN3+BiW8=;
 b=rQ+P2vl91gUmAdrLsvQrBuUBujrWqrqvwcDMJcdszayHnXxtVhnfMIQXqoPgnVD6xG
 ryudEt8sfWBoKWq+b5rYRWaEDNVccwl4SQceT3/IxYZsCOc3prhu2Tl/QaPt/nKNKq+Q
 aWndnY40s8FzeYLRMG778NEFcQ0VLArhIE3miNhEf9Cc+dqF8+9+DMWt0du6A2HZrLvy
 sl6PzXkSFi7pChIuSgHDb3Gg5SHg6u/A90gpk3BNitFmGNQkg3UsGnMnmY8fcRw/sR3E
 pgomNItPGM/lWiyTOmh4WLxKuLrjLAIk3PtaWj0Af2MB4fEkA/nj0chZGQNlrHhjW4HN
 Jfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782139354; x=1782744154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wbnknPVhxgUjoLyJUpNTJWsP5bi0yvlXS8MQN3+BiW8=;
 b=ivvsJvObaTHkm87v0t5ECggBOX4sViZqs5aFXIKoj8wcgo9AQM2b5mYO3Sj6MoyXSD
 Fs5a14jSR8mmrszZpOZ9uvDjAKh7En9FZ+b02sdCIr762gunBW9tBO+fjZKq8r7TRVP+
 elROQPCtgokv/Fw27znwn06e2cosZ5cEnE42QWctJIYVdSQZmmAMFTzwekC9iM9bDi7j
 N5UCOLx/45BVZvfxBolSFKfutkce6F1MTA6m+IegHh2vwFzbhGG4afoJB2UYESt8pX1F
 awIB4xehiABm5X5dl7eaF1J+1sp4UgvP2VQGue0yYDe40stngsvLcSwFYLj1TLsY93tb
 O0kQ==
X-Gm-Message-State: AOJu0YyfcCDfJP3v/gJZqS7g0tgYb0WVm2a8N1xuRL0kvx6KRg7tPn14
 3stABsJk+2Avo9idIC591rWWDSJGFXWpaEKk096aQNPw7E27/55ZDNQMAjLNbBKKuhY34tt7GAr
 9SzLy5qOAJZuet6rakLIQzX4XHQOWYsxpzT0DI4i69g==
X-Gm-Gg: AfdE7cnh/8vbDFdTYWlRiykv3EntyL/v+6Mye4pJ3Vop1bLA7fOATBD4CaL4oASX79+
 5SpjkN5gR1zfB6UB95slHRhfJq+Lo7J02OzJ2ZHV3rzzKzithGa84yQekspGgIVPWLaQAT2mc4S
 PmuzFqpPSaOV50XomkSxsBs/Dn3kLoRyNcG9WWW53sxofJl6fiVaMl/9cVhouq1+QZUXmWDGVzk
 baRvoDN0PfgwLebJO1CJYEKG8NEoVPXJtfyy3YAcjNqMXb/iuQynN/YlhQbN0trJmTpbeWhDRPF
 bMGvfeCivrM4+bsULnW/DwwUhVKeG914CUdWsgmprDsFBrSHh/qXej6o
X-Received: by 2002:a05:690e:411:b0:662:dcc4:c6bb with SMTP id
 956f58d0204a3-662fca04321mr10997123d50.37.1782139353824; Mon, 22 Jun 2026
 07:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260529045730.90322-1-jasowang@redhat.com>
 <20260529045730.90322-6-jasowang@redhat.com>
In-Reply-To: <20260529045730.90322-6-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2026 15:42:22 +0100
X-Gm-Features: AVVi8Ce6vtiLWoScZDP27M3jCPJxl2mhe5gvfoAO8cwT1Oxf3f-XRdT2nVRd0Ic
Message-ID: <CAFEAcA_C-a_n=Xi=Jmm_ggOZmMDhjPi6G0jR+6Y3oQrPdeGtfw@mail.gmail.com>
Subject: Re: [PULL 05/15] net/tap: net_init_tap(): common fail label
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 29 May 2026 at 05:59, Jason Wang <jasowang@redhat.com> wrote:
>
> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
> Add common failure label. This:
>
> - simplifies failure paths in the function
> - get rid of unusual free_fail: in the middle of the function
> - simplify further refactoring

Hi; Coverity points out an issue with this patch (CID 160042).
Later changes have moved things about a bit but the part
that makes Coverity complain is:

> @@ -989,14 +965,13 @@ free_fail:
>              fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? NULL : script,
>                                ifname, sizeof ifname, queues > 1, errp);
>              if (fd == -1) {
> -                return -1;
> +                goto fail;

Here we will go to the fail label if fd == -1...

>              }


> +
> +fail:
> +    close(fd);

...but at the fail label we unconditionally close(fd).
That's not valid if fd == -1.

> +    if (vhost_fds) {
> +        for (i = 0; i < nvhosts; i++) {
> +            g_free(vhost_fds[i]);
> +        }
> +        g_free(vhost_fds);
> +    }
> +    if (fds) {
> +        for (i = 0; i < nfds; i++) {
> +            g_free(fds[i]);
> +        }
> +        g_free(fds);
> +    }
> +    return -1;
>  }

thanks
-- PMM

