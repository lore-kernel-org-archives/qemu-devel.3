Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98B2D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQALg-00051n-8Y; Mon, 01 Dec 2025 15:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQALe-00050K-H1
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:18:14 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQALc-0000yh-Td
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:18:14 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42e2e628f8aso758069f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764620291; x=1765225091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Es+vQYHiWrgYn41Qr59RFNsJHpmUPdyF9TpZvAsL8N8=;
 b=ATIgeg6jDDBs8WQ0y/YJttB3nRlNLQI7pTJmcTLBJoTg+8y4nwjb8jOPOwHhRDv9HZ
 B0TsO0MeG8AqaV++J5+M2d+/PNASOCAW3STlaYqmHXn3EgDCrPvC5IsfyW9Q2VlQcg5y
 l8V9Eao1FTw8dUStjNUMu3LjfOKV3xTEjQU/W7b7J8x9iontObJxhSDFhtqrtmScIRXl
 AK1+2aPgrTyuptfIDF5jAdphYQ8TvvrNx1ympYi36P1qNDrquto3SQxL69gBa0VhstL7
 PXQPlVtZNWbSBY2+NBheyicZUts1bT4esWaos15xzNhurtR8KxH0JtDnwg+8FZsMimep
 tTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764620291; x=1765225091;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Es+vQYHiWrgYn41Qr59RFNsJHpmUPdyF9TpZvAsL8N8=;
 b=a1wIhlk1MT7mArsW6xPEPBRv6yUy50vofCZGQpytSdlCuyeghBAQ7HwmCzgB4igKV0
 WqAheFpKJ7dv/Q46aLKmtDhmXIug9LtnjMZHDJsr/oT9iajbRAicLKyRDBBxz9CV/fIg
 +ytNJgF/nANN9/R0qOqv4o2mKfE2JYCOC4Ta7lsZTkh76zPjaRcrY7JZqHW3kT3HqNSl
 sVOrDNL9BwzimgiocQcVgnOgOuo/zp7v42C4Ei8gPqtT0PmyobO1XOeK6hkueuIu1IQ2
 RRCmoBY/jBplVhkf+sT3bMc9bh1dhkZ1HEP3VlEVvqPUpkHehAPrhcsvHDg7v1kC7EX6
 bXUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWOKknfYL/XwxerbwvTFcObiQTqzNIhLRTSPmK/1bXJmdC8B2Pyi8KgV8hpXM1WrP2nBtdVVXOuJhn@nongnu.org
X-Gm-Message-State: AOJu0YzfZtXhmHhrzCQ6nA2dIHnrnyWLpKidZuKZezs1RaJfSNmwahbc
 NGLXAS3KJ25jZ9p7/My/Sg2+ZEIKkbTSgYjA8DnqBsqkuW3g/jrJhmKutQmSR5ypmMc=
X-Gm-Gg: ASbGncuscnFidrrOnRIgn1lv72fKtfIuScIA05n+sZ0D5UHAhysYyFqIggtbUzAzLVQ
 9BOp5FF+VVbIjm2YBObl7TAjTplxox8zXsCYhSA9D251NJD4TTBtX1W2cc5PAYMjAfoZymhviCZ
 /3m40f2j9buprUocV97YKAdCX60gyd6uNMKtY9QInbyNjv5QGQOKEPgV+hpOiukYzx/XCCLGLB9
 JLB+hcAM+O7qwoNvTzJiBuGXtn87lS4QiR7dO1WqgHk63xA9skr+mFqb/e27UXCC9G1HqjoR6AS
 EzlxqsHO9nywoznozLogGsAuHhY6Z5gTSifgNzH90gg1Xh6rpl64IM6Km8UVvzMtFTGlNQMxTXz
 MYFdyVZpHZjkcGvZeXG6xIU9oQ2wyrLJ8Bd6c/degaeezmax79HEb2voAal1qYlrsElBLYpjL4Y
 wtspICY3Auzj7d/Yd+a/q7TqFzfbHEFURawfnSVoVjUGVpE+BvuuSKMQ==
X-Google-Smtp-Source: AGHT+IH+Rrtzk8Zn5/pfWzZKUIvMtJMfgP+ZmlhDa/kDPeckQ4jDOWEf3AC68US0iq3/Cbuh9uupvw==
X-Received: by 2002:a05:6000:2309:b0:429:d350:8012 with SMTP id
 ffacd0b85a97d-42e0f1e34a4mr27822689f8f.8.1764620290801; 
 Mon, 01 Dec 2025 12:18:10 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a2easm28985189f8f.23.2025.12.01.12.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 12:18:10 -0800 (PST)
Message-ID: <a5803130-031a-441d-b15e-c8ea31ff82e3@linaro.org>
Date: Mon, 1 Dec 2025 21:18:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/ipmi/ipmi_bmc_sim: Support getting fake LAN
 channel config
Content-Language: en-US
To: Yunpeng Yang <yunpeng.yang@nutanix.com>, "minyard@acm.org"
 <minyard@acm.org>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 "corey@minyard.net" <corey@minyard.net>, Jonathan Davies <jond@nutanix.com>,
 "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>
