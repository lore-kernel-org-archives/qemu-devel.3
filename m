Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B747FC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI2oL-0004Xo-VN; Thu, 22 May 2025 06:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uI2oK-0004XU-FE
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:06:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uI2oG-0002XY-8r
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:06:00 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso63712425e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 03:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747908353; x=1748513153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzSmlbzdXyt7bNZpTi9t5T9ZvJwF2RhXhAKlnwzFnqk=;
 b=cR52E00yyJckOw6Abu4msWY8UGChigEGhbW+HnwCu0G/VuyTdz/bJiyl/xYsqpum2n
 SdwTEIMCceXmMmVkLPTWSnraM7QGyrNVL9Cbxf5F0i0NAjSj2v7D/4mquKLHxuicdT1v
 abMQof0fqcThzXnBMuztFHfyCGtNLvrf5KPzrRjRVohPNznuWLKBIVZZJplaPMJf/OWG
 dsAYTsrE2C3q8SxGgZiPvsFLTK2Q2l2bbOV2fwHevE5wUhCtRRZ2R+bZzb7RJC0xNlPo
 GHph7xM8qcDJ5WmY2TaDn81cO9YM5RZthet/cZfadISjoOKuQkCgeLqoWfcsioxi9xZv
 aDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747908353; x=1748513153;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mzSmlbzdXyt7bNZpTi9t5T9ZvJwF2RhXhAKlnwzFnqk=;
 b=JeRh8RF23a2dacchB9UutYUXPNrkq2XnG8nCzha2h/5fl8H/qAMqALmRihIoFivIt8
 K1+QDFFVIIS8GKfNcFiNhKtXhYaM/LluI9or5bH5pqKIKGp32nPxjEwvGAzBxheT8w01
 6jKVeArO/ptvbDqjsrB/DPDe56SYFcDutu48OLKyTTlwIisF1mMvRMkbb2elmtzBHpX9
 Xw9Yoo9lnbaJV41MPi8qTAcIcesVGFRdQf3h8a5gE+LRPBxfiqRjF1+vgBaCQ7NK+g8t
 nOsGfQAA7XguA3CcS70bju1kp0Q4baq8NX2n/HiJaZiV3QqCVcFcWR9XzSQRVug26173
 URQw==
X-Gm-Message-State: AOJu0Yz2k9oyNICNV/ZFR/CpX6cfh5rLovFNT0lD9vsqjHXRlALmrzMk
 jYe45MJ3fi40+SDbNY7g1Lb4mWAvE+7nv73zVyzxsvB8PVfDmNI1HyuRsPGVjEaTT2I=
X-Gm-Gg: ASbGnctwckPinYHwxMo99IXyXJ5z1py7fZChTFyOFcZilryKJJXJUoC+tBLXAwWzf6x
 Qyws2KaPlEGZ84gP85rSvLtmHOUgTrqYwEe5EsJyMI6LRgiD2r/v5/FhidD+4D8iH+XXACpMrLZ
 Dx8qN/eeE3UVdMjaAbxE+l+H3Lq+PbJaWRFCppRTzNAW+U1ATeaS4YtEKUNqmW6HgEId2Fv8ZyQ
 Z8TkpAie/f8UElubqBsXq0bx98zxhpiJLAyhKVSejZdKGTo+ATBVR+RWTJRbi69i0bsmvOActxL
 yHKSoIHLbcg6JSF678Yek9JhCeX77s6uYc/aIzo3rOgBMzn3WK3s
X-Google-Smtp-Source: AGHT+IHAOwooPWuagL3wDUu00H+w42AkTySOuPM5T7BlpYDCZ5ab5O4ddWOsMld0pWAid2QaLu718w==
X-Received: by 2002:a05:600c:3acb:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-442fefee292mr240181885e9.10.1747908353197; 
 Thu, 22 May 2025 03:05:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f3814262sm98656845e9.25.2025.05.22.03.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 03:05:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE8B75F8AD;
 Thu, 22 May 2025 11:05:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Peter Xu
 <peterx@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Markus Armbruster
 <armbru@redhat.com>,  David Hildenbrand <david@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,  Patryk
 'patryk4815' Sondej <patryk.sondej@gmail.com>
Subject: Re: [PATCH v3 19/20] gdbstub: Implement qGDBServerVersion packet
In-Reply-To: <0e6cb7af-37eb-4e8d-b342-ecfcdb639f10@daynix.com> (Akihiko
 Odaki's message of "Thu, 22 May 2025 15:29:06 +0900")
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-20-alex.bennee@linaro.org>
 <0e6cb7af-37eb-4e8d-b342-ecfcdb639f10@daynix.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 22 May 2025 11:05:51 +0100
Message-ID: <87zff56juo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2025/05/22 1:42, Alex Benn=C3=A9e wrote:
>> From: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
>> This commit adds support for the `qGDBServerVersion` packet to the
>> qemu
>> gdbstub  which could be used by clients to detect the QEMU version
>> (and, e.g., use a workaround for known bugs).
>> This packet is not documented/standarized by GDB but it was
>> implemented
>> by LLDB gdbstub [0] and is helpful for projects like Pwndbg [1].
>> This has been implemented by Patryk, who I included in
>> Co-authored-by
>> and who asked me to send the patch.
>> [0]
>> https://lldb.llvm.org/resources/lldbgdbremote.html#qgdbserverversion
>> [1] https://github.com/pwndbg/pwndbg/issues/2648
>> Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
>> Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail=
.com>
>> Message-Id: <20250403191340.53343-1-dominik.b.czarnota@gmail.com>
>> [AJB: fix include, checkpatch linewrap]
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   gdbstub/gdbstub.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index 6023c80d25..def0b7e877 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -28,6 +28,7 @@
>>   #include "qemu/cutils.h"
>>   #include "qemu/module.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/target-info.h"
>>   #include "trace.h"
>>   #include "exec/gdbstub.h"
>>   #include "gdbstub/commands.h"
>> @@ -1597,6 +1598,18 @@ static void handle_query_threads(GArray *params, =
void *user_ctx)
>>       gdbserver_state.query_cpu =3D gdb_next_attached_cpu(gdbserver_stat=
e.query_cpu);
>>   }
>>   +static void handle_query_gdb_server_version(GArray *params, void
>> *user_ctx)
>> +{
>> +#if defined(CONFIG_USER_ONLY)
>> +    g_string_printf(gdbserver_state.str_buf, "name:qemu-%s;version:%s;",
>> +                    target_name(), QEMU_VERSION);
>> +#else
>> +    g_string_printf(gdbserver_state.str_buf, "name:qemu-system-%s;versi=
on:%s;",
>> +                    target_name(), QEMU_VERSION);
>> +#endif
>
> I sugguest passing "qemu" as the name property.
>
> I guess LLDB developers chose to explicitly have the key-value pair
> syntax so that users can have one unified logic for parsing and avoid
> the mess of HTTP's User-Agent; there is a proposal for Web that
> introduces key-value pairs in a similar manner:
> https://developer.chrome.com/docs/privacy-security/user-agent-client-hints
>
> If we embed more information like to the name property, users will
> need to have an additional logic to know if it's QEMU or to know other
> information. Instead, we can emit:
> name:qemu;version:10.0.50;
>
> and we can use something like follows if we want to tell more:
> name:qemu;version:10.0.50;qemu-mode:system;qemu-target:hexagon;

I think we are getting into bike shedding territory here. GDB does need
a decent way to communicate about supported targets and when it comes up
with one we shall implement it. But I don't think we need to give too
much thought to this custom response for now.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

