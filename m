Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CBCC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpZO-0005iv-8r; Mon, 05 May 2025 02:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBpZM-0005id-K5
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:44:52 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBpZK-0007UV-L0
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:44:52 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso3904101b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 23:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746427489; x=1747032289;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YIUxxhjNyQXaa6xVMsBBJ0f9g7v1IfCCUpbgqE5S6ZI=;
 b=nx2bo6C2qSGHLZFWSqFC7HliMfThX4Papw4tK4hzzDpdfy75j2qvSIEVD5po2vi0YH
 jpVo/S7fRxBBpWBflRALFMZ7PheFNwixWMqYT9V6D6GqliORuO5JMd0Z3JnBAnlK8nyD
 FjGZbzfwHaP52fywY1N/PURvXrasKs5f462oemxb2Xaqt74JOJPZMgusy0CoFTliKtuu
 beWzzGjHLFWTpBgX6wtmUlvf2t8o/bZuYFrv8SDtuPmLZEFsrOt0bF3Xo3KfdixPyhC4
 8Py/FSxBNQXYDjdddwdnD5rR8prdDjDbDnnLpXbuY37/O6JrT1xdBBVKp0gQPGJidmxk
 3TKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746427489; x=1747032289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YIUxxhjNyQXaa6xVMsBBJ0f9g7v1IfCCUpbgqE5S6ZI=;
 b=jL2+gNN6GSK2PCBUZd1tCUrd33/UkcTKROMcCHUP6StILbyvae0JM+jlVEE9sSc3pW
 NynvTy+LDNf2etuh2HdeLqPy1Nabv6k0VDdHnS0yKAgzYAQ8BWRJ+XNReGVP19vHgifc
 M1uCg9mtt/bJ7lOvtjPtMC7fphx3HtT+v93q8K3u40LTyAhWyrbTTqmTzFJPUWe2sWbQ
 em1uvgftO0t181QdLTklcfenMaUyljndCrnn0Dme0sMDOpgYonusTpLBu4HqEFBIFDUz
 TSyUsDy7GDcOk2QeqGP8CYrA6S2Kr0WeMvS6IYYO9zxRytCsdH8lvnQlHLu+JP+QfPki
 FLmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWolXeeBG5a0ZcfV/Az9JBK2YsU2yw041mliT4eyBEzSPY57NkGQsF8cRfBGEvKYIu+5HYvVcM/Jbro@nongnu.org
X-Gm-Message-State: AOJu0Yz+BM0yGBJKExG8cJ0bjbIoEWgdJ5tKuaQDozXdDBtu29Pb5oRS
 rESLzRMkZ18G3zwDHCw3auqewpTT5+CrgtyGc/6Oyt/nB2U6CzvIdhoWZjf8GSI=
X-Gm-Gg: ASbGncvLtuWJBTBfaAqmH3v/4NAq3z36pEoOX+sfp2MgwKTT0HHkCmeiec1WBRC41kr
 2NN8j0ZuU6SgT0HgUlGP+x5b/48tz5QkFPO7eia3hma513Fn5+LmBVTKvKdnDDXymA37fqaDu28
 p9BQFSRxL5rTUYmj2BUiWXqqweMq6/YkREVTgVugHr1BuXGNM9LIhF6+gxVjESU8X7JB8EVmM8L
 vm8eukgX1ci/oZ8B3fc2lX0f6EGtUCnucs9Wgy2TmH+UjIbrEuOFKmFQ20nk6Pcez2+Oq8/bHdL
 kBf8u0KkEcQTyddiTKHnIBd4O91yfOvfcuPAgRKULH2FJLDfsZw=
X-Google-Smtp-Source: AGHT+IESvSmFexnkai6hMshJOXUw1VNCWoSRkp5WdlcqQfGVhSkfHunrCbdoVueTFSL5uz8/VDJnSA==
X-Received: by 2002:a05:6a20:e609:b0:1f5:72eb:8b3f with SMTP id
 adf61e73a8af0-20e96ae5554mr8999364637.24.1746427489149; 
 Sun, 04 May 2025 23:44:49 -0700 (PDT)
Received: from [157.82.207.61] ([157.82.207.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7aebdsm5998931b3a.32.2025.05.04.23.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 23:44:48 -0700 (PDT)
Message-ID: <db08fab9-682c-491c-bafc-9a701bbc73ee@daynix.com>
Date: Mon, 5 May 2025 15:44:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] virtio: Convert feature properties to OnOffAuto
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org, devel@daynix.com
References: <20250306-virtio-v6-0-1235eab776d9@daynix.com>
 <20250425081234-mutt-send-email-mst@kernel.org> <aAt-HPZB7ifgZqmd@redhat.com>
 <87r01gb7of.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87r01gb7of.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/04/26 0:08, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Fri, Apr 25, 2025 at 08:14:13AM -0400, Michael S. Tsirkin wrote:
>>> On Thu, Mar 06, 2025 at 03:16:26PM +0900, Akihiko Odaki wrote:
>>>> This series was spun off from:
>>>> "[PATCH 0/3] virtio-net: Convert feature properties to OnOffAuto"
>>>> (https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/)
>>>>
>>>> Some features are not always available with vhost. Legacy features are
>>>> not available with vp_vdpa in particular. virtio devices used to disable
>>>> them when not available even if the corresponding properties were
>>>> explicitly set to "on".
>>>>
>>>> QEMU already has OnOffAuto type, which includes the "auto" value to let
>>>> it automatically decide the effective value. Convert feature properties
>>>> to OnOffAuto and set them "auto" by default to utilize it. This allows
>>>> QEMU to report an error if they are set "on" and the corresponding
>>>> features are not available.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>>
>>> Marcus, Paolo, Daniel, Eduardo, any feedback on the QOM bits?
>>
>> I've said on every previous version that I don't think we should be
>> changing OnOffAuto to secretly accept bool values. That is bypassing
>> QAPI schema definitions with a special code hack.
> 
> I also objected to v4.  Thread starts at
> 
>      Message-ID: <87cyfwxveo.fsf@pond.sub.org>
>      https://lore.kernel.org/qemu-devel/87cyfwxveo.fsf@pond.sub.org/
> 
> I could be persuaded to accept a patch that changes exactly the
> properties that need to be changed to tri-state, with suitable
> rationale.  This patch changes a bunch of unrelated properties, too.
> 

I replied to the thread as I found that I haven't replied to the last 
message in the thread and the newer versions of the series do not 
address its discussion points either.

Regards,
Akihiko Odaki