References: <20251028180115.1098433-1-yunpeng.yang@nutanix.com>
 <20251028180115.1098433-2-yunpeng.yang@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251028180115.1098433-2-yunpeng.yang@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Yunpeng,

On 28/10/25 19:01, Yunpeng Yang wrote:
> The following IPMI commands are added or modified to support getting
> fake LAN channel configurations from the `ipmi_bmc_sim` device:
> * Get Channel Access;
> * Get Channel Info Command;
> * Get LAN Configuration Parameters.
> 
> The fake LAN channel configurations can be specified from QEMU
> commandline options for device `ipmi_bmc_sim`. Inside the guest OS, the
> configurations can be retrieved from the device using some IPMI tools,
> e.g., `ipmitool lan print`.
> Note, there is not a real LAN channel. The fake LAN channel is suitable
> for testing purposes.
> 
> Signed-off-by: Yunpeng Yang <yunpeng.yang@nutanix.com>
> ---
>   hw/ipmi/ipmi_bmc_sim.c      | 297 ++++++++++++++++++++++++++++++++++--
>   include/hw/ipmi/ipmi.h      |   1 +
>   qemu-options.hx             |  26 ++++
>   tests/qtest/ipmi-kcs-test.c |  60 ++++++++
>   4 files changed, 374 insertions(+), 10 deletions(-)


>   /* Same as a timespec struct. */
>   struct ipmi_time {
> @@ -170,6 +177,23 @@ typedef struct IPMISensor {
>   #define MAX_SENSORS 20
>   #define IPMI_WATCHDOG_SENSOR 0
>   
> +#define NBYTES_IP  4
> +#define NBYTES_MAC 6
> +
> +typedef struct IPMILan {
> +    uint8_t channel;
> +    uint8_t ipaddr[NBYTES_IP];
> +    uint8_t ipsrc;
> +    MACAddr macaddr;
> +    uint8_t netmask[NBYTES_IP];
> +    uint8_t defgw_ipaddr[NBYTES_IP];
> +    MACAddr defgw_macaddr;
> +
> +    char *arg_ipaddr;
> +    char *arg_netmask;
> +    char *arg_defgw_ipaddr;
> +} IPMILan;
> +
>   #define MAX_NETFNS 64
>   
>   typedef struct IPMIRcvBufEntry {
> @@ -215,6 +239,7 @@ struct IPMIBmcSim {
>       IPMIFru fru;
>       IPMISensor sensors[MAX_SENSORS];
>       char *sdr_filename;
> +    IPMILan lan;
>   

[...]

> +static inline bool is_valid_netmask(const uint8_t *netmask)
> +{
> +    uint32_t mask = netmask[3];
> +    uint32_t inverted;
> +
> +    mask |= (uint32_t) netmask[2] << 8;
> +    mask |= (uint32_t) netmask[1] << 16;
> +    mask |= (uint32_t) netmask[0] << 24;

Why manually byteswap?

I'd expect such helper already available in include/net/ somewhere,
otherwise what about:

   static bool is_ipv4_netmask_valid(const void *buf)
   {
       uint32_t netmask = ldl_be_p(buf);

       return clo32(netmask) + ctz32(netmask) == 32;
   }

> +    inverted = ~mask;
> +    return mask != 0 && (inverted & (inverted + 1)) == 0;
> +}


> @@ -2176,7 +2395,7 @@ static void ipmi_sdr_init(IPMIBmcSim *ibs)
>   
>   static const VMStateDescription vmstate_ipmi_sim = {
>       .name = TYPE_IPMI_BMC_SIMULATOR,
> -    .version_id = 1,
> +    .version_id = 2,
>       .minimum_version_id = 1,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT8(bmc_global_enables, IPMIBmcSim),
> @@ -2198,6 +2417,13 @@ static const VMStateDescription vmstate_ipmi_sim = {
>           VMSTATE_UINT16(sensors[IPMI_WATCHDOG_SENSOR].deassert_states,
>                          IPMIBmcSim),
>           VMSTATE_UINT16(sensors[IPMI_WATCHDOG_SENSOR].assert_enable, IPMIBmcSim),
> +        VMSTATE_UINT8_V(lan.channel, IPMIBmcSim, 2),
> +        VMSTATE_UINT8_ARRAY_V(lan.ipaddr, IPMIBmcSim, NBYTES_IP, 2),
> +        VMSTATE_UINT8_V(lan.ipsrc, IPMIBmcSim, 2),
> +        VMSTATE_UINT8_ARRAY_V(lan.macaddr.a, IPMIBmcSim, NBYTES_MAC, 2),
> +        VMSTATE_UINT8_ARRAY_V(lan.netmask, IPMIBmcSim, NBYTES_IP, 2),
> +        VMSTATE_UINT8_ARRAY_V(lan.defgw_ipaddr, IPMIBmcSim, NBYTES_IP, 2),
> +        VMSTATE_UINT8_ARRAY_V(lan.defgw_macaddr.a, IPMIBmcSim, NBYTES_MAC, 2),

Safer would be to add a VMStateDescription for the new IPMILan
structure and link it as subsections, so other code using could just
link as subsection, not duplicating the VMSTATE_FOO() macros.

>           VMSTATE_END_OF_LIST()
>       }
>   };

Regards,

Phil.

