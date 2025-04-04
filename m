Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAA4C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 13:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gz1-0006TJ-E6; Fri, 04 Apr 2025 09:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0gz0-0006Ss-1j
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:21:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0gyx-00065f-Bz
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:21:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so18154835e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743772872; x=1744377672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n+yY4zHMpzonncGp0PG2YOqpZf6vw5c75RcGQuFG3hg=;
 b=dj+4XSAz70dKVGJRlA6foI+TUjFMiZcHTnYT/5BVONE9RqJ1DEcJyeE5+QZ7vPYDzZ
 P94NT7uGXgJ4LgznSdfPqR7xgVv+QZJ7VrbQoJabY+qDLxzgvDyk3sTTJEUM82ta66hE
 1UF1sFG6Si3O04zB142N2G8kJ3liRyjvI9KIydZHYEGZ+/DS4o3ZJenkuoWctxgcCwI3
 0DjbpNwEBrPvej5GkpCWK7GQdGQpliZ3pxhnJV1zxr14P1ZScZZSF95Nj1qpL2uTULHe
 tA0tdLLz6hey/gHPSEMCGq+E4aVzMStMVB5xSIQ1TGLsIGs6edT/j2weGtyzWTGdcU4K
 AwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743772872; x=1744377672;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n+yY4zHMpzonncGp0PG2YOqpZf6vw5c75RcGQuFG3hg=;
 b=ba0yMZ7BNUy5KclVJJiWyWOlFOCD9WHolHaDXjrtm1HJI7daXDbUlufDR6Rg7DmksS
 Yse/KrucQxQtL0UFfKIq1dpDXtwF538j4lzp2SfYZRl76I4Cro+mOHaN8my/folUDP/Q
 MUKcpZrdBFriewf2f5BfRa6Vz3XsHt/BmwQht61ACSuHaIEzx9N8j/um4Wio3PvHjkt5
 C58z69DWDKQ/7qO4tuHXhUnpc1e3asYsa28LNSKTsKEs0CJwY4Cpn99zSM5U9GviBCVh
 Yg7rdtcSqtlMf93/tN+vmozBUXmPK5ScQwh1dEi0H8rhbL/NPi//Fh7dZkF6oM/hiiL9
 IQcA==
X-Gm-Message-State: AOJu0Ywzeo79/gY3rcZn+hJiPuVpvZmnLhbUn70QI9urNyLPxGer9sa0
 YumRYmORNg8ooviiWuRSC9nfxNpWySTj/DC0PsduPxn3i4hEs/QF7Z5YQgLZclY=
X-Gm-Gg: ASbGncs+nVgfR1lvDZP6GDn/NyInpQFktnvuEBzKf7FAhTcY3RLFS+8OXqaJmaUnrFI
 5TYY06fvuC0HK751lZphBqxRqTlFC25Sc0CcMJQ9IzEmzgES8u15hvnIkbxMChfoy8JKDdaHkaU
 OP8Q/gHNDcMbwav133QI+Qf6pwzxXrntw/QqfSBT0+z1BO4I4tuAqn9m1mvwCV5/7Pqm4hXzGq0
 9PKs7XWdXtYVaAfx93+h259G9mYzkmrCatoKpy0aF+xEFuAFK+xzc/qddpXP2gGXK+RNweT7NzK
 pZzUzoqnsM4iOBN9VbrGXmYxl0ADOFq0zybTEh7piaHq0tKwTYYn+3vVo3UPgxWZCKZDiOf/sSR
 8fk5R1R421oVQtO4bHQ==
X-Google-Smtp-Source: AGHT+IEOrjPJAEW/PIVPR4c039TWO+D04Onh6lM3gMg4YjxWeqjujxk6UuYgWX4FycblqoRYtaAStg==
X-Received: by 2002:a7b:cc83:0:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-43ed6615607mr16418945e9.18.1743772872362; 
 Fri, 04 Apr 2025 06:21:12 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b1352sm48581965e9.37.2025.04.04.06.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 06:21:11 -0700 (PDT)
Message-ID: <e4181e5f-5393-4345-9dab-8bf1a6dcdd91@linaro.org>
Date: Fri, 4 Apr 2025 15:21:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ipmi: Allow multiple BMC instances
To: corey@minyard.net
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
References: <Z-8ujYWA8yBATtYK@mail.minyard.net>
 <438cb87a-cfa2-4392-92f4-bbb05f7a2ec2@linaro.org>
 <Z-_Y3VJ49yYyZmE4@mail.minyard.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z-_Y3VJ49yYyZmE4@mail.minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 4/4/25 15:04, Corey Minyard wrote:
