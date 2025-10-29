Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D4DCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1ZT-0000ra-Gx; Wed, 29 Oct 2025 04:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE1ZS-0000qr-EV
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE1ZM-0007RM-Qm
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761726608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EQKGV9O9lc9gix3q02KFTPF1x39K2gFpCdzx2x96lVE=;
 b=Gg/xOSVZzpozo1X9X8Bbksw2qzBailGwpGUddYl3q0v2tW1CdqpICbpoK4999FLFYyAM1P
 AX9StdIICk+UhsMbfJUe0D2Xd454f9+onGlHBimIgO7DjKKOPrGPFNMKgYawSjEarkOGrI
 z/QFZP00JNEw4CMP/h2N9WWfudO2/B4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-NvdxRc9TPN2VxEpQuEJbfQ-1; Wed, 29 Oct 2025 04:30:07 -0400
X-MC-Unique: NvdxRc9TPN2VxEpQuEJbfQ-1
X-Mimecast-MFC-AGG-ID: NvdxRc9TPN2VxEpQuEJbfQ_1761726606
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42851b6a659so5546197f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761726606; x=1762331406;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EQKGV9O9lc9gix3q02KFTPF1x39K2gFpCdzx2x96lVE=;
 b=QttMZXMD0p6z/P0FUzdUF/yX3R9XNGh8A4a3Y0IW+vfwELIDYBo3e/KMtDK16UL2yI
 SvfiACaDXGa4vrg0rxpdEazIbeL0ULFEptZJr6h/LGUKghs408x1+SJU06rBRf9F3JfX
 VhYh9WRxULLuTEJVPzWGveI8pY3iOLrfJtOcm3GTuPc38yU1XWunwDbkBgdiQVv9LJEE
 abSFraZJholhBXoDAPplRrmZ5FBf2xKb0yOwQKpP/fIYzURP7vmqmeL/+ZAHiYnshhLZ
 GgWwhCO6z6TuUYRAB24qSQLXLNLasMCtMY5kXFePXZolPFy1whFHKuoUeMt28cYynCrs
 HtWQ==
X-Gm-Message-State: AOJu0Yw2eCnBLoiCD3c691ZrFFqrw/dliEGMKZOIdT0cxxbuIy8fiy48
 cSfyB46xUSgV+mn0XRsFO4cCpgqYudpBlyYAHnvIiESPdDsO8qUy+TO4TRPnPCH+GLD7MpsmrY0
 CUNuvb8bI9B0VWSyYqG8UZa+axYxTYYMM1InMaINdNPTrv4LpahhHViCf
X-Gm-Gg: ASbGncs3MDq0k+/BAcjDE/1A1Vo2xDjrnsd9bVpfWbjeGKHn+cycelwXiiHsmQxpNSu
 PL3KpSh3pmLAqJAAvvkTs2w6L0eVz1BIHtr/T286Q/gkbF/0nQSFXh2Kf2LvWpjC1hkTIFnkHXZ
 1fUKQYGnXzS6Xd0CCeg693Z5RN/6rrb84jdCnLKj2X2/CyMfxnVVLXRfNrqdoQ32a7KYmDj0xmN
 gzeVfwmZvtAy2KTxUu7KuQr2p+o/dr4jrZHochEKgWeBk7XsXDnCy0DuB8DF1X02j8p5UWm5xxH
 cdmMMGxVDW8JO+AXTY0O1Xz7yXwQ7WWWecF8Xfag8cGqn7PB0YU9PEE7RLLOSBQ7D3cZEkI=
X-Received: by 2002:a05:6000:4304:b0:426:ee08:8ea9 with SMTP id
 ffacd0b85a97d-429aefcd0e5mr1419144f8f.44.1761726605728; 
 Wed, 29 Oct 2025 01:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGexTCcXBGYoiDUvWYt8lCj4x1DhaYlOjTSE1zUn1SncVs4iXNnVmb84aYMgVYo6VpP78kgUQ==
X-Received: by 2002:a05:6000:4304:b0:426:ee08:8ea9 with SMTP id
 ffacd0b85a97d-429aefcd0e5mr1419103f8f.44.1761726605070; 
 Wed, 29 Oct 2025 01:30:05 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbc16sm24275621f8f.15.2025.10.29.01.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:30:04 -0700 (PDT)
Message-ID: <cd041086-e694-438f-a396-1bb0319510b5@redhat.com>
Date: Wed, 29 Oct 2025 09:30:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: include the lower level QMP log
 messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, John Snow <jsnow@redhat.com>
