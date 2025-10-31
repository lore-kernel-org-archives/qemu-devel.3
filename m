Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BB0CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwjZ-0000gf-PC; Fri, 31 Oct 2025 17:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vEwjW-0000gH-Cf
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:32:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vEwjR-0004Gv-K4
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:32:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-429c4c65485so825469f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761946337; x=1762551137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gFJOesv/QdVpQAxa4r8mRd0VNlEOsmE6SdFu/J/SCg=;
 b=iaJ6I/PvF6o57Eh6/Kn+RVRXNyG1EtS8yFSkIyA31K3TN+xqQ5Bh4O5kZOJStdbnH3
 p17VvVRdBD0actKM2buMnNFeZbt5FrVvVCWcXDdWcR8to0GD6bEehX14Sq254bJ+uKSk
 n6ka/BtXtWlJZ/oyou3NXphXetARPtZx6R7oRyslXfUg6ZvitVq+QDrRBeOL0DvymVEc
 0FmloeCKdzGcGey4mCFG+zy3xEDJDkzDbj8gbEqAmKB4VxPDwh8AdX3V1P570bIi3ku8
 iFl6X6SG6RZh2IIFBRLAbE5ypdp76RDxrpJkCGvKbhnwaNoyvEsO4LbJoiS8C4NkxVRd
 Fxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761946337; x=1762551137;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7gFJOesv/QdVpQAxa4r8mRd0VNlEOsmE6SdFu/J/SCg=;
 b=Z7WGc4nHcs0+VOxZkBqwTBASJowYVDnQTG5foHnrmOJBPikkvvpSKRXohjnNMD0a7D
 0ZCBfTV37wY5I4YQ6AsPqSLc1vME2J0S/AUiegcE5di/qwKQYtBZ9Jmgtlz7Mt4xdbX1
 KHX+qKNm0M29aIYziYlbq3jYUP/Jl8iSpbDaroiHROoJCjoQJu7TtK1ncR9ozG1tyjkH
 5Z33Q5Tzpiq4+Cuk+ABt9+BqK0vNGAVMn35DGreCUgC0ytcNQxqzpHNz47audCKTZpXa
 NZlXBhsHRTPzhknzf3WTIBc4aUARJ3UpGvUYyAjk+3wOdKkwXRssLVpxloHdX+b4Ajap
 qqyA==
X-Gm-Message-State: AOJu0YzvEUwmjpHhsKEFS/amkjvOOWRbV+QTG54jgtlA7wSzz8dcDiMj
 +Ql33L7C9700uD9lLQ5T8Q3MzLCkohG5I8LLXmKcu0tVPNcyX/LLXrv6v7BRJYAwV3OCCljvjo/
 4x8Nd8i4=
X-Gm-Gg: ASbGncsXZWI5g0BhYOBDhIY6u9ieQBblijiHnPGXs4kK9Oc62HYSqdD+QsL50Kr3YJ6
 4B+Wp6UbkYIDHbDS7+08P0f8C34iw8iAlAByYEpVXKbn45DarTeKuGu/hao6Nfsd/VFjjRWZsmO
 /eh+JG8Mmv5Eu0lUvBTnj9kQlWsFUck3fxnMzoQ0uPa5S88zyJgIGjltRdUEhXcU1nT9M5pYv/y
 cRV/kRuzNXFPziQq3K7FRzcQ0hR0BVlsFQDPnmE3ojL3VLGUbWiJqOwYRrdx40MfuCGZoJdm+UD
 OZ1l2G6Ji/2VoxagW59PyGWWwI7uWBOwE4QKGSe9QDJRVsbd97mbgW1L4zN8ey+WXGTEluYDqFh
 GqHb/CCvZeCvw5McYQA0ZO2/VZaAMaA47Egck2xCSnBQmdSumLljWoLVTIaDSc7xY51LiooY4cc
 Tb
X-Google-Smtp-Source: AGHT+IFDhxmTOwDroynzlrhAYzHyyVObROFvNH3A42ylRfQg+UeTMRz+gVXXTqrnc6jl2wc9crjn0Q==
X-Received: by 2002:a5d:5d13:0:b0:429:c4bb:fbc5 with SMTP id
 ffacd0b85a97d-429c4bbfdfdmr1763899f8f.7.1761946337192; 
 Fri, 31 Oct 2025 14:32:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1405fffsm5275588f8f.45.2025.10.31.14.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 14:32:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 874F55F81E;
 Fri, 31 Oct 2025 21:32:14 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/5] virtio-gpu: Force RCU when unmapping blob
In-Reply-To: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Wed, 29 Oct 2025 15:12:44 +0900")
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Fri, 31 Oct 2025 21:32:14 +0000
Message-ID: <87zf96sqox.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> Based-on: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
> ("[PATCH] rcu: Unify force quiescent state")
>
> Unmapping a blob changes the memory map, which is protected with RCU.
> RCU is designed to minimize the read-side overhead at the cost of
> reclamation delay. While this design usually makes sense, it is
> problematic when unmapping a blob because the operation blocks all
> virtio-gpu commands and causes perceivable disruption.
>
> Minimize such the disruption with force_rcu(), which minimizes the
> reclamation delay at the cost of a read-side overhead.
>
> Dmitry, can you see if this change makes difference?
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Are you planning a re-spin now the rcu patch is merged? If the rcu
maintainers are happy I'm fine to take it via virtio-gpu/next with the
testcase.

> ---
> Akihiko Odaki (5):
>       futex: Add qemu_futex_timedwait()
>       qemu-thread: Add qemu_event_timedwait()
>       rcu: Use call_rcu() in synchronize_rcu()
>       rcu: Wake the RCU thread when draining
>       virtio-gpu: Force RCU when unmapping blob
>
>  include/qemu/futex.h          |  29 ++++++--
>  include/qemu/rcu.h            |   1 +
>  include/qemu/thread-posix.h   |  11 +++
>  include/qemu/thread.h         |   8 ++-
>  hw/display/virtio-gpu-virgl.c |   1 +
>  util/event.c                  |  34 ++++++++--
>  util/qemu-thread-posix.c      |  11 +--
>  util/rcu.c                    | 153 ++++++++++++++++++++++++------------=
------
>  8 files changed, 163 insertions(+), 85 deletions(-)
> ---
> base-commit: ee7fbe81705732785aef2cb568bbc5d8f7d2fce1
> change-id: 20251027-force_rcu-616c743373f7
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

