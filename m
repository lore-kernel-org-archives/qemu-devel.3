Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71152C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 12:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siv9O-0007jz-C7; Tue, 27 Aug 2024 08:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1siv9J-0007g4-P6
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1siv9I-0006Yl-1z
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724761086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EiTPZ2qWaTRorA0xI6FP2nhQmqz8XNx/iknuS88GzQ=;
 b=ApT2nbqIdEvaNWQMNcNuBPx5qQ8LzAINZHbwIbpKWEJpEqEuxjkKbpxE4EiwNSldwA8oQK
 80VPlGgQmJiLQbDaD5oIat8Pd4I6vbpxt02xW9i2G+7e34O/1CjjFUakklI1WRbJEaqNs9
 3x+6nl59WPnjQNo5m+3oyiNJ0oyr+6k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-9k36jNK0OZiBLpZRvr8zXw-1; Tue, 27 Aug 2024 08:18:04 -0400
X-MC-Unique: 9k36jNK0OZiBLpZRvr8zXw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3718eb22836so3486418f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 05:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724761083; x=1725365883;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3EiTPZ2qWaTRorA0xI6FP2nhQmqz8XNx/iknuS88GzQ=;
 b=gRuRgW4fV+arlEmeoC2U4/uRLbC6MWpchxzyAMzMZSCfca3Eskl9ZeVVX2dx/3E9mM
 eU5npJn/0BpE7NOoqITlGMbg4uQHfP+EIWtxU/POBQZJ/62xT7aicqV6lifbrDUGFACT
 2qVbKYap0jqDB1ErgwP4Bm6s6MCfHGQpxkzbrt/Jy/lVxUn+TwiBHi89WdNhjZzE3PPF
 mAQFRUSGAkOhA+YM/gYL2qtffDNMUjSFOnqyq24W/c9Bh2NtNbU+EYH+V7nqHpV/WeXm
 2zItsH/CAMtJeYiH79N+QDOyj7knjR8IfKKqXZKFR49WuxdajQyARJTjxMeNyx2MORt4
 I0IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZGfIlJbvcrHoAuKFUAS5SthWpikVvRgP15Fr2A1xQQnOwF/VLgbkxRfnDMV7XJTPHiYbcJVnvUeP9@nongnu.org
X-Gm-Message-State: AOJu0Yw5Vggqpnv/LbM1zzA35yu+XDhvRKDQYaHtdq1R3a+swkpmitUu
 Qa6mf/xGRZepcd4HvNscdx2bvKJQYpE9RIr8c/im0D0/vQMjQLQCnLg4JKzyAp0ySXuMAKY2so5
 tQhM0/blm5ihwc4uc3cbXkCqhXQxnhn8YIP1xDbMS72+iOOtLt3K7
X-Received: by 2002:a05:6000:b88:b0:371:8af5:473d with SMTP id
 ffacd0b85a97d-37311840cb5mr7924320f8f.12.1724761083124; 
 Tue, 27 Aug 2024 05:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKZ7lsET1X/0DxMuelSdo1KQrt6r0yhxj3/qYEXESLmw2vm2Thtj1uVKCxQA6nL30WO0oPuw==
X-Received: by 2002:a05:6000:b88:b0:371:8af5:473d with SMTP id
 ffacd0b85a97d-37311840cb5mr7924295f8f.12.1724761082506; 
 Tue, 27 Aug 2024 05:18:02 -0700 (PDT)
Received: from smtpclient.apple ([115.96.30.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730815b7eesm12909709f8f.54.2024.08.27.05.17.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2024 05:18:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v3] kvm: replace fprintf with error_report/printf() in
 kvm_init()
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87v7zmmq9f.fsf@pond.sub.org>
Date: Tue, 27 Aug 2024 17:47:44 +0530
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <03C06183-B8ED-405D-8B9C-532E30B8E412@redhat.com>
References: <20240809064940.1788169-1-anisinha@redhat.com>
 <8913b8c7-4103-4f69-8567-afdc29f8d0d3@linaro.org>
 <87v7zmmq9f.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On 27 Aug 2024, at 12:00=E2=80=AFPM, Markus Armbruster =
<armbru@redhat.com> wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>=20
>> Hi Ani,
>>=20
>> On 9/8/24 08:49, Ani Sinha wrote:
>>> error_report() is more appropriate for error situations. Replace =
fprintf with
>>> error_report. Cosmetic. No functional change.
>>> CC: qemu-trivial@nongnu.org
>>> CC: zhao1.liu@intel.com
>>=20
>> (Pointless to carry Cc line when patch is already reviewed next line)
>>=20
>>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>>  accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
>>>  1 file changed, 18 insertions(+), 22 deletions(-)
>>> changelog:
>>> v2: fix a bug.
>>> v3: replace one instance of error_report() with error_printf(). =
added tags.
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 75d11a07b2..5bc9d35b61 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
>>>      QLIST_INIT(&s->kvm_parked_vcpus);
>>>      s->fd =3D qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>>>      if (s->fd =3D=3D -1) {
>>> -        fprintf(stderr, "Could not access KVM kernel module: =
%m\n");
>>> +        error_report("Could not access KVM kernel module: %m");
>>>          ret =3D -errno;
>>>          goto err;
>>>      }
>>> @@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)
>>>          if (ret >=3D 0) {
>>>              ret =3D -EINVAL;
>>>          }
>>> -        fprintf(stderr, "kvm version too old\n");
>>> +        error_report("kvm version too old");
>>>          goto err;
>>>      }
>>>        if (ret > KVM_API_VERSION) {
>>>          ret =3D -EINVAL;
>>> -        fprintf(stderr, "kvm version not supported\n");
>>> +        error_report("kvm version not supported");
>>>          goto err;
>>>      }
>>>  @@ -2488,26 +2488,22 @@ static int kvm_init(MachineState *ms)
>>>      } while (ret =3D=3D -EINTR);
>>>        if (ret < 0) {
>>> -        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", =
-ret,
>>> -                strerror(-ret));
>>> +        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
>>> +                    strerror(-ret));
>>>    #ifdef TARGET_S390X
>>>          if (ret =3D=3D -EINVAL) {
>>> -            fprintf(stderr,
>>> -                    "Host kernel setup problem detected. Please =
verify:\n");
>>> -            fprintf(stderr, "- for kernels supporting the =
switch_amode or"
>>> -                    " user_mode parameters, whether\n");
>>> -            fprintf(stderr,
>>> -                    "  user space is running in primary address =
space\n");
>>> -            fprintf(stderr,
>>> -                    "- for kernels supporting the vm.allocate_pgste =
sysctl, "
>>> -                    "whether it is enabled\n");
>>> +            error_report("Host kernel setup problem detected.
>>=20
>> \n"
>>=20
>> Should we use error_printf_unless_qmp() for the following?
>>=20
>> " Please verify:");
>>> +            error_report("- for kernels supporting the switch_amode =
or"
>>> +                        " user_mode parameters, whether");
>>> +            error_report("  user space is running in primary =
address space");
>>> +            error_report("- for kernels supporting the =
vm.allocate_pgste "
>>> +                        "sysctl, whether it is enabled");
>=20
> Do not put newlines into error messages.  error_report()'s function
> comment demands "The resulting message should be a single phrase, with
> no newline or trailing punctuation."
>=20
> You can do this:
>=20
>    error_report(... the actual error message ...);
>    error_printf(... hints on what to do about it ...);
>=20
> Questions?

Do you see any newlines in my proposed patch?


