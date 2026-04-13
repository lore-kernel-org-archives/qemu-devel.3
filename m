Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F16EBFD20
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCDfo-0007CB-2f; Mon, 13 Apr 2026 05:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCDfk-0007Ba-Mc
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:33:37 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCDff-0005Xq-H1
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:33:36 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-651cfaa21e6so450573d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 02:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776072810; cv=none;
 d=google.com; s=arc-20240605;
 b=cJy0Me9qIYcm6bqfr/QOkfjLPAwGudZF32JDqVyzktlhsNwwIx/mfwA2Ktgx/WyN9N
 oNjr5msR4d9yQkgwTAiKokgxJFeNUailss/EVJgAmA06s9ySbSuoo3UExtPZiUZp0NO8
 ODyvvOn/oiTDZjIihTAn9rB1Tpro1O0sZdX6qrdTupK/Uf99nVPU40kMC6LOAfRqzqab
 51YDgG0XahxwN6QZmjGdRXOzxtkyqUlm/mbucx8Jg0APfFzwJK2dwnqa5cNnb3EbD4ln
 n4mRVYr3hnCd3Rc/0miST3DOPlNTyFKR8SsDT52YXnoqH945vYZ7XD55nmxnx7GCjqiZ
 5Fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0XI9DbHYUkGehlX0OcWQ888vFtJXew82enKuyuQHRk0=;
 fh=q+92S+8ZWXLl9eg/tdbobV+jDbNbyjbR8mwSpqPZ/ZE=;
 b=TOOGvRs2N0EwU+RQLCGl+Eyh4D8/L832tw73vb/9yt+c66AIOB0d7etCuv6pfzpfBo
 J/pIb62i2TRy3IxS9QCnS4Bs0THpT13uDABKv8t0qaTJ5nb1nCFnNTKuKhAkG14d4Chi
 JBOq3gEsk56yOfZjlnBeiBl/urqJjdNVFFbtrhoq2r1yDLUO3ZI1lgaXeFHN7InYBSQB
 stDMDVNsAt0q7EX7z6U8ioCmOu0xXP62NVEpbuoXdi7D8VOZey7OXJrCRaGxq3sf+1fc
 cPc8sJgjV+sBxdPZ/WbmNuN9r2XAGR9uV2puLMJemT2UzwhMljkx7xLwlYR5j2f3V/63
 Y1DQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776072810; x=1776677610; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0XI9DbHYUkGehlX0OcWQ888vFtJXew82enKuyuQHRk0=;
 b=fuS8rQ6xH4QSaZb0dK2pZoGjVLM1ZJnvnwWsNtA0pQqMn5kLOyRQwc2OTa4zlcuqen
 N6VF+KZDQUVg8lXrOHVTIO5tMJVETGzilhLRiCdBLBfibI8kLEpKeUz3HZgq27mbKRGE
 /Ts0cf6K6CVaqTmWC+QEXG/jwGDIhprfSYKfikEyYnGVVeL+n4NAhSo1WqN4FkY6vDpw
 i1XuFE7aukieoQC+GbL++Q/KZK1X8A9EfQTgCi3qovj+1ONfPAJVWAgTYqIsnPkSqa0V
 n0YqLnlkK0LSvyf+O7phubaCqm0pn4bj2ExYsFGR0SRypFv/AXe+IUDH4F0w8+ztrh+0
 QZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776072810; x=1776677610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XI9DbHYUkGehlX0OcWQ888vFtJXew82enKuyuQHRk0=;
 b=dPGw4p+SOEQJB6xgJWjFgokph1mjKVhIsmV8c+eoegYp9UwvH24okoyWONwC462tmJ
 MRswEVpXTlzD/VdPGkD8rKJganJit/RyQD74iVX+Wcs6QWjN6zKFIKiy+UsEFisyzenK
 V2Uf65plC+jq5mc5LkuSiu29QgjMnVn6k5q2/ze6mbfGcSY+6ZoHynugkwNJhpKLAtl5
 U/ck34aMpglp2dC4k3VhRYPnt6UpuPdvWVBMcQshOcDm+2RM7xBgbZR3LEVOiYBVCfrs
 G4VIyUBfOn7Cavla42W4CxdvQdGiyEKSWX+PM6JrzU8q5ADEKh476Spu0F4yVvmc3YL3
 x8fw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lFQIZwzZZYbuskegYoEGYGyiqY/Q2mfY3Hz4l8abWil7X8bM6Cb/pDItwt35MExeNR8jRZ70sKCuY@nongnu.org
