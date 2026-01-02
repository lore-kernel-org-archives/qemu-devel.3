Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65704FA3754
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 16:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbi4O-0006mq-Qf; Fri, 02 Jan 2026 11:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vbi4D-0006gT-WB
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 11:31:59 -0500
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vbi4A-0002ql-4V
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 11:31:57 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.243])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4djTjc23jFz5vqb;
 Fri,  2 Jan 2026 16:31:48 +0000 (UTC)
Received: from kaod.org (37.59.142.111) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 2 Jan
 2026 17:31:47 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S0052d12b98d-8004-4f35-a29e-8d451fc98177,
 B7FD5E44328430CDF13337E5E30BE77826E2EBC7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <dca78653-72eb-43aa-b7a8-031abf0968eb@kaod.org>
Date: Fri, 2 Jan 2026 17:31:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
To: Kane Chen <kane_chen@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-7-kane_chen@aspeedtech.com>
 <465b0714-bd08-40b5-9cf9-5cd206e8548b@kaod.org>
 <SI6PR06MB76312852C6243B1F48202A89F7B0A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <55adfce4-0dbc-492a-b586-4c46df78007a@kaod.org>
 <SI6PR06MB76318E7A596008386B0AE51CF7BFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <ed07c0f2-737d-4d65-917f-d39d02c37063@kaod.org>
 <006fa26f-6b84-4e82-b6e1-7d1353579441@kaod.org>
 <CA+QoejXzjvyLA0Pp0xJjCsrwSyegSBRBs-MaT7yP41Nd2B9BcQ@mail.gmail.com>
 <SI6PR06MB76312518466322BC6BD67DC5F7BCA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <d6fa3762-7ea8-4173-af20-9615cc5f92dc@kaod.org>
 <SI6PR06MB763159AEBF12B77662CE6697F7BDA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <72b2b29e-d5eb-412b-913f-6a0f56b709ae@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <72b2b29e-d5eb-412b-913f-6a0f56b709ae@kaod.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.111]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 196e2e59-a554-4f70-9e1e-c53b0956e50d
X-Ovh-Tracer-Id: 17506617653175684088
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG1/AqXXOoXc2zA70hKAs/C/itKfWPIOv7nIIy/L0MgsKihi9qq+LGmp04W9rP+Le/4Eg1VroMldv7O8QcYGRB/PndPiH0aaF7RXIADJ/YMzGQYJV+F/FyNHiZU2FpWnVMjbVXnAVwKy5FzcX+NIQcxF1gfuvmyrTt1PICy7FMeIM5dYlWXdyORTdMyD7zwOW6zk9tJv97+fFoMZCTJYsJrlv3C07B7piu0nPmoDh+XKhcC8R7djDy1+ig2Xw840ZO/yP7/vjnE5TTISy0k61/ppJq7FdGqS+JFzccrauRVNoSa3CCwNTma7pzGxQtAc/sMsqJSUw5vh8M9MDe938vYgDyraKGf4EK8YTEP/zKwIkXntZS1GzoGJhWWHLyv7bfqzseGxG0oZKQPuKRHyK54tb/scgacM7SovCmQTYLiDqC5jH3KSMgyMCj6jLeD8PO/3N1QnX2eUXIbnovRRiEhMTy7N6Yh+F0lyiU5RyVisv1hjb3zCzQ+WuOqFHHeJ3LcFUBIFnGj+DsQWS1CiqR+5PY1FLCQdT+rx2D6O72EOVeDF7OAdgYGuKAax61j9UX0cgeyK26nexXe3QMaE6wt6L10gGEwwG+T4uuDQoM8SjcZYVxzpd99Elw0RDyLTn4fLQg9PssbpIMnqV8nVrtcZ1mdBHDm5OTjSKvl9/zNoQ
DKIM-Signature: a=rsa-sha256; bh=zlGMQXvX9/7q+C1Jj5UtQWWPvBIdtC8HcgdOMdYr1JM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767371509; v=1;
 b=m1sxfipzt6mtYUzWvyJinvIroEAKswe8wvrnEmSak1d4q8smArAWx6JczABU9nJeeknlSHCb
 LJ7uGjmnL2nG4t+lABOA21vTbe8PdBY45dNNtR0NLaqPIQSJyVMvUHTbgsVAGVRhdoMVrUEPmxa
 PpKza3Vo/BUJH1RwNdwIn/PE1yhGsMenChBtW/PdJoixK/mJIdvwByEeR9JmGgiooj+hc3GZvLa
 oFr5CF61kLMFeeSHBVREXSiRo6eFsdNFV1H+AnY4O1PB2huUZwQDy3/nMxmfkzN5ewY2VyP6o9o
 i6oNeUBO7G1T8x7yWsMMdHoDV360OMQgDYWpee1fLXZ8A==
Received-SPF: pass client-ip=188.165.45.220; envelope-from=clg@kaod.org;
 helo=5.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/31/25 12:49, Cédric Le Goater wrote:
