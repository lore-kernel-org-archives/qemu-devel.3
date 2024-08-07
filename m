Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E794C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbfTx-00066Y-PJ; Wed, 07 Aug 2024 08:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfTm-0005yi-BM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:09:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfTg-0008DI-F3
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:09:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3684e8220f9so461338f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723032554; x=1723637354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BzYjHKM8QWm29bOPoyExYoIAdgoIo8pXShLve8RotKo=;
 b=OwM9aLirNLI3qdRghKg70E/Je0R8mlkw6ufPJ4ldZ/YY1X22Qgyed/FVPVeba9T2nw
 505i9likWjnYOjptYw1zKQzhfI3QGP9bOpFedduAkio1S+D2DphvCGBePZFXeBfzriK5
 zZ+CqVJN42rl0v92/VW8QgXSyNSvAi/Io5W5di5wXoL4Hd2IXe5iQBla7BY+NdYWbqnx
 NsbdpYGHbxQk44UxbDE8Fw3LnpM55BrM2Rpt4qgIAlTGG2ajsjsbq5gyNKOqTCxTQeKc
 TLK+oinRhUdB3gASu3S4by4hoD3EAHPCokgGHPWypqE4f5Z2xg8in1TlBUnMMWEXXWnM
 fhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723032554; x=1723637354;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BzYjHKM8QWm29bOPoyExYoIAdgoIo8pXShLve8RotKo=;
 b=cqOFyjI6S9jln3hLusGS0bDHr2rG0unXyUHJguuMB49bTpKOdMgMWcKpEOi4jwe1mk
 QROEXZL1QE59Pmm/ypVPlD3HFewglZoa2bZ/tMq/NtvFmJMZ2qeoGuZufiYW/KINaSyY
 atkBynlpSDhY0oKXOUNoJDM8x0wajth++oEJs7zoN86FGeLj3ESZceH/sPx0W4e1oUgC
 2OvNJIMlyGERWsJQPFAn5XXAo2QgP4TA7D5YIatGwnFONQWOzF2jAN8UDJWZunc1ALTA
 fwfQeXAqTyJvjkojLTZ7qc/icMp53OuLWX4UGN6ZMC4Nszhc3OraicOzpP68UFIQsksx
 5x+g==
X-Gm-Message-State: AOJu0YzvhH0flfH7LopJIdAqA6xvtn8t4aKIgvUe9sp5Smf8pOM6cmc0
 osScc/yVMVygANddvFLpF7ye0NZq9hvfSPiHO/EEK8kyNZooARt8ZNOEsoFXNlQ=
X-Google-Smtp-Source: AGHT+IEexye4bTd5GUjoXpcrXInlT7xJIWsZz+MgVf0XYtY7myKgZXP/OTB5nYoAwB/pb07EXpD07Q==
X-Received: by 2002:adf:b197:0:b0:36b:a9e8:6b5 with SMTP id
 ffacd0b85a97d-36bf0db1e40mr1574498f8f.10.1723032553621; 
 Wed, 07 Aug 2024 05:09:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01efe5sm15832435f8f.46.2024.08.07.05.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 05:09:13 -0700 (PDT)
Message-ID: <f2491b8e-595f-456e-8dd4-92a11207e092@linaro.org>
Date: Wed, 7 Aug 2024 14:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] qapi: Generate QAPI files using qapi/ for generated
 header paths
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240807093406.40360-1-philmd@linaro.org>
 <ZrNB5C7Ta-Qg-9HT@redhat.com> <87ttfwwqrx.fsf@pond.sub.org>
 <ZrNTxb8go0xqfE3R@redhat.com> <8734ngwpca.fsf@pond.sub.org>
 <ZrNZmFL_HjuKrque@redhat.com> <87ed70v8x0.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ed70v8x0.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 7/8/24 14:01, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Wed, Aug 07, 2024 at 01:21:25PM +0200, Markus Armbruster wrote:
>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>
>>>> On Wed, Aug 07, 2024 at 12:50:26PM +0200, Markus Armbruster wrote:
>>>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>
>>> [...]
>>>
>>>>>> It is confusing that we have both shared stuff and QMP schema
>>>>>> only stuff under the same location.
>>>>>
>>>>> Which stuff in which location?
>>>>
>>>> There are multiple directories with 'qapi' in their name
>>>>
>>>>   - $SRC/include/qapi - all generic stuff for any consumer of QAPI
>>>>   - $SRC/qapi - impl of generic stuff from $SRC/include/qapi, but
>>>>                 also the QMP schema for machine emulator
>>>>   - $BUILD/qapi - generated code for QMP schema for machine emulator
>>>
>>>     - scripts/qapi - the generator code
>>>
>>>>
>>>> I find it confusing that we have both generic QAPI code and the main
>>>> machine emulator QMP schema in directories sharing the same 'qapi'
>>>> name.
>>>
>>> Got it.
>>>
>>> Lack of separation between generic C infrastructure and specific schema
>>> hasn't really annoyed me.  Possibly because the two are, for better or
>>> worse, joined at the hip.  Except for the use of "qapi:" in commit
>>> message titles; there I've at times felt a slight urge to distinguish
>>> between schema work, C infrastructure work, and generator work.
>>>
>>> Of course, other people's confusion trumps my non-annoyance.
>>
>> When we first introduced the QAPI/QMP schema for system emulator of
>> course it was fine, since we didn't have QGA usage.
> 
> Actually, qga's QAPI schema (commit e3d4d25206a) predates the main QAPI
> schema (commit e3193601c84) by a few weeks.
> 
>>                                                      Now days we have
>> a dedicate $SRCDIR/system directory for the system emulators, so I
>> wonder if its worth putting the system emulator schemas in there
>> instead ? Caveat is that the QSD also uses some of this schema.
> 
> Another caveat is that much QAPI code, both infrastructure and
> generated, has bled into programs other than qemu-system-FOO.

