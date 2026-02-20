Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4919DC5ACD9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 16:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtTSt-00062E-Jx; Fri, 20 Feb 2026 11:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtTSs-00061x-2C
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 11:34:50 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtTSp-00046N-Qz
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 11:34:49 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65c187dfc82so2664002a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 08:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771605285; x=1772210085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wczBOvyJbz7JP+3E3wJjRaByMSjsbBRJyH/8kgk1/U8=;
 b=p9NI/fXo3bUJ13qCJz+pslBAMbG/gaHBaxdlgNB4oZTibzL8AfDHlBpCcU+NdnoKNo
 BqcGQHJcz/MgaAqpqKjYihgGk3DHV2QCjgRmc7RQA6+2FRi9sdczscbsmjiJoNBhOsL3
 FR6r6zZZyy9f6N1pPEj3Pw3IyGupPmpmvsMTgiDLaBmb1pT9teftS099hQVpOqmOPDY6
 MFpB0YO+p8lTMBx7gXKUxVL9lss2wTBwImvW1eRF3GTBx5wXOBmvY48w4CRMy/RQ1S35
 H9N46ndnJMBJKRGftH6f+cT/scvjv5Fnzqv0YdDUAB1TWNCZDiP/IAs0pzOGyA366MQ3
 X0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771605285; x=1772210085;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wczBOvyJbz7JP+3E3wJjRaByMSjsbBRJyH/8kgk1/U8=;
 b=E2HbI0AByYFjDRL43OHjQgjPsCn3fplWTN4/7KZkryCVzWJJjhXFNhMjjMMlBWmHqk
 mh5ZmBOoJEk6Z/5CHdCr9FQfK/v6HYQDobZZY3Ma9ECDVTt49sv/eYBPcsrcMubWRSwJ
 t6OGVosczaucg5icBZQjRkJgW3Xk+8Vmg1NWaVO64E7zmpUKaq/UuCnxNhbyv2+VwOQQ
 tay/ssSA7IZ/lF5hJBBAES70cm2P2umGEMgpOC4UoZnZ8q13jr4jpKDWXTfVdxsVRb8c
 mhZDjskrKC66gHsc3zFp3WRcPBmRMw+yjwzI8RXM1vh/LZzwyeymhf0QGFfyZeLL1s/k
 aKwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDWc83K7YWuJzneWvt9FqeTQGJv7gIS6agG2KN+qtare35GTvQ+f77tfBeNUM38HPE9w/61pFKcOLv@nongnu.org
X-Gm-Message-State: AOJu0Ywlv4A9oFTH3bqM55qo3HvpV6FjPxM+E9ks0SG+KqftwmU3uBJD
 R3JxJAk422aIUB4CPdvFZhFLERGVBb2YfOYlLlDGLzztgcElpefPFekY3VYyh8jr1oY=
X-Gm-Gg: AZuq6aJb2cr9nm/QqiPv0MAL1wLj6TkCGDct53oPELgiLqGPz+T2KU55qBTdkAtBlry
 DwkrvR6bgfjuZfJt+YHqla9nlq0HgYouTkWGTcrj7Vs4Rlxi20Ig3+WKAgX6GvQyKxJDZvdd+cq
 oK2H0sHyjiYq2tO2mnlzmyGc6d9oBZdboYl30tUPeygRY0i8eoIM4KTw7jHpxhdhaGJD0h3PTC/
 cDjHmBMKzFtdqtXbgmy9g8YyfNpG/crJSEBx7WBFEWqWs6nvZ+PFPRoaq6HGo1r2C0fDZnzWCc+
 dBlyKumNL6/wCaTV7r8iOQOecPeTPcEVpLe4Wuy2jm9iJnux+N0DIkZfyQIkReDqeXokozhZKKe
 aRCOehCHEEEzuzNu3/uLA2Y/i6R511xgqmGeOmD32JHG/jbDP9aAYMY9sc/GORmz/okbTc9+msm
 SmqNzX9qVuF08bzrS5Pj+MYY4=