> On Fri, Apr 04, 2025 at 02:41:46PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Corey,
>>
>> On 4/4/25 02:57, Corey Minyard wrote:
>>> Allow a system to have multiple BMC connections to the same BMC and
>>> multiple different BMCs.  This can happen on real systems, and is
>>> useful for testing the IPMI driver on Linux.
>>>
>>> Signed-off-by: Corey Minyard <corey@minyard.net>
>>> ---
>>> I'm working on a fairly extensive test suite for IPMI, the Linux
>>> driver and qemu, and this is necessary for some driver tests.
>>>
>>>    hw/ipmi/ipmi.c            | 1 +
>>>    hw/ipmi/ipmi_bmc_extern.c | 5 +++--
>>>    hw/ipmi/ipmi_bmc_sim.c    | 2 +-
>>>    include/hw/ipmi/ipmi.h    | 1 +
>>>    qemu-options.hx           | 9 ++++++++-
>>>    5 files changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
>>> index fdeaa5269f..ffd972f78b 100644
>>> --- a/hw/ipmi/ipmi.c
>>> +++ b/hw/ipmi/ipmi.c
>>> @@ -110,6 +110,7 @@ void ipmi_bmc_find_and_link(Object *obj, Object **bmc)
>>>    static const Property ipmi_bmc_properties[] = {
>>>        DEFINE_PROP_UINT8("slave_addr",  IPMIBmc, slave_addr, 0x20),
>>> +    DEFINE_PROP_UINT8("instance",    IPMIBmc, instance, 0),
>>
>> Can we use "id" instead of "instance"? The latter confuses me, but
>> maybe a matter of taste.
> 
> "id" means "identifier", not "instance".  The error log mentions
> "instance", that that is what is passed to vmstate_register().

Note, vmstate_register() is a legacy API, with only 20 cases left to
update. See commit 6caf1571a97 ("include/migration: mark
vmstate_register() as a legacy function"):

     /**
      * vmstate_register() - legacy function to register state
      * serialisation description
      *
      * New code shouldn't be using this function as QOM-ified devices
      * have dc->vmsd to store the serialisation description.
      *
      * Returns: 0 on success, -1 on failure
      */

> Maybe it's better to just have a global variable that increments and not
> pass it in?  That way it would work automatically.

Global variables often hide suble problems. We have a list of some used
in qdev / qbus / pci that we plan to remove, because it makes command
line not reproducible.

See this thread:
https://lore.kernel.org/qemu-devel/87czq0l2mn.fsf@dusky.pond.sub.org/

> 
> -corey
> 
>>
>> Preferably s/instance/id/:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>>>    };
>>>    static void bmc_class_init(ObjectClass *oc, void *data)
>>> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
>>> index d015500254..11c28d03ab 100644
>>> --- a/hw/ipmi/ipmi_bmc_extern.c
>>> +++ b/hw/ipmi/ipmi_bmc_extern.c
>>> @@ -488,7 +488,8 @@ static const VMStateDescription vmstate_ipmi_bmc_extern = {
>>>    static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
>>>    {
>>> -    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(dev);
>>> +    IPMIBmc *b = IPMI_BMC(dev);
>>> +    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(b);
>>>        if (!qemu_chr_fe_backend_connected(&ibe->chr)) {
>>>            error_setg(errp, "IPMI external bmc requires chardev attribute");
>>> @@ -498,7 +499,7 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
>>>        qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
>>>                                 chr_event, NULL, ibe, NULL, true);
>>> -    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
>>> +    vmstate_register(NULL, b->instance, &vmstate_ipmi_bmc_extern, ibe);
>>>    }
>>>    static void ipmi_bmc_extern_init(Object *obj)
>>> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
>>> index 6157ac7120..c1b39dbdc5 100644
>>> --- a/hw/ipmi/ipmi_bmc_sim.c
>>> +++ b/hw/ipmi/ipmi_bmc_sim.c
>>> @@ -2188,7 +2188,7 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
>>>        ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
>>> -    vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
>>> +    vmstate_register(NULL, b->instance, &vmstate_ipmi_sim, ibs);
>>>    }
>>>    static const Property ipmi_sim_properties[] = {
>>> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
>>> index 77a7213ed9..4436d70842 100644
>>> --- a/include/hw/ipmi/ipmi.h
>>> +++ b/include/hw/ipmi/ipmi.h
>>> @@ -183,6 +183,7 @@ struct IPMIBmc {
>>>        DeviceState parent;
>>>        uint8_t slave_addr;
>>> +    uint8_t instance;
>>>        IPMIInterface *intf;
>>>    };
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index dc694a99a3..186433ac13 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -1120,6 +1120,10 @@ SRST
>>>        ``slave_addr=val``
>>>            Define slave address to use for the BMC. The default is 0x20.
>>> +    ``instance=val``
>>> +        For more than one BMC on the same system, each instance needs
>>> +	a unique number.  The default is 0.
>>> +
>>>        ``sdrfile=file``
>>>            file containing raw Sensor Data Records (SDR) data. The default
>>>            is none.
>>> @@ -1137,7 +1141,7 @@ SRST
>>>            is set, get "Get GUID" command to the BMC will return it.
>>>            Otherwise "Get GUID" will return an error.
>>> -``-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val]``
>>> +``-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val][,instance=id]``
>>>        Add a connection to an external IPMI BMC simulator. Instead of
>>>        locally emulating the BMC like the above item, instead connect to an
>>>        external entity that provides the IPMI services.
>>> @@ -1151,6 +1155,9 @@ SRST
>>>        simulator running on a secure port on localhost, so neither the
>>>        simulator nor QEMU is exposed to any outside network.
>>> +    You can have more than one external BMC connection with this, but
>>> +    you must set a unique instance for each BMC.
>>> +
>>>        See the "lanserv/README.vm" file in the OpenIPMI library for more
>>>        details on the external interface.
>>


