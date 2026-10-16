Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B7ACCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrW4-0007bY-2i; Fri, 16 Oct 2026 19:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xHrVy-0007ar-PL
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:39:08 -0400
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xHrVx-0002ma-Cx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:39:06 -0400
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso923829eec.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792193943; cv=none;
 d=google.com; s=arc-20260327;
 b=Y8T0qmEpwSAHU9WA8HjvJzS0YSB14xxtf09vMS/nfdgupBS0Qs73EWU/ZyYGb3ytLv
 MOQKr+irTjy4gJ9U0y5UzXUA9Tp0y/v2amkHBgezSQ0Ni1XRSnKqYfa9ejYlMQxjU7CA
 LMHYf4IAj/S31DR1cZcEYJWkwmV6gxWgwO7wzvLkdRRPzzHgiOUS9Qw+7Yy+7yBDEuYr
 cNeVAxJv6cjXQ1FjyqRfcrZGD4C+yv08Pxh3WeMsQ+3Yh57GhM//mqXq7kKupUUC7Iah
 mMjZp8ed6w5cPCfRfk5QcWhMR1UQSpF7oPhy1nB852l2BsDsnF9cuwmCcl065Kk/u+kp
 pRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zUNYiJ5KKGGCqSXh0YCkaYhE+czP5NWG0MMnZ8F+bCw=;
 fh=qAX0oJxOOYE5IQsixN1XiS6rs9CNjF4Qy4Pvsd2Byrs=;
 b=M2yBJMXbvoDQxRy8F8jlysAp2A5JyOo3mn+OscFPLhNjn86AT8jk11vwdVyLrUi2yg
 rJMRjNIOPVP6d+CIGVKDDMyr14oNd5XZpugxQS91Bt4h6FehoRLsx/+MasHymkiAAmex
 w0XbAlORRvrR/iQAs7DBiLBC3xeGAG5ALNX4hlUuZQz9xhC45m91l8blTaCVj9nmvBeG
 2/6Vj7sF0HGrMCabzFW75M52S5Rhx22+ZOoEbsP8g/ncst9FQG4qLPTINW4DcUHDhUd1
 GUGbLOzuTX/aUJ/pmyAB6P5QQ9t39yRBpgfRLERAfEZZHXk5z+7Ei7iwBjOlmQxICl9Z
 p3+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792193943; x=1792798743; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zUNYiJ5KKGGCqSXh0YCkaYhE+czP5NWG0MMnZ8F+bCw=;
 b=Lk2xENzWiWNkGv0UKRdTDt1e687fsKZfQ/7U45D6JOKXQ5r1Qh9hQXc4AxpSi+mENL
 sJZfLDaFZxbWb/fozN/+0gXjxAsK02xkcIVPTihJlSENZLAtE4OWz3i89ve0ldGqKozo
 1TEF5n6XoeSIh+l2gx+JCbVoGidDwMcjC9KM3HBmTl/RE0h/nG3QmVvQWCbZ/Nj55/jA
 EieN8ujMAOcUDRVgiYHwuom3x7mdRsBwGrbnHylTmwi4Rw7KQtWTBCMVBZiZV+SKJb9f
 O+C8lEmSMYaC9tyDJomJUodHNChquAvvYoE2kWWsmcWHlY9sTCvnc7RFmGHSC4+man1K
 W+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792193943; x=1792798743;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zUNYiJ5KKGGCqSXh0YCkaYhE+czP5NWG0MMnZ8F+bCw=;
 b=1feXy1Cb18YP5QmoxBNSX2kWN3vcDmjrPVkdw9AYDzKZiGaF2KTvmSV24kTgwWaYdL
 8ZEa/XvDIFTMsX4f5N6yi54K6WZnjUXxttMsctK81IBqox9cuDDnB8vNnicaXdZ881vO
 ovubPmZEhVULhsQCnTWmAgVdDCoSNOdjQeOWmErAYkT3ibr1loH+5gIqs0i4dQkxlbvQ
 YlyztZTJ/bxp1TQAXLom2GMw/fhKlYiRPHfAnqXRVSHEjwioCmuMP8BEpTjQNce7eTUU
 ZK8oY5F2TVsRHjf4CZX2JdRx+axn6KrwdgEtVvm2h+hTgyzK/e5TuljEjDpQyVrMyAPn
 I8RQ==
X-Gm-Message-State: AFq9FYJ2QAL+x4crxxUcTr+VxnPQie6aOkNvbwuPFAboKveMsHougFrn
 eRJZ7fBzrIgCjw+c1FB0mg/LEwM45icECuJx6SJK2yASZPa0soKilh1I13qdiWM/LRlfqgsL7g4
 DcMLlH1K8la/5Jo+fH+yH/TUdT9PaiLTbBMb3kryGuQ==
X-Gm-Gg: AYBFou23hg9a+N3XWggu+KKYs23gfa6MBRmoAWGm/v+x/Q+GQjMjwZBHoPNX3WVq7t4
 xfaw0oXbA12o49qyN2J3tknZE6dHBIyYq2dz+bF6PMf1pnBgoRjRJZ3moVEel4mqQ3dKThwSFHK
 3IABa8JuEytOYbfNE4g6pDND7Eu9adRkFIHwuR8njOO4v37wD/NPa5teRF29FPNzlW5Y6a3mUuC
 msT9dCeBigIgDnJWbqosvJSyXyAd64eiBdV607+MGWFrvzd6omqUAxQxSAKJLCpxVCZrzgws0BZ
 oTduokhIzCM/X9pQ6ymR2ZaBWGWtE/kc7WCcYjW66qxwn+LLXWxZhXXuhr8QZGxrMig2gp87zdg
 vnLtC37/hvqwP
X-Received: by 2002:a05:7301:fc09:b0:359:2f0b:aa89 with SMTP id
 5a478bee46e88-361a16681bemr1541832eec.10.1792193943112; Fri, 16 Oct 2026
 16:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20261016122113.226920-1-apolivodaa433@gmail.com>
 <CAGscdFvtLkFsLaTzWLPd=J757ioWyFmBKds_yb467WY7RrqhJA@mail.gmail.com>
In-Reply-To: <CAGscdFvtLkFsLaTzWLPd=J757ioWyFmBKds_yb467WY7RrqhJA@mail.gmail.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Sat, 17 Oct 2026 09:38:51 +1000
X-Gm-Features: AclHuK8dfC8MV1gDQwz7cwS3H0RMBGhdVrMwGyaH6rp081sQlOOxMRdktMUT_ys
Message-ID: <CAGscdFuxDUWVsNOsLCwHjqT4KYGp0aoBzrUjp9svjLyofi1uoQ@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Reject VPINSRW with VEX.pp != 0b01
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy1-x132d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Somehow messed up the commands twice...

```bash
$ nasm -f elf64 vpinsrw_test.asm
$ ld.lld -o vpinsrw_test vpinsrw_test.o
$ ./qemu-x86_64 ./vpinsrw_test
```

