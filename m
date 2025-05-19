Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FB1C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 23:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH9qv-0007iX-GX; Mon, 19 May 2025 19:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uH9qt-0007hq-9G
 for qemu-devel@nongnu.org; Mon, 19 May 2025 19:24:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uH9qr-0002uS-71
 for qemu-devel@nongnu.org; Mon, 19 May 2025 19:24:58 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22e033a3a07so51375025ad.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 16:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747697095; x=1748301895;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZaq0aPbjEuS7KoDg8k+HasqE2XJEw/76A9C+uBVdwg=;
 b=PsVYQE7balVezSeMwdQn9ZVYMsRuBTTttC2hvYsMZ+MMPC6OBp5feR566G3SEPclgG
 AZb5JIktccJ8DyU+OyztP+bghdivXGkIfBgMrzdWDJTbzbOeB5ttK+VRvbGkl2n0qG8g
 7Cz2nloWxG0NiEtX5v+fIXppTR6MSlBzJ/wPWUMpCycK7sbN7A4NqElxKUmCiv0l34bn
 YRIBYqDw8WMKof4gmLbxevdljd1i1+zA4icQU3ln8rc+IVmDLPZA05MR5vjcgOHk5Q/p
 McQnfhUws8v8rZcXpnDaFEYPQa6iJs/P7QRNgYotvR/bdGUXodBzEsWuVARlByA+E/0t
 nstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747697095; x=1748301895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZaq0aPbjEuS7KoDg8k+HasqE2XJEw/76A9C+uBVdwg=;
 b=kfp+SO9igtgZBpYBx9zy9jb3HugBQHbqnYUcDjrRQf4QZv8Dd84lFPZ6MDT3dkJbZI
 t7ha5hUBUKUWVXHyXalbDO6WpblSSrL35sFFX9tgSB06lvF0eC6aadd7Ygd/loE67n8m
 D0WsK0fT8AoejOTaoDcw0VxICA2pUagmiTerrDseRb5jcNcAgQGND4oZN6GhEVCyR1M+
 VGTDcwuEeWh9K11AGeH4x4HJ4GKTF84BO5oaeVKydUy3y23+rlk69+JWQg0W86grHWi0
 0WsNHQ6jYEtvIF4lt+k4If4Jmj53ZxHFPS54kE1Yv1o/pYquAD+Q4Zf+US5nawuTWhEV
 /bgw==
X-Gm-Message-State: AOJu0Ywgte7JCCvJnz+9mBpsGqU6f1By6nkapD7LlaYmz5cnqOXfOJ+S
 pWgaPnn4a8u0l/NtxkYnKLEqzwr7A0/zs1PWIy0BRCVuBm3+JYCAtnIW4OTMfExJ6Qw=
X-Gm-Gg: ASbGncvHe/VUq9iaNDl+cpm2SKhLYO6buEHhPTm9HNGyqgFZoj5owwsZVay1MvOHS+f
 mW0sGOlOeDQuJhXLXzilFxxqnuk8/10oLAwrQXk3poFO8g0xWSdycW/kCs3e4TDkoZfD3nXOK8v
 McWJU8cAPM4Thj3NVjanT5St/iLx8azr6r+2F6ECmYk8J3Bba7y0Czqp6MehWGiKSGrtsWxZZgV
 YYbxQWp4Rv061FwhMkJn4hH0rGEkB9h1FBBmLmsAwpjK82sIYu9wKUVaTxJcBuEFf/0zMp4mW9B
 wtXUqEpTO/nXDC9sCZiKsbStA9M/1mnOBSkovnEx16J9BF7olU8fhek90M3ajp8I7IHIQLsiEU+
 9PXsX9sUTxBMGmbuY9TcUHkbE4qDW4A==
X-Google-Smtp-Source: AGHT+IFP8+sIiE59Vx0jHwK+PrTvgGzZQD8Cx5IogWshJ38KRfnIyY98LnBja0OXcuk/PFt9DyBaYA==
X-Received: by 2002:a17:903:1a68:b0:216:393b:23d4 with SMTP id
 d9443c01a7336-231d43d9bd7mr216951515ad.11.1747697095103; 
 Mon, 19 May 2025 16:24:55 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:4952:3c52:120a:27e9?
 ([2400:4050:b783:b00:4952:3c52:120a:27e9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ac9567sm65447585ad.11.2025.05.19.16.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 16:24:54 -0700 (PDT)
Message-ID: <c790b6c8-310a-49c7-868f-cf88e42b9a88@daynix.com>
Date: Tue, 20 May 2025 08:24:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] contrib/plugins: add a scaling factor to the ips
 arg
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, David Hildenbrand <david@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-6-alex.bennee@linaro.org>
 <cabfe49b-38af-4ecc-a338-1fe175dd7226@daynix.com>
 <8734d0slbr.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8734d0slbr.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/19 23:54, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/05/06 21:57, Alex Bennée wrote:
>>> It's easy to get lost in zeros while setting the numbers of
>>> instructions per second. Add a scaling suffix to make things simpler.
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>> v2
>>>     - normalise the suffix before a full strcmp0
>>>     - check endptr actually set
>>>     - fix checkpatch
>>> ---
>>>    contrib/plugins/ips.c | 36 +++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 35 insertions(+), 1 deletion(-)
>>> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
>>> index e5297dbb01..9b166a7d6c 100644
>>> --- a/contrib/plugins/ips.c
>>> +++ b/contrib/plugins/ips.c
>>> @@ -20,6 +20,8 @@
>>>      QEMU_PLUGIN_EXPORT int qemu_plugin_version =
>>> QEMU_PLUGIN_VERSION;
>>>    +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>>> +
>>
>> G_N_ELEMENTS() is already available.
>>
>>>    /* how many times do we update time per sec */
>>>    #define NUM_TIME_UPDATE_PER_SEC 10
>>>    #define NSEC_IN_ONE_SEC (1000 * 1000 * 1000)
>>> @@ -129,6 +131,18 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
>>>        qemu_plugin_scoreboard_free(vcpus);
>>>    }
>>>    +typedef struct {
>>> +    const char *suffix;
>>> +    unsigned long multipler;
>>
>> I prefer to have an explicitly-sized type: uint32_t in this case. It
>> also saves typing several characters as a bonus.
> 
> 4Ghz would be a reasonable size and that would overflow a simple
> uint32_t unless we start casting.

unsigned long can be 32-bit so it should be uint64_t if you want to 
avoid overflow without casting.

Regards,
Akihiko Odaki

