Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E3AC636BA
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 21:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuHSW-00027t-Ew; Sun, 22 Feb 2026 16:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuHST-00027D-2P
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 16:57:45 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuHSR-0007O7-Dx
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 16:57:44 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4837907f535so32913295e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 13:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771797461; x=1772402261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9t3bdn96J9shGSR6jtPt8Uq3S8CknrUZoF0dq2ePH8w=;
 b=eOgmeF9/spfjTbKhJWmnlfYOt/DpMwhJqg5WwidrXXN+a+UnR/3Ukv7m5uo4SupncG
 KGRqI2NPdMRNiX3dsfoWtuYsuTWclmwo/fyTFfM0l3il1tqOOUQ6rVAFvE0Zjb1UAhwU
 gDTIIYPxELTwG/vfuIi/CEjPdO0L6JfAbGgic91esK9aFb2OMyhgPEEP878Gwn+wImPH
 liRKedzAAqYiwLmA932tfT3DjWjlxaf2ihjJVfOFHfPEMuq8nn4MyeYotPjCh4A5PDML
 I9c5q2SkCcIa6f+py3LWSye5Yij2IMlK+nMZTzIxPFdWk0+/sc94/fscClagarlaU5Rw
 lIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771797461; x=1772402261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9t3bdn96J9shGSR6jtPt8Uq3S8CknrUZoF0dq2ePH8w=;
 b=qn/bEQ/ScC1NHkKW+E2gybYsOo7wYAufOCxE6a6D7X+1O5Gy1y+C7o5Dk2dMANFG0D
 wGGDxTfHoDXczEPf9gRHYk6wBa6UULJnJj9u4WVnVSS7tCHwsfrt6k0jrUcepWoIm6At
 2jRcSjrc9JLiqa0eSISsp1kNmyrQLhs+Kxt3kNfoz/bJZ1fkoHB6S4chDT8uIUlOCzn+
 L7rjdpXK6PfVyyJCjADDVN78KxtK5FfR21u/q0q/t5WDNfN77O+2zwsv7R8qKhELKHh2
 tElLcAJaGuZKD1GfHVbog8/euug5Lfi2TNjiO7WoBtxz/U5WHPBzolNOv98L/DYWrYrp
 T8Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0JremQxXmjG1wI1SkELDV4p1W+uCQV7wYHVW9+Topx48Ma6nGlgYart8DzjsgiQu4n1bc3aBuya5Y@nongnu.org
X-Gm-Message-State: AOJu0YxwxEYa4Nh3lnJVQgyj7GWAl6LyDRzwwdczHECN9tCV0sxIMkTF
 HCFJ8Kt7beh/TbL17/EtHiPiwNUww87yIb4M5FPkwZjv/6o7GZYsHyn19jNZ5dlmi+M=
X-Gm-Gg: AZuq6aLZtwniEy2+ekAtFCbp8Zsx0nNv0Lv7Z/am2vJhgVBTTEZNaoH9HiheyRQ6lpJ
 dPCJZlFwfma+jo6Lz1Y13sEb7Od4968JiDkEzaH/upSfdPe9vQnzVlT1A3iPoRpeRuf+p2ga/rw
 WK37uvaEvdmQyP8ejy7h0DbPWtppPwEVQftCzC6SElS0q+JEbxSxtD7XhxCFxlzUtQJP4GtwUt5
 0IhN643DDp7+4cUeezbrSwQ2jXhZNBLuMwqE0d8GVlOc4KyQLt0X5Fb0ssOATAiYwNFr2TDAW9Y
 5lzQMf4/YBLvQs742N2QY5fzRN61mEyGnaLZctXZBDn/sywfz7Vg6ID764Qc6Ke4/ba9uN1aLbW
 p2xnPYCga3niQc1VAlDDybRHPkVsfAiAh8oYIhERkzed3iNdtRkex+KUSu67/xMbrkaLehZrmJ9
 iq2SPmU2Umte9gMrgRWZpgAnOPkPQ+P+r5i5USdpitGoAC/JmIoTXtP0x45RBSGTJF0Q==
X-Received: by 2002:a05:600c:c8a:b0:483:96d8:9f75 with SMTP id
 5b1f17b1804b1-483a9603b00mr100954865e9.28.1771797461358; 
 Sun, 22 Feb 2026 13:57:41 -0800 (PST)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b75e63sm250571955e9.6.2026.02.22.13.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Feb 2026 13:57:40 -0800 (PST)
Message-ID: <35356f16-3a1f-4ba3-8d10-bece637d9c4e@linaro.org>
Date: Sun, 22 Feb 2026 22:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtl8139: Remove ineffective parameter
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260127173849.588F25969F0@zero.eik.bme.hu>
 <597883bc-c6a3-cd7f-42dc-1ee7fb8e213c@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <597883bc-c6a3-cd7f-42dc-1ee7fb8e213c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 12/2/26 19:45, BALATON Zoltan wrote:
