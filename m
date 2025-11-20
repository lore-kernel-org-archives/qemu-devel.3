Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30D9CF8854
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4Rv-0002yL-PD; Thu, 20 Nov 2025 08:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vM4Rt-0002xi-RD
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 08:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vM4Rr-0000Jj-SQ
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 08:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763644301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qyhhdzn0BYMbkUVey/n2YMFPr5fhLGbTZAGvpz5pi1c=;
 b=JlCb4T4c5JtVhbbUQc631/tFniz0gdXHBP6bJFqefzcumugrszFfzF5b8kxK1bnnAj87Ej
 RsoXng8UyMr+JPPAyKxoSRfN5rqP45vflfOupFxHFCBsfbYlPKnkISKl6qeKwHcHY2gFP7
 J8uHb0mjl75pwFKwIvqEjs6Oh+EHEoQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-6OvnX6EePCW-ULeab7o0mQ-1; Thu, 20 Nov 2025 08:11:39 -0500
X-MC-Unique: 6OvnX6EePCW-ULeab7o0mQ-1
X-Mimecast-MFC-AGG-ID: 6OvnX6EePCW-ULeab7o0mQ_1763644298
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477a60a23adso5828905e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763644298; x=1764249098; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qyhhdzn0BYMbkUVey/n2YMFPr5fhLGbTZAGvpz5pi1c=;
 b=P82PP92Kc1iW2g7yR5wjsmMPlamN4PSliCjvyBclNcY8V4HORN+2FSm8KzARbnY1E9
 frMVG22xxN4LyrKd85sC+kxk07vBi5/o1fkQWnQnry7JhTKJK1icoU0bivEHWiAxP8+8
 jt/YFirD+mr83Pxpabginjuh0SUQ8v596ktKyekDT80NvjC63KKWfvwchAxFIbs7rp2d
 A1KtPKz5QwoJBZlBrJisWa3DMfYn8eSBra2Glmt7BBFke0I6JGdKE/KIfG3/VinvVgbD
 my7eBKmUraeaRoEbwqjlQ0QSChqlRKw3NpEYosAhK7tF4asPrZj0O6JCxEXYXfceGoWF
 GTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763644298; x=1764249098;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qyhhdzn0BYMbkUVey/n2YMFPr5fhLGbTZAGvpz5pi1c=;
 b=Y1BlAuh+DMD+0nvOtnrCe5TKyAnx0YuRglr46ERVU9ink983JcIJStTEVl66zfWCKA
 8H0cXiliDm4X+FV7EMAGBC9Idzonz6jMd/kHhjpyLCAN2fKiOFRFnx4ER3X5lMZ09Srn
 iaQZx1l5FIkv888Xpw5jrwACUfTvENn4+P/ETX9OevMpZ9ReLlyByfG5rqTxqgc3aR72
 2V/BlMBRZjeuorZ0wcNhOtmTGiibTN/WAV18dIk2HpXYFlqiBV/G2VwQJjZxt2WMnsni
 +u9Nk3sYsQjfHEjmafILSx5Q7lyNZ+f5iKu5olbN3OqGaJnhfab3hyiqty0xMty10xbt
 IzDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxeM+O28Uo9a8Fp7yzfRv+YLDIX2uIVBCovpHaJIM8jWXjMXP3KupFk0VSEBuye0eMZcM6MkwOASkb@nongnu.org
X-Gm-Message-State: AOJu0YzauD8GM35W/IJfAwRNPB9Lb8MOP4Bwn8M4XwpTtRgT2cAP1YUm
 SAMxqemMrUMpMYF56qXY/Q3XHz+1YH+IQjGCn8FtCkGMvsZcPOeXVLzIrcYW7ZRMLPt64/ZXA96
 ofV24Y0+vBqHkSx+PeZdNQpYYlm/jSprNP33bmt1suoGF0ce/px3d1Bob
X-Gm-Gg: ASbGncsQ57DeM77kDgvEnnbWSecdaFabAYUhGBjWAUnCmLaOofczZMlQFuuptq6nM5X
 9EZALI5rsr/yy/wuJUWzSTs/zao9ICOWNfuVktye52ZHJ5sotiv3zJJmgEtXK+QgXVVBztTA6+f
 Ka57rKt6cjWjfGwcBehuRhl3M0Ger+839+wDtCmk0Ae91XGr5oXRv43wVgEMp5wZJlVLgrSGzwU
 y1nVSFt67O3aFEtsFtvFnB6Gurg08o86pRGyJBcdzcrUqiqmGxlJVZOxgqxRoOG4OZHcqf9l9bT
 ieozhgflOyCxGU3lbzBkzkGdJXPRuFM3AOvuDBpgKdcS1Bk7DhB6TKcPNImxbc18VC7JDtRX0bT
 WJ9CIe4eBbYfCNjwP/CGMdyEVzB9A+OB112Wps2P/x9sHtewbZxGy4/gXTa0=
X-Received: by 2002:a05:600c:19cf:b0:477:7725:c16a with SMTP id
 5b1f17b1804b1-477b9deb5fcmr27551055e9.10.1763644298198; 
 Thu, 20 Nov 2025 05:11:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqk0rLj6ifgE7tCamOIWPRaEiyBBbqDGCq1Uha6rrPDrmf26u75w870PL6lQD0kcpOCi1brA==
