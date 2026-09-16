Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18434C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ovy-0004tb-6W; Wed, 16 Sep 2026 08:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1x6ovr-0004q2-3O
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:40:11 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1x6ovo-0003yP-Ev
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:40:10 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b5e4f13d77so1097073e87.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 05:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789562406; cv=none;
 d=google.com; s=arc-20260327;
 b=q3WclVQGaAO3/43sZKioZDQAs/dw1E3nDMLwLbKYAhPOc3IRg7jB64B5ZPBx28Atp/
 LKQ4/o5y04dU741Khg69oPUyqx/FTVifrrD1BOg6Sy8LAAuTtF0aM/Xy8S5uXv4557Ry
 B29QFRi2X4zYMYb+Y+LHxR4EoJCG0lSRKCRNBaPgfgMe/usrLO8/t6vX2MmNq5IjD8TG
 D/H+Y0qUvRN21xovaFYkvUIUIg+imfZOE9RjiX4RiQQEtYZPM/5FOmHwIdghnGbZ/Cwm
 qk8XQw6lylyqJvgURg3W3U0fuQLMU9p21J+7Uz049v4pDZEtBlXdryG+hgjlJoqQ+SpH
 C5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DbD3p8jMET1nmvhB+WjefO62+1Xr/3+riUWqZdD6110=;
 fh=/c8Hxh4HFY4gZJGkC/smGKMSvLG7cYMQ/9bafODEfcI=;
 b=Rs2++apPsnU+VRNW/HoobWrmbuU1HgHW5ymUF27CWGFVQMpPstik3PACHCqehz9GYn
 6rQZxeSYoHS3gJCx13Cdh6CNzs4gDafYDAI5gIzPhFBKgrp+b+zdLtp3hn3dyfjYXbxC
 0aO+1vy1486NKPnetlHi3ijn+I2CCbEgiMoR3liGwjEJhXQ8PTs40XMn9JmMq+AM/a5d
 CuiiAUybKaat3OFh05fJK+1AoVOu/HSv67AsvQmp6pu3lwEd04QAMbXxYrCM+PK74eew
 gqhjXyDnzcEHWgH524CgzR+RKmJFJ4aqD6fdY0DF84122foKBPy1oeDG7Cv+wusUlLqJ
 +n9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1789562406; x=1790167206; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DbD3p8jMET1nmvhB+WjefO62+1Xr/3+riUWqZdD6110=;
 b=KZd3/D1nsb/CzCX8Rj9NwTEeJzwHg5eghgAP+QgHrSKfUGvPGA7gRsjFOgSD0C1vvM
 6hg+jqmokBQEsmmtTigfSScIAWU+Plp+D/dCC4oVTbMypfydkQYHF2+HizHGoPLbmq8h
 TJczUsB3gQxYIKB/X7pwKi4QhWP8rZcnpcKu7NIpsxfWiEvLIk0Yj20zex3yOZLB3gJN
 iFvxCe7dakRSuzzDPN5eFfQ9CkIyAfgVS0OT/l4lURQKE9/xJfSnsM7EjROoM2nxt3mn
 GwyiAMaUNakcSKgs3SV1nNZKLckF2p7oTagqQo/Dlbq8gpJpjFi9/Ojh02o+BbMdKTte
 pRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562406; x=1790167206;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DbD3p8jMET1nmvhB+WjefO62+1Xr/3+riUWqZdD6110=;
 b=lHSlwn2xmqlwrH50KPMbUpiWoXNPY58GeHB7TcDy0IQJYT9yxPgCoJPmHkG6K6QMnA
 KsXWIGoTpdLznXEdimOSjom5Vt8QQ3EnxxK2uOvDhS9s3cjjDBlezyd1pUr+0pkTdH1N
 m/YSUqVpxFBYJLMCTx+VlnqVUJzN2RY7n9uiBpPyrFWs8xmme2mStu5mOQw6RRsvfrhz
 rhhYnTbn/AuEveeU6oAUTsqre1OcS+cENPk9WXtEKaaWsOJ43q9pwxx3ZZkIf8dIa+6F
 xM4fUSp2jrHXAsXHIAvj8F1iu+bHdC6AmSZdEcyT9oObbtJRvFiawin6Qk4kYy7cI648
 uwVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/G1sd5W9IEky+s9pL0JPc52s9IoqcfT8Mo8bG+L7KqCxgYmtGCIEhvYSQ+wdoBkQ6kxjSw18y5SGE@nongnu.org
X-Gm-Message-State: AFuF++nY6HB/v3349yQnHmBdO+0585QeHaOx43roq++Y1N3xpgmkrNFV
 KAAb9C5o30u38WZUthwvKJ+GiadIzAcSclBj4EsqCrdgChi9XKOMvCp1a7Tb8mvkTurrG/bmzim
 h0RI7v5kY2EGftk4rUx827KdPttMQUqB8aFy08kQsKA==
X-Gm-Gg: AYBFou3ZZ7Ux3OM5CnMZUdYbRYfCDhsZriHMr/pYbNdAPI2Vuzgmrt6JY7bqaXvu1Wr
 HJ0C4IySlVAHt47AYHTMWL911VfJx34t8OQLbMqK58Lk2a48Wy1WiBhFcazD/38F/DCKrXqET/q
 6CbTLFiEj1vXzQPplSo1gj5AiN9p2JMu3HrUu2URcUQD8IaQPV6i+TJGy6qV29UEQhnjlfRCumi
 CQsVzVHbDFizL5hDa/VJCPEzY9RGdqXHY42KJgU9/sVCygyOyIDS38AksELOiIjAiDFk1jlVXh4
 Jb5O2deMsEezgGZD32HyBVmUTLyO0h1YHwAfi+k3cDHLE9vsVSowUT9OsyAJA2POJ0yTs/oKfp6
 jYBn3muZO
X-Received: by 2002:a05:651c:43db:20b0:3a5:b53e:1243 with SMTP id
 38308e7fff4ca-3a5dc987755mr3069781fa.8.1789562405982; Wed, 16 Sep 2026
 05:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260916073209.1791732-1-antonb@tenstorrent.com>
 <d0f6d31b-af76-4a21-821a-8f997491abe6@linaro.org>
In-Reply-To: <d0f6d31b-af76-4a21-821a-8f997491abe6@linaro.org>
From: Anton Blanchard <antonb@tenstorrent.com>
Date: Wed, 16 Sep 2026 22:39:54 +1000
X-Gm-Features: AcwNN1UQ30c0OumQSh9LHhhlaKSYGQk2uQyety7KWNS82kPAM7jwVufZt8Kv-58
Message-ID: <CAN7m+mCgv2v9GeY=kLJUMkrBeGeKLfrCe2+TtcfMoKUJhAXUdA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] accel/tcg: Fix TLB_MMIO check in
 tlb_plugin_lookup()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=antonb@tenstorrent.com; helo=mail-lf2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi rth,

On Wed, Sep 16, 2026 at 8:19=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Mm.  Missed when doing the conversion.
>
> You don't actually need to test vs FORCE_SLOW; that's just there for the
> fast path to notice.  Just test slow_flags unconditionally.

Thanks, I'll resubmit with the test removed.

Anton