> On Tue, 27 Jan 2026, BALATON Zoltan wrote:
>> The do_interrupt parameter for rtl8139_do_receive was originally added
>> in commit 6cadb320c7 to avoid generating interrupt when receiving in
>> loopback mode. Later commit 5311fb805a changed this so that this
>> parameter became ineffective and now this parameter is unused and
>> always 1. If this turns out to be a problem maybe there's a better way
>> to fix this so remove the do_interrupt parameter for now to simplify
>> code.
> 
> Ping?

Jason usually only does 1 pull request per dev cycle, close to soft
freeze.

Jason, since this patch is trivial enough, I'll take it via my
hw-misc tree for convenience. Please object if you disagree :)

Regards,

Phil.

> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> hw/net/rtl8139.c | 24 ++++++++----------------
>> 1 file changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
>> index 9fd00574d2..2ad6338ebe 100644
>> --- a/hw/net/rtl8139.c
>> +++ b/hw/net/rtl8139.c
>> @@ -815,7 +815,8 @@ static bool rtl8139_can_receive(NetClientState *nc)
>>     return avail == 0 || avail >= 1514 || (s->IntrMask & RxOverflow);
>> }
>>
>> -static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t 
>> *buf, size_t size_, int do_interrupt)
>> +static ssize_t rtl8139_receive(NetClientState *nc,
>> +                               const uint8_t *buf, size_t size_)
>> {
>>     RTL8139State *s = qemu_get_nic_opaque(nc);
>>     PCIDevice *d = PCI_DEVICE(s);
>> @@ -1173,20 +1174,11 @@ static ssize_t 
>> rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
>>     }
>>
>>     s->IntrStatus |= RxOK;
>> -
>> -    if (do_interrupt)
>> -    {
>> -        rtl8139_update_irq(s);
>> -    }
>> +    rtl8139_update_irq(s);
>>
>>     return size_;
>> }
>>
>> -static ssize_t rtl8139_receive(NetClientState *nc, const uint8_t 
>> *buf, size_t size)
>> -{
>> -    return rtl8139_do_receive(nc, buf, size, 1);
>> -}
>> -
>> static void rtl8139_reset_rxring(RTL8139State *s, uint32_t bufferSize)
>> {
>>     s->RxBufferSize = bufferSize;
>> @@ -1745,7 +1737,7 @@ static uint32_t 
>> rtl8139_RxConfig_read(RTL8139State *s)
>> }
>>
>> static void rtl8139_transfer_frame(RTL8139State *s, uint8_t *buf, int 
>> size,
>> -    int do_interrupt, const uint8_t *dot1q_buf)
>> +                                   const uint8_t *dot1q_buf)
>> {
>>     struct iovec *iov = NULL;
>>     struct iovec vlan_iov[3];
>> @@ -1828,7 +1820,7 @@ static int rtl8139_transmit_one(RTL8139State *s, 
>> int descriptor)
>>     s->TxStatus[descriptor] |= TxHostOwns;
>>     s->TxStatus[descriptor] |= TxStatOK;
>>
>> -    rtl8139_transfer_frame(s, txbuffer, txsize, 0, NULL);
>> +    rtl8139_transfer_frame(s, txbuffer, txsize, NULL);
>>
>>     DPRINTF("+++ transmitted %d bytes from descriptor %d\n", txsize,
>>         descriptor);
>> @@ -2246,7 +2238,7 @@ static int 
>> rtl8139_cplus_transmit_one(RTL8139State *s)
>>                     DPRINTF("+++ C+ mode TSO transferring packet size "
>>                         "%d\n", tso_send_size);
>>                     rtl8139_transfer_frame(s, saved_buffer, 
>> tso_send_size,
>> -                        0, (uint8_t *) dot1q_buffer);
>> +                                           (uint8_t *)dot1q_buffer);
>>
>>                     /* add transferred count to TCP sequence number */
>>                     stl_be_p(&p_tcp_hdr->th_seq,
>> @@ -2323,8 +2315,8 @@ skip_offload:
>>
>>         DPRINTF("+++ C+ mode transmitting %d bytes packet\n", 
>> saved_size);
>>
>> -        rtl8139_transfer_frame(s, saved_buffer, saved_size, 1,
>> -            (uint8_t *) dot1q_buffer);
>> +        rtl8139_transfer_frame(s, saved_buffer, saved_size,
>> +                               (uint8_t *)dot1q_buffer);
>>
>>         /* restore card space if there was no recursion and reset 
>> offset */
>>         if (!s->cplus_txbuffer)
>>


