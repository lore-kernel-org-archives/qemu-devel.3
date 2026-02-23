Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D5FE98DE6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 15:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuYGT-0006Ea-1g; Mon, 23 Feb 2026 10:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vuYGR-0006E3-2e
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 10:54:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vuYGN-0002dE-06
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 10:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771862061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOuEBKX3RiEasYRIBw0IkcZmtR/BlQwl99CWe3Y4y94=;
 b=UsE4bwH44PrYIvqbu3kDa8QG0W36N7frtrHW6i5n9MMY+VupNIiH2QUSCBuwv1q9kAZWFu
 ooII68qnf1M0fidb1n421qaAmv6ipA8X9hMviOesfppwxlBGgbGpln8S507bFvMXhpwsni
 UiP0xfa72U4upbWb2S2DJw9tdkwmgxQ=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-eiq3tsGQMhibbr7oKBL0mA-1; Mon, 23 Feb 2026 10:54:17 -0500
X-MC-Unique: eiq3tsGQMhibbr7oKBL0mA-1
X-Mimecast-MFC-AGG-ID: eiq3tsGQMhibbr7oKBL0mA_1771862056
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bd808454d6so13315890eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 07:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771862056; x=1772466856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NOuEBKX3RiEasYRIBw0IkcZmtR/BlQwl99CWe3Y4y94=;
 b=QctZYBgIxxLFRA8NN2HnCewBSIh+k8RN8wW/UNpMceerOzTINCuxiv2fCb2mm9iBIx
 vhDJrYiD+NDPWcolU5FHNmbX4XxRFFKBO560C0VHzKTrMkab7Svq5m/iZJvrIKNB3C6g
 x5E5RYxlLma0v5PMjRGXXsXEiRcX29x0FMyp58aybLNjtoAWx6EDn0Qy1z1KFIVupqE5
 2ZW0KXRkFF4ExFVfMcEBScN5z5mbrRFuHFI7BH0HAS79CYktyl/mxbIBbChu83GIkmub
 Ae92UZGciOK1xSj/FVnK+2hfm0whiwQOkmwJi4DAslRa4cKnUzTaIilUYob8Vbudz/Jb
 ETZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771862056; x=1772466856;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NOuEBKX3RiEasYRIBw0IkcZmtR/BlQwl99CWe3Y4y94=;
 b=G9TU5V906xbdsQJHIq4AYlDYlwzAQUlqKf9QvLZZD+cqFfiQndYMWCjc4OtgsJhCrK
 pnek2vzTto1vlUi2Kj/ZBS++ryzPUha4ygylHQa2TeDez6jtGaqzZ4UmEiE95ZZTjocH
 Idf2Xyvx8ZWysbtbqYmCu5trgD1Bw2SRNIF3uLwiHMqwrrcFUH2d97pp2QXXudV5lj+x
 /8mwARPnOj4+HuHhXasAKPP/nan235qDdaMN4wbreewd0KBUUxZhaBot3Cq/Q/QdOVca
 Mb6V7pD5bpetO5CYt8X9JSndDS/gApTPGdeIn4WbUo4g2nhAzyae+fHUnX7JwSSsFVjY
 JNhQ==
X-Gm-Message-State: AOJu0YxGjTpYxPj5DVvDmTuTuQFkBjCD0j16NE2O6zMou8MvLrtWmpa7
 UNtQpRqCU6T8MFAhUnjWNHvP6mEQNzGh5nBiZpe2ojkuXRoRXGHvwJXwIDSd585rCaLVXGMxzEm
 IZl/MqzFYJyT7Gj5CWP7smGApt+kzxMF+5+jvt6P53sgRpxBvJP8nefLy
X-Gm-Gg: ATEYQzxSSkUqj6L7yGqxwZHIwoHA0HZb+MvKnJnYTJBdVG9O9vV1fGGIG9bW9HfXz+f
 cVYamMzBRY+YYnloIkLFjKA93AwZrT35DPmjEA3JF+M0f7P7ONJEAB5UC4mf7+I+/6qIjnVZMCW
 p6YWlVqJF06O/UHXvo8VtVWKLBd5Vfk+n0kTy1z/A+cVWGp33AFrmaB/SRXBeSpK6VlGPNeMoCf
 Fj8W3UpQF/tI96AQqsbTcLleZa4FMca21rguXTvx1AB89e4j0MZBf8yIGKx2YfGNJJXXBuRwvXH
 uCih+S67QmGNGVzv2gH80TxjyqDcqgTw66jhNc9eQRv5rS6noUl1sGE0v1GdZ5gs3k4ETR2Oe9l
 /2ZAM5jOew4y1z/nD2v7t5gqDxqCcJfjALLROYN/zinKznVgI3TpeqwovvkTSIIoUFKdfFWOs9C
 /d1MRFMHL2oBhkoSmm+OA7+ILRF9o=
