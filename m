Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2859ACC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGboK-0005fY-QY; Tue, 13 Oct 2026 08:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGboI-0005f4-Rh
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:40:51 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGboG-0007KS-A8
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:40:50 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ab38a051aaso21989027b3.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 05:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791895246; cv=none;
 d=google.com; s=arc-20260327;
 b=BL0OR+3Aju/7kCStZH5q7uZyAMhF/e+lxs0jz0r/A+mW/N35zN0Ju2ElvhbJxMYAMT
 t8a7hLuzwVz8PowzrY4HKcmqykp8kiIuZ3MmCxckKpqM6JwENUgok3lvrmnWLZhzKVty
 uaVYqIrhLfzZkQgy7I15tmgqIa/GdXdDXV7WGrJlt6+vDPUFlq40K3lqHW5teOMP0am5
 C8cpgT4a9rpmesTU6cxIYWwncmQ6WHlPM+jSpNHOOMx67ysvQ8CAGfXO3O5x5i+2CLuy
 lbxOuBP3XPzYYMLOxAYk5czKvoHDDFahjnM8oxKg6nQTz6u6MbtowtqD70MaogiGxdKN
 S9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M4i+TfWhfJgBHbFZZ+S9QcXExOYYOteNyT9ScjAIlHE=;
 fh=LGjyBRjvL8EGIm67DyS73MV9LJmJY/pYgFwt4V3Eocc=;
 b=d27QFhfxTDi+AlEYffFjjRoLpdqM7Tay4LXAH3Q5K/ReDKfKMLpUHsKqP2MEWfwm4y
 cx+DO1SmUdcBdvyvj//syqChnv77ZEjMelkyVO9Hjyw3rdWZ4ZthuOdcFGY46QNGphob
 gL+dviQ1CaeCrD5a5+dfkb35t4+aNR5aII9wsLyK7exToFgyLJvRGQZ4oQTGobJ6bEhF
 tQ5qQD8K56YaBF9aDk/GcceLjjGUJyp2m0gug4N4pxgQkaS0IjSHXWWItgTdsbN6ZgpU
 lBjbFk87q77Rz19/mrHCre9TKB0zm5QWRKpdvDBFHLfFMOjF4bKiuuLSUInHQFZFCmDE
 Et6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791895246; x=1792500046; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M4i+TfWhfJgBHbFZZ+S9QcXExOYYOteNyT9ScjAIlHE=;
 b=niuFnzVcp1fKukLHef8O+gWD07WagbDJdtkBLRgixePFTjcDAqd+vr0zNElbTMxFni
 0rpqPkad0+tDYD8a/HkUhgAyCPi70HE5RgyXqK1hpwqm4RuGpE0QgeCGkvJGJIBoI8cA
 1sDAZ3fqnDJOqzwatHhqGBpqhq+lL8z+F5Of4DBnemjuXPOTacOaiTKCLPkAKqaL8n/i
 KyWBebgik7cpgW/9OwqgENSw3HCOH+ABYRislFd7UdRbeYbyxjTPw+DCnwlWMRAcj9e4
 cF8CdpjCNxMgzshmkPuRVd9NzQCfW0zi6kLPgAJ/F6/uUqh5BLhJBBpzM8M0Tpcbor2i
 +kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791895246; x=1792500046;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M4i+TfWhfJgBHbFZZ+S9QcXExOYYOteNyT9ScjAIlHE=;
 b=WxyRuy9Sbg15OiQycYbzlpPsChpVQ9EQCbi/rBcaeI/5C4BaPuf6ZKKvADhOWnMsy5
 DgGHWcwCdiYYZEowQ2InXsVmQWv/+nUC17/4PhJc1nKM1eS2Y3IOHVQi0o5ss4Ef6+bD
 tce5/W4IbGndEKmhwT0gmYgGCngc6bhNa4+e8dvAptZlbSh+yrN2J+ATW/Csshfrd5d8
 8h4+xTThXrF6CBSww8cOEogDlCB2g6byPRrHo26OyQWV6iTDDZdaejk7p0F+9pR8oxzm
 uM4BKtq1y1G1yi868qhMajikqXkgmgj++D2NHxl5fStaUSo7I58+W0w+S3PLHdLiWw8m
 xYNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvc05pEzaFR6M84KKbY7ZTbgJcZ8ho0YMFKfVwLZzcThBcyndlsW6YfDNUnpbcCkLh2L4JV80nsBm+@nongnu.org
X-Gm-Message-State: AFq9FYLog11aFnaOm2ThDP2zjysXfrX3w/XFwwOlLmfpntxZPXkuBx1M
 bTJYS2vGow+dfoJymDF5VwRq3NjWFeEQsXa8SaBuRUd06a2ttVBmjBU97iV4fkZg5NUBmmeU7dA
 P+HXZIzd9SlV5SSyc90QMWQ9NumSrvwSkadwqy3vlHw==
X-Gm-Gg: AYBFou2LHFTxrvpWhVLEXbLBCDQI6Km33mh2TcSmaxwYXVnHdyQKVa8AKpkZIh589fb
 M7O2xCBB5tFfe1km7Bveq0OT2w2evhIF/kmJmqoYc1NdyABs3ZxQfFE0KfwYpjlAedfownTBGyl
 sgmiKcbdTozRvVJfV0qRMrsXhnJYBoD5DKodwpJladFzV0JW5hwT2KDtVrRPJO6Vf3Xyy1Axilx
 e1F6kfx3wHkhzBzDmJnkdRnQ6k6HNCpSRhQMZWq+YeKFG3g2x0Nv70Lzcj+6Ne0Rnhx5dE/zVK4
 dNgfOpVKIQE9p+QMu4EQDODBFyfZc5DlVfhe7fd+5ejMthjU1pXwQ6jewIW9eKj2nfvhkdy+5aQ
 /T44U27fGwKqW1mmnaHqTA4h3I5AVrNzvv+hb3yLIUb9co0p9hw==
X-Received: by 2002:a05:690c:e145:b0:8a8:7fda:15db with SMTP id
 00721157ae682-8b07edb0b40mr35669117b3.22.1791895246523; Tue, 13 Oct 2026
 05:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-8-peter.maydell@linaro.org>
 <eba0b754-7505-49ea-939f-39a3ac1fca4f@oss.qualcomm.com>
In-Reply-To: <eba0b754-7505-49ea-939f-39a3ac1fca4f@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 13:40:34 +0100
X-Gm-Features: AclHuK9xAbo72QNILCcEE8GOEDeFqckIAkC69yMGsospGLAP8OJdU4p-EmBOT-A
Message-ID: <CAFEAcA-+1fDSRkqoyHvz7UK59fataAybfyxdPOa35QPKF6KNLw@mail.gmail.com>
Subject: Re: [PATCH 07/86] target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to
 set IRQ/FIQ status
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 13 Oct 2026 at 12:57, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> Revisiting this comment:
>
>    * For the moment, we do not consider preemptive interrupts,
>    * because these only occur when there is a HPPI of sufficient
>    * priority for another interrupt domain, and we only support EL1
>    * and the NonSecure interrupt domain currently.
>
> Is there a way to assert preemptive interrupts are not accessed
> by the guest?

They just don't exist when there's only a single interrupt domain,
so there's nothing to check. (Preemptive interrupts are either
those for the EL3 domain, or else those for a domain configured
via the EL3-only register ICC_CR0_EL3.) The check in virt.c that
says "don't allow GICv5 when EL3 is enabled" is what keeps a
guest out of this not-yet-implemented part of the spec.

thanks
-- PMM

