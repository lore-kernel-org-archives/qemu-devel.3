Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6507D78799
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAle-0008J0-1d; Thu, 21 Nov 2024 12:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEAlb-0008CO-Ui
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:14:55 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEAlW-0003eT-Mc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:14:55 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-382442b7d9aso997772f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732209289; x=1732814089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1jRM3SbL2Xoxq1lgpfB4HaF+zi4Ki5mT+NgJ7XmAcb8=;
 b=iPuKk0poh+j7GnFFz5VxpJKjpbuwtjnhDKPcvpl38yqFmO+KTYgiQ2ybinb17Kin49
 t9tW4VbeK4NVGyX5w9ITVe593/i+EG3d9unt8IHsItvsmy8c27c6kDrZSf8vyETuPoOC
 Is8Bu5GXXkDvqsU1DV5NCkjPZZU0b8RAp31wg7hg1KMSRp3vtOgPu6uIEel8oEwv/vQP
 p7AazgW3HXw3AkavPh1RXOvO222Q/iBBnohLVxqNXjxuFJs8+kTVQs25ny2sbEF6tz8a
 UUt4rgwImp0PrzcXFjw8kV0Uxqw5UdnYyct5N9/nib1ekt1S4Zuti3c6tDZNcygqGUia
 Lbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732209289; x=1732814089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1jRM3SbL2Xoxq1lgpfB4HaF+zi4Ki5mT+NgJ7XmAcb8=;
 b=Lt2HvA5DbD9uHDR5Lsrfyt4yZwBg++0BGB7IM6RZjk4kokILnTna4l5injOPCizvcm
 TbnCOT9dgNy/Mq+A7e95yhENsXx6Xk7kHBm8cyqBXfTv1iACpi2xIehIjsIRwTQpasMW
 b5E42NiBLA13f1ui3/ScNW5QHis2eP8qR8P6XI58ZLMXziWj/EXax4j2efPXOZ82HOTm
 JUAqofEi5p8/LvjqizsOs58CldG0HYb1+gmx7zDrWqEJ+KYPqeZzDjOIH/+cLDay0wnT
 xTu9igkGzgEKf3wn+UcMchlbqgQXlMZI8EpFCJ/AOw5wxOH0bzWNMfHx2OG+cyb0zeJK
 cxJg==
X-Gm-Message-State: AOJu0YzOjJzLqO+feqIJ/o89YrM8lWJSq8R6Qh2mcrVh1jKYIAWk2OWK
 6yC7Pbc3XRiY9AWQjMdCmvos8VY9copTyEdrt+IgaMd1PU9a+WIlbXiEkT3a8wM=
X-Gm-Gg: ASbGncsi26o01kc60JYS/VlR8+OWQMe4a9IY/kSdj4WIsPcERtAm9y6JxhsKZPIdw5c
 dszkbKZ04oe2vFwPua1xDEGmdseBxXJzKE7/xM40nCbfsL7KJIJAKuPYX6pM21Na5oJtUrKbTx4
 1SeFHEgO/6GB8vokpS1s5ud+/lL+kgKjn4gVqGmh//VIRfsnCyt9MwDaDNd35CUqYWd0Q6agQSC
 rGsXBu49YRfVKHpT0EcQ305ZP4i1IsjMujPagRCnZ0cJTb+Fij4bMlGK1VfQuXK
X-Google-Smtp-Source: AGHT+IEc/r7dJx8PwhuQUDtSYCOFEJ3DJUcEFDvPnIeulnpDu3V95N2AeBLgj3cMHVOwe9lZex0WLw==
X-Received: by 2002:a5d:47af:0:b0:382:44e0:c5e9 with SMTP id
 ffacd0b85a97d-38254af9c4fmr5797178f8f.25.1732209288794; 
 Thu, 21 Nov 2024 09:14:48 -0800 (PST)
