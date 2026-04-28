Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9A8FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbif-0005sp-Or; Tue, 28 Apr 2026 02:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbie-0005sM-GT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:14:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbic-0000gv-F9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:14:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso109959295e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777356889; x=1777961689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1d8TNqz2NHJG5W/9arvrmncK1DAev/rLBR9mufXqyrQ=;
 b=my4+R2oFHamuuevOrPO3yyjwsFJ2wzcp6l2xvxoDLrDzVYKYN4jKQUFSXD8xXf7V4M
 OGf9HYq6nD92OGKdy/x36BiDYKXHP+4cCl7YI+gmXJLrn9MpGgr0kc6Rekmr4mHord+a
 papqKzvufdLEtm4s2NK4RRj2mnazPRpKZgSSbFcFQn2eh0kIkZ0jOBYZsGI5uMK0M/eS
 9eyKyHEzCcbftsq9AVLkg3w2mqDYMYF/uirc4VXZ411/H5mrHQPY9aWFVuhTgVssgtdB
 6qVbGq6fNuUF2q0PlmXmR6yOdFxG0hIuQkn/H8HkezlbdW2BwKsSCwD4nXqhX3tya3fR
 q4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356889; x=1777961689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1d8TNqz2NHJG5W/9arvrmncK1DAev/rLBR9mufXqyrQ=;
 b=fRigyfM7R9IPWeLK5na82OapwlJZwz+vyrLThUEnIK9tHa/mUF5vxryje+l3U0asbc
 ywWOhAfs6C93DFC4Cg5tEOFOXOXUeIV1zFgnjNHlaoweic+p7tc0gS7GnUjDfqZVBLBA
 lillDl0N8pCq8ZUh4RYToIDBcfXmRgCPSsinN7nGYNp3pC4abToIekLiNQgncVi759B1
 Suiv5GNiGaDCJ3gZdXFlwptfjLAFrJeM4HxvID3VEAaChzM4ufxcG0Jpcr0JdrNvdel9
 MSCpYDJgDQK7dGc5Q/Sw5Yf4m0zteHlO7fGvDDEC7CpjxufYtQmuBAlsB38DTQfBVwEU
 1dvg==
X-Gm-Message-State: AOJu0YwTI12Knwkae0vg0lfDMlcR4eW3qOci/cXFIYbLf1xeP/iGRYXU
 yikW5GBrOciiDKfN9E49dkHQR6owcB3W5paBvwD4mi9E89qpKqja0sSqBe5ZqT63sqY=
X-Gm-Gg: AeBDiesRBaa5f+18u+d/rjh4+nqKwh7CC3BnhZ3XkQFdfcRP0Anj/kkN8mRpM1n4B7o
 i20FvytyDKr+jwa2hocI4U6ywU3qtgXtyY/wBzPPgjUFLfygdEWcZJcmyCjlys6oF6DDO8PKbrB
 PVQGsFOo/PZ6p3CqT2f8JHAbfoZ2OG3jkMpox83fxaqD4+Jr8h2/vhzphQukY8Bk2IgwUhftdDd
 BLwEOcYefj5/WLgCkCBYxjm+0i2VGqOHw9rf1MOuVQdHb679qeGNyGKaDm6pkATRWpOMxsycOkm
 g1tC6iJD4w7Q3ako+5g8C+OOsIFkrjdB7mmSEmYTR3/Cjdp9IoNqQYQsERwOUHdyJkh+Ip1UrCr
 KFX8e2HMeydj1QGZ54c9fccWUC4oMSMyKP+h73HFPJhOF8r9XMl8v4PAQ6LiWqd++/ERyTAocve
 chHs89Cp53EfyLwpIo+NC2IqbKM6mhJO6xTS5lvvkwbTVLREkRUsV8i2YtbVES78Vm7jDhfx9ic
 jQG
X-Received: by 2002:a05:600c:3b15:b0:487:1108:48af with SMTP id
 5b1f17b1804b1-48a77ae5412mr26976425e9.4.1777356888561; 
 Mon, 27 Apr 2026 23:14:48 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77aab1b4sm27180145e9.0.2026.04.27.23.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 23:14:47 -0700 (PDT)
Message-ID: <8e86fe74-4b31-40e5-baf7-88ec7fd399a9@linaro.org>
Date: Tue, 28 Apr 2026 08:14:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/41] hw/pci-host/i440fx: handle NULL bus in pci-hole64
 getters
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-4-c413f3605311@redhat.com>
 <d48730e4-2034-4245-a671-9d2dbd72b1a3@linaro.org>
 <CAJ+F1C+ginfPqr3K4yYpnhC++SDt6Z0YBH92aTexiMHZpsX6dg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ+F1C+ginfPqr3K4yYpnhC++SDt6Z0YBH92aTexiMHZpsX6dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 28/4/26 08:10, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Apr 28, 2026 at 1:01 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 27/4/26 21:42, Marc-André Lureau wrote:
>>> When called on an unrealized i440FX host bridge (e.g. from
>>> qmp_qom_list_properties), h->bus is NULL since the root bus is only
>>> created during realize. Guard against this in both
>>> pci_hole64_start and pci_hole64_end getters, reporting an error.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    hw/pci-host/i440fx.c | 15 +++++++++++++--
>>>    1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
>>> index e7d638b296c..6952094510d 100644
>>> --- a/hw/pci-host/i440fx.c
>>> +++ b/hw/pci-host/i440fx.c
>>> @@ -189,8 +189,14 @@ static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
>>>                                                    const char *name,
>>>                                                    void *opaque, Error **errp)
>>>    {
>>> -    uint64_t hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
>>> +    PCIHostState *h = PCI_HOST_BRIDGE(obj);
>>> +    uint64_t hole64_start;
>>>
>>> +    if (!h->bus) {
>>> +        error_setg(errp, "bus not realized");
>>
>> "PCI host bridge not realized"?
> 
> Ok
> 
>>
>> But calling a getter at this point is a programming error IMHO.
>>
> 
> We don't have a way to prevent calling getters when objects are just
> instantiated but not yet in some "clean" state. Since this can be
> triggered at run-time by QMP, we better return an error than doing
> assert() or crash.

Yeah I know, thus no objection, but still I'm wondering if this is
a good design. Maybe running introspection tests should be restricted
to a particular QEMU mode, like x-pre-config?

