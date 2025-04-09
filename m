Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D5BC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 05:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2O1m-00008X-OY; Wed, 09 Apr 2025 01:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u2O1k-00007y-H8
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 01:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u2O1f-0008DQ-MS
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 01:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744176660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ugIF7tjKsi26UJCKbDwnBoN42ojVtAQ19ZUXc5RZ3Bo=;
 b=bejhK3r+dn6+CQStdvA2UN5oK67GC/VGjKAqpyAnChjVlV4LpwigbE1kRIwDa+KHWB95CN
 lTk9lx3akFTEL5ZOc7w0BTVI+AV4ZKHT0DnEzvzfai5PdpbCRDrXse9KHGbv9aO5aTa+RM
 OVZEKEOzfqgKJo4OLON5hQfhko+5gkw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-ez0ULGCrOeayVY2G46dN0w-1; Wed, 09 Apr 2025 01:30:59 -0400
X-MC-Unique: ez0ULGCrOeayVY2G46dN0w-1
X-Mimecast-MFC-AGG-ID: ez0ULGCrOeayVY2G46dN0w_1744176658
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e623fe6aa2so6746745a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 22:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744176658; x=1744781458;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ugIF7tjKsi26UJCKbDwnBoN42ojVtAQ19ZUXc5RZ3Bo=;
 b=bEYxvRupBpG0hLkMPjMemHqjtAeKZuvXb+xEw2f921gktqw5JsfwjWK5MVXrteGcHJ
 JvboDb6z7ubT4yggAY4OTQPGglAME9Rxl4FTUDGVwwfAuaa0lurKt9ETWiGT97e5A0FM
 G9TWBTbMbLqLxL74iH65JbTjVRN56L+YPyG0uoj2Qmjd3qO7SKBvdjQ366En83kkH4M7
 qvpzy/qjAexF6ZlAgmuBBEARr2lNb6Ljac2R27g8liaSBFqs2zDztVU2/4TT5b4ly39t
 S0Xv/HCrG3iqxG7dDqtpjMLY+NFRcJ6cQlFlX0CZZ7M6V5aRDpkKKQ0idOLu3CATo3kf
 LFlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEKwXiGY4QzbH1Q2AIDjFWJuNhFxhm1X4wM+zX/2JEG72YomOSeF3qJMqYdQ8o6t648OCJllFrxI+9@nongnu.org
X-Gm-Message-State: AOJu0YydUP0iGiUWgGZi/SNM93FQqi9u/JXGGVZUTNCIiQKHIkz3aPBf
 6ubi45qQE2xrinmOyK7mJjX0l6KAAwV+MKLChXoOQTbYdK8t3jSAzVJ8ox2U8bTI400/2r7NsH9
 qvO2qpnHr60TDM0RtuFaxcI/ejzbeHixRt0Dh/4Xy/uusLwnD+Y9x
X-Gm-Gg: ASbGncse+eRAUfbQOUo6gcVTj4BbG/Pis+gWR7W5vXoDNTuwSgYL7MwW0KN1uTF3glz
 PHmXsASUusyfnx+mtjJ1eb5N5z7h4ArPbW3JKIGHIM1HNYTyzlKYagvoB68JfUKY+Qxhg+pdaqT
 sDIjE+ijXnmePcRtjXTHBHXSB8uPwPW9DY8WFcHgjzMu8gBZ2aFZOCTRCktTN+qELmEaB42PxG+
 N3FhAZEoI9hCpDKFF1xqBTNjSQNQ2nHSusN4UikrGyEOC2QWNNlCC3DszixznYsYFx+LznqTXA7
 BdmO5c4ElPh8TGOLVFqq57SwbADWpspqZF8ZHAJ5qqbLYWk=
X-Received: by 2002:a05:6402:2810:b0:5ec:922f:7a02 with SMTP id
 4fb4d7f45d1cf-5f2f76b51f2mr1376498a12.10.1744176657967; 
 Tue, 08 Apr 2025 22:30:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0dw7x9MG6AVwSkE/MGZ9YdHHazsFKVCmfFwG4fuJFXSH7tzyj10pT5dfOfR0BXej023S2Og==
