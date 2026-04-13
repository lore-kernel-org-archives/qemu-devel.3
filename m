Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DDDEBFD2C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCDtG-00010t-Jp; Mon, 13 Apr 2026 05:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCDtE-00010Q-Ez
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCDtC-0000E5-EL
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776073648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFPS6fRPR8ifQZYJmpMES4Pv/Kh+VEGwYZnf74bIzfc=;
 b=IL78LQOoPDTDc9xN3ksDeBweh9FsNQPfxzmk33jTcuD71eH4Z6wdkI0NZlnotMNNnqMJqe
 LJIZcybDF4HjnOH50RlDaOyVDyTxD9UZKdv3RS0/DxaE5BaZAs7NYL3L5oq1+8+o/iHBSc
 He8emBm5CySdbnc7+I9vMaGQ6O4tp3s=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-lo6Y6kLuOmSnI8w6tEd08A-1; Mon, 13 Apr 2026 05:47:27 -0400
X-MC-Unique: lo6Y6kLuOmSnI8w6tEd08A-1
X-Mimecast-MFC-AGG-ID: lo6Y6kLuOmSnI8w6tEd08A_1776073646
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c76cb2dce57so2530352a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 02:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776073646; x=1776678446; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFPS6fRPR8ifQZYJmpMES4Pv/Kh+VEGwYZnf74bIzfc=;
 b=rS3QYm1vLnGt/bYd34QwFT96iWUz//5mWxB6ZFzuFmLmeq8jIw9r2e2W2HLA1bDDpk
 OcOm9nbEW0yX/Jyb3tWKkm61EbCXsB3pgs7AR/+QyxnAXFUp/WtZ13x8NzQRi9fx43Ga
 xRaw+4JoF7VQHa3OKlb0lg4lOHEHjzasOx7zpBXjmgaqPOSnPAik2r34VJ698vyu4w7b
 V94niWGkxm0XY9lwm/6o6UWi0pqS+aCJH3MS4CvHPI4ta4i0rAkE/c8YnFJ/q+4dGnOv
 b/PsYmWljMNkDsrmzCPxMWVvTB3F9hTIeQzNJxs+40fmzEziuTsw+K/KNYK5HgUpbuiY
 p8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776073646; x=1776678446;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vFPS6fRPR8ifQZYJmpMES4Pv/Kh+VEGwYZnf74bIzfc=;
 b=S94vZmCepnmwtWpM2rp78eseLZ5dUeipL/fPSl4XqQvZgHuXhQcv1suHCl4ghdq5if
 93rSqARyC5fdrr36rI+FiiXXOOPxd6DwJtUL56ZtLxuWTCcuGJZ5KQrwPShryvJ2MllU
 XhKb73FQ1xLFBEvVVZWvf1+KSkx5X+wGVwVsHOaMR63Ast905AcvqZPzxG5DEN+R+nZk
 SKQ8O2tg/vlj3j0AxYmZLU4gQEBk9IAa9hISvQfEz8exAqlvBk0lNPMM9n4AoWt/+QHj
 O7LpqxlMyO5pqCt5bkZpffPfGoO6f1G6tpbglF9yh7vHih6fL/agsB6y2YDCUB25DrH7
 gTag==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bh4iuibRPYcVh7vt7D/KSE0zmkIsKbSMwT9u8sQabcUjDMzxP48WEf8x1nR1Wr4K3WxC8qawFGy0e@nongnu.org
X-Gm-Message-State: AOJu0YwJ5b09lZA7Fb1j+mybFq52vwFRvpOP342ZQS/mTa7eoN98re51
 L6wxQZcyngr/AyYWzx9yv/0J8qdpdNiyFMsdUtJpAyGEF9uz3IITTYYfOIami35dF9mSqWa/wNH
 h+Wwkdn/72X/alYXmUB4e8u9C5FHDHk/Wqve5fMUpSDMDevPrE3Xw5nsn
