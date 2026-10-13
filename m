Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD4FCC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGeuN-0000E2-0U; Tue, 13 Oct 2026 11:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGeuF-0000Av-OK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:59:13 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGeuE-0007Sv-1i
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:59:11 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8a83d2706fdso931257b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907149; cv=none;
 d=google.com; s=arc-20260327;
 b=Gt0balTRP92/+60yolgAYiOm2+e7LIO6g4yQFZL+6fZlA0jVH85yPcuSd4VzC2bvyJ
 8X/ixPfs2Lgpjzr0cS9dNqoC/E4w0V49j364xy62UF3hYQULDoy/X1KDEh/LFE9fRCUh
 DLWa2TclLzW2hDPKVT6+VttqszFm3DuDbkpmtHu0TixCgjLycOd7vOh2Oyzzra1+lL+W
 KKU3QLfzZUywaBKjk469z3aJH8bLzlqpS9eLymto/ptGEWvWZQlnSsJ28p4wPwUxuPQv
 f6/CadKqhl5/6lH+FZ8gl6udFDNfVXPugcohPHjaxERnpKxW7Ya5PGXBfG1rHeGQ1aIP
 Pi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FJNmQg65EL7s7OyNY6H0dUpsRkuSOaX4owUg57y7TK8=;
 fh=bZldGZKjQb69zmionImdAynHDuvz0fozrcMQYdy8VIo=;
 b=M3UkNblmZ1g2j2Nky5E4Idf8abB5nGkf3Cp1socu4By/fJNr+f2g5Mb97brWIXvcBc
 EkmPGjDMNORZS4XKfxz38JLqxL/eOA8AGqkwfZ8Uo5CVs7pXzUcaPr84XnsXDZlPLrsV
 1r2WqEnDuM8CC0kVL0hxce33J3Zi9GZnfHS3DazhKzvXr5skBv3cqn5p47vhmioJHFh7
 qeLwUhYuxBjR6st60ODqbaPB6JGKVHAYjkMR7Nkz8Jzo+Ivlq389JxYOOt6+6d0zx0gp
 QDb8JIp9Ci48pDBV1P8nsTfLKAK9LsD0KYPPnT4pXGQ2cMdzqxH0wfVygvu/fNdQ0k+u
 xVlA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791907149; x=1792511949; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FJNmQg65EL7s7OyNY6H0dUpsRkuSOaX4owUg57y7TK8=;
 b=ZNtQ7yT88csHdIKuTV2Bj6WKL5RBRAqbzwLQC2mj+pYBOlZ6aXuMqYG7gq8M2j3rjo
 mKRXRwdCz+fkyTAFUhfz1hbCWT0iQvj56tl5vBPx25HNZZXFwIPVewzE9NBNnLOixoFr
 fHqv+3V5I/bTSqCzstmqWiv2UgIE44op4hAWAsG4N1MzdCZ2u3PJWwJIFPkulOugTQww
 X9vd0t2j1l2XtplgO+TbYEtz+oYh1Lt8z34mtKU/oy2nEmZjR2WsDaVkj3JqFoLFjoVS
 QZbMf6cQTPhW7jJtpsKTrTmhDV+nf6AZwfyaDl7AIKz4UVfH7j8JyHKFp1WRbzHbiJTg
 lZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907149; x=1792511949;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FJNmQg65EL7s7OyNY6H0dUpsRkuSOaX4owUg57y7TK8=;
 b=nC0ZAK3ivqPac8mn89pKn2DuISTervT8oQsHoTmYW/0pUmbnl2cuPM7WqGda53X7ng
 X49yUcRPpZoZZwqMd3ZbPaf01S0CnGvzl9BbX1rbX0Pp/WHE2VoYiRtPoAkZFhrOvf5c
 adkCTi2yiJ5dgKpqUeqhEaoE7ftNjV4aLwUaQyBzuT9QK++il8CwNZHwtoFc7Xrqrrpp
 EbvrhsmOKGje0fw8d5V/M8NE2DjfpRJlfnBPnbRdwz9ASuLN03AVXkPr0oxkwdi3UUNp
 In63AiYX+WJrHl9z8gbOGGRrdLkbupWN5UDrsWZGQepKtuao07rSQ+oXfeA6aM5GJNyH
 cfMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByQXl37xD79J0O43kp44oeoUutI09YXLvRDHipagSp72HfcVEefaCApudRCVlhgLrdRlowGtpE35odj@nongnu.org
X-Gm-Message-State: AFq9FYIFrR6mry4HmPtibU/w2mUZbxrmtRTYhupX7xkGZxANrHIs3cNV
 2hvC733jD+S0qnzHXAQqLYQjgL6fQHhgc7MBOupGD8q2pNsdgXqd+TmLp8vhGJmy5lv89IR8arg
 C3kV8kZ/8RJerFOZBa12OJDYnTiOunPF/zFf34rMYXw==
X-Gm-Gg: AYBFou1Awdw/D0EVF5gP5gcM8+aKIq0oEUCAuFY6rGuZts8o5Lkwhcc2CVrCtPe7+Yy
 94YrJSqkIAxYwYNtT52hXZtwsxV4UKcHrNeSuWIYfbyunurstyO4XRmvn24MZ3EOWRpFlpy/5IW
 OHVFsf4Z7uK3E8QSRuakyJjuk9jfGBx2W61Bd+SanPggKVCffOXLMzV+vUEQ4IWX0WXhrTu89pH
 36+MYIPcCF6thPpHCzuLtCuExOtVG0dpkfWM3zhaLZqcultgeZKF7tNrMSp6l6ReJme8n2GumFO
 lJyUsdaKrBwsw5yQ/v6RElWJDTOLQNgHrmimiyvoWI1J0mmTkPqzHJ8kMNrxEsGCa2yQa8NFmW/
 WYQaGb0GtyskyUyjj3a0539mgc2ZNFBE3kiqBqp8=
X-Received: by 2002:a05:690c:a78a:b0:87e:2404:45fc with SMTP id
 00721157ae682-8b07ee0119bmr25300217b3.53.1791907148775; Tue, 13 Oct 2026
 08:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-10-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-10-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 16:58:56 +0100
X-Gm-Features: AclHuK9l7BoKCi9zhsOGKWUFSW56RXKgiiWtviGpuEUGHICMhXY_rAt3MbM6dI4
Message-ID: <CAFEAcA9f6pSCmwFD63v3NerXDMYWXF+Pq4skgGKs3_N78xo1rQ@mail.gmail.com>
Subject: Re: [PATCH 09/22] kvm/i8259.c: use kvm_i8259 prefix for functions
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This ensures consistency with our normal QOM-based naming convention.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/i386/kvm/i8259.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