X-Received: by 2002:a05:6402:2810:b0:5ec:922f:7a02 with SMTP id
 4fb4d7f45d1cf-5f2f76b51f2mr1376481a12.10.1744176657503; 
 Tue, 08 Apr 2025 22:30:57 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f2fbc0c7basm232676a12.30.2025.04.08.22.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 22:30:57 -0700 (PDT)
Message-ID: <7743d8f3-497f-4d7e-9f42-16d8e8fc5c8e@redhat.com>
Date: Wed, 9 Apr 2025 07:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hw/s390x: add Control-Program Identification to QOM
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <bc4a5b3f078657b8dc3045a207ba9386@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <bc4a5b3f078657b8dc3045a207ba9386@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/04/2025 16.33, Shalini Chellathurai Saroja wrote:
> On 2025-04-01 15:55, Nina Schoetterl-Glausch wrote:
>> On Mon, 2025-03-31 at 16:00 +0200, Shalini Chellathurai Saroja wrote:
>>> Add Control-Program Identification data to the QEMU Object
>>> Model (QOM), along with the timestamp in which the data was received.
>>>
>>> Example:
>>> virsh # qemu-monitor-command vm --pretty '{
>>> "execute": "qom-get",
>>> "arguments": {
>>> "path": "/machine/sclp/s390-sclp-event-facility/sclpcpi",
>>> "property": "control-program-id" }}'
>>> {
>>>   "return": {
>>>     "timestamp": 1742390410685762000,
>>>     "system-level": 74872343805430528,
>>>     "sysplex-name": "PLEX ",
>>>     "system-name": "TESTVM  ",
>>>     "system-type": "LINUX   "
>>>   },
>>>   "id": "libvirt-15"
>>> }
>>>
>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>> ---
>>>  hw/s390x/sclpcpi.c                | 38 ++++++++++++++++++++
>>>  include/hw/s390x/event-facility.h |  9 +++++
>>>  qapi/machine.json                 | 58 +++++++++++++++++++++++++++++++
>>>  3 files changed, 105 insertions(+)
>>>
>>> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>>> index 7ace5dd64e..969c15e43d 100644
>>> --- a/hw/s390x/sclpcpi.c
>>> +++ b/hw/s390x/sclpcpi.c
>>> @@ -57,8 +57,11 @@
>>>    */
>>>
>>>  #include "qemu/osdep.h"
>>> +#include "qemu/timer.h"
>>>  #include "hw/s390x/sclp.h"
>>>  #include "hw/s390x/event-facility.h"
>>> +#include "hw/s390x/ebcdic.h"
>>> +#include "qapi/qapi-visit-machine.h"
>>>
>>>  typedef struct Data {
>>>      uint8_t id_format;
>>> @@ -99,10 +102,37 @@ static int write_event_data(SCLPEvent *event, 
>>> EventBufferHeader *evt_buf_hdr)
>>>      ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, 
>>> ControlProgramIdMsg,
>>>                                               ebh);
>>>
>>> +    ascii_put(event->cpi.system_type, (char *)cpim->data.system_type, 8);
>>> +    ascii_put(event->cpi.system_name, (char *)cpim->data.system_name, 8);
>>> +    ascii_put(event->cpi.sysplex_name, (char *)cpim->data.sysplex_name, 8);
>>> +    event->cpi.system_level = ldq_be_p(&cpim->data.system_level);
>>> +    event->cpi.timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
>>> +
>>>      cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
>>>      return SCLP_RC_NORMAL_COMPLETION;
>>>  }
>>>
>>> +static void get_control_program_id(Object *obj, Visitor *v,
>>> +                                   const char *name, void *opaque,
>>> +                                   Error **errp)
>>> +{
>>> +    SCLPEvent *event = (SCLPEvent *)(obj);
>>
>> Do a checked cast with SCLP_EVENT(obj).
> 
> Hello Nina,
> 
> ok, thank you.
>>
>>> +    S390ControlProgramId *cpi;
>>> +
>>> +    cpi = &(S390ControlProgramId){
>>> +        .system_type = g_strndup((char *) event->cpi.system_type,
>>> +                                 sizeof(event->cpi.system_type)),
>>> +        .system_name = g_strndup((char *) event->cpi.system_name,
>>> +                                 sizeof(event->cpi.system_name)),
>>> +        .system_level = event->cpi.system_level,
>>> +        .sysplex_name = g_strndup((char *) event->cpi.sysplex_name,
>>> +                                  sizeof(event->cpi.sysplex_name)),
>>> +        .timestamp = event->cpi.timestamp
>>> +    };
>>> +
>>> +    visit_type_S390ControlProgramId(v, name, &cpi, errp);
>>> +}
>>> +
>>>  static void cpi_class_init(ObjectClass *klass, void *data)
>>>  {
>>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>> @@ -114,6 +144,14 @@ static void cpi_class_init(ObjectClass *klass, void 
>>> *data)
>>>      k->get_send_mask = send_mask;
>>>      k->get_receive_mask = receive_mask;
>>>      k->write_event_data = write_event_data;
>>> +
>>> +    object_class_property_add(klass, "control-program-id",
>>> +                              "S390ControlProgramId",
>>> +                              get_control_program_id,
>>> +                              NULL, NULL, NULL);
>>> +    object_class_property_set_description(klass, "control-program-id",
>>> +        "Control-program identifiers provide data about the guest "
>>> +        "operating system");
>>>  }
>>>
>>>  static const TypeInfo sclp_cpi_info = {
>>> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event- 
>>> facility.h
>>> index f445d2f9f5..39e589ed44 100644
>>> --- a/include/hw/s390x/event-facility.h
>>> +++ b/include/hw/s390x/event-facility.h
>>> @@ -169,10 +169,19 @@ typedef struct ReadEventData {
>>>      };
>>>  } QEMU_PACKED ReadEventData;
>>>
>>> +typedef struct ControlProgramId {
>>> +    uint8_t system_type[8];
>>> +    uint8_t system_name[8];
>>> +    uint64_t system_level;
>>> +    uint8_t sysplex_name[8];
>>> +    uint64_t timestamp;
>>> +} QEMU_PACKED ControlProgramId;
>>> +
>>>  struct SCLPEvent {
>>>      DeviceState qdev;
>>>      bool event_pending;
>>>      char *name;
>>> +    ControlProgramId cpi;
>>
>> I don't think this should go into SCLPEvent.
>> Rather SCLPEventFacility or SCLPDevice. Otherwise all events,
>> so also quiesce and cpu_hotplug have a cpi field.
>>
> ok, that is correct.
> 
> I gave it a try by moving ControlProgramId to SCLPDevice. With this, the 
> migration data is stored in dc->vmsd of TYPE_SCLP as shown below.
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 5945c9b1d8..4d6d5bb857 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -424,6 +424,29 @@ static void sclp_init(Object *obj)
>       sclp_memory_init(sclp);
>   }
> 
> +static const VMStateDescription vmstate_control_program_id = {
> +    .name = "s390_control_program_id",
> +    .version_id = 0,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(system_type, ControlProgramId, 8),
> +        VMSTATE_UINT8_ARRAY(system_name, ControlProgramId, 8),
> +        VMSTATE_UINT64(system_level, ControlProgramId),
> +        VMSTATE_UINT8_ARRAY(sysplex_name, ControlProgramId, 8),
> +        VMSTATE_UINT64(timestamp, ControlProgramId),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_sclpcpi = {
> +    .name = "s390_sclpcpi",
> +    .version_id = 0,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT(cpi, SCLPDevice, 0, vmstate_control_program_id,
> +                       ControlProgramId),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static void sclp_class_init(ObjectClass *oc, void *data)
>   {
>       SCLPDeviceClass *sc = SCLP_CLASS(oc);
> @@ -438,6 +461,7 @@ static void sclp_class_init(ObjectClass *oc, void *data)
>        * which is a non-pluggable sysbus device
>        */
>       dc->user_creatable = false;
> +    dc->vmsd =  &vmstate_sclpcpi;
> 
>       sc->read_SCP_info = read_SCP_info;
>       sc->read_cpu_info = sclp_read_cpu_info;
> 
> @Thomas Huth: Is this ok?, thank you.

  Hi,

that also does not look like the right place to me ... can't you move the 
migration state to the TYPE_SCLP_CPI device instead?

  Thomas