X-Received: by 2002:a17:907:c12:b0:b88:4c99:bc0e with SMTP id
 a640c23a62f3a-b9081a01b8bmr6359466b.26.1771605285390; 
 Fri, 20 Feb 2026 08:34:45 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc7386b49sm694928666b.22.2026.02.20.08.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 08:34:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E5ECA5F838;
 Fri, 20 Feb 2026 16:34:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v3 2/5] plugins: add read-only property for registers
In-Reply-To: <7fc71343-095c-4dad-9cda-4267fc49b64c@epfl.ch> (Florian
 Hofhammer's message of "Mon, 16 Feb 2026 13:54:06 +0100")
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
 <8b36b6c1-83bd-462b-a346-f240dd17746d@epfl.ch>
 <871pjcdt5q.fsf@draig.linaro.org> <87pl6wcda9.fsf@draig.linaro.org>
 <878883e5-7100-48b7-bb44-e0728c93ae72@epfl.ch>
 <7137a1e3-9f07-4a6b-8507-35bbfa5324e7@linaro.org>
 <7fc71343-095c-4dad-9cda-4267fc49b64c@epfl.ch>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 20 Feb 2026 16:34:43 +0000
Message-ID: <87tsvb4bmk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> On 13/02/2026 19:36, Pierrick Bouvier wrote:
>> On 2/13/26 5:38 AM, Florian Hofhammer wrote:
>>> On 26/01/2026 21:46, Alex Benn=C3=A9e wrote:> Alex Benn=C3=A9e <alex.be=
nnee@linaro.org> writes:
>>>>
>>>>> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
>>>>>
>>>>>> Some registers should be marked as read-only from a plugin API
>>>>>> perspective, as writing to them via qemu_plugin_write_register has no
>>>>>> effect. This includes the program counter, and we expose this fact to
>>>>>> the plugins with this patch.
>>>>>>
>>>>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>>>>> ---
>>>>>>   include/qemu/qemu-plugin.h |  2 ++
>>>>>>   plugins/api.c              | 17 +++++++++++++++++
>>>>>>   2 files changed, 19 insertions(+)
>>>>>>
>>>>>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>>>>>> index f976b62030..1f25fb2b40 100644
>>>>>> --- a/include/qemu/qemu-plugin.h
>>>>>> +++ b/include/qemu/qemu-plugin.h
>>>>>> @@ -942,11 +942,13 @@ struct qemu_plugin_register;
>>>>>>    *          writing value with qemu_plugin_write_register
>>>>>>    * @name: register name
>>>>>>    * @feature: optional feature descriptor, can be NULL
>>>>>> + * @is_readonly: true if the register cannot be written via qemu_pl=
ugin_write_register
>>>>>>    */
>>>>>>   typedef struct {
>>>>>>       struct qemu_plugin_register *handle;
>>>>>>       const char *name;
>>>>>>       const char *feature;
>>>>>> +    bool is_readonly;
>>>>>>   } qemu_plugin_reg_descriptor;
>>>>>>     /**
>>>>>> diff --git a/plugins/api.c b/plugins/api.c
>>>>>> index fc19bdb40b..de8c32db50 100644
>>>>>> --- a/plugins/api.c
>>>>>> +++ b/plugins/api.c
>>>>>> @@ -403,6 +403,12 @@ bool qemu_plugin_bool_parse(const char *name, c=
onst char *value, bool *ret)
>>>>>>    * ancillary data the plugin might find useful.
>>>>>>    */
>>>>>>   +static const char pc_str[] =3D "pc"; // generic name for program =
counter
>>>>>> +static const char eip_str[] =3D "eip"; // x86 specific name for pro=
gram counter
>>>>>> +static const char rip_str[] =3D "rip"; // x86_64 specific name for =
program counter
>>>>>> +static const char pswa_str[] =3D "pswa"; // s390x specific name for=
 program counter
>>>>>> +static const char iaoq_str[] =3D "iaoq"; // HP/PA specific name for=
 program counter
>>>>>> +static const char rpc_str[] =3D "rpc"; // microblaze specific name =
for
>>>>>> program counter
>>>>>
>>>>> It's ugly but I can't think of anything better as you say in the comm=
it message.
>>>>>
>>>>>>   static GArray *create_register_handles(GArray *gdbstub_regs)
>>>>>>   {
>>>>>>       GArray *find_data =3D g_array_new(true, true,
>>>>>> @@ -417,9 +423,20 @@ static GArray *create_register_handles(GArray *=
gdbstub_regs)
>>>>>>               continue;
>>>>>>           }
>>>>>>   +        gint plugin_ro_bit =3D 0;
>>>>>>           /* Create a record for the plugin */
>>>>>>           desc.handle =3D GINT_TO_POINTER(grd->gdb_reg + 1);
>>>>>>           desc.name =3D g_intern_string(grd->name);
>>>>>
>>>>> Lets just set desc.is_readonly to false here.
>>>>>
>>>>>> +        if (!strcmp(desc.name, pc_str)
>>>>>> +            || !strcmp(desc.name, eip_str)
>>>>>> +            || !strcmp(desc.name, rip_str)
>>>>>> +            || !strcmp(desc.name, pswa_str)
>>>>>> +            || !strcmp(desc.name, iaoq_str)
>>>>>> +            || !strcmp(desc.name, rpc_str)
>>>>>> +           ) {
>>>>>> +            plugin_ro_bit =3D 1;
>>>>>> +        }
>>>>>> +        desc.is_readonly =3D plugin_ro_bit =3D=3D 1 ? true : false;
>>>>>
>>>>> And fold setting it to true into the if statement. I have a marginal
>>>>> preference for g_strcmp0(desc.name, eip_str) =3D=3D 0 style tests.
>>>>
>>>> The option of course would be to skip the register all together. Do we
>>>> have code which will have multiple vaddr's for the same TB where using
>>>> the TB data wouldn't be sufficient?
>>>
>>> Skipping the register altogether would basically make it invisible to
>>> plugins and therefore remove functionality. A plugin might want to get a
>>> list of all registers (which would not be complete anymore), or get the
>>> current PC value. If I didn't miss anything, the latter might not
>>> necessarily be possible anymore, as a callback (especially the simple
>>> callback type) doesn't have access to the current TB data and can't
>>> necessarily pass userdata to the callback, so it wouldn't be able to get
>>> the PC from there anymore.
>>>
>>>>>
>>>>>>           desc.feature =3D g_intern_string(grd->feature_name);
>>>>>>           g_array_append_val(find_data, desc);
>>>>>>       }
>>>>>
>>>>> Otherwise:
>>>>>
>>>>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> Seeing there are some questions around this, I have another one.
>>=20
>> Does it really matter if a user can read/write pc register?
>
> The idea of blocking writes to the PC via the register write API came up
> in https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg01671.html.
> As it stands, writes to the PC are silently swallowed, and preventing
> that could reduce confusion for plugin authors. It makes it clear why
> there would be a special API for setting the PC instead of using the
> generic register write API.

Agreed.

>
>> It seems to bring a lot of complexity to prevent this (especially
>> the string per arch approach, even though that's the best we can
>> do), and I'm not sure what's the actual benefit. If someone tries
>> something QEMU plugins don't support in general, they can always
>> send a bug report, or even a patch.
>> I'm not really sure to why someone would have a bad idea mixing register=
 writes and pc diversion. And if they do, it would not be surprising it bre=
aks things.
>
> Alternatively, I could add a remark to the documentation for the
> register write API that the PC can only be modified via the dedicated
> API and not change the implementation at all. But I think I'll have to
> defer that decision to you and Alex as the plugin subsystem
> maintainers.

We definitely want to make it clear to use the specific function. We
just need a solution for making sure they can always find out the
current pc when we have multiple virtual mappings to the same place.

>
>> So maybe we can just extend API with PC diversion, and not overthink too=
 much about potential consequences on registers.
>>=20
>> Regards,
>> Pierrick
>
> Best,
> Florian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

