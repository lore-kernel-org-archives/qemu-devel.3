Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF5EC54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 12:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sivHN-000510-JA; Tue, 27 Aug 2024 08:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sivHL-0004yL-Bi
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sivHJ-0007Oi-DS
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724761587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pqf4vIDiJZIq0NvzPPjp8hfkf3fzLyKRmzc9tkgSTY=;
 b=X7l2QO1kzCh4LcsZnXajrDwK/39aJLcWp76OQo979BzZrSoqZzER9MEVvMItgVPBtOsh1/
 k6rKImTLsocGXmiNzHbcwb4g+9PfxlV4+/1R/0D+c3DvSdBzu9G74R+aeW375FhogcwvJs
 khLafReGNqabRP93Za4ZHCBwjmORezs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-y-Ul_CPtOw-27rCzWzUC0w-1; Tue,
 27 Aug 2024 08:26:24 -0400
X-MC-Unique: y-Ul_CPtOw-27rCzWzUC0w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C20161955D54; Tue, 27 Aug 2024 12:26:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6072119560A3; Tue, 27 Aug 2024 12:26:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 05FFA21E6A28; Tue, 27 Aug 2024 14:26:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-trivial@nongnu.org,  Zhao Liu
 <zhao1.liu@intel.com>,  kvm@vger.kernel.org,  qemu-devel
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] kvm: replace fprintf with error_report/printf() in
 kvm_init()
In-Reply-To: <03C06183-B8ED-405D-8B9C-532E30B8E412@redhat.com> (Ani Sinha's
 message of "Tue, 27 Aug 2024 17:47:44 +0530")
References: <20240809064940.1788169-1-anisinha@redhat.com>
 <8913b8c7-4103-4f69-8567-afdc29f8d0d3@linaro.org>
 <87v7zmmq9f.fsf@pond.sub.org>
 <03C06183-B8ED-405D-8B9C-532E30B8E412@redhat.com>
Date: Tue, 27 Aug 2024 14:26:18 +0200
Message-ID: <87plpui239.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Ani Sinha <anisinha@redhat.com> writes:

>> On 27 Aug 2024, at 12:00=E2=80=AFPM, Markus Armbruster <armbru@redhat.co=
m> wrote:
>>=20
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> Hi Ani,
>>>=20
>>> On 9/8/24 08:49, Ani Sinha wrote:
>>>> error_report() is more appropriate for error situations. Replace fprin=
tf with
>>>> error_report. Cosmetic. No functional change.
>>>> CC: qemu-trivial@nongnu.org
>>>> CC: zhao1.liu@intel.com
>>>=20
>>> (Pointless to carry Cc line when patch is already reviewed next line)
>>>=20
>>>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> ---
>>>>  accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
>>>>  1 file changed, 18 insertions(+), 22 deletions(-)
>>>> changelog:
>>>> v2: fix a bug.
>>>> v3: replace one instance of error_report() with error_printf(). added =
tags.
>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>> index 75d11a07b2..5bc9d35b61 100644
>>>> --- a/accel/kvm/kvm-all.c
>>>> +++ b/accel/kvm/kvm-all.c
>>>> @@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
>>>>      QLIST_INIT(&s->kvm_parked_vcpus);
>>>>      s->fd =3D qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>>>>      if (s->fd =3D=3D -1) {
>>>> -        fprintf(stderr, "Could not access KVM kernel module: %m\n");
>>>> +        error_report("Could not access KVM kernel module: %m");
>>>>          ret =3D -errno;
>>>>          goto err;
>>>>      }
>>>> @@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)
>>>>          if (ret >=3D 0) {
>>>>              ret =3D -EINVAL;
>>>>          }
>>>> -        fprintf(stderr, "kvm version too old\n");
>>>> +        error_report("kvm version too old");
>>>>          goto err;
>>>>      }
>>>>        if (ret > KVM_API_VERSION) {
>>>>          ret =3D -EINVAL;
>>>> -        fprintf(stderr, "kvm version not supported\n");
>>>> +        error_report("kvm version not supported");
>>>>          goto err;
>>>>      }
>>>>  @@ -2488,26 +2488,22 @@ static int kvm_init(MachineState *ms)
>>>>      } while (ret =3D=3D -EINTR);
>>>>        if (ret < 0) {
>>>> -        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret,
>>>> -                strerror(-ret));
>>>> +        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
>>>> +                    strerror(-ret));
>>>>    #ifdef TARGET_S390X
>>>>          if (ret =3D=3D -EINVAL) {
>>>> -            fprintf(stderr,
>>>> -                    "Host kernel setup problem detected. Please verif=
y:\n");
>>>> -            fprintf(stderr, "- for kernels supporting the switch_amod=
e or"
>>>> -                    " user_mode parameters, whether\n");
>>>> -            fprintf(stderr,
>>>> -                    "  user space is running in primary address space=
\n");
>>>> -            fprintf(stderr,
>>>> -                    "- for kernels supporting the vm.allocate_pgste s=
ysctl, "
>>>> -                    "whether it is enabled\n");
>>>> +            error_report("Host kernel setup problem detected.
>>>=20
>>> \n"
>>>=20
>>> Should we use error_printf_unless_qmp() for the following?
>>>=20
>>> " Please verify:");
>>>> +            error_report("- for kernels supporting the switch_amode o=
r"
>>>> +                        " user_mode parameters, whether");
>>>> +            error_report("  user space is running in primary address =
space");
>>>> +            error_report("- for kernels supporting the vm.allocate_pg=
ste "
>>>> +                        "sysctl, whether it is enabled");
>>=20
>> Do not put newlines into error messages.  error_report()'s function
>> comment demands "The resulting message should be a single phrase, with
>> no newline or trailing punctuation."
>>=20
>> You can do this:
>>=20
>>    error_report(... the actual error message ...);
>>    error_printf(... hints on what to do about it ...);
>>=20
>> Questions?
>
> Do you see any newlines in my proposed patch?

I see some in Philippe's suggestion.

Your patch's use of multiple error_report() for a single error condition
is inappropriate.

Questions?