> Hello Kane,
> 
> On 12/31/25 11:15, Kane Chen wrote:
>>> -----Original Message-----
>>> From: Cédric Le Goater <clg@kaod.org>
>>> Sent: Tuesday, December 30, 2025 10:29 PM
>>> To: Kane Chen <kane_chen@aspeedtech.com>; Nabih Estefan
>>> <nabihestefan@google.com>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>; Steven Lee
>>> <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>; Jamin Lin
>>> <jamin_lin@aspeedtech.com>; Andrew Jeffery
>>> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; open
>>> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
>>> <qemu-devel@nongnu.org>; Troy Lee <troy_lee@aspeedtech.com>; Philippe
>>> Mathieu-Daudé <philmd@linaro.org>
>>> Subject: Re: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
>>> for AST1700
>>>
>>> Hello Kane,
>>>
>>>> Currently, three devices in our setup support I2C.
>>>> 1. BMC
>>>> 2. IO expander 1
>>>> 3. IO expander 2
>>>>
>>>> Each device supports 16 I2C buses, and the bus indices for each device
>>>> all start from 0. This leads to naming conflicts under the current
>>>> naming convention. While we could extend the bus IDs from 16 to 47,
>>>> doing so would require significant code changes to handle different ID ranges,
>>> making the code harder to maintain.
>>>>
>>>> Therefore, I believe using readable bus labels would be more intuitive for the
>>> user API.
>>>
>>> I tend to agree.
>>>
>>>> If there are any existing conventions for this use case or if you have
>>>> any concerns regarding the use of bus labels, please let me know.
>>>
>>> Could you please send us the contents of directory :
>>>
>>>     /sys/bus/i2c/devices/
>>>
>>> on a system with such IO expanders? preferably with some devices attached
>>> to the I2C buses.
>>>
>>> Thanks,
>>>
>>> C.
>>
>> Hi Cédric,
>>
>> I'm afraid I cannot provide data from a physical platform on such short notice.
>> Currently, my AST1700 board is malfunctioning, and our other unit is occupied
>> with different tests. I am reaching out to colleagues to see if a spare is available.
>>
>> I've attached logs from a QEMU simulation, as the results are expected to be
>> consistent with the actual hardware.. Since our EVB does not have I2C devices
>> connected to these specific buses, I typically use the following command to
>> create a dummy device for testing:
>> echo slave-24c02 0x106c > /sys/bus/i2c/devices/i2c-16/new_device"
> 
> Which command line did you use for the I2C backing device in QEMU ?
> 
> Is there a specific FW image to use to enable the IO expanders ?
> 
>> System info:
>> ls -l /sys/bus/i2c/devices/
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 10-1010 -> ../../../devices/platform/soc@14000000/soc@14000000:bus@14c0f000/14c0fb00.i2c-bus/i2c-10/10-1010
>> lrwxrwxrwx    1 root     root             0 Dec 31 09:43 16-106c -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f100.i2c-bus/i2c-16/16-106c
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 8-1010 -> ../../../devices/platform/soc@14000000/soc@14000000:bus@14c0f000/14c0f900.i2c-bus/i2c-8/8-1010
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 9-0050 -> ../../../devices/platform/soc@14000000/soc@14000000:bus@14c0f000/14c0fa00.i2c-bus/i2c-9/9-0050
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-10 -> ../../../devices/platform/soc@14000000/soc@14000000:bus@14c0f000/14c0fb00.i2c-bus/i2c-10
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-16 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f100.i2c-bus/i2c-16
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-17 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f200.i2c-bus/i2c-17
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-18 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f300.i2c-bus/i2c-18
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-19 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f400.i2c-bus/i2c-19
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-20 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f500.i2c-bus/i2c-20
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-21 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f600.i2c-bus/i2c-21
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-22 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f700.i2c-bus/i2c-22
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-23 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f800.i2c-bus/i2c-23
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-24 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0f900.i2c-bus/i2c-24
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-25 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0fa00.i2c-bus/i2c-25
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-26 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0fb00.i2c-bus/i2c-26
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-27 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0fc00.i2c-bus/i2c-27
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-28 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0fd00.i2c-bus/i2c-28
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-29 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0fe00.i2c-bus/i2c-29
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-30 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c0ff00.i2c-bus/i2c-30
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-31 -> ../../../devices/platform/ltpi0_bus@30000000/ltpi0_bus@30000000:bus@30c0f000/30c10000.i2c-bus/i2c-31
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-32 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f100.i2c-bus/i2c-32
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-33 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f200.i2c-bus/i2c-33
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-34 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f300.i2c-bus/i2c-34
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-35 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f400.i2c-bus/i2c-35
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-36 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f500.i2c-bus/i2c-36
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-37 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f600.i2c-bus/i2c-37
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-38 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f700.i2c-bus/i2c-38
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-39 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f800.i2c-bus/i2c-39
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-40 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0f900.i2c-bus/i2c-40
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-41 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0fa00.i2c-bus/i2c-41
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-42 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0fb00.i2c-bus/i2c-42
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-43 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0fc00.i2c-bus/i2c-43
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-44 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0fd00.i2c-bus/i2c-44
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-45 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0fe00.i2c-bus/i2c-45
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-46 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c0ff00.i2c-bus/i2c-46
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-47 -> ../../../devices/platform/ltpi1_bus@50000000/ltpi1_bus@50000000:bus@50c0f000/50c10000.i2c-bus/i2c-47
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-8 -> ../../../devices/platform/soc@14000000/soc@14000000:bus@14c0f000/14c0f900.i2c-bus/i2c-8
>> lrwxrwxrwx    1 root     root             0 Apr  3  2025 i2c-9 -> ../../../devices/platform/soc@14000000/soc@14000000:bus@14c0f000/14c0fa00.i2c-bus/i2c-9
> 
> Could we order the I2C buses the same way in QEMU ?

We would need to modify the bus creation in aspeed_i2c_bus_realize()
as follows :
  
      s->bus = i2c_init_bus(dev, NULL);

and fix all tests.

Hmm, I am pondering the possible solutions.

C.