Received: from [192.168.69.197] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafe338sm71258f8f.33.2024.11.21.09.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 09:14:47 -0800 (PST)
Message-ID: <2c5fb523-d146-4629-8fad-125011b518d6@linaro.org>
Date: Thu, 21 Nov 2024 18:14:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] hw/ppc: Explicitly create the drc container
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-7-peterx@redhat.com>
 <66301003-f2cd-4a0a-8951-cbfdcb1c398b@linaro.org> <Zz9hnEj3xQnOoM0c@x1n>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zz9hnEj3xQnOoM0c@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 21/11/24 17:36, Peter Xu wrote:
> On Thu, Nov 21, 2024 at 10:35:39AM +0100, Philippe Mathieu-Daudé wrote:
>> Hi Peter,
>>
>> On 20/11/24 22:56, Peter Xu wrote:
>>> QEMU will start to not rely on implicit creations of containers soon.  Make
>>> PPC drc devices follow by explicitly create the container whenever a drc
>>> device is realized, dropping container_get() calls.
>>>
>>> No functional change intended.
>>>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
>>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> Cc: qemu-ppc@nongnu.org
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    hw/ppc/spapr_drc.c | 40 ++++++++++++++++++++++++++++++----------
>>>    1 file changed, 30 insertions(+), 10 deletions(-)
>>
>>
>>> +static GOnce drc_container_created = G_ONCE_INIT;
>>> +
>>> +static gpointer drc_container_create(gpointer unused G_GNUC_UNUSED)
>>> +{
>>> +    container_create(object_get_root(), DRC_CONTAINER_PATH);
>>> +    return NULL;
>>> +}
>>> +
>>> +static Object *drc_container_get(void)
>>> +{
>>> +    return object_resolve_path_component(
>>> +        object_get_root(), DRC_CONTAINER_PATH);
>>> +}
>>> +
>>> +/* TODO: create the container in an ppc init function */
>>> +static void drc_container_create_once(void)
>>> +{
>>> +    g_once(&drc_container_created, drc_container_create, NULL);
>>> +}
>>> +
>>>    static void drc_realize(DeviceState *d, Error **errp)
>>>    {
>>>        SpaprDrc *drc = SPAPR_DR_CONNECTOR(d);
>>> @@ -521,6 +541,9 @@ static void drc_realize(DeviceState *d, Error **errp)
>>>        Object *root_container;
>>>        const char *child_name;
>>> +    /* Whenever a DRC device is realized, create the container */
>>> +    drc_container_create_once();
>>
>> Can't we just create it once in spapr_dr_connector_class_init(),
>> removing the G_ONCE_INIT need?
> 
> IIUC it's a matter of whether there's case where we have this file compiled
> in, but never create any DRC device.  When that happens, the patch can
> change the QEMU qom-tree slightly, in that there'll be an empty drc
> container while we used to not have it.
> 
> I'm trying to be on the safe side in case something would detect the
> container's existance to know whether drc devices are present.  lazy create
> it in realize() is the safest way to behave 100% identical like before,

Class singleton must be taken care in class_init, not once in the
first instance realize(). I'd rather fix this bad QOM pattern.

> considering my ppc knowledge is merely zero (even if I have drc tests
> covered in ppc64's qtest..).
> 
> However I also doubt whether it matters much.  It'll be great if I can get
> an ACK from anyone familiar with this device (Phil, are you?), then I can
> move it over.

I'm not, but having to care about G_ONCE_INIT seems cumbersome.

> 
>>
>>>        trace_spapr_drc_realize(spapr_drc_index(drc));
>>>        /* NOTE: we do this as part of realize/unrealize due to the fact
>>>         * that the guest will communicate with the DRC via RTAS calls
>>> @@ -529,7 +552,7 @@ static void drc_realize(DeviceState *d, Error **errp)
>>>         * inaccessible by the guest, since lookups rely on this path
>>>         * existing in the composition tree
>>>         */
>>> -    root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
>>> +    root_container = drc_container_get();
>>>        child_name = object_get_canonical_path_component(OBJECT(drc));
>>>        trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
>>>        object_property_add_alias(root_container, link_name,
>>
> 