References: <20251028182651.873256-1-berrange@redhat.com>
 <20251028182651.873256-3-berrange@redhat.com>
 <c87f0929-a38c-425d-bfb6-d2985b908124@redhat.com>
 <aQHMNLgcazOGGR45@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aQHMNLgcazOGGR45@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29/10/2025 09.12, Daniel P. Berrangé wrote:
> On Wed, Oct 29, 2025 at 08:12:31AM +0100, Thomas Huth wrote:
>> On 28/10/2025 19.26, Daniel P. Berrangé wrote:
>>> We've seen a GitLab CI timeout failure in the test_pseries.py test,
>>> where it appears likely that the test has hung in a self.qmp('quit')
>>> call, but we don't have conclusive proof. Adding the QMP log category
>>> to what we capture should help us diagnose this, at the cost of the
>>> base.log file becoming significantly more verbose. The previous
>>> commit to include the logger category name and function should at
>>> least help understanding the more verbose logs.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    tests/functional/qemu_test/testcase.py | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
>>> index 6fc6e1ac0a..5ab84ce674 100644
>>> --- a/tests/functional/qemu_test/testcase.py
>>> +++ b/tests/functional/qemu_test/testcase.py
>>> @@ -225,6 +225,9 @@ def setUp(self):
>>>            self.machinelog = logging.getLogger('qemu.machine')
>>>            self.machinelog.setLevel(logging.DEBUG)
>>>            self.machinelog.addHandler(self._log_fh)
>>> +        self.qmplog = logging.getLogger('qemu.qmp')
>>> +        self.qmplog.setLevel(logging.DEBUG)
>>> +        self.qmplog.addHandler(self._log_fh)
>>>            if not self.assets_available():
>>>                self.skipTest('One or more assets is not available')
>>> @@ -235,6 +238,7 @@ def tearDown(self):
>>>            if self.socketdir is not None:
>>>                shutil.rmtree(self.socketdir.name)
>>>                self.socketdir = None
>>> +        self.qmplog.removeHandler(self._log_fh)
>>>            self.machinelog.removeHandler(self._log_fh)
>>>            self.log.removeHandler(self._log_fh)
>>>            self._log_fh.close()
>>
>>   Hi,
>>
>> I tested this patch, and now I'm seeing Python stack traces in the base.log,
>> like this:
>>
>> 2025-10-29 07:22:45,264 - DEBUG: qemu.qmp.protocol.default._bh_loop_forever
>> Task.Reader: failure:
>>    | Traceback (most recent call last):
>>    |   File "../python/qemu/qmp/protocol.py", line 914, in _bh_loop_forever
>>    |     await async_fn()
>>    |   File "../python/qemu/qmp/protocol.py", line 952, in _bh_recv_message
>>    |     msg = await self._recv()
>>    |           ^^^^^^^^^^^^^^^^^^
>>    |   File "../python/qemu/qmp/protocol.py", line 1053, in _recv
>>    |     message = await self._do_recv()
>>    |               ^^^^^^^^^^^^^^^^^^^^^
>>    |   File "../python/qemu/qmp/qmp_client.py", line 459, in _do_recv
>>    |     msg_bytes = await self._readline()
>>    |                 ^^^^^^^^^^^^^^^^^^^^^^
>>    |   File "../python/qemu/qmp/protocol.py", line 1021, in _readline
>>    |     raise EOFError
>>    | EOFError
>>
>> If if it's harmless, I think that's very confusing for the casual user when
>> trying to debug a problem. Can we avoid these?
> 
> That comes from this code in qemu/qmp/protocol.py
> 
>          except BaseException as err:
>              self.logger.log(
>                  logging.INFO if isinstance(err, EOFError) else logging.ERROR,
>                  "Task.%s: %s",
>                  name, exception_summary(err)
>              )
>              self.logger.debug("Task.%s: failure:\n%s\n",
>                                name, pretty_traceback())
>              self._schedule_disconnect()
>              raise
> 
> Given EOF is a "normal" thing, I'm not convinced it justifies printing
> a traceback.  I'd be inclined to suggest a new "except EOFError" clause
> that catches that normal exception and thus skips the traceback.

Sounds reasonable, could you please send a patch for qemu.qmp?

> I don't think we need to block this patch waiting for that improvement
> though. When collecting DEBUG logs there are always going to be weird
> things like this present, and anything misleading just needs to be
> fixed when we uncover it.

Ack.

>> Or maybe rather log the qmp stuff into a separate file, e.g. qmp.log ?
> 
> I really don't want separate files for different log categories, as then
> you have created a problem of merging the two files in order to interpret
> the flow. That doesn't doesn't scale as we capture yet more log categories.

Ok, fine with me, we still can refine later if we feel that it is necessary. So:

Reviewed-by: Thomas Huth <thuth@redhat.com>

I'll queue this for my next pull request.

  Thomas