qapi/qapi-types-foo.h is OK since we to share libcommon.a.

I'm not sure about qapi/qapi-visit-foo.h, maybe due to qtests?
There was also some code pulled by QOM properties, althougth not used.

> $ gdb -batch -ex "info sources" bld/qemu-i386 | tr ',' '\012' | sed -n '/qapi/s,^.*/qemu/,,p'
> bld/qapi/qapi-types-machine-common.h
> bld/qapi/qapi-types-machine.h
> include/qapi/util.h
> bld/qapi/qapi-builtin-types.h
> bld/qapi/qapi-types-error.h
> bld/qapi/qapi-types-common.h
> bld/qapi/qapi-types-run-state.h
> include/qapi/error.h
> bld/qapi/qapi-visit-machine.h
> include/qapi/visitor.h
> bld/qapi/qapi-builtin-visit.h
> bld/qapi/qapi-types-replay.h
> include/qapi/qmp/qobject.h
> include/qapi/qmp/qlist.h
> include/qapi/qmp/qdict.h
> bld/qapi/qapi-events-qdev.h
> include/qapi/qmp/qbool.h
> include/qapi/qmp/qnum.h
> include/qapi/qmp/qstring.h
> include/qapi/forward-visitor.h
> include/qapi/string-output-visitor.h
> include/qapi/string-input-visitor.h
> include/qapi/qobject-input-visitor.h
> bld/qapi/qapi-types-authz.h
> bld/qapi/qapi-types-crypto.h
> bld/qapi/qapi-types-sockets.h
> bld/qapi/qapi-types-block-core.h
> bld/qapi/qapi-types-qom.h
> include/qapi/qmp/qjson.h
> bld/qapi/qapi-visit-qom.h
> include/qapi/qobject-output-visitor.h
> bld/qapi/qapi-builtin-visit.c
> bld/qapi/qapi-types-common.c
> bld/qapi/qapi-visit-common.h
> include/qapi/dealloc-visitor.h
> bld/qapi/qapi-visit-common.c
> bld/qapi/qapi-visit-machine.c
> bld/qapi/qapi-visit-machine-common.h
> bld/qapi/qapi-types-qom.c
> bld/qapi/qapi-visit-qom.c
> bld/qapi/qapi-visit-crypto.h
> bld/qapi/qapi-visit-block-core.h
> bld/qapi/qapi-visit-authz.h
> bld/qapi/qapi-visit-sockets.h
> bld/qapi/qapi-visit-sockets.c
> bld/qapi/qapi-events-qdev.c
> bld/qapi/qapi-emit-events.h
> bld/qapi/qapi-types-qdev.h
> bld/qapi/qapi-visit-qdev.h
> include/qapi/compat-policy.h
> include/qapi/qmp-event.h
> qapi/qapi-dealloc-visitor.c
> include/qapi/qmp/qnull.h
> include/qapi/visitor-impl.h
> bld/qapi/qapi-types-compat.h
> qapi/qapi-forward-visitor.c
> qapi/qapi-util.c
> qapi/qapi-visit-core.c
> bld/trace/trace-qapi.h
> qapi/trace-events
> bld/trace/trace-dtrace-qapi.h
> qapi/qobject-input-visitor.c
> qapi/qobject-output-visitor.c
> qapi/string-input-visitor.c
> qapi/string-output-visitor.c
> qapi/qmp-dispatch.c
> include/qapi/qmp/dispatch.h
> qapi/qmp-event.c
> qapi/qmp-registry.c
> include/qapi/qmp/json-parser.h
> include/qapi/qmp/json-writer.h
> bld/qapi/qapi-builtin-types.c
> bld/qapi/qapi-visit-authz.c
> bld/qapi/qapi-visit-block-core.c
> bld/qapi/qapi-types-job.h
> bld/qapi/qapi-visit-job.h
> bld/qapi/qapi-visit-crypto.c
> bld/qapi/qapi-types-error.c
> bld/qapi/qapi-visit-job.c
> bld/qapi/qapi-visit-machine-common.c
> bld/qapi/qapi-types-machine.c
> bld/qapi/qapi-types-sockets.c
> bld/qapi/qapi-visit-qdev.c
> bld/trace/trace-qapi.c
> bld/qapi/qapi-types-authz.c
> bld/qapi/qapi-types-block-core.c
> bld/qapi/qapi-types-crypto.c
> bld/qapi/qapi-types-job.c
> bld/qapi/qapi-types-machine-common.c
> 

At least there are no qapi/qapi-commands-foo.[ch]!