X-Gm-Message-State: AOJu0YyZpiFELI3xYBzonMXPuiUX29pWGeKM6grQv/8kPJ5tyAWUhzW3
 7BRaTLnnaBIAIAadujsmziOP4dJCQSXZfDPq2P0mtKihHwGT7E8qqsgstnW7Rb1HfoO/yVSd8qe
 jTvIy+kcAwOx8SUuGoSCpDZEb/RD6fXPGTbnXz/i4Yw==
X-Gm-Gg: AeBDievVYA0naDAq71s3Ctj0SK1AOg8dz872FZPKlnUugSIcJASchrbBAi/6l0Rq0lC
 SBJkYwxM4ZLjpwhf/uPrU1Dj/fIrzkMXtdwOE7Hp50KnNA1bftYgUUWykn9ENXVGoiVWLtpT9v8
 BQtcA8Scb0QKMp5CuuDuqx7zgbVWSFsX7O4qb2+n3uMEu3Hrxe5rOYBgB0Aixv2+IIU3s3IIkyI
 XVrP0Z2I9mZOgm65lpz/kiYWkNaYbBy9/RoB/v33pZao7NETK09F41x5fy02LZf8TjMTT0U96hd
 PdvX4T7Adp2G6+7wuBSfMe1UIlBEGRkSa40zpt8L0qDd2bg2/d6hHTo19IqbHUMEbCSALUmYJFe
 lYw==
X-Received: by 2002:a05:690e:1341:b0:650:ece:89fd with SMTP id
 956f58d0204a3-6518721b5b9mr12869286d50.27.1776072809671; Mon, 13 Apr 2026
 02:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260413090010.60339-1-anisinha@redhat.com>
In-Reply-To: <20260413090010.60339-1-anisinha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 10:33:17 +0100
X-Gm-Features: AQROBzCPNQstYoD5bOM-E3AUU_4dEQnR2dcVMuHGo-eva1X-zovzQPwiUKgqIfo
Message-ID: <CAFEAcA__kgxb-9FEsBu_3cmv3UZMMy3kuqk9Bf1NqoQpnEmmSw@mail.gmail.com>
Subject: Re: [PATCH for-11.0] accel/kvm: return early from kvm_irqchip_create
 if kvm does not support irqchip
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>, 
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 13 Apr 2026 at 10:01, Ani Sinha <anisinha@redhat.com> wrote:
>
> During refactoring of kvm_irqchip_create(), the refactored code was returning
> early from do_kvm_irqchip_create() function if the required capabilities were
> not present in KVM. This was not translating to an early return from
> kvm_irqchip_create() as was the case before refactoring. This is because,
> do_kvm_irqchip_create() did not have a means to notify the caller of the lack
> of kvm capabilities. Fix this by making do_notify_irqchip_create() return
> EOPNOTSUPP error when required capabilities are absent and then the caller
> can check the return code and return early.
>
> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f..92af42503b 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
>      g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>  }
>
> -static void do_kvm_irqchip_create(KVMState *s)
> +static int do_kvm_irqchip_create(KVMState *s)
>  {
>      int ret;
>      if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> @@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
>              exit(1);
>          }
>      } else {
> -        return;
> +        return -EOPNOTSUPP;
>      }
>
>      if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {

This function confuses me. With this patch it can do three things:
 * report an error and exit(1)
 * return success
 * return a failure code

What is the difference between the cases where we exit and
where we return the error code? The commit message says we
return an error "when required capabilities are absent", but
we do the error-exit for e.g. "KVM_CAP_IRQFD not present", which
sounds like "required capabilities are absent" to me...

thanks
-- PMM

