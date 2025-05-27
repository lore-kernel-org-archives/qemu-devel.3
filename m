Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F281C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 09:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJqQR-0007U6-MI; Tue, 27 May 2025 05:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uJqQP-0007Ry-Uq
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:16:46 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uJqQN-0005Yo-K4
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:16:45 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6045a8a59c5so4163061a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748337401; x=1748942201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26IrOJbBSzBEDERJTfH26O1/Y1kPw6CEQvUOwS9hG0I=;
 b=DBZ8oMzIN4C1v1NbKRRhbYeeYnt8pT/+3xUo7o7jgwj1atcx7wFaDYyzp4yKGKDd4V
 Zjd8+IAlnu8kOfDm08K9xSONsyR6oq633OGwsBhJfLEamakUncmTyM9Io8N7YBDT/3ys
 CW8NNcpXy9YDdczD7d1b6taA2f0qwM9yu16Qk0IoVPPY9uX/91yXH7zwbkF7iU3SHAnj
 4MyuF9acg5hMcxBxO+PIk4ZMR/EMRYEqgHgUQF83IPM0/u0DSwCPCvFyMTkhwt80o5/u
 cA/B54vYHi16s/oLpuHGXvBfoW8Q80KN61mC9LtSxl9mvktrJLM2DINskCb4PJ7rlgU9
 ARcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748337401; x=1748942201;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=26IrOJbBSzBEDERJTfH26O1/Y1kPw6CEQvUOwS9hG0I=;
 b=bmk9kI62aofF/iHmQeWygldeojtjU7lf0IO7uGOTlQvodng5xLJv4PZgiJ10Q9TWFY
 hNaH50L4wSlh96VOH5Z6CLbQgXoImBnwQr3/qrHIU7mxj1xYdI7FFnW7FKoRmoJ2rtSb
 qLAdc1Ag2E4S/nimAYI/VKW1ZAko0bNMqgwepzwtkqKF12de+xzx7S40gnr5GIDov6DY
 VC54CuNnvA9i23VISvf1bsuyCOvdIqVLUmRiMNoeMPz6dWCxc91uIo6UtJIYj0wv/boI
 Yt1IDNBVEWaUcveweh2fYx2u+UZNy7j3FTKPj0aRBvsWM/Hsz2wFSIoXqdKNjsvNySCh
 SFDQ==
X-Gm-Message-State: AOJu0YyWJ9dFu/B3C5of27LJmw/tjtYZGADc/0TArVlbcW9VXNRBQ+kD
 3cyD/X7Owt4HZqtwlUN3ZCkV2JP0Zei/8CgSK7O5gHvGThih8XNh/zbGBPg45iJHjSo=
X-Gm-Gg: ASbGnctXXdA6yDj8iDVQl43z5LpXQ7szhRbALcKz01KLLm6xhWRENk57IQwaclxLm4G
 Tw2GpgjQo1/fmIkkrASlgycX3Vlgodde8lXToVXw5PxUdR78Ta5VboZH8Alvno2zaPB5bfJ1N8S
 puQ4Z49V7Z+G6BJlhMCA89DBwrYxrcXFkoi9vTtMxLab1q6gUQPRq6MbGwZ6GFQHAklZdl9DDRD
 wYgdqn53pyfTeLaegRsJOPm1gVeHnshwJy6ibGyKZKFRJElUoLKSOeMBHZGEpV9UxzMth51fJ8N
 BVpTT+5ZGHQn0PinZutW+72sPhUYYCfd30lWaSBJV/y2DLN8PuRr
X-Google-Smtp-Source: AGHT+IHa/oIyJ2u9PwrZETfX8hOgoTF2yjHcnop3y1I9ND5CsDm6fg4yXU/9vaV8K0USEAE9RvRHMw==
X-Received: by 2002:a17:907:96a8:b0:ad2:5198:d715 with SMTP id
 a640c23a62f3a-ad85b181f1fmr1126516366b.19.1748337400931; 
 Tue, 27 May 2025 02:16:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad892483c19sm51973666b.145.2025.05.27.02.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 02:16:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A26335F80B;
 Tue, 27 May 2025 10:16:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,  John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Peter Xu <peterx@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alexandre Iooss
 <erdnaxe@crans.org>,  Markus Armbruster <armbru@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,  Patryk
 'patryk4815' Sondej <patryk.sondej@gmail.com>
Subject: Re: [PATCH v3 19/20] gdbstub: Implement qGDBServerVersion packet
In-Reply-To: <b916fe83-180b-48d6-815f-da556b8e42fd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun, 25 May 2025 17:25:47
 +0200")
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-20-alex.bennee@linaro.org>
 <b916fe83-180b-48d6-815f-da556b8e42fd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 27 May 2025 10:16:39 +0100
Message-ID: <877c22o1l4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 21/5/25 17:42, Alex Benn=C3=A9e wrote:
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
> g_string_printf() isn't really justified, we usually call
> g_string_append().

How is that meant to work with a format string?

>
>> +    gdb_put_strbuf();
>> +}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

