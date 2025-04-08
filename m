Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F791C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 11:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u27DT-0003rA-0L; Tue, 08 Apr 2025 07:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u27Cu-0003oP-8D
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:33:32 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u27Cr-0007Id-Iv
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:33:31 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so953048166b.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744112007; x=1744716807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYoAebW+mVCrH5+3zl2gfxi09/h8FSZxlYwO38Lyyu4=;
 b=p9mneqvIivfMcnEfcMqwQA35UMQfMrbhF8VieAsMOF13pHUzjbxLN8nT+TSZ6g0mt7
 8NerLo96EMDmUCvHWlxlFxINLBAc+ZqYSWzfDkzOJsw+KNa6sTcf1PTuv6cXeGawKdKC
 mqzWuWrXPJP8nI0CORfKrYYQYMaRPtVjUAxd2bBLSaDNr3roeEZD1/fBo7eiU3EzFwnA
 F4U13/Tj8R8QffMLw9bBcEqvc4PTaaEkvjSH6rUjTtzyzhG3vXxQMO/RwrarxDiF1gmS
 wCIatZCVU+fXlWEcFz3TJxTpLGnm6nnrVVBgrGSi3v1/V09uChm6Jo8wThQ57UT9ErWH
 NJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744112007; x=1744716807;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EYoAebW+mVCrH5+3zl2gfxi09/h8FSZxlYwO38Lyyu4=;
 b=BcHA/eebCnbkIk4HsvvEgejYMXjHwf0+xsCXmjao/SfswzOLrB/yMSRgRxqciAdBK5
 5uORdEp3pZugBs4Ouy6CbFlIQQpAQdGsS7GJa7p8uYzAB3WLdnX6r43neoUawLi6uFlO
 7xLyAM5A+uBi6JbYP1O23pdtbSdtUTxms3dmlSrAO0IWzBg6GPs3Kh8uAJcvzL+UsCUP
 YlrjugG/Ov6rW4k9RFi4ic0yb3eUQb7dTRkgvpGB29sWXV/nDtVp0v0LIx62ClmPsCC2
 PRfUSxEOkbFNBrmBYOR32zczvQu/irWysu9+2SUSvnHa3hBQDw/1NtHsGTBSsgjG4z5Z
 ZKog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY8zj6Pu1fKgv4qgiHHK7bkNB+DHY2N1AEY2qINkcLn2kjj7+sNsYj5f1hshgStx75YhCN0mYcYEKq@nongnu.org
X-Gm-Message-State: AOJu0YzVXnOmi5aapMXROYvjp88khLjzp6utt+B98F/a/OkbRLCHDG0E
 I592YeSwej+E09UsPp4lxC9R1XsKMn9i58Gd0pj4zVntDirdJphhODv9FeIdwKo=
X-Gm-Gg: ASbGncvIcM7p08Im6VBVSamp9ujvfYQP+5/rFFCPV2AI6zxBpyJh0Pq5Jq0pVRD05sl
 gQJUkpZ8Wkgp1iWLAfbEwYHa500QKgu5mEUqUOjNnghbOED3xvLeBC/nT12Rf04nsWk1QUIo+0j
 nM+TA393GzewmFb/H70ZymBjqWTym7z2U1+kDKz3tiP57XunBKuo7c4S+XqWq/3GzN7Afdl3DRZ
 7e9FJnhhlwI0hsfADxV1mEFuzEzfM6S/5N052vb0tw7+dbTUl8wjlwN2JsxzHcDTpUHVtjfLIpa
 jUoWUgFBDkyOHxdPsfII2TuFRLlTVW3W07V5uGDZd+1pLS4=
X-Google-Smtp-Source: AGHT+IErzGWtCDEvobE4Ioz2s0RiueqV1beGd7DKL9E2Gii0+EFARjSx0vW4ELTv1UXTxfA+//0aRA==
X-Received: by 2002:a17:907:960f:b0:ac3:5c8e:d3f5 with SMTP id
 a640c23a62f3a-ac7d190ff66mr1521592466b.27.1744112007305; 
 Tue, 08 Apr 2025 04:33:27 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe9bb8esm884326666b.48.2025.04.08.04.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 04:33:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D4B2F5F8D1;
 Tue,  8 Apr 2025 12:33:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Mario Fleischmann <mario.fleischmann@lauterbach.com>,
 qemu-devel@nongnu.org,  philmd@linaro.org, christian.boenig@lauterbach.com
Subject: Re: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
In-Reply-To: <87r023m422.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 08 Apr 2025 10:48:53 +0200")
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
 <87semkw3qx.fsf@pond.sub.org>
 <ea767dfa-d52b-44fc-baec-deea0223094f@lauterbach.com>
 <87semjp286.fsf@pond.sub.org>
 <0736943f-443b-4bfc-8d69-f30f42029d07@lauterbach.com>
 <87r023m422.fsf@pond.sub.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Apr 2025 12:33:25 +0100