X-Gm-Gg: AeBDieuqtDwhJZ8IhBHVccIF8Lt1oP1sR1qsjngmPy3BGIg5QEdgIZibSxibbkMnVdO
 eN1kEJ882mdrHrMa7IEMcWQVhG+02I3gaEdIT+GT91ofPC2ebjVNLo1CC8GISwc35Ne6T7aBcyt
 gZGpaCZ4d9plBVTrWMhLvVYTLMrSzTX+xpu8SVLdvNM76IbqBQs04kYYtGiU5aQwfUvDxZWuJlI
 xXmYT1fND7qiSS0Yd2jWw2wfa2we2yA9rtCkBsS7HxrkdTajGmU/LDxISmb23obpILc0BGvb5qS
 p6WRykyKL037X9n09GlNX0YUwe8p3dmVzqaLuWx1TPQg4yCbjN12w1cKQNJX4AQmCejOK5mDdUr
 G9TmKVtrrUDwu0o5i2yaiXm55tC2JAdlyH/nOVQwuTExpr0Ymzt2vrtlmx5gXakjQdPLwkAr7Ay
 o=
X-Received: by 2002:a05:6a21:9991:b0:39b:ce4a:f397 with SMTP id
 adf61e73a8af0-39fe3d0eca5mr14334536637.18.1776073646003; 
 Mon, 13 Apr 2026 02:47:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:9991:b0:39b:ce4a:f397 with SMTP id
 adf61e73a8af0-39fe3d0eca5mr14334511637.18.1776073645547; 
 Mon, 13 Apr 2026 02:47:25 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7921a12adasm9453700a12.26.2026.04.13.02.47.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:47:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for-11.0] accel/kvm: return early from kvm_irqchip_create
 if kvm does not support irqchip
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAFEAcA__kgxb-9FEsBu_3cmv3UZMMy3kuqk9Bf1NqoQpnEmmSw@mail.gmail.com>
Date: Mon, 13 Apr 2026 15:17:09 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3B285BF-87E9-48DA-8F9E-28B2C3E9426E@redhat.com>
References: <20260413090010.60339-1-anisinha@redhat.com>
 <CAFEAcA__kgxb-9FEsBu_3cmv3UZMMy3kuqk9Bf1NqoQpnEmmSw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 13 Apr 2026, at 3:03=E2=80=AFPM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Mon, 13 Apr 2026 at 10:01, Ani Sinha <anisinha@redhat.com> wrote:
>>=20
>> During refactoring of kvm_irqchip_create(), the refactored code was =
returning
>> early from do_kvm_irqchip_create() function if the required =
capabilities were
>> not present in KVM. This was not translating to an early return from
>> kvm_irqchip_create() as was the case before refactoring. This is =
because,
>> do_kvm_irqchip_create() did not have a means to notify the caller of =
the lack
>> of kvm capabilities. Fix this by making do_notify_irqchip_create() =
return
>> EOPNOTSUPP error when required capabilities are absent and then the =
caller
>> can check the return code and return early.
>>=20
>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM =
file descriptor change")
>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> accel/kvm/kvm-all.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 774499d34f..92af42503b 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>>     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>> }
>>=20
>> -static void do_kvm_irqchip_create(KVMState *s)
>> +static int do_kvm_irqchip_create(KVMState *s)
>> {
>>     int ret;
>>     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
>> @@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
>>             exit(1);
>>         }
>>     } else {
>> -        return;
>> +        return -EOPNOTSUPP;
>>     }
>>=20
>>     if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
>=20
> This function confuses me. With this patch it can do three things:
> * report an error and exit(1)
> * return success
> * return a failure code
>=20
> What is the difference between the cases where we exit and
> where we return the error code? The commit message says we
> return an error "when required capabilities are absent", but
> we do the error-exit for e.g. "KVM_CAP_IRQFD not present", which
> sounds like "required capabilities are absent" to me...

I think it should be an assertion there. That is instead of exit(1) we =
should have had

assert(kvm_check_extension(s, KVM_CAP_IRQFD));

That is you can=E2=80=99t have KVM_CAP_IRQCHIP cap and not have =
KVM_CAP_IRQFD . That is how I understand it.



