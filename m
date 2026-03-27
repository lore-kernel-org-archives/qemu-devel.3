Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67D210ED674
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w682v-0007BW-Fv; Fri, 27 Mar 2026 10:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w682s-0006xe-Fo
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:20:18 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w682q-0007sI-P8
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:20:18 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65005a8840dso43782d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621216; cv=none;
 d=google.com; s=arc-20240605;
 b=Dqop7c2T4iDE1qaVKVKZ56lw4fZlrizE02STE541hl3H6vEw1UFQ+MX2VAM8ChK4As
 bo8VSy0sckywYkU7BOqo9u/7OJpauq74/Vo0auuC3t/PtzhmCxUcH7mNh2JY0j0JnKVJ
 fQA4BsHYbttJB+iLh9AhHQwqI+SnPQcTelCbOthGVz+NrBoGPYGFeOh9jBWKepUL07kc
 6tpow2glbx0lhjvax7fj9Ur3QlhXoY9/jvbOo5U5gQ9VOS932BMB4I5dI99cJ1Zh5n4Y
 ZQm/+NGf9Rql8usdw7PDHQkm0bh1wNZva8WDI3/iyYRWerzHK8EnNrKFa83zPbryAhFZ
 J8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h4EmkHMn9ibIoN2/Jf+eFFYHaBZUJUVQrG0xettR+is=;
 fh=w+LpouDh30NtiNlKwr9dDyCbDsk9PDvxuqtAWQibE8Q=;
 b=QFm5ntNKUpubswWycx80ITrpA6JDJe+czHNTBvsf1OP4xP4f+vCDqwimpNzulisYyK
 EnzD171yXUc+A4/2nm6i5ZiP866SBo6nyJ9H0rJDPFjC+Hrj/o9nzZ9jW31qD/HJbnKY
 zEt364yE5FYGbHkXuN+Dn+k+yNQ1HQmaNqjMGvODWuC0vvCgTtakAQVcObWHcSWBP8+h
 +QJR9HVQfjEVUhjtTBRjRrtztYG2QKTuNw3LLsurxuZ/w9SVqpbIr1tP9HTZckn6JTh1
 iMuAJW3ZXGWlGjRkjWVy/2qN+r6wWXJlEdWo6ivY0oxK5Yhxi9ggqqk3vcJT1LJESHE3
 OWqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774621216; x=1775226016; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h4EmkHMn9ibIoN2/Jf+eFFYHaBZUJUVQrG0xettR+is=;
 b=xTgfCjTbYihpd1RNACURld87BixgNhJIGo/ot94Xk7xkpGVs2YVvwO4ythP92a07Y3
 CCsVi59aznA2Rk2JN85Qr6eY/eeVEsnstpLGGvcNXL5wDAcToAVJrOK0fHd5hKwHWMpS
 3FsBWhIjBI+5OmvSDN8DBv+eDlxbMhv8DD29ln+RfNDg+C39g47UloVQTTd6pnqnEdvd
 zaFxfEr/l/idInhybxIBJA7k++fvuVLHJ0u4lKhXFwdcJZ2B5eMdLipzmIeRV7fG5OsH
 6QqmOALTcKARQ2JOmvkUGpKdao2o48LoLrDG3bZeu1vrbt/Woe0jYhJRzCodkgRTdvAr
 nGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774621216; x=1775226016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4EmkHMn9ibIoN2/Jf+eFFYHaBZUJUVQrG0xettR+is=;
 b=ikGqbVDxD3vQLwnOCNwu4M+hl63XZEUVT56i1mUBZq3jKrplOC+A623s/YNdOfl6q4
 B4kDv6b/DXR8tZwKlUYft11hJEWz4hBNF//yNh8ps8VxDZyfFaX/JPEr2NrVVmnz/Wxd
 mrfpwpIPJm2/HP/bVfqr4YIP34cGtBnIIpI4+mE6CGnARJBmu+hQX44gTp6XuWvMrYZe
 r1CPedH1xDO/E4IFBGfELCP/CXAbhXdYiPgcEWBMSySbcjuN7WLPiu1RLc0EtcDnZ17K
 5ihoUnlcV9wx39lE5Tok5BtU69ipi8KbMN+JdkqDnx9AQekdTPO20maZO90c7M5GrQiJ
 ILSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpSA8PYTuAIozZpy7o04OwgM+MS2w2jBu+bcPwjaeEgo2f1i6JIKt35rnqxDuNZgnm16Qbchw4D6om@nongnu.org
X-Gm-Message-State: AOJu0YzdBi7nQdClnFG/c79zeCkkP1GXu8IpqCON0asbxoo1FqTI316r
 W8FipvDK8PQFttSCJpKmxbxDoEWxRrmkEYIGw2iroewXmKbU6Omq9vr9TAkIWP6/zu37xfTAWRe
 8EwGbCIEBDxmvlaQDl+O9PwwCwngwsHxMDZgAWqlrqQ==
X-Gm-Gg: ATEYQzy7zQgFUANXzupPqxnLGwpC+8+XadslILw4KXHWOVItGd11wbdkSO9p2Z8lkkt
 LNsmbo8u3a/ZfEIWrVOZuW5NMmNevn23bCvcxeeEn97u38Ac94PLEZfSUpR01RFoj6Ptrxy9bQE
 2BLszthDNERVLqCY7iRC3kt6XRIdkETuV/Xj7dtolQfPub2tordgeNBcnSfnMVrD8oiTPtLBGtl
 J+kCIWT5m8RUhjaRyfExjxsV8B3ihZjrxmChYSk2mWf+vlgx4eKELv2n0kRx5/yVKl5U8sVNCeJ
 O4xKXpMdS9s/Upfqu4NjXjeYfcgWGRVDSLlhC0LaY6IHf2VDvEKzZEdhhhwVCdIEJFnCuEKMpQC
 MXw==
X-Received: by 2002:a53:d60d:0:b0:64e:f106:60e5 with SMTP id
 956f58d0204a3-64ff73b6081mr1959808d50.52.1774621215306; Fri, 27 Mar 2026
 07:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-14-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-14-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:20:03 +0000
X-Gm-Features: AQROBzBFRtQAiDsGDqgRuOyZis6C54lKjmWtnXZGQUZFVhOVaki8E6WZtmCjCXU
Message-ID: <CAFEAcA_B7hU2+YXEem-9-avrz64cvz6X=NB+bb8hfdMu9PdgGQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] util: Remove unused sys/param.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> We dropped the use of PATH_MAX in commit f3a8bdc1d5b26 (which
> basically completely rewrote the path handling).
> Now we don't need any sys/param.h defines.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(If you need to do a v3 for some reason you could merge this
with the previous patch; but it's not worth respinning just
to do that.)

thanks
-- PMM