Message-ID: <87a58qj3ay.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>
>> Apologies for the line wrapping in yesterday's answer. Should be fixed n=
ow.
>>
>> On 08.04.2025 09:00, Markus Armbruster wrote:
>>> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>>>=20
>>>> Thanks a lot for the response, I really appreciate your time.
>>>>
>>>> On 07.04.2025 14:33, Markus Armbruster wrote:
>>>>
>>>>> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>>>>>
>>>>>> This patch series introduces support for the Multi-Core Debug (MCD) =
API, a
>>>>>> commonly used debug interface by emulators. The MCD API, defined thr=
ough a
>>>>>> header file, consists of 54 functions for implementing debug and tra=
ce.
>>>>>> However, since it is a header-file-only interface, MCD does not spec=
ify a
>>>>>> communication protocol. We get around this limitation by following a=
 remote
>>>>>> procedure call approach using QMP. The client stub corresponding to =
this
>>>>>> implementation can be found at https://gitlab.com/lauterbach/mcdrefs=
rv
>>>>>>
>>>>>> This series is the successor to:
>>>>>> "[PATCH v5 00/18] first version of mcdstub"
>>>>>> (https://patchew.org/QEMU/20231220162555.19545-1-nicolas.eder@lauter=
bach.com/)
>>>>>>
>>>>>> * Architecture-independent MCD implementation
>>>>>> * QMP instead of custom TCP protocol
>>>>>
>>>>> Rationale?  There must be pros and cons.
>>>>
>>>> Assuming you're referring to the protocol of the previous patch series:
>>>> The previous TCP protocol only supported a subset of MCD. As the=20
>>>> implementation progresses, the protocol eventually needs to be extende=
d,=20
>>>> possibly resulting in backwards compatibility problems.
>>>> Following an RPC approach and keeping the communication layer as close=
=20
>>>> to the MCD API as possible results in a larger protocol at first, but=
=20
>>>> does not need to be changed afterwards.
>>>> By directly mapping MCD functions onto QMP commands, the complexity in=
=20
>>>> the server and client stubs can be minimized.
>>>>
>>>> Assuming you're referring to the QMP choice:
>>>> QMP is being described as the "protocol which allows applications to=20
>>>> control a QEMU instance".
>>>> It provides a RPC framework which automatically (de)serializes methods=
=20
>>>> and their parameters, even inside QTests.
>>>> The whole interface is automatically documented.
>>>=20
>>> Let's see whether I understand.
>>>=20
>>> MCD is an established C interface.
>>>=20
>>> Your goal is to provide remote MCD for QEMU, i.e. the client uses the
>>> MCD C interface, and the interface's implementation talks to an MCD
>>> server integrated into QEMU via some remote transport.
>>>=20
>>> The previous version connects the two with a bespoke protocol via TCP.
>>> The client software translates between the C interface and this
>>> protocol.  QEMU implements the protocol's server side.  Designing and
>>> maintaining a protocol is expensive.
>>>=20
>>> This versions makes two changes:
>>>=20
>>> 1. Instead of layering a protocol on top of MCD, you use MCD directly.
>>> This eliminates protocol design and maintenance.  Moreover, translation
>>> becomes straightforward marshaling / unmarshaling for the transport.
>>>=20
>>> 2. You use QMP as a transport.  This gets you marshaling / unmarshaling
>>> for free.  It also provides some useful infrastructure for tests,
>>> documentation and such.
>>>=20
>>> Fair?
>>
>> Couldn't have put it better myself.
>>
<snip>
>>> What about providing the MCD interface as a separate QMP-like protocol?
>>> It gets its own QAPI schema, just like for qemu-ga.  Simplifies
>>> compiling it out when not needed.
>>>
>>> It gets its own socket, just like the GDB stub.  Might reduce
>>> interference between debugging and QMP.
>>>=20
>>> Thoughts?  Alex, Philippe, care to chime in?
>>
>> Sound reasonable to me. Keeping in mind the size of generated QAPI code,
>> an option to `./configure [...] --enable-mcd` is definitely advisable.
>
> Alex, Philippe?

When I spoke to Mario at DVCon last year I liked the idea of re-using
QMP instead of inventing yet another RPC interface for QEMU. QMP
certainly has nicer properties than the gdbstub which has a very
"organic" and "serial" feel to it.

Are you suggesting we re-use the machinery but use an entirely separate
socket with just the MCD namespace in it? I don't see that being a
problem as long as we can test it properly in the CI.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