X-Received: by 2002:a05:7300:7643:b0:2b8:6a22:6d52 with SMTP id
 5a478bee46e88-2bd7bd76f9emr3993333eec.33.1771862056301; 
 Mon, 23 Feb 2026 07:54:16 -0800 (PST)
X-Received: by 2002:a05:7300:7643:b0:2b8:6a22:6d52 with SMTP id
 5a478bee46e88-2bd7bd76f9emr3993312eec.33.1771862055728; 
 Mon, 23 Feb 2026 07:54:15 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-2bd7dc167b2sm4984731eec.28.2026.02.23.07.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Feb 2026 07:54:14 -0800 (PST)
Message-ID: <bedbf511-c46a-4468-bf65-cc452c621765@redhat.com>
Date: Mon, 23 Feb 2026 16:54:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] rust: QObject and QAPI bindings
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <aZwjpfu-qCCSoHdx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <aZwjpfu-qCCSoHdx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/23/26 10:53, Daniel P. Berrangé wrote:
> On Thu, Jan 08, 2026 at 02:10:27PM +0100, Paolo Bonzini wrote:
>> This adds two related parts of the Rust bindings:
>>
>> - QAPI code generator that creates Rust structs from the JSON
>>    description.  The structs are *not* ABI compatible with the
>>    C ones, instead they use native Rust data types.
>>
>> - QObject bindings and (de)serialization support, which can be used to
>>    convert QObjects to and from QAPI structs.
>>
>> Unfortunately Rust code is not able to use visitors, other than by
>> creating an intermediate QObject.  This is because of the different
>> architecture of serde vs. QAPI visitors, and because visitor's
>> dual-purpose functions, where the same function is used by both input and
>> output visitors, rely heavily on the structs using the same representation
>> as the visitor arguments (for example NUL-terminated strings).
>>
>> The serde format implementation was co-authored by me and Marc-André.
>> Marc-André did all the bug fixing and integration testing.
>>
>> As an example of how this would be used, the marshaling functions for
>> QMP commands would look like this:
> 
> Can you give more of the big picture about what follows this ?  From
> this example you're showing, are you suggesting that you'll be soon
> moving QMP command impls from C to Rust ?

The reasons for Marc-André and I to do this was just as an exploration. 
The patches show a different way to do what he had already tackled in 
2022, and allow a direct comparison the relative benefits between a more 
Rust-focused approach and a more direct translation of QEMU's C code.

Marc-André indeed had command implementations in Rust and that would be 
an obvious next step to continue on the QAPI side.  On the other hand, 
the QObject part (without QAPI structs) also works as a step towards 
more QOM integration, especially with respect to properties and 
backends.  Having a full-blown QObject implementation to move around 
bools is perhaps over-engineered, but is also an easy way to make a 
generic implementation that works for all QAPI types.

The block layer also needs QAPI for option parsing, so Kevin's work on 
block layer bindings would also benefit from having this integration.

In other words, there is no real big picture from me other than "someone 
needs to do the hard part for others": QOM, QAPI and the build system 
are the three central components from which all other bindings branch 
out.  Zhao and Marc-André have helped a lot with this work, and they 
also showed how to use these hard parts (see Zhao's vm-memory work and 
Marc-André's GStreamer backend), now it's also time for others to try 
and to take inspiration from Rust for improving the C side of things.

Paolo

> 
>>
>> fn qmp_marshal_query_stats(args: *mut QDict,
>>      retp: *mut *mut QObject, errp: *mut *mut Error)
>> {
>>      let qobj = unsafe { QObject::cloned_from_raw(args.cast()) };
>>
>>      let result = from_qobject::<StatsFilter>(qobj)
>>           .map_err(anyhow::Error::from)
>>           .and_then(qmp_query_stats)
>>           .and_then(|ret| to_qobject::<Vec<StatsResult>>(ret).map_err(anyhow::Error::from));
>>
>>      match qmp_marshal_query_stats_rs(qobj) {
>>          Ok(ret) => unsafe { *retp = ret.into_raw(); },
>>          Err(e) => unsafe { crate::Error::from(e).propagate(errp) },
>>      }
>> }
>>
> 
> With regards,
> Daniel


