Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E191C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 16:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZuOD-0000tw-Av; Mon, 20 Jan 2025 11:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1tZuO5-0000tY-GG
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 11:12:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1tZuO2-0003xk-Uj
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 11:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737389544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9yhP0uEDiYJqmFpzHNnhf1BaxUbSn+fjd9KQVLXJQPM=;
 b=CWnQUUV+YRMDuBzvaHVxeWwB1k5iwRcecEFJNonUiKoOFu0wEf6rJB2TOnarHJEt+XdAku
 714S9LB0eNAq9se846mt+0Lq0GF0u87f0S8maEO4Hf6OCzn81/9V8a82blWclPyWV4P6B1
 QqEA7A9y3asq37H3xH7LaO2NItc34Dc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-bcy3O9hxO72b0ZTWaCZADw-1; Mon, 20 Jan 2025 11:11:15 -0500
X-MC-Unique: bcy3O9hxO72b0ZTWaCZADw-1
X-Mimecast-MFC-AGG-ID: bcy3O9hxO72b0ZTWaCZADw
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2167141e00eso93067115ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 08:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737389474; x=1737994274;
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9yhP0uEDiYJqmFpzHNnhf1BaxUbSn+fjd9KQVLXJQPM=;
 b=ZpLlno7v6s0Beahd7HV/54/Z9wgZj00LF4vQYE6DdY9Uk7w+oPC3OUlqZQHcLYN6c+
 +YgEsUnYj+OdOmJqyoMgkHVuXjPVJ7DlLZ3w8RUpR/XbO1doEQmiYyFWPUqPbQSgdKZ6
 RiLZkryX9E8HMTXKwYO4tGpMxE0rHq8EIWrZ+DzKwl/Tx29WMkHXh7wRI4im5v4RsKlJ
 ft5SSkKdypuFPeJ+fueQs0IygkpwyEcFOQmG0kh6g2VGvu0Ucz68+Ry6VHiRkawu3QR8
 OFr57BkgdpwlVz9XObqZo51XO4erD/4MWvRbfIgIWYBYTpLzBe/9N3LClagMOB8SrG9b
 Ttkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ82/SQBCCJTYadZLl7d8gaA65FlTRCO7L/BxKJlS2pTQuVZp1j4mbAyb3AqiqssgMGfYIQ+j6f1jJ@nongnu.org
X-Gm-Message-State: AOJu0YyEgLPG9tPJAjSfL1sNvWFbSinZGl7L4L/tky+RM7oqKByDwnhw
 ShZiZT2HiH9YJdNrPUdCS1wNrHbBdR0Qce/1TaYGmeIJJ69Mpn5skzQnsBzDtK/nHY6aHNUz7jP
 O+/a16As8K0o6+rpNgg0u1wUWB49wDuOQG6DVUMzotPTnI9TaKc4Ar5WSp0vP0C4jKFk4mduor3
 tAjf2zbN4wlhKCo4nbd9+X1DfAexM=
X-Gm-Gg: ASbGncv+OzjqPY4aF+a0SEgU3//b833P2cf7HOXt6uPtGqadHzaeTU2cxmWriItHbrA
 VzBm3FzmJ2UujNpo4hi9OV7rm9cTqePFpVNC+y8vjQ4A6NnA=
X-Received: by 2002:a05:6a21:339c:b0:1ea:ee89:5d9b with SMTP id
 adf61e73a8af0-1eb214de499mr21741654637.21.1737389474490; 
 Mon, 20 Jan 2025 08:11:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbUk+WS6LF10O+x07NUvjGCEgshyimdh3kxomHCEng5OH9/TtTlJchkF2CXAvwBzA3PHcxBT8dS7jFRzYzS7M=
X-Received: by 2002:a05:6a21:339c:b0:1ea:ee89:5d9b with SMTP id
 adf61e73a8af0-1eb214de499mr21741606637.21.1737389474081; Mon, 20 Jan 2025
 08:11:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 11:11:13 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20250120105825.400434-1-thuth@redhat.com>
References: <20250120105825.400434-1-thuth@redhat.com>
MIME-Version: 1.0
Date: Mon, 20 Jan 2025 11:11:13 -0500
X-Gm-Features: AbW1kvYBi4iE3P80CJYntkYSZJ_kT0NzN7uJQnx6azGsWI22tlkxTldjwJV5TnM
Message-ID: <CAAiTLFUUUU01WTVD8C_auZ5=h=znQTXe+L0f6CBLpovgOrc5eQ@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/microvm: Fix crash that occurs when introspecting
 the microvm machine
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=slopezpa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> QEMU currently crashes when you try to inspect the properties of the
> microvm machine:
>
>  $ echo '{ "execute": "qmp_capabilities" }
>          { "execute": "qom-list-properties","arguments":
>            { "typename": "microvm-machine"}}' | \
>    ./qemu-system-x86_64 -qmp stdio
>  {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
>   "package": "v9.2.0-1072-g60af367187-dirty"}, "capabilities": ["oob"]}}
>  {"return": {}}
>  qemu-system-x86_64: ../qemu/hw/i386/acpi-microvm.c:250:
>   void acpi_setup_microvm(MicrovmMachineState *):
>    Assertion `x86ms->fw_cfg' failed.
>  Aborted (core dumped)
>
> This happens because the microvm machine adds a machine_done (and a
> powerdown_req) notifier in their instance_init function - however, the
> instance_init of machines are not only called for machines that are
> realized, but also for machines that are introspected, so in this case
> the listener is added for a microvm machine that is never realized. And
> since there is already a running machine, the listener function is
> triggered immediately, causing a crash since it was not for the right
> machine it was meant for.
>
> Such listener functions must never be installed from an instance_init
> function. Let's do it from microvm_machine_state_init() instead - this
> function is the MachineClass->init() function instead, i.e. guaranteed
> to be only called once in the lifetime of a QEMU process.
>
> Since the microvm_machine_done() and microvm_powerdown_req() were
> defined quite late in the microvm.c file, we have to move them now
> also earlier, so that we can get their function pointers from
> microvm_machine_state_init() without having to introduce a separate
> prototype for those functions earlier.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/i386/microvm.c | 66 +++++++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

Thanks, Thomas!

Sergio.