X-Received: by 2002:a05:600c:19cf:b0:477:7725:c16a with SMTP id
 5b1f17b1804b1-477b9deb5fcmr27550685e9.10.1763644297761; 
 Thu, 20 Nov 2025 05:11:37 -0800 (PST)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a974cdc8sm67987845e9.2.2025.11.20.05.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 05:11:37 -0800 (PST)
Date: Thu, 20 Nov 2025 14:11:35 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 2/2] target/arm/kvm: add kvm-psci-version vcpu property
In-Reply-To: <a2d0ddf1-f00c-42dd-851d-53f2ec789986@redhat.com>
Message-ID: <8c679736-a168-0a33-e44a-4367e9e7b8d4@redhat.com>
References: <20251112181357.38999-1-sebott@redhat.com>
 <20251112181357.38999-3-sebott@redhat.com>
 <d4f17034-94d9-4fdb-9d9d-c027dbc1e9b3@linaro.org>
 <c082340f-31b1-e690-8c29-c8d39edf8d35@redhat.com>
 <a2d0ddf1-f00c-42dd-851d-53f2ec789986@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1463806286-370073406-1763644297=:54158"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806286-370073406-1763644297=:54158
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 20 Nov 2025, Eric Auger wrote:
> On 11/13/25 1:05 PM, Sebastian Ott wrote:
>> Hi Philippe,
>>
>> On Wed, 12 Nov 2025, Philippe Mathieu-Daudé wrote:
>>> On 12/11/25 19:13, Sebastian Ott wrote:
>>>>  Provide a kvm specific vcpu property to override the default
>>>>  (as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
>>>>  by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>>>>
>>>>  Note: in order to support PSCI v0.1 we need to drop vcpu
>>>>  initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
>>>>
>>>>  Signed-off-by: Sebastian Ott <sebott@redhat.com>
>>>>  ---
>>>>    docs/system/arm/cpu-features.rst |  5 +++
>>>>    target/arm/cpu.h                 |  6 +++
>>>>    target/arm/kvm.c                 | 64
>>>> +++++++++++++++++++++++++++++++-
>>>>    3 files changed, 74 insertions(+), 1 deletion(-)
>>>
>>>
>>>>  diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>>>  index 0d57081e69..e91b1abfb8 100644
>>>>  --- a/target/arm/kvm.c
>>>>  +++ b/target/arm/kvm.c
>>>>  @@ -484,6 +484,49 @@ static void kvm_steal_time_set(Object *obj, bool
>>>>  value, Error **errp)
>>>>        ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON :
>>>>    ON_OFF_AUTO_OFF;
>>>>    }
>>>>
>>>>  +struct psci_version {
>>>>  +    uint32_t number;
>>>>  +    const char *str;
>>>>  +};
>>>>  +
>>>>  +static const struct psci_version psci_versions[] = {
>>>>  +    { QEMU_PSCI_VERSION_0_1, "0.1" },
>>>>  +    { QEMU_PSCI_VERSION_0_2, "0.2" },
>>>>  +    { QEMU_PSCI_VERSION_1_0, "1.0" },
>>>>  +    { QEMU_PSCI_VERSION_1_1, "1.1" },
>>>>  +    { QEMU_PSCI_VERSION_1_2, "1.2" },
>>>>  +    { QEMU_PSCI_VERSION_1_3, "1.3" },
>>>>  +    { -1, NULL },
>>>>  +};
>>>
>>>
>>>>  @@ -505,6 +548,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>>>>                                 kvm_steal_time_set);
>>>>        object_property_set_description(obj, "kvm-steal-time",
>>>>                                        "Set off to disable KVM steal
>>>>  time.");
>>>>  +
>>>>  +    object_property_add_str(obj, "kvm-psci-version",
>>>>  kvm_get_psci_version,
>>>>  +                            kvm_set_psci_version);
>>>>  +    object_property_set_description(obj, "kvm-psci-version",
>>>>  +                                    "Set PSCI version. "
>>>>  +                                    "Valid values are 0.1, 0.2,
>>>> 1.0, 1.1,
>>>>  1.2, 1.3");
>>>
>>> Could we enumerate from psci_versions[] here?
>>>
>>
>> Hm, we'd need to concatenate these. Either manually:
>> "Valid values are " psci_versions[0].str ", " psci_versions[1].str ",
>> " ... which is not pretty and still needs to be touched for a new
>> version.
>>
>> Or by a helper function that puts these in a new array and uses smth like
>> g_strjoinv(", ", array);
>> But that's quite a bit of extra code that needs to be maintained without
>> much gain.
>>
>> Or we shy away from the issue and rephrase that to:
>> "Valid values include 1.0, 1.1, 1.2, 1.3" 
> Personally I would vote for keeping it as is

OK, thanks!

> (by the way why did you
> moit 0.1 and 0.2 above?)

Just to clarify that this is an incomplete list of possible values
that we don't have to change when a new psci version is introduced.

Sebastian
---1463806286-370073406-1763644297=:54158--


